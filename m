Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CD976281B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 03:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjGZBWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 21:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGZBWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:22:10 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 95EDDC0;
        Tue, 25 Jul 2023 18:22:09 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 9DA4E6025FB42;
        Wed, 26 Jul 2023 09:21:51 +0800 (CST)
Message-ID: <630b9f2e-00e8-5b54-ad1c-3e4d404454a1@nfschina.com>
Date:   Wed, 26 Jul 2023 09:21:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915/tv: avoid possible division by
 zero
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, andrzej.hajda@intel.com,
        intel-gfx@lists.freedesktop.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mripard@kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <5d096bcf-c394-4dad-b307-3d7e33ab6e6f@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/25 13:51, Dan Carpenter wrote:
> The reason why the first five attempts had bugs is because we are
> trying to write it in the most complicated way possible, shifting by
> logical not what?
Wonderful! Should I add your name as signed-of-by?
I will send a v3 patch later.
Really thanks for your help!

Su Hui

> regards,
> dan carpenter
>
> diff --git a/drivers/gpu/drm/i915/display/intel_tv.c b/drivers/gpu/drm/i915/display/intel_tv.c
> index 36b479b46b60..6997b6cb1df2 100644
> --- a/drivers/gpu/drm/i915/display/intel_tv.c
> +++ b/drivers/gpu/drm/i915/display/intel_tv.c
> @@ -988,7 +988,13 @@ intel_tv_mode_to_mode(struct drm_display_mode *mode,
>   		      const struct tv_mode *tv_mode,
>   		      int clock)
>   {
> -	mode->clock = clock / (tv_mode->oversample >> !tv_mode->progressive);
> +	int div = tv_mode->oversample;
> +
> +	if (!tv_mode->progressive)
> +		div >>= 1;
> +	if (div == 0)
> +		div = 1;
> +	mode->clock = clock / div;
>   
>   	/*
>   	 * tv_mode horizontal timings:
> @@ -1135,6 +1141,8 @@ intel_tv_get_config(struct intel_encoder *encoder,
>   		break;
>   	default:
>   		tv_mode.oversample = 1;
> +		WARN_ON_ONCE(!tv_mode.progressive);
> +		tv_mode.progressive = true;
>   		break;
>   	}
>   
>
