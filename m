Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8437B6CC5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjJCPOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjJCPOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:14:48 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D42CB0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:14:45 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-495c10cec8aso470343e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696346084; x=1696950884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G502n/pwsi2xTvXRats/u+gp/KdtO1vpg74dn53OTQA=;
        b=KfmNOFLqCS+lSSOgcbphofXlnxSqCS+9qJZ4baHQnOOMsa5qaZhbtZ5VvQ/5FEUE58
         tBDiXS3+dnR2aETNg4Ovm2t9NQ63VigILPawUn4BvQro5Of0g60Ta2xXrAie87EBmAHb
         nrSb1UPrNB6AuvVA+QL1gCbfYFR0bAb4d0AMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696346084; x=1696950884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G502n/pwsi2xTvXRats/u+gp/KdtO1vpg74dn53OTQA=;
        b=u0TLTnSqZLAUJMgtB77EvTIAzVDliDmLPJj2o5oKRMlS+sgjnjcY2oJUxPqZjCk/eT
         tQDWT6inguCDZvD41qf5fqCUoQ2Vi9ZsViUdrQyQjEjFUJcyt8EkZSV0rxjTbYjIHQ7d
         MdDw4ryDlUuepKUPTjsqJwh5KZw+BmvK0YuE+G70/grBvZbpG7J66PbTOds8xxa6JPLS
         bi62hNloLU+kOtg2dgR5tQcMBltrgjmojGrdckpbhkT56HXb2DTlNMxKoVVPbsaB0ldL
         6BVYdj1lKbqByI5IZUSuDeQGAKmS5z8B2XSvaTJvcnztlUmoB8G73lnr+rBv3B2HRlg1
         cqqg==
X-Gm-Message-State: AOJu0YyizybTVg5gcNvkbJ+97JbDuBqrRGcUhhwggANYDHD4c8ihrmCS
        kAPmAj9QMaCWyQdnAhFnmekippz21HluutOjmT3hvQ==
X-Google-Smtp-Source: AGHT+IFfg/XsyCRAvdUgyolXi9PnolqHd3VaNSoM4w3If3uzr2zNrcEqKmIptVR4WBOt2OSagsdAHg==
X-Received: by 2002:a1f:e043:0:b0:495:bf04:89f8 with SMTP id x64-20020a1fe043000000b00495bf0489f8mr11819878vkg.6.1696346084033;
        Tue, 03 Oct 2023 08:14:44 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id l23-20020a05612210d700b0048f9f9200c7sm187515vko.45.2023.10.03.08.14.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 08:14:43 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-45274236ef6so570784137.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 08:14:42 -0700 (PDT)
X-Received: by 2002:a05:6102:274c:b0:452:9384:139a with SMTP id
 p12-20020a056102274c00b004529384139amr13589952vsu.22.1696346082550; Tue, 03
 Oct 2023 08:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231002092051.555479-1-wenst@chromium.org>
In-Reply-To: <20231002092051.555479-1-wenst@chromium.org>
From:   Fei Shao <fshao@chromium.org>
Date:   Tue, 3 Oct 2023 23:14:06 +0800
X-Gmail-Original-Message-ID: <CAC=S1ng3_z0H48awhum7unXTTk0yfn61pTWqSmPJ9fWdoURL=A@mail.gmail.com>
Message-ID: <CAC=S1ng3_z0H48awhum7unXTTk0yfn61pTWqSmPJ9fWdoURL=A@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Correctly free sg_table in gem prime vmap
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 2, 2023 at 5:21=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> The MediaTek DRM driver implements GEM PRIME vmap by fetching the
> sg_table for the object, iterating through the pages, and then
> vmapping them. In essence, unlike the GEM DMA helpers which vmap
> when the object is first created or imported, the MediaTek version
> does it on request.
>
> Unfortunately, the code never correctly frees the sg_table contents.
> This results in a kernel memory leak. On a Hayato device with a text
> console on the internal display, this results in the system running
> out of memory in a few days from all the console screen cursor updates.
>
> Add sg_free_table() to correctly free the contents of the sg_table. This
> was missing despite explicitly required by mtk_gem_prime_get_sg_table().
>
> Fixes: 3df64d7b0a4f ("drm/mediatek: Implement gem prime vmap/vunmap funct=
ion")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Please merge for v6.6 fixes.
>
> Also, I was wondering why the MediaTek DRM driver implements a lot of
> the GEM functionality itself, instead of using the GEM DMA helpers.
> From what I could tell, the code closely follows the DMA helpers, except
> that it vmaps the buffers only upon request.
>
>
>  drivers/gpu/drm/mediatek/mtk_drm_gem.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/med=
iatek/mtk_drm_gem.c
> index 9f364df52478..297ee090e02e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> @@ -239,6 +239,7 @@ int mtk_drm_gem_prime_vmap(struct drm_gem_object *obj=
, struct iosys_map *map)
>         npages =3D obj->size >> PAGE_SHIFT;
>         mtk_gem->pages =3D kcalloc(npages, sizeof(*mtk_gem->pages), GFP_K=
ERNEL);
>         if (!mtk_gem->pages) {
> +               sg_free_table(sgt);
>                 kfree(sgt);
>                 return -ENOMEM;
>         }
> @@ -248,11 +249,13 @@ int mtk_drm_gem_prime_vmap(struct drm_gem_object *o=
bj, struct iosys_map *map)
>         mtk_gem->kvaddr =3D vmap(mtk_gem->pages, npages, VM_MAP,
>                                pgprot_writecombine(PAGE_KERNEL));
>         if (!mtk_gem->kvaddr) {
> +               sg_free_table(sgt);
>                 kfree(sgt);
>                 kfree(mtk_gem->pages);
>                 return -ENOMEM;
>         }
>  out:
> +       sg_free_table(sgt);

I think this will cause invalid access from the "goto out" path -
sg_free_table() accesses the provided sg table pointer, but it doesn't
handle NULL pointers like kfree() does.

Regards,
Fei


>         kfree(sgt);
>         iosys_map_set_vaddr(map, mtk_gem->kvaddr);
>
> --
> 2.42.0.582.g8ccd20d70d-goog
>
>
