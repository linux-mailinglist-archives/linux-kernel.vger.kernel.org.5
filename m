Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C52D7CEE72
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 05:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjJSDg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 23:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSDgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 23:36:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B541109
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 20:36:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3D252F4;
        Wed, 18 Oct 2023 20:37:01 -0700 (PDT)
Received: from [10.163.36.185] (unknown [10.163.36.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B38CF3F64C;
        Wed, 18 Oct 2023 20:36:18 -0700 (PDT)
Message-ID: <d8db313d-1161-4a6e-9edc-7dc1e22d2018@arm.com>
Date:   Thu, 19 Oct 2023 09:06:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Independently update HDFGRTR_EL2 and HDFGWTR_EL2
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-kernel@vger.kernel.org
References: <20231018030007.1968317-1-anshuman.khandual@arm.com>
 <86r0lsm7cq.wl-maz@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <86r0lsm7cq.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/23 18:10, Marc Zyngier wrote:
> On Wed, 18 Oct 2023 04:00:07 +0100,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>> Currently PMSNEVFR_EL1 system register read, and write access EL2 traps are
>> disabled, via setting the same bit (i.e 62) in HDFGRTR_EL2, and HDFGWTR_EL2
>> respectively. Although very similar, bit fields are not exact same in these
>> two EL2 trap configure registers particularly when it comes to read-only or
>> write-only accesses such as ready-only 'HDFGRTR_EL2.nBRBIDR' which needs to
>> be set while enabling BRBE on NVHE platforms. Using the exact same bit mask
>> fields for both these trap register risk writing into their RESERVED areas,
>> which is undesirable.
> 
> Sorry, I don't understand at all what you are describing. You seem to
> imply that the read and write effects of the FGT doesn't apply the
> same way. But my reading of the ARM ARM is that  behave completely
> symmetrically.
> 
> Also, what is nBRBIDR doing here? It is still set to 0. What
> 'RESERVED' state are you talking about?

Let's observe the following example which includes the nBRBIDR problem,
mentioned earlier.

Read access trap configure

HDFGRTR_EL2[59]	   - nBRBIDR
HDFGRTR_EL2[58]	   - PMCEIDn_EL0

Write access trap configure

HDFGWTR_EL2[59:58] - RES0

Because BRBIDR_EL1 and PMCEID<N>_EL0 are read only registers they don't
have corresponding entries in HDFGWTR_EL2 for write trap configuration.

Using the exact same value contained in 'x0' both for HDFGRTR_EL2, and
HDFGWTR_EL2 will be problematic in case it contains bit fields that are
available only in one of the registers but not in the other.

If 'x0' contains nBRBIDR being set, it will be okay for HDFGRTR_EL2 but
might not be okay for HDFGWTR_EL2 where it will get into RESERVED areas.

> 
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Oliver Upton <oliver.upton@linux.dev>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on v6.6-rc6.
>>
>> I guess it should be okay to use 'x2' as it is in the clobbered register
>> list for init_el2_state() function. But please do let me know otherwise.
>>
>>  arch/arm64/include/asm/el2_setup.h | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
>> index 899b5c10f84c..c534afb1a30d 100644
>> --- a/arch/arm64/include/asm/el2_setup.h
>> +++ b/arch/arm64/include/asm/el2_setup.h
>> @@ -206,16 +206,19 @@
>>  	cbz	x1, .Lskip_fgt_\@
>>  
>>  	mov	x0, xzr
>> +	mov	x2, xzr
>>  	mrs	x1, id_aa64dfr0_el1
>>  	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
>>  	cmp	x1, #3
>>  	b.lt	.Lset_debug_fgt_\@
>> +
>>  	/* Disable PMSNEVFR_EL1 read and write traps */
>> -	orr	x0, x0, #(1 << 62)
>> +	orr	x0, x0, #HDFGRTR_EL2_nPMSNEVFR_EL1_MASK
>> +	orr	x2, x2, #HDFGWTR_EL2_nPMSNEVFR_EL1_MASK
>>  
>>  .Lset_debug_fgt_\@:
>>  	msr_s	SYS_HDFGRTR_EL2, x0
>> -	msr_s	SYS_HDFGWTR_EL2, x0
>> +	msr_s	SYS_HDFGWTR_EL2, x2
> 
> So what has changed here, aside from clobbering an extra register? The
> masks are the same, the initial values are the same... Is it in
> preparation for some other work?

Right, this is in preparation for the BRBE register and instructions trap
configuration. Planning to add the following change for BRBE enablement.

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index c534afb1a30d..128177465a9c 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -217,6 +217,32 @@
        orr     x2, x2, #HDFGWTR_EL2_nPMSNEVFR_EL1_MASK
 
 .Lset_debug_fgt_\@:
+#ifdef CONFIG_ARM64_BRBE
+       mrs     x1, id_aa64dfr0_el1
+       ubfx    x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
+       cbz     x1, .Lskip_brbe_reg_fgt_\@
+
+       /*
+        * Disable BRBINF_EL1, BRBINFINJ_EL1, BRBSRC_EL1, BRBSRCINJ_EL1,
+        * BRBTGT_EL1, BRBTGTINJ_EL1, and BRBTS_EL1 read traps.
+        */
+       orr     x0, x0, #HDFGRTR_EL2_nBRBDATA_MASK
+
+       /*
+        * Disable BRBINFINJ_EL1, BRBSRCINJ_EL1, BRBTGTINJ_EL1, and
+        * BRBTS_EL1 write traps.
+        */
+       orr     x2, x2, #HDFGWTR_EL2_nBRBDATA_MASK
+
+       /* Disable BRBCR_EL1, BRBFCR_EL1 read and write traps */
+       orr     x0, x0, #HDFGRTR_EL2_nBRBCTL_MASK
+       orr     x2, x2, #HDFGWTR_EL2_nBRBCTL_MASK
+
+       /* Disable BRBIDR_EL1 read traps */
+       orr     x0, x0, #HDFGRTR_EL2_nBRBIDR_MASK
+
+.Lskip_brbe_reg_fgt_\@:
+#endif
        msr_s   SYS_HDFGRTR_EL2, x0
        msr_s   SYS_HDFGWTR_EL2, x2
 
@@ -241,7 +267,22 @@
 .Lset_fgt_\@:
        msr_s   SYS_HFGRTR_EL2, x0
        msr_s   SYS_HFGWTR_EL2, x0
-       msr_s   SYS_HFGITR_EL2, xzr
+
+       mov     x0, xzr
+#ifdef CONFIG_ARM64_BRBE
+       mrs     x1, id_aa64dfr0_el1
+       ubfx    x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
+       cbz     x1, .Lskip_brbe_insn_fgt_\@
+
+       /* Disable trapping for BRBIALL instruction */
+       orr     x0, x0, #HFGITR_EL2_nBRBIALL_MASK
+
+       /* Disable trapping for BRBINJ instruction */
+       orr     x0, x0, #HFGITR_EL2_nBRBINJ_MASK
+
+.Lskip_brbe_insn_fgt_\@:
+#endif
+       msr_s   SYS_HFGITR_EL2, x0
 
        mrs     x1, id_aa64pfr0_el1             // AMU traps UNDEF without AMU
        ubfx    x1, x1, #ID_AA64PFR0_EL1_AMU_SHIFT, #4

After the above change, HDFGRTR_EL2_nBRBIDR_MASK only gets set
inside HFGRTR_EL2 but not inside HFGWTR_EL2.

> 
> /me puzzled.

I should have given more details in the commit message but hope
you have some context now, but please do let me know if there
is something still missing.
