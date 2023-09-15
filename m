Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B52B7A24F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbjIORgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236564AbjIORgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6116A2D59
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694799297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wg4EmNZIrmGv1tACZxeJZ0Y5VT57wRFa8YOjLPmyTEA=;
        b=C3h7nYWLxOH8bendxvD5cShERRzKQs31ZvhOT+32f/RD8dXeutS20X5zzcmUblpu0uZZr3
        p1vPkHX2+1x0lcIYk8tbG2loJHVtjdgY91jnC4qCQqp5g1Kl2+kxiSbwyhFKumB5xhVf4R
        b2YucSzq+sv7cQlvAEJUkK0XXhCACYg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-3HYJNYH1P9KakmUM-x9w0w-1; Fri, 15 Sep 2023 13:34:56 -0400
X-MC-Unique: 3HYJNYH1P9KakmUM-x9w0w-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6563dbf266aso5389246d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799295; x=1695404095;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg4EmNZIrmGv1tACZxeJZ0Y5VT57wRFa8YOjLPmyTEA=;
        b=vlmRATVCN4XZ5X+al/CuLuklFxJJTWGQkSimqG14B2YjsUzW0T2T14RclLnM7vzNR5
         +/quTUmt6sCURXYG2x42XNpD5KFCNWRYsCiKGZYO5syEzGWUWYOmt9obKDo7V3DGP1dY
         w3wLjS8EAsTPPTnjum1XHqdh2bTeUrcy8SpXLRwffu+GKH+JG/0E37j0CwjSwfsBjXKD
         SQxHZ8xhnnZfyr/Nj2fE2owg0B1MLSFiHGSt88D8znPCi7Gq6pyd67cnS5rf5VGGtuM0
         K0UWe6JxC4uXNSxOHcKdk5KlmdatEQ/KYV/YNzGXVFbejmMWOqp3WRBwiLyr3lUnYutw
         B+dw==
X-Gm-Message-State: AOJu0Ywo4Vdc2NRqmiGYiwocW5Sk3b3or2aIfgTPJHogJ+MvBKyOJHmj
        tXcw02qXiM6gNgDJLMqGV8efr/2umzA4R9sM5YAp+Az/UeQuYbHM7/gEAOOl4SAL4aD0fF+GdUj
        kDRBvFdJYqEsW7ZkfE8Bkzf/S
X-Received: by 2002:a05:620a:31a8:b0:76e:f38b:e87a with SMTP id bi40-20020a05620a31a800b0076ef38be87amr2532013qkb.48.1694799295664;
        Fri, 15 Sep 2023 10:34:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP11ZRbh22ddAzRnfdJhpVYsJBozLWaDGrgjYYQNVtI0psKjUDWcq5Q/AqsDQgs/wMdX3AMQ==
X-Received: by 2002:a05:620a:31a8:b0:76e:f38b:e87a with SMTP id bi40-20020a05620a31a800b0076ef38be87amr2531996qkb.48.1694799295431;
        Fri, 15 Sep 2023 10:34:55 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id b1-20020a05620a118100b0076ca401d8c7sm1358150qkk.111.2023.09.15.10.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 10:34:55 -0700 (PDT)
Message-ID: <0a563e8d6e380e8f89956abc8b17090432a142b5.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/nvif: refactor deprecated strncpy
From:   Lyude Paul <lyude@redhat.com>
To:     Justin Stitt <justinstitt@google.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Fri, 15 Sep 2023 13:34:53 -0400
In-Reply-To: <20230914-strncpy-drivers-gpu-drm-nouveau-nvif-client-c-v1-1-dc3b3719fcb4@google.com>
References: <20230914-strncpy-drivers-gpu-drm-nouveau-nvif-client-c-v1-1-dc3b3719fcb4@google.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push this and your other patches in just a moment

On Thu, 2023-09-14 at 21:30 +0000, Justin Stitt wrote:
> `strncpy` is deprecated and as such we should prefer more robust and
> less ambiguous string interfaces.
>=20
> A suitable replacement is `strscpy_pad` due to the fact that it
> guarantees NUL-termination on the destination buffer whilst also
> maintaining the NUL-padding behavior that `strncpy` provides. I am not
> sure whether NUL-padding is strictly needed but I see in
> `nvif_object_ctor()` args is memcpy'd elsewhere so I figured we'd keep
> the same functionality.
>=20
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/gpu/drm/nouveau/nvif/client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvif/client.c b/drivers/gpu/drm/nouv=
eau/nvif/client.c
> index a3264a0e933a..3a27245f467f 100644
> --- a/drivers/gpu/drm/nouveau/nvif/client.c
> +++ b/drivers/gpu/drm/nouveau/nvif/client.c
> @@ -69,7 +69,7 @@ nvif_client_ctor(struct nvif_client *parent, const char=
 *name, u64 device,
>  	} nop =3D {};
>  	int ret;
> =20
> -	strncpy(args.name, name, sizeof(args.name));
> +	strscpy_pad(args.name, name, sizeof(args.name));
>  	ret =3D nvif_object_ctor(parent !=3D client ? &parent->object : NULL,
>  			       name ? name : "nvifClient", 0,
>  			       NVIF_CLASS_CLIENT, &args, sizeof(args),
>=20
> ---
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> change-id: 20230914-strncpy-drivers-gpu-drm-nouveau-nvif-client-c-82b023c=
36953
>=20
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

