Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5EB7C6F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378990AbjJLNrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343854AbjJLNrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E1BBE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697118393;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7lA6iK0/UHM5oGG1Zev7Ey/lrzl0SVmWqGH8Yx0ceXg=;
        b=amNRSPXG/RorFx5hH1sX3abmyQTts3+MvYUPEskiD7W6eGvzw7plaXzQuyQVCdlb9f+M6h
        5FQWC/IGyIkvrbigMKwL4/BZwtwRV9W7/2PcMW1GEjkm54pg3M0OzeuWkI+GXfBPd+4SXN
        v4rYxEcBRDs6f7ExGpJpA5Z+2TV7oYc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-uQD1m9xIP0uReLRq5Mrf8w-1; Thu, 12 Oct 2023 09:46:30 -0400
X-MC-Unique: uQD1m9xIP0uReLRq5Mrf8w-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41975c9e66fso14473801cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697118390; x=1697723190;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lA6iK0/UHM5oGG1Zev7Ey/lrzl0SVmWqGH8Yx0ceXg=;
        b=UIS/0VTQ2fu332WsXN5/hZRnZomEgtB/3RKhFAewUUrQjLv3ZTvwnX9gJL0uC7cNVs
         pOH+ceA2e2q4Qa3l5HsPXOQeMReEVe7SetFKASzl0/iSCFKDF7oJxtjxlBikt6j/CJ3Z
         QDcTaf3TZkSxQATjS49jBHs6wU+eF7/InD9aQGQvv/nFYlnrvw65zke/QR3n4sqKLcUX
         IcxojH93ZhklkDgU/xoP4narI4t3DucGz2qM5/3nE8FmvvVhDsYXbvgZXYfStSoxBEAw
         +tNGHEJbeHbb0+/DfkvXgPKBQBn92WlnJ/uqIVDsE5nK0JCTFvt6BWY7kL9gV6itc01a
         WzMQ==
X-Gm-Message-State: AOJu0YwXes9e8afyC2aicwi6hOo4v/wtLpqpXlP3wc+/Sa0vtCLSgNsq
        V3HAkULpe7Z70l9lHvGsQQUL+gqFsTFB5pIcvfm0A79PLWOKLRc5ohy+/HaEVQrrTIRgkTuu/cn
        prVTVavquo6dd2K9a+TGw4JMY
X-Received: by 2002:ac8:5895:0:b0:41a:b68:54d5 with SMTP id t21-20020ac85895000000b0041a0b6854d5mr28247533qta.0.1697118390107;
        Thu, 12 Oct 2023 06:46:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTGGdn/As7/O2x0iD1ySAEs+y/AqV8+MgJHJ0fH9dqt0fS7ZE6V6m6uVefR3MExhkSJpYHNw==
X-Received: by 2002:ac8:5895:0:b0:41a:b68:54d5 with SMTP id t21-20020ac85895000000b0041a0b6854d5mr28247519qta.0.1697118389850;
        Thu, 12 Oct 2023 06:46:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id bb36-20020a05622a1b2400b00403ad6ec2e8sm6182191qtb.26.2023.10.12.06.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 06:46:29 -0700 (PDT)
Message-ID: <4c73e58f-13d3-7cb9-a706-b20ab7d2df18@redhat.com>
Date:   Thu, 12 Oct 2023 15:46:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v3 2/3] arm64: Add missing _EL2 encodings
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
 <20231011180103.91774-3-miguel.luis@oracle.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20231011180103.91774-3-miguel.luis@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On 10/11/23 20:01, Miguel Luis wrote:
> Some _EL2 encodings are missing. Add them.
>
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  arch/arm64/include/asm/sysreg.h | 37 +++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index ba5db50effec..d8e8607c9de8 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -484,6 +484,7 @@
>  
>  #define SYS_SCTLR_EL2			sys_reg(3, 4, 1, 0, 0)
>  #define SYS_ACTLR_EL2			sys_reg(3, 4, 1, 0, 1)
> +#define SYS_SCTLR2_EL2			sys_reg(3, 4, 1, 0, 3)
>  #define SYS_HCR_EL2			sys_reg(3, 4, 1, 1, 0)
>  #define SYS_MDCR_EL2			sys_reg(3, 4, 1, 1, 1)
>  #define SYS_CPTR_EL2			sys_reg(3, 4, 1, 1, 2)
> @@ -497,6 +498,10 @@
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
> @@ -514,6 +519,18 @@
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
> @@ -562,9 +579,29 @@
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

