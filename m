Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9A47D914E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjJ0IXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345534AbjJ0IWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE27F10CF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698394907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ZxpY1vjsc4zx7bmsbIUQXSJpyxKql+2tTnnsraEizo=;
        b=h+kjnRq34qI6AfEI2uxkgNJESlFUI3sv3+Zn29cn+MeV7DVViz9mu52RuTej1CXALHznws
        rcZw33YBGQyn+rCwROU5CUjcxy6hOmwy9G1ccVqV53ur42hnTMxGSUA0FPwCr05tkyuR4Q
        tmNWFqrFuAN8dbJHXn+yagGXFqmb5Ms=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-GnB8q6rWNSyuWShPblyC5w-1; Fri, 27 Oct 2023 04:21:45 -0400
X-MC-Unique: GnB8q6rWNSyuWShPblyC5w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4083717431eso13759005e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698394904; x=1698999704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZxpY1vjsc4zx7bmsbIUQXSJpyxKql+2tTnnsraEizo=;
        b=bLaocZfbCn3p175YGFNY24iuU3EO947KGYCxOpkKQ3/RF4OoJszEh6eJl6xgzKpaYB
         3EqmGq/nhAMhhpPs6i8emAhTUhmy3CMwkPKF0GSYsiThEVYfK9Rz5RTc0+UCGpUOdQEy
         AUZQvSQvdInMCn5onSer70yFFzDCDfOKFVlWHokWZtPyktBgV05VllUbFdxz1vF+XwX/
         MhZn6l9AluDqqegptRsDMky5PiWbdDDCp9Qc9SFZjC3eyOTo2pVXFKRc2ammaHkmZakg
         jyGg7fqiRbLVZd34nFezTfbaZ50wvuu4mnCQMfGbn9r9Lctqbe14FC1AG3BC7a/fqS2Y
         LTUg==
X-Gm-Message-State: AOJu0YyavYqVxgXkD5w4GkMAZQlyh020uLw2OFoef2SdloGjh3yp0r75
        DYUxdt3QCzxQIbwAUJtKn2LzhtWXHMZpI9MuFkn9rNY+hQuAzLtny8Tr3zu9OJBukpraVA9WDXc
        +YdfTlIqtkRRSNueYsBcZNqFt
X-Received: by 2002:a5d:6782:0:b0:319:867e:97d7 with SMTP id v2-20020a5d6782000000b00319867e97d7mr1431772wru.52.1698394904067;
        Fri, 27 Oct 2023 01:21:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFX4cZTcYTSS67ZvwWwFIoRNz9zHlbzA9ZwiQnl0+H47D3MNXP0EvI2yIjN6m1nwZEWfpVEdw==
X-Received: by 2002:a5d:6782:0:b0:319:867e:97d7 with SMTP id v2-20020a5d6782000000b00319867e97d7mr1431763wru.52.1698394903737;
        Fri, 27 Oct 2023 01:21:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:d5:a000:680e:9bf4:b6a9:959b? ([2a01:e0a:d5:a000:680e:9bf4:b6a9:959b])
        by smtp.gmail.com with ESMTPSA id h16-20020adfe990000000b0032dc24ae625sm1225357wrm.12.2023.10.27.01.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 01:21:43 -0700 (PDT)
Message-ID: <b048247c-75e9-488e-a4f3-b227a38bca5e@redhat.com>
Date:   Fri, 27 Oct 2023 10:21:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ssd130x: Fix possible uninitialized usage of
 crtc_state variable
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20231020225338.1686974-1-javierm@redhat.com>
From:   Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20231020225338.1686974-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/10/2023 00:52, Javier Martinez Canillas wrote:
> Avoid a possible uninitialized use of the crtc_state variable in function
> ssd132x_primary_plane_atomic_check() and avoid the following Smatch warn:
> 
>      drivers/gpu/drm/solomon/ssd130x.c:921 ssd132x_primary_plane_atomic_check()
>      error: uninitialized symbol 'crtc_state'.

That looks trivial, so you can add:

Acked-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Fixes: fdd591e00a9c ("drm/ssd130x: Add support for the SSD132x OLED controller family")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/dri-devel/7dd6ca45-8263-44fe-a318-2fd9d761425d@moroto.mountain/
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>   drivers/gpu/drm/solomon/ssd130x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
> index 32f0857aec9f..e0174f82e353 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c
> @@ -910,7 +910,7 @@ static int ssd132x_primary_plane_atomic_check(struct drm_plane *plane,
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct ssd130x_plane_state *ssd130x_state = to_ssd130x_plane_state(plane_state);
>   	struct drm_crtc *crtc = plane_state->crtc;
> -	struct drm_crtc_state *crtc_state;
> +	struct drm_crtc_state *crtc_state = NULL;
>   	const struct drm_format_info *fi;
>   	unsigned int pitch;
>   	int ret;

