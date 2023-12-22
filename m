Return-Path: <linux-kernel+bounces-10015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AA281CEC2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED0A1F23524
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6022A2E63C;
	Fri, 22 Dec 2023 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ddPgy0ss"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD32C1A1;
	Fri, 22 Dec 2023 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703273781; x=1734809781;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KAtck4BGqYVK3fz23UMMSkja7TsmFfA8lc0yhEsq2NQ=;
  b=ddPgy0ss+PLOyXAPrDtgPJAByu4qFDqAgALQ/ncsmiyeWIqboPKDjXO1
   R6vsed91nZVYGTHeOqqS2pD0zM7OeDDT2P3N9jW7Ypqb4/8ZwAQHMiLUz
   wRwrdtu3qReqms07B6WYLaBzDslea48QumrKB2wqZYtp38hrGO9Hvehx5
   A=;
X-IronPort-AV: E=Sophos;i="6.04,297,1695686400"; 
   d="scan'208";a="53377554"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:36:19 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix) with ESMTPS id 5786E410A7;
	Fri, 22 Dec 2023 19:36:14 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:57298]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.144:2525] with esmtp (Farcaster)
 id ffe0a76c-e2dd-4e3b-86dd-cff8ede9d562; Fri, 22 Dec 2023 19:36:13 +0000 (UTC)
X-Farcaster-Flow-ID: ffe0a76c-e2dd-4e3b-86dd-cff8ede9d562
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:36:13 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:36:09 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>, <x86@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rob Herring" <robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Mark Rutland
	<mark.rutland@arm.com>, "Tom Lendacky" <thomas.lendacky@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>, Stanislav
 Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: [PATCH v2 00/17] kexec: Allow preservation of ftrace buffers
Date: Fri, 22 Dec 2023 19:35:50 +0000
Message-ID: <20231222193607.15474-1-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Kexec today considers itself purely a boot loader: When we enter the new
kernel, any state the previous kernel left behind is irrelevant and the
new kernel reinitializes the system.

However, there are use cases where this mode of operation is not what we
actually want. In virtualization hosts for example, we want to use kexec
to update the host kernel while virtual machine memory stays untouched.
When we add device assignment to the mix, we also need to ensure that
IOMMU and VFIO states are untouched. If we add PCIe peer to peer DMA, we
need to do the same for the PCI subsystem. If we want to kexec while an
SEV-SNP enabled virtual machine is running, we need to preserve the VM
context pages and physical memory. See James' and my Linux Plumbers
Conference 2023 presentation for details:

  https://lpc.events/event/17/contributions/1485/

To start us on the journey to support all the use cases above, this
patch implements basic infrastructure to allow hand over of kernel state
across kexec (Kexec HandOver, aka KHO). As example target, we use ftrace:
With this patch set applied, you can read ftrace records from the
pre-kexec environment in your post-kexec one. This creates a very powerful
debugging and performance analysis tool for kexec. It's also slightly
easier to reason about than full blown VFIO state preservation.

== Alternatives ==

There are alternative approaches to (parts of) the problems above:

  * Memory Pools [1] - preallocated persistent memory region + allocator
  * PRMEM [2] - resizable persistent memory regions with fixed metadata
                pointer on the kernel command line + allocator
  * Pkernfs [3] - preallocated file system for in-kernel data with fixed
                  address location on the kernel command line
  * PKRAM [4] - handover of user space pages using a fixed metadata page
                specified via command line

All of the approaches above fundamentally have the same problem: They
require the administrator to explicitly carve out a physical memory
location because they have no mechanism outside of the kernel command
line to pass data (including memory reservations) between kexec'ing
kernels.

KHO provides that base foundation. We will determine later whether we
still need any of the approaches above for fast bulk memory handover of for
example IOMMU page tables. But IMHO they would all be users of KHO, with
KHO providing the foundational primitive to pass metadata and bulk memory
reservations as well as provide easy versioning for data.

== Documentation ==

If people are happy with the approach in this patch set, I will write up
conclusive documentation including schemas for the metadata as part of its
next iteration. For now, here's a rudimentary overview:

We introduce a metadata file that the kernels pass between each other. How
they pass it is architecture specific. The file's format is a Flattened
Device Tree (fdt) which has a generator and parser already included in
Linux. When the root user enables KHO through /sys/kernel/kho/active, the
kernel invokes callbacks to every driver that supports KHO to serialize
its state. When the actual kexec happens, the fdt is part of the image
set that we boot into. In addition, we keep a "scratch region" available
for kexec: A physically contiguous memory region that is guaranteed to
not have any memory that KHO would preserve.  The new kernel bootstraps
itself using the scratch region and sets all handed over memory as in use.
When drivers initialize that support KHO, they introspect the fdt and
recover their state from it. This includes memory reservations, where the
driver can either discard or claim reservations.

== Limitations ==

I currently only implemented file based kexec. The kernel interfaces
in the patch set are already in place to support user space kexec as well,
but I have not implemented it yet.

== How to Use ==

To use the code, please boot the kernel with the "kho_scratch=" command
line parameter set: "kho_scratch=512M". KHO requires a scratch region.

Make sure to fill ftrace with contents that you want to observe after
kexec.  Then, before you invoke file based "kexec -l", activate KHO:

  # echo 1 > /sys/kernel/kho/active
  # kexec -l Image --initrd=initrd -s
  # kexec -e

The new kernel will boot up and contain the previous kernel's trace
buffers in /sys/kernel/debug/tracing/trace.

== Changelog ==

