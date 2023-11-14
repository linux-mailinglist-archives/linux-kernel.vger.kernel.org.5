Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CEC7EAD7C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjKNJ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjKNJ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:58:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C6C0191;
        Tue, 14 Nov 2023 01:58:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9391DC15;
        Tue, 14 Nov 2023 01:59:17 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 420223F641;
        Tue, 14 Nov 2023 01:58:29 -0800 (PST)
Message-ID: <0020aa0d-e9a5-aef6-f33d-817da56411a3@arm.com>
Date:   Tue, 14 Nov 2023 09:58:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [V14 3/8] drivers: perf: arm_pmuv3: Enable branch stack sampling
 framework
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
References: <20231114051329.327572-1-anshuman.khandual@arm.com>
 <20231114051329.327572-4-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20231114051329.327572-4-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/11/2023 05:13, Anshuman Khandual wrote:
> Branch stack sampling support i.e capturing branch records during execution
> in core perf, rides along with normal HW events being scheduled on the PMU.
> This prepares ARMV8 PMU framework for branch stack support on relevant PMUs
> with required HW implementation.
> 

[...]

> - All armv8pmu_branch_xxxx() stub definitions have been moved inside
>   include/linux/perf/arm_pmuv3.h for easy access from both arm32 and
>   arm64 platforms
> 

This causes lots of W=1 build errors because the prototypes are in
arm_pmuv3.h, but arm_brbe.c doesn't include it.

It seems like the main reason you can't include arm_brbe.h in arm32 code
is because there are a load of inline functions and references to
registers in there. But these are only used in arm_brbe.c, so they don't
need to be in the header anyway.

If you removed the code from the header and moved it to the source file
you could move the brbe prototypes to the brbe header and it would be a
bit cleaner and more idiomatic.

