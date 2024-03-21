Return-Path: <linux-kernel+bounces-110515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B5D885FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2085F1C21A71
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D959384A28;
	Thu, 21 Mar 2024 17:44:32 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218DAE57B;
	Thu, 21 Mar 2024 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711043072; cv=none; b=D46csBHduHUtpO2A05P9zjUm8vvh5/R8UvtT4pP1JcbNciiBDeJII2qatImgFNuteEQewUubtXD3kIpNJikTSkkHzbR1ilue3GJnTLKs5mIbbMqyxN3KTRRWe8ewIihDcNWz8FUWk+GitRavWObgNwPfIvWWoVvkRi2oeVdtbMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711043072; c=relaxed/simple;
	bh=wTbKWzdEt85HhcoAH5XHPgmXrvighJUnydmBeN8UTrA=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type; b=mh3b6Y3fKz9KdcwRwfenalotsIsqiRySnevuRcZFdbtaAAI5lXq5eCH18RPNywaCt+mLZfrXfO/p60xqlr9XZTPLqHKQxZmS6xpo1BjUilKKxDoX7tDlueR6NJULHkNkfPWrhXtsVak+AdiryxdgdmAcH1KbeMxeHJEBRkh9RyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V0t9d3slgz6K5rf;
	Fri, 22 Mar 2024 01:43:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 62FDF140A36;
	Fri, 22 Mar 2024 01:44:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 21 Mar
 2024 17:44:24 +0000
Date: Thu, 21 Mar 2024 17:44:23 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <linux-cxl@vger.kernel.org>
CC: Sreenivas Bagalkote <sreenivas.bagalkote@broadcom.com>, Brett Henning
	<brett.henning@broadcom.com>, Harold Johnson <harold.johnson@broadcom.com>,
	Sumanesh Samanta <sumanesh.samanta@broadcom.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, <linuxarm@huawei.com>,
	<linux-api@vger.kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Natu, Mahesh" <mahesh.natu@intel.com>
Subject: RFC: Restricting userspace interfaces for CXL fabric management
Message-ID: <20240321174423.00007e0d@Huawei.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Hi All,

This is has come up in a number of discussions both on list and in private,
so I wanted to lay out a potential set of rules when deciding whether or not
to provide a user space interface for a particular feature of CXL Fabric
Management.  The intent is to drive discussion, not to simply tell people
a set of rules.  I've brought this to the public lists as it's a Linux kernel
policy discussion, not a standards one.

Whilst I'm writing the RFC this my attempt to summarize a possible
position rather than necessarily being my personal view.

It's a straw man - shoot at it!

Not everyone in this discussion is familiar with relevant kernel or CXL concepts
so I've provided more info than I normally would.

First some background:
======================

CXL has two different types of Fabric. The comments here refer to both, but
for now the kernel stack is focused on the simpler VCS fabric, not the more
recent Port Based Routing (PBR) Fabrics. A typical example for 2 hosts
connected to a common switch looks something like:

 ________________               _______________
|                |             |               |    Hosts - each sees 
|    HOST A      |             |     HOST B    |    a PCIe style tree
|                |             |               |    but from a fabric config
|   |Root Port|  |             |   |Root Port| |    point of view it's more
 -------|--------               -------|-------     complex.
        |                              |           
        |                              |
 _______|______________________________|________
|      USP (SW-CCI)                   USP       | Switch can have lots of
|       |                              |        | Upstream Ports. Each one
|   ____|________               _______|______  | has a virtual hierarchy.
|  |             |              |             | |
| vPPB          vPPB          vPPB          vPPB| There are virtual
|  x             |             |              | | "downstream ports."(vPPBs)
|                \            /              /  | That can be bound to real
|                 \          /              /   | downstream ports.
|                  \        /              /    |
|                   \      /              /     | Multi Logical Devices are
|      DSP0           DSP1             DSP 2    | support more than one vPPB
------------------------------------------------  bound to a single physical
         |             |                 |        DSP (transactions are tagged
         |             |                 |        with an LD-ID)
        SLD0           MLD0              SLD1

Some typical fabric management activities:
1) Bind/Unbind vPPB to physical DSP (Results in hotplug / unplug events)
2) Access config space or BAR space of End Points below the switch.
3) Tunneling messages through to devices downstream (e.g Dynamic Capacity
   Forced Remove that will blow away some memory even if a host is using it).
4) Non destructive stuff like status read back.

Given the hosts may be using the Type 3 hosted memory (either Single Logical
Device - SLD, or an LD on a Multi logical Device - MLD) as normal memory,
unbinding a device in use can result in the memory access from a
different host being removed. The 'blast radius' is perhaps a rack of
servers.  This discussion applies equally to FM-API commands sent to Multi
Head Devices (see CXL r3.1).

The Fabric Management actions are done using the CXL spec defined Fabric
Management API, (FM-API) which is transported over various means including
OoB MCTP over your favourite transport (I2C, PCIe-VDM...) or via normal
PCIe read/write to a Switch-CCI.  A Switch-CCI is mailbox in PCI BAR
space on a function found alongside one of the switch upstream ports;
this mailbox is very similar to the MMPT definition found in PCIe r6.2.

