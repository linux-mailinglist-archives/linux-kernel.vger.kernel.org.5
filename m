Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BFB7B3665
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjI2PJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjI2PJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01FC1A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696000131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hEGFAwORKfsvdgrCcVd+UUjZF6l0U2fhYj6xzLXT72Y=;
        b=fnHaVr4ZVRlpSGBlCw5GofRth91NtPlTZhNG8XJ+eK33Qqj6aeMscB9yo1vw8cVU8f093b
        FI3pl/y2aT15Ser2TmRrkQAPwB0ud6vh1QVo5JwihFIHcXfnsvADOGNPONl0LjZ7fJ0JEQ
        uaTo+512S3NeXrECLKaTDxdNwAtab/Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-BYtjnLMLOIOI1ui41DVZEA-1; Fri, 29 Sep 2023 11:08:49 -0400
X-MC-Unique: BYtjnLMLOIOI1ui41DVZEA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-65b23c40cefso109401076d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696000128; x=1696604928;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEGFAwORKfsvdgrCcVd+UUjZF6l0U2fhYj6xzLXT72Y=;
        b=LHOzAWUHHrJbNL1y3Cj+rbwjsuO4TrRqGBKQwhfTWuLTyuGcuz0eqyq4Tntr77GIba
         4A68zHMjIfkhSy8OIRPwZBh/ccnGbAiEVj6Y0ys66Q8SL0F1dMm/ulf82P9m8VjVS/IP
         6UYZzXx3tCkTQFoeHolXHVf7qbx4nf4UtNrmhdiucGs7iVgqug/+WWc0fQ2VYEeXsr/+
         Ea0xtX3NeKLMqERJKT9oe5zeOZid6pNVnoSiDi06NPLIi0wEMPsWxCil4FnZsmG5PfAr
         ql+8M1MH2YHDBgJMFjJQZK/btBL1M815ElKfrkaAG51EIw9M2SArEIDZMr3tcvKg67YS
         690Q==
X-Gm-Message-State: AOJu0Yyd5FFaGtEg+azPdZLOVv1SVYGkusTj8zSYjiGiFAwG9Ye5tUpU
        BJXoW6VCx0STVHIlZjBbsSKyhfgrPzY/zyJrBBEgsd5ehG5avn1unDOoC7bj7X5nPjp/8noIIsh
        iCXb2vt7yvWwQJkmLY4WXmudN
X-Received: by 2002:a05:6214:5195:b0:656:3895:fcf9 with SMTP id kl21-20020a056214519500b006563895fcf9mr5233552qvb.32.1696000128456;
        Fri, 29 Sep 2023 08:08:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpXBwGNEJJzKEDm/uR6gg/YZKn0fFNat4TrMwImkQUzzjWH19IG5NZ7qpVQxSogcBiIrZGdw==
X-Received: by 2002:a05:6214:5195:b0:656:3895:fcf9 with SMTP id kl21-20020a056214519500b006563895fcf9mr5233520qvb.32.1696000128081;
        Fri, 29 Sep 2023 08:08:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id a10-20020a0ce38a000000b0063f88855ef2sm3377788qvl.101.2023.09.29.08.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 08:08:47 -0700 (PDT)
Message-ID: <c01525e8-0906-6990-19b9-df374fdb087b@redhat.com>
Date:   Fri, 29 Sep 2023 17:08:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] arm64/kvm: Fine grain _EL2 system registers list
 that affect nested virtualization
Content-Language: en-US
To:     Miguel Luis <miguel.luis@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
References: <20230925162057.27548-1-miguel.luis@oracle.com>
 <20230925162057.27548-3-miguel.luis@oracle.com>
