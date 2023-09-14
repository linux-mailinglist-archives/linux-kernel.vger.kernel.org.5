Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CBC79FF68
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbjINJDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbjINJCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:02:54 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E64C1BF1;
        Thu, 14 Sep 2023 02:02:29 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2DCF12CF;
        Thu, 14 Sep 2023 11:00:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694682055;
        bh=ZSJzooOMl8o+UASvefvCSAyN9by/gcSLf34MmpDlkOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sRgWdbuxCqCfmaEXP0Wbi/MjJfDdjiaIJ6JrR+j3Fdan+E3YvXDF+1+7tdS6bbRSh
         jvuRtKEZsgVG8KQyyB36+OvBN5Vo0Xqs1SM6ao9T9HHSJ6xtlbVazYSW436gAE9A3E
         qIboFCnK8987DMfYzOQo9kHaVjNXETJ4J1oxcj+I=
Date:   Thu, 14 Sep 2023 12:02:41 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarrah Gosbell <kernel@undef.tools>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH] media: ov5640: use pm_runtime_force_suspend/resume for
 system suspend
Message-ID: <20230914090241.GA2504@pendragon.ideasonboard.com>
References: <20230818173416.2467832-1-andrej.skvortzov@gmail.com>
 <ZQHU+LA+BEB7jzx1@valkosipuli.retiisi.eu>
 <ZQIgDb0usm768umH@skv.local>
 <pvbl7c34njy2bxeb3vjnvvoiaatrfc6jp53iidh2dfogor4h5x@geb7cigsran5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pvbl7c34njy2bxeb3vjnvvoiaatrfc6jp53iidh2dfogor4h5x@geb7cigsran5>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:54:40AM +0200, Jacopo Mondi wrote:
> On Wed, Sep 13, 2023 at 11:48:13PM +0300, Andrey Skvortsov wrote:
> > On 23-09-13 15:27, Sakari Ailus wrote:
> > > On Fri, Aug 18, 2023 at 08:34:16PM +0300, Andrey Skvortsov wrote:
> > > > If system was suspended while camera sensor was used, data and
> > > > interrupts were still coming from sensor and that caused unstable
> > > > system. Sometimes system hanged during a resume. Use
> > > > pm_runtime_force_* helpers in order to support system suspend.
> > > >
> > > > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > >
> > > Thanks for the patch.
> > >
> > > It's not been documented really how system suspend and resume should
> > > work for complex cameras. But I don't think it can be done by drivers
> > > separately as the CSI-2 bus initialisation requires actions from both
> > > sender and receiver drivers, at particular points of time.
> >
> > Thanks for the review.
> >
> > I've tested this on PinePhone A64. It uses DVP, maybe because of that
> > system suspend/resume worked good in my case.
> > Originally I've implemented system suspend/resume similar to this [1]
> > or [2] as I've seen this approach in other mainlined drivers. But some
> > drivers reuse pm_runtime_force_* helpers, so I've went with this.
> >
> > Do you think it would be better to use something like [2] until there
> > is better well defined way for system suspend/resume for complex cameras?
> >
> 
> please don't :)
> https://patchwork.linuxtv.org/project/linux-media/patch/20230913135638.26277-16-laurent.pinchart@ideasonboard.com/
> 
> However...
> 
> > > So I think we'll need to initiate this from the driver handling DMA, just
> > > as starting and stopping streaming. Even then, there needs to be a
> > > certainty that the sensor device has resumed before streaming is started. I
> > > recall Laurent suggested device links for that purpose, but I don't think
> > > any work has been done to implement it that way.
> 
> .. as Sakari suggested, the driver handling the DMA should be in
> charge of calling s_stream() on the sensor subdev in its
> suspend/resume handlers. There's the risk the receiver resumes while
> the sensor is still suspended, and at this time there's no solution in
> mainline to handle this correctly.
> 
> Laurent/Sakari, how should this be handled for the time being ?

device_link() should handle this. See mxc_isi_async_notifier_bound() in
drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c.

It would be nice if this could be done in the V4L2 core. I haven't
checked if that's possible.

> Laurent's patch for imx219 (and his forthcoming patch to remove the
> same pattern from all sensor drivers in mainline) might be opening th
> door for unexpected bugs as long as we don't enforce a resume/suspend
> ordering ?

I'd argue that the bugs are there already, at least for CSI-2 sensors
the use a continuous clock. If you resume streaming on the sensor first,
the clock lane will switch to HS mode before the receiver gets resumed,
and the receiver won't be able to synchronize.

System suspend/resume tends to be badly tested in camera sensor drivers,
so lots of bugs creep in :-(

> > 1. https://salsa.debian.org/Mobian-team/devices/kernels/sunxi64-linux/-/blob/mobian-6.1/debian/patches/camera/0076-media-gc2145-implement-system-suspend.patch
> > 2. https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/imx219.c#L1159
> 
> Can we get a link to the receiver driver you're using in your kernel ?

-- 
Regards,

Laurent Pinchart
