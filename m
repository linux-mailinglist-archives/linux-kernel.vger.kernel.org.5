Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FC97C7155
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379274AbjJLPYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379226AbjJLPYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:24:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6574BCA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697124192;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LPVVrFpPDVyx3xRaYdaYaCN0WQspDDkOcGN6DIUH97E=;
        b=QV/ztgujZWk/Sf7cjX17+aLtBAb1FI315i0B1e8tFpq5IFYN4wxRUGrvDJwVSaDa8LhZsF
        YQg+XyrLG1aLBlUddkQ9ZPnaAlyOSLGMux3r0X7PS+AwdgC166QwcSXUjhcX1p/kBeZw9o
        SPgNCpkIR/+79eWE2JU0/Clw0vXKZOk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-OqHDG5O3NOGuD9jbCZkTvw-1; Thu, 12 Oct 2023 11:23:01 -0400
X-MC-Unique: OqHDG5O3NOGuD9jbCZkTvw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66d08175882so10464336d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697124181; x=1697728981;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPVVrFpPDVyx3xRaYdaYaCN0WQspDDkOcGN6DIUH97E=;
        b=jHt2tpruDY3maGEgN+XZjMbxoSd0N9GoqtAXDju3turvxUOvY+mvSWHRdaL8BywcZR
         7tKznYSi8ic2H64SCrLIiTsdxMyuQ/0X0Z9U9AXbQUsfAXQLvQJ3c9o4nSJVKIh94cra
         LyIbNx5fIQv5gGvjZ5B4dNvxOzUSc+rlutjSnirAI/KC/Ud/XsJQrq9EsWJHShFDDQNz
         GLo0fg8qmxVF2my77rqJKJ1V2jfola+wR/ONbqq647HvLvl42zKxUBTWFrGOzTEkumFX
         slShKdW17YHMolcZv7uCXoM/EdTH3yflo7Jqg98usfWQpF+FzfBeDDKg00HOJX8xe+eT
         8OCA==
X-Gm-Message-State: AOJu0Yzv6miVpO2pxol/ToGmK8zLwGaCyISkYNK24Ap9lElRsvbEORCH
        qfUaFAXMfT9KjcyzxZa2ldtHaw7AHszpaepLBxFaZM+/xDRSh6RQyqznyxIgSwQ3QPfGaC6ygOC
        ZQEA+9IpgsU2WlykcPCnspapa
X-Received: by 2002:a0c:8e8c:0:b0:64f:8213:197d with SMTP id x12-20020a0c8e8c000000b0064f8213197dmr22337058qvb.33.1697124180401;
        Thu, 12 Oct 2023 08:23:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCeMZIB3m1qx2fbkdT4OPLLEqPsHeGO1L/iAH1/dZ2KldB+ZvbUW9y7GqXbzwRlkPP4euU0Q==
X-Received: by 2002:a0c:8e8c:0:b0:64f:8213:197d with SMTP id x12-20020a0c8e8c000000b0064f8213197dmr22337044qvb.33.1697124180079;
        Thu, 12 Oct 2023 08:23:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id dy18-20020ad44e92000000b0066d11c1f578sm883123qvb.97.2023.10.12.08.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 08:22:59 -0700 (PDT)
Message-ID: <7df53e6b-9141-de85-b7a3-b9eb092ef7b4@redhat.com>
Date:   Thu, 12 Oct 2023 17:22:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v3 3/3] arm64/kvm: Fine grain _EL2 system registers list
 that affect nested virtualization
Content-Language: en-US
To:     Miguel Luis <miguel.luis@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
References: <20231011180103.91774-1-miguel.luis@oracle.com>
 <20231011180103.91774-4-miguel.luis@oracle.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20231011180103.91774-4-miguel.luis@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On 10/11/23 20:01, Miguel Luis wrote:
