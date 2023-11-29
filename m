Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027BA7FCDE7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 05:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376892AbjK2EZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 23:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjK2EZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 23:25:36 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE35C10E7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 20:25:40 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54b0310f536so946858a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 20:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701231939; x=1701836739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZzuVjJtlnAafrGnIlhuyzTMjINdeQbe2IGSLVE2qCI=;
        b=SldNVqehB3u/7rwu/Zl3mGdxyFW6LcP14mq+S7/3PqVBJ8r+AE+nLmeHGmSlHuEA/U
         fUda3JadQu75PvGkcZ9iYCUfYlugjYaOKrR7cAY+vhFTDkWWbw1zFTLaJS/bAWor7qHB
         xoZ+DhKpadZRKJvF+29SGOARf36QOceWwKpQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701231939; x=1701836739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZzuVjJtlnAafrGnIlhuyzTMjINdeQbe2IGSLVE2qCI=;
        b=J/Fxm1r16ahKlXI7m67bI9+Vx8wjv+IsvYX4hyOy1lRNz8i9QaMK85zlf6uePjPkF4
         mEhiy3H64y3QBYN9WJXlQtsPz3eJCHTdT8Fk3kR7LL/EzHzE/zcfE9H4yTyrWY0qADJT
         EuvieRIGqzSEfa6lq9aQR9BWT7I5kz1fW4lVvW0mdcXRlrMJY7yCTbqqrOJM0hMWpvey
         TN2/x78KXdul5fwGTnAUB2FLzjG93VzX8NNZvF6U+oy2bk+jtA3NbPdjWZnz5xPmfIuj
         1G9qd2mNvRsu1XUYLL3exFi6QxrTpoRYYMforZXDhymM3QeRid+HhNJ6PghtCKyyBpZy
         ZctQ==
X-Gm-Message-State: AOJu0YxtET+DJ1mksmLDYE3YFnYve3wEMdjvBJSOIXofxGlsDL9gp8i8
        of270z9hF1snIzxMkQdd4MQ4b1Q6c8I1H6ah5aW36NCZ
X-Google-Smtp-Source: AGHT+IGoPi/083p+2DzllFMlYKbUeTW7P0d0PeZ0VQh7gL2L1TCqXO/Qo8PSnMtyvmLlPgNC3WqKHw==
X-Received: by 2002:aa7:c045:0:b0:54b:5007:9a12 with SMTP id k5-20020aa7c045000000b0054b50079a12mr8060851edo.10.1701231939264;
        Tue, 28 Nov 2023 20:25:39 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id b9-20020a056402350900b0054b7e312b97sm2351592edd.38.2023.11.28.20.25.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 20:25:39 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a0064353af8so96000166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 20:25:39 -0800 (PST)
X-Received: by 2002:adf:f10d:0:b0:332:cae1:dd5 with SMTP id
 r13-20020adff10d000000b00332cae10dd5mr13790346wro.34.1701231450791; Tue, 28
 Nov 2023 20:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
 <20231127165454.166373-8-benjamin.gaignard@collabora.com> <20231127170700.GC31314@pendragon.ideasonboard.com>
 <6fa1ec09-3e30-475e-9718-29d23586753e@collabora.com> <CAAFQd5DCVTLpPoKSp_OA6fe_Hqt-oV7=AsCZWSmkJORvLSgUiw@mail.gmail.com>
 <995eb6c2-cc7f-4217-bc37-4ab1a32f36ee@collabora.com>
In-Reply-To: <995eb6c2-cc7f-4217-bc37-4ab1a32f36ee@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 29 Nov 2023 13:17:09 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Bv5kc9TfNM5CkKowvaoRndTmkmU6+0LyCG8YbOKy=hxQ@mail.gmail.com>
Message-ID: <CAAFQd5Bv5kc9TfNM5CkKowvaoRndTmkmU6+0LyCG8YbOKy=hxQ@mail.gmail.com>
Subject: Re: [PATCH 07/55] media: imx8-isi: Stop abusing of min_buffers_needed field
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        hverkuil@xs4all.nl, mchehab@kernel.org, m.szyprowski@samsung.com,
        matt.ranostay@konsulko.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        kernel@collabora.com, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 7:26=E2=80=AFPM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
