Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0F6808FFD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjLGSdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjLGSdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:33:38 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D4D170D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:33:41 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4239f5c1ec2so7660711cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 10:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1701974020; x=1702578820; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GZWhK495VLeN7TNOf6swobaME2YnrmvMGk89MvaYBHI=;
        b=AJyY+UurD2VyzWSnIyramL1wrfCzPSmNBHI+QAzXXvOPvucYNpbhreZo8Irf6rWwW7
         /mAIhUo6ZJ/G6Dk5OwiTEzXtEJ4ZjzORjilsErCoJ88VsZbj/pX0Fs1/i5QjQfDkKvbq
         CdWxWXOZ/BNoLK9K5uez7XJLVSg1ea3Mc7WfmHCJjypfE3xsTQlBFDEcfJmIEu1iSOqM
         ShZQPG9+5iHzFqnF5bcZZPTQEXZNBzrAxdth7yqvyKE1NMJsShR1zCsdreeGbl82TIAj
         BAIAqbHdAVFQKSxmCleOhhHPl1qWYZymd5cHXo/k8nlxIQTViGczkxX+peucwFG+Ew3R
         jugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701974020; x=1702578820;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GZWhK495VLeN7TNOf6swobaME2YnrmvMGk89MvaYBHI=;
        b=dLjVdnw4bkLw4CVyrLp9BaWpES0IdJn/a7NxvHPiiaHiud0baDTXB9iZNLZ3l7/ihr
         O7oZTiRZbF9UVuvhHTGUeWIGtyAdvpuocF7KTe1TrPGpQEwnzLgap1sGdBFdQUyXa7VX
         PQztJqi1/9UxXTFNxrGlfeY5XSF40VAq5BBePfjbBPGmgs5UWZcrlf8u2SaeN+ZFwTZu
         OyzvXNMsnw21q1isjIpxX0+WiPiq2ubkHuxkxpihvqAeQoxtt8NX/zjW/QfJ8+FsLfrj
         1Cp6zK1q585/6Q7eLuDGsuIUGSixIciehghfKRMev1Tzq1nBvLUATbpmCnvWJSTJNV4s
         QmKA==
X-Gm-Message-State: AOJu0YwiXCUuINWpY3hoqm7w23T/KZKe1Cczh+Zt7ovFC2zZnE/1inQw
        J2bvkj/OCXV8X29n04g7qev7MA==
X-Google-Smtp-Source: AGHT+IF44G4vo91Pehf9E6Xdpq+8M9mRAYJujL+Kh9cNIlF92TI6vHzDWOvzVRMCx1+2PXWbmtxP1Q==
X-Received: by 2002:ac8:570b:0:b0:425:4043:41c7 with SMTP id 11-20020ac8570b000000b00425404341c7mr3133948qtw.115.1701974020565;
        Thu, 07 Dec 2023 10:33:40 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:17:b5c::7a9])
        by smtp.gmail.com with ESMTPSA id j15-20020ac8664f000000b004255e0e5962sm131926qtp.50.2023.12.07.10.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 10:33:40 -0800 (PST)
Message-ID: <3ab3f9ea25d222c0b27e1b76f80c1abe76d27def.camel@ndufresne.ca>
Subject: Re: [PATCH 07/55] media: imx8-isi: Stop abusing of
 min_buffers_needed field
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        hverkuil@xs4all.nl, mchehab@kernel.org, m.szyprowski@samsung.com,
        matt.ranostay@konsulko.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        kernel@collabora.com, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Date:   Thu, 07 Dec 2023 13:33:38 -0500
In-Reply-To: <20231128103117.GF31314@pendragon.ideasonboard.com>
References: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
         <20231127165454.166373-8-benjamin.gaignard@collabora.com>
         <20231127170700.GC31314@pendragon.ideasonboard.com>
         <6fa1ec09-3e30-475e-9718-29d23586753e@collabora.com>
         <CAAFQd5DCVTLpPoKSp_OA6fe_Hqt-oV7=AsCZWSmkJORvLSgUiw@mail.gmail.com>
         <20231128103117.GF31314@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 28 novembre 2023 =C3=A0 12:31 +0200, Laurent Pinchart a =C3=A9crit=
