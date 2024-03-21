Return-Path: <linux-kernel+bounces-109687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DB7881C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B751F21815
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8C33A8CE;
	Thu, 21 Mar 2024 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6wqCwr5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8069838DD8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711001838; cv=none; b=h2W2BmF0+XNLe9viei0imH48Jx6NiA2SzQ04JTf53Nd5nu9fXmJ7bTWmwduKb78m/Wx9ghgLJcAcpE6DIIaSB/1WZjm3VhVJdPA65+9M44V8jssx2GMUKrrN2KOjn2a+rWfR9MCFa6LT/zAF3CjhTYDNI7gv08L5VsuzHUIkk9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711001838; c=relaxed/simple;
	bh=KWCj5buf0iiJ5WNjx0ZYvc+FX+yns/hRyQ2YK1Xzm+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/79T1Qa4puxNS7e2D8YSF9HnpaMqTXwjNxQkqbuOP6kJu12em62GHdyDs9WRCPgS255c+u86qpVqZc4Dxk4SzsQV2JMcXbcR997+THjuyqidrkzP+6rRRAxRf+Fv7m9tl8Ghmrx9EpiYVjWywIEc0jJ0IzeJNcW7dqOUrgdz64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6wqCwr5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711001835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9jAIuJp36kQ83ph08kGCrk7a6I+win2cjS4x9JRD5ps=;
	b=d6wqCwr59NThwEn0f8nrKmkGX5AWsWrUzIQ9jTOp/EuvVIU4f+SVOrk7Lx+uQgkSo6R8lY
	mOGDa27+SFmH+zKiofleNZMcVef2Bs8b0msO+bJ5a5CnyIcVDGujxcjOCPsr5MIiQ9OvgR
	gQeGUCtt60TYaOLnflGkNlzJE3VsKXM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-i8MNhxPtOsu-j7Qqejuaog-1; Thu, 21 Mar 2024 02:17:11 -0400
X-MC-Unique: i8MNhxPtOsu-j7Qqejuaog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E08BC101A526;
	Thu, 21 Mar 2024 06:17:10 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C09D71121306;
	Thu, 21 Mar 2024 06:17:09 +0000 (UTC)
Date: Thu, 21 Mar 2024 14:17:02 +0800
From: Baoquan He <bhe@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"hpa@zytor.com" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH v3 0/7] device backed vmemmap crash dump support
Message-ID: <ZfvQ3qbRWCZeSb62@MiWiFi-R3L-srv>
References: <20240306102846.1020868-1-lizhijian@fujitsu.com>
 <92644ab5-6467-484c-b8f3-05cba2164cc1@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92644ab5-6467-484c-b8f3-05cba2164cc1@fujitsu.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 03/21/24 at 05:40am, Zhijian Li (Fujitsu) wrote:
> ping
> 
> 
> Any comment is welcome.

I will have a look at this from kdump side. How do you test your code?

By the way, there's issue reported by test robot.

Thanks
Baoquan

