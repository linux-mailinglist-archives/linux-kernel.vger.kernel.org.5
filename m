Return-Path: <linux-kernel+bounces-26463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C5C82E14E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9012837CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE5E19477;
	Mon, 15 Jan 2024 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3dkaKTi"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBB011190;
	Mon, 15 Jan 2024 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e4e3323a6so9641764e87.0;
        Mon, 15 Jan 2024 12:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705349461; x=1705954261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2scrAorqhTdNjmhFlkO+08vbWn1dSzwQYA+mCWsr0io=;
        b=H3dkaKTiEsQCQniR3futjVveCMjVdj0J9ImSNNtlSPI6u7ku+gL2VO48FHUrMmrzuc
         tLiUSfvqGxxBH2xMj967j8NtHKvLK9PCfX/VqKH5SSdlulAgNHRt/ryGD2mhb6sEXHC+
         cwADzBkcbjXI/+bybojlWE62pKkciB39RwrbxMfJ0hMd8qTeeAsjRH8db3GLAkg5Byrg
         J06dhT7DQ6qg2FEnwSIXo+hIzSkkr7ZC49Vo7yTkSeK2YeQE6BBwfhpjp3u13KvSHx3r
         ekUWZlscnAZxrLTxplNl+TbNkr4+IpnEEp6bILaISYBdeRsJEVD2ey+Z9znZAMnaqp4l
         20CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705349461; x=1705954261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2scrAorqhTdNjmhFlkO+08vbWn1dSzwQYA+mCWsr0io=;
        b=aqncdPtFLx0zHEWHeybQpa/94PwFS0jEvfz+6fmWWasZLBvg2NrLdk0yTwbOFugdz5
         Fs7GSOuZR6nyX5DWZryxFnJUL2CaoHU0J9eohvztnDKCZtAu7I4NI3rBhInYVAvN964P
         A3zLfEyj4UGG4hI2eBXpJoB4yMVoec086+5B8OOpCwC9+F1eux214nPJZsp29MA0hwU0
         y6SZr4WK76RZCrbB0blKHE5bdhX6YeSfioQ7TY3tca/Q6yg1O9vD8EuYSoNZefFuzPOF
         rKlUFO0SFq6oUIWH+GNI33Ww39PuQ5lzU3rdOj/luSwhGajb2q8584/xRHlx4/z/t7SM
         j4bA==
X-Gm-Message-State: AOJu0YyeA9ZszFIFTO62puuwBvU87aW9yrHU4KPJwVeRM5uSOa9YbAnK
	tYS6C3CyS369PuvnKF4CgtE=
X-Google-Smtp-Source: AGHT+IElEMmJVJzUW6tGmecCRRbDwWxsBQEffklaD2hZsiqOE5iQ79epTj/lX2MYJsxAvyTwoeNy9A==
X-Received: by 2002:a05:6512:29b:b0:50e:5770:718b with SMTP id j27-20020a056512029b00b0050e5770718bmr3939169lfp.11.1705349461208;
        Mon, 15 Jan 2024 12:11:01 -0800 (PST)
Received: from ?IPV6:2a02:a466:68ed:1:176c:f513:1187:6521? (2a02-a466-68ed-1-176c-f513-1187-6521.fixed6.kpn.net. [2a02:a466:68ed:1:176c:f513:1187:6521])
        by smtp.gmail.com with ESMTPSA id y3-20020ac24e63000000b0050e7e92d211sm1545416lfs.45.2024.01.15.12.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 12:11:00 -0800 (PST)
Message-ID: <f25283fc-4550-4725-960b-2ea783fd62e1@gmail.com>
Date: Mon, 15 Jan 2024 21:10:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: gadget: u_ether: Replace netif_stop_queue with
 netif_device_detach
Content-Language: en-US
To: Hardik Gajjar <hgajjar@de.adit-jv.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ferry Toth <ftoth@exalondelft.nl>, gregkh@linuxfoundation.org,
 s.hauer@pengutronix.de, jonathanh@nvidia.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_linyyuan@quicinc.com,
 paul@crapouillou.net, quic_eserrao@quicinc.com, erosca@de.adit-jv.com
