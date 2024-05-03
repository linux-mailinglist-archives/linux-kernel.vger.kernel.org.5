Return-Path: <linux-kernel+bounces-168387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC1F8BB7CF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7851E286AE1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2016182D94;
	Fri,  3 May 2024 22:52:22 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A3258AB9;
	Fri,  3 May 2024 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714776741; cv=none; b=VVwPHq3GOujYL/0Cq+lgcFTwHgGNYOc1r9t6N6/EGeIOe8p/kgjiFkTAxvIJMeHm/sLXGiBEAVKVPFh9Sfok+z0y/1JHKXhErMAKZFjD33ny0QuhOtRhQPkcdF0C3832+UdUB5jxZL3PKRmFxrR/wYJnq4Ko3lkWx+GdJUClS5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714776741; c=relaxed/simple;
	bh=+k7smC01PbURrogCBgEc+38Tqvw0xyJMXL4rJUbsaSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iP/WLEJSOxgmOLZGTc166ZjVvUoWquatAVDMAvGJC1GeeFcKJprr9IsZrQyuIIZj03DtsfHpjAIvCrGfhDOpc3tf+t7ddP/U2oVnXy8FRS9hiPlarfraLi8xWJCsc28a+aqvaP/DxUalx5SU2IqfHgJUfoo7fe6y465V3iySLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Sat, 4 May
 2024 01:52:14 +0300
Received: from [192.168.211.130] (10.0.253.138) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 4 May 2024
 01:52:13 +0300
Message-ID: <73c24dd7-3cd8-4875-a33d-b546a346a24d@fintech.ru>
Date: Fri, 3 May 2024 15:52:10 -0700
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
 <4069e01b-09d1-49e6-b053-3f6b99dd9405@fintech.ru>
 <20240503222054.45ed636f@sal.lan>
Content-Language: en-US
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
In-Reply-To: <20240503222054.45ed636f@sal.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Hi

On 5/3/24 14:20, Mauro Carvalho Chehab wrote:
> Em Fri, 3 May 2024 09:14:37 -0700
> Nikita Zhandarovich <n.zhandarovich@fintech.ru> escreveu:
> 
>>> Did you test it on what devices? I'm not sure if all siano devices
>>> are bulk. Why did you decide to use usb_endpoint_is_bulk_(in|out)
>>> instead of usb_endpoint_dir_(in|out)?  
>>
>> I did not have the hardware required to test it properly, I'm afraid.
>> I made sure to point that out in the patch description.
>>
>> As for siano devices possibly having different endpoints type apart from
>> bulk, I was relying on the rest of the driver code to determine just
>> that (which is maybe somewhat flawed in this case). 
> 
> Most digital TV devices also have ISOC endpoints. I'm not sure about
> Siano.
After a quick glance at Siano driver I am not sure about that being true
specifically for Siano devices just yet, but I understand your point
nonetheless.
> 
>> Since
>> smsusb_submit_urb() (and some other functions like usb_rcvbulkpipe())
>> works exclusively with bulk types, I did not feel the need to even
>> expect int types, for instance.
> 
> The problem is not with int endpoints. Most media devices have isoc
> endpoints. There are even cases that different device models supported
> by the same driver have some bulk and some isoc endpoints. See em28xx 
> driver for instance: most devices are isoc only; some have both isoc
> and bulk; a few have just bulk.
> 
> In the specific case of siano, it supports 3 generations of devices
> (sms1000, sms11xx, sms22xx), each with several submodels. 
> Those 3 generations have different specs, and sms1000 even have one
> "boot" USB ID, and one "warm" USB ID, each one with different endpoints.
> 
> That's basically why I'm afraid of a patch like this could cause
> regressions if not properly tested, as it is changing the logic
> from just detecting the direction to also validate if the endpoint
> is not isoc.

Thank you for being so thorough with your answer. I think I
overestimated how much I should trust current driver implementation. I
should be (at least, in this case) looking at what hardware expects of
the driver.

Let me try to do a little more research into smsxxxx specs and maybe see
about getting my hands on some actual devices for testing.

> 
> Regards,
> Mauro

With regards,
Nikita

