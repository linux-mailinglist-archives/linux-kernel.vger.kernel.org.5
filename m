Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43B27B78C6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241541AbjJDHdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241534AbjJDHdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:33:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F22FB4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 00:33:00 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5041335fb9cso2049835e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 00:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696404779; x=1697009579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzbt6X7Q7d0mjTqmZT49evnXk1E+0LrXDBffntKrV+U=;
        b=bX7IRveGVY3S7IGm0QAUpiHP3Iy8bUCjGwnNtWLg2L0YBiLRkAB72VBNQOaip6z041
         yUF/jPtLQ6z4o8Wdp/qYk5D2gPqogUqBsePhk9GWYSwUVsF8V7Ht9pwnvAQaYnqYZXWq
         MwSUYByRWJBtM0LrUpB2IY6/Rgkf57iuM/rxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696404779; x=1697009579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzbt6X7Q7d0mjTqmZT49evnXk1E+0LrXDBffntKrV+U=;
        b=HhSPyyXHUvSstUMd2jFcVdwtBLqyF3rH9Ap/OtIGhCgtb4W2qmJHpFuhQIbDA3Hw7F
         j22GCHje60LCym8ojLAvDcQ0RJh5AmQfNB+d2+vEjnUAjPyZQqaEa7mKg1D+KqmD1hyR
         vJ1oziuhT1Fg2YlkEHvYVSa0NOTzK8vlvRP0f9AQj55gYnqqhXy822Ep79ngRs9T1zR7
         XZYS/oUkvdsP3FcETqARQaZME3DXFlruCvBtuR3fmUg+08CHtXk8sou/wo4quFFk8Eft
         8Vr2X5N5pg97TvH3kvv7MQuAlJW+NE00ndcuyQRIIHKdmg2jpOSCnfZbSkohZkaEUeKF
         RHNQ==
X-Gm-Message-State: AOJu0YzxOWXOxb1JtGlf3BIBQFx0K1x/crujaTwkpwaLSPgtIl5w3elK
        oNzu2op+8xOYKEb6xqaia+vtwymesLUDc82i/0ft4w==
X-Google-Smtp-Source: AGHT+IGssoE7hQqBg/N5JbkjtBec11yjXOZDIx9mR4vfXI1H5ndkIzs/dQErwY530PlhjT1G82jsZ/AwIGzfKfKkfKA=
X-Received: by 2002:a05:6512:3b28:b0:500:7de4:300e with SMTP id
 f40-20020a0565123b2800b005007de4300emr1597917lfv.58.1696404778196; Wed, 04
 Oct 2023 00:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231002092051.555479-1-wenst@chromium.org> <CAC=S1ng3_z0H48awhum7unXTTk0yfn61pTWqSmPJ9fWdoURL=A@mail.gmail.com>
In-Reply-To: <CAC=S1ng3_z0H48awhum7unXTTk0yfn61pTWqSmPJ9fWdoURL=A@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 4 Oct 2023 15:32:47 +0800
Message-ID: <CAGXv+5Ex9ZN+MPZx0CyNaHf0h+DC2VLNH6Obs7Wt-nokU70MNg@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Correctly free sg_table in gem prime vmap
To:     Fei Shao <fshao@chromium.org>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 11:14=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote=
:
>
> Hi,
>
> On Mon, Oct 2, 2023 at 5:21=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
> >
> > The MediaTek DRM driver implements GEM PRIME vmap by fetching the
> > sg_table for the object, iterating through the pages, and then
> > vmapping them. In essence, unlike the GEM DMA helpers which vmap
> > when the object is first created or imported, the MediaTek version
> > does it on request.
> >
> > Unfortunately, the code never correctly frees the sg_table contents.
> > This results in a kernel memory leak. On a Hayato device with a text
> > console on the internal display, this results in the system running
> > out of memory in a few days from all the console screen cursor updates.
> >
> > Add sg_free_table() to correctly free the contents of the sg_table. Thi=
s
> > was missing despite explicitly required by mtk_gem_prime_get_sg_table()=
.
> >
> > Fixes: 3df64d7b0a4f ("drm/mediatek: Implement gem prime vmap/vunmap fun=
ction")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Please merge for v6.6 fixes.
> >
> > Also, I was wondering why the MediaTek DRM driver implements a lot of
> > the GEM functionality itself, instead of using the GEM DMA helpers.
> > From what I could tell, the code closely follows the DMA helpers, excep=
t
> > that it vmaps the buffers only upon request.
> >
> >
> >  drivers/gpu/drm/mediatek/mtk_drm_gem.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/m=
ediatek/mtk_drm_gem.c
> > index 9f364df52478..297ee090e02e 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> > @@ -239,6 +239,7 @@ int mtk_drm_gem_prime_vmap(struct drm_gem_object *o=
bj, struct iosys_map *map)
> >         npages =3D obj->size >> PAGE_SHIFT;
> >         mtk_gem->pages =3D kcalloc(npages, sizeof(*mtk_gem->pages), GFP=
_KERNEL);
> >         if (!mtk_gem->pages) {
> > +               sg_free_table(sgt);
> >                 kfree(sgt);
> >                 return -ENOMEM;
> >         }
> > @@ -248,11 +249,13 @@ int mtk_drm_gem_prime_vmap(struct drm_gem_object =
*obj, struct iosys_map *map)
> >         mtk_gem->kvaddr =3D vmap(mtk_gem->pages, npages, VM_MAP,
> >                                pgprot_writecombine(PAGE_KERNEL));
> >         if (!mtk_gem->kvaddr) {
> > +               sg_free_table(sgt);
> >                 kfree(sgt);
> >                 kfree(mtk_gem->pages);
> >                 return -ENOMEM;
> >         }
> >  out:
> > +       sg_free_table(sgt);
>
> I think this will cause invalid access from the "goto out" path -
> sg_free_table() accesses the provided sg table pointer, but it doesn't
> handle NULL pointers like kfree() does.

You're right. I'll send a new version fixing this.
