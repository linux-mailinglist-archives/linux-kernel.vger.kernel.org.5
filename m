Return-Path: <linux-kernel+bounces-29109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAB98308C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 086BAB2582F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A0223757;
	Wed, 17 Jan 2024 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jkl3iEhx"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA442232C;
	Wed, 17 Jan 2024 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503010; cv=none; b=jFdl5+M4UOQbB3Ke1UKv/VLhW8hucAcP6zkErbhrFZjW6asPUs4Y/bfzp5VcXk6EjOv/gCx5yHQMVCd67UQaDNu0JSI0GJ8R+YmALLHReb7EGhXxrCHLH1WX/JfmLBaTOjTMulWAoCMPxvyGbpGgWR0V+gK2HS3VqsIaVbBcLHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503010; c=relaxed/simple;
	bh=M4xsVfV/+F5mriFinfpf39EQh3DfNKpLBBjzXyGsAmE=;
	h=DKIM-Signature:X-IronPort-AV:Received:Received:Received:
	 X-Farcaster-Flow-ID:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding; b=V4beWm6oODMo1Fu7ViIY8cN6IGdw8FrEuwTCnIu4wvZAK9N2H7Usl4ji79+d3qSgjLHUvpx0XE8AmcNLYpgKYh5OIe4ddZVAMeQ9mfvI+zyFN0BSkL6w2fFrte6RvuqieSBuhi/YpRvGtdMCgkb/9auFr1LA+gIp5fEleCfAh6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jkl3iEhx; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705503008; x=1737039008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tPlYmxW2bD4g5p/4BZUhVQG9FE6x6xhR8RJRJRx13Io=;
  b=jkl3iEhxFN0r8FVHPk+eTNYHtb7St1LRYKDU5CIMW5vvgeIJ3hUKqvc3
   iFGAX1F5bNZiHNpeHFFNpqfzln+edLxuQUeloqqehxwEOsFd7AtrnmwuY
   LJVLBqoDmAUI+WnguZjWKFxMUitYysZm4zo5BlTovRnkZexvLdFs9kV5m
   I=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="58930648"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:50:08 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com (Postfix) with ESMTPS id 1DF7988A4B;
	Wed, 17 Jan 2024 14:50:07 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:3171]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.206:2525] with esmtp (Farcaster)
 id b53c9c00-2d51-410c-8d2a-13bacadca1c2; Wed, 17 Jan 2024 14:50:06 +0000 (UTC)
X-Farcaster-Flow-ID: b53c9c00-2d51-410c-8d2a-13bacadca1c2
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:50:06 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:50:02 +0000
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
Subject: [PATCH v3 17/17] Documentation: KHO: Add ftrace bindings
Date: Wed, 17 Jan 2024 14:47:04 +0000
Message-ID: <20240117144704.602-18-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117144704.602-1-graf@amazon.com>
References: <20240117144704.602-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We introduced KHO into Linux: A framework that allows Linux to pass
metadata and memory across kexec from Linux to Linux. KHO reuses fdt
as file format and shares a lot of the same properties of firmware-to-
Linux boot formats: It needs a stable, documented ABI that allows for
forward and backward compatibility as well as versioning.

As first user of KHO, we introduced ftrace which can now preserve
trace contents across kexec, so you can use the post-kexec kernel to
read traces from the pre-kexec kernel.

This patch adds ftrace schemas similar to "device" device tree ones to
a new kho bindings directory. This allows us to force contributors to
document the data that moves across KHO kexecs and catch breaking change
during review.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v2 -> v3:

  - Fix make dt_binding_check
  - Add descriptions for each object
  - s/trace_flags/trace-flags/
  - s/global_trace/global-trace/
  - Make all additionalProperties false
  - Change subject to reflect subsysten (dt-bindings)
  - Fix indentation
  - Remove superfluous examples
  - Convert to 64bit syntax
  - Move to kho directory
---
 .../kho/bindings/ftrace/ftrace-array.yaml     | 38 ++++++++++++
 .../kho/bindings/ftrace/ftrace-cpu.yaml       | 43 +++++++++++++
 Documentation/kho/bindings/ftrace/ftrace.yaml | 62 +++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 Documentation/kho/bindings/ftrace/ftrace-array.yaml
 create mode 100644 Documentation/kho/bindings/ftrace/ftrace-cpu.yaml
 create mode 100644 Documentation/kho/bindings/ftrace/ftrace.yaml