=C2=A0:
> On Tue, Nov 28, 2023 at 06:35:51PM +0900, Tomasz Figa wrote:
> > On Tue, Nov 28, 2023 at 6:31=E2=80=AFPM Benjamin Gaignard wrote:
> > > Le 27/11/2023 =C3=A0 18:07, Laurent Pinchart a =C3=A9crit :
> > > > Hi Benjamin,
> > > >=20
> > > > Thank you for the patch.
> > > >=20
> > > > On Mon, Nov 27, 2023 at 05:54:06PM +0100, Benjamin Gaignard wrote:
> > > > > 'min_buffers_needed' is suppose to be used to indicate the number
> > > > > of buffers needed by DMA engine to start streaming.
> > > > > imx8-isi driver doesn't use DMA engine and just want to specify
> > > > What do you mean, "doesn't use DMA engine" ? The ISI surely has DMA
> > > > engines :-)
> > >=20
> > > I have done assumption on drivers given if they use or dma_* function=
s.
> >=20
> > I suspect the use of vb2_dma_sg_plane_desc() and
> > vb2_dma_contig_plane_dma_addr() may be more correlated to whether
> > there is a DMA involved or not. Usually V4L2 drivers don't really have
> > to deal with the DMA API explicitly, because the vb2 framework handles
> > most of the work.
>=20
> And this is anyway not related to DMA at all, but to the logic each
> driver implements when it deals with buffers. There's a lower chance a
> USB driver driver will have a hard requirement for more than one buffer
> compared to an AMBA/platform/PCI device driver, but at the end of the
> day, each driver needs to be analyzed individually to check what they
> require. Benjamin, I think you'll have some more homework to do :-)

Personally, I disagree that we should blindly patch drivers and actually ch=
ange
the framework behaviour. A patch that simply take what we have, and make it=
 so a
human reader now understand what is going on should be acceptable. Maintain=
ers
or developer that have access to the hardware should be making this judgmen=
t now
that the current behaviour is visible, modify and test it.

Asking to eye review drivers and change their behaviour without any test be=
ing
conducted will certainly cause regressions. I don't believe this is the rig=
ht
approach. Refactoring the code, making an effort to not change the behaviou=
r
during refactoring does make more sense to me.

regards,
Nicolas

>=20
> > > I have considers that all PCI drivers are using DMA engine and
> > > I don't know the design for each drivers so I hope to get this inform=
ation
> > > from maintainers and fix that in v2.
> > > If imx8-isi driver needs a minimum number of buffers before start str=
eaming
> > > I will do a v2 and use min_dma_buffers_needed instead.
> > >=20
> > > > > the minimum number of buffers to allocate when calling VIDIOC_REQ=
BUFS.
> > > > > That 'min_reqbufs_allocation' field purpose so use it.
> > > > >=20
> > > > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com=
>
> > > > > CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > > CC: Mauro Carvalho Chehab <mchehab@kernel.org>
> > > > > CC: Shawn Guo <shawnguo@kernel.org>
> > > > > CC: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > CC: Pengutronix Kernel Team <kernel@pengutronix.de>
> > > > > CC: Fabio Estevam <festevam@gmail.com>
> > > > > CC: NXP Linux Team <linux-imx@nxp.com>
> > > > > ---
> > > > >   drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c | 2 +-
> > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c=
 b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> > > > > index 49bca2b01cc6..81673ff9084b 100644
> > > > > --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> > > > > +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> > > > > @@ -1453,7 +1453,7 @@ int mxc_isi_video_register(struct mxc_isi_p=
ipe *pipe,
> > > > >      q->mem_ops =3D &vb2_dma_contig_memops;
> > > > >      q->buf_struct_size =3D sizeof(struct mxc_isi_buffer);
> > > > >      q->timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> > > > > -    q->min_buffers_needed =3D 2;
> > > > > +    q->min_reqbufs_allocation =3D 2;
> > > > >      q->lock =3D &video->lock;
> > > > >      q->dev =3D pipe->isi->dev;
> > > > >=20
>=20

