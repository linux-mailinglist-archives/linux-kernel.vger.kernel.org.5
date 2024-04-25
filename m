Return-Path: <linux-kernel+bounces-159208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ACB8B2ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42061F21AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206D0155A39;
	Thu, 25 Apr 2024 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEXu8/Cm"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AF8153812;
	Thu, 25 Apr 2024 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080473; cv=none; b=lcsPzImFrLrPA/vpjTM/dBWpT7RTlCNGvWUk8ew65fa5yYxwajjqeMOrRaTq9+9f1PGoLmSyApYRUyuVLDTwTjStd+LWtLwtev0f19RlEZxZ9i/JKcylJFeQF/pryKoclE2Mr8Wr0nxjaxFeZmvPidK5a3JhDS28ovtRHA/i97o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080473; c=relaxed/simple;
	bh=psx9BZYmFV9bz0acvXBcIrIlmbT+veMViuEJI/CsI8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyW4B9WujNzCAKW0i2yK6uRIkFo3RGfX08/oQ9iYvdaOa2uM1nT5ipHwomx9uo4jqjjRUC1DoxYd6BvoGl7Fn3981waG6MaY+uKhLRyXi5JjeZ5nZBBawvrT79I1f6ZdsHo8aBc0/SxV6H8lBxhE7hahbppDk523CEKT/Xu/R+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEXu8/Cm; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e1f3462caso2008091a12.3;
        Thu, 25 Apr 2024 14:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714080470; x=1714685270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltvE+80RPDAHmMR3jhekEzOsCMsm5ckdzFq4WbDQd+w=;
        b=iEXu8/CmN2/tDXzaY7Wm+zt9qSLnIrXxM5MxWoMUyayg9O5bjh7rP3Pc7ZzFGrGo7z
         2vK6QLl83wiC7pG7+3BBWDw2w7Y99Zxkr6YC9jj5ShSxb++Rxawau/XkO6OGkRDDjRqD
         EU92HdgkJvI6LGNm5fQTe21Xnu0ADi0+o7fzt6V3+L4I9922QGWDB6Ogwxowb3EpI8j4
         Gm5s43+koPPNrO8mtVsgDQYs6pc/b/nTbAC9ria4+Bp7IagLTfBxChhHyfaZNt6J1mgw
         EzwmW1KZOOAtaWCeDA9fO+12Ck1XRcSF6gF1nv6tCoP4V7ZWGm/5thH4zZSLBmc4twlT
         pW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714080470; x=1714685270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltvE+80RPDAHmMR3jhekEzOsCMsm5ckdzFq4WbDQd+w=;
        b=AaNYSG86FCwy8L+LKGVTL4Y7gpkQp8zIZkigQz0UY1qQSGxBtG4ecr3JwAu9GKmT8h
         yVs27J+t7gVCjYxoPwXVcPI7HwG+Vup3QqCuKVJGhbupIw0MuY2HEXTREpbC0q5mBr49
         2oulVY4VFNVC8a8WL4Fa5+oC6BXgb0P7FbLcu9USQP6iJtwg98H/PhG3YHbW9ELz7UjJ
         bAd7Ne1wnZ97FfdtkRe3QyMaQfzlacxC+t3rf89Uko278I6DOLq2Ryfee85EaGhl5ZNL
         yHCJ7B4xjaLtbS1xX5M60rPR41vG2z1tP75K8z/G64xFJb7nw+jqUKSGbpDvhHmomU+S
         rt/A==
X-Forwarded-Encrypted: i=1; AJvYcCVGnmC4P6vDcxpnSPartnzRXM9HrA5ikKKSt6H/yC4gkSL1P/0D2L6C8k2ZEq4KhiyUE+InXfr1qUp9mncMW5bISzRQmN28jhVODUq3hD12QvGpqRUwu8u6Zbbx38RuyKT00Aiqol0O
X-Gm-Message-State: AOJu0YxE/QvDy5lapIJTdMp36dTT8agbVXBUS1C07hcy94/VgG9ymS/8
	AIC3El4Nw3sggThjZ/YfvRmnqDf/eMo/E7rrHaa5o3sNL2PRtCYu
