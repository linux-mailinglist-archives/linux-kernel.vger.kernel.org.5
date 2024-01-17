Return-Path: <linux-kernel+bounces-29098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE87B83087F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54AA51F25544
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB87121102;
	Wed, 17 Jan 2024 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IP32Rud+"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49200208B0;
	Wed, 17 Jan 2024 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705502908; cv=none; b=OFn3TMtqviLuaz2gEGMejPUHTCe18VQYrPtr+xESDufEOTpGvl6MtJkMhPJWY0PwY92IjM+f+YWX1ioQCxEPmlnCAG57ij44hjc7sBxqYwv0WXwz7BVcTuyz7hxcGGpb68OlmwuioMkTPTl28zrzcfag0H3gIyzPHUrC+B7lP6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705502908; c=relaxed/simple;
	bh=cQgJ5FMziwF/ZVGk5IQHM8xa8EGbaqSY+PgnjwvFFmY=;
	h=DKIM-Signature:X-IronPort-AV:Received:Received:Received:
	 X-Farcaster-Flow-ID:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding; b=dEckYnWT4M6GG4NHfTPJDjfhS4nmTBIzfAk7/10Yehfh4GxCk6TDNxa+sz/Oy2TVsBhOPShD3PI/6MEF4U63vL5pRHm0fgUVtFaLGWUDlaJBMyu/rhphzQqEYKtKM+zjuZHy/IRCTgE31i7W3IoW8oGuHV1Jh7T94m4OnIWQltU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IP32Rud+; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705502907; x=1737038907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zs1ZonnNcsxfGweb9JZkXAKdSNx8wyk84dZsk33RDuw=;
  b=IP32Rud+NCZUHlj0YV+fE8XJxcw36JOSXDNUfoMAvHl3tR32cDlCgC6x
   89ri9036iVCoCAe4xj9T5S9QR0ktl+R253deLrZ0skiKLnedWAjATXdRc
   XB3Bspbf6tnLfNMNzUHaNUxXG8Bs7QDDcBcYRk+WdjnYilJTbwEyckCY5
   o=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="267408007"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:48:24 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id 4014B80E4C;
	Wed, 17 Jan 2024 14:48:22 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:3455]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.34:2525] with esmtp (Farcaster)
 id 15515389-f0a6-44be-bc51-5bd5302b18d0; Wed, 17 Jan 2024 14:48:21 +0000 (UTC)
X-Farcaster-Flow-ID: 15515389-f0a6-44be-bc51-5bd5302b18d0
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:48:21 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:48:17 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>, <x86@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>, Andrew Morton
	<akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>, <arnd@arndb.de>, <pbonzini@redhat.com>,
	<madvenka@linux.microsoft.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 07/17] kexec: Add documentation for KHO
Date: Wed, 17 Jan 2024 14:46:54 +0000
Message-ID: <20240117144704.602-8-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117144704.602-1-graf@amazon.com>
References: <20240117144704.602-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

With KHO in place, let's add documentation that describes what it is and
how to use it.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v2 -> v3:

  - Fix wording
  - Add Documentation to MAINTAINERS file
---
 Documentation/kho/concepts.rst   | 88 ++++++++++++++++++++++++++++++++
 Documentation/kho/index.rst      | 19 +++++++
 Documentation/kho/usage.rst      | 57 +++++++++++++++++++++
 Documentation/subsystem-apis.rst |  1 +
 MAINTAINERS                      |  1 +
 5 files changed, 166 insertions(+)
 create mode 100644 Documentation/kho/concepts.rst
 create mode 100644 Documentation/kho/index.rst
 create mode 100644 Documentation/kho/usage.rst

