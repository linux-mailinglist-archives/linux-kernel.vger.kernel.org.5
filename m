Return-Path: <linux-kernel+bounces-43125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B064B840BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5CF1F24A31
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38073158D98;
	Mon, 29 Jan 2024 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElSA3Tnp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3B2158D95
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546103; cv=none; b=DCXJh0afdERluPVgsevi9AJy+EP+1EChMUMaOF0stMPf5SMNRo8c9kCNBbwq81cVzp9WnBTNHWzeNcDCKLRpf7ymYxGtM8Dtdna2DmjtqOUIYSVb88mzJd1Wg+NqXevdNWrh1UUo4H9NWgHrqKuGPE4cy36tY3WXL3BEkR+54G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546103; c=relaxed/simple;
	bh=ha+gkVG8/zn6aZEH9rIVdE9aMWwOucc2/kkJ3OxCGr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0LyIljlSUH3UA4dP8Kx7haOU42WGHkphLsBaLoIh3teq2EIVumYdIi8lROyWy862Ik/8CFwuqciVykjV/gutTmNAbNksih6TFp+r+MriUfoHQT6Kg5wNdSoZtehPAclwGoN08HsHCq/E/8r2jOSqNJKMbE4tB7F0gbFFQeQGsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ElSA3Tnp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706546100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cnxc7g1CCZMSmgVTOsS1bbzZVy9L35+UTayMqPPm28A=;
	b=ElSA3Tnp6bkDvYiHhju+WVa6UdYuG/LCEmnA1Ty1U+rv31NnOUs5TfzIY/NOx/1SV1FTgj
	NOVKdG+YQI5/HUEXTtJKY8860OjFR29uITgjFtTfh632WBHOOC2Do6jeRpC1cARAdR6eH4
	1UQ44eC00OWKIB41p0tG3stPPFMHadg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-_GUyyg5UMA6WJBcMu_5Zvw-1; Mon, 29 Jan 2024 11:34:57 -0500
X-MC-Unique: _GUyyg5UMA6WJBcMu_5Zvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C98D85A599;
	Mon, 29 Jan 2024 16:34:56 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.193.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B18E41C060AF;
	Mon, 29 Jan 2024 16:34:51 +0000 (UTC)
Date: Mon, 29 Jan 2024 17:34:50 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Mark
 Rutland <mark.rutland@arm.com>, "Tom Lendacky" <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
 <pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
 <anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 00/17] kexec: Allow preservation of ftrace buffers
Message-ID: <20240129173450.038e46b7@rotkaeppchen>
In-Reply-To: <20240117144704.602-1-graf@amazon.com>
References: <20240117144704.602-1-graf@amazon.com>
Organization: Red Hat inc.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Hi Alex,

adding linux-integrity as there are some synergies with IMA_KEXEC (in case we
get KHO to work).

Fist of all I believe that having a generic framework to pass information from
one kernel to the other across kexec would be a good thing. But I'm afraid that
you are ignoring some fundamental problems which makes it extremely hard, if
not impossible, to reliably transfer the kernel's state from one kernel to the
other.

One thing I don't understand is how reusing the scratch area is working. Sure
you pass it's location via the dt/boot_params but I don't see any code that
makes it a CMA region. So IIUC the scratch area won't be available for the 2nd
kernel. Which is probably for the better as IIUC the 2nd kernel gets loaded and
runs inside that area and I don't believe the CMA design ever considered that
the kernel image could be included in a CMA area.

Staying at reusing the scratch area. One thing that is broken for sure is that
you reuse the scratch area without ever checking the kho_scratch parameter of
the 2nd kernel's command line. Remember, with kexec you are dealing with two
different kernels with two different command lines. Meaning you can only reuse
the scratch area if the requested size in the 2nd kernel is identical to the
one of the 1st kernel. In all other cases you need to adjust the scratch area's
size or reserve a new one.

This directly leads to the next problem. In kho_reserve_previous_mem you are
reusing the different memory regions wherever the 1st kernel allocated them.
But that also means you are handing over the 1st kernel's memory
fragmentation to the 2nd kernel and you do that extremely early during boot.
Which means that users who need to allocate large continuous physical memory,
like the scratch area or the crashkernel memory, will have increasing chance to
not find a suitable area. Which IMHO is unacceptable.