From:   Eric Auger <eauger@redhat.com>
In-Reply-To: <20230925162057.27548-3-miguel.luis@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,
On 9/25/23 18:20, Miguel Luis wrote:
> Some _EL1 registers got included in the _EL2 ranges, which are not
if they aren't too many, you may list them as it eases the review
> affected by NV. Remove them, fine grain the ranges to exclusively
> include the _EL2 ones and fold SPSR/ELR _EL2 registers into the
> existing range.
> 
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
Fixes: d0fc0a2519a6 (" KVM: arm64: nv: Add trap forwarding for HCR_EL2") ?
> ---
>  arch/arm64/kvm/emulate-nested.c | 44 ++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
> index 9ced1bf0c2b7..f6d0c87803f4 100644
> --- a/arch/arm64/kvm/emulate-nested.c
> +++ b/arch/arm64/kvm/emulate-nested.c
> @@ -649,14 +649,46 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
>  	SR_TRAP(SYS_APGAKEYHI_EL1,	CGT_HCR_APK),
>  	/* All _EL2 registers */
>  	SR_RANGE_TRAP(sys_reg(3, 4, 0, 0, 0),
> -		      sys_reg(3, 4, 3, 15, 7), CGT_HCR_NV),
> +		      sys_reg(3, 4, 4, 0, 1), CGT_HCR_NV),
>  	/* Skip the SP_EL1 encoding... */
> -	SR_TRAP(SYS_SPSR_EL2,		CGT_HCR_NV),
> -	SR_TRAP(SYS_ELR_EL2,		CGT_HCR_NV),
> -	SR_RANGE_TRAP(sys_reg(3, 4, 4, 1, 1),
> -		      sys_reg(3, 4, 10, 15, 7), CGT_HCR_NV),
I am not sure I fully understand the sysreg encoding but globally there
are not so many _EL2 regs trapped with .NV. And I can see holes within
somes ranges defined above (I searched all "if EL2Enabled() &&
HCR_EL2.NV == '1' then" in the ARM ARM). Maybe I don't know how to use
the ARM ARM doc but I feel  difficult to understand if the "holes"
within the encoding of some ranges are unused or are allocated to some
other sysregs, which wouldn't be trapped by /NV. I fear range encoding
may be quite risky.
> +	SR_RANGE_TRAP(sys_reg(3, 4, 4, 3, 0),
> +		      sys_reg(3, 4, 10, 6, 7), CGT_HCR_NV),
> +	/*
> +	 * Note that the spec. describes a group of MEC registers
> +	 * whose access should not trap, therefore skip the following:
> +	 * MECID_A0_EL2, MECID_A1_EL2, MECID_P0_EL2,
> +	 * MECID_P1_EL2, MECIDR_EL2, VMECID_A_EL2,
> +	 * VMECID_P_EL2.
> +	 */
>  	SR_RANGE_TRAP(sys_reg(3, 4, 12, 0, 0),
> -		      sys_reg(3, 4, 14, 15, 7), CGT_HCR_NV),
> +		      sys_reg(3, 4, 12, 1, 1), CGT_HCR_NV),
> +	/* ICH_AP0R<m>_EL2 */
> +	SR_RANGE_TRAP(SYS_ICH_AP0R0_EL2,
> +		      SYS_ICH_AP0R3_EL2, CGT_HCR_NV),
> +	/* ICH_AP1R<m>_EL2 */
> +	SR_RANGE_TRAP(SYS_ICH_AP1R0_EL2,
> +		      SYS_ICH_AP1R3_EL2, CGT_HCR_NV),
> +	SR_RANGE_TRAP(sys_reg(3, 4, 12, 9, 5),
> +		      sys_reg(3, 4, 12, 11, 7), CGT_HCR_NV),
> +	/* ICH_LR<m>_EL2 */
> +	SR_RANGE_TRAP(SYS_ICH_LR0_EL2,
> +		      SYS_ICH_LR7_EL2, CGT_HCR_NV),
> +	SR_RANGE_TRAP(SYS_ICH_LR8_EL2,
> +		      SYS_ICH_LR15_EL2, CGT_HCR_NV),
> +	SR_RANGE_TRAP(sys_reg(3, 4, 13, 0, 1),
> +		      sys_reg(3, 4, 13, 0, 7), CGT_HCR_NV),
> +	/* AMEVCNTVOFF0<n>_EL2 */
> +	SR_RANGE_TRAP(sys_reg(3, 4, 13, 8, 0),
> +		      sys_reg(3, 4, 13, 8, 7), CGT_HCR_NV),
> +	SR_RANGE_TRAP(sys_reg(3, 4, 13, 9, 0),
> +		      sys_reg(3, 4, 13, 9, 7), CGT_HCR_NV),
I think those 2 above ranges can be merged
> +	/* AMEVCNTVOFF1<n>_EL2 */
> +	SR_RANGE_TRAP(sys_reg(3, 4, 13, 10, 0),
> +		      sys_reg(3, 4, 13, 10, 7), CGT_HCR_NV),
> +	SR_RANGE_TRAP(sys_reg(3, 4, 13, 11, 0),
> +		      sys_reg(3, 4, 13, 11, 7), CGT_HCR_NV),
/* CNT*_EL2 */
> +	SR_RANGE_TRAP(sys_reg(3, 4, 14, 0, 3),
> +		      sys_reg(3, 4, 14, 5, 2), CGT_HCR_NV),
>  	/* All _EL02, _EL12 registers */
>  	SR_RANGE_TRAP(sys_reg(3, 5, 0, 0, 0),
>  		      sys_reg(3, 5, 10, 15, 7), CGT_HCR_NV),
not related to your patch but wrt the EL02 the only ones that I
idenftied beeing trapped by NV using above search are

CNTP_TVAL_EL02	3	5	14	2	0
CNTP_CTL_EL02	3	5	14	2	1
CNTP_CVAL_EL02	3	5	14	2	2
CNTV_TVAL_EL02	3	5	14	3	0
CNTV_CTL_EL02	3	5	14	3	1
CNTV_CVAL_EL02	3	5	14	3	2

Thanks

Eric

