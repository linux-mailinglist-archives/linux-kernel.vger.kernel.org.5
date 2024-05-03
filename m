Return-Path: <linux-kernel+bounces-168236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1D18BB581
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4591E281B0D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6B354BD8;
	Fri,  3 May 2024 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrAIQ+aH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ACD33CF1;
	Fri,  3 May 2024 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771263; cv=none; b=pvHFmG8ev0TyV441IT7fezf+MiVDLMRApc8QjhBP2QYOVTW5YaXCX2gFt/WE8wy9G/JxPH+lr5MQCkphXjBvs0Yq3yTEeyi4J0G3wwbA3hvHzQ5vX2Csyt9dgl2/w0xXgGVnI0EWYnvnfwaPfRmdYWGL98otANqiZa8cngYa9CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771263; c=relaxed/simple;
	bh=m3RRaRXGJms8rDFATO/O9+wihzhhAA5bkIRH1joYdiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2VuvNQHhr74x9g2BWDtO7q/amY4UXRRZGptsUmi0lYehrixtoli/KB+YxUMmCFn4fn8//O2klkinG/5Xa4hPKhBlEKsmicQ5k6hxQzAQ7xNjWWbVStL8ARGboZ3BndARLUsl+l2wIdfjb5wDgKXkgwsRe3+br4NKNRmsMFTvMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrAIQ+aH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD11C116B1;
	Fri,  3 May 2024 21:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714771262;
	bh=m3RRaRXGJms8rDFATO/O9+wihzhhAA5bkIRH1joYdiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GrAIQ+aH7T6Ql+gFqObGLSkI/qmCrTRHJwbrfWOBy1R1nOov1G/dFJl3hGShYfnEF
	 AKQuKRM1cmQQRhtHdHlzkYTnhctobmEwkIw2StGGAEsUHNLYnqXMekpwnltzxS5t8d
	 hm/bcva5ULhZOu4RslCMqFKfT1ZXRWkW1Wjf/doutQkbrd3mstyMoC11SgfsqYx2LK
	 zHqc7po5+L+tNhA/FMlkB2NoPcG4yaYF66+DLmtg6TXJ4XChKj26jK+bzpgxhGT1rZ
	 f+/K6cXucqCcrV0S4F/PT1dvrM5uINggp/L9ezxNynsy4eA0ohZT7br/cEJIEBeeni
	 v580PwcdZezcQ==
Date: Fri, 3 May 2024 22:20:54 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, Dongliang Mu
 <dzm91@hust.edu.cn>, Andrew Morton <akpm@linux-foundation.org>, Alan Stern
 <stern@rowland.harvard.edu>, <linux-media@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
 <syzbot+12002a39b8c60510f8fb@syzkaller.appspotmail.com>
Subject: Re: [PATCH] media: usb: siano: fix endpoint checks in
 smsusb_init_device()
Message-ID: <20240503222054.45ed636f@sal.lan>
In-Reply-To: <4069e01b-09d1-49e6-b053-3f6b99dd9405@fintech.ru>
References: <20240409143634.33230-1-n.zhandarovich@fintech.ru>
	<20240503165833.4781fb4a@sal.lan>
	<4069e01b-09d1-49e6-b053-3f6b99dd9405@fintech.ru>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 3 May 2024 09:14:37 -0700
Nikita Zhandarovich <n.zhandarovich@fintech.ru> escreveu:

> Hi
> 
> On 5/3/24 08:58, Mauro Carvalho Chehab wrote:
> > Em Tue, 9 Apr 2024 07:36:34 -0700
> > Nikita Zhandarovich <n.zhandarovich@fintech.ru> escreveu:
> >   
> >> Syzkaller reported a warning [1] in smsusb_submit_urb() which occurs
> >> if an attempt is made to send a bulk URB using the wrong endpoint
> >> type. The current approach to perform endpoint checking does not
> >> explicitly check if an endpoint in question has its type set to bulk.
> >>
> >> Fix this issue by using functions usb_endpoint_is_bulk_XXX() to
> >> enable testing for correct ep types.
> >>
> >> This patch has not been tested on real hardware.
> >>
> >> [1] Syzkaller report:
> >> usb 1-1: string descriptor 0 read error: -71
> >> smsusb:smsusb_probe: board id=2, interface number 0
> >> smsusb:siano_media_device_register: media controller created
> >> ------------[ cut here ]------------
> >> usb 1-1: BOGUS urb xfer, pipe 3 != type 1
> >> WARNING: CPU: 0 PID: 3147 at drivers/usb/core/urb.c:494 usb_submit_urb+0xacd/0x1550 drivers/usb/core/urb.c:493
> >> ...
> >> Call Trace:
> >>  smsusb_start_streaming+0x16/0x1d0 drivers/media/usb/siano/smsusb.c:195
> >>  smsusb_init_device+0xd85/0x12d0 drivers/media/usb/siano/smsusb.c:475
> >>  smsusb_probe+0x496/0xa90 drivers/media/usb/siano/smsusb.c:566
> >>  usb_probe_interface+0x633/0xb40 drivers/usb/core/driver.c:396
> >>  really_probe+0x3cb/0x1020 drivers/base/dd.c:580
> >>  driver_probe_device+0x178/0x350 drivers/base/dd.c:763
> >> ...
> >>  hub_event+0x48d/0xd90 drivers/usb/core/hub.c:5644
> >>  process_one_work+0x833/0x10c0 kernel/workqueue.c:2276
> >>  worker_thread+0xac1/0x1300 kernel/workqueue.c:2422
> >>  kthread+0x39a/0x3c0 kernel/kthread.c:313
> >>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> >>
> >> Reported-and-tested-by: syzbot+12002a39b8c60510f8fb@syzkaller.appspotmail.com
> >> Fixes: 31e0456de5be ("media: usb: siano: Fix general protection fault in smsusb")
> >> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> >> ---
> >>  drivers/media/usb/siano/smsusb.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
> >> index 723510520d09..daaac121c670 100644
> >> --- a/drivers/media/usb/siano/smsusb.c
> >> +++ b/drivers/media/usb/siano/smsusb.c
> >> @@ -405,10 +405,10 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
> >>  		struct usb_endpoint_descriptor *desc =
> >>  				&intf->cur_altsetting->endpoint[i].desc;
> >>  
> >> -		if (desc->bEndpointAddress & USB_DIR_IN) {
> >> +		if (usb_endpoint_is_bulk_in(desc)) {
> >>  			dev->in_ep = desc->bEndpointAddress;
> >>  			align = usb_endpoint_maxp(desc) - sizeof(struct sms_msg_hdr);
> >> -		} else {
> >> +		} else if (usb_endpoint_is_bulk_out(desc)) {  
> > 
> > Did you test it on what devices? I'm not sure if all siano devices
> > are bulk. Why did you decide to use usb_endpoint_is_bulk_(in|out)
> > instead of usb_endpoint_dir_(in|out)?  
> 
> I did not have the hardware required to test it properly, I'm afraid.
> I made sure to point that out in the patch description.
> 
> As for siano devices possibly having different endpoints type apart from
> bulk, I was relying on the rest of the driver code to determine just
> that (which is maybe somewhat flawed in this case). 

Most digital TV devices also have ISOC endpoints. I'm not sure about
Siano.

> Since
> smsusb_submit_urb() (and some other functions like usb_rcvbulkpipe())
> works exclusively with bulk types, I did not feel the need to even
> expect int types, for instance.

The problem is not with int endpoints. Most media devices have isoc
endpoints. There are even cases that different device models supported
by the same driver have some bulk and some isoc endpoints. See em28xx 
driver for instance: most devices are isoc only; some have both isoc
and bulk; a few have just bulk.

In the specific case of siano, it supports 3 generations of devices
(sms1000, sms11xx, sms22xx), each with several submodels. 
Those 3 generations have different specs, and sms1000 even have one
"boot" USB ID, and one "warm" USB ID, each one with different endpoints.

That's basically why I'm afraid of a patch like this could cause
regressions if not properly tested, as it is changing the logic
from just detecting the direction to also validate if the endpoint
is not isoc.

Regards,
Mauro

