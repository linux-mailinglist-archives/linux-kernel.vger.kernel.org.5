Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934BF7CA495
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjJPJzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjJPJzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9EE9C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697450091;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n0jE8MAcqywJFlB1trMu8LPmdKPf81U9Nw3AO9okGcQ=;
        b=XiFwCBCPb4PXO/L6IOx53orXzis3aHFQyGmiAKrQoJlgGsFsX9bdD+B6V4Pili4MAgZ6bN
        M561abiz0L139m1ZGn71QWyfIv2jID7DF4MQFviCBjf+oL/KWv7X2bJV93qPQdgPEy3l3J
        Aogb+uSKHXFZQSVxsmwvjSkPISXdPYY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-kptiEgWLMzeQqXfbemt6WA-1; Mon, 16 Oct 2023 05:54:49 -0400
X-MC-Unique: kptiEgWLMzeQqXfbemt6WA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7756d4d252cso542666185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697450089; x=1698054889;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0jE8MAcqywJFlB1trMu8LPmdKPf81U9Nw3AO9okGcQ=;
        b=Wf+2H6amaiyqxd2PvOotX6xWBaTINdgBjW6gm/R+mJ+PIoe3RPLh8VsPfH+kdTzpW3
         R3PQmjhSUVsavW9x2ugy30JyLgQU+2eheY8L7av+6F8C2J8+hFZrKZvC4zsJ155Ozlxg
         QZuCOgnrpfjiVhjOQpoeaOZSaml4PheMAuiMOUdO8k4olZqMuPLUs3rM62thruOvqk8+
         95d9DX8dx2DBofekvfFeoIKLUfNACcDWqHiQUQ/lrksTJERjSiSRfgOsb6+06uO5vLm8
         cSZimOSpXjdod9nRZBbGvhLuLCd2waeh1XIPNAi99kq/zDZHLhEx48awLSdtrYdbKHv5
         OfTg==
X-Gm-Message-State: AOJu0YzZ5Q66rCtLoDw/2qXZH1aQeV09FtWFGmPJCFcj1bRlESqjMk4f
        VG+tDdG0Il63fEYgO9FChXRVWihVX5OVjiwrwB0q55K1yV7h2IQhOomdUvvMeD2tWy+lxbvjRTc
        wcA4g/bzdx46tRWEM9tzr3QkE
X-Received: by 2002:a05:620a:2885:b0:76d:bc1b:c491 with SMTP id j5-20020a05620a288500b0076dbc1bc491mr36613436qkp.14.1697450089409;
        Mon, 16 Oct 2023 02:54:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHera92CisFmHnwAu7Oxn3Cd+9Ukc/Ecqin7fRG2h5uJVMp61qGtVvfoOcqM0b7EG/MpKN+3w==
X-Received: by 2002:a05:620a:2885:b0:76d:bc1b:c491 with SMTP id j5-20020a05620a288500b0076dbc1bc491mr36613424qkp.14.1697450089132;
        Mon, 16 Oct 2023 02:54:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id h4-20020a37de04000000b007659935ce64sm2845228qkj.71.2023.10.16.02.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 02:54:48 -0700 (PDT)
Message-ID: <72b67c49-423a-e88a-62c9-6b3cc9211f88@redhat.com>
Date:   Mon, 16 Oct 2023 11:54:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v3 3/3] arm64/kvm: Fine grain _EL2 system registers list
 that affect nested virtualization
Content-Language: en-US
To:     Miguel Luis <miguel.luis@oracle.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jing Zhang <jingzhangos@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>
References: <20231011180103.91774-1-miguel.luis@oracle.com>
 <20231011180103.91774-4-miguel.luis@oracle.com>
 <7df53e6b-9141-de85-b7a3-b9eb092ef7b4@redhat.com>
 <9D159B58-D336-4560-AF6A-294D910CF775@oracle.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <9D159B58-D336-4560-AF6A-294D910CF775@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On 10/13/23 20:41, Miguel Luis wrote:
> Hi Eric,
>
>> On 12 Oct 2023, at 15:22, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> Hi Miguel,
>>
>> On 10/11/23 20:01, Miguel Luis wrote:
>>> Implement a fine grained approach in the _EL2 sysreg ranges.
>>>
>>> Fixes: d0fc0a2519a6 ("KVM: arm64: nv: Add trap forwarding for HCR_EL2")
>>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
>>> ---
>>> arch/arm64/kvm/emulate-nested.c | 88 ++++++++++++++++++++++++++++++---
>>> 1 file changed, 82 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
>>> index 9ced1bf0c2b7..3af49e130ee6 100644
>>> --- a/arch/arm64/kvm/emulate-nested.c
>>> +++ b/arch/arm64/kvm/emulate-nested.c
>>> @@ -648,15 +648,91 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
>>> SR_TRAP(SYS_APGAKEYLO_EL1, CGT_HCR_APK),
>>> SR_TRAP(SYS_APGAKEYHI_EL1, CGT_HCR_APK),
>>> /* All _EL2 registers */
>>> - SR_RANGE_TRAP(sys_reg(3, 4, 0, 0, 0),
>>> -       sys_reg(3, 4, 3, 15, 7), CGT_HCR_NV),
>>> + SR_TRAP(SYS_VPIDR_EL2, CGT_HCR_NV),
>> I think you miss DBGVCR32_EL2
> That would be op0 == 10, which I indeed didn't considered given the ranges
> previously defined. From its pseudocode I see it would make sense only if EL1
> would support AArch32 but that seems not to be in the plans.
>
>>> + SR_TRAP(SYS_VMPIDR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_SCTLR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_ACTLR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_SCTLR2_EL2, CGT_HCR_NV),
>>> + SR_RANGE_TRAP(SYS_HCR_EL2,
>>> +       SYS_HCRX_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_SMPRIMAP_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_SMCR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_SDER32_EL2, CGT_HCR_NV),
>>> + SR_RANGE_TRAP(SYS_TTBR0_EL2,
>>> +       SYS_TCR2_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_VTTBR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_VTCR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_VNCR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_VSTTBR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_VSTCR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_DACR32_EL2, CGT_HCR_NV),
>>> + SR_RANGE_TRAP(SYS_HDFGRTR_EL2,
>>> +       SYS_HAFGRTR_EL2, CGT_HCR_NV),
>>> /* Skip the SP_EL1 encoding... */
>>> SR_TRAP(SYS_SPSR_EL2, CGT_HCR_NV),
>>> SR_TRAP(SYS_ELR_EL2, CGT_HCR_NV),
>>> - SR_RANGE_TRAP(sys_reg(3, 4, 4, 1, 1),
>>> -       sys_reg(3, 4, 10, 15, 7), CGT_HCR_NV),
>>> - SR_RANGE_TRAP(sys_reg(3, 4, 12, 0, 0),
>>> -       sys_reg(3, 4, 14, 15, 7), CGT_HCR_NV),
>>> + /* SPSR_irq, SPSR_abt, SPSR_und, SPSR_fiq */
>>> + SR_RANGE_TRAP(sys_reg(3, 4, 4, 3, 0),
>>> +       sys_reg(3, 4, 4, 3, 3), CGT_HCR_NV),
>>> + SR_TRAP(SYS_IFSR32_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_AFSR0_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_AFSR1_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_ESR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_VSESR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_FPEXC32_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_TFSR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_FAR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_HPFAR_EL2, CGT_HCR_NV),
>> you miss BRBCR_EL2
> Yes, definitely. Same as above, didn't considered op0 == 10, (Table D18-1).
> This one seems to me the only one missing too.

yep
>
>>> + SR_TRAP(SYS_PMSCR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_MAIR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_AMAIR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_MPAMHCR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_MPAMVPMV_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_MPAM2_EL2, CGT_HCR_NV),
>>> + SR_RANGE_TRAP(SYS_MPAMVPM0_EL2,
>>> +       SYS_MPAMVPM7_EL2, CGT_HCR_NV),
>> About the MPAM where did you find the pseudo code?
> The pseucode isn't available on the document. I'm following the statement when
> HCR_EL2.NV is 1, where:
>
> "The System or Special-purpose registers for which accesses are trapped and
> reported using EC syndrome value 0x18 are as follows:
> — Registers accessed using MRS or MSR with a name ending in _EL2, except, [...]"

