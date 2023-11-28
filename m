Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C9D7FB801
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344281AbjK1Kgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbjK1KgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:36:24 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E210335BB;
        Tue, 28 Nov 2023 02:31:12 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 42A93BB2;
        Tue, 28 Nov 2023 11:30:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701167436;
        bh=OXd6WFN+hXV6bAu/T8kro/U446h2pL6QGhhs60nEIi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rrlqwtw2gOQQrNMKVW//q6jy+QDsES4uivGL0gr+shfBzULUgf8EIPHup52837x6M
         lkjEvjo+r5i+ErgPYmnwxd9IEVaCbbtjkecd0f/jixfjw9p22lRsstRNb28SEuU2fe
         uiM/3GmHY9w/a0YXrbP6QkaEtxAR6gre/elYP32E=
Date:   Tue, 28 Nov 2023 12:31:17 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        hverkuil@xs4all.nl, mchehab@kernel.org, m.szyprowski@samsung.com,
        matt.ranostay@konsulko.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        kernel@collabora.com, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 07/55] media: imx8-isi: Stop abusing of
 min_buffers_needed field
Message-ID: <20231128103117.GF31314@pendragon.ideasonboard.com>
References: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
 <20231127165454.166373-8-benjamin.gaignard@collabora.com>
 <20231127170700.GC31314@pendragon.ideasonboard.com>
 <6fa1ec09-3e30-475e-9718-29d23586753e@collabora.com>
 <CAAFQd5DCVTLpPoKSp_OA6fe_Hqt-oV7=AsCZWSmkJORvLSgUiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAFQd5DCVTLpPoKSp_OA6fe_Hqt-oV7=AsCZWSmkJORvLSgUiw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 06:35:51PM +0900, Tomasz Figa wrote:
> On Tue, Nov 28, 2023 at 6:31 PM Benjamin Gaignard wrote:
> > Le 27/11/2023 à 18:07, Laurent Pinchart a écrit :
> > > Hi Benjamin,
> > >
> > > Thank you for the patch.
> > >
> > > On Mon, Nov 27, 2023 at 05:54:06PM +0100, Benjamin Gaignard wrote:
> > >> 'min_buffers_needed' is suppose to be used to indicate the number
> > >> of buffers needed by DMA engine to start streaming.
> > >> imx8-isi driver doesn't use DMA engine and just want to specify
> > > What do you mean, "doesn't use DMA engine" ? The ISI surely has DMA
> > > engines :-)
> >
> > I have done assumption on drivers given if they use or dma_* functions.
> 
> I suspect the use of vb2_dma_sg_plane_desc() and
> vb2_dma_contig_plane_dma_addr() may be more correlated to whether
> there is a DMA involved or not. Usually V4L2 drivers don't really have
> to deal with the DMA API explicitly, because the vb2 framework handles
> most of the work.

And this is anyway not related to DMA at all, but to the logic each
driver implements when it deals with buffers. There's a lower chance a
USB driver driver will have a hard requirement for more than one buffer
compared to an AMBA/platform/PCI device driver, but at the end of the
day, each driver needs to be analyzed individually to check what they
require. Benjamin, I think you'll have some more homework to do :-)

> > I have considers that all PCI drivers are using DMA engine and
> > I don't know the design for each drivers so I hope to get this information
> > from maintainers and fix that in v2.
> > If imx8-isi driver needs a minimum number of buffers before start streaming
> > I will do a v2 and use min_dma_buffers_needed instead.
> >
> > >> the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
> > >> That 'min_reqbufs_allocation' field purpose so use it.
> > >>
> > >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > >> CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > >> CC: Mauro Carvalho Chehab <mchehab@kernel.org>
> > >> CC: Shawn Guo <shawnguo@kernel.org>
> > >> CC: Sascha Hauer <s.hauer@pengutronix.de>
> > >> CC: Pengutronix Kernel Team <kernel@pengutronix.de>
> > >> CC: Fabio Estevam <festevam@gmail.com>
> > >> CC: NXP Linux Team <linux-imx@nxp.com>
> > >> ---
> > >>   drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c | 2 +-
> > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> > >> index 49bca2b01cc6..81673ff9084b 100644
> > >> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> > >> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> > >> @@ -1453,7 +1453,7 @@ int mxc_isi_video_register(struct mxc_isi_pipe *pipe,
> > >>      q->mem_ops = &vb2_dma_contig_memops;
> > >>      q->buf_struct_size = sizeof(struct mxc_isi_buffer);
> > >>      q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> > >> -    q->min_buffers_needed = 2;
> > >> +    q->min_reqbufs_allocation = 2;
> > >>      q->lock = &video->lock;
> > >>      q->dev = pipe->isi->dev;
> > >>

-- 
Regards,

Laurent Pinchart