In many cases this switch CCI / MCTP connection is used by a BMC rather
than a normal host, but there have been some questions raised about whether
a general purpose server OS would have a valid reason to use this interface
(beyond debug and testing) to configure the switch or an MHD.

If people have a use case for this, please reply to this thread to give
more details.

The most recently posted CXL Switch-CCI support only provided the RAW CXL
command IOCTL interface that is already available for Type 3 memory devices.
That allows for unfettered control of the switch but, because it is
extremely easy to shoot yourself in the foot and cause unsolvable bug reports,
it taints the kernel. There have been several requests to provide this interface
without the taint for these switch configuration mailboxes.

Last posted series:
https://lore.kernel.org/all/20231016125323.18318-1-Jonathan.Cameron@huawei.com/
Note there are unrelated reasons why that code hasn't been updated since v6.6 time,
but I am planning to get back to it shortly.

Similar issues will occur for other uses of PCIe MMPT (new mailbox in PCI that
sometimes is used for similarly destructive activity such as PLDM based
firmware update).


On to the proposed rules:

1) Kernel space use of the various mailboxes, or filtered controls from user space.
==================================================================================

Absolutely fine - no one worries about this, but the mediated traffic will
be filtered for potentially destructive side effects. E.g. it will reject
attempts to change anything routing related if the kernel either knows a host is
using memory that will be blown away, or has no way to know (so affecting
routing to another host).  This includes blocking 'all' vendor defined
messages as we have no idea what the do.  Note this means the kernel has
an allow list and new commands are not initially allowed.

This isn't currently enabled for Switch CCIs because they are only really
interesting if the potentially destructive stuff is available (an earlier
version did enable query commands, but it wasn't particularly useful to
know what your switch could do but not be allowed to do any of it).
If you take a MMPT usecase of PLDM firmware update, the filtering would
check that the device was in a state where a firmware update won't rip
memory out from under a host, which would be messy if that host is
doing the update.

2) Unfiltered userspace use of mailbox for Fabric Management - BMC kernels
==========================================================================

(This would just be a kernel option that we'd advise normal server
distributions not to turn on. Would be enabled by openBMC etc)

This is fine - there is some work to do, but the switch-cci PCI driver
will hopefully be ready for upstream merge soon. There is no filtering of
accesses. Think of this as similar to all the damage you can do via
MCTP from a BMC. Similarly it is likely that much of the complexity
of the actual commands will be left to user space tooling: 
https://gitlab.com/jic23/cxl-fmapi-tests has some test examples.

Whether Kconfig help text is strong enough to ensure this only gets
enabled for BMC targeted distros is an open question we can address
alongside an updated patch set.

(On to the one that the "debate" is about)

3) Unfiltered user space use of mailbox for Fabric Management - Distro kernels
=============================================================================
(General purpose Linux Server Distro (Redhat, Suse etc))

This is equivalent of RAW command support on CXL Type 3 memory devices.
You can enable those in a distro kernel build despite the scary config
help text, but if you use it the kernel is tainted. The result
of the taint is to add a flag to bug reports and print a big message to say
that you've used a feature that might result in you shooting yourself
in the foot.

The taint is there because software is not at first written to deal with
everything that can happen smoothly (e.g. surprise removal) It's hard
to survive some of these events, so is never on the initial feature list
for any bus, so this flag is just to indicate we have entered a world
where almost all bets are off wrt to stability.  We might not know what
a command does so we can't assess the impact (and no one trusts vendor
commands to report affects right in the Command Effects Log - which
in theory tells you if a command can result problems).

A concern was raised about GAE/FAST/LDST tables for CXL Fabrics
(a r3.1 feature) but, as I understand it, these are intended for a
host to configure and should not have side effects on other hosts?
My working assumption is that the kernel driver stack will handle
these (once we catch up with the current feature backlog!) Currently
we have no visibility of what the OS driver stack for a fabrics will
actually look like - the spec is just the starting point for that.
(patches welcome ;)

The various CXL upstream developers and maintainers may have
differing views of course, but my current understanding is we want
to support 1 and 2, but are very resistant to 3!

General Notes
=============

One side aspect of why we really don't like unfiltered userspace access to any
of these devices is that people start building non standard hacks in and we
lose the ecosystem advantages. Forcing a considered discussion + patches
to let a particular command be supported, drives standardization.

https://lore.kernel.org/linux-cxl/CAPcyv4gDShAYih5iWabKg_eTHhuHm54vEAei8ZkcmHnPp3B0cw@mail.gmail.com/
provides some history on vendor specific extensions and why in general we
won't support them upstream.

To address another question raised in an earlier discussion:
Putting these Fabric Management interfaces behind guard rails of some type
(e.g. CONFIG_IM_A_BMC_AND_CAN_MAKE_A_MESS) does not encourage the risk
of non standard interfaces, because we will be even less likely to accept
those upstream!

If anyone needs more details on any aspect of this please ask.
There are a lot of things involved and I've only tried to give a fairly
minimal illustration to drive the discussion. I may well have missed
something crucial.

Jonathan