ok thank you for the clarification. With

BRBCR_EL2 handling, feel free to add my

Reviewed-by: Eric Auger <eric.auger@redhat.com>

(I guess you will handle 
DBGVCR32_EL2 in a separate patch)

Eric

>
>>> + /*
>>> +  * Note that the spec. describes a group of MEC registers
>>> +  * whose access should not trap, therefore skip the following:
>>> +  * MECID_A0_EL2, MECID_A1_EL2, MECID_P0_EL2,
>>> +  * MECID_P1_EL2, MECIDR_EL2, VMECID_A_EL2,
>>> +  * VMECID_P_EL2.
>>> +  */
>>> + SR_RANGE_TRAP(SYS_VBAR_EL2,
>>> +       SYS_RMR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_VDISR_EL2, CGT_HCR_NV),
>>> + /* ICH_AP0R<m>_EL2 */
>>> + SR_RANGE_TRAP(SYS_ICH_AP0R0_EL2,
>>> +       SYS_ICH_AP0R3_EL2, CGT_HCR_NV),
>>> + /* ICH_AP1R<m>_EL2 */
>>> + SR_RANGE_TRAP(SYS_ICH_AP1R0_EL2,
>>> +       SYS_ICH_AP1R3_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_ICC_SRE_EL2, CGT_HCR_NV),
>>> + SR_RANGE_TRAP(SYS_ICH_HCR_EL2,
>>> +       SYS_ICH_EISR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_ICH_ELRSR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_ICH_VMCR_EL2, CGT_HCR_NV),
>>> + /* ICH_LR<m>_EL2 */
>>> + SR_RANGE_TRAP(SYS_ICH_LR0_EL2,
>>> +       SYS_ICH_LR15_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_CONTEXTIDR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_TPIDR_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_SCXTNUM_EL2, CGT_HCR_NV),
>>> + /* AMEVCNTVOFF0<n>_EL2, AMEVCNTVOFF1<n>_EL2  */
>>> + SR_RANGE_TRAP(SYS_AMEVCNTVOFF0n_EL2(0),
>>> +       SYS_AMEVCNTVOFF1n_EL2(15), CGT_HCR_NV),
>>> + /* CNT*_EL2 */
>>> + SR_TRAP(SYS_CNTVOFF_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_CNTPOFF_EL2, CGT_HCR_NV),
>>> + SR_TRAP(SYS_CNTHCTL_EL2, CGT_HCR_NV),
>>> + SR_RANGE_TRAP(SYS_CNTHP_TVAL_EL2,
>>> +       SYS_CNTHP_CVAL_EL2, CGT_HCR_NV),
>>> + SR_RANGE_TRAP(SYS_CNTHV_TVAL_EL2,
>>> +       SYS_CNTHV_CVAL_EL2, CGT_HCR_NV),
>>> + SR_RANGE_TRAP(SYS_CNTHVS_TVAL_EL2,
>>> +       SYS_CNTHVS_CVAL_EL2, CGT_HCR_NV),
>>> + SR_RANGE_TRAP(SYS_CNTHPS_TVAL_EL2,
>>> +       SYS_CNTHPS_CVAL_EL2, CGT_HCR_NV),
>>> /* All _EL02, _EL12 registers */
>>> SR_RANGE_TRAP(sys_reg(3, 5, 0, 0, 0),
>>>       sys_reg(3, 5, 10, 15, 7), CGT_HCR_NV),
>> Besides this looks good to me and to me this looks safer than the
>> previous large span approach but that's my taste ;-)
>>
> Your suggestions made total sense to me.
>
> Thanks!
> Miguel
>
>> Thanks
>>
>> Eric
>

