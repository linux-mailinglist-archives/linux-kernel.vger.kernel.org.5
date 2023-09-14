Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35AF79FF17
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbjINIzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbjINIyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:54:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3407B1BEF;
        Thu, 14 Sep 2023 01:54:47 -0700 (PDT)
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0243910A0;
        Thu, 14 Sep 2023 10:53:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694681592;
        bh=OH84/PBeWWziSquWHkX0+RoW9ezYH9hrzygtXuMSelA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=GHt+EvmHSnNOSEqSvcK7C0MtrcIdhTgMMZM5MN1WeTxIqMm6oWH98HC2RlplnB9jg
         uKIcbO4SjgWI85OGiu1tnjtvBNfak9JJx1zX/RMgptgdCvjgYiQM+jQFl4x+vdc1Zb
         egh3er3CZu2Ddc7UgSGUAmF1iWUifZJ+VJbhLgSU=
Date:   Thu, 14 Sep 2023 10:54:40 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarrah Gosbell <kernel@undef.tools>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH] media: ov5640: use pm_runtime_force_suspend/resume for
 system suspend
Message-ID: <pvbl7c34njy2bxeb3vjnvvoiaatrfc6jp53iidh2dfogor4h5x@geb7cigsran5>
References: <20230818173416.2467832-1-andrej.skvortzov@gmail.com>
 <ZQHU+LA+BEB7jzx1@valkosipuli.retiisi.eu>
 <ZQIgDb0usm768umH@skv.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZQIgDb0usm768umH@skv.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey

On Wed, Sep 13, 2023 at 11:48:13PM +0300, Andrey Skvortsov wrote:
> Hi Sakari,
>
> On 23-09-13 15:27, Sakari Ailus wrote:
> > Hi Andrey,
> >
> > On Fri, Aug 18, 2023 at 08:34:16PM +0300, Andrey Skvortsov wrote:
> > > If system was suspended while camera sensor was used, data and
> > > interrupts were still coming from sensor and that caused unstable
> > > system. Sometimes system hanged during a resume. Use
> > > pm_runtime_force_* helpers in order to support system suspend.
> > >
> > > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> >
> > Thanks for the patch.
> >
> > It's not been documented really how system suspend and resume should
> > work for complex cameras. But I don't think it can be done by drivers
> > separately as the CSI-2 bus initialisation requires actions from both
> > sender and receiver drivers, at particular points of time.
>
> Thanks for the review.
>
> I've tested this on PinePhone A64. It uses DVP, maybe because of that
> system suspend/resume worked good in my case.
> Originally I've implemented system suspend/resume similar to this [1]
> or [2] as I've seen this approach in other mainlined drivers. But some
> drivers reuse pm_runtime_force_* helpers, so I've went with this.
>
> Do you think it would be better to use something like [2] until there
> is better well defined way for system suspend/resume for complex cameras?
>

please don't :)
https://patchwork.linuxtv.org/project/linux-media/patch/20230913135638.26277-16-laurent.pinchart@ideasonboard.com/

However...

> >
> > So I think we'll need to initiate this from the driver handling DMA, just
> > as starting and stopping streaming. Even then, there needs to be a
> > certainty that the sensor device has resumed before streaming is started. I
> > recall Laurent suggested device links for that purpose, but I don't think
> > any work has been done to implement it that way.



.. as Sakari suggested, the driver handling the DMA should be in
charge of calling s_stream() on the sensor subdev in its
suspend/resume handlers. There's the risk the receiver resumes while
the sensor is still suspended, and at this time there's no solution in
mainline to handle this correctly.

Laurent/Sakari, how should this be handled for the time being ?

Laurent's patch for imx219 (and his forthcoming patch to remove the
same pattern from all sensor drivers in mainline) might be opening th
door for unexpected bugs as long as we don't enforce a resume/suspend
ordering ?

>
> 1. https://salsa.debian.org/Mobian-team/devices/kernels/sunxi64-linux/-/blob/mobian-6.1/debian/patches/camera/0076-media-gc2145-implement-system-suspend.patch
> 2. https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/imx219.c#L1159

Can we get a link to the receiver driver you're using in your kernel ?

Thanks
  j

>
> --
> Best regards,
> Andrey Skvortsov
