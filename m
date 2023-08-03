Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C7976F5B8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjHCW16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjHCW1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:27:53 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151811716;
        Thu,  3 Aug 2023 15:27:51 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EB9CB12E4;
        Fri,  4 Aug 2023 00:26:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691101605;
        bh=wFXxvJpEphqHGKum0ptI+ZQjqc1SV5g0mm8WDNA5Hi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hhxA63LnguVhTmUlF8NuguU42d1LxGEQPTr1uZ9mGRpjrZuK0/Wv0vJwF4CjpkHnL
         AqWSPiFRwATxcYdD/Q7g1Gd5IuedfSiJq/0al6PbKuzIJjfErCUTIhgQUjDOQyGxOW
         dqB0Dc2mgHVgTYDDqlSy28p9siPC3HAlp2T7Tjcg=
Date:   Fri, 4 Aug 2023 01:27:55 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/2] media: video-mux: update driver to active state
Message-ID: <20230803222755.GG9722@pendragon.ideasonboard.com>
References: <20230524-video-mux-active-state-v1-0-325c69937ac3@pengutronix.de>
 <20230524-video-mux-active-state-v1-2-325c69937ac3@pengutronix.de>
 <wy4tvjl7tsfkbb6q544omgbzyk7xb746znyuos3nezrychq64b@zitkjug7hd3s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <wy4tvjl7tsfkbb6q544omgbzyk7xb746znyuos3nezrychq64b@zitkjug7hd3s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 03:15:33PM +0200, Jacopo Mondi wrote:
> Hello
> 
> On Wed, May 24, 2023 at 03:29:25PM +0200, Philipp Zabel wrote:
> > Drop the open coded pad format array, use subdev active state instead.
> >
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> I get a WARN with this patch applied when testing iMX6Q with OV5640
> 
> 
>  media-ctl --links ''\''imx6-mipi-csi2'\'':1->'\''ipu1_csi0_mux'\'':0[1]'
> [   85.377504]
> [   85.379019] ======================================================
> [   85.385208] WARNING: possible circular locking dependency detected
> [   85.391397] 6.4.0-rc5-00109-gd716bd480968 #2 Not tainted
> [   85.396719] ------------------------------------------------------
> [   85.402905] media-ctl/199 is trying to acquire lock:
> [   85.407879] c397d6b8 (video_mux:448:sd->active_state->lock){+.+.}-{3:3}, at: video_mux_link_setup+0xac/0x260
> [   85.417770]
> [   85.417770] but task is already holding lock:
> [   85.423609] c2fcb780 (&vmux->lock){+.+.}-{3:3}, at: video_mux_link_setup+0x48/0x260
> [   85.431305]
> [   85.431305] which lock already depends on the new lock.
> [   85.431305]
> [   85.439489]
> [   85.439489] the existing dependency chain (in reverse order) is:
> [   85.446978]
> [   85.446978] -> #1 (&vmux->lock){+.+.}-{3:3}:
> [   85.452754]        __mutex_lock+0x84/0x8c4
> [   85.456875]        mutex_lock_nested+0x1c/0x24
> [   85.461336]        video_mux_init_cfg+0x1c/0xe0
> [   85.465883]        __v4l2_subdev_state_alloc+0xbc/0x138
> [   85.471135]        __v4l2_subdev_init_finalize+0xc/0x20
> [   85.476379]        video_mux_probe+0x190/0x320
> [   85.480838]        platform_probe+0x58/0xb0
> [   85.485036]        really_probe+0xd8/0x3fc
> [   85.489152]        __driver_probe_device+0x94/0x1f0
> [   85.494047]        driver_probe_device+0x2c/0xc4
> [   85.498679]        __device_attach_driver+0xa4/0x11c
> [   85.503663]        bus_for_each_drv+0x84/0xdc
> [   85.508036]        __device_attach+0xa8/0x1dc
> [   85.512409]        bus_probe_device+0x8c/0x90
> [   85.516782]        deferred_probe_work_func+0x88/0xd4
> [   85.521850]        process_one_work+0x2a4/0x6a0
> [   85.526399]        worker_thread+0x28/0x4ac
> [   85.530596]        kthread+0xf4/0x114
> [   85.534272]        ret_from_fork+0x14/0x28
> [   85.538382]
> [   85.538382] -> #0 (video_mux:448:sd->active_state->lock){+.+.}-{3:3}:
> [   85.546328]        __lock_acquire+0x14b8/0x28e8
> [   85.550873]        lock_acquire.part.0+0xb4/0x250
> [   85.555591]        __mutex_lock+0x84/0x8c4
> [   85.559704]        mutex_lock_nested+0x1c/0x24
> [   85.564163]        video_mux_link_setup+0xac/0x260
> [   85.568969]        __media_entity_setup_link+0x14c/0x1b4
> [   85.574305]        media_device_ioctl+0x158/0x190
> [   85.579027]        sys_ioctl+0x4a8/0xee8
> [   85.582971]        ret_fast_syscall+0x0/0x1c
> [   85.587253]
> [   85.587253] other info that might help us debug this:
> [   85.587253]
> [   85.595263]  Possible unsafe locking scenario:
> [   85.595263]
> [   85.601186]        CPU0                    CPU1
> [   85.605722]        ----                    ----
> [   85.610258]   lock(&vmux->lock);
> [   85.613501]                                lock(video_mux:448:sd->active_state->lock);
> [   85.621434]                                lock(&vmux->lock);
> [   85.627195]   lock(video_mux:448:sd->active_state->lock);
> [   85.632609]
> [   85.632609]  *** DEADLOCK ***
> [   85.632609]
> [   85.638535] 2 locks held by media-ctl/199:
> [   85.642640]  #0: c3856174 (&mdev->graph_mutex){+.+.}-{3:3}, at: media_device_ioctl+0x148/0x190
> [   85.651299]  #1: c2fcb780 (&vmux->lock){+.+.}-{3:3}, at: video_mux_link_setup+0x48/0x260
> [   85.659434]
> [   85.659434] stack backtrace:
> [   85.663800] CPU: 1 PID: 199 Comm: media-ctl Not tainted 6.4.0-rc5-00109-gd716bd480968 #2
> [   85.671904] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   85.678445]  unwind_backtrace from show_stack+0x10/0x14
> [   85.683700]  show_stack from dump_stack_lvl+0x60/0x90
> [   85.688769]  dump_stack_lvl from check_noncircular+0xf4/0x164
> [   85.694547]  check_noncircular from __lock_acquire+0x14b8/0x28e8
> [   85.700576]  __lock_acquire from lock_acquire.part.0+0xb4/0x250
> [   85.706510]  lock_acquire.part.0 from __mutex_lock+0x84/0x8c4
> [   85.712279]  __mutex_lock from mutex_lock_nested+0x1c/0x24
> [   85.717791]  mutex_lock_nested from video_mux_link_setup+0xac/0x260
> [   85.724085]  video_mux_link_setup from __media_entity_setup_link+0x14c/0x1b4
> [   85.731164]  __media_entity_setup_link from media_device_ioctl+0x158/0x190
> [   85.738063]  media_device_ioctl from sys_ioctl+0x4a8/0xee8
> [   85.743577]  sys_ioctl from ret_fast_syscall+0x0/0x1c
> [   85.748649] Exception stack(0xe0f41fa8 to 0xe0f41ff0)
> [   85.753716] 1fa0:                   00e233b8 00000079 00000003 c0347c03 bef629d0 00000001
> [   85.761908] 1fc0: 00e233b8 00000079 00e21150 00000036 bef629d0 00e23230 00000001 00000000
> [   85.770096] 1fe0: 004d9f5c bef629cc 004c37c8 b6e79f4c
> 
> Please note that in my tree I have reverted
> "media: v4l2-async: Use endpoints in __v4l2_async_nf_add_fwnode_remote()"
> 
> to have the imx6 media graph to probe correctly, but I presume this is
> not related to the error here above.

It looks like we should drop the lock in the video_mux structure, and
rely on the active state lock to protect the vmux->active field in
video_mux_link_setup() by calling
v4l2_subdev_lock_and_get_active_state() earlier.

