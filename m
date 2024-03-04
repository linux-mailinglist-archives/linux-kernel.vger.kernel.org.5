Return-Path: <linux-kernel+bounces-90914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A0E8706B8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A2C28D6D3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ECD4C600;
	Mon,  4 Mar 2024 16:15:28 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id EF9954CB46
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568928; cv=none; b=l2rzLOzYoh32/7ztqHzhaJA9l+1QcQtEsXhgwquzd85binUoIg7hMRTpneqQgq1LTzYtnFrj4nTVsLd+yrlKFUeiePrMweKRZOvzSraLSD9tsflrD4w/NR25xJ/jl2fb6uL8YbGVjpWpV4jzrVvpaoJUmCjEnjCtoYHss1KHdGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568928; c=relaxed/simple;
	bh=qAdvsdCrpIoYhm6EIJvOhedQNm7nBC/QUtRA/6aXAf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB8sPTGZ7PJAx7soXq5y7//o66U4jtRV3VJPcZLFSEE5zPA9TI91cgCF1uslFFU5jxSdlwNrjWJDvX0sG7AzRFU0n3uFmIPLphG7VhkKTrs88hzQLDz+WYmPb1GF/0tlLK2CBoA/dyqM5l73q7UZdhyc8M6cdLr/NJe18x6smHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 125641 invoked by uid 1000); 4 Mar 2024 11:15:24 -0500
Date: Mon, 4 Mar 2024 11:15:24 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Sam Sun <samsun1006219@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
  Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  "xrivendell7@gmail.com" <xrivendell7@gmail.com>, hgajjar@de.adit-jv.com,
  quic_ugoswami@quicinc.com, stanley_chang@realtek.com,
  heikki.krogerus@linux.intel.com
Subject: Re: [Bug] INFO: task hung in hub_activate
Message-ID: <e9d710fc-eace-44de-b3cc-1117c3575ef7@rowland.harvard.edu>
References: <CAEkJfYO6jRVC8Tfrd_R=cjO0hguhrV31fDPrLrNOOHocDkPoAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkJfYO6jRVC8Tfrd_R=cjO0hguhrV31fDPrLrNOOHocDkPoAA@mail.gmail.com>

On Mon, Mar 04, 2024 at 08:10:02PM +0800, Sam Sun wrote:
> Dear developers and maintainers,
> 
> We encountered a task hung in function hub_activate(). It was reported
> before by Syzbot several years ago
> (https://groups.google.com/g/syzkaller-lts-bugs/c/_komEgHj03Y/m/rbcVKyLXBwAJ),
> but no repro at that time. We have a C repro this time and kernel
> config is attached to this email. The bug report is listed below.

Never mind the rest of the kernel log; I figured out what's going on.
Here are the important parts:

> ppid:8106   flags:0x00000006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5376 [inline]
>  __schedule+0xcea/0x59e0 kernel/sched/core.c:6688
>  __schedule_loop kernel/sched/core.c:6763 [inline]
>  schedule+0xe9/0x270 kernel/sched/core.c:6778
>  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0x509/0x940 kernel/locking/mutex.c:747
>  device_lock include/linux/device.h:992 [inline]
>  usb_deauthorize_interface+0x4d/0x130 drivers/usb/core/message.c:1789
>  interface_authorized_store+0xaf/0x110 drivers/usb/core/sysfs.c:1178
>  dev_attr_store+0x54/0x80 drivers/base/core.c:2366

usb_deauthorize_interface() starts by calling device_lock() on the
usb_interface's parent usb_device.

> ppid:8109   flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5376 [inline]
>  __schedule+0xcea/0x59e0 kernel/sched/core.c:6688
>  __schedule_loop kernel/sched/core.c:6763 [inline]
>  schedule+0xe9/0x270 kernel/sched/core.c:6778
>  kernfs_drain+0x36c/0x550 fs/kernfs/dir.c:505
>  __kernfs_remove+0x280/0x650 fs/kernfs/dir.c:1465
>  kernfs_remove_by_name_ns+0xb4/0x130 fs/kernfs/dir.c:1673
>  kernfs_remove_by_name include/linux/kernfs.h:623 [inline]
>  remove_files+0x96/0x1c0 fs/sysfs/group.c:28
>  sysfs_remove_group+0x8b/0x180 fs/sysfs/group.c:292
>  sysfs_remove_groups fs/sysfs/group.c:316 [inline]
>  sysfs_remove_groups+0x60/0xa0 fs/sysfs/group.c:308
>  device_remove_groups drivers/base/core.c:2734 [inline]
>  device_remove_attrs+0x192/0x290 drivers/base/core.c:2909
>  device_del+0x391/0xa30 drivers/base/core.c:3813
>  usb_disable_device+0x360/0x7b0 drivers/usb/core/message.c:1416
>  usb_set_configuration+0x1243/0x1c40 drivers/usb/core/message.c:2063
>  usb_deauthorize_device+0xe4/0x110 drivers/usb/core/hub.c:2638
>  authorized_store+0x122/0x140 drivers/usb/core/sysfs.c:747
>  dev_attr_store+0x54/0x80 drivers/base/core.c:2366

Among other things, usb_disable_device() calls device_del() for the
usb_device's child interfaces.

For brevity, let A be the parent usb_device and let B be the child
usb_interface.  Then in broad terms, we have:

CPU 0					CPU 1
-----------------------------		----------------------------
usb_deauthorize_device(A)
  device_lock(A)			usb_deauthorize_interface(B)
  usb_set_configuration(A, -1)		  device_lock(A)
    usb_disable_device(B)
      device_del(B)
        sysfs_remove_group(B, intf_attrs)

The problem now is:

1.	The kernfs core (kernfs_drain) on CPU 0 can't remove the
	intf_attrs sysfs attribute group while CPU 1 is in the middle
	of running a callback routine for one of the attribute files
	in that group.

2.	The callback routine on CPU 1 can't grab A's lock while CPU 0
	is holding it.

Result: deadlock.

This seems to be the only case where an interface sysfs callback
routine tries to acquire the parent device's lock.  That lock is
needed here because when an interface is deauthorized, the kernel has
to unbind the driver for that interface -- and binding or unbinding a
USB interface driver requires that the parent device's lock be held.

Three ideas stand out.  First, the device_lock() call should be
interruptible, because it is called when a user process writes to the
"authorized" attribute file.  But that alone won't fix the problem.

Second, we could avoid the deadlock by adding a timeout to this
device_lock() call.  But we probably don't want a deauthorize
operation to fail because of a timeout from a contested lock.

Third, this must be a generic problem.  It will occur any time a sysfs
attribute callback tries to lock its device while another process is
trying to unregister that device.

We faced this sort of problem some years ago when we were worrying
about "suicidal" attributes -- ones which would unregister their own
devices.  I don't remember what the fix was or how it worked.  But we
need something like it here.

Greg and Tejun, any ideas?  Is it possible somehow for an attribute file 
to be removed while its callback is still running?

Alan Stern

