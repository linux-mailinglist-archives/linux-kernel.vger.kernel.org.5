Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C600C7DC653
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbjJaGNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbjJaGN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:13:26 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D82C183;
        Mon, 30 Oct 2023 23:13:24 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b2e44c7941so3643677b6e.2;
        Mon, 30 Oct 2023 23:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698732803; x=1699337603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnsBwc25XTCfMAo0+GI5roZ5GuLTSammQf7P8YSq7yM=;
        b=hgxBa98JlaXFcN+0XX3f8evRH6M/3T1boCKIw/x+zNzesPxRa4y2m7mtE27CT95vge
         oZjjUERKpTfCrI/r9LjOdksYvyiTt3D1/Iokrvre23eo/rds6SJ1dfde+A9IMYwqtGe/
         3EG+1oOyd+mbLRauZo5ln9XJHwpyYE8SAe7C+dy32Pt6eOygR+Xj4XLmksiMmK5mNAj5
         lP4zrGleSqh8B6d/6uspB0hNftfyCQYRemxGNolY3t3AbcDeeu84c+YxlzI7hzKDnwd8
         Bzn3fRyDtKItQuhXA9EOo/n8I5TXmgrxPZK2EqZvw0fXWpy7qA5aA/lxbeoLHIJdV0GF
         +Zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698732803; x=1699337603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnsBwc25XTCfMAo0+GI5roZ5GuLTSammQf7P8YSq7yM=;
        b=rBqa/7OJ1UxZGnEVWaoLK25zaU/+28WhAlGu37wswiLjRd0KbYUZaiPawILGLRPo+6
         zToFaufyQqpmg5aqWIxVmytDUSvTisi1tisVtyydrVtZGHBJzOBxWh/nJUpus5l6c+b3
         FUZNHYqFeExL8MXP2leo8wImuM3urTBX2yQxtOWk04lnXNuVoMTWDKm+Pqo5CiJX9thv
         olnKGZVptTOGu/LysxgCaKs9vbuAmAtSLfOv2EikNp2etqz9DjNOio6WSv000FnUFFQ2
         CsfZwMDM65HU+43ucW8bdlDGC56HTmabvA4GlxredSlzbdmNqlhkxKCkEXGp6ayZpT+z
         Vtqw==
X-Gm-Message-State: AOJu0YxzoAv2VcSmkdzZAeHiTV3+HL2aa2DaVQPd0tZ6oQ3HUQqVeKMB
        zMLrvUbBCpRDtPT4mS31LAi9bhLkNKsB9kPEx2o=
X-Google-Smtp-Source: AGHT+IGrBfSiOw0QxtPs9SYLozH9F2oFeT55K/phAH35aMIB94/vCdunurZiNZtPmzlnc4j34JJOR+ygl9/qPDF1z/E=
X-Received: by 2002:a05:6808:646:b0:3b2:d8c8:7bfa with SMTP id
 z6-20020a056808064600b003b2d8c87bfamr13000899oih.8.1698732803133; Mon, 30 Oct
 2023 23:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231027091612.38896-1-zyytlz.wz@163.com> <b9407b5d-3dba-3e7d-139b-075728b8346c@collabora.com>
In-Reply-To: <b9407b5d-3dba-3e7d-139b-075728b8346c@collabora.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 31 Oct 2023 14:13:12 +0800
Message-ID: <CAJedcCz3CwJ8meXmv-1tgOHZ-6zHAmSwX7sPO1X9oyKv=oPyNQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] media: mtk-jpeg: Remove cancel worker in
 mtk_jpeg_remove to avoid the crash of multi-core JPEG devices
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, Kyrie.Wu@mediatek.com,
        bin.liu@mediatek.com, mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com, amergnat@baylibre.com, wenst@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Osipenko <dmitry.osipenko@collabora.com> =E4=BA=8E2023=E5=B9=B410=E6=
=9C=8831=E6=97=A5=E5=91=A8=E4=BA=8C 13:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On 10/27/23 12:16, Zheng Wang wrote:
> > This patch reverts commit c677d7ae8314
> > ("media: mtk-jpeg: Fix use after free bug due to uncanceled work").
> > The job_timeout_work is initialized only for
> > the single-core JPEG device so it will cause the crash for multi-core
> > JPEG devices.
> >
> > Fix it by removing the cancel_delayed_work_sync function.
> >
> > Fixes: c677d7ae8314 ("media: mtk-jpeg: Fix use after free bug due to un=
canceled work")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > ---
> >  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/dri=
vers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > index 7194f88edc0f..60425c99a2b8 100644
> > --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > @@ -1403,7 +1403,6 @@ static void mtk_jpeg_remove(struct platform_devic=
e *pdev)
> >  {
> >       struct mtk_jpeg_dev *jpeg =3D platform_get_drvdata(pdev);
> >
> > -     cancel_delayed_work_sync(&jpeg->job_timeout_work);
> >       pm_runtime_disable(&pdev->dev);
> >       video_unregister_device(jpeg->vdev);
> >       v4l2_m2m_release(jpeg->m2m_dev);
>
> Please send all three patches as a single series and version it with v2.
> Add cover letter with changelog.
>
> # git format-patch --cover-letter -v2 -3
>

Thanks for your kind reminder. Will do right now.

Best regards,
Zheng Wang

> --
> Best regards,
> Dmitry
>