> 
> 
> On 06/03/2024 18:28, Li Zhijian wrote:
> > Hello folks,
> > 
> > Compared with the V2[1] I posted a long time ago, this time it is a
> > completely new proposal design.
> > 
> > ### Background and motivate overview ###
> > ---
> > Crash dump is an important feature for troubleshooting the kernel. It is the
> > final way to chase what happened at the kernel panic, slowdown, and so on. It
> > is one of the most important tools for customer support.
> > 
> > Currently, there are 2 syscalls(kexec_file_load(2) and kexec_load(2)) to
> > configure the dumpable regions. Generally, (A)iomem resources registered with
> > flags (IORESOURCE_SYSTEM_RAM | IORESOUCE_BUSY) for kexec_file_load(2) or
> > (B)iomem resources registered with "System RAM" name prefix for kexec_load(2)
> > are dumpable.
> > 
> > The pmem use cases including fsdax and devdax, could map their vmemmap to
> > their own devices. In this case, these part of vmemmap will not be dumped when
> > crash happened since these regions are satisfied with neither the above (A)
> > nor (B).
> > 
> > In fsdax, the vmemmap(struct page array) becomes very important, it is one of
> > the key data to find status of reverse map. Lacking of the information may
> > cause difficulty to analyze trouble around pmem (especially Filesystem-DAX).
> > That means troubleshooters are unable to check more details about pmem from
> > the dumpfile.
> > 
> > ### Proposal ###
> > ---
> > In this proposal, register the device backed vmemmap as a separate resource.
> > This resource has its own new flag and name, and then teaches kexec_file_load(2)
> > and kexec_load(2) to mark it as dumpable.
> > 
> > Proposed flag: IORESOURCE_DEVICE_BACKED_VMEMMAP
> > Proposed name: "Device Backed Vmemmap"
> > 
> > NOTE: crash-utils also needs to adapt to this new name for kexec_load()
> > 
> > With current proposal, the /proc/iomem should show as following for device
> > backed vmemmap
> > # cat /proc/iomem
> > ...
> > fffc0000-ffffffff : Reserved
> > 100000000-13fffffff : Persistent Memory
> >    100000000-10fffffff : namespace0.0
> >      100000000-1005fffff : Device Backed Vmemmap  # fsdax
> > a80000000-b7fffffff : CXL Window 0
> >    a80000000-affffffff : Persistent Memory
> >      a80000000-affffffff : region1
> >        a80000000-a811fffff : namespace1.0
> >          a80000000-a811fffff : Device Backed Vmemmap # devdax
> >        a81200000-abfffffff : dax1.0
> > b80000000-c7fffffff : CXL Window 1
> > c80000000-147fffffff : PCI Bus 0000:00
> >    c80000000-c801fffff : PCI Bus 0000:01
> > ...
> > 
> > ### Kdump service reloading ###
> > ---
> > Once the kdump service is loaded, if changes to CPUs or memory occur,
> > either by hot un/plug or off/onlining, the crash elfcorehdr should also
> > be updated. There are 2 approaches to make the reloading more efficient.
> > 1) Use udev rules to watch CPU and memory events, then reload kdump
> > 2) Enable kernel crash hotplug to automatically reload elfcorehdr (>= 6.5)
> > 
> > This reloading also needed when device backed vmemmap layouts change, Similar
> > to what 1) does now, one could add the following as the first lines to the
> > RHEL udev rule file /usr/lib/udev/rules.d/98-kexec.rules:
> > 
> > # namespace updated: watch daxX.Y(devdax) and pfnX.Y(fsdax) of nd
> > SUBSYSTEM=="nd", KERNEL=="[dp][af][xn][0-9].*", ACTION=="bind", GOTO="kdump_reload"
> > SUBSYSTEM=="nd", KERNEL=="[dp][af][xn][0-9].*", ACTION=="unbind", GOTO="kdump_reload"
> > # devdax <-> system-ram updated: watch daxX.Y of dax
> > SUBSYSTEM=="dax", KERNEL=="dax[0-9].*", ACTION=="bind", GOTO="kdump_reload"
> > SUBSYSTEM=="dax", KERNEL=="dax[0-9].*", ACTION=="unbind", GOTO="kdump_reload"
> > 
> > Regarding 2), my idea is that it would need to call the memory_notify() in
> > devm_memremap_pages_release() and devm_memremap_pages() to trigger the crash
> > hotplug. This part is not yet mature, but it does not affect the whole feature
> > because we can still use method 1) alternatively.
> > 
> > [1] https://lore.kernel.org/lkml/02066f0f-dbc0-0388-4233-8e24b6f8435b@fujitsu.com/T/
> > --------------------------------------------
> > changes from V2[1]
> > - new proposal design
> > 
> > CC: Alison Schofield <alison.schofield@intel.com>
> > CC: Andrew Morton <akpm@linux-foundation.org>
> > CC: Baoquan He <bhe@redhat.com>
> > CC: Borislav Petkov <bp@alien8.de>
> > CC: Dan Williams <dan.j.williams@intel.com>
> > CC: Dave Hansen <dave.hansen@linux.intel.com>
> > CC: Dave Jiang <dave.jiang@intel.com>
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > CC: "H. Peter Anvin" <hpa@zytor.com>
> > CC: Ingo Molnar <mingo@redhat.com>
> > CC: Ira Weiny <ira.weiny@intel.com>
> > CC: Thomas Gleixner <tglx@linutronix.de>
> > CC: Vishal Verma <vishal.l.verma@intel.com>
> > CC: linux-cxl@vger.kernel.org
> > CC: linux-mm@kvack.org
> > CC: nvdimm@lists.linux.dev
> > CC: x86@kernel.org
> > 
> > Li Zhijian (7):
> >    mm: memremap: register/unregister altmap region to a separate resource
> >    mm: memremap: add pgmap_parent_resource() helper
> >    nvdimm: pmem: assign a parent resource for vmemmap region for the
> >      fsdax
> >    dax: pmem: assign a parent resource for vmemmap region for the devdax
> >    resource: Introduce walk device_backed_vmemmap res() helper
> >    x86/crash: make device backed vmemmap dumpable for kexec_file_load
> >    nvdimm: set force_raw=1 in kdump kernel
> > 
> >   arch/x86/kernel/crash.c         |  5 +++++
> >   drivers/dax/pmem.c              |  8 ++++++--
> >   drivers/nvdimm/namespace_devs.c |  3 +++
> >   drivers/nvdimm/pmem.c           |  9 ++++++---
> >   include/linux/ioport.h          |  4 ++++
> >   include/linux/memremap.h        |  4 ++++
> >   kernel/resource.c               | 13 +++++++++++++
> >   mm/memremap.c                   | 30 +++++++++++++++++++++++++++++-
> >   8 files changed, 70 insertions(+), 6 deletions(-)
> > 