diff --git a/Documentation/kho/concepts.rst b/Documentation/kho/concepts.rst
new file mode 100644
index 000000000000..cb8330bcb06c
--- /dev/null
+++ b/Documentation/kho/concepts.rst
@@ -0,0 +1,88 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=======================
+Kexec Handover Concepts
+=======================
+
+Kexec HandOver (KHO) is a mechanism that allows Linux to preserve state -
+arbitrary properties as well as memory locations - across kexec.
+
+It introduces multiple concepts:
+
+KHO Device Tree
+---------------
+
+Every KHO kexec carries a KHO specific flattened device tree blob that
+describes the state of the system. Device drivers can register to KHO to
+serialize their state before kexec. After KHO, device drivers can read
+the device tree and extract previous state.
+
+KHO only uses the fdt container format and libfdt library, but does not
+adhere to the same property semantics that normal device trees do: Properties
+are passed in native endianness and standardized properties like ``regs`` and
+``ranges`` do not exist, hence there are no ``#...-cells`` properties.
+
+KHO introduces a new concept to its device tree: ``mem`` properties. A
+``mem`` property can be inside any subnode in the device tree. When present,
+it contains an array of physical memory ranges that the new kernel must mark
+as reserved on boot. It is recommended, but not required, to make these ranges
+as physically contiguous as possible to reduce the number of array elements ::
+
+    struct kho_mem {
+            __u64 addr;
+            __u64 len;
+    };
+
+After boot, drivers can call the kho subsystem to transfer ownership of memory
+that was reserved via a ``mem`` property to themselves to continue using memory
+from the previous execution.
+
+The KHO device tree follows the in-Linux schema requirements. Any element in
+the device tree is documented via device tree schema yamls that explain what
+data gets transferred.
+
+Mem cache
+---------
+
+The new kernel needs to know about all memory reservations, but is unable to
+parse the device tree yet in early bootup code because of memory limitations.
+To simplify the initial memory reservation flow, the old kernel passes a
+preprocessed array of physically contiguous reserved ranges to the new kernel.
+
+These reservations have to be separate from architectural memory maps and
+reservations because they differ on every kexec, while the architectural ones
+get passed directly between invocations.
+
+The less entries this cache contains, the faster the new kernel will boot.
+
+Scratch Region
+--------------
+
+To boot into kexec, we need to have a physically contiguous memory range that
+contains no handed over memory. Kexec then places the target kernel and initrd
+into that region. The new kernel exclusively uses this region for memory
+allocations before it ingests the mem cache.
+
+We guarantee that we always have such a region through the scratch region: On
+first boot, you can pass the ``kho_scratch`` kernel command line option. When
+it is set, Linux allocates a CMA region of the given size. CMA gives us the
+guarantee that no handover pages land in that region, because handover
+pages must be at a static physical memory location and CMA enforces that
+only movable pages can be located inside.
+
+After KHO kexec, we ignore the ``kho_scratch`` kernel command line option and
+instead reuse the exact same region that was originally allocated. This allows
+us to recursively execute any amount of KHO kexecs. Because we used this region
+for boot memory allocations and as target memory for kexec blobs, some parts
+of that memory region may be reserved. These reservations are irrenevant for
+the next KHO, because kexec can overwrite even the original kernel.
+
+KHO active phase
+----------------
+
+To enable user space based kexec file loader, the kernel needs to be able to
+provide the device tree that describes the previous kernel's state before
+performing the actual kexec. The process of generating that device tree is
+called serialization. When the device tree is generated, some properties
+of the system may become immutable because they are already written down
+in the device tree. That state is called the KHO active phase.
diff --git a/Documentation/kho/index.rst b/Documentation/kho/index.rst
new file mode 100644
index 000000000000..5e7eeeca8520
--- /dev/null
+++ b/Documentation/kho/index.rst
@@ -0,0 +1,19 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+========================
+Kexec Handover Subsystem
+========================
+
+.. toctree::
+   :maxdepth: 1
+
+   concepts
+   usage
+
+.. only::  subproject and html
+
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/kho/usage.rst b/Documentation/kho/usage.rst
new file mode 100644
index 000000000000..59e82f609f75
--- /dev/null
+++ b/Documentation/kho/usage.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+====================
+Kexec Handover Usage
+====================
+
+Kexec HandOver (KHO) is a mechanism that allows Linux to preserve state -
+arbitrary properties as well as memory locations - across kexec.
+
+This document expects that you are familiar with the base KHO
+:ref:`Documentation/kho/concepts.rst <concepts>`. If you have not read
+them yet, please do so now.
+
+Prerequisites
+-------------
+
+KHO is available when the ``CONFIG_KEXEC_KHO`` config option is set to y
+at compile time. Every KHO producer has its own config option that you
+need to enable if you would like to preserve their respective state across
+kexec.
+
+To use KHO, please boot the kernel with the ``kho_scratch`` command
+line parameter set to allocate a scratch region. For example
+``kho_scratch=512M`` will reserve a 512 MiB scratch region on boot.
+
+Perform a KHO kexec
+-------------------
+
+Before you can perform a KHO kexec, you need to move the system into the
+:ref:`Documentation/kho/concepts.rst <KHO active phase>` ::
+
+  $ echo 1 > /sys/kernel/kho/active
+
+After this command, the KHO device tree is available in ``/sys/kernel/kho/dt``.
+
+Next, load the target payload and kexec into it. It is important that you
+use the ``-s`` parameter to use the in-kernel kexec file loader, as user
+space kexec tooling currently has no support for KHO with the user space
+based file loader ::
+
+  # kexec -l Image --initrd=initrd -s
+  # kexec -e
+
+The new kernel will boot up and contain some of the previous kernel's state.
+
+For example, if you enabled ``CONFIG_FTRACE_KHO``, the new kernel will contain
+the old kernel's trace buffers in ``/sys/kernel/debug/tracing/trace``.
+
+Abort a KHO exec
+----------------
+
+You can move the system out of KHO active phase again by calling ::
+
+  $ echo 1 > /sys/kernel/kho/active
+
+After this command, the KHO device tree is no longer available in
+``/sys/kernel/kho/dt``.
diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index 2d353fb8ea26..7c366337db5d 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -87,3 +87,4 @@ Storage interfaces
    peci/index
    wmi/index
    tee/index
+   kho/index
diff --git a/MAINTAINERS b/MAINTAINERS
index 88bf6730d801..1c48e4ea4005 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11826,6 +11826,7 @@ S:	Maintained
 W:	http://kernel.org/pub/linux/utils/kernel/kexec/
 F:	Documentation/ABI/testing/sysfs-firmware-kho
 F:	Documentation/ABI/testing/sysfs-kernel-kho
+F:	Documentation/kho/
 F:	include/linux/kexec.h
 F:	include/uapi/linux/kexec.h
 F:	kernel/kexec*
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




