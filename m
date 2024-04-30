Return-Path: <linux-kernel+bounces-164284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A518B7BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCFD0B294E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB651CFB6;
	Tue, 30 Apr 2024 15:32:54 +0000 (UTC)
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F25BE49;
	Tue, 30 Apr 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491174; cv=none; b=VDr7QkJzv0LtgsrDhAOn+qV5cYZrVoyBzUrBLdkRGfWW5kRjGoc5V9rPfuCfuPFCAdUtm+ZNLTDjrFkBzYsz9/nKL+q8epHhMOjBXBlXaasfA9aq8uR+OnS4ksvY6QI4jaTtU0pqiTwYCpShgNqiVaJgD0/R7VgbNDNgpdsH1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491174; c=relaxed/simple;
	bh=BXq4IiRdv5CjXBAP5Z694gpULhqb3OM4GV35nudmfmo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iugw6l14vXjUy2QA+HJVJ4iM2+HtlFPnrjeuUH91RZDOR6G9lJt9KfhOT28Ca0I2DNE0PKU48Sbrg9dyWH/dElzBjeRWVngeIKh14yw2negyyDaHDFkVwPPFEOtsq9mJchX/qi2peOSfGkUAt03JXGXqWVtmey/Vpcap8C2f5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 06815520150;
	Tue, 30 Apr 2024 17:32:48 +0200 (CEST)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.37; Tue, 30 Apr
 2024 17:32:47 +0200
Date: Tue, 30 Apr 2024 17:32:43 +0200
From: Hardik Gajjar <hgajjar@de.adit-jv.com>
To: Ferry Toth <fntoth@gmail.com>
CC: Hardik Gajjar <hgajjar@de.adit-jv.com>, Andy Shevchenko
	<andriy.shevchenko@intel.com>, <gregkh@linuxfoundation.org>,
	<s.hauer@pengutronix.de>, <jonathanh@nvidia.com>,
	<linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<quic_linyyuan@quicinc.com>, <paul@crapouillou.net>,
	<quic_eserrao@quicinc.com>, <erosca@de.adit-jv.com>
Subject: Re: [PATCH v4] usb: gadget: u_ether: Replace netif_stop_queue with
 netif_device_detach
Message-ID: <20240430153243.GA129136@vmlxhi-118.adit-jv.com>
References: <20240405113855.GA121923@vmlxhi-118.adit-jv.com>
 <321e908e-0d10-4e36-8dc4-6997c73fe2eb@gmail.com>
 <ZhbOZsp-XHemVhQz@smile.fi.intel.com>
 <20240411142637.GA110162@vmlxhi-118.adit-jv.com>
 <ZhgSPCq6sVejRjbj@smile.fi.intel.com>
 <be8904bd-71ea-4ae1-b0bc-9170461fd0d9@gmail.com>
 <Zh6BsK8F3gCzGJfE@smile.fi.intel.com>
 <20240417151342.GA56989@vmlxhi-118.adit-jv.com>
 <d94f37cf-8140-4f89-aa67-53f9291faff3@gmail.com>
 <5dae4b62-24d4-4942-934a-38c548a2fdbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dae4b62-24d4-4942-934a-38c548a2fdbc@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

