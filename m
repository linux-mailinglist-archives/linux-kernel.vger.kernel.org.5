Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0CF7CA584
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjJPKfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPKfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:35:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A645383
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:35:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E0AC433C7;
        Mon, 16 Oct 2023 10:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697452509;
        bh=KR2AMN+HMC6H4qN9SDzN3tWCnpdF7dCi/m3CWhQ796w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PFXE+a7AiudwEChB0+tH7/rF0Ud41eL8+5KpFfYpMhjcqi0USueJXVRsmvW3U3orH
         2BU/Eyy9NmGKr7LEJ/iiTdD+2r0YeYvw2qvtL1ONPAAc5G3cskQm8FS4Rciqit3a4f
         shot/XyasEUt+UlV0Oedev6OgUXZjF+kDP5HfYnUBvBH+Vl+rQ89OFPQHKyk4iPSW7
         V7ZeCLdi8RBJ+X0F23E8XepWFMNBA79Ba6+XhJoDqlV7iLIbj4w/ntoc2qaM4nZTKM
         wgE9hABWG/ImYZ2yWWDLrW+LeRS5Hxv4KCuRHhoAKq+w6JcEJqxeZO/geqiMXc6gDY
         +WGHNNx//mpUQ==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qsKwE-004XvQ-H0;
        Mon, 16 Oct 2023 11:35:06 +0100
MIME-Version: 1.0
Date:   Mon, 16 Oct 2023 11:35:06 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Miguel Luis <miguel.luis@oracle.com>
Cc:     Eric Auger <eric.auger@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
Subject: Re: [PATCH v3 3/3] arm64/kvm: Fine grain _EL2 system registers list
 that affect nested virtualization
In-Reply-To: <15851D9D-5FF5-4900-B70F-0141B8392503@oracle.com>
References: <20231011180103.91774-1-miguel.luis@oracle.com>
 <20231011180103.91774-4-miguel.luis@oracle.com>
 <7df53e6b-9141-de85-b7a3-b9eb092ef7b4@redhat.com>
 <9D159B58-D336-4560-AF6A-294D910CF775@oracle.com>
 <72b67c49-423a-e88a-62c9-6b3cc9211f88@redhat.com>
 <15851D9D-5FF5-4900-B70F-0141B8392503@oracle.com>
