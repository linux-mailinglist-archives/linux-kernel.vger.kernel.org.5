Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B6B7A2228
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbjIOPSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbjIOPRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:17:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE77E6A;
        Fri, 15 Sep 2023 08:17:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D5BC433C7;
        Fri, 15 Sep 2023 15:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694791049;
        bh=TPHKnv6db0a6xw1+xArvSG1rxIzxtQZwKrUHA2vOqak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VS53YwKyC45jVv8cxTqITtzN4aMPex3Kowb0nPZL/iwXu56eSPi1Qzy7l7DDrzSFV
         PU2eInHPR2bn/M4W/7BitgLePLEt/5CvQEphwFBBuk4eQV4ndh1PjCxPIz159DIM0h
         Y5K1/SPWImejGYZIPV7fFgr+Qf1pxHHlcGKsw8idOvWKR+Ecr70s+QcCLnF4MJ44Te
         XaXh4dQ7y/Ln2W7q+YKKVjogAEq551SfM9l87fPZVBfzEgmho8hbEN2FDAl+m/c1rL
         KN+tMXo0YPNFhe4XtDi9iasDqiWWI4E1bKTnUphiqtayzsmEHuJBw85iP24yoOWyFB
         YSSK6n1SAOlHg==
Date:   Fri, 15 Sep 2023 08:21:43 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_eberman@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH V2] firmware: qcom_scm: use the SCM_CONVENTION based on
 ARM / ARM64
Message-ID: <rzxxoofebcyuoktsl72diwv575md62bxqse4uizfns247gyklp@tdoixme3qrjq>
References: <20230607045345.25049-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607045345.25049-1-quic_kathirav@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:23:45AM +0530, Kathiravan T wrote:
> During SCM probe, to identify the SCM convention, scm call is made with
> SMC_CONVENTION_ARM_64 followed by SMC_CONVENTION_ARM_32. Based on the
> result what convention to be used is decided.
> 
> IPQ chipsets starting from IPQ807x, supports both 32bit and 64bit kernel
> variants, however TZ firmware runs in 64bit mode. When running on 32bit
> kernel, scm call is made with SMC_CONVENTION_ARM_64 is causing the
> system crash, due to the difference in the register sets between ARM and
> AARCH64, which is accessed by the TZ.
> 
> To avoid this, use SMC_CONVENTION_ARM_64 only on ARM64 builds.
> 

My memory of this is cloudy, but I feel the logic is complicated because
early 64-bit boards all used 32-bit TZ. So, I really would like Elliot's
input before picking this change.

Regards,
Bjorn

> Cc: stable@vger.kernel.org
> Fixes: 9a434cee773a ("firmware: qcom_scm: Dynamically support SMCCC and legacy conventions")
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
> Changes in V2:
> 	- Added the Fixes tag and cc'd stable mailing list
> 
>  drivers/firmware/qcom_scm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index fde33acd46b7..db6754db48a0 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -171,6 +171,7 @@ static enum qcom_scm_convention __get_convention(void)
>  	if (likely(qcom_scm_convention != SMC_CONVENTION_UNKNOWN))
>  		return qcom_scm_convention;
>  
> +#if IS_ENABLED(CONFIG_ARM64)
>  	/*
>  	 * Device isn't required as there is only one argument - no device
>  	 * needed to dma_map_single to secure world
> @@ -191,6 +192,7 @@ static enum qcom_scm_convention __get_convention(void)
>  		forced = true;
>  		goto found;
>  	}
> +#endif
>  
>  	probed_convention = SMC_CONVENTION_ARM_32;
>  	ret = __scm_smc_call(NULL, &desc, probed_convention, &res, true);
> -- 
> 2.17.1
> 
