Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3297FB5F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343805AbjK1JgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343751AbjK1JgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:36:08 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64506D41
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:36:14 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a00b056ca38so696088566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701164172; x=1701768972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gn4UB1lK5iWfBPlsVj0cmidPsZvNY1ecgwO2dUiuTUo=;
        b=KDh3+BdHyKsVGepfyaAiW45JL3m3G+bitGeBQTFkjxh00xRKuBZDsqWvymSNQ/8hQQ
         yV56ZuoQo/hW3ltN4Fnu/bibHDM6XTj8IgJ8F8Ge0xcu8rNd5+3GIRYgVfQU7Hcc1Xp4
         FdCWp351Egv2hYaCOnvadSjqWjTfGvspI6Gcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701164172; x=1701768972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gn4UB1lK5iWfBPlsVj0cmidPsZvNY1ecgwO2dUiuTUo=;
        b=L9KIX/pPJSWH3XXR8rG+Pwr/mG9vtYe3oribKtWa38/pCUyuJVS0CPPDlp9vJg9BVQ
         XXQjw0uUq5wByPSMtfkSHWDqz5y6aqVBOGH5lZK0PjVcGTesWNPOOX4p6N4stxediZZy
         rtkva2RR/x6N0ZqMdavFv+n3LfUe+1WGrPxa5UwPM77qAlB9xIT3H9ajvdttE1qglEQM
         LvWO8xla4X5+ZK3eOVbMcA1BItwagPoyEQS4AC9wLFJLs4hDNxT1hoqsrUf/8uAcMJ+a
         rGo+ozSR9HWy4cJ4t/dyGymFtN+fJtFsjMUyLmvT+d6tU3knXxIeJljk0tvxFV3lbxTc
         jvYw==
X-Gm-Message-State: AOJu0YztRZlsxO+Rm0vACLVao/+g/oM1NPSw97VeAYpn4BKJYXI99l5g
        k1QtTedpWpr7tF7k3ghZHRxEXzCsYzs0BF78eqpAKAbl
X-Google-Smtp-Source: AGHT+IFRcfiR2SHV7E4Q8Iq7W2sme6tHg5yhy6oz58I5o1NReKy/DGij0WMuAA5HdykNq/JG1gdhig==
X-Received: by 2002:a17:906:6c8:b0:9c5:cfa3:d04d with SMTP id v8-20020a17090606c800b009c5cfa3d04dmr9164564ejb.52.1701164171891;
        Tue, 28 Nov 2023 01:36:11 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id hz19-20020a1709072cf300b009a168ab6ee2sm6569326ejc.164.2023.11.28.01.36.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 01:36:11 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-332c46d5988so3280407f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:36:11 -0800 (PST)
X-Received: by 2002:adf:fcc8:0:b0:32d:a495:a9b7 with SMTP id
 f8-20020adffcc8000000b0032da495a9b7mr9105847wrs.61.1701164171112; Tue, 28 Nov
 2023 01:36:11 -0800 (PST)
MIME-Version: 1.0
References: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
 <20231127165454.166373-8-benjamin.gaignard@collabora.com> <20231127170700.GC31314@pendragon.ideasonboard.com>
 <6fa1ec09-3e30-475e-9718-29d23586753e@collabora.com>
In-Reply-To: <6fa1ec09-3e30-475e-9718-29d23586753e@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 28 Nov 2023 18:35:51 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DCVTLpPoKSp_OA6fe_Hqt-oV7=AsCZWSmkJORvLSgUiw@mail.gmail.com>
Message-ID: <CAAFQd5DCVTLpPoKSp_OA6fe_Hqt-oV7=AsCZWSmkJORvLSgUiw@mail.gmail.com>
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

On Tue, Nov 28, 2023 at 6:31=E2=80=AFPM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
>
> Le 27/11/2023 =C3=A0 18:07, Laurent Pinchart a =C3=A9crit :
> > Hi Benjamin,
> >
> > Thank you for the patch.
> >
> > On Mon, Nov 27, 2023 at 05:54:06PM +0100, Benjamin Gaignard wrote:
> >> 'min_buffers_needed' is suppose to be used to indicate the number
> >> of buffers needed by DMA engine to start streaming.
> >> imx8-isi driver doesn't use DMA engine and just want to specify
> > What do you mean, "doesn't use DMA engine" ? The ISI surely has DMA
> > engines :-)
>
> I have done assumption on drivers given if they use or dma_* functions.

I suspect the use of vb2_dma_sg_plane_desc() and
vb2_dma_contig_plane_dma_addr() may be more correlated to whether
there is a DMA involved or not. Usually V4L2 drivers don't really have
to deal with the DMA API explicitly, because the vb2 framework handles
most of the work.

Best regards,
Tomasz

> I have considers that all PCI drivers are using DMA engine and
> I don't know the design for each drivers so I hope to get this informatio=
n
> from maintainers and fix that in v2.
> If imx8-isi driver needs a minimum number of buffers before start streami=
ng
> I will do a v2 and use min_dma_buffers_needed instead.
>
> Regards,
> Benjamin
>
> >
> >> the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
> >> That 'min_reqbufs_allocation' field purpose so use it.
> >>
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >> CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >> CC: Mauro Carvalho Chehab <mchehab@kernel.org>
> >> CC: Shawn Guo <shawnguo@kernel.org>
> >> CC: Sascha Hauer <s.hauer@pengutronix.de>
> >> CC: Pengutronix Kernel Team <kernel@pengutronix.de>
> >> CC: Fabio Estevam <festevam@gmail.com>
> >> CC: NXP Linux Team <linux-imx@nxp.com>
> >> ---
> >>   drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c b/dr=
ivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> >> index 49bca2b01cc6..81673ff9084b 100644
> >> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> >> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> >> @@ -1453,7 +1453,7 @@ int mxc_isi_video_register(struct mxc_isi_pipe *=
pipe,
> >>      q->mem_ops =3D &vb2_dma_contig_memops;
> >>      q->buf_struct_size =3D sizeof(struct mxc_isi_buffer);
> >>      q->timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> >> -    q->min_buffers_needed =3D 2;
> >> +    q->min_reqbufs_allocation =3D 2;
> >>      q->lock =3D &video->lock;
> >>      q->dev =3D pipe->isi->dev;
> >>
