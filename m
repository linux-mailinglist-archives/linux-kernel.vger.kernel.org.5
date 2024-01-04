Return-Path: <linux-kernel+bounces-16772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05642824390
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6F9B25511
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B610422EF4;
	Thu,  4 Jan 2024 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K0uE6u02"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D7622EEF;
	Thu,  4 Jan 2024 14:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E17C433C7;
	Thu,  4 Jan 2024 14:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704377951;
	bh=WLvYC+0IkEMVSSIQbYcMkAdmvdMqgG6gUJTDRz9dZaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K0uE6u02Z7qL/cuj0tHSMH5GH/l2U+G5+rMIj5DHA8fL0KMUOgpOUdLsy3LN3i+4V
	 A2szCkd1/fKxHGUBLaKCu4miwo8fdSyyKHIrR4Tj4u4C9Ki3FcWnPlqsqBURjFJ22d
	 4Qc8W5TpsSq8K4vV8j/qiIFeVCbBFNgKxfla1hPs=
Date: Thu, 4 Jan 2024 15:19:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Avichal Rakesh <arakesh@google.com>
Cc: dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
	etalvala@google.com, jchowdhary@google.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: gadget: uvc: Fix use are free during STREAMOFF
Message-ID: <2024010450-humming-bullion-1af4@gregkh>
References: <20231215210746.821494-1-arakesh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215210746.821494-1-arakesh@google.com>

On Fri, Dec 15, 2023 at 01:07:44PM -0800, Avichal Rakesh wrote:
> There is a path that may lead to freed memory being referenced,
> and causing kernel panics.
> 
> The kernel panic has the following stack trace:
> 
> Workqueue: uvcgadget uvcg_video_pump.c51fb85fece46625450f86adbf92c56c.cfi_jt
> pstate: 60c00085 (nZCv daIf +PAN +UAO -TCO BTYPE=--)
> pc : __list_del_entry_valid+0xc0/0xd4
> lr : __list_del_entry_valid+0xc0/0xd4
> Call trace:
>   __list_del_entry_valid+0xc0/0xd4
>   uvc_video_free_request+0x60/0x98
>   uvcg_video_pump+0x1cc/0x204
>   process_one_work+0x21c/0x4b8
>   worker_thread+0x29c/0x574
>   kthread+0x158/0x1b0
>   ret_from_fork+0x10/0x30
> 
> The root cause is that uvcg_video_usb_req_queue frees the uvc_request
> if is_enabled is false and returns an error status. video_pump also
> frees the associated request if uvcg_video_usb_req_queue returns an e
> rror status, leading to double free and accessing garbage memory.

Odd line wrapping :(

> 
> To fix the issue, this patch removes freeing logic from
> uvcg_video_usb_req_queue, and lets the callers to the function handle
> queueing errors as they see fit.
> 
> Signed-off-by: Avichal Rakesh <arakesh@google.com>
> ---
>  drivers/usb/gadget/function/uvc_video.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

What commit id does this fix?


> 
> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
> index 98ba524c27f5..e5db1be14ca3 100644
> --- a/drivers/usb/gadget/function/uvc_video.c
> +++ b/drivers/usb/gadget/function/uvc_video.c
> @@ -277,8 +277,7 @@ static int uvcg_video_usb_req_queue(struct uvc_video *video,
>  	struct list_head *list = NULL;
>  
>  	if (!video->is_enabled) {
> -		uvc_video_free_request(req->context, video->ep);
> -		return -ENODEV;
> +		return -EINVAL;

Isn't this a separate change?  And does it actually matter?

thanks,

greg k-h

