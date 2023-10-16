Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00417CA6C6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjJPLcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjJPLch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51710EA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697455910;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BhW7/+Hnd+nw6HsskQCdbMFMqpQicyDAa/U17Zs0gQY=;
        b=dfBMwKIlB1yJVFdjaJwxtPrrqKwutrA/bk2BBFTj5lAvnEPm+UmUymMw5Z1oZ1UvG9PwLX
        rbxOk6jd0oeV7aeJgm+6E9kgZ5u1hKbuOtnLL+/uGwXxj1xhZQH/1OJwj56zcuL9ajzf5A
        nM1ripNm1c3IPCw0HXNYNFGs/rbDBkE=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-_dy6kXzyP6y2Ih1u_Zj7Pw-1; Mon, 16 Oct 2023 07:31:48 -0400
X-MC-Unique: _dy6kXzyP6y2Ih1u_Zj7Pw-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3ae5ac8de14so6708470b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697455908; x=1698060708;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhW7/+Hnd+nw6HsskQCdbMFMqpQicyDAa/U17Zs0gQY=;
        b=gBv7wIzfnEaI3jD3Y5yidS45pMNSp6vr7DZDa4qyQJvei42qKWLRnu1L16aehHFy8R
         NOqt1isSuc5AOjicSOZpSi8AiW/4ahL16k6EAYk+f7nOTVkep9acX0dpvJ2lANhSH2kl
         0YK2pcKyyND023AjEApgBQCqfSpp6Uj9hjheLYFxR26X9QPFXHyMMLU617qTP3RFLZVk
         hDgvdu2UqEu26BBq1Autes+cvI8zevanzmXhYYD8vgzi0evXrYdCzJDT77jOC1FBjHAe
         TlYe6x/vpHz4iJKfRFJPZGfB428BW+ylpFGwZEDZZI9h3kvtDoB7uee2VhLRCA5ZAO96
         X5bw==
X-Gm-Message-State: AOJu0Yxjc8O8VsM0Ai6f1lr0Yd9Wi0hr1397r+Xu/LpsmdbaeinSANSp
        yMrZ+AFQwS33qaY4t1uqYWdPwtZiQOw5RrrbiMhsFWK4b6MF55BlCK2jagqYwV4XGbMS6QoxePa
        QCsX0mV740SZO9wsyDmmS7+z8
X-Received: by 2002:aca:1215:0:b0:3ae:5397:eaa0 with SMTP id 21-20020aca1215000000b003ae5397eaa0mr36300989ois.41.1697455908292;
        Mon, 16 Oct 2023 04:31:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3vWVTwyNYs+Dn822wU8lNEybdv4HMBGqwcen2RpAqoD4ZtozluGp1pL+ZF/Vgk72EDaSNCw==
X-Received: by 2002:aca:1215:0:b0:3ae:5397:eaa0 with SMTP id 21-20020aca1215000000b003ae5397eaa0mr36300977ois.41.1697455908013;
        Mon, 16 Oct 2023 04:31:48 -0700 (PDT)
Received: from [192.168.43.95] ([37.170.191.221])
        by smtp.gmail.com with ESMTPSA id t27-20020a05620a035b00b0076ef3e6e6a4sm2920531qkm.42.2023.10.16.04.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 04:31:47 -0700 (PDT)
Message-ID: <a067660b-7ba1-9a23-0b56-9fa4ada5db0d@redhat.com>
Date:   Mon, 16 Oct 2023 13:31:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v4 2/3] arm64: Add missing _EL2 encodings
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
References: <20231016111743.30331-1-miguel.luis@oracle.com>
 <20231016111743.30331-3-miguel.luis@oracle.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20231016111743.30331-3-miguel.luis@oracle.com>
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



