Return-Path: <linux-kernel+bounces-130599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B4E897A50
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B111C25DF2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0A9156655;
	Wed,  3 Apr 2024 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StA5MxiQ"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FE1156257;
	Wed,  3 Apr 2024 21:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712178122; cv=none; b=NTgXG5BrAdXF64roXiOKdokG+yJcCmkpx8OLZK0tlQsvjsgOiu3Ema9sgcGOIk/VJ0IkZ7XECc1ct21VnkWxtXORzQawq+HXpK4MPG0T5WgMK7L22dXIxAE8eIH+GaQvG9XJbrAGYKxB++R5RTi8+3iBh/fgIgN51cK/KrxauC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712178122; c=relaxed/simple;
	bh=O+d2xhIV/lOT3xIrFWGLYtJgVKqXI4zkXFR3u+3IDeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flgdoglO5YRPUtkAH9fihqYv+RNYZ/V9U2qyEo0M8z1mOZImR6adcgotGUEyCoqLOu5j7jjsf3+5oNjH9nrqNG/Gk0rH8+w/hG/M2xf/HQqxTveoSbBrnqVytF/dd42O5quaqRJ6MSfXGJWNnW2OwjKokTFplowxiu6CEVltKbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StA5MxiQ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56c583f5381so378737a12.1;
        Wed, 03 Apr 2024 14:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712178119; x=1712782919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=miuXJJywSWsMiyEU6SyFk+idteSJTItU5lhbjToBFIY=;
        b=StA5MxiQtJc6EfeF2UhrPYrRftmzuokoSxZ4CdqUCfGgxGG0k8a1HtX/C8BIhyxZhH
         iI6M7GQp634JnABgoralWEVA1VelD8ZdsdkncsllPvxhWL7vABc6o7FXTJ6Q2Ru7UZSS
         eQ+/cc5UtAo2wNMhh+98jj9SsKY2lYsHacOUoH/aUcLV7NgsSbbvcLve/JTk+KKWi/8Y
         WEROAoDTydeRPDmhk+uhYTiFf5bMuVyFRT46Pk/Kk+yZ6E09IClyABMJDvx3ryVgUaTA
         PPg5sSzcDq2FpY8KeQ3TpHY1xXkR49yy8j2lEL+KViwDNz0gQs4AChGKfIjvl57M29Lz
         gVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712178119; x=1712782919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miuXJJywSWsMiyEU6SyFk+idteSJTItU5lhbjToBFIY=;
        b=RrE2VBbTfpKGxaZSrQRXPvjiOq3wEHfqDKBAExUhAIRnS6IGIg3R84Q96pz6euZmrT
         kVkFog1IrD70jW+nl0z9RK01vxdMN+FlszXy1q8TTephjVWnLcP8VsTdY1SuvDX6KA72
         TXLOw0UL9I16SAS/vNOko/zVbQm0M1aYdvEhKL4kGjWcxf+n7tF66/Ch4T8V8uOxR1yA
         G4AL17wVYv2TjbJ2IDYxl9QMexYMR47DYCAa2x1BijJrxOFmWC80BXQr+Ybl5sUkt203
         V3enbDJSz0SIZ4ppoeE4GPL8/kYsgUvNTLfpRtDO7+dDsWyXQ5UklexQSo01IBoy6S/z
         Mvzw==
X-Forwarded-Encrypted: i=1; AJvYcCXLyrEmYtapuDeVQcbUGd17QOs7zSMm/3yMcAomkPWVOcAywxf5PtUmfBgbqQ+lWyboP7eLw6lOwYxDiZ9UOfU0oDuC2Zwc18CqyuGoVLS0/nztcBujaQxaW8u3GcgzNhEp0lAyotoD
X-Gm-Message-State: AOJu0YwFkEpcmDiWgQGHVp9h0/d0kqogHhRsFe7QQQ3Zhuop1OiqhYby
	fBSVMH4H+jJQ20+lubbgj+BcefhCWWKXYwfg91061ipWQ2CRLnDy