On Sun, Apr 28, 2024 at 11:07:36PM +0200, Ferry Toth wrote:
> Hi,
> 
> Op 25-04-2024 om 23:27 schreef Ferry Toth:
> > Hi,
> > 
> > Op 17-04-2024 om 17:13 schreef Hardik Gajjar:
> > > On Tue, Apr 16, 2024 at 04:48:32PM +0300, Andy Shevchenko wrote:
> > > > On Thu, Apr 11, 2024 at 10:52:36PM +0200, Ferry Toth wrote:
> > > > > Op 11-04-2024 om 18:39 schreef Andy Shevchenko:
> > > > > > On Thu, Apr 11, 2024 at 04:26:37PM +0200, Hardik Gajjar wrote:
> > > > > > > On Wed, Apr 10, 2024 at 08:37:42PM +0300, Andy Shevchenko wrote:
> > > > > > > > On Sun, Apr 07, 2024 at 10:51:51PM +0200, Ferry Toth wrote:
> > > > > > > > > Op 05-04-2024 om 13:38 schreef Hardik Gajjar:
> > > > 
> > > > ...
> > > > 
> > > > > > > > > Exactly. And this didn't happen before the 2 patches.
> > > > > > > > > 
> > > > > > > > > To be precise: /sys/class/net/usb0 is not
> > > > > > > > > removed and it is a link, the link
> > > > > > > > > target /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/net/usb0
> > > > > > > > > no
> > > > > > > > > longer exists
> > > > > > > So, it means that the /sys/class/net/usb0 is
> > > > > > > present, but the symlink is
> > > > > > > broken. In that case, the dwc3 driver should
> > > > > > > recreate the device, and the
> > > > > > > symlink should become active again
> > > > > 
> > > > > Yes, on first enabling gadget (when device mode is activated):
> > > > > 
> > > > > root@yuna:~# ls
> > > > > /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
> > > > > driver  net  power  sound  subsystem  suspended  uevent
> > > > > 
> > > > > Then switching to host mode:
> > > > > 
> > > > > root@yuna:~# ls
> > > > > /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
> > > > > ls: cannot access
> > > > > '/sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/':
> > > > > No such file
> > > > > or directory
> > > > > 
> > > > > Then back to device mode:
> > > > > 
> > > > > root@yuna:~# ls
> > > > > /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
> > > > > driver  power  sound  subsystem  suspended  uevent
> > > > > 
> > > > > net is missing. But, network functions:
> > > > > 
> > > > > root@yuna:~# ping 10.42.0.1
> > > > > PING 10.42.0.1 (10.42.0.1): 56 data bytes
> > > > > 
> > > > > Mass storage device is created and removed each time as expected.
> > > > 
> > > > So, what's the conclusion? Shall we move towards revert of those
> > > > two changes?
> > > 
> > > 
> > > As promised, I have the tested the this patch with the dwc3 gadget.
> > > I could not reproduce
> > > the issue.
> > > 
> > > I can see the usb0 exist all the time and accessible regardless of
> > > the role switching of the USB mode (peripheral <-> host)
> > > 
> > > Following are the logs:
> > > //Host to device
> > > 
> > > console:/sys/bus/platform/devices/a800000.ssusb # echo "peripheral"
> > > > mode
> > > console:/sys/bus/platform/devices/a800000.ssusb # ls
> > > a800000.dwc3/gadget/net/
> > > usb0
> > > 
> > > //device to host
> > > console:/sys/bus/platform/devices/a800000.ssusb # echo "host" > mode
> > > console:/sys/bus/platform/devices/a800000.ssusb # ls
> > > a800000.dwc3/gadget/net/
> > > usb0
> > 
> > That is weird. When I switch to host mode (using the physical switch),
> > the whole gadget directory is removed (now testing 6.9.0-rc5)
> > 
> > Switching back to device mode, that gadget directory is recreated. And
> > gadget/sound as well, but not gadget/net.
> > 
> > > s a800000.dwc3/gadget/net/usb0                                               
> > > <
> > > addr_assign_type    duplex             phys_port_name
> > > addr_len            flags              phys_switch_id
> > > address             gro_flush_timeout  power
> > > broadcast           ifalias            proto_down
> > > carrier             ifindex            queues
> > > carrier_changes     iflink             speed
> > > carrier_down_count  link_mode          statistics
> > > carrier_up_count    mtu                subsystem
> > > dev_id              name_assign_type   tx_queue_len
> > > dev_port            netdev_group       type
> > > device              operstate          uevent
> > > dormant             phys_port_id       waiting_for_supplier
> > > console:/sys/bus/platform/devices/a800000.ssusb # ifconfig -a usb0
> > > usb0      Link encap:Ethernet  HWaddr 3a:8b:63:97:1a:9a
> > >            BROADCAST MULTICAST  MTU:1500  Metric:1
> > >            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> > >            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
> > >            collisions:0 txqueuelen:1000
> > >            RX bytes:0 TX bytes:0
> > > 
> > > console:/sys/bus/platform/devices/a800000.ssusb #
> > > 
> > > I strongly advise against reverting the patch solely based on the
> > > observed issue of removing the /sys/class/net/usb0 directory while
> > > the usb0 interface remains available.
> > 
> > There's more to it. I also mentioned that switching the role or
> > unplugging the cable leaves the usb0 connection.
> > 
> > I have while in host mode:
> > root@yuna:~# ifconfig -a usb0
> > usb0: flags=-28605<UP,BROADCAST,RUNNING,MULTICAST,DYNAMIC>  mtu 1500
> >          inet 10.42.0.221  netmask 255.255.255.0  broadcast 10.42.0.255
> >          inet6 fe80::a8bb:ccff:fedd:eef1  prefixlen 64  scopeid 0x20<link>
> > 
> > 
> > You don't see that because you didn't create a connection at all.
> > 
> > > Instead, I recommend enabling FTRACE to trace the functions involved
> > > and identify which faulty call is responsible for removing usb0.
> > 
> > Switching from device -> host -> device:
> > 
> > root@yuna:~# trace-cmd record -p function_graph -l *gether_*
> >    plugin 'function_graph'
> > Hit Ctrl^C to stop recording
> > ^CCPU0 data recorded at offset=0x1c8000
> >      188 bytes in size (4096 uncompressed)
> > CPU1 data recorded at offset=0x1c9000
> >      0 bytes in size (0 uncompressed)
> > root@yuna:~# trace-cmd report
> > cpus=2
> >       irq/68-dwc3-725   [000]   514.575337: funcgraph_entry:      #
> > 2079.480 us |  gether_disconnect();
> >       irq/68-dwc3-946   [000]   524.263731: funcgraph_entry:      +
> > 11.640 us  |  gether_disconnect();
> >       irq/68-dwc3-946   [000]   524.263743: funcgraph_entry:      !
> > 116.520 us |  gether_connect();
> >       irq/68-dwc3-946   [000]   524.268029: funcgraph_entry:      #
> > 2057.260 us |  gether_disconnect();
> >       irq/68-dwc3-946   [000]   524.270089: funcgraph_entry:      !
> > 109.000 us |  gether_connect();
> 
> I tried to get a more useful trace:
> root@yuna:/sys/kernel/tracing# echo 'gether_*' > set_ftrace_filter
> root@yuna:/sys/kernel/tracing# echo 'eem_*' >> set_ftrace_filter
> root@yuna:/sys/kernel/tracing# echo function > current_tracer
> root@yuna:/sys/kernel/tracing# echo 'reset_config' >> set_ftrace_filter
> -> switch to host mode then back to device
> root@yuna:/sys/kernel/tracing# cat trace
> # tracer: function
> #
> # entries-in-buffer/entries-written: 53/53   #P:2
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>      irq/68-dwc3-523     [000] D..3.   133.990254: reset_config
> <-__composite_disconnect
>      irq/68-dwc3-523     [000] D..3.   133.992274: eem_disable
> <-reset_config
>      irq/68-dwc3-523     [000] D..3.   133.992276: gether_disconnect
> <-reset_config
>      kworker/1:3-443     [001] ...1.   134.022453: eem_unbind
> <-purge_configs_funcs
> 
> -> to device mode
> 
>      kworker/1:3-443     [001] ...1.   148.630773: eem_bind
> <-usb_add_function
>      irq/68-dwc3-734     [000] D..3.   149.155209: eem_set_alt
> <-composite_setup
>      irq/68-dwc3-734     [000] D..3.   149.155215: gether_disconnect
> <-eem_set_alt
>      irq/68-dwc3-734     [000] D..3.   149.155220: gether_connect
> <-eem_set_alt
>      irq/68-dwc3-734     [000] D..3.   149.157287: eem_set_alt
> <-composite_setup
>      irq/68-dwc3-734     [000] D..3.   149.157292: gether_disconnect
> <-eem_set_alt
>      irq/68-dwc3-734     [000] D..3.   149.159338: gether_connect
> <-eem_set_alt
>      irq/68-dwc3-734     [000] D..2.   149.239625: eem_unwrap <-rx_complete
> ...
> 
> I don't know where to look exactly. Any hints?

