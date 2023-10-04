Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E637B7A20
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241684AbjJDIeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241688AbjJDIeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:34:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13E6C1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:34:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50573e85ee0so2148934e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 01:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696408443; x=1697013243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfmW3coigpVfgSMijltIl7QADja7SAFkOQQrbcYexQk=;
        b=bOT0lP9lDC2xqTqru/LCIAZnVwJIJWhZVa3WKIV+MlonLzZRsspeMiktA08pHAiIZe
         VVe0uki+9l2/J8f9+nh3ZAq6l5lv3v5cyc2QroPyU789pcrj7gJryZiLuZrKeDsDmVAm
         FPtmjbqMwSF0oWZe9tMW4uS59OVTWEXszvx+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696408443; x=1697013243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfmW3coigpVfgSMijltIl7QADja7SAFkOQQrbcYexQk=;
        b=I4iUCTtieAPb0s7xJAi6Pzx2BMJB0QnvdlHZUsnlmfqkv1TLXbgSUVf8ND47HEafx3
         h9DuSQJOdT27JRPdo4T2VrIIaBeAdbzwlmjAyV/+egLRPtQR2PbH5tQcFo7ywQK8KbPg
         mUfKYgRZz1O9x2qPdtLgahri3rMKgBiUoswCwobpNSBA85SI5/WIDkWroVrmI1sBKvf7
         CpvkMij5ffS1LxDWGO6CPC6QFK6Y/NwBNEaXzGUwQZj2qnshSoJTpiX6iMizaSmgxvMb
         yysKqTqzoEbgwyApE3QozU4L78/EfRablITzDlLRgO2H7vkpeb+3Ey8dwST0l9Etz+km
         r6vQ==
X-Gm-Message-State: AOJu0YyGh1vcZ9sZfKeVL3CpDVNOU+dCmwAsoDUqoBoCcQev13W5E933
        11dXwlKxmvwLaGH/Y3shs3d9QjUKiKorc8Fg6UWPkA==
X-Google-Smtp-Source: AGHT+IF9sR2Cj+7e97L/FPexpqaBojFR/xX2jui4Z8uoOZLn5ebZKHpYgKEeRaYNH0lTMRLG8ectez6G8uh/TNsdVuw=
X-Received: by 2002:a19:e015:0:b0:500:94c3:8e3b with SMTP id
 x21-20020a19e015000000b0050094c38e3bmr1344729lfg.57.1696408442607; Wed, 04
 Oct 2023 01:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231004083226.1940055-1-wenst@chromium.org>
In-Reply-To: <20231004083226.1940055-1-wenst@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 4 Oct 2023 16:33:51 +0800
Message-ID: <CAGXv+5GiN22ObkB8P_w7ftVsWkRfOvoq3dAT4OtoUw3TTpUtaw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: Correctly free sg_table in gem prime vmap
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 4:32=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> wr=
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
> Also move the "out" shortcut label to after the kfree() call for the
> sg_table. Having sg_free_table() together with kfree() makes more sense.
> The shortcut is only used when the object already has a kernel address,
> in which case the pointer is NULL and kfree() does nothing. Hence this
> change causes no functional change.
>
> Fixes: 3df64d7b0a4f ("drm/mediatek: Implement gem prime vmap/vunmap funct=
ion")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Changes since v1:
- Move "out" shortcut label to after sg_free_table() and kfree()

> Please merge for v6.6 fixes.
>
> Also, I was wondering why the MediaTek DRM driver implements a lot of
> the GEM functionality itself, instead of using the GEM DMA helpers.
> From what I could tell, the code closely follows the DMA helpers, except
> that it vmaps the buffers only upon request.
>
>  drivers/gpu/drm/mediatek/mtk_drm_gem.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/med=
iatek/mtk_drm_gem.c
> index 9f364df52478..0e0a41b2f57f 100644
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
> @@ -248,12 +249,15 @@ int mtk_drm_gem_prime_vmap(struct drm_gem_object *o=
bj, struct iosys_map *map)
>         mtk_gem->kvaddr =3D vmap(mtk_gem->pages, npages, VM_MAP,
>                                pgprot_writecombine(PAGE_KERNEL));
>         if (!mtk_gem->kvaddr) {
> +               sg_free_table(sgt);
>                 kfree(sgt);
>                 kfree(mtk_gem->pages);
>                 return -ENOMEM;
>         }
> -out:
> +       sg_free_table(sgt);
>         kfree(sgt);
> +
> +out:
>         iosys_map_set_vaddr(map, mtk_gem->kvaddr);
>
>         return 0;
> --
> 2.42.0.582.g8ccd20d70d-goog
>