On 10/16/23 13:17, Miguel Luis wrote:
> Some _EL2 encodings are missing. Add them.
>
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  arch/arm64/include/asm/sysreg.h | 39 +++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index ba5db50effec..8653fb67a339 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -270,6 +270,8 @@
>  /* ETM */
>  #define SYS_TRCOSLAR			sys_reg(2, 1, 1, 0, 4)
>  
> +#define SYS_BRBCR_EL2			sys_reg(2, 4, 9, 0, 0)
> +
>  #define SYS_MIDR_EL1			sys_reg(3, 0, 0, 0, 0)
>  #define SYS_MPIDR_EL1			sys_reg(3, 0, 0, 0, 5)
>  #define SYS_REVIDR_EL1			sys_reg(3, 0, 0, 0, 6)
> @@ -484,6 +486,7 @@
>  
>  #define SYS_SCTLR_EL2			sys_reg(3, 4, 1, 0, 0)
>  #define SYS_ACTLR_EL2			sys_reg(3, 4, 1, 0, 1)
> +#define SYS_SCTLR2_EL2			sys_reg(3, 4, 1, 0, 3)
>  #define SYS_HCR_EL2			sys_reg(3, 4, 1, 1, 0)
>  #define SYS_MDCR_EL2			sys_reg(3, 4, 1, 1, 1)
>  #define SYS_CPTR_EL2			sys_reg(3, 4, 1, 1, 2)
> @@ -497,6 +500,10 @@
>  #define SYS_VTCR_EL2			sys_reg(3, 4, 2, 1, 2)
>  
>  #define SYS_TRFCR_EL2			sys_reg(3, 4, 1, 2, 1)
> +#define SYS_SDER32_EL2			sys_reg(3, 4, 1, 3, 1)
> +#define SYS_VNCR_EL2			sys_reg(3, 4, 2, 2, 0)
> +#define SYS_VSTTBR_EL2			sys_reg(3, 4, 2, 6, 0)
> +#define SYS_VSTCR_EL2			sys_reg(3, 4, 2, 6, 2)
>  #define SYS_HAFGRTR_EL2			sys_reg(3, 4, 3, 1, 6)
>  #define SYS_SPSR_EL2			sys_reg(3, 4, 4, 0, 0)
>  #define SYS_ELR_EL2			sys_reg(3, 4, 4, 0, 1)
> @@ -514,6 +521,18 @@
>  
>  #define SYS_MAIR_EL2			sys_reg(3, 4, 10, 2, 0)
>  #define SYS_AMAIR_EL2			sys_reg(3, 4, 10, 3, 0)
> +#define SYS_MPAMHCR_EL2			sys_reg(3, 4, 10, 4, 0)
> +#define SYS_MPAMVPMV_EL2		sys_reg(3, 4, 10, 4, 1)
> +#define SYS_MPAM2_EL2			sys_reg(3, 4, 10, 5, 0)
> +#define __SYS__MPAMVPMx_EL2(x)		sys_reg(3, 4, 10, 6, x)
> +#define SYS_MPAMVPM0_EL2		__SYS__MPAMVPMx_EL2(0)
> +#define SYS_MPAMVPM1_EL2		__SYS__MPAMVPMx_EL2(1)
> +#define SYS_MPAMVPM2_EL2		__SYS__MPAMVPMx_EL2(2)
> +#define SYS_MPAMVPM3_EL2		__SYS__MPAMVPMx_EL2(3)
> +#define SYS_MPAMVPM4_EL2		__SYS__MPAMVPMx_EL2(4)
> +#define SYS_MPAMVPM5_EL2		__SYS__MPAMVPMx_EL2(5)
> +#define SYS_MPAMVPM6_EL2		__SYS__MPAMVPMx_EL2(6)
> +#define SYS_MPAMVPM7_EL2		__SYS__MPAMVPMx_EL2(7)
>  
>  #define SYS_VBAR_EL2			sys_reg(3, 4, 12, 0, 0)
>  #define SYS_RVBAR_EL2			sys_reg(3, 4, 12, 0, 1)
> @@ -562,9 +581,29 @@
>  
>  #define SYS_CONTEXTIDR_EL2		sys_reg(3, 4, 13, 0, 1)
>  #define SYS_TPIDR_EL2			sys_reg(3, 4, 13, 0, 2)
> +#define SYS_SCXTNUM_EL2			sys_reg(3, 4, 13, 0, 7)
> +
> +#define __AMEV_op2(m)			(m & 0x7)
> +#define __AMEV_CRm(n, m)		(n | ((m & 0x8) >> 3))
> +#define __SYS__AMEVCNTVOFF0n_EL2(m)	sys_reg(3, 4, 13, __AMEV_CRm(0x8, m), __AMEV_op2(m))
> +#define SYS_AMEVCNTVOFF0n_EL2(m)	__SYS__AMEVCNTVOFF0n_EL2(m)
> +#define __SYS__AMEVCNTVOFF1n_EL2(m)	sys_reg(3, 4, 13, __AMEV_CRm(0xA, m), __AMEV_op2(m))
> +#define SYS_AMEVCNTVOFF1n_EL2(m)	__SYS__AMEVCNTVOFF1n_EL2(m)
>  
>  #define SYS_CNTVOFF_EL2			sys_reg(3, 4, 14, 0, 3)
>  #define SYS_CNTHCTL_EL2			sys_reg(3, 4, 14, 1, 0)
> +#define SYS_CNTHP_TVAL_EL2		sys_reg(3, 4, 14, 2, 0)
> +#define SYS_CNTHP_CTL_EL2		sys_reg(3, 4, 14, 2, 1)
> +#define SYS_CNTHP_CVAL_EL2		sys_reg(3, 4, 14, 2, 2)
> +#define SYS_CNTHV_TVAL_EL2		sys_reg(3, 4, 14, 3, 0)
> +#define SYS_CNTHV_CTL_EL2		sys_reg(3, 4, 14, 3, 1)
> +#define SYS_CNTHV_CVAL_EL2		sys_reg(3, 4, 14, 3, 2)
> +#define SYS_CNTHVS_TVAL_EL2		sys_reg(3, 4, 14, 4, 0)
> +#define SYS_CNTHVS_CTL_EL2		sys_reg(3, 4, 14, 4, 1)
> +#define SYS_CNTHVS_CVAL_EL2		sys_reg(3, 4, 14, 4, 2)
> +#define SYS_CNTHPS_TVAL_EL2		sys_reg(3, 4, 14, 5, 0)
> +#define SYS_CNTHPS_CTL_EL2		sys_reg(3, 4, 14, 5, 1)
> +#define SYS_CNTHPS_CVAL_EL2		sys_reg(3, 4, 14, 5, 2)
>  
>  /* VHE encodings for architectural EL0/1 system registers */
>  #define SYS_BRBCR_EL12			sys_reg(2, 5, 9, 0, 0)

