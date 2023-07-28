Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3584F76727A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjG1QzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbjG1Qyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:54:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67A4E448D;
        Fri, 28 Jul 2023 09:53:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E38A71570;
        Fri, 28 Jul 2023 09:53:59 -0700 (PDT)
Received: from [10.57.0.147] (unknown [10.57.0.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4F0A3F67D;
        Fri, 28 Jul 2023 09:53:14 -0700 (PDT)
Message-ID: <89ce4bc4-00c5-a763-3179-e1d3e9f198b7@arm.com>
Date:   Fri, 28 Jul 2023 17:52:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V13 - RESEND 02/10] arm64/perf: Add BRBE registers and
 fields
Content-Language: en-US
To:     Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
 <20230711082455.215983-3-anshuman.khandual@arm.com>
 <20230728162011.GA22050@willie-the-truck>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230728162011.GA22050@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/07/2023 17:20, Will Deacon wrote:
> On Tue, Jul 11, 2023 at 01:54:47PM +0530, Anshuman Khandual wrote:
>> This adds BRBE related register definitions and various other related field
>> macros there in. These will be used subsequently in a BRBE driver which is
>> being added later on.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Tested-by: James Clark <james.clark@arm.com>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/sysreg.h | 103 +++++++++++++++++++++
>>  arch/arm64/tools/sysreg         | 158 ++++++++++++++++++++++++++++++++
>>  2 files changed, 261 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index b481935e9314..f95e30c13c8b 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -163,6 +163,109 @@
>>  #define SYS_DBGDTRTX_EL0		sys_reg(2, 3, 0, 5, 0)
>>  #define SYS_DBGVCR32_EL2		sys_reg(2, 4, 0, 7, 0)
>>  
>> +#define __SYS_BRBINFO(n)		sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 0))
>> +#define __SYS_BRBSRC(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 1))
>> +#define __SYS_BRBTGT(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 2))
> 
> It's that time on a Friday but... aren't these macros busted? I think you
> need brackets before adding the offset, otherwise wouldn't, for example,
> target registers 0-15 all access info register 0 and __SYS_BRBTGT(16) would
> then start accessing source register 0?
> 
> I'm surprised that the compiler doesn't warn about this, but even more
> surprised that you managed to test this.
> 
> Please tell me I'm wrong!
> 
> Will

No I think you are right, it is wrong. Luckily there is already an
extraneous bracket so you you can fix it by moving one a place down:

  sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10) >> 2) + 2))

It's interesting because the test [1] is doing quite a bit and looking
at the branch info, and that src and targets match up to function names.
I also manually looked at the branch buffers and didn't see anything
obviously wrong like things that looked like branch infos in the source
or target fields. Will have to take another look to see if it would be
possible for the test to catch this.

James

[1]:
https://gitlab.arm.com/linux-arm/linux-jc/-/commit/3a7ddce70c2daadb63fcc511de0a89055ca48b32