References: <20231006153808.9758-1-hgajjar@de.adit-jv.com>
 <20231006155646.12938-1-hgajjar@de.adit-jv.com>
 <ZaQS5x-XK08Jre6I@smile.fi.intel.com>
 <20240115132720.GA98840@vmlxhi-118.adit-jv.com>
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20240115132720.GA98840@vmlxhi-118.adit-jv.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Op 15-01-2024 om 14:27 schreef Hardik Gajjar:
> On Sun, Jan 14, 2024 at 06:59:19PM +0200, Andy Shevchenko wrote:
>> +Cc: Ferry.
>>
>> On Fri, Oct 06, 2023 at 05:56:46PM +0200, Hardik Gajjar wrote:
>>> This patch replaces the usage of netif_stop_queue with netif_device_detach
>>> in the u_ether driver. The netif_device_detach function not only stops all
>>> tx queues by calling netif_tx_stop_all_queues but also marks the device as
>>> removed by clearing the __LINK_STATE_PRESENT bit.
>>>
>>> This change helps notify user space about the disconnection of the device
>>> more effectively, compared to netif_stop_queue, which only stops a single
>>> transmit queue.
>>
>> This change effectively broke my USB ether setup.
>>
>> git bisect start
>> # status: waiting for both good and bad commits
>> # good: [1f24458a1071f006e3f7449c08ae0f12af493923] Merge tag 'tty-6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
>> git bisect good 1f24458a1071f006e3f7449c08ae0f12af493923
>> # status: waiting for bad commit, 1 good commit known
>> # bad: [2c40c1c6adab90ee4660caf03722b3a3ec67767b] Merge tag 'usb-6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
>> git bisect bad 2c40c1c6adab90ee4660caf03722b3a3ec67767b
>> # bad: [17d6b82d2d6d467149874b883cdba844844b996d] usb/usbip: fix wrong data added to platform device
>> git bisect bad 17d6b82d2d6d467149874b883cdba844844b996d
>> # good: [ba6b83a910b6d8a9379bda55cbf06cb945473a96] usb: xhci-mtk: add a bandwidth budget table
>> git bisect good ba6b83a910b6d8a9379bda55cbf06cb945473a96
>> # good: [dddc00f255415b826190cfbaa5d6dbc87cd9ded1] Revert "usb: gadget: uvc: cleanup request when not in correct state"
>> git bisect good dddc00f255415b826190cfbaa5d6dbc87cd9ded1
>> # bad: [8f999ce60ea3d47886b042ef1f22bb184b6e9c59] USB: typec: tps6598x: Refactor tps6598x port registration
>> git bisect bad 8f999ce60ea3d47886b042ef1f22bb184b6e9c59
>> # bad: [f49449fbc21e7e9550a5203902d69c8ae7dfd918] usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach
>> git bisect bad f49449fbc21e7e9550a5203902d69c8ae7dfd918
>> # good: [97475763484245916735a1aa9a3310a01d46b008] USB: usbip: fix stub_dev hub disconnect
>> git bisect good 97475763484245916735a1aa9a3310a01d46b008
>> # good: [0f5aa1b01263b8b621bc4f031a1f2983ef8517b7] usb: usbtest: fix a type promotion bug
>> git bisect good 0f5aa1b01263b8b621bc4f031a1f2983ef8517b7
>> # first bad commit: [f49449fbc21e7e9550a5203902d69c8ae7dfd918] usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach
>>
>> Note, revert indeed helps. Should I send a revert?
>>
>> I use configfs to setup USB EEM function and it worked till this commit.
>> If needed, I can share my scripts, but I believe it's not needed as here
>> we see a clear regression.
>>
>> -- 
>> With Best Regards,
>> Andy Shevchenko
>>
>>
> 
> Without this patch, there may be a potential crash in a race condition, as __LINK_STATE_PRESENT is monitored at many places in the Network stack to determine the status of the link.
> 
> Could you please provide details on how this patch affects your functionality? Are you experiencing connection problems or data transfer interruptions?

In my case on mrfld (Intel Edison Arduino) using configfs with this 
patch no config from host through dhcp is received. Manual setting 
correct ipv4 addr / mask / gw still no connection.

> Instead of reverting this patch, consider trying the upcoming patch (soon to be available in the mainline) to see if it resolves your issue.
> 
> https://lore.kernel.org/lkml/2023122900-commence-agenda-db2c@gregkh/T/#m36a812d3f1e5d744ee32381f6ae4185940b376de

This patch works for me with v6.7.0.

> Thanks,
> Hardik


