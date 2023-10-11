Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793097C5EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjJKVUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjJKVUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:20:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0FBA9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697059163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ARFU5ehJ77LMWQGx5SDRsMXLUYL9Q8sCSHPYnJI9hQ=;
        b=eGWT7cA1oX41XyND6xTX+DnGSccEauXa8j+lgxIMhGSR0fm9MDQqc10O/CBYJS+rk3ykUF
        jmZuIgvsjT/rhEYUuIhC9QtTn13eRZ/AIQVklgvHILnbFkwHdi1sr6E04vRzXmhQIPKIVl
        d22RKwOfT20YaPY7J+KGUbwm9SecIYM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-NxDZTYGPMReF_eU-2-VvxQ-1; Wed, 11 Oct 2023 17:19:11 -0400
X-MC-Unique: NxDZTYGPMReF_eU-2-VvxQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-774105e8c7fso33936085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697059151; x=1697663951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ARFU5ehJ77LMWQGx5SDRsMXLUYL9Q8sCSHPYnJI9hQ=;
        b=pJtnsHwhiL1D0IG6TLgFRfgkKKUopu8SOnTKJnE/CCzruxuiwOmOdwOrQSks2naFBZ
         XI/63GEasfvoseTNsAaxspDQFs1opbz4EpPAfaa71R7S/RFC261E/YYkV+gYXBZDK1Vf
         tJLpjiJiyYibrTcN3rznxPIR8MWJUvEBaRbHf8YzD3YffqgYgJqu0S8q8JUFNUrj6/Rp
         Re1F83SQn/W2YViWyZtkTjzWHdWQJbupXiicO5BtbV3rXZEcHlHnUCw+Sal/PZyK1e2M
         taDBIh+oMwctz00BWf7AA5utMvokWiMUPcckumIv9N1i4rSt28WgPN7vhL3eoxvwLN6f
         gcJg==
X-Gm-Message-State: AOJu0YzPuYCVLhVPBBuc7NoJ6AfUV9i+DLC8YuDhiKCV7l6sRhhcvgoF
        WizuoXooMunv5SKD9MzAJ/rYdsn1RCSXtyGqTEcd1NEpTQobGvRmhc88yfwNHp+rADPFLdMlGLI
        hg+hgG2213x1a48NvMX2rjRZm
X-Received: by 2002:a05:620a:24c8:b0:775:9025:c18a with SMTP id m8-20020a05620a24c800b007759025c18amr25845154qkn.35.1697059151238;
        Wed, 11 Oct 2023 14:19:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYryp37Si/mOVFiRWp6KQ4xbl+Cq9cO+Og0eIcqwKiNzWhUHZVCxvChfEaZVnlkhQdnFD5mQ==
X-Received: by 2002:a05:620a:24c8:b0:775:9025:c18a with SMTP id m8-20020a05620a24c800b007759025c18amr25845136qkn.35.1697059150956;
        Wed, 11 Oct 2023 14:19:10 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id y23-20020a37e317000000b00767da9b6ae9sm5493487qki.11.2023.10.11.14.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:19:10 -0700 (PDT)
Date:   Wed, 11 Oct 2023 16:19:08 -0500
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
Subject: Re: [PATCH v3 14/15] firmware: qcom: scm: clarify the comment in
 qcom_scm_pas_init_image()
Message-ID: <gnwwzwtxwsvetldugl4h6muoki7gleqbyfrx7jve7lx52p7xde@5kfhsgrbnynn>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-15-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009153427.20951-15-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 05:34:26PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The "memory protection" mechanism mentioned in the comment is the SHM
> Bridge. This is also the reason why we do not convert this call to using
> the TM mem allocator.

s/TM/TZ/ ?

> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 839773270a21..8a2475ced10a 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -563,9 +563,13 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
>  	struct qcom_scm_res res;
>  
>  	/*
> -	 * During the scm call memory protection will be enabled for the meta
> -	 * data blob, so make sure it's physically contiguous, 4K aligned and
> -	 * non-cachable to avoid XPU violations.
> +	 * During the SCM call the TrustZone will make the buffer containing
> +	 * the program data into an SHM Bridge. This is why we exceptionally
> +	 * must not use the TrustZone memory allocator here as - depending on
> +	 * Kconfig - it may already use the SHM Bridge mechanism internally.
> +	 *
> +	 * If we pass a buffer that is already part of an SHM Bridge to this
> +	 * call, it will fail.

I can at least confirm this matches my testing results in v2, fwiw.

I guess you could use the Kconfig and conditionally use the TZ mem
allocator if !SHMBridge, but I don't know if its worth the if statements
or not.

Bummer, I can't think of a beautiful way to unify this outside of a
dedicated non SHM bridge pool for this...

>  	 */
>  	mdata_buf = dma_alloc_coherent(__scm->dev, size, &mdata_phys,
>  				       GFP_KERNEL);
> -- 
> 2.39.2
> 

