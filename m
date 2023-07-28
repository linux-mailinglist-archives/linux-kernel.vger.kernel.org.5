Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9E0766AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjG1Kom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjG1Kok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:44:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A9BA0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:44:38 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RC3dL6g78z67nbq;
        Fri, 28 Jul 2023 18:23:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 11:27:21 +0100
Date:   Fri, 28 Jul 2023 11:27:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64/fpsimd: Only provide the length to cpufeature for
 xCR registers
Message-ID: <20230728112720.00005ee6@Huawei.com>
In-Reply-To: <20230727-arm64-sme-fa64-hotplug-v1-1-34ae93afc05b@kernel.org>
References: <20230727-arm64-sme-fa64-hotplug-v1-1-34ae93afc05b@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 22:31:44 +0100
Mark Brown <broonie@kernel.org> wrote:

> For both SVE and SME we abuse the generic register field comparison
> support in the cpufeature code as part of our detection of unsupported
> variations in the vector lengths available to PEs, reporting the maximum
> vector lengths via ZCR_EL1.LEN and SMCR_EL1.LEN.  Since these are
> configuration registers rather than identification registers the
> assumptions the cpufeature code makes about how unknown bitfields behave
> are invalid, leading to warnings when SME features like FA64 are enabled
> and we hotplug a CPU:
> 
>   CPU features: SANITY CHECK: Unexpected variation in SYS_SMCR_EL1. Boot CPU: 0x0000000000000f, CPU3: 0x0000008000000f
>   CPU features: Unsupported CPU feature variation detected.
> 
> SVE has no controls other than the vector length so is not yet impacted
> but the same issue will apply there if any are defined.
> 
> Since the only field we are interested in having the cpufeature code
> handle is the length field and we use a custom read function to obtain
> the value we can avoid these warnings by filtering out all other bits
> when we return the register value.
> 
> Fixes: 2e0f2478ea37eb ("arm64/sve: Probe SVE capabilities and usable vector lengths")
> FixeS: b42990d3bf77cc ("arm64/sme: Identify supported SME vector lengths at boot")

Fixes

> Signed-off-by: Mark Brown <broonie@kernel.org>


> ---
>  arch/arm64/kernel/fpsimd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 89d54a5242d1..c7fdeebd050c 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1189,11 +1189,11 @@ u64 read_zcr_features(void)
>  	write_sysreg_s(ZCR_ELx_LEN_MASK, SYS_ZCR_EL1);
>  
>  	zcr = read_sysreg_s(SYS_ZCR_EL1);
> -	zcr &= ~(u64)ZCR_ELx_LEN_MASK; /* find sticky 1s outside LEN field */
> +	zcr &= ~(u64)ZCR_ELx_LEN_MASK;
>  	vq_max = sve_vq_from_vl(sve_get_vl());
>  	zcr |= vq_max - 1; /* set LEN field to maximum effective value */
>  
> -	return zcr;
> +	return SYS_FIELD_GET(ZCR_ELx, LEN, zcr);

Isn't that overly complex if we only end up with the length? (if I'm reading this right)
Perhaps it is more logical to build the register then pull the
field out of it, but it would be simpler as something like...

	return sve_vq_from_vl(sve_get_vl()) - 1;

>  }
>  
>  void __init sve_setup(void)
> @@ -1364,7 +1364,7 @@ u64 read_smcr_features(void)
>  	vq_max = sve_vq_from_vl(sme_get_vl());
>  	smcr |= vq_max - 1; /* set LEN field to maximum effective value */
>  
> -	return smcr;
> +	return SYS_FIELD_GET(SMCR_ELx, LEN, smcr);
>  }
>  
>  void __init sme_setup(void)
> 
> ---
> base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
> change-id: 20230727-arm64-sme-fa64-hotplug-1e6896746f97
> 
> Best regards,

