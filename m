Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169777A00F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbjINJzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbjINJzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:55:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BF083;
        Thu, 14 Sep 2023 02:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694685331; x=1726221331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Fu99T9/XDJUIk7rTU/0AQiev26FduZXA7d84BlqrDA=;
  b=UCnN+yUwkknq/C/WCPmYEcPiZ6+0dB9T/elWiQjMndu4jkQ/RiWFLE7x
   8bcETK2Rq0dr/tmCotIzhBmQA2tW7xlar3Vr9QUInnPN5lyjRcQ20ULUU
   Bu+/ZRsUoKTYbq1Cn+c24/09DG68MPi1NuGO8DHWpCV7a5QFzamIeXMkW
   DhEMy93Vj77kzUUt+gYHSMol6/3AEOCqxsiUk9TrZRU5rDXKAXZPOHqLc
   HjFHx33+mnVtTY348mVFq4Wwyx+CI5Do/TwaPOv4E5YHWXd/ZkLgoXu5P
   p3xYXpsDgCdKBxLUT5k01PNKio4/taVssyvnxgmYGPE5j6kBA96Nma12u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="409860996"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="409860996"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 02:55:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="834696678"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="834696678"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 02:55:28 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 6F4AF11FB8E;
        Thu, 14 Sep 2023 12:55:25 +0300 (EEST)
Date:   Thu, 14 Sep 2023 09:55:25 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarrah Gosbell <kernel@undef.tools>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH] media: ov5640: use pm_runtime_force_suspend/resume for
 system suspend
Message-ID: <ZQLYjTkWrW6m1E2r@kekkonen.localdomain>
References: <20230818173416.2467832-1-andrej.skvortzov@gmail.com>
 <ZQHU+LA+BEB7jzx1@valkosipuli.retiisi.eu>
 <ZQIgDb0usm768umH@skv.local>
 <pvbl7c34njy2bxeb3vjnvvoiaatrfc6jp53iidh2dfogor4h5x@geb7cigsran5>
 <20230914090241.GA2504@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914090241.GA2504@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Thu, Sep 14, 2023 at 12:02:41PM +0300, Laurent Pinchart wrote:
> On Thu, Sep 14, 2023 at 10:54:40AM +0200, Jacopo Mondi wrote:
> > On Wed, Sep 13, 2023 at 11:48:13PM +0300, Andrey Skvortsov wrote:
> > > On 23-09-13 15:27, Sakari Ailus wrote:
> > > > On Fri, Aug 18, 2023 at 08:34:16PM +0300, Andrey Skvortsov wrote:
> > > > > If system was suspended while camera sensor was used, data and
> > > > > interrupts were still coming from sensor and that caused unstable
> > > > > system. Sometimes system hanged during a resume. Use
> > > > > pm_runtime_force_* helpers in order to support system suspend.
> > > > >
> > > > > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > > >
> > > > Thanks for the patch.
> > > >
> > > > It's not been documented really how system suspend and resume should
> > > > work for complex cameras. But I don't think it can be done by drivers
> > > > separately as the CSI-2 bus initialisation requires actions from both
> > > > sender and receiver drivers, at particular points of time.
> > >
> > > Thanks for the review.
> > >
> > > I've tested this on PinePhone A64. It uses DVP, maybe because of that
> > > system suspend/resume worked good in my case.
> > > Originally I've implemented system suspend/resume similar to this [1]
> > > or [2] as I've seen this approach in other mainlined drivers. But some
> > > drivers reuse pm_runtime_force_* helpers, so I've went with this.
> > >
> > > Do you think it would be better to use something like [2] until there
> > > is better well defined way for system suspend/resume for complex cameras?
> > >
> > 
> > please don't :)
> > https://patchwork.linuxtv.org/project/linux-media/patch/20230913135638.26277-16-laurent.pinchart@ideasonboard.com/
> > 
> > However...
> > 
> > > > So I think we'll need to initiate this from the driver handling DMA, just
> > > > as starting and stopping streaming. Even then, there needs to be a
> > > > certainty that the sensor device has resumed before streaming is started. I
> > > > recall Laurent suggested device links for that purpose, but I don't think
> > > > any work has been done to implement it that way.
> > 
> > .. as Sakari suggested, the driver handling the DMA should be in
> > charge of calling s_stream() on the sensor subdev in its
> > suspend/resume handlers. There's the risk the receiver resumes while
> > the sensor is still suspended, and at this time there's no solution in
> > mainline to handle this correctly.
> > 
> > Laurent/Sakari, how should this be handled for the time being ?
> 
> device_link() should handle this. See mxc_isi_async_notifier_bound() in
> drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c.
> 
> It would be nice if this could be done in the V4L2 core. I haven't
> checked if that's possible.

I can't see why it wouldn't be, and it seems easy, too. We're still early
in the cycle so if someone writes the patches, I can't see why we couldn't
get them for 6.7.

-- 
Regards,

Sakari Ailus
