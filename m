Return-Path: <linux-kernel+bounces-68880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8D6858156
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112311F214BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2AB1468E9;
	Fri, 16 Feb 2024 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="gIva1+X6"
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D89145B0C;
	Fri, 16 Feb 2024 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097418; cv=none; b=W+tpuClwCA0U67QSCysHspcAWbyTA9MRvnfI9sIifqfnEDy3aNzouskMHXmeF9pOgitTPL7Tc89eMFzntJmZh724YGXnIwIToybduA3kiVF+hr03ajo1j6MEBKL76J62ukqMDKTzNEao1A1JDt+v/YfT/Cj/n5YEf0H17D7b7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097418; c=relaxed/simple;
	bh=wVrW8kT4DejB28L712djWukexTnKvatq3YuM0neGVPs=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=srSb+uIhiOjNjTZIo8ZATc+ZCsMlNZcTcNvNKkrc12gn3bHvWqD44O3JuXFGsVFISclDTLQvY6+MQ7iaoPcXaXTXu3lwv+0Q8uWipr9hWXbRzsWMa2MJ7i/q6ygn9HSd0WRZgyi/Sx5qNSnctUGOTQ7HvQ6nvTwI9tdg7Ycc88I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=gIva1+X6; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1708097416; x=1739633416;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=F/Eio/BjkBDvnj7lgXtt9GlxdtOY8F3NsfX7BbAdrZU=;
  b=gIva1+X6I8wbrO8J3Wy5M92hbu8ewGk7/u6aTPMRrOoc+Xo0s0QHBjtJ
   p6WvO8NPOBH6aFqFcZdPAi2tCSdRqbxDrpHBek15CSjb6GHPYjr560d6y
   bDM625LdVfDNMCzaeFFnln0wDZ8elztftXlpDIYBA2ODvuUHQ9c9UJc1q
   w=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="327439017"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 15:29:52 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:25817]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.203:2525] with esmtp (Farcaster)
 id 745c92d6-d758-4d02-8839-5255b61b4613; Fri, 16 Feb 2024 15:29:51 +0000 (UTC)
X-Farcaster-Flow-ID: 745c92d6-d758-4d02-8839-5255b61b4613
Received: from EX19D020UWC001.ant.amazon.com (10.13.138.157) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 15:29:44 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D020UWC001.ant.amazon.com (10.13.138.157) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 15:29:44 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 16 Feb 2024 15:29:44 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id A785620CE8; Fri, 16 Feb 2024 16:29:43 +0100 (CET)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Alexander Graf <graf@amazon.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
	<rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>
Subject: Re: [PATCH v3 00/17] kexec: Allow preservation of ftrace buffers
In-Reply-To: <20240117144704.602-1-graf@amazon.com> (Alexander Graf's message
	of "Wed, 17 Jan 2024 14:46:47 +0000")
References: <20240117144704.602-1-graf@amazon.com>
Date: Fri, 16 Feb 2024 16:29:43 +0100
Message-ID: <mafs0zfw08m1k.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Alex,

On Wed, Jan 17 2024, Alexander Graf wrote:

> Kexec today considers itself purely a boot loader: When we enter the new
> kernel, any state the previous kernel left behind is irrelevant and the
> new kernel reinitializes the system.
>
> However, there are use cases where this mode of operation is not what we
> actually want. In virtualization hosts for example, we want to use kexec
> to update the host kernel while virtual machine memory stays untouched.
> When we add device assignment to the mix, we also need to ensure that
> IOMMU and VFIO states are untouched. If we add PCIe peer to peer DMA, we
> need to do the same for the PCI subsystem. If we want to kexec while an
> SEV-SNP enabled virtual machine is running, we need to preserve the VM
> context pages and physical memory. See James' and my Linux Plumbers
> Conference 2023 presentation for details:

I am working on handing userspace pages across kexec. This can be useful
for applications with large in-memory state that can be time consuming
to rebuild. If they can hand over their state over kexec, it allows for
kernel upgrades with lower downtime. As a part of this problem, I have
been looking at plugging all of this into CRIU [0] so I don't have to
modify the applications to use this feature. I can just use CRIU to do
the checkpoint and restore quickly over kexec.

I hacked together some patches for this (which are not yet polished
enough to publish) and ended up implementing something like KHO in a
much more crude way. I have since refactored my patches to use KHO and I
find it quite useful. So thanks for working on this :-)

It was easy enough to get KHO working with my patches though I had to
look into your ftrace patches to get the whole picture. The
documentation can be improved to show how it can be used from the
driver/subsystem perspective. For example, I had to read your ftrace
patches to figure out I should use kho_get_fdt(), or that I should
register a notifier via kho_register_notifier(). I would be happy to
contribute some documentation improvements.

