Return-Path: <linux-kernel+bounces-86705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E96986C94D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECAD01F25B52
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043DF7D3FF;
	Thu, 29 Feb 2024 12:36:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803FD33FE;
	Thu, 29 Feb 2024 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709210172; cv=none; b=mK5q064w11w81+/VsGn/Ln5lko6nRgxkSMIpf4zf0l7fivZ++b415JHn54rytzHbU+5PuU2gxr5zlO0Ae40ypvbCpi/CVGuUx0QtAjuLaFZR5i8C/Pv+CVBOWC4y0hAFUvp73cq3imZPmmeuwQiQy9Q+BqKmBEp28tQi6pIfDPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709210172; c=relaxed/simple;
	bh=cEm1nlpXzkO+OrkahjB0Vv9weCQRVfMybCdEiveFC9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCBb6HdnSO/8hYqCb48VNHbuIwqzOarj0Ke3pdfsUJQHyOSSq/y1UkDGZHA8x7i1gNN72wEnBolsiDkNDI2WRyyfGP1IPvA4ZyJ3XbJYTM1+aW29uj/yXPbo5JSKiwm+Lw3sBWh2EHNJsAIFc15y0o9Gh4c5i/hmg4VvDA5zh5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37943C433C7;
	Thu, 29 Feb 2024 12:36:10 +0000 (UTC)
Message-ID: <ee461aca-40c6-4e81-baf0-60d52f7a6577@xs4all.nl>
Date: Thu, 29 Feb 2024 13:36:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: fix task hung in vb2_video_unregister_device
Content-Language: en-US
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+2622b51b35f91a00ea18@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-usb@vger.kernel.org, m.szyprowski@samsung.com, mchehab@kernel.org,
 syzkaller-bugs@googlegroups.com, tfiga@chromium.org
References: <0000000000008faf0a06126a0ffb@google.com>
 <tencent_70C492C20645C99DEEC9EED28C8E27D40606@qq.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <tencent_70C492C20645C99DEEC9EED28C8E27D40606@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/29/24 13:21, Edward Adam Davis wrote:
> vb2_video_unregister_device() will get vb2q_lock, so usbtv_video_free() does
> not need vb2q_lock.
> 
> Reported-and-tested-by: syzbot+2622b51b35f91a00ea18@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Duplicate of:

https://lore.kernel.org/linux-media/19cdefd3-163b-41a1-b603-764aab4b5b90@xs4all.nl/

I'm waiting for a v2 of that one.

Regards,

	Hans

> ---
>  drivers/media/usb/usbtv/usbtv-video.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/usbtv/usbtv-video.c
> index 62a583040cd4..b55f432b44d4 100644
> --- a/drivers/media/usb/usbtv/usbtv-video.c
> +++ b/drivers/media/usb/usbtv/usbtv-video.c
> @@ -963,7 +963,6 @@ int usbtv_video_init(struct usbtv *usbtv)
>  
>  void usbtv_video_free(struct usbtv *usbtv)
>  {
> -	mutex_lock(&usbtv->vb2q_lock);
>  	mutex_lock(&usbtv->v4l2_lock);
>  
>  	usbtv_stop(usbtv);
> @@ -971,7 +970,6 @@ void usbtv_video_free(struct usbtv *usbtv)
>  	v4l2_device_disconnect(&usbtv->v4l2_dev);
>  
>  	mutex_unlock(&usbtv->v4l2_lock);
> -	mutex_unlock(&usbtv->vb2q_lock);
>  
>  	v4l2_device_put(&usbtv->v4l2_dev);
>  }


