Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8727C58CD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbjJKQEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjJKQED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:04:03 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B74B7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:04:01 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9d7a98abbso2739895ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697040241; x=1697645041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/JdPIzkZRw+UEDCwPct/StXsx1OeuztdzUWh/BOTJXs=;
        b=Xc1EJqelwNYwe6Kfm2eAtA+XjRix1DyZKgwQEYFbVIKUUCcIGcjZR2WLhB2MLXxPX0
         94Q4uq4CfMxRvyn4xMGcNfiWykpv8hw1yYfq7Ti/9rQ58zqk4fpvoBPqYVp6aTd2cvZy
         PssJ3Cmh+uof7P87zQx6jkKvklsPgM5myBsKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697040241; x=1697645041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JdPIzkZRw+UEDCwPct/StXsx1OeuztdzUWh/BOTJXs=;
        b=dPXsHundQRoaLMyHTbm9Z/89YXDWZ3TN3vNYqYxjTqzETV9Oxy2ZSXQK4cbIaYRQOt
         sVbX91VTEOTfFtlADNlGKiln1RxAbBWVmQndQ8/9ftIzlF09v5jnOPNvN7fEETUrDgLX
         MyAGYovgafZDLKiO6EPJ8WLa6Jy0mJmhr0aj8bdXBhrUhNyZH2eW8PaE14v2649N1MWb
         llPqVZQf4/y83NeF8njfC3KQ63l39DE04n0BPfDvOEUeICvnkAHrToX04RjknZOWuMqY
         MdpnEEiTgYt7NLBYcsBAMiGIb/K67mfeSs+PQoA2n4qiLCoF3tAAP3/gSPQRpHNinAqd
         BjQw==
X-Gm-Message-State: AOJu0YxZcnsKJLfCQliuWgZJb7ho06zkhc759+iSvdc3uItNYMfzqwCC
        VpVICdMvaCajauSsDQ+Xn9oTgQ==
X-Google-Smtp-Source: AGHT+IGqjWqrCIqSHnONJ5fjKcFYrHjY07tSyis9X/kZiXSoJrS/q64lZQJ+lrnayGHRVg3N8XWShA==
X-Received: by 2002:a17:903:2289:b0:1c6:28f6:9545 with SMTP id b9-20020a170903228900b001c628f69545mr21755725plh.45.1697040241156;
        Wed, 11 Oct 2023 09:04:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jw14-20020a170903278e00b001adf6b21c77sm9908plb.107.2023.10.11.09.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 09:04:00 -0700 (PDT)
Date:   Wed, 11 Oct 2023 09:03:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Arvind Yadav <Arvind.Yadav@amd.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] dma-buf: Fix NULL pointer dereference in
 dma_fence_enable_sw_signaling()
Message-ID: <202310110903.FE533CBCD@keescook>
References: <ZSarP0/+hG8/87//@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSarP0/+hG8/87//@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 08:03:43AM -0600, Gustavo A. R. Silva wrote:
> Currently, a NULL pointer dereference will happen in function
> `dma_fence_enable_sw_signaling()` (at line 615), in case `chain`
> is not allocated in `mock_chain()` and this function returns
> `NULL` (at line 86). See below:
> 
> drivers/dma-buf/st-dma-fence-chain.c:
>  86         chain = mock_chain(NULL, f, 1);
>  87         if (!chain)
>  88                 err = -ENOMEM;
>  89
>  90         dma_fence_enable_sw_signaling(chain);

Instead of the larger patch, should line 88 here just do a "return
-ENOMEM" instead?

-Kees

> 
> drivers/dma-buf/dma-fence.c:
>  611 void dma_fence_enable_sw_signaling(struct dma_fence *fence)
>  612 {
>  613         unsigned long flags;
>  614
>  615         spin_lock_irqsave(fence->lock, flags);
> 			       ^^^^^^^^^^^
> 				    |
> 			  NULL pointer reference
> 			  if fence == NULL
> 
>  616         __dma_fence_enable_signaling(fence);
>  617         spin_unlock_irqrestore(fence->lock, flags);
>  618 }
> 
> Fix this by adding a NULL check before dereferencing `fence` in
> `dma_fence_enable_sw_signaling()`. This will prevent any other NULL
> pointer dereference when the `fence` passed as an argument is `NULL`.
> 
> Addresses-Coverity: ("Dereference after null check")
> Fixes: d62c43a953ce ("dma-buf: Enable signaling on fence for selftests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/dma-buf/dma-fence.c | 9 ++++++++-
>  include/linux/dma-fence.h   | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 8aa8f8cb7071..4d2f13560d0f 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -607,14 +607,21 @@ static bool __dma_fence_enable_signaling(struct dma_fence *fence)
>   * This will request for sw signaling to be enabled, to make the fence
>   * complete as soon as possible. This calls &dma_fence_ops.enable_signaling
>   * internally.
> + *
> + * Returns 0 on success and a negative error value when @fence is NULL.
>   */
> -void dma_fence_enable_sw_signaling(struct dma_fence *fence)
> +int dma_fence_enable_sw_signaling(struct dma_fence *fence)
>  {
>  	unsigned long flags;
>  
> +	if (!fence)
> +		return -EINVAL;
> +
>  	spin_lock_irqsave(fence->lock, flags);
>  	__dma_fence_enable_signaling(fence);
>  	spin_unlock_irqrestore(fence->lock, flags);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(dma_fence_enable_sw_signaling);
>  
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index ebe78bd3d121..1e4025e925e6 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -399,7 +399,7 @@ int dma_fence_add_callback(struct dma_fence *fence,
>  			   dma_fence_func_t func);
>  bool dma_fence_remove_callback(struct dma_fence *fence,
>  			       struct dma_fence_cb *cb);
> -void dma_fence_enable_sw_signaling(struct dma_fence *fence);
> +int dma_fence_enable_sw_signaling(struct dma_fence *fence);
>  
>  /**
>   * dma_fence_is_signaled_locked - Return an indication if the fence
> -- 
> 2.34.1
> 
> 

-- 
Kees Cook
