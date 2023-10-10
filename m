Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972C27C4406
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343743AbjJJW2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbjJJW1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E6AC4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696976809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tdmK2PJpm7tFVM+sD/0UEMZcITp4E1l/E4NAmoPnMSg=;
        b=haNpw279RRLuu4dASACeEYg8/ZPrHUYNVGopx1EOeCVnzUHZ70aWhIcCp/tcCyhpEVK5kC
        0nsrcLgsAjv2glcu17G4VVJf6aqxVsaT+aSaiOhTaGa322xKSOpymRdMCHboIcvN3OSApK
        6a0tbB9CHWeAuzcyRwTJQS+9DiqTFB4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-sywiTnumO2u6Fixpokl6HQ-1; Tue, 10 Oct 2023 18:26:48 -0400
X-MC-Unique: sywiTnumO2u6Fixpokl6HQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66d03dcdc6bso2637296d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696976808; x=1697581608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdmK2PJpm7tFVM+sD/0UEMZcITp4E1l/E4NAmoPnMSg=;
        b=hOjHkyS9vD9VVGvszXG7FQhyeiry5p3Hau5+ZmH1wmC6Ir6Qbuh0zbJrqirib6F2YX
         OoelMpOCcvLAueNGGfSEEYYly6OdNiGSWCAzQcPZQ55Ny5aAYwvS6N5AD34OgVB/4pi1
         VfF+BykYpQdDyxk7OGJhbYP0fOhdUmkDwEjxyTeomLCk0wBnK1g89ua3RwleRbguMmGQ
         Mu+K1Lk2YhA2qHHxyeE4dP08BSYDeh9zFeVU4BoIOk3hpKUOAXoPCuAJW/4FAib4EXgM
         8yDFnLPovj9liQVEoqiffkfRF68K4UB2okYBfYOEpNZ7vGMATdJCu8AwEESuOhA+ryT8
         93dQ==
X-Gm-Message-State: AOJu0YyfzOBl+BlhQQ791yeSgu8ZC6ln/VZXYRKl+qpr4WqcQsmKSUG4
        AGpVRLSbfHd5NkyiEIei4tlSiI7TfbmajdK8TX/AjzcXkTB0XfxTPTkTI+sqNhBivkRfvH/EuI5
        bUjVRRy4pEx0556cprG6eILwL
X-Received: by 2002:a0c:aa9a:0:b0:65b:771:f2ea with SMTP id f26-20020a0caa9a000000b0065b0771f2eamr14687789qvb.53.1696976808077;
        Tue, 10 Oct 2023 15:26:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7/58KgO3b18HaxHhOjODoHl5A2u5oh0qL5aQngVtqkyqSQ0+wZCRK4G1WOlb/PoQfZ3Ro/g==
X-Received: by 2002:a0c:aa9a:0:b0:65b:771:f2ea with SMTP id f26-20020a0caa9a000000b0065b0771f2eamr14687781qvb.53.1696976807826;
        Tue, 10 Oct 2023 15:26:47 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id p6-20020a0ce186000000b0065b0e724f83sm5117109qvl.6.2023.10.10.15.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:26:47 -0700 (PDT)
Date:   Tue, 10 Oct 2023 17:26:45 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 09/15] firmware: qcom: scm: make qcom_scm_lmh_dcvsh()
 use the TZ allocator
Message-ID: <vggxx4dqzlg2k443oo34opkkwr7goqmkjsorcarbibeqz3oqbc@6hpy36jd2tow>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-10-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009153427.20951-10-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 05:34:21PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Let's use the new TZ memory allocator to obtain a buffer for this call
> instead of using dma_alloc_coherent().
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/firmware/qcom/qcom_scm.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 31071a714cf1..11638daa2fe5 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1340,8 +1340,6 @@ EXPORT_SYMBOL_GPL(qcom_scm_lmh_profile_change);
>  int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>  		       u64 limit_node, u32 node_id, u64 version)
>  {
> -	dma_addr_t payload_phys;
> -	u32 *payload_buf;
>  	int ret, payload_size = 5 * sizeof(u32);
>  
>  	struct qcom_scm_desc desc = {
> @@ -1356,7 +1354,9 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>  		.owner = ARM_SMCCC_OWNER_SIP,
>  	};
>  
> -	payload_buf = dma_alloc_coherent(__scm->dev, payload_size, &payload_phys, GFP_KERNEL);
> +	u32 *payload_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
> +							       payload_size,
> +							       GFP_KERNEL);
>  	if (!payload_buf)
>  		return -ENOMEM;
>  
> @@ -1366,11 +1366,10 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>  	payload_buf[3] = 1;
>  	payload_buf[4] = payload_val;
>  
> -	desc.args[0] = payload_phys;
> +	desc.args[0] = qcom_tzmem_to_phys(payload_buf);
>  
>  	ret = qcom_scm_call(__scm->dev, &desc, NULL);
>  
> -	dma_free_coherent(__scm->dev, payload_size, payload_buf, payload_phys);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh);
> -- 
> 2.39.2
> 