Have you done any analysis on the performance or memory overhead? If
yes, it would be nice to look at some data. I have some concerns with
performance and memory overhead, especially for more fragmented memory
but I don't yet have numbers to present you.

[0] https://github.com/checkpoint-restore/criu

>
>   https://lpc.events/event/17/contributions/1485/
>
> To start us on the journey to support all the use cases above, this
> patch implements basic infrastructure to allow hand over of kernel state
> across kexec (Kexec HandOver, aka KHO). As example target, we use ftrace:
> With this patch set applied, you can read ftrace records from the
> pre-kexec environment in your post-kexec one. This creates a very powerful
> debugging and performance analysis tool for kexec. It's also slightly
> easier to reason about than full blown VFIO state preservation.
>
> == Alternatives ==
>
> There are alternative approaches to (parts of) the problems above:
>
>   * Memory Pools [1] - preallocated persistent memory region + allocator
>   * PRMEM [2] - resizable persistent memory regions with fixed metadata
>                 pointer on the kernel command line + allocator
>   * Pkernfs [3] - preallocated file system for in-kernel data with fixed
>                   address location on the kernel command line
>   * PKRAM [4] - handover of user space pages using a fixed metadata page
>                 specified via command line

FYI, you forgot to paste the links in v3 but I can find them from v2.

From all these options, PKRAM seems somewhat useful for my use case but
with CRIU it would need to copy all the application pages to the PKRAM
FS and would need at least as much free memory as application memory.

Instead, I have built a simple system that gives an API to userspace to
hand over its pages and to request them back. It then keeps track of the
PID and PA -> VA mappings (essentially a page table). This lets me keep
the pages in-place and avoid needing lots of free memory or expensive
copying. KHO plays a crucial role there in handing those pages and page
tables across to the next kernel.

The FDT format works fairly well for my use case. Since page tables are
a stable data structure, I don't need to worry about their format
changing between kernel versions and can directly pass them through.
This might not be true for many other data structures so subsystems
using those either need to serialize them to FDT or invent their own
serialization formats.

I also wonder how the "mem" array will work for more fragmented
allocations. It might grow very large with lots of scattered elements. I
wonder how both KHO's parsing and memblock will behave in this case. I
have not yet tried stressing it so I can't say for myself.

>
> All of the approaches above fundamentally have the same problem: They
> require the administrator to explicitly carve out a physical memory
> location because they have no mechanism outside of the kernel command
> line to pass data (including memory reservations) between kexec'ing
> kernels.
>
> KHO provides that base foundation. We will determine later whether we
> still need any of the approaches above for fast bulk memory handover of for
> example IOMMU page tables. But IMHO they would all be users of KHO, with
> KHO providing the foundational primitive to pass metadata and bulk memory
> reservations as well as provide easy versioning for data.
>
> == Overview ==
>
> We introduce a metadata file that the kernels pass between each other. How
> they pass it is architecture specific. The file's format is a Flattened
> Device Tree (fdt) which has a generator and parser already included in
> Linux. When the root user enables KHO through /sys/kernel/kho/active, the
> kernel invokes callbacks to every driver that supports KHO to serialize
> its state. When the actual kexec happens, the fdt is part of the image
> set that we boot into. In addition, we keep a "scratch region" available
> for kexec: A physically contiguous memory region that is guaranteed to
> not have any memory that KHO would preserve.  The new kernel bootstraps
> itself using the scratch region and sets all handed over memory as in use.
> When drivers initialize that support KHO, they introspect the fdt and
> recover their state from it. This includes memory reservations, where the
> driver can either discard or claim reservations.
>
> == Limitations ==
>
> I currently only implemented file based kexec. The kernel interfaces
> in the patch set are already in place to support user space kexec as well,
> but I have not implemented it yet inside kexec tools.
>
> == How to Use ==
>
> To use the code, please boot the kernel with the "kho_scratch=" command
> line parameter set: "kho_scratch=512M". KHO requires a scratch region.
>
> Make sure to fill ftrace with contents that you want to observe after
> kexec.  Then, before you invoke file based "kexec -l", activate KHO:
>
>   # echo 1 > /sys/kernel/kho/active
>   # kexec -l Image --initrd=initrd -s
>   # kexec -e
>
> The new kernel will boot up and contain the previous kernel's trace
> buffers in /sys/kernel/debug/tracing/trace.
>
[...]

Overall, I think KHO is quite useful and I would be happy to see it
evolve and eventually make it into the kernel. It would certainly make
my life a lot easier.

Since I have used it in my patches, I have done some basic testing for
it. Nothing fancy, just handed a few pages across. It works as
advertised. For that,

Tested-by: Pratyush Yadav <ptyadav@amazon.de>

-- 
Regards,
Pratyush Yadav



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