X-Google-Smtp-Source: AGHT+IEfK5FrL2/8WlOMh0OUYK6oLciySXh0EcWx/gaeCdrYNeRGlcxcLDl/wk6fFRR0/eHpk/UKUA==
X-Received: by 2002:a50:aad4:0:b0:56b:aa17:813a with SMTP id r20-20020a50aad4000000b0056baa17813amr590848edc.21.1712178119266;
        Wed, 03 Apr 2024 14:01:59 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:a930:c891:41c1:3154? (2a02-a466-68ed-1-a930-c891-41c1-3154.fixed6.kpn.net. [2a02:a466:68ed:1:a930:c891:41c1:3154])
        by smtp.gmail.com with ESMTPSA id n24-20020a05640204d800b0056c5d0c932bsm7271178edw.53.2024.04.03.14.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 14:01:58 -0700 (PDT)
Message-ID: <aeee83d8-dee3-42ed-b705-988b17800721@gmail.com>
Date: Wed, 3 Apr 2024 23:01:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: gadget: u_ether: Replace netif_stop_queue with
 netif_device_detach
To: Ferry Toth <fntoth@gmail.com>, Hardik Gajjar <hgajjar@de.adit-jv.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: gregkh@linuxfoundation.org, s.hauer@pengutronix.de, jonathanh@nvidia.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_linyyuan@quicinc.com, paul@crapouillou.net, quic_eserrao@quicinc.com,
 erosca@de.adit-jv.com
References: <20231006153808.9758-1-hgajjar@de.adit-jv.com>
 <20231006155646.12938-1-hgajjar@de.adit-jv.com>
 <ZaQS5x-XK08Jre6I@smile.fi.intel.com>
 <20240115132720.GA98840@vmlxhi-118.adit-jv.com>
 <f25283fc-4550-4725-960b-2ea783fd62e1@gmail.com>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <f25283fc-4550-4725-960b-2ea783fd62e1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Op 15-01-2024 om 21:10 schreef Ferry Toth:
> Hi,
>
> Op 15-01-2024 om 14:27 schreef Hardik Gajjar:
>> On Sun, Jan 14, 2024 at 06:59:19PM +0200, Andy Shevchenko wrote:
>>> +Cc: Ferry.
>>>
>>> On Fri, Oct 06, 2023 at 05:56:46PM +0200, Hardik Gajjar wrote:
>>>> This patch replaces the usage of netif_stop_queue with 
>>>> netif_device_detach
>>>> in the u_ether driver. The netif_device_detach function not only 
>>>> stops all
>>>> tx queues by calling netif_tx_stop_all_queues but also marks the 
>>>> device as
>>>> removed by clearing the __LINK_STATE_PRESENT bit.
>>>>
>>>> This change helps notify user space about the disconnection of the 
>>>> device
>>>> more effectively, compared to netif_stop_queue, which only stops a 
>>>> single
>>>> transmit queue.
>>>
>>> This change effectively broke my USB ether setup.
>>>
>>> git bisect start
>>> # status: waiting for both good and bad commits
>>> # good: [1f24458a1071f006e3f7449c08ae0f12af493923] Merge tag 
>>> 'tty-6.7-rc1' of 
>>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
>>> git bisect good 1f24458a1071f006e3f7449c08ae0f12af493923
>>> # status: waiting for bad commit, 1 good commit known
>>> # bad: [2c40c1c6adab90ee4660caf03722b3a3ec67767b] Merge tag 
>>> 'usb-6.7-rc1' of 
>>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
>>> git bisect bad 2c40c1c6adab90ee4660caf03722b3a3ec67767b
>>> # bad: [17d6b82d2d6d467149874b883cdba844844b996d] usb/usbip: fix 
>>> wrong data added to platform device
>>> git bisect bad 17d6b82d2d6d467149874b883cdba844844b996d
>>> # good: [ba6b83a910b6d8a9379bda55cbf06cb945473a96] usb: xhci-mtk: 
>>> add a bandwidth budget table
>>> git bisect good ba6b83a910b6d8a9379bda55cbf06cb945473a96
>>> # good: [dddc00f255415b826190cfbaa5d6dbc87cd9ded1] Revert "usb: 
>>> gadget: uvc: cleanup request when not in correct state"
>>> git bisect good dddc00f255415b826190cfbaa5d6dbc87cd9ded1
>>> # bad: [8f999ce60ea3d47886b042ef1f22bb184b6e9c59] USB: typec: 
>>> tps6598x: Refactor tps6598x port registration
>>> git bisect bad 8f999ce60ea3d47886b042ef1f22bb184b6e9c59
>>> # bad: [f49449fbc21e7e9550a5203902d69c8ae7dfd918] usb: gadget: 
>>> u_ether: Replace netif_stop_queue with netif_device_detach
>>> git bisect bad f49449fbc21e7e9550a5203902d69c8ae7dfd918
>>> # good: [97475763484245916735a1aa9a3310a01d46b008] USB: usbip: fix 
>>> stub_dev hub disconnect
>>> git bisect good 97475763484245916735a1aa9a3310a01d46b008
>>> # good: [0f5aa1b01263b8b621bc4f031a1f2983ef8517b7] usb: usbtest: fix 
>>> a type promotion bug
>>> git bisect good 0f5aa1b01263b8b621bc4f031a1f2983ef8517b7
>>> # first bad commit: [f49449fbc21e7e9550a5203902d69c8ae7dfd918] usb: 
>>> gadget: u_ether: Replace netif_stop_queue with netif_device_detach
>>>
>>> Note, revert indeed helps. Should I send a revert?
>>>
>>> I use configfs to setup USB EEM function and it worked till this 
>>> commit.
>>> If needed, I can share my scripts, but I believe it's not needed as 
>>> here
>>> we see a clear regression.
>>>
>>> -- 
>>> With Best Regards,
>>> Andy Shevchenko
>>>
>>>
>>
>> Without this patch, there may be a potential crash in a race 
>> condition, as __LINK_STATE_PRESENT is monitored at many places in the 
>> Network stack to determine the status of the link.
>>
>> Could you please provide details on how this patch affects your 
>> functionality? Are you experiencing connection problems or data 
>> transfer interruptions?
>
> In my case on mrfld (Intel Edison Arduino) using configfs with this 
> patch no config from host through dhcp is received. Manual setting 
> correct ipv4 addr / mask / gw still no connection.
>
>> Instead of reverting this patch, consider trying the upcoming patch 
>> (soon to be available in the mainline) to see if it resolves your issue.
>>
>> https://lore.kernel.org/lkml/2023122900-commence-agenda-db2c@gregkh/T/#m36a812d3f1e5d744ee32381f6ae4185940b376de 
>>
>
> This patch works for me with v6.7.0.

