Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3420679CBC1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjILJ30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbjILJ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:29:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AE6BE;
        Tue, 12 Sep 2023 02:29:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27398378997so3834985a91.3;
        Tue, 12 Sep 2023 02:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694510957; x=1695115757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ju+ZWjiZ0TMy4CSEl3+l9giop0quoUuFFKF8EikprBA=;
        b=rCE8gpictBYQ0oHnLctrZdkvUiIy/5aujglrbrUpmoDoodNAGKQj8EkDT3zaxApTt9
         lCbmkmSsNPBt2kXdadIh40nVdjMzBtI6aLi/SF6AURNhCI163h/2rlf64gB9/UmdcMJu
         hx6AzzqKpvETRDK3wjQELwXuWBshYHa742V04k/aszDe5jZZHEZYfz1zL0iSlOxAPLjx
         NdV7p7aa4B7xRQIMbH35aR+FEAL+HMHVatV/yyjzPBcslIBr1hiQliQGDGpdhGYJealL
         djuf65NWKErSNBZT+h4aAMH1Djgls5GP5Kx0yFEiauEZaNdPQdB93rk+dFEmxEQHIn7E
         Zcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694510957; x=1695115757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ju+ZWjiZ0TMy4CSEl3+l9giop0quoUuFFKF8EikprBA=;
        b=iKtm/afmoF4EbAqPf47jUSSzUQf/6wYJlT8kG1qBI+4CkIq+A7v4/qTStXoMNWuP5k
         MzO/Y5pDHDBAmLRYlvufgsNyThGi0+7mnoqoMDR9/UhgPnlfHE1AlNV5JkHyZwy2pL4r
         GtOFiPKeHmM6arVqvW3zW362ki1/Ml7tnFa3FMJfKk98msHiYLm9l5Pi6uVujJuXEzNr
         coZqB0Da5GfFubTTb6106hxCuxIrwDtwTBlSRXfNs+WoI9zaimSlCbPB+vX5jAOsgIbf
         bvGWuJGfPK7FKlrJ1cP4dR+iWEqKXqxN0/OoYbiq47YwXjYsq/uybhf2X0IlVD+GVi2V
         AGPg==
X-Gm-Message-State: AOJu0YwV5OrUqmm+wKUvqk1mZ5ARM0JPGP7yQcqA6Ropec7634VxcfWC
        h8Yk+aiMwmaalO/MuGrRpw2CId007CJKsv0XELU=
X-Google-Smtp-Source: AGHT+IFfZiKYex8ecrWmlwPjEQFl+kocIsqxf8T4wAmdHxrw+aNuiuJIflnWoioqH4/+s97g/xmYh6ITsDvKC9pCxBs=
X-Received: by 2002:a17:90b:1c0b:b0:26d:49c8:78aa with SMTP id
 oc11-20020a17090b1c0b00b0026d49c878aamr10100752pjb.32.1694510957418; Tue, 12
 Sep 2023 02:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230707092414.866760-1-zyytlz.wz@163.com> <8c8bd3ec-a5a4-32e4-45b5-ee16eeeac246@collabora.com>
 <CAJedcCxPG1mKtgB7AcJSwaQB_qvODObwq3gz6eM_1w777b2PfQ@mail.gmail.com>
 <54b14ebe-b51b-2744-328d-2adcdaaf6d0e@collabora.com> <CAJedcCyn+VHxcSXH+HqP3yiXX8L0wjNao+suti5GgyQzYORcYA@mail.gmail.com>
 <CAJedcCw2A1hJ89g5W1u+XvP26gqaUeVFOYRw_tj7eWYNMPfXBQ@mail.gmail.com>
In-Reply-To: <CAJedcCw2A1hJ89g5W1u+XvP26gqaUeVFOYRw_tj7eWYNMPfXBQ@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 12 Sep 2023 17:29:06 +0800
Message-ID: <CAJedcCxeCoyswkgW5o4YNJA2siBzP4mbEaqNnK7ZUJQ5nUaWbw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, Kyrie.Wu@mediatek.com,
        bin.liu@mediatek.com, mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

The patch is on the stable queue. Could you please take a look at my
analysis? Thanks for your help.