diff --git a/Documentation/kho/bindings/ftrace/ftrace-array.yaml b/Documentation/kho/bindings/ftrace/ftrace-array.yaml
new file mode 100644
index 000000000000..aa0007595b95
--- /dev/null
+++ b/Documentation/kho/bindings/ftrace/ftrace-array.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/kho/ftrace/ftrace-array.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ftrace trace array
+
+maintainers:
+  - Alexander Graf <graf@amazon.com>
+
+description: |
+  Ftrace can create and expose multiple different trace instances, see
+  https://docs.kernel.org/trace/ftrace.html#instances. Each instance is
+  backed by a single trace array which contains all information about where
+  the corresponding trace buffers are located and how they are configured.
+
+properties:
+  compatible:
+    enum:
+      - ftrace,array-v1
+
+  trace-flags:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Bitmap of all the trace flags that were enabled in the trace array at the
+      point of serialization.
+
+patternProperties:
+  cpu[0-9a-f]*:
+    $ref: ftrace-cpu.yaml#
+    description: Trace buffer location for each CPU
+
+required:
+  - compatible
+  - trace-flags
+
+additionalProperties: false
diff --git a/Documentation/kho/bindings/ftrace/ftrace-cpu.yaml b/Documentation/kho/bindings/ftrace/ftrace-cpu.yaml
new file mode 100644
index 000000000000..95dec1c94fc3
--- /dev/null
+++ b/Documentation/kho/bindings/ftrace/ftrace-cpu.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/kho/ftrace/ftrace-cpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ftrace per-CPU ring buffer contents
+
+maintainers:
+  - Alexander Graf <graf@amazon.com>
+
+description: |
+  An ftrace trace array contains a ring buffers for each CPU. This
+  object describes the buffers of such a single CPU. It describes which
+  CPU it was used in and which memory was backing the ring buffer.
+
+properties:
+  compatible:
+    enum:
+      - ftrace,cpu-v1
+
+  cpu:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      CPU number of the CPU that this ring buffer belonged to when it was
+      serialized.
+
+  mem:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Array of { u64 phys_addr, u64 len } elements that describe a list of ring
+      buffer pages. Each page consists of two elements. The first element
+      describes the location of the struct buffer_page that contains metadata
+      for a given ring buffer page, such as the ring's head indicator. The
+      second element points to the ring buffer data page which contains the raw
+      trace data.
+
+required:
+  - compatible
+  - cpu
+  - mem
+
+additionalProperties: false
diff --git a/Documentation/kho/bindings/ftrace/ftrace.yaml b/Documentation/kho/bindings/ftrace/ftrace.yaml
new file mode 100644
index 000000000000..4a7308be8dbf
--- /dev/null
+++ b/Documentation/kho/bindings/ftrace/ftrace.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/kho/ftrace/ftrace.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ftrace core data
+
+maintainers:
+  - Alexander Graf <graf@amazon.com>
+
+description: |
+  Ftrace can serialize its current trace buffers across kexec through KHO.
+  For each instance, it preserves the backing ring buffers. It also
+  preserves event ID associations. The post-KHO kernel can then consume
+  these bits to reassemble trace data (not configuration!) for each trace
+  instance and that way expose pre-KHO traces in post-KHO ftrace files.
+
+properties:
+  compatible:
+    enum:
+      - ftrace-v1
+
+  events:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Array of { u32 crc, u32 type } elements. Each element contains a unique
+      identifier for an event, followed by the identifier that this event had
+      in the previous kernel's trace buffers.
+
+# Every subnode has to be a trace array
+patternProperties:
+  ^(?!compatible|events)$:
+    $ref: ftrace-array.yaml#
+    description: Trace array description for each trace instance
+
+required:
+  - compatible
+  - events
+
+additionalProperties: true
+
+examples:
+  - |
+    ftrace {
+      compatible = "ftrace-v1";
+      events = < 1 1 2 2 3 3 >;
+
+      global-trace {
+        compatible = "ftrace,array-v1";
+        trace-flags = < 0x3354601 >;
+
+        cpu0 {
+          compatible = "ftrace,cpu-v1";
+          cpu = < 0x00 >;
+          mem = /bits/ 64 < 0x101000000 0x38
+	                    0x101000100 0x1000
+	                    0x101000038 0x38
+	                    0x101002000 0x1000 >;
+        };
+      };
+    };
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