I need to revisit this. The patch in this topic landed in v6.7.0-rc1 
(f49449fbc21e) and breaks the gadget mrfld (Intel Edison Arduino) and 
other platforms as well.

The mentioned fix "usb: gadget: u_ether: Re-attach netif device to 
mirror detachment*" * has landed in v6.8.0-rc1 (76c945730). What it does 
fix: I am able to make a USB EEM function again.

However, now a hidden issue appears. With mrfld there is an external 
switch to easily switch between host and device mode.

What is not fixed:

- when in device mode and unplugging/plugging the cable when using 
`ifconfig usb0` the line "usb0: 
flags=4163<UP,BROADCAST,RUNNING,MULTICAST>" changes to "usb0: 
flags=4099<UP,BROADCAST,MULTICAST>" as is supposed to, the route table 
is updated and the dir `/sys/class/net/usb0` exists and in the dir `cat 
carrier*` shows the carrier up and down counts. This is the expected 
behavior.

- when in device mode and switching to host mode `ifconfig usb0` 
continues to show "RUNNING", the route table is not modified and the dir 
`/sys/class/net/usb0` no longer exists.

- switching to device mode again, USB EEM works fine, no changes to 
RUNNING or the route table happen and the dir `/sys/class/net/usb0` 
still is non- existing.

- unplugging/plugging the cable in device mode after this does not 
restore the original situation.

This behavior I tested on v6.9.0-rc2 (with a few unrelated but essential 
patches on top) and bisected back to this patch in v6.70-rc1.

It seems `netif_device_detach` does not completely clean up as expected 
and `netif_device_attach` does not completely rebuild.

I am wondering if on other platforms this can be reproduced? If so, inho 
it would be best to revert the both patches until the issue is resolved.

Thanks,

Ferry

>> Thanks,
>> Hardik
>