Best regards,
Zheng

Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=885=
=E6=97=A5=E5=91=A8=E4=BA=8C 12:24=E5=86=99=E9=81=93=EF=BC=9A
>
> Friendly ping.
>
> Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=883=
1=E6=97=A5=E5=91=A8=E5=9B=9B 16:18=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Dmitry Osipenko <dmitry.osipenko@collabora.com> =E4=BA=8E2023=E5=B9=B48=
=E6=9C=8828=E6=97=A5=E5=91=A8=E4=B8=80 10:04=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On 8/24/23 11:20, Zheng Hacker wrote:
> > > > Dmitry Osipenko <dmitry.osipenko@collabora.com> =E4=BA=8E2023=E5=B9=
=B48=E6=9C=8823=E6=97=A5=E5=91=A8=E4=B8=89 02:51=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > >>
> > > >> Hello Zheng,
> > > >>
> > > >> On 7/7/23 12:24, Zheng Wang wrote:
> > > >>> In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> > > >>> mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
> > > >>> and mtk_jpeg_enc_device_run may be called to start the
> > > >>> work.
> > > >>> If we remove the module which will call mtk_jpeg_remove
> > > >>> to make cleanup, there may be a unfinished work. The
> > > >>> possible sequence is as follows, which will cause a
> > > >>> typical UAF bug.
> > > >>>
> > > >>> Fix it by canceling the work before cleanup in the mtk_jpeg_remov=
e
> > > >>>
> > > >>> CPU0                  CPU1
> > > >>>
> > > >>>                     |mtk_jpeg_job_timeout_work
> > > >>> mtk_jpeg_remove     |
> > > >>>   v4l2_m2m_release  |
> > > >>>     kfree(m2m_dev); |
> > > >>>                     |
> > > >>>                     | v4l2_m2m_get_curr_priv
> > > >>>                     |   m2m_dev->curr_ctx //use
> > > >>> Fixes: b2f0d2724ba4 ("[media] vcodec: mediatek: Add Mediatek JPEG=
 Decoder Driver")
> > > >>> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > > >>> ---
> > > >>> - v2: use cancel_delayed_work_sync instead of cancel_delayed_work=
 suggested by Kyrie.
> > > >>> ---
> > > >>>  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 1 +
> > > >>>  1 file changed, 1 insertion(+)
> > > >>>
> > > >>> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c=
 b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > > >>> index 0051f372a66c..6069ecf420b0 100644
> > > >>> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > > >>> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > > >>> @@ -1816,6 +1816,7 @@ static void mtk_jpeg_remove(struct platform=
_device *pdev)
> > > >>>  {
> > > >>>       struct mtk_jpeg_dev *jpeg =3D platform_get_drvdata(pdev);
> > > >>>
> > > >>> +     cancel_delayed_work_sync(&jpeg->job_timeout_work);
> > > >>>       pm_runtime_disable(&pdev->dev);
> > > >>>       video_unregister_device(jpeg->vdev);
> > > >>>       v4l2_m2m_release(jpeg->m2m_dev);
> > > >>
> > > >> AFAICS, there is a fundamental problem here. The job_timeout_work =
uses
> > > >> v4l2_m2m_get_curr_priv() and at the time when driver module is unl=
oaded,
> > > >> all the v4l contexts must be closed and released. Hence the
> > > >> v4l2_m2m_get_curr_priv() shall return NULL and crash the kernel wh=
en
> > > >> work is executed before cancel_delayed_work_sync().
> > > >>
> > > >
> > > > Hi Dmitry,
> > > >
> > > > Thanks for your reply. I think you're right. As m2m_dev is freed in
> > > > v4l2_m2m_release,
> > > > the invoking in v4l2_m2m_get_curr_priv might cause either UAF or nu=
ll
> > > > pointer dereference
> > > > bug. I am sure that context is closed when we invoke mtk_jpeg_remov=
e.
> > > > But I'm not sure if
> > > > context is released when mtk_jpegdec_timeout_work running.
> > > >
> > > >> At the time when mtk_jpeg_remove() is invoked, there shall be no
> > > >> job_timeout_work running in background because all jobs should be
> > > >> completed before context is released. If you'll look at
> > > >> v4l2_m2m_cancel_job(), you can see that it waits for the task comp=
letion
> > > >> before closing context.
> > > >
> > > > Yes, so I think the better way is to put the cancel_delayed_work_sy=
nc
> > > > invoking into
> > > > v4l2_m2m_ctx_release function?
> > >
> > > The v4l2_m2m_ctx_release() already should wait for the job_timeout_wo=
rk
> > > completion or for the interrupt fire. Apparently it doesn't work in
> > > yours case. You'll need to debug why v4l job or job_timeout_work is
> > > running after v4l2_m2m_ctx_release(), it shouldn't happen.
> > >
> >
> > Yes, v4l2_m2m_cancel_job waits for m2m_ctx->job_flags to be  ~TRANS_RUN=
NING,
> > the mtk_jpeg_job_timeout_work will finally invoke v4l2_m2m_job_finish
> > to trigger that.
> >
> > However, this is not the only path to call v4l2_m2m_job_finish. Here
> > is a invoking chain:
> > v4l_streamon
> >   ->v4l2_m2m_ioctl_streamon
> >     ->v4l2_m2m_streamon
> >       ->v4l2_m2m_try_schedule
> >         ->v4l2_m2m_try_run
> >           ->mtk_jpeg_dec_device_run
> >             ->schedule_delayed_work(&jpeg->job_timeout_work...
> >             ->error path goto dec_end
> >             ->v4l2_m2m_job_finish
> >
> > In some specific situation, it starts the worker and also calls
> > v4l2_m2m_job_finish, which might
> > make v4l2_m2m_cancel_job continues.
> >
> > > The interrupt handler cancels job_timeout_work, you shouldn't need to
> > > flush the work.
> >
> > It will, but as I said, there might be an early invocation chain to
> > start the work.(Not very sure)
> >
> > >
> > > Technically, interrupt handler may race with job_timeout_work, but th=
e
> > > timeout is set to 1 second and in practice should be difficult to
> > > trigger the race. The interrupt handler needs to be threaded, it shou=
ld
> > > use cancel_delayed_work_sync() and check the return value of this fun=
ction.
> > >
> >
> > Yes, it's better to use cancel_delayed_work_sync here.
> >
> > > >>
> > > >> You shouldn't be able to remove driver module while it has active/=
opened
> > > >> v4l contexts. If you can do that, then this is yours bug that need=
s to
> > > >> be fixed.
> > > >>
> > > >> In addition to this all, the job_timeout_work is initialized only =
for
> > > >> the single-core JPEG device. I'd expect this patch should crash
> > > >> multi-core JPEG devices.
> > > >>
> > > >
> > > > I think that's true. As I'm not familiar with the code here. Could =
you
> > > > please give me some advice about the patch?
> > >
> > > We'll need to understand why v4l2_m2m_ctx_release() doesn't work as
> > > expected before thinking about the patch.
> > >
> > > --
> > > Best regards,
> > > Dmitry
> > >