On a side note, it would be really nice if we could use the new routing
API to configure routing in the mux, instead of relying on link setup,
but that would break the userspace API :-( Maybe we could deprecate the
existing video-mux driver and create a new one for new platforms (or
just add a new compatible string to select which API to expose) ?

> > ---
> >  drivers/media/platform/video-mux.c | 78 ++++++++++++--------------------------
> >  1 file changed, 24 insertions(+), 54 deletions(-)
> >
> > diff --git a/drivers/media/platform/video-mux.c b/drivers/media/platform/video-mux.c
> > index 4fe31386afc7..6d273abfe16c 100644
> > --- a/drivers/media/platform/video-mux.c
> > +++ b/drivers/media/platform/video-mux.c
> > @@ -24,7 +24,6 @@ struct video_mux {
> >  	struct v4l2_subdev subdev;
> >  	struct v4l2_async_notifier notifier;
> >  	struct media_pad *pads;
> > -	struct v4l2_mbus_framefmt *format_mbus;
> >  	struct mux_control *mux;
> >  	struct mutex lock;
> >  	int active;
> > @@ -71,6 +70,9 @@ static int video_mux_link_setup(struct media_entity *entity,
> >  	mutex_lock(&vmux->lock);
> >
> >  	if (flags & MEDIA_LNK_FL_ENABLED) {
> > +		struct v4l2_subdev_state *sd_state;
> > +		struct v4l2_mbus_framefmt *source_mbusformat;
> > +
> >  		if (vmux->active == local->index)
> >  			goto out;
> >
> > @@ -86,7 +88,12 @@ static int video_mux_link_setup(struct media_entity *entity,
> >  		vmux->active = local->index;
> >
> >  		/* Propagate the active format to the source */
> > -		vmux->format_mbus[source_pad] = vmux->format_mbus[vmux->active];
> > +		sd_state = v4l2_subdev_lock_and_get_active_state(sd);
> > +		source_mbusformat = v4l2_subdev_get_pad_format(sd, sd_state,
> > +							       source_pad);
> > +		*source_mbusformat = *v4l2_subdev_get_pad_format(sd, sd_state,
> > +								 vmux->active);
> > +		v4l2_subdev_unlock_state(sd_state);
> >  	} else {
> >  		if (vmux->active != local->index)
> >  			goto out;
> > @@ -138,40 +145,6 @@ static const struct v4l2_subdev_video_ops video_mux_subdev_video_ops = {
> >  	.s_stream = video_mux_s_stream,
> >  };
> >
> > -static struct v4l2_mbus_framefmt *
> > -__video_mux_get_pad_format(struct v4l2_subdev *sd,
> > -			   struct v4l2_subdev_state *sd_state,
> > -			   unsigned int pad, u32 which)
> > -{
> > -	struct video_mux *vmux = v4l2_subdev_to_video_mux(sd);
> > -
> > -	switch (which) {
> > -	case V4L2_SUBDEV_FORMAT_TRY:
> > -		return v4l2_subdev_get_try_format(sd, sd_state, pad);
> > -	case V4L2_SUBDEV_FORMAT_ACTIVE:
> > -		return &vmux->format_mbus[pad];
> > -	default:
> > -		return NULL;
> > -	}
> > -}
> > -
> > -static int video_mux_get_format(struct v4l2_subdev *sd,
> > -			    struct v4l2_subdev_state *sd_state,
> > -			    struct v4l2_subdev_format *sdformat)
> > -{
> > -	struct video_mux *vmux = v4l2_subdev_to_video_mux(sd);
> > -
> > -	mutex_lock(&vmux->lock);
> > -
> > -	sdformat->format = *__video_mux_get_pad_format(sd, sd_state,
> > -						       sdformat->pad,
> > -						       sdformat->which);
> > -
> > -	mutex_unlock(&vmux->lock);
> > -
> > -	return 0;
> > -}
> > -
> >  static int video_mux_set_format(struct v4l2_subdev *sd,
> >  			    struct v4l2_subdev_state *sd_state,
> >  			    struct v4l2_subdev_format *sdformat)
> > @@ -181,14 +154,11 @@ static int video_mux_set_format(struct v4l2_subdev *sd,
> >  	struct media_pad *pad = &vmux->pads[sdformat->pad];
> >  	u16 source_pad = sd->entity.num_pads - 1;
> >
> > -	mbusformat = __video_mux_get_pad_format(sd, sd_state, sdformat->pad,
> > -						sdformat->which);
> > +	mbusformat = v4l2_subdev_get_pad_format(sd, sd_state, sdformat->pad);
> >  	if (!mbusformat)
> >  		return -EINVAL;
> >
> > -	source_mbusformat = __video_mux_get_pad_format(sd, sd_state,
> > -						       source_pad,
> > -						       sdformat->which);
> > +	source_mbusformat = v4l2_subdev_get_pad_format(sd, sd_state, source_pad);
> >  	if (!source_mbusformat)
> >  		return -EINVAL;
> >
> > @@ -298,7 +268,8 @@ static int video_mux_set_format(struct v4l2_subdev *sd,
> >
> >  	/* Source pad mirrors active sink pad, no limitations on sink pads */
> >  	if ((pad->flags & MEDIA_PAD_FL_SOURCE) && vmux->active >= 0)
> > -		sdformat->format = vmux->format_mbus[vmux->active];
> > +		sdformat->format = *v4l2_subdev_get_pad_format(sd, sd_state,
> > +							       vmux->active);
> >
> >  	*mbusformat = sdformat->format;
> >
> > @@ -321,7 +292,7 @@ static int video_mux_init_cfg(struct v4l2_subdev *sd,
> >  	mutex_lock(&vmux->lock);
> >
> >  	for (i = 0; i < sd->entity.num_pads; i++) {
> > -		mbusformat = v4l2_subdev_get_try_format(sd, sd_state, i);
> > +		mbusformat = v4l2_subdev_get_pad_format(sd, sd_state, i);
> >  		*mbusformat = video_mux_format_mbus_default;
> >  	}
> >
> > @@ -332,7 +303,7 @@ static int video_mux_init_cfg(struct v4l2_subdev *sd,
> >
> >  static const struct v4l2_subdev_pad_ops video_mux_pad_ops = {
> >  	.init_cfg = video_mux_init_cfg,
> > -	.get_fmt = video_mux_get_format,
> > +	.get_fmt = v4l2_subdev_get_fmt,
> >  	.set_fmt = video_mux_set_format,
> >  };
> >
> > @@ -462,17 +433,9 @@ static int video_mux_probe(struct platform_device *pdev)
> >  	if (!vmux->pads)
> >  		return -ENOMEM;
> >
> > -	vmux->format_mbus = devm_kcalloc(dev, num_pads,
> > -					 sizeof(*vmux->format_mbus),
> > -					 GFP_KERNEL);
> > -	if (!vmux->format_mbus)
> > -		return -ENOMEM;
> > -
> > -	for (i = 0; i < num_pads; i++) {
> > +	for (i = 0; i < num_pads; i++)
> >  		vmux->pads[i].flags = (i < num_pads - 1) ? MEDIA_PAD_FL_SINK
> >  							 : MEDIA_PAD_FL_SOURCE;
> > -		vmux->format_mbus[i] = video_mux_format_mbus_default;
> > -	}
> >
> >  	vmux->subdev.entity.function = MEDIA_ENT_F_VID_MUX;
> >  	ret = media_entity_pads_init(&vmux->subdev.entity, num_pads,
> > @@ -482,12 +445,18 @@ static int video_mux_probe(struct platform_device *pdev)
> >
> >  	vmux->subdev.entity.ops = &video_mux_ops;
> >
> > +	ret = v4l2_subdev_init_finalize(&vmux->subdev);
> > +	if (ret < 0)
> > +		goto err_entity_cleanup;
> > +
> >  	ret = video_mux_async_register(vmux, num_pads - 1);
> >  	if (ret)
> > -		goto err_entity_cleanup;
> > +		goto err_subdev_cleanup;
> >
> >  	return 0;
> >
> > +err_subdev_cleanup:
> > +	v4l2_subdev_cleanup(&vmux->subdev);
> >  err_entity_cleanup:
> >  	media_entity_cleanup(&vmux->subdev.entity);
> >  	return ret;
> > @@ -501,6 +470,7 @@ static void video_mux_remove(struct platform_device *pdev)
> >  	v4l2_async_nf_unregister(&vmux->notifier);
> >  	v4l2_async_nf_cleanup(&vmux->notifier);
> >  	v4l2_async_unregister_subdev(sd);
> > +	v4l2_subdev_cleanup(sd);
> >  	media_entity_cleanup(&sd->entity);
> >  }

-- 
Regards,

Laurent Pinchart
