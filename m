Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07AB7F3D32
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 06:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjKVFPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 00:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVFPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 00:15:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7862F100;
        Tue, 21 Nov 2023 21:15:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F3F6168F;
        Tue, 21 Nov 2023 21:16:13 -0800 (PST)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 086DE3F73F;
        Tue, 21 Nov 2023 21:15:21 -0800 (PST)
Message-ID: <b549c537-fda7-4ffc-b371-4b04a6480f6d@arm.com>
Date:   Wed, 22 Nov 2023 10:45:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V14 0/8] arm64/perf: Enable branch stack sampling
To:     James Clark <james.clark@arm.com>
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
 <af04e269-d43d-0dd6-5434-3cea9c74be01@arm.com>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <af04e269-d43d-0dd6-5434-3cea9c74be01@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 22:47, James Clark wrote:
> 
> 
> On 14/11/2023 05:13, Anshuman Khandual wrote:
>> This series enables perf branch stack sampling support on arm64 platform
>> via a new arch feature called Branch Record Buffer Extension (BRBE). All
>> the relevant register definitions could be accessed here.
>>
> [...]
>>
>> --------------------------- Virtualisation support ------------------------
>>
>> - Branch stack sampling is not currently supported inside the guest (TODO)
>>
>> 	- FEAT_BRBE advertised as absent via clearing ID_AA64DFR0_EL1.BRBE
>> 	- Future support in guest requires emulating FEAT_BRBE
> 
> If you never add support for the host looking into a guest, and you save

But that seems to be a valid use case though. Is there a particular concern
why such capability should or could not be added for BRBE ?

> and restore all the BRBINF[n] registers, I think you might be able to
> just let the guest do whatever it wants with BRBE and not trap and
> emulate it? Maybe there is some edge case why that wouldn't work, but
> it's worth thinking about.

Right, in case host tracing of the guest is not supported (although still
wondering why it should not be), saving and restoring complete BRBE state
i.e all system registers that can be accessed from guest, would let guest
do what ever it wants with BRBE without requiring the trap-emulate model.

> 
> For BRBE specifically I don't see much of a use case for hosts looking
> into a guest, at least not like with PMU counters.
But how is it any different from normal PMU counters ? Branch records do
provide statistical insights into hot sections in the guest.
