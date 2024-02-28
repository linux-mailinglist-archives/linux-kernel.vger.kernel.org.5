Return-Path: <linux-kernel+bounces-84697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C07A586AA58
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 615C7B23C53
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4074F2D60C;
	Wed, 28 Feb 2024 08:45:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60C02D03C;
	Wed, 28 Feb 2024 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109920; cv=none; b=F1L5NPf5t3TggSOD6KHmH38JVjCgjeD8sxVH+YfdcdtOCFegCrK9mYq/RhiHJQlsMWvpJi8HF5XN/zhNqx/xPq/kWeu+8rJ5Wceft3Q+m10gX8bAQE8JsTZifQeoLFrjZdR1++RD312dYsBPruAdQadPIkjBgfE6AgfW+Po6cEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109920; c=relaxed/simple;
	bh=h5aEVTRj/DVmp+v39kdo/RsbNFljsaBQE/diK9z3LgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3vR9LjzkpoeUMpKYFPehBlCXFR+zq5eVHA3Ruq55HrdFXBluVDlCV8RfzbT/ZdxKXKnScp38ktZTHya9BCWvJDTeSqqFFLCbpUllFMtG7rcf+Z1O3A6kYFTpNyHVazdRZz9qcG7ZluefIPaQyjkT/NsQCuYsVO254Bh+Dt7xYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDA5C433F1;
	Wed, 28 Feb 2024 08:45:18 +0000 (UTC)
Message-ID: <b8400b7b-0716-4e8c-9ae5-f594778066c5@xs4all.nl>
Date: Wed, 28 Feb 2024 09:45:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: usbtv: Remove useless locks in usbtv_video_free()
Content-Language: en-US, nl
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, mchehab@kernel.org,
 tfiga@chromium.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20240220080628.13141-1-benjamin.gaignard@collabora.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240220080628.13141-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/02/2024 09:06, Benjamin Gaignard wrote:
> Remove locks calls in usbtv_video_free() because
> are useless and may led to a deadlock as reported here:
> https://syzkaller.appspot.com/x/bisect.txt?x=166dc872180000
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Fixes: c838530d230b ("media: media videobuf2: Be more flexible on the number of queue stored buffers")

Hmm, the code was really always wrong, it is just that before this commit
it would only fail if you did a disconnect while streaming, and now it also
fails if you disconnect when you are not streaming, so it is much more
noticeable now.

That should probably be explained better in the commit log. You could add a
second Fixes line:

Fixes: f3d27f34fdd7 ("[media] usbtv: Add driver for Fushicai USBTV007 video frame grabber")

but I am not sure how useful that is.

> ---
>  drivers/media/usb/usbtv/usbtv-video.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/usbtv/usbtv-video.c
> index 62a583040cd4..96276358d116 100644
> --- a/drivers/media/usb/usbtv/usbtv-video.c
> +++ b/drivers/media/usb/usbtv/usbtv-video.c
> @@ -963,15 +963,9 @@ int usbtv_video_init(struct usbtv *usbtv)
>  
>  void usbtv_video_free(struct usbtv *usbtv)
>  {
> -	mutex_lock(&usbtv->vb2q_lock);
> -	mutex_lock(&usbtv->v4l2_lock);
> -
>  	usbtv_stop(usbtv);

This call should also be dropped...

>  	vb2_video_unregister_device(&usbtv->vdev);

..since this function will call stop_streaming if streaming is in progress,
which will call usbtv_stop with all the correct locks held.

Regards,

	Hans

>  	v4l2_device_disconnect(&usbtv->v4l2_dev);
>  
> -	mutex_unlock(&usbtv->v4l2_lock);
> -	mutex_unlock(&usbtv->vb2q_lock);
> -
>  	v4l2_device_put(&usbtv->v4l2_dev);
>  }


