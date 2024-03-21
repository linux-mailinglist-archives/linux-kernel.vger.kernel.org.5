Return-Path: <linux-kernel+bounces-110278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E514885C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C021C21A00
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD0786263;
	Thu, 21 Mar 2024 15:47:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A360723778;
	Thu, 21 Mar 2024 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036027; cv=none; b=MKZNQXRtCB6ChqsCZOv7tVj3GdWEX2XBoZEfdlAoGybVSOOgNZ+taEIS/BlxSs4e14+GEAuSOivo+px8hytsZUhz9xE8uE4g1KS45Ru5Zk4/ZSOz37lPMbyDFh4WTK5HGNQmwPYGG6f8DLhTKpMlqmxOu+fqeIrVkIbg+2Ko+NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036027; c=relaxed/simple;
	bh=thSvwB8rR3BM2oBG9DuRpKkR95kWQmdAazTxYk9K/a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmTr6xREPn5W0ciPF2w2T5nfTU0IU7jI/HSZKBET3QQvriCwQ7CkvEiSCoad4sGqLEFVF2+viXzaEj3BrrD1tmZdcmBICWoH16+D8Ejl2ncWQOpWvKMk0pJUZIR08XrQ/B8tXZi2G4wYzucJ3aXcH+RIZpDfgRHIKaqXSOfqnhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E823FC433C7;
	Thu, 21 Mar 2024 15:47:04 +0000 (UTC)
Message-ID: <e4b2fc02-977f-4eb6-be7a-a4493a5a3931@xs4all.nl>
Date: Thu, 21 Mar 2024 16:47:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] media: uvcvideo: Lock video streams and queues
 while unregistering
Content-Language: en-US, nl
To: Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Tomasz Figa <tfiga@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Alan Stern <stern@rowland.harvard.edu>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20231122-guenter-mini-v5-0-15d8cd8ed74f@chromium.org>
 <20231122-guenter-mini-v5-1-15d8cd8ed74f@chromium.org>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231122-guenter-mini-v5-1-15d8cd8ed74f@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 22/11/2023 12:45 pm, Ricardo Ribalda wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> The call to uvc_disconnect() is not protected by any mutex.
> This means it can and will be called while other accesses to the video
> device are in progress. This can cause all kinds of race conditions,
> including crashes such as the following.
> 
> usb 1-4: USB disconnect, device number 3
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 0 PID: 5633 Comm: V4L2CaptureThre Not tainted 4.19.113-08536-g5d29ca36db06 #1
> Hardware name: GOOGLE Edgar, BIOS Google_Edgar.7287.167.156 03/25/2019
> RIP: 0010:usb_ifnum_to_if+0x29/0x40
> Code: <...>
> RSP: 0018:ffffa46f42a47a80 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff904a396c9000
> RDX: ffff904a39641320 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffffa46f42a47a80 R08: 0000000000000002 R09: 0000000000000000
> R10: 0000000000009975 R11: 0000000000000009 R12: 0000000000000000
> R13: ffff904a396b3800 R14: ffff904a39e88000 R15: 0000000000000000
> FS: 00007f396448e700(0000) GS:ffff904a3ba00000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000016cb46000 CR4: 00000000001006f0
> Call Trace:
>  usb_hcd_alloc_bandwidth+0x1ee/0x30f
>  usb_set_interface+0x1a3/0x2b7
>  uvc_video_start_transfer+0x29b/0x4b8 [uvcvideo]
>  uvc_video_start_streaming+0x91/0xdd [uvcvideo]
>  uvc_start_streaming+0x28/0x5d [uvcvideo]
>  vb2_start_streaming+0x61/0x143 [videobuf2_common]
>  vb2_core_streamon+0xf7/0x10f [videobuf2_common]
>  uvc_queue_streamon+0x2e/0x41 [uvcvideo]
>  uvc_ioctl_streamon+0x42/0x5c [uvcvideo]
>  __video_do_ioctl+0x33d/0x42a
>  video_usercopy+0x34e/0x5ff
>  ? video_ioctl2+0x16/0x16
>  v4l2_ioctl+0x46/0x53
>  do_vfs_ioctl+0x50a/0x76f
>  ksys_ioctl+0x58/0x83
>  __x64_sys_ioctl+0x1a/0x1e
>  do_syscall_64+0x54/0xde
> 
> usb_set_interface() should not be called after the USB device has been
> unregistered. However, in the above case the disconnect happened after
> v4l2_ioctl() was called, but before the call to usb_ifnum_to_if().
> 
> Acquire various mutexes in uvc_unregister_video() to fix the majority
> (maybe all) of the observed race conditions.
> 
> The uvc_device lock prevents races against suspend and resume calls
> and the poll function.
> 
> The uvc_streaming lock prevents races against stream related functions;
> for the most part, those are ioctls. This lock also requires other
> functions using this lock to check if a video device is still registered
> after acquiring it. For example, it was observed that the video device
> was already unregistered by the time the stream lock was acquired in
> uvc_ioctl_streamon().
> 
> The uvc_queue lock prevents races against queue functions, Most of
> those are already protected by the uvc_streaming lock, but some
> are called directly. This is done as added protection; an actual race
> was not (yet) observed.
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 08fcd2ffa727..ded2cb6ce14f 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1907,14 +1907,22 @@ static void uvc_unregister_video(struct uvc_device *dev)
>  {
>  	struct uvc_streaming *stream;
>  
> +	mutex_lock(&dev->lock);
> +
>  	list_for_each_entry(stream, &dev->streams, list) {
>  		if (!video_is_registered(&stream->vdev))
>  			continue;
>  
> +		mutex_lock(&stream->mutex);
> +		mutex_lock(&stream->queue.mutex);
> +
>  		video_unregister_device(&stream->vdev);
>  		video_unregister_device(&stream->meta.vdev);
>  
>  		uvc_debugfs_cleanup_stream(stream);
> +
> +		mutex_unlock(&stream->queue.mutex);
> +		mutex_unlock(&stream->mutex);

Part of the problem here is that video_unregister_device does not stop streaming.

For 'normal' drivers that leave most of the locking to the core framework and
that use the standard vb2_fop_* and vb2_ioctl_* helpers, instead of calling
video_unregister_device, they call vb2_video_unregister_device(). This will
safely unregister the device and stop streaming at the same time.

Since after the device is unregistered the only file operation that is accepted
is close(), it will be impossible to restart streaming.

In other words, this guarantees that when the disconnect function exits there
is nothing streaming anymore.

This makes it much easier to deal with disconnects, and I think this should
happen here as well. I wonder if this will obsolete patch 3/3 and perhaps
2/3.

I don't think taking the queue.mutex is needed, especially if you stop
streaming here.

Regards,

	Hans

>  	}
>  
>  	uvc_status_unregister(dev);
> @@ -1925,6 +1933,7 @@ static void uvc_unregister_video(struct uvc_device *dev)
>  	if (media_devnode_is_registered(dev->mdev.devnode))
>  		media_device_unregister(&dev->mdev);
>  #endif
> +	mutex_unlock(&dev->lock);
>  }
>  
>  int uvc_register_video_device(struct uvc_device *dev,
> 