User-Agent: Roundcube Webmail/1.4.14
Message-ID: <72e79b9ff7a451c583f0adb643befcda@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: miguel.luis@oracle.com, eric.auger@redhat.com, catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, jingzhangos@google.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-16 11:11, Miguel Luis wrote:
> Hi Eric,
> 
>> On 16 Oct 2023, at 09:54, Eric Auger <eric.auger@redhat.com> wrote:
>> 
>> Hi Miguel,
>> 
>> On 10/13/23 20:41, Miguel Luis wrote:
>>> Hi Eric,
>>> 
>>>> On 12 Oct 2023, at 15:22, Eric Auger <eric.auger@redhat.com> wrote:
>>>> 
>>>> Hi Miguel,
>>>> 
>>>> On 10/11/23 20:01, Miguel Luis wrote:
>>>>> Implement a fine grained approach in the _EL2 sysreg ranges.
>>>>> 
>>>>> Fixes: d0fc0a2519a6 ("KVM: arm64: nv: Add trap forwarding for 
>>>>> HCR_EL2")
>>>>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
>>>>> ---
>>>>> arch/arm64/kvm/emulate-nested.c | 88 
>>>>> ++++++++++++++++++++++++++++++---
>>>>> 1 file changed, 82 insertions(+), 6 deletions(-)
>>>>> 
>>>>> diff --git a/arch/arm64/kvm/emulate-nested.c 
>>>>> b/arch/arm64/kvm/emulate-nested.c
>>>>> index 9ced1bf0c2b7..3af49e130ee6 100644
>>>>> --- a/arch/arm64/kvm/emulate-nested.c
>>>>> +++ b/arch/arm64/kvm/emulate-nested.c
>>>>> @@ -648,15 +648,91 @@ static const struct encoding_to_trap_config 
>>>>> encoding_to_cgt[] __initconst = {
>>>>> SR_TRAP(SYS_APGAKEYLO_EL1, CGT_HCR_APK),
>>>>> SR_TRAP(SYS_APGAKEYHI_EL1, CGT_HCR_APK),
>>>>> /* All _EL2 registers */
>>>>> - SR_RANGE_TRAP(sys_reg(3, 4, 0, 0, 0),
>>>>> -       sys_reg(3, 4, 3, 15, 7), CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_VPIDR_EL2, CGT_HCR_NV),
>>>> I think you miss DBGVCR32_EL2
>>> That would be op0 == 10, which I indeed didn't considered given the 
>>> ranges
>>> previously defined. From its pseudocode I see it would make sense 
>>> only if EL1
>>> would support AArch32 but that seems not to be in the plans.
>>> 
>>>>> + SR_TRAP(SYS_VMPIDR_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_SCTLR_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_ACTLR_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_SCTLR2_EL2, CGT_HCR_NV),
>>>>> + SR_RANGE_TRAP(SYS_HCR_EL2,
>>>>> +       SYS_HCRX_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_SMPRIMAP_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_SMCR_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_SDER32_EL2, CGT_HCR_NV),
>>>>> + SR_RANGE_TRAP(SYS_TTBR0_EL2,
>>>>> +       SYS_TCR2_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_VTTBR_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_VTCR_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_VNCR_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_VSTTBR_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_VSTCR_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_DACR32_EL2, CGT_HCR_NV),
>>>>> + SR_RANGE_TRAP(SYS_HDFGRTR_EL2,
>>>>> +       SYS_HAFGRTR_EL2, CGT_HCR_NV),
>>>>> /* Skip the SP_EL1 encoding... */
>>>>> SR_TRAP(SYS_SPSR_EL2, CGT_HCR_NV),
>>>>> SR_TRAP(SYS_ELR_EL2, CGT_HCR_NV),
>>>>> - SR_RANGE_TRAP(sys_reg(3, 4, 4, 1, 1),
>>>>> -       sys_reg(3, 4, 10, 15, 7), CGT_HCR_NV),
>>>>> - SR_RANGE_TRAP(sys_reg(3, 4, 12, 0, 0),
>>>>> -       sys_reg(3, 4, 14, 15, 7), CGT_HCR_NV),
>>>>> + /* SPSR_irq, SPSR_abt, SPSR_und, SPSR_fiq */
>>>>> + SR_RANGE_TRAP(sys_reg(3, 4, 4, 3, 0),
>>>>> +       sys_reg(3, 4, 4, 3, 3), CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_IFSR32_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_AFSR0_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_AFSR1_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_ESR_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_VSESR_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_FPEXC32_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_TFSR_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_FAR_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_HPFAR_EL2, CGT_HCR_NV),
>>>> you miss BRBCR_EL2
>>> Yes, definitely. Same as above, didn't considered op0 == 10, (Table 
>>> D18-1).
>>> This one seems to me the only one missing too.
>> 
>> yep
> 
> Thanks for confirming it!
> 
>>> 
>>>>> + SR_TRAP(SYS_PMSCR_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_MAIR_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_AMAIR_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_MPAMHCR_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_MPAMVPMV_EL2, CGT_HCR_NV),
>>>>> + SR_TRAP(SYS_MPAM2_EL2, CGT_HCR_NV),
>>>>> + SR_RANGE_TRAP(SYS_MPAMVPM0_EL2,
>>>>> +       SYS_MPAMVPM7_EL2, CGT_HCR_NV),
>>>> About the MPAM where did you find the pseudo code?
>>> The pseucode isn't available on the document. I'm following the 
>>> statement when
>>> HCR_EL2.NV is 1, where:
>>> 
>>> "The System or Special-purpose registers for which accesses are 
>>> trapped and
>>> reported using EC syndrome value 0x18 are as follows:
>>> — Registers accessed using MRS or MSR with a name ending in _EL2, 
>>> except, [...]"
>> 
>> ok thank you for the clarification. With
>> 
>> BRBCR_EL2 handling, feel free to add my
>> 
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> 
> 
> Thank you Eric!
> 
>> (I guess you will handle
>> DBGVCR32_EL2 in a separate patch)
>> 
> 
> I think that Marc is addressing it here:
> https://lore.kernel.org/kvmarm/20231013223311.3950585-1-maz@kernel.org/
> but I can be wrong.
> 
> Marc, could you please confirm ?

Indeed, that's the fix. If you respin this series *now*, I can take
this patch and your series as a set of fixes for 6.6.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