do you see anything related to gether_cleanup() after eem_unbind() ?
If not then, you may try to enable tracing of TCP/IP stack and network side to check who deleting the sysfs entry

Hardik


> 
> > 
> > > According to current kernel architecture of u_ether driver, only
> > > gether_cleanup should remove the usb0 interface along with its
> > > kobject and sysfs interface.
> > > I suggest sharing the analysis here to understand why this practice
> > > is not followed in your use case or driver ?
> > 
> > Yes, I'll try to trace where that happens.
> > 
> > Nevertheless, the disappearance of the net/usb0 directory seems
> > harmless? But the usb: net device remaining after disconnect or role
> > switch is not good, as the route remains.
> > 
> > May be they are 2 separate problems. Could you try to reproduce what
> > happens if you make eem connection and then unplug?
> > 
> > > I am curious why the driver was developed without adhering to the
> > > kernel's gadget architecture.
> 
> I don't know what you mean here. Which driver do you mean?
> 
> > > > 
> > > > > > > I have the dwc3 IP base usb controller, Let me check
> > > > > > > with this patch and
> > > > > > > share result here.  May be we need some fix in dwc3
> > > > > Would have been nice if someone could test on other
> > > > > controller as well. But
> > > > > another instance of dwc3 is also very welcome.
> > > > > > It's quite possible, please test on your side.
> > > > > > We are happy to test any fixes if you come up with.
> > > > 
> > > > -- 
> > > > With Best Regards,
> > > > Andy Shevchenko
> > > > 
> > > > 
> > 

