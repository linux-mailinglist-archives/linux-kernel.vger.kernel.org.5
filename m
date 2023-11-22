Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDD27F4775
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343965AbjKVNOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343619AbjKVNOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:14:53 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B358219E;
        Wed, 22 Nov 2023 05:14:49 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 89721276;
        Wed, 22 Nov 2023 14:14:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700658857;
        bh=I9y4sun9NeXdT7AZljuwRol7VPibB34QiqgjRQUZFpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=swIZNt/sv5KAV2KlMVIqUpuJ0ECH71R84iDO/VHU3YXKGBo8la459hrmNMnogg4GR
         bozwtL/zl6Qj4mBnM56gTPQN2VyVNl+BUuiCALRMniJLAcs1Rg1ws659YmjEryR2T8
         CIVoV+uo6kmBRm/+nsJ9ANBw7U06KqNasYIy+nB8=
Date:   Wed, 22 Nov 2023 15:14:55 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 3/3] media: uvcvideo: Lock video streams and queues
 while unregistering
Message-ID: <20231122131455.GC3909@pendragon.ideasonboard.com>
References: <20231121-guenter-mini-v3-0-d8a5eae2312b@chromium.org>
 <20231121-guenter-mini-v3-3-d8a5eae2312b@chromium.org>
 <ZV3WEDZ0EfdYrImE@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZV3WEDZ0EfdYrImE@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ing Dan Williams.

On Wed, Nov 22, 2023 at 10:21:04AM +0000, Sakari Ailus wrote:
> Hi Ricardo,
> 
> On Tue, Nov 21, 2023 at 07:53:50PM +0000, Ricardo Ribalda wrote:
> > From: Guenter Roeck <linux@roeck-us.net>
> > 
> > The call to uvc_disconnect() is not protected by any mutex.
> > This means it can and will be called while other accesses to the video
> > device are in progress. This can cause all kinds of race conditions,
> > including crashes such as the following.
> > 
> > usb 1-4: USB disconnect, device number 3
> > BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> > PGD 0 P4D 0
> > Oops: 0000 [#1] PREEMPT SMP PTI
> > CPU: 0 PID: 5633 Comm: V4L2CaptureThre Not tainted 4.19.113-08536-g5d29ca36db06 #1
> > Hardware name: GOOGLE Edgar, BIOS Google_Edgar.7287.167.156 03/25/2019
> > RIP: 0010:usb_ifnum_to_if+0x29/0x40
> > Code: <...>
> > RSP: 0018:ffffa46f42a47a80 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff904a396c9000
> > RDX: ffff904a39641320 RSI: 0000000000000001 RDI: 0000000000000000
> > RBP: ffffa46f42a47a80 R08: 0000000000000002 R09: 0000000000000000
> > R10: 0000000000009975 R11: 0000000000000009 R12: 0000000000000000
> > R13: ffff904a396b3800 R14: ffff904a39e88000 R15: 0000000000000000
> > FS: 00007f396448e700(0000) GS:ffff904a3ba00000(0000) knlGS:0000000000000000
> > CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000000 CR3: 000000016cb46000 CR4: 00000000001006f0
> > Call Trace:
> >  usb_hcd_alloc_bandwidth+0x1ee/0x30f
> >  usb_set_interface+0x1a3/0x2b7
> >  uvc_video_start_transfer+0x29b/0x4b8 [uvcvideo]
> >  uvc_video_start_streaming+0x91/0xdd [uvcvideo]
> >  uvc_start_streaming+0x28/0x5d [uvcvideo]
> >  vb2_start_streaming+0x61/0x143 [videobuf2_common]
> >  vb2_core_streamon+0xf7/0x10f [videobuf2_common]
> >  uvc_queue_streamon+0x2e/0x41 [uvcvideo]
> >  uvc_ioctl_streamon+0x42/0x5c [uvcvideo]
> >  __video_do_ioctl+0x33d/0x42a
> >  video_usercopy+0x34e/0x5ff
> >  ? video_ioctl2+0x16/0x16
> >  v4l2_ioctl+0x46/0x53
> >  do_vfs_ioctl+0x50a/0x76f
> >  ksys_ioctl+0x58/0x83
> >  __x64_sys_ioctl+0x1a/0x1e
> >  do_syscall_64+0x54/0xde
> > 
> > usb_set_interface() should not be called after the USB device has been
> > unregistered. However, in the above case the disconnect happened after
> > v4l2_ioctl() was called, but before the call to usb_ifnum_to_if().
> > 
> > Acquire various mutexes in uvc_unregister_video() to fix the majority
> > (maybe all) of the observed race conditions.
> > 
> > The uvc_device lock prevents races against suspend and resume calls
> > and the poll function.
> > 
> > The uvc_streaming lock prevents races against stream related functions;
> > for the most part, those are ioctls. This lock also requires other
> > functions using this lock to check if a video device is still registered
> > after acquiring it. For example, it was observed that the video device
> > was already unregistered by the time the stream lock was acquired in
> > uvc_ioctl_streamon().
> > 
> > The uvc_queue lock prevents races against queue functions, Most of
> > those are already protected by the uvc_streaming lock, but some
> > are called directly. This is done as added protection; an actual race
> > was not (yet) observed.
> > 
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > Reviewed-by: Sean Paul <seanpaul@chromium.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index 413c32867617..3408b865d346 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -1907,14 +1907,22 @@ static void uvc_unregister_video(struct uvc_device *dev)
> >  {
> >  	struct uvc_streaming *stream;
> >  
> > +	mutex_lock(&dev->lock);
> > +
> >  	list_for_each_entry(stream, &dev->streams, list) {
> >  		if (!video_is_registered(&stream->vdev))
> >  			continue;
> >  
> > +		mutex_lock(&stream->mutex);
> > +		mutex_lock(&stream->queue.mutex);
> > +
> >  		video_unregister_device(&stream->vdev);
> >  		video_unregister_device(&stream->meta.vdev);
> >  
> >  		uvc_debugfs_cleanup_stream(stream);
> > +
> > +		mutex_unlock(&stream->queue.mutex);
> > +		mutex_unlock(&stream->mutex);
> >  	}
> >  
> >  	uvc_status_unregister(dev);
> > @@ -1925,6 +1933,7 @@ static void uvc_unregister_video(struct uvc_device *dev)
> >  	if (media_devnode_is_registered(dev->mdev.devnode))
> >  		media_device_unregister(&dev->mdev);
> >  #endif
> > +	mutex_unlock(&dev->lock);
> >  }
> >  
> >  int uvc_register_video_device(struct uvc_device *dev,
> > 
> 
> Instead of acquiring all the possible locks, could you instead take the
> same approach as you do with ISP? It should use refcount_t btw.
> <URL:https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/kcam-6.1/drivers/isp/isp-device.c:

The right approach, as I've said countless of times, is to fix this at
the cdev and V4L2 level. Dan Williams has done some ground work on this
a while ago ([1]), and before that I posted an RFC series that
overlapped with Dan's work (with a more naive and less efficient
implementation of refcounting, see [2]).

[1] https://lore.kernel.org/all/161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com/
[2] https://lore.kernel.org/linux-media/20171116003349.19235-2-laurent.pinchart+renesas@ideasonboard.com/

-- 
Regards,

Laurent Pinchart
