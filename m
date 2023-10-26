Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D7A7D7AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjJZCh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJZChY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:37:24 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9613910A;
        Wed, 25 Oct 2023 19:37:20 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5b8f68ba4e5so376451a12.1;
        Wed, 25 Oct 2023 19:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698287840; x=1698892640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+/LYLyDdbkps/oxv4vLLfhE34izDmpgctZLGQjlrOU=;
        b=LnVHNherEob6mbFgxWHG35CRUalku9oJrHnFwANijraFbynH9RP9hMyFoHx4HQfPfd
         5FxJqa9EpINl1QIc1rjlkmvhD/yjsAyKtDUeDJ3HVu663POU4MhESOqdH0TC5v4ysPQu
         FYFQqcmSsRTIytnb7iRufo1cjLEMmnVwO4pv8re+MhC8om909AeaZj714aVh1vFb8HiY
         suktaswu3wpHJjTqJcOwGq+789NhP6GtaIxhq5GCzuQY85iykfU7iTDzprsovQmsUixQ
         tNS8hwSTJtjJtEdRD1wBnNMe+BluqcxumV4TLUV9RUcNKPICUiZ0SeNozH30lHb1VVBL
         SUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698287840; x=1698892640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+/LYLyDdbkps/oxv4vLLfhE34izDmpgctZLGQjlrOU=;
        b=DmUv9C+YLCblKlC1vaszGWK/w+bfew4JJreToSTOEQiwhZQp/8tnztqvJdbWL521wa
         EE7N/ciZ3zZhQ3JK6jeBlUQ8EyeoPwMierS1mYr6WUvucqxTCKMnotSGvgfeTc/GB/CH
         1UwmEro34Tz0xlSRzxS/ryRFWdwDZicTzYY5DH/BFc2kGSm86iu/376VRUbut81kjn38
         tQU9kac8O8l9FIit3PGOX+jeAGk1cxFqhHeLHyM5MVTU6jwA2UY+BtelaV8fvRQgX7Zc
         yjm9R5fSTfPLqA49mCu2kkzN2WCwzt85LavCQMwF2eWcMPq8ZmLQL3ZNaoNCu3kP5Z/d
         eQeQ==
X-Gm-Message-State: AOJu0YzZhJQmmGiOOlaoq2F9CRT1TNlq6fQdBvmNmehS00J3bjy89R/H
        9t4Ux7eCzVf2vnrA2HseiVUs/4bpn6zc4XZm62g=
X-Google-Smtp-Source: AGHT+IFV4x3BSS9K1oEjlHSvE2/RvYvw8fBgrj6u9+FX0gXhcriKZl+MxQEA3rcXPFkAVWIVdxgy2xECdKyXcpxRICs=
X-Received: by 2002:a17:90a:4f45:b0:27e:3880:d03d with SMTP id
 w5-20020a17090a4f4500b0027e3880d03dmr10065765pjl.7.1698287839741; Wed, 25 Oct
 2023 19:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231020040732.2499269-1-zyytlz.wz@163.com> <46f704c2-ba42-4e16-d798-ea2171e5ba16@collabora.com>
In-Reply-To: <46f704c2-ba42-4e16-d798-ea2171e5ba16@collabora.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 26 Oct 2023 10:37:06 +0800
Message-ID: <CAJedcCzE_EHqquj6iu-NgUpBkeF0XdUiDutsgOdCqqX814nkDg@mail.gmail.com>
Subject: Re: [PATCH] media: mtk-jpeg: Fix use after free bug due to error path
 handling in mtk_jpeg_dec_device_run
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, Kyrie.Wu@mediatek.com,
        bin.liu@mediatek.com, mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com, amergnat@baylibre.com, wenst@chromium.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get it. I'll figure it out how to split up.

Thanks,
Zheng

