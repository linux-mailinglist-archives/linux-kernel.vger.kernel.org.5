Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C387AD478
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjIYJZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjIYJZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:25:49 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00999AB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:25:42 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-415155b2796so672931cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695633942; x=1696238742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xr8Pm0FHns5z+sDzwSgcIqm9qFlErBM1xlOG5O4Qks=;
        b=VzBBH/glLLF758zOIAAL4gqUJQw9Mk9U2HsKWvdr1UpdSHjHASVWF/TOgOoWfuhfHj
         0legabos2U10CLDMVDRUTj7rO0urx4uEA1jJ9BMAareVBn87kL+XrkPWBqBimLcShp+Z
         3R0oxK0vUtvapuVzv8s1865f0/k7F+OWO2brjNeBEBcJ4BTb0KQ4ggF1afaytlcGPfPk
         LxLRjsLrCXvMrBL/R9ClU0Ga40UpSFjjOJaWfpKAupioXQ2LTG6lVJvpFW5nJ7+WfJLY
         GIPdsHQrTnzLahFvJvsytDdYUYo/Rt6P1DUHbmoMQiFOg9rEAIE64m0FXvZRC3uSxigR
         9wSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695633942; x=1696238742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xr8Pm0FHns5z+sDzwSgcIqm9qFlErBM1xlOG5O4Qks=;
        b=vkzqFw3/53OX9VeQ6CUatEcD6Pzr4Pp5cVm4nlo/1iLt6E7OJTIrE8zoL/aBpR6SPj
         gBt8cEzxTkcMosPJli9HmyfgtIqkZFVNYiREQd+8i9Q2mqpR62rBPEbTsaAl+ZtljYuz
         7a2rvuEVyQqFccsQjAYrtL6dTWcgndQInERdIyBi1dn8/5lfxpzp+SIfYvPn25HdlYuD
         yGFEKdIAvE0oUWpiWw04bxL0lzdwzVjRLta9YE6hb3wPgk1D9LI/GCPZYf4el+qORnAB
         yilfihoSAaOESieq1804vyavk7nwOB7t4MwoW3hke9p2zWPGoh7M6SnrMu/ArIRV6K+k
         ZNLg==
X-Gm-Message-State: AOJu0YwsqP1PFyKEwKP5QaoVMEmbdau4+Hda0gTJ4mh1iChnTu9ImWE6
        Orjj0p3gfztLWRgSpix1oupxWNlXF0yT5CTzwVrGfA==
X-Google-Smtp-Source: AGHT+IFfw6R3PruYRpn1KMKh6lR/ZIydA1Xovah/Z3U+3DE6GvyT7bl5mA/0LZHXEUU3B4R8i/UHE5x70+g4n5TmicA=
X-Received: by 2002:a05:622a:11c2:b0:410:653f:90e8 with SMTP id
 n2-20020a05622a11c200b00410653f90e8mr405985qtk.11.1695633941887; Mon, 25 Sep
 2023 02:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230925092249.2228743-1-hmazur@chromium.org>
In-Reply-To: <20230925092249.2228743-1-hmazur@chromium.org>
From:   =?UTF-8?Q?Micha=C5=82_Krawczyk?= <mikrawczyk@google.com>
Date:   Mon, 25 Sep 2023 11:25:30 +0200
Message-ID: <CAHDt3PPObYmUTedxQ5OJ4FcXNbb9LREQ9DfiBJ4KhA6=rCvBMA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Check GEM buffer size
To:     Hubert Mazur <hmazur@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 11:23=E2=80=AFAM Hubert Mazur <hmazur@chromium.org>=
 wrote:
>
> The buffer size is derived from parameters supplied by the userspace.
> Having the size equal 0 causes allocation failure leading to kernel
> panic.
>
> Fix this by checking if size equals 0.
>
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT817=
3.")
>
> Signed-off-by: Hubert Mazur <hmazur@chromium.org>
Reviewed-by: Michal Krawczyk <mikrawczyk@google.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_gem.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/med=
iatek/mtk_drm_gem.c
> index 9f364df52478..3b985b99d5c6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> @@ -62,6 +62,11 @@ struct mtk_drm_gem_obj *mtk_drm_gem_create(struct drm_=
device *dev,
>         struct drm_gem_object *obj;
>         int ret;
>
> +       if (size =3D=3D 0) {
> +               DRM_ERROR("Invalid allocation size: %zu", size);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
>         mtk_gem =3D mtk_drm_gem_init(dev, size);
>         if (IS_ERR(mtk_gem))
>                 return ERR_CAST(mtk_gem);
> --
> 2.42.0.515.g380fc7ccd1-goog
>