> Implement a fine grained approach in the _EL2 sysreg ranges.
>
> Fixes: d0fc0a2519a6 ("KVM: arm64: nv: Add trap forwarding for HCR_EL2")
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> ---
>  arch/arm64/kvm/emulate-nested.c | 88 ++++++++++++++++++++++++++++++---
>  1 file changed, 82 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
> index 9ced1bf0c2b7..3af49e130ee6 100644
> --- a/arch/arm64/kvm/emulate-nested.c
> +++ b/arch/arm64/kvm/emulate-nested.c
> @@ -648,15 +648,91 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
>  	SR_TRAP(SYS_APGAKEYLO_EL1,	CGT_HCR_APK),
>  	SR_TRAP(SYS_APGAKEYHI_EL1,	CGT_HCR_APK),
>  	/* All _EL2 registers */
> -	SR_RANGE_TRAP(sys_reg(3, 4, 0, 0, 0),
> -		      sys_reg(3, 4, 3, 15, 7), CGT_HCR_NV),
> +	SR_TRAP(SYS_VPIDR_EL2,		CGT_HCR_NV),
I think you miss DBGVCR32_EL2
> +	SR_TRAP(SYS_VMPIDR_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_SCTLR_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_ACTLR_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_SCTLR2_EL2,		CGT_HCR_NV),
> +	SR_RANGE_TRAP(SYS_HCR_EL2,
> +		      SYS_HCRX_EL2,	CGT_HCR_NV),
> +	SR_TRAP(SYS_SMPRIMAP_EL2,	CGT_HCR_NV),
> +	SR_TRAP(SYS_SMCR_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_SDER32_EL2,		CGT_HCR_NV),
> +	SR_RANGE_TRAP(SYS_TTBR0_EL2,
> +		      SYS_TCR2_EL2,	CGT_HCR_NV),
> +	SR_TRAP(SYS_VTTBR_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_VTCR_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_VNCR_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_VSTTBR_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_VSTCR_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_DACR32_EL2,		CGT_HCR_NV),
> +	SR_RANGE_TRAP(SYS_HDFGRTR_EL2,
> +		      SYS_HAFGRTR_EL2,	CGT_HCR_NV),
>  	/* Skip the SP_EL1 encoding... */
>  	SR_TRAP(SYS_SPSR_EL2,		CGT_HCR_NV),
>  	SR_TRAP(SYS_ELR_EL2,		CGT_HCR_NV),
> -	SR_RANGE_TRAP(sys_reg(3, 4, 4, 1, 1),
> -		      sys_reg(3, 4, 10, 15, 7), CGT_HCR_NV),
> -	SR_RANGE_TRAP(sys_reg(3, 4, 12, 0, 0),
> -		      sys_reg(3, 4, 14, 15, 7), CGT_HCR_NV),
> +	/* SPSR_irq, SPSR_abt, SPSR_und, SPSR_fiq */
> +	SR_RANGE_TRAP(sys_reg(3, 4, 4, 3, 0),
> +		      sys_reg(3, 4, 4, 3, 3), CGT_HCR_NV),
> +	SR_TRAP(SYS_IFSR32_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_AFSR0_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_AFSR1_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_ESR_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_VSESR_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_FPEXC32_EL2,	CGT_HCR_NV),
> +	SR_TRAP(SYS_TFSR_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_FAR_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_HPFAR_EL2,		CGT_HCR_NV),
you miss BRBCR_EL2
> +	SR_TRAP(SYS_PMSCR_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_MAIR_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_AMAIR_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_MPAMHCR_EL2,	CGT_HCR_NV),
> +	SR_TRAP(SYS_MPAMVPMV_EL2,	CGT_HCR_NV),
> +	SR_TRAP(SYS_MPAM2_EL2,		CGT_HCR_NV),
> +	SR_RANGE_TRAP(SYS_MPAMVPM0_EL2,
> +		      SYS_MPAMVPM7_EL2,	CGT_HCR_NV),
About the MPAM where did you find the pseudo code?
> +	/*
> +	 * Note that the spec. describes a group of MEC registers
> +	 * whose access should not trap, therefore skip the following:
> +	 * MECID_A0_EL2, MECID_A1_EL2, MECID_P0_EL2,
> +	 * MECID_P1_EL2, MECIDR_EL2, VMECID_A_EL2,
> +	 * VMECID_P_EL2.
> +	 */
> +	SR_RANGE_TRAP(SYS_VBAR_EL2,
> +		      SYS_RMR_EL2,	CGT_HCR_NV),
> +	SR_TRAP(SYS_VDISR_EL2,		CGT_HCR_NV),
> +	/* ICH_AP0R<m>_EL2 */
> +	SR_RANGE_TRAP(SYS_ICH_AP0R0_EL2,
> +		      SYS_ICH_AP0R3_EL2, CGT_HCR_NV),
> +	/* ICH_AP1R<m>_EL2 */
> +	SR_RANGE_TRAP(SYS_ICH_AP1R0_EL2,
> +		      SYS_ICH_AP1R3_EL2, CGT_HCR_NV),
> +	SR_TRAP(SYS_ICC_SRE_EL2,	CGT_HCR_NV),
> +	SR_RANGE_TRAP(SYS_ICH_HCR_EL2,
> +		      SYS_ICH_EISR_EL2,	CGT_HCR_NV),
> +	SR_TRAP(SYS_ICH_ELRSR_EL2,	CGT_HCR_NV),
> +	SR_TRAP(SYS_ICH_VMCR_EL2,	CGT_HCR_NV),
> +	/* ICH_LR<m>_EL2 */
> +	SR_RANGE_TRAP(SYS_ICH_LR0_EL2,
> +		      SYS_ICH_LR15_EL2, CGT_HCR_NV),
> +	SR_TRAP(SYS_CONTEXTIDR_EL2,	CGT_HCR_NV),
> +	SR_TRAP(SYS_TPIDR_EL2,		CGT_HCR_NV),
> +	SR_TRAP(SYS_SCXTNUM_EL2,	CGT_HCR_NV),
> +	/* AMEVCNTVOFF0<n>_EL2, AMEVCNTVOFF1<n>_EL2  */
> +	SR_RANGE_TRAP(SYS_AMEVCNTVOFF0n_EL2(0),
> +		      SYS_AMEVCNTVOFF1n_EL2(15), CGT_HCR_NV),
> +	/* CNT*_EL2 */
> +	SR_TRAP(SYS_CNTVOFF_EL2,	CGT_HCR_NV),
> +	SR_TRAP(SYS_CNTPOFF_EL2,	CGT_HCR_NV),
> +	SR_TRAP(SYS_CNTHCTL_EL2,	CGT_HCR_NV),
> +	SR_RANGE_TRAP(SYS_CNTHP_TVAL_EL2,
> +		      SYS_CNTHP_CVAL_EL2, CGT_HCR_NV),
> +	SR_RANGE_TRAP(SYS_CNTHV_TVAL_EL2,
> +		      SYS_CNTHV_CVAL_EL2, CGT_HCR_NV),
> +	SR_RANGE_TRAP(SYS_CNTHVS_TVAL_EL2,
> +		      SYS_CNTHVS_CVAL_EL2, CGT_HCR_NV),
> +	SR_RANGE_TRAP(SYS_CNTHPS_TVAL_EL2,
> +		      SYS_CNTHPS_CVAL_EL2, CGT_HCR_NV),
>  	/* All _EL02, _EL12 registers */
>  	SR_RANGE_TRAP(sys_reg(3, 5, 0, 0, 0),
>  		      sys_reg(3, 5, 10, 15, 7), CGT_HCR_NV),
Besides this looks good to me and to me this looks safer than the
previous large span approach but that's my taste ;-)

Thanks

Eric

 

