Return-Path: <linux-kernel+bounces-167862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3E68BB077
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8671C2248A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D003155332;
	Fri,  3 May 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6uXtanG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5047D4AEE5;
	Fri,  3 May 2024 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751922; cv=none; b=b1TW29oVDzQx2tezB93T1kxcn0t3TxkwldYryq4Yh0bOcIVcUuwJscvQBdXTwCcggv7qQGWs/ETP7gKK3J9fynWGGuL0qhJNWG/yWYmZokgxna0x3vPQ3M80ZO+1qMGYdA53GZ/7s5ieqfcgYw+xLzd1K3JWqwjHrqlW5z5zK44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751922; c=relaxed/simple;
	bh=tjcLMcc1pXHKQ8EsF3q4E+jRwwGEPkth6eL7KXSUy1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHR4Vs5mR5bYJ/JWFiZR9jgyMyBPap2g5x577M5hKiV28NdUUnRVO7iVf1iPLHMAsoCC+G6cmAd7e8Ad0696EAwIbSLY5TxBWrKeoyxAZQmDRx2FSTgHgQJqyd8XvQS6U+4Nu14R+mBMn7kplHkHRH+vboLla2alCNdiYsevlcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6uXtanG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9121CC116B1;
	Fri,  3 May 2024 15:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714751920;
	bh=tjcLMcc1pXHKQ8EsF3q4E+jRwwGEPkth6eL7KXSUy1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b6uXtanGACF3WNXDK+4E1/y+M0/Z8Dsc9Tdm9b6leLSTuF1wSbst1D3gRebUOY8ge
	 A8UtzrLJv107KY7Sq5Ctn7SI7rGOIIq/CroQd+1LAATvhbZPmyGV1j6attQddGxeVT
	 uZ0dj8h82OSjgRJvo+YUmsfGO58KqbbFquTtv38kIuH8oS8WBUTETtGc6+PxVHOtPE
	 YkNVqem6OsyjftSf+vRG1Hkfvkhi9VCB6Yom6Q0C/fFv7yDoT9lC4tI1tSQhL7neVp
	 wnaj1MNQ/36F+KwJu9gM6/xA+db9taVZfUWitMtAU+uawAE11N+eumWQDv++RXYPBH
	 9ZPa1yvgwwVTw==
Date: Fri, 3 May 2024 16:58:33 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, Dongliang Mu
 <dzm91@hust.edu.cn>, Andrew Morton <akpm@linux-foundation.org>, Alan Stern
 <stern@rowland.harvard.edu>, <linux-media@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
 <syzbot+12002a39b8c60510f8fb@syzkaller.appspotmail.com>
Subject: Re: [PATCH] media: usb: siano: fix endpoint checks in
 smsusb_init_device()
Message-ID: <20240503165833.4781fb4a@sal.lan>
In-Reply-To: <20240409143634.33230-1-n.zhandarovich@fintech.ru>
References: <20240409143634.33230-1-n.zhandarovich@fintech.ru>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 9 Apr 2024 07:36:34 -0700
Nikita Zhandarovich <n.zhandarovich@fintech.ru> escreveu:

> Syzkaller reported a warning [1] in smsusb_submit_urb() which occurs
> if an attempt is made to send a bulk URB using the wrong endpoint
> type. The current approach to perform endpoint checking does not
> explicitly check if an endpoint in question has its type set to bulk.
> 
> Fix this issue by using functions usb_endpoint_is_bulk_XXX() to
> enable testing for correct ep types.
> 
> This patch has not been tested on real hardware.
> 
> [1] Syzkaller report:
> usb 1-1: string descriptor 0 read error: -71
> smsusb:smsusb_probe: board id=2, interface number 0
> smsusb:siano_media_device_register: media controller created
> ------------[ cut here ]------------
> usb 1-1: BOGUS urb xfer, pipe 3 != type 1
> WARNING: CPU: 0 PID: 3147 at drivers/usb/core/urb.c:494 usb_submit_urb+0xacd/0x1550 drivers/usb/core/urb.c:493
> ...
> Call Trace:
>  smsusb_start_streaming+0x16/0x1d0 drivers/media/usb/siano/smsusb.c:195
>  smsusb_init_device+0xd85/0x12d0 drivers/media/usb/siano/smsusb.c:475
>  smsusb_probe+0x496/0xa90 drivers/media/usb/siano/smsusb.c:566
>  usb_probe_interface+0x633/0xb40 drivers/usb/core/driver.c:396
>  really_probe+0x3cb/0x1020 drivers/base/dd.c:580
>  driver_probe_device+0x178/0x350 drivers/base/dd.c:763
> ...
>  hub_event+0x48d/0xd90 drivers/usb/core/hub.c:5644
>  process_one_work+0x833/0x10c0 kernel/workqueue.c:2276
>  worker_thread+0xac1/0x1300 kernel/workqueue.c:2422
>  kthread+0x39a/0x3c0 kernel/kthread.c:313
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> 
> Reported-and-tested-by: syzbot+12002a39b8c60510f8fb@syzkaller.appspotmail.com
> Fixes: 31e0456de5be ("media: usb: siano: Fix general protection fault in smsusb")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  drivers/media/usb/siano/smsusb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
> index 723510520d09..daaac121c670 100644
> --- a/drivers/media/usb/siano/smsusb.c
> +++ b/drivers/media/usb/siano/smsusb.c
> @@ -405,10 +405,10 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
>  		struct usb_endpoint_descriptor *desc =
>  				&intf->cur_altsetting->endpoint[i].desc;
>  
> -		if (desc->bEndpointAddress & USB_DIR_IN) {
> +		if (usb_endpoint_is_bulk_in(desc)) {
>  			dev->in_ep = desc->bEndpointAddress;
>  			align = usb_endpoint_maxp(desc) - sizeof(struct sms_msg_hdr);
> -		} else {
> +		} else if (usb_endpoint_is_bulk_out(desc)) {

Did you test it on what devices? I'm not sure if all siano devices
are bulk. Why did you decide to use usb_endpoint_is_bulk_(in|out)
instead of usb_endpoint_dir_(in|out)?

Regards,
Mauro

>  			dev->out_ep = desc->bEndpointAddress;
>  		}
>  	}
> 