X-Google-Smtp-Source: AGHT+IE1B+VlQAB2FC+41+K1812I6TzbwNtx7BU3K/bBv752Q+yhsmjuLUH8WkNlU2pM/T8QJ7hV3g==
X-Received: by 2002:a50:d7da:0:b0:56d:f54a:8765 with SMTP id m26-20020a50d7da000000b0056df54a8765mr599235edj.23.1714080469364;
        Thu, 25 Apr 2024 14:27:49 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:7697:d12:5d01:2fe6? (2a02-a466-68ed-1-7697-d12-5d01-2fe6.fixed6.kpn.net. [2a02:a466:68ed:1:7697:d12:5d01:2fe6])
        by smtp.gmail.com with ESMTPSA id em8-20020a056402364800b0057021b811eesm9384295edb.67.2024.04.25.14.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 14:27:48 -0700 (PDT)
Message-ID: <d94f37cf-8140-4f89-aa67-53f9291faff3@gmail.com>
Date: Thu, 25 Apr 2024 23:27:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: gadget: u_ether: Replace netif_stop_queue with
 netif_device_detach
To: Hardik Gajjar <hgajjar@de.adit-jv.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: gregkh@linuxfoundation.org, s.hauer@pengutronix.de, jonathanh@nvidia.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_linyyuan@quicinc.com, paul@crapouillou.net, quic_eserrao@quicinc.com,
 erosca@de.adit-jv.com
References: <20240115132720.GA98840@vmlxhi-118.adit-jv.com>
 <f25283fc-4550-4725-960b-2ea783fd62e1@gmail.com>
 <aeee83d8-dee3-42ed-b705-988b17800721@gmail.com>
 <20240405113855.GA121923@vmlxhi-118.adit-jv.com>
 <321e908e-0d10-4e36-8dc4-6997c73fe2eb@gmail.com>
 <ZhbOZsp-XHemVhQz@smile.fi.intel.com>
 <20240411142637.GA110162@vmlxhi-118.adit-jv.com>
 <ZhgSPCq6sVejRjbj@smile.fi.intel.com>
 <be8904bd-71ea-4ae1-b0bc-9170461fd0d9@gmail.com>
 <Zh6BsK8F3gCzGJfE@smile.fi.intel.com>
 <20240417151342.GA56989@vmlxhi-118.adit-jv.com>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20240417151342.GA56989@vmlxhi-118.adit-jv.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Op 17-04-2024 om 17:13 schreef Hardik Gajjar:
> On Tue, Apr 16, 2024 at 04:48:32PM +0300, Andy Shevchenko wrote:
>> On Thu, Apr 11, 2024 at 10:52:36PM +0200, Ferry Toth wrote:
>>> Op 11-04-2024 om 18:39 schreef Andy Shevchenko:
>>>> On Thu, Apr 11, 2024 at 04:26:37PM +0200, Hardik Gajjar wrote:
>>>>> On Wed, Apr 10, 2024 at 08:37:42PM +0300, Andy Shevchenko wrote:
>>>>>> On Sun, Apr 07, 2024 at 10:51:51PM +0200, Ferry Toth wrote:
>>>>>>> Op 05-04-2024 om 13:38 schreef Hardik Gajjar:
>>
>> ...
>>
>>>>>>> Exactly. And this didn't happen before the 2 patches.
>>>>>>>
>>>>>>> To be precise: /sys/class/net/usb0 is not removed and it is a link, the link
>>>>>>> target /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/net/usb0 no
>>>>>>> longer exists
>>>>> So, it means that the /sys/class/net/usb0 is present, but the symlink is
>>>>> broken. In that case, the dwc3 driver should recreate the device, and the
>>>>> symlink should become active again
>>>
>>> Yes, on first enabling gadget (when device mode is activated):
>>>
>>> root@yuna:~# ls /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
>>> driver  net  power  sound  subsystem  suspended  uevent
>>>
>>> Then switching to host mode:
>>>
>>> root@yuna:~# ls /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
>>> ls: cannot access
>>> '/sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/': No such file
>>> or directory
>>>
>>> Then back to device mode:
>>>
>>> root@yuna:~# ls /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
>>> driver  power  sound  subsystem  suspended  uevent
>>>
>>> net is missing. But, network functions:
>>>
>>> root@yuna:~# ping 10.42.0.1
>>> PING 10.42.0.1 (10.42.0.1): 56 data bytes
>>>
>>> Mass storage device is created and removed each time as expected.
>>
>> So, what's the conclusion? Shall we move towards revert of those two changes?
> 
> 
> As promised, I have the tested the this patch with the dwc3 gadget. I could not reproduce
> the issue.
> 
> I can see the usb0 exist all the time and accessible regardless of the role switching of the USB mode (peripheral <-> host)
> 
> Following are the logs:
> //Host to device
> 
> console:/sys/bus/platform/devices/a800000.ssusb # echo "peripheral" > mode
> console:/sys/bus/platform/devices/a800000.ssusb # ls a800000.dwc3/gadget/net/
> usb0
> 
> //device to host
> console:/sys/bus/platform/devices/a800000.ssusb # echo "host" > mode
> console:/sys/bus/platform/devices/a800000.ssusb # ls a800000.dwc3/gadget/net/
> usb0