>
> Le 28/11/2023 =C3=A0 10:35, Tomasz Figa a =C3=A9crit :
> > On Tue, Nov 28, 2023 at 6:31=E2=80=AFPM Benjamin Gaignard
> > <benjamin.gaignard@collabora.com> wrote:
> >>
> >> Le 27/11/2023 =C3=A0 18:07, Laurent Pinchart a =C3=A9crit :
> >>> Hi Benjamin,
> >>>
> >>> Thank you for the patch.
> >>>
> >>> On Mon, Nov 27, 2023 at 05:54:06PM +0100, Benjamin Gaignard wrote:
> >>>> 'min_buffers_needed' is suppose to be used to indicate the number
> >>>> of buffers needed by DMA engine to start streaming.
> >>>> imx8-isi driver doesn't use DMA engine and just want to specify
> >>> What do you mean, "doesn't use DMA engine" ? The ISI surely has DMA
> >>> engines :-)
> >> I have done assumption on drivers given if they use or dma_* functions=
.
> > I suspect the use of vb2_dma_sg_plane_desc() and
> > vb2_dma_contig_plane_dma_addr() may be more correlated to whether
> > there is a DMA involved or not. Usually V4L2 drivers don't really have
> > to deal with the DMA API explicitly, because the vb2 framework handles
> > most of the work.
>
> Unfortunately isn't not true either, for example verisilicon driver use
> these function but doesn't need DMA engine.

That sounds weird. Why would a driver that doesn't have a DMA engine
need to obtain a scatterlist or the DMA address of the buffer?

> I haven't found yet a 100% criteria to decide if driver use or not DMA en=
gine
> so I plan to fix case by case given maintainers remarks.

Yeah, there probably wouldn't be a way that would give one a 100%
certainty, although I'd still insist that the two functions I
mentioned should be close to that. Of course a driver can use those
functions for some queues, while other queues would be pure software
queues, e.g. for some metadata - a simple grep is not enough. Is that
perhaps the case for the verisilicon driver?

Best regards,
Tomasz

>
> Regards,
> Benjamin
>
> >
> > Best regards,
> > Tomasz
> >
> >> I have considers that all PCI drivers are using DMA engine and
> >> I don't know the design for each drivers so I hope to get this informa=
tion
> >> from maintainers and fix that in v2.
> >> If imx8-isi driver needs a minimum number of buffers before start stre=
aming
> >> I will do a v2 and use min_dma_buffers_needed instead.
> >>
> >> Regards,
> >> Benjamin
> >>
> >>>> the minimum number of buffers to allocate when calling VIDIOC_REQBUF=
S.
> >>>> That 'min_reqbufs_allocation' field purpose so use it.
> >>>>
> >>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >>>> CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>> CC: Mauro Carvalho Chehab <mchehab@kernel.org>
> >>>> CC: Shawn Guo <shawnguo@kernel.org>
> >>>> CC: Sascha Hauer <s.hauer@pengutronix.de>
> >>>> CC: Pengutronix Kernel Team <kernel@pengutronix.de>
> >>>> CC: Fabio Estevam <festevam@gmail.com>
> >>>> CC: NXP Linux Team <linux-imx@nxp.com>
> >>>> ---
> >>>>    drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c b/=
drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> >>>> index 49bca2b01cc6..81673ff9084b 100644
> >>>> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> >>>> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> >>>> @@ -1453,7 +1453,7 @@ int mxc_isi_video_register(struct mxc_isi_pipe=
 *pipe,
> >>>>       q->mem_ops =3D &vb2_dma_contig_memops;
> >>>>       q->buf_struct_size =3D sizeof(struct mxc_isi_buffer);
> >>>>       q->timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> >>>> -    q->min_buffers_needed =3D 2;
> >>>> +    q->min_reqbufs_allocation =3D 2;
> >>>>       q->lock =3D &video->lock;
> >>>>       q->dev =3D pipe->isi->dev;
> >>>>
