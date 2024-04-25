Return-Path: <linux-kernel+bounces-158972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1768B278E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889551C217D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B77614EC40;
	Thu, 25 Apr 2024 17:26:13 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA014B077;
	Thu, 25 Apr 2024 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065973; cv=none; b=mYv8Rl7rlnniw1lt4LQSc3UOxGWZY9ulbvMUqeBdal2qyI4jIA0AdJNp9Z085aYQbdegnJLaD3gHoxrlJYzlMSFAE7yNzBwdy7EiDSLHeogU8kwv7CDDab8IzTzcgGzDW38ZH0YKtPOwweaXj/DuOZMqETjIaPEpcHGYCAwREqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065973; c=relaxed/simple;
	bh=3mQMCNkjITWlTa2ZzqZEImLGvvbd5agAGSP3TETx2I4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHw1+J3V6YdnHqa1ixi7DHC6wz/DEkC55nGAHpNFPXkHKo3hxiUHwIYFGV3xY7KmjxNwPWAJkpdbOfkTlZ0+WJ1LnNGq11W8lj2GYxTWZ89rd9GC16paSy+HFp/6uhiW42jnG1FlpxL2NJyqYA3DeY2G31qOBI5Rs4ft80atOjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQN4H6QSvz67GVD;
	Fri, 26 Apr 2024 01:23:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BC294140C98;
	Fri, 26 Apr 2024 01:26:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 25 Apr
 2024 18:26:06 +0100
Date: Thu, 25 Apr 2024 18:26:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Sreenivas Bagalkote
	<sreenivas.bagalkote@broadcom.com>, Brett Henning
	<brett.henning@broadcom.com>, Harold Johnson <harold.johnson@broadcom.com>,
	Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
	<linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>,
	<linuxarm@huawei.com>, <linux-api@vger.kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Natu, Mahesh" <mahesh.natu@intel.com>,
	<gregkh@linuxfoundation.org>
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric management
Message-ID: <20240425182605.00005f22@Huawei.com>
In-Reply-To: <662a826dbeeff_b6e02943c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240321174423.00007e0d@Huawei.com>
	<66109191f3d6d_2583ad29468@dwillia2-xfh.jf.intel.com.notmuch>
	<20240410124517.000075f2@Huawei.com>
	<66284d5e8ac01_690a29431@dwillia2-xfh.jf.intel.com.notmuch>
	<20240425123344.000001a9@Huawei.com>
	<662a826dbeeff_b6e02943c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 25 Apr 2024 09:18:53 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> [..]
> > > Also, the assertion that these kernels will be built with
> > > CONFIG_SECURITY_LOCKDOWN_LSM=n and likely CONFIG_STRICT_DEVMEM=n, then
> > > the entire user-mode driver ABI is available for use. CXL commands are
> > > simple polled mmio, does Linux really benefit from carrying drivers in
> > > the kernel that the kernel itself does not care about?  
> > 
> > Sure we could it in userspace...  It's bad engineering, limits the design
> > to polling only and uses a bunch of interfaces we put a lot of effort into
> > telling people not to use except for debug.
> > 
> > I really don't see the advantage in pushing a project/group of projects
> > all of which are picking the upstream kernel up directly, to do a dirty
> > hack. We loose all the advantages of a proper well maintained kernel
> > driver purely on the argument that one use model is not the same as
> > this one.  Sensible security lockdown requirements is fine (along
> > with all the other kernel features that must be disable for that
> > to work), making open kernel development on for a large Linux
> > market harder is not.  
> 
> The minimum requirement for justifying an in kernel driver is that
> something else in the kernel consumes that facility. So, again, I want
> to get back to specifics what else in the kernel is going to leverage
> the Switch CCI mailbox?

Why?  I've never heard of such as a requirement and numerous drivers
provide fairly direct access to hardware. Sometimes there is a subsystem
aiding the data formatting etc, but fundamentally that's a convenience.

Taking this to a silly level, on this basis all networking drivers would
not be in the kernel.  They are there mainly to provide userspace access to
a network.  Any of the hardware access subsystems such hwmon, input, IIO
etc are primarily about providing a convenient way to get data to/from
a device.  They are kernel drivers because that is the cleaner path
for data marshaling, interrupt handling etc.

In kernel users are a perfectly valid reason to have a kernel driver,
but it's far from the only one.  None of the AI accelerators have in kernel
users today (maybe they will in future). Sure there are other arguments
that mean only a few such devices have been upstreamed, but it's not
that they need in kernel users. If it's really an issue I'll just submit
it to driver/misc and Greg can take a view on whether it's an acceptable
device to have driver for... (after he's asked the obvious question of
why aren't the CXL folk taking it!) +cc Greg to save providing info later.

For background this is a PCI function with a mailbox used for switch
configuration. The mailbox is identical to the one found on CXL type3
devices. Whole thing defined in the CXL spec. It gets a little complex
because you can tunnel commands to devices connected to the switch,
potentially affecting other hosts.  Typical Linux device doing this
would be a BMC, but there have been repeated questions about providing
a subset of access to any Linux system (avoiding the foot guns)
Whole thing fully discoverable - proposal is a standard PCI driver.

> 
> The generic-Type-3-device mailbox has an in kernel driver because the
> kernel has need to send mailbox commands internally and it is
> fundamental to RAS and provisioning flows that the kernel have this
> coordination. What are the motivations for an in-band Switch CCI command
> submission path?
> 
> It could be the case that you have a self-evident example in mind that I
> have thus far failed to realize.
> 

There are possibilities, but for now it's a transport driver just like
MCTP etc with a well defined chardev interface, with documented ioctl
interface etc (which I'd keep inline with one the CXL mailbox uses
just to avoid reinventing the wheel - I'd prefer to use that directly
to avoid divergence but I don't care that much).

As far as I can see, with the security / blast radius concern alleviated
by disabling this if lockdown is in use + taint for unaudited commands
(and a nasty sounding config similar to the cxl mailbox one)
there is little reason not to take such a driver into the kernel.
It has next to no maintenance impact outside of itself and a bit of
library code which I've proposed pushing down to the level of MMPT
(so PCI not CXL) if you think that is necessary. 

We want interrupt handling and basic access controls / command
interface to userspace.

Apologies if I'm grumpy - several long days of battling cpu hotplug code.

Jonathan