v1 -> v2:
  - Removed: tracing: Introduce names for ring buffers
  - Removed: tracing: Introduce names for events
  - New: kexec: Add config option for KHO
  - New: kexec: Add documentation for KHO
  - New: tracing: Initialize fields before registering
  - New: devicetree: Add bindings for ftrace KHO
  - test bot warning fixes
  - Change kconfig option to ARCH_SUPPORTS_KEXEC_KHO
  - s/kho_reserve_mem/kho_reserve_previous_mem/g
  - s/kho_reserve/kho_reserve_scratch/g
  - Remove / reduce ifdefs
  - Select crc32
  - Leave anything that requires a name in trace.c to keep buffers
    unnamed entities
  - Put events as array into a property, use fingerprint instead of
    names to identify them
  - Reduce footprint without CONFIG_FTRACE_KHO
  - s/kho_reserve_mem/kho_reserve_previous_mem/g
  - make kho_get_fdt() const
  - Add stubs for return_mem and claim_mem
  - make kho_get_fdt() const
  - Get events as array from a property, use fingerprint instead of
    names to identify events
  - Change kconfig option to ARCH_SUPPORTS_KEXEC_KHO
  - s/kho_reserve_mem/kho_reserve_previous_mem/g
  - s/kho_reserve/kho_reserve_scratch/g
  - Leave the node generation code that needs to know the name in
    trace.c so that ring buffers can stay anonymous
  - s/kho_reserve/kho_reserve_scratch/g
  - Move kho enums out of ifdef
  - Move from names to fdt offsets. That way, trace.c can find the trace
    array offset and then the ring buffer code only needs to read out
    its per-CPU data. That way it can stay oblivient to its name.
  - Make kho_get_fdt() const


Alex

[1] https://lore.kernel.org/all/169645773092.11424.7258549771090599226.stgit@skinsburskii./
[2] https://lore.kernel.org/all/20231016233215.13090-1-madvenka@linux.microsoft.com/
[3] https://lpc.events/event/17/contributions/1485/attachments/1296/2650/jgowans-preserving-across-kexec.pdf
[4] https://lore.kernel.org/kexec/1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com/

Alexander Graf (17):
  mm,memblock: Add support for scratch memory
  memblock: Declare scratch memory as CMA
  kexec: Add Kexec HandOver (KHO) generation helpers
  kexec: Add KHO parsing support
  kexec: Add KHO support to kexec file loads
  kexec: Add config option for KHO
  kexec: Add documentation for KHO
  arm64: Add KHO support
  x86: Add KHO support
  tracing: Initialize fields before registering
  tracing: Introduce kho serialization
  tracing: Add kho serialization of trace buffers
  tracing: Recover trace buffers from kexec handover
  tracing: Add kho serialization of trace events
  tracing: Recover trace events from kexec handover
  tracing: Add config option for kexec handover
  devicetree: Add bindings for ftrace KHO

 Documentation/ABI/testing/sysfs-firmware-kho  |   9 +
 Documentation/ABI/testing/sysfs-kernel-kho    |  53 ++
 .../admin-guide/kernel-parameters.txt         |  10 +
 .../bindings/kho/ftrace/ftrace-array.yaml     |  46 ++
 .../bindings/kho/ftrace/ftrace-cpu.yaml       |  56 ++
 .../bindings/kho/ftrace/ftrace.yaml           |  48 ++
 Documentation/kho/concepts.rst                |  88 +++
 Documentation/kho/index.rst                   |  19 +
 Documentation/kho/usage.rst                   |  57 ++
 Documentation/subsystem-apis.rst              |   1 +
 MAINTAINERS                                   |   2 +
 arch/arm64/Kconfig                            |   3 +
 arch/arm64/kernel/setup.c                     |   2 +
 arch/arm64/mm/init.c                          |   8 +
 arch/x86/Kconfig                              |   3 +
 arch/x86/boot/compressed/kaslr.c              |  55 ++
 arch/x86/include/uapi/asm/bootparam.h         |  15 +-
 arch/x86/kernel/e820.c                        |   9 +
 arch/x86/kernel/kexec-bzimage64.c             |  39 ++
 arch/x86/kernel/setup.c                       |  46 ++
 arch/x86/mm/init_32.c                         |   7 +
 arch/x86/mm/init_64.c                         |   7 +
 drivers/of/fdt.c                              |  39 ++
 drivers/of/kexec.c                            |  54 ++
 include/linux/kexec.h                         |  58 ++
 include/linux/memblock.h                      |  19 +
 include/linux/ring_buffer.h                   |  17 +-
 include/linux/trace_events.h                  |   1 +
 include/uapi/linux/kexec.h                    |   6 +
 kernel/Kconfig.kexec                          |  13 +
 kernel/Makefile                               |   2 +
 kernel/kexec_file.c                           |  41 ++
 kernel/kexec_kho_in.c                         | 298 ++++++++++
 kernel/kexec_kho_out.c                        | 526 ++++++++++++++++++
 kernel/trace/Kconfig                          |  14 +
 kernel/trace/ring_buffer.c                    | 243 +++++++-
 kernel/trace/trace.c                          |  96 +++-
 kernel/trace/trace_events.c                   |  14 +-
 kernel/trace/trace_events_synth.c             |  14 +-
 kernel/trace/trace_events_user.c              |   4 +
 kernel/trace/trace_output.c                   | 246 +++++++-
 kernel/trace/trace_output.h                   |   5 +
 kernel/trace/trace_probe.c                    |   4 +
 mm/Kconfig                                    |   4 +
 mm/memblock.c                                 |  83 ++-
 45 files changed, 2360 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-kho
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-kho
 create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml
 create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml
 create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml
 create mode 100644 Documentation/kho/concepts.rst
 create mode 100644 Documentation/kho/index.rst
 create mode 100644 Documentation/kho/usage.rst
 create mode 100644 kernel/kexec_kho_in.c
 create mode 100644 kernel/kexec_kho_out.c

-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




