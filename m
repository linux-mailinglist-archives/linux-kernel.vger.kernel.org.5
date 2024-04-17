Return-Path: <linux-kernel+bounces-148773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CE38A8731
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5273C1C20E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3946C1487DB;
	Wed, 17 Apr 2024 15:14:00 +0000 (UTC)
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741A2146D5E;
	Wed, 17 Apr 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366839; cv=none; b=RCkt7url/1F6NTS6ZpoOJPEh+jTJc3HwBmmKCl0mf44Hd82fQ9GMTbGJQ2wuouv1ybKkJiY5EO4k2q8ry0askvtt1gZMmuFCpLj+mZl6vimEsvgbuErrVvPMSkols+KyRPvHJ9zBVkhu1HiaVa3HeM6SWQWDBVsRok4hSetYhKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366839; c=relaxed/simple;
	bh=ReJbikJ2kepuUijelUZQhkZwPh2q88Pj0bpQ80tCjGE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTpXsLN9TLz37Q+nspuwaXbvX3xIRAbGqJrBeh6hvF5vkGgEfsGhdnBf2dpyZXX/Q5PUwxCn1MchkdgTtvELmmYd3IayOYOCpQjdsT145DtWSNvMRUyA/RYhNUfMNGQq5jMPDTVBxv8XIdQMQizgZN1prwxP4/hsxvCuXg6qHGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 68F0D5203A7;
	Wed, 17 Apr 2024 17:13:47 +0200 (CEST)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.37; Wed, 17 Apr
 2024 17:13:47 +0200
Date: Wed, 17 Apr 2024 17:13:42 +0200
From: Hardik Gajjar <hgajjar@de.adit-jv.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Ferry Toth <fntoth@gmail.com>, Hardik Gajjar <hgajjar@de.adit-jv.com>,
	<gregkh@linuxfoundation.org>, <s.hauer@pengutronix.de>,
	<jonathanh@nvidia.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <quic_linyyuan@quicinc.com>,
	<paul@crapouillou.net>, <quic_eserrao@quicinc.com>, <erosca@de.adit-jv.com>
Subject: Re: [PATCH v4] usb: gadget: u_ether: Replace netif_stop_queue with
 netif_device_detach
Message-ID: <20240417151342.GA56989@vmlxhi-118.adit-jv.com>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zh6BsK8F3gCzGJfE@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

On Tue, Apr 16, 2024 at 04:48:32PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 11, 2024 at 10:52:36PM +0200, Ferry Toth wrote:
> > Op 11-04-2024 om 18:39 schreef Andy Shevchenko:
> > > On Thu, Apr 11, 2024 at 04:26:37PM +0200, Hardik Gajjar wrote:
> > > > On Wed, Apr 10, 2024 at 08:37:42PM +0300, Andy Shevchenko wrote:
> > > > > On Sun, Apr 07, 2024 at 10:51:51PM +0200, Ferry Toth wrote:
> > > > > > Op 05-04-2024 om 13:38 schreef Hardik Gajjar:
> 
> ...
> 
> > > > > > Exactly. And this didn't happen before the 2 patches.
> > > > > > 
> > > > > > To be precise: /sys/class/net/usb0 is not removed and it is a link, the link
> > > > > > target /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/net/usb0 no
> > > > > > longer exists
> > > > So, it means that the /sys/class/net/usb0 is present, but the symlink is
> > > > broken. In that case, the dwc3 driver should recreate the device, and the
> > > > symlink should become active again
> > 
> > Yes, on first enabling gadget (when device mode is activated):
> > 
> > root@yuna:~# ls /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
> > driver  net  power  sound  subsystem  suspended  uevent
> > 
> > Then switching to host mode:
> > 
> > root@yuna:~# ls /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
> > ls: cannot access
> > '/sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/': No such file
> > or directory
> > 
> > Then back to device mode:
> > 
> > root@yuna:~# ls /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
> > driver  power  sound  subsystem  suspended  uevent
> > 
> > net is missing. But, network functions:
> > 
> > root@yuna:~# ping 10.42.0.1
> > PING 10.42.0.1 (10.42.0.1): 56 data bytes
> > 
> > Mass storage device is created and removed each time as expected.
> 
> So, what's the conclusion? Shall we move towards revert of those two changes?


As promised, I have the tested the this patch with the dwc3 gadget. I could not reproduce
the issue. 

I can see the usb0 exist all the time and accessible regardless of the role switching of the USB mode (peripheral <-> host)

Following are the logs:
//Host to device

console:/sys/bus/platform/devices/a800000.ssusb # echo "peripheral" > mode
console:/sys/bus/platform/devices/a800000.ssusb # ls a800000.dwc3/gadget/net/
usb0

//device to host
console:/sys/bus/platform/devices/a800000.ssusb # echo "host" > mode
console:/sys/bus/platform/devices/a800000.ssusb # ls a800000.dwc3/gadget/net/
usb0
s a800000.dwc3/gadget/net/usb0                                                <
addr_assign_type    duplex             phys_port_name
addr_len            flags              phys_switch_id
address             gro_flush_timeout  power
broadcast           ifalias            proto_down
carrier             ifindex            queues
carrier_changes     iflink             speed
carrier_down_count  link_mode          statistics
carrier_up_count    mtu                subsystem
dev_id              name_assign_type   tx_queue_len
dev_port            netdev_group       type
device              operstate          uevent
dormant             phys_port_id       waiting_for_supplier
console:/sys/bus/platform/devices/a800000.ssusb # ifconfig -a usb0
usb0      Link encap:Ethernet  HWaddr 3a:8b:63:97:1a:9a
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 TX bytes:0

console:/sys/bus/platform/devices/a800000.ssusb #

I strongly advise against reverting the patch solely based on the observed issue of removing the /sys/class/net/usb0 directory while the usb0 interface remains available. 
Instead, I recommend enabling FTRACE to trace the functions involved and identify which faulty call is responsible for removing usb0.

According to current kernel architecture of u_ether driver, only gether_cleanup should remove the usb0 interface along with its kobject and sysfs interface.
I suggest sharing the analysis here to understand why this practice is not followed in your use case or driver ?

I am curious why the driver was developed without adhering to the kernel's gadget architecture.

> 
> > > > I have the dwc3 IP base usb controller, Let me check with this patch and
> > > > share result here.  May be we need some fix in dwc3
> > Would have been nice if someone could test on other controller as well. But
> > another instance of dwc3 is also very welcome.
> > > It's quite possible, please test on your side.
> > > We are happy to test any fixes if you come up with.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