Finally, and that's the big elephant in the room, is your lax handling of the
unstable kernel internal ABI. Remember, you are dealing with two different
kernels, that also means two different source levels and two different configs.
So only because both the 1st and 2nd kernel have a e.g. struct buffer_page
doesn't means that they have the same struct buffer_page. But that's what your
code implicitly assumes. For KHO ever to make it upstream you need to make sure
that both kernels are "speaking the same language".

Personally I see two possible solutions:

1) You introduce a stable intermediate format for every subsystem similar to
what IMA_KEXEC does. This should work for simple types like struct buffer_page
but for complex ones like struct vfio_device that's basically impossible.

2) You also hand over the ABI version for every given type (basically just a
hash over all fields including all the dependencies). So the 2nd kernel can
verify that the data handed over is in a format it can handle and if not bail
out with a descriptive error message rather than reading garbage. Plus side is
that once such a system is in place you can reuse it to automatically resolve
all dependencies so you no longer need to manually store the buffer_page and
its buffer_data_page separately.
Down side is that traversing the debuginfo (including the ones from modules) is
not a simple task and I expect that such a system will be way more complex than
the rest of KHO. In addition there are some cases that the versioning won't be
able to capture. For example if a type contains a "void *"-field. Then although
the definition of the type is identical in both kernels the field can be cast
to different types when used. An other problem will be function pointers which
you first need to resolve in the 1st kernel and then map to the identical
function in the 2nd kernel. This will become particularly "fun" when the
function is part of a module that isn't loaded at the time when you try to
recreate the kernel's state.

So to summarize, while it would be nice to have a generic framework like KHO to
pass data from one kernel to the other via kexec there are good reasons why it
doesn't exist, yet.

Thanks
Philipp


