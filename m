Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405057AE186
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjIYWHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIYWHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:07:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B90116
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695679574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tY5bcSFTLxhrJq0wnGX1DBWHzjbAl0iR3STf9o5hxaQ=;
        b=Pn62VgF9Hwhu/sZjPC7xQUyVIjjudYclDHUsjKggn1m7/c6QypemzGU1Hh/t0SxwqXFkhM
        37sNW/bbwPKGCjBmJwgrCU96hvefEJf+zntZYgSSGpkMY2D3TUAjM2Qu91Zanb5EpqmH2F
        ofrl6vdcptNo7b0kpKSfhicDhxPG/3Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-uCiVlFosO9GeqtQbA_SEMg-1; Mon, 25 Sep 2023 18:06:11 -0400
X-MC-Unique: uCiVlFosO9GeqtQbA_SEMg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32320b3ee93so2838091f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695679570; x=1696284370;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tY5bcSFTLxhrJq0wnGX1DBWHzjbAl0iR3STf9o5hxaQ=;
        b=Cy4kEHbtjTIB7Db9aBIlHSXLuijylFHv1uhKWKqUOmLm1h3bRFqeOa/s5fWWrv4wyb
         Njizo9EOCURkmvpXFIIbPFK0j+C385Hi1JpQiPJSq3ytzMQPQH2oBHX5kvpvmcLkTW31
         cfMvDOxYfgQp1uVwV/4bVkzGjj1U4q6Hp9XWITVig662FkUj4itlbFrRQjYcyG6WLoyC
         QIPl6HjDfFwcvPUX0nxVwgiLmkNxZiEPORxngy7qZKvlxS1vSRGVHOu6UTVEbK25bfqg
         8AZj7nXRsd7vq1aY9LWXjwjdh+zTaKlG4//CMPm8VUvw8EK9tUg03ieM0VWljUFEzGif
         rezQ==
X-Gm-Message-State: AOJu0YxyfdkLv9T8F0UR9f4UFd2/ijl4uv4elG8NA3PV8XPRK565T0YA
        WnGMB8l8dWij01j5zw2R5d3BESZzaUaHdhUe5oifGdsSo8J8YToEGxUp6x/f/NQzw+zZ7t0YN6w
        1UhL6u84G4X5tXRhwjn7CkbwW
X-Received: by 2002:a5d:6382:0:b0:319:8c35:378 with SMTP id p2-20020a5d6382000000b003198c350378mr6912291wru.44.1695679570581;
        Mon, 25 Sep 2023 15:06:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmeSIEMwFLWmZGGbq/ZzwRhXqWOvyeod0GnC31lUWRsM0brD8Xc2qSB7EvUpkx5KUb+zHPbw==
X-Received: by 2002:a5d:6382:0:b0:319:8c35:378 with SMTP id p2-20020a5d6382000000b003198c350378mr6912272wru.44.1695679570272;
        Mon, 25 Sep 2023 15:06:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d634c000000b0031773a8e5c4sm12875356wrw.37.2023.09.25.15.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 15:06:09 -0700 (PDT)
Message-ID: <e2072b46-11a4-a146-e984-70be30514fe1@redhat.com>
Date:   Tue, 26 Sep 2023 00:06:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Nouveau] [PATCH] drm/nouveau/kms/nv50: hide unused variables
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
        Wayne Lin <Wayne.Lin@amd.com>, Danilo Krummrich <me@dakr.org>
References: <20230925155930.677620-1-arnd@kernel.org>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20230925155930.677620-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/23 17:59, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After a recent change, two variables are only used in an #ifdef:
> 
> drivers/gpu/drm/nouveau/dispnv50/disp.c: In function 'nv50_sor_atomic_disable':
> drivers/gpu/drm/nouveau/dispnv50/disp.c:1569:13: error: unused variable 'ret' [-Werror=unused-variable]
>   1569 |         int ret;
>        |             ^~~
> drivers/gpu/drm/nouveau/dispnv50/disp.c:1568:28: error: unused variable 'aux' [-Werror=unused-variable]
>   1568 |         struct drm_dp_aux *aux = &nv_connector->aux;
>        |                            ^~~
> 
> Move them into the same conditional block, along with the nv_connector variable
> that becomes unused during that fix.
> 
> Fixes: 757033808c95b ("drm/nouveau/kms/nv50-: fixup sink D3 before tearing down link")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Danilo Krummrich <dakr@redhat.com>

> ---
>   drivers/gpu/drm/nouveau/dispnv50/disp.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 52f1569ee37c1..a0ac8c258d9ff 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1560,15 +1560,13 @@ nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *st
>   {
>   	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
>   	struct nv50_head *head = nv50_head(nv_encoder->crtc);
> -	struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
>   #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
> +	struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
>   	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
>   	struct nouveau_backlight *backlight = nv_connector->backlight;
> -#endif
>   	struct drm_dp_aux *aux = &nv_connector->aux;
>   	int ret;
>   
> -#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
>   	if (backlight && backlight->uses_dpcd) {
>   		ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
>   		if (ret < 0)

