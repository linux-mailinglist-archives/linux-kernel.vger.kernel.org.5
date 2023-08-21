Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6C67825D8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjHUIx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjHUIx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:53:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2159ABB;
        Mon, 21 Aug 2023 01:53:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F0792F4;
        Mon, 21 Aug 2023 01:54:36 -0700 (PDT)
Received: from [10.162.42.6] (unknown [10.162.42.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8D093F762;
        Mon, 21 Aug 2023 01:53:50 -0700 (PDT)
Message-ID: <3cfaa5ae-924c-19ff-acb6-809e3f27c0fe@arm.com>
Date:   Mon, 21 Aug 2023 14:23:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V13 - RESEND 00/10] arm64/perf: Enable branch stack
 sampling
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
 <20230731130538.GA24881@willie-the-truck>
 <366bcaff-3c54-0c4d-633f-b6ef37c4e3f4@arm.com>
 <20230818175623.GA16509@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230818175623.GA16509@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Will,

Separated this part out just to understand it better.

On 8/18/23 23:26, Will Deacon wrote:
>> These stubs are necessary to protect PMU drivers built on arm32 which share
>> basic branch record processing abstraction at ARMV8 PMU level. It compiles
>> successfully both on arm32 and arm64 platforms with these changes. Subject
>> line for this patch clearly mentions that as well.

> But they shouldn't be needed. When CONFIG_ARM64_BRBE is not selected, no
> branch record processing functions should be needed, empty or otherwise.

But that is not how the code is organized currently. CONFIG_ARM64_BRBE enables
the driver to bring in BRBE HW specific branch stack callback implementation
details. But these callbacks are always present at ARMV8 PMU level even without
BRBE implementation as well. Hence these call sites are present, regardless of
CONFIG_ARM64_BRBE.

> The callers should not exist in the first place (i.e. the empty definitions

But how to achieve that ? Branch stack needs to be driven along side normal PMU
events, which in turn get driven from 'struct arm_pmu' callbacks. Hence branch
stack callbacks too needs to be at ARMV8 PMU level, and closely tied to normal
PMU event handling callbacks. Let's examine from where all these new callbacks
are called from.

* armv8pmu_disable_event()	---> armv8pmu_branch_disable()
* armv8pmu_handle_irq()		---> armv8pmu_branch_read()
* armv8pmu_sched_task()		---> armv8pmu_branch_save()
* armv8pmu_sched_task()		---> armv8pmu_branch_reset()
* armv8pmu_reset()		---> armv8pmu_branch_reset()
* __armv8_pmuv3_map_event()	---> armv8pmu_branch_attr_valid()
* __armv8pmu_probe_pmu()	---> armv8pmu_branch_probe()
* armv8pmu_probe_pmu()		---> armv8pmu_task_ctx_cache_alloc()
* armv8pmu_probe_pmu()		---> branch_records_alloc()

Please note that, branch_records_alloc() being deferred allocation is only one
that is platform agnostic.

I did not intend to make any of the BRBE details visible at ARMV8 PMU level i.e
right inside armv8pmu_XXXX() definitions, as ARMV8 PMU is shared between arm32
and arm64 platforms.

Hence these new branch stack callbacks are added along with required fallback
stubs for build protection, so that the HW implementations can be hidden inside
a new driver wrapped in CONFIG_ARM64_BRBE. Please note that these new branch
stack functions are not 'struct arm_pmu' callbacks but instead normal helpers.

> should live in the core driver code, not in the arch header, or the calling

Driver code is compiled with CONFIG_ARM64_BRBE, hence the real definitions are
there. Instead default stubs are required only when armv8pmu_branch_XXX() call
backs are not defined. But are you suggesting that these stubs be moved inside
drivers/perf/arm_pmuv3.c (where all call sites reside), so that there will be
just one stub copy both for arm32 and arm64 platforms removing their duplicate
definitions from arch headers i.e arch/arm64/include/asm/perf_event.h and
arch/arm/include/asm/arm_pmuv3.h ?

> code should not be compiled at all).

Branch stack sampling is always enabled from core perf perspective without any
config option to wrap around, hence calling code cannot be selectively enabled
or disabled.

- Anshuman
