Return-Path: <linux-kernel+bounces-167888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2149E8BB0B3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56D77B2322B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA0C15686E;
	Fri,  3 May 2024 16:14:49 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039D479E3;
	Fri,  3 May 2024 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752889; cv=none; b=XUHOOyfKfLF1sc+7geB08vCyiWjiFQzlhIXhUa9PKKmtgIOIfJ6sjjbk2PKGZ04Zy4ErKIAgpov3CMcTjBcbssDUJtj1lvZNexDPikeAGrknbvRZJi2w0PknsSjAq51bCXdCN/UmZ/XLRD+STXqWcutqL0GIcdC2h0qN4re32bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752889; c=relaxed/simple;
	bh=pbxiDzRe5zgBNCC0hVoF8CA3VIA7a25l0e7+srfO3Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GkWGU44b8fEGqdl5EnI6/eauSr8mQjzRAVIb13SB6JgDqZN7y3ZNirJ3d/6V0/rwsYKASl3zlMPuu9nf1UPL3W5FeclKi+mDNTTHzyMkFmZ/kpeifL6uZvr5pwiAI0cfBZWP0LhVl4gYnSaeXOsaZj2dKLgBp6+LNdnl7AhGK58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 3 May
 2024 19:14:41 +0300
Received: from [192.168.211.130] (10.0.253.138) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 3 May 2024
 19:14:41 +0300
Message-ID: <4069e01b-09d1-49e6-b053-3f6b99dd9405@fintech.ru>
Date: Fri, 3 May 2024 09:14:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: usb: siano: fix endpoint checks in
 smsusb_init_device()
To: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Hans Verkuil <hverkuil-cisco@xs4all.nl>, Dongliang Mu <dzm91@hust.edu.cn>,
	Andrew Morton <akpm@linux-foundation.org>, Alan Stern
	<stern@rowland.harvard.edu>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<syzbot+12002a39b8c60510f8fb@syzkaller.appspotmail.com>
References: <20240409143634.33230-1-n.zhandarovich@fintech.ru>
 <20240503165833.4781fb4a@sal.lan>
Content-Language: en-US
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
In-Reply-To: <20240503165833.4781fb4a@sal.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Hi

On 5/3/24 08:58, Mauro Carvalho Chehab wrote:
> Em Tue, 9 Apr 2024 07:36:34 -0700
> Nikita Zhandarovich <n.zhandarovich@fintech.ru> escreveu:
> 
>> Syzkaller reported a warning [1] in smsusb_submit_urb() which occurs
>> if an attempt is made to send a bulk URB using the wrong endpoint
>> type. The current approach to perform endpoint checking does not
>> explicitly check if an endpoint in question has its type set to bulk.
>>
>> Fix this issue by using functions usb_endpoint_is_bulk_XXX() to
>> enable testing for correct ep types.
>>
>> This patch has not been tested on real hardware.
>>
>> [1] Syzkaller report:
>> usb 1-1: string descriptor 0 read error: -71
>> smsusb:smsusb_probe: board id=2, interface number 0
>> smsusb:siano_media_device_register: media controller created
>> ------------[ cut here ]------------
>> usb 1-1: BOGUS urb xfer, pipe 3 != type 1
>> WARNING: CPU: 0 PID: 3147 at drivers/usb/core/urb.c:494 usb_submit_urb+0xacd/0x1550 drivers/usb/core/urb.c:493
>> ...
>> Call Trace:
>>  smsusb_start_streaming+0x16/0x1d0 drivers/media/usb/siano/smsusb.c:195
>>  smsusb_init_device+0xd85/0x12d0 drivers/media/usb/siano/smsusb.c:475
>>  smsusb_probe+0x496/0xa90 drivers/media/usb/siano/smsusb.c:566
>>  usb_probe_interface+0x633/0xb40 drivers/usb/core/driver.c:396
>>  really_probe+0x3cb/0x1020 drivers/base/dd.c:580
>>  driver_probe_device+0x178/0x350 drivers/base/dd.c:763
>> ...
>>  hub_event+0x48d/0xd90 drivers/usb/core/hub.c:5644
>>  process_one_work+0x833/0x10c0 kernel/workqueue.c:2276
>>  worker_thread+0xac1/0x1300 kernel/workqueue.c:2422
>>  kthread+0x39a/0x3c0 kernel/kthread.c:313
>>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
>>
>> Reported-and-tested-by: syzbot+12002a39b8c60510f8fb@syzkaller.appspotmail.com
>> Fixes: 31e0456de5be ("media: usb: siano: Fix general protection fault in smsusb")
>> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>> ---
>>  drivers/media/usb/siano/smsusb.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
>> index 723510520d09..daaac121c670 100644
>> --- a/drivers/media/usb/siano/smsusb.c
>> +++ b/drivers/media/usb/siano/smsusb.c
>> @@ -405,10 +405,10 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
>>  		struct usb_endpoint_descriptor *desc =
>>  				&intf->cur_altsetting->endpoint[i].desc;
>>  
>> -		if (desc->bEndpointAddress & USB_DIR_IN) {
>> +		if (usb_endpoint_is_bulk_in(desc)) {
>>  			dev->in_ep = desc->bEndpointAddress;
>>  			align = usb_endpoint_maxp(desc) - sizeof(struct sms_msg_hdr);
>> -		} else {
>> +		} else if (usb_endpoint_is_bulk_out(desc)) {
> 
> Did you test it on what devices? I'm not sure if all siano devices
> are bulk. Why did you decide to use usb_endpoint_is_bulk_(in|out)
> instead of usb_endpoint_dir_(in|out)?

I did not have the hardware required to test it properly, I'm afraid.
I made sure to point that out in the patch description.

As for siano devices possibly having different endpoints type apart from
bulk, I was relying on the rest of the driver code to determine just
that (which is maybe somewhat flawed in this case). Since
smsusb_submit_urb() (and some other functions like usb_rcvbulkpipe())
works exclusively with bulk types, I did not feel the need to even
expect int types, for instance.

> 
> Regards,
> Mauro
> 
>>  			dev->out_ep = desc->bEndpointAddress;
>>  		}
>>  	}
>>

With regards,
Nikita