That is weird. When I switch to host mode (using the physical switch), 
the whole gadget directory is removed (now testing 6.9.0-rc5)

Switching back to device mode, that gadget directory is recreated. And 
gadget/sound as well, but not gadget/net.

> s a800000.dwc3/gadget/net/usb0                                                <
> addr_assign_type    duplex             phys_port_name
> addr_len            flags              phys_switch_id
> address             gro_flush_timeout  power
> broadcast           ifalias            proto_down
> carrier             ifindex            queues
> carrier_changes     iflink             speed
> carrier_down_count  link_mode          statistics
> carrier_up_count    mtu                subsystem
> dev_id              name_assign_type   tx_queue_len
> dev_port            netdev_group       type
> device              operstate          uevent
> dormant             phys_port_id       waiting_for_supplier
> console:/sys/bus/platform/devices/a800000.ssusb # ifconfig -a usb0
> usb0      Link encap:Ethernet  HWaddr 3a:8b:63:97:1a:9a
>            BROADCAST MULTICAST  MTU:1500  Metric:1
>            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:1000
>            RX bytes:0 TX bytes:0
> 
> console:/sys/bus/platform/devices/a800000.ssusb #
> 
> I strongly advise against reverting the patch solely based on the observed issue of removing the /sys/class/net/usb0 directory while the usb0 interface remains available.

There's more to it. I also mentioned that switching the role or 
unplugging the cable leaves the usb0 connection.

I have while in host mode:
root@yuna:~# ifconfig -a usb0
usb0: flags=-28605<UP,BROADCAST,RUNNING,MULTICAST,DYNAMIC>  mtu 1500
         inet 10.42.0.221  netmask 255.255.255.0  broadcast 10.42.0.255
         inet6 fe80::a8bb:ccff:fedd:eef1  prefixlen 64  scopeid 0x20<link>


You don't see that because you didn't create a connection at all.

> Instead, I recommend enabling FTRACE to trace the functions involved and identify which faulty call is responsible for removing usb0.

Switching from device -> host -> device:

root@yuna:~# trace-cmd record -p function_graph -l *gether_*
   plugin 'function_graph'
Hit Ctrl^C to stop recording
^CCPU0 data recorded at offset=0x1c8000
     188 bytes in size (4096 uncompressed)
CPU1 data recorded at offset=0x1c9000
     0 bytes in size (0 uncompressed)
root@yuna:~# trace-cmd report
cpus=2
      irq/68-dwc3-725   [000]   514.575337: funcgraph_entry:      # 
2079.480 us |  gether_disconnect();
      irq/68-dwc3-946   [000]   524.263731: funcgraph_entry:      + 
11.640 us  |  gether_disconnect();
      irq/68-dwc3-946   [000]   524.263743: funcgraph_entry:      ! 
116.520 us |  gether_connect();
      irq/68-dwc3-946   [000]   524.268029: funcgraph_entry:      # 
2057.260 us |  gether_disconnect();
      irq/68-dwc3-946   [000]   524.270089: funcgraph_entry:      ! 
109.000 us |  gether_connect();


> According to current kernel architecture of u_ether driver, only gether_cleanup should remove the usb0 interface along with its kobject and sysfs interface.
> I suggest sharing the analysis here to understand why this practice is not followed in your use case or driver ?

Yes, I'll try to trace where that happens.

Nevertheless, the disappearance of the net/usb0 directory seems 
harmless? But the usb: net device remaining after disconnect or role 
switch is not good, as the route remains.

May be they are 2 separate problems. Could you try to reproduce what 
happens if you make eem connection and then unplug?

> I am curious why the driver was developed without adhering to the kernel's gadget architecture.
> 
>>
>>>>> I have the dwc3 IP base usb controller, Let me check with this patch and
>>>>> share result here.  May be we need some fix in dwc3
>>> Would have been nice if someone could test on other controller as well. But
>>> another instance of dwc3 is also very welcome.
>>>> It's quite possible, please test on your side.
>>>> We are happy to test any fixes if you come up with.
>>
>> -- 
>> With Best Regards,
>> Andy Shevchenko
>>
>>