On Wed, 17 Jan 2024 14:46:47 +0000
Alexander Graf <graf@amazon.com> wrote:

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
> == Changelog ==
> 
> v1 -> v2:
>   - Removed: tracing: Introduce names for ring buffers
>   - Removed: tracing: Introduce names for events
>   - New: kexec: Add config option for KHO
>   - New: kexec: Add documentation for KHO
>   - New: tracing: Initialize fields before registering
>   - New: devicetree: Add bindings for ftrace KHO
>   - test bot warning fixes
>   - Change kconfig option to ARCH_SUPPORTS_KEXEC_KHO
>   - s/kho_reserve_mem/kho_reserve_previous_mem/g
>   - s/kho_reserve/kho_reserve_scratch/g
>   - Remove / reduce ifdefs
>   - Select crc32
>   - Leave anything that requires a name in trace.c to keep buffers
>     unnamed entities
>   - Put events as array into a property, use fingerprint instead of
>     names to identify them
>   - Reduce footprint without CONFIG_FTRACE_KHO
>   - s/kho_reserve_mem/kho_reserve_previous_mem/g
>   - make kho_get_fdt() const
>   - Add stubs for return_mem and claim_mem
>   - make kho_get_fdt() const
>   - Get events as array from a property, use fingerprint instead of
>     names to identify events
>   - Change kconfig option to ARCH_SUPPORTS_KEXEC_KHO
>   - s/kho_reserve_mem/kho_reserve_previous_mem/g
>   - s/kho_reserve/kho_reserve_scratch/g
>   - Leave the node generation code that needs to know the name in
>     trace.c so that ring buffers can stay anonymous
>   - s/kho_reserve/kho_reserve_scratch/g
>   - Move kho enums out of ifdef
>   - Move from names to fdt offsets. That way, trace.c can find the trace
>     array offset and then the ring buffer code only needs to read out
>     its per-CPU data. That way it can stay oblivient to its name.
>   - Make kho_get_fdt() const
> 
> v2 -> v3:
> 
>   - Fix make dt_binding_check
>   - Add descriptions for each object
>   - s/trace_flags/trace-flags/
>   - s/global_trace/global-trace/
>   - Make all additionalProperties false
>   - Change subject to reflect subsysten (dt-bindings)
>   - Fix indentation
>   - Remove superfluous examples
>   - Convert to 64bit syntax
>   - Move to kho directory
>   - s/"global_trace"/"global-trace"/
>   - s/"global_trace"/"global-trace"/
>   - s/"trace_flags"/"trace-flags"/
>   - Fix wording
>   - Add Documentation to MAINTAINERS file
>   - Remove kho reference on read error
>   - Move handover_dt unmap up
>   - s/reserve_scratch_mem/mark_phys_as_cma/
>   - Remove ifdeffery
>   - Remove superfluous comment
> 
> Alexander Graf (17):
>   mm,memblock: Add support for scratch memory
>   memblock: Declare scratch memory as CMA
>   kexec: Add Kexec HandOver (KHO) generation helpers
>   kexec: Add KHO parsing support
>   kexec: Add KHO support to kexec file loads
>   kexec: Add config option for KHO
>   kexec: Add documentation for KHO
>   arm64: Add KHO support
>   x86: Add KHO support
>   tracing: Initialize fields before registering
>   tracing: Introduce kho serialization
>   tracing: Add kho serialization of trace buffers
>   tracing: Recover trace buffers from kexec handover
>   tracing: Add kho serialization of trace events
>   tracing: Recover trace events from kexec handover
>   tracing: Add config option for kexec handover
>   Documentation: KHO: Add ftrace bindings
> 
>  Documentation/ABI/testing/sysfs-firmware-kho  |   9 +
>  Documentation/ABI/testing/sysfs-kernel-kho    |  53 ++
>  .../admin-guide/kernel-parameters.txt         |  10 +
>  .../kho/bindings/ftrace/ftrace-array.yaml     |  38 ++
>  .../kho/bindings/ftrace/ftrace-cpu.yaml       |  43 ++
>  Documentation/kho/bindings/ftrace/ftrace.yaml |  62 +++
>  Documentation/kho/concepts.rst                |  88 +++
>  Documentation/kho/index.rst                   |  19 +
>  Documentation/kho/usage.rst                   |  57 ++
>  Documentation/subsystem-apis.rst              |   1 +
>  MAINTAINERS                                   |   3 +
>  arch/arm64/Kconfig                            |   3 +
>  arch/arm64/kernel/setup.c                     |   2 +
>  arch/arm64/mm/init.c                          |   8 +
>  arch/x86/Kconfig                              |   3 +
>  arch/x86/boot/compressed/kaslr.c              |  55 ++
>  arch/x86/include/uapi/asm/bootparam.h         |  15 +-
>  arch/x86/kernel/e820.c                        |   9 +
>  arch/x86/kernel/kexec-bzimage64.c             |  39 ++
>  arch/x86/kernel/setup.c                       |  46 ++
>  arch/x86/mm/init_32.c                         |   7 +
>  arch/x86/mm/init_64.c                         |   7 +
>  drivers/of/fdt.c                              |  39 ++
>  drivers/of/kexec.c                            |  54 ++
>  include/linux/kexec.h                         |  58 ++
>  include/linux/memblock.h                      |  19 +
>  include/linux/ring_buffer.h                   |  17 +-
>  include/linux/trace_events.h                  |   1 +
>  include/uapi/linux/kexec.h                    |   6 +
>  kernel/Kconfig.kexec                          |  13 +
>  kernel/Makefile                               |   2 +
>  kernel/kexec_file.c                           |  41 ++
>  kernel/kexec_kho_in.c                         | 298 ++++++++++
>  kernel/kexec_kho_out.c                        | 526 ++++++++++++++++++
>  kernel/trace/Kconfig                          |  14 +
>  kernel/trace/ring_buffer.c                    | 243 +++++++-
>  kernel/trace/trace.c                          |  96 +++-
>  kernel/trace/trace_events.c                   |  14 +-
>  kernel/trace/trace_events_synth.c             |  14 +-
>  kernel/trace/trace_events_user.c              |   4 +
>  kernel/trace/trace_output.c                   | 247 +++++++-
>  kernel/trace/trace_output.h                   |   5 +
>  kernel/trace/trace_probe.c                    |   4 +
>  mm/Kconfig                                    |   4 +
>  mm/memblock.c                                 |  79 ++-
>  45 files changed, 2351 insertions(+), 24 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-firmware-kho
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-kho
>  create mode 100644 Documentation/kho/bindings/ftrace/ftrace-array.yaml
>  create mode 100644 Documentation/kho/bindings/ftrace/ftrace-cpu.yaml
>  create mode 100644 Documentation/kho/bindings/ftrace/ftrace.yaml
>  create mode 100644 Documentation/kho/concepts.rst
>  create mode 100644 Documentation/kho/index.rst
>  create mode 100644 Documentation/kho/usage.rst
>  create mode 100644 kernel/kexec_kho_in.c
>  create mode 100644 kernel/kexec_kho_out.c
> 