Dmitry Osipenko <dmitry.osipenko@collabora.com> =E4=BA=8E2023=E5=B9=B410=E6=
=9C=8824=E6=97=A5=E5=91=A8=E4=BA=8C 21:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On 10/20/23 07:07, Zheng Wang wrote:
> > In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> > mtk_jpeg_job_timeout_work.
> >
> > In mtk_jpeg_dec_device_run, if error happens in
> > mtk_jpeg_set_dec_dst, it will finally start the worker while
> > mark the job as finished by invoking v4l2_m2m_job_finish.
> >
> > There are two methods to trigger the bug. If we remove the
> > module, it which will call mtk_jpeg_remove to make cleanup.
> > The possible sequence is as follows, which will cause a
> > use-after-free bug.
> >
> > CPU0                  CPU1
> > mtk_jpeg_dec_...    |
> >   start worker            |
> >                     |mtk_jpeg_job_timeout_work
> > mtk_jpeg_remove     |
> >   v4l2_m2m_release  |
> >     kfree(m2m_dev); |
> >                     |
> >                     | v4l2_m2m_get_curr_priv
> >                     |   m2m_dev->curr_ctx //use
> >
> > If we close the file descriptor, which will call mtk_jpeg_release,
> > it will have a similar sequence.
> >
> > Fix this bug by start timeout worker only if started jpegdec worker
> > successfully so the v4l2_m2m_job_finish will only be called on
> > either mtk_jpeg_job_timeout_work or mtk_jpeg_dec_device_run.
> >
> > This patch also reverts commit c677d7ae8314
> > ("media: mtk-jpeg: Fix use after free bug due to uncanceled work")
> > for this patch also fixed the use-after-free bug mentioned before.
> > Before mtk_jpeg_remove is invoked, mtk_jpeg_release must be invoked
> > to close opened files. And it will call v4l2_m2m_cancel_job to wait
> > for the timeout worker finished so the canceling in mtk_jpeg_remove
> > is unnecessary.
> >
> > Fixes: b2f0d2724ba4 ("[media] vcodec: mediatek: Add Mediatek JPEG Decod=
er Driver")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  .../media/platform/mediatek/jpeg/mtk_jpeg_core.c    | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/dri=
vers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > index 7194f88edc0f..c3456c700c07 100644
> > --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > @@ -1021,13 +1021,13 @@ static void mtk_jpeg_dec_device_run(void *priv)
> >       if (ret < 0)
> >               goto dec_end;
> >
> > -     schedule_delayed_work(&jpeg->job_timeout_work,
> > -                           msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC))=
;
> > -
> >       mtk_jpeg_set_dec_src(ctx, &src_buf->vb2_buf, &bs);
> >       if (mtk_jpeg_set_dec_dst(ctx, &jpeg_src_buf->dec_param, &dst_buf-=
>vb2_buf, &fb))
> >               goto dec_end;
> >
> > +     schedule_delayed_work(&jpeg->job_timeout_work,
> > +                           msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC))=
;
> > +
> >       spin_lock_irqsave(&jpeg->hw_lock, flags);
> >       mtk_jpeg_dec_reset(jpeg->reg_base);
> >       mtk_jpeg_dec_set_config(jpeg->reg_base,
> > @@ -1403,7 +1403,6 @@ static void mtk_jpeg_remove(struct platform_devic=
e *pdev)
> >  {
> >       struct mtk_jpeg_dev *jpeg =3D platform_get_drvdata(pdev);
> >
> > -     cancel_delayed_work_sync(&jpeg->job_timeout_work);
> >       pm_runtime_disable(&pdev->dev);
> >       video_unregister_device(jpeg->vdev);
> >       v4l2_m2m_release(jpeg->m2m_dev);
> > @@ -1750,9 +1749,6 @@ static void mtk_jpegdec_worker(struct work_struct=
 *work)
> >       v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
> >       v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> >
> > -     schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
> > -                           msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC))=
;
> > -
> >       mtk_jpeg_set_dec_src(ctx, &src_buf->vb2_buf, &bs);
> >       if (mtk_jpeg_set_dec_dst(ctx,
> >                                &jpeg_src_buf->dec_param,
> > @@ -1762,6 +1758,9 @@ static void mtk_jpegdec_worker(struct work_struct=
 *work)
> >               goto setdst_end;
> >       }
> >
> > +     schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
> > +                           msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC))=
;
> > +
> >       spin_lock_irqsave(&comp_jpeg[hw_id]->hw_lock, flags);
> >       ctx->total_frame_num++;
> >       mtk_jpeg_dec_reset(comp_jpeg[hw_id]->reg_base);
>
> What about to split this patch into 3 patches:
>
> 1. will remove cancel_delayed_work_sync()
> 2. will update mtk_jpeg_dec_device_run()
> 3. will update mtk_jpegdec_worker()
>
> The reason for splitting is because the multi-core mtk_jpegdec_worker()
> doesn't present in older stable kernels, and thus, the patch isn't
> backportable as-is.
>
> --
> Best regards,
> Dmitry
>
