Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406197B099F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjI0QIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI0QIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EDC92
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695830874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dmc5VmRD75N5MrwkjQkOMmpHbgV6BLNCT6oM/cgrosQ=;
        b=R32qGWQ+husnVbwqfNjjucdSMaRYYlZoorFaJsvq4kppQFpQTVlKYdCRyafEF6QMXd7nQ0
        tgy5wRlQxWhJIV9CdrSeLpOxWXM3fjYI44FNno6P7UA+WzHcwfXe3nGuA+FNqQm54jfntC
        ePtJ3dDoZxoBVBijEznhmgDm4teyNlQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-P5wa97hBNeGWOUfc_sf1oQ-1; Wed, 27 Sep 2023 12:07:52 -0400
X-MC-Unique: P5wa97hBNeGWOUfc_sf1oQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99388334de6so1001196366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695830871; x=1696435671;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dmc5VmRD75N5MrwkjQkOMmpHbgV6BLNCT6oM/cgrosQ=;
        b=EuTXsMgSMVqPby2JvERw16E/Ado/MtbAt4UhLb26ffa1xHdSSncMhJE0yhCopt85R/
         BTKUhEG1eNEOh3eyhxz6gFGv7dM0m08P4yH7XYavoI8Kajg7ktb770ulR9QMNFHfUd97
         HFlfr4VSa2Yq5QsaGE3FUw49CA6CSaNIqemc0t1k+H6y3uwPA7aDRYzN+0f9qV8g1k+u
         Fsmq8cy0I1nIEffHtpkHEyPRzAW3U+PMFK922vQrbXMHEBjhzPyquIpFbmCAfe3uesbG
         6wv3OKwK6UOfcL812p+545ZFOpzJPlRaD54LLbUVzqf/3uTDJjm1g/lswVZPL9emCO3E
         8mGw==
X-Gm-Message-State: AOJu0YzipjRYwXKwkiBKP+omwoAvT3iPJDbC685u22MGDlkBQdSdMdI9
        VbfmlaaHnGiIo0dSw60lTPJ/zZJxqYQzE5lp0sPCj2xkLHfJL8zlw6FrG4Tb8x7TA4sxIg21hXc
        FlyvFA7I04sye8KojxDaw98Wi
X-Received: by 2002:a17:906:cc4a:b0:9a5:852f:10ae with SMTP id mm10-20020a170906cc4a00b009a5852f10aemr2068151ejb.60.1695830871402;
        Wed, 27 Sep 2023 09:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEScE57Oifvf88LVHOFmgxtaT4lQ7JAGP2BjnoUvP4S8zYBm//vVNHqB4Egl8TQoqvs/HAJ7Q==
X-Received: by 2002:a17:906:cc4a:b0:9a5:852f:10ae with SMTP id mm10-20020a170906cc4a00b009a5852f10aemr2068130ejb.60.1695830871071;
        Wed, 27 Sep 2023 09:07:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099cf840527csm9523564ejc.153.2023.09.27.09.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 09:07:50 -0700 (PDT)
Message-ID: <83c1b1df-7e5e-8b71-358a-9c34969dc695@redhat.com>
Date:   Wed, 27 Sep 2023 18:07:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Nouveau] [PATCH] drm/nouveau/kms/nv50: hide unused variables
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Danilo Krummrich <me@dakr.org>, Ben Skeggs <bskeggs@redhat.com>
Cc:     nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
        Wayne Lin <Wayne.Lin@amd.com>
References: <20230925155930.677620-1-arnd@kernel.org>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20230925155930.677620-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Applied to drm-misc-next, thanks!

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

