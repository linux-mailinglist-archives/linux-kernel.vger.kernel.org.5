Return-Path: <linux-kernel+bounces-10044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F6B81CF15
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DD2286B93
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988B72FC51;
	Fri, 22 Dec 2023 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UnmFO7dg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119E53309E;
	Fri, 22 Dec 2023 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703274836; x=1734810836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a+3i4loybtPdN0BnSihZonArbdMyz7IERtq4xLgkTQM=;
  b=UnmFO7dgnpQoIvHDXRPrXy5s8+CTuS4fPU/9ATOSqq6mp73kNjrpWCz8
   CESTzsIfNwxpXTW15n1Q+pzr2YSdobCEDEZCLmDepUHXcnw3HsB3+E4a4
   P+PBBh/icwJlUjldS+vV69tpyCTs7cMc8n2FSvcdSnDmDQSDDYZ7hLARW
   U=;
X-IronPort-AV: E=Sophos;i="6.04,297,1695686400"; 
   d="scan'208";a="602627379"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:53:53 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id 69E8040DFE;
	Fri, 22 Dec 2023 19:53:38 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:18182]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.218:2525] with esmtp (Farcaster)
 id bf3bafa8-c33b-453a-b6f8-9e29248b4425; Fri, 22 Dec 2023 19:53:38 +0000 (UTC)
X-Farcaster-Flow-ID: bf3bafa8-c33b-453a-b6f8-9e29248b4425
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:53:37 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:53:33 +0000
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
Subject: [PATCH v2 17/17] devicetree: Add bindings for ftrace KHO
Date: Fri, 22 Dec 2023 19:51:44 +0000
Message-ID: <20231222195144.24532-12-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231222195144.24532-1-graf@amazon.com>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222195144.24532-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

With ftrace in KHO, we are creating an ABI between old kernel and new
kernel about the state that they transfer. To ensure that we document
that state and catch any breaking change, let's add its schema to the
common devicetree bindings. This way, we can quickly reason about the
state that gets passed.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 .../bindings/kho/ftrace/ftrace-array.yaml     | 46 +++++++++++++++
 .../bindings/kho/ftrace/ftrace-cpu.yaml       | 56 +++++++++++++++++++
 .../bindings/kho/ftrace/ftrace.yaml           | 48 ++++++++++++++++
 3 files changed, 150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml
 create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml
 create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml

diff --git a/Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml b/Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml
new file mode 100644
index 000000000000..9960fefc292d
--- /dev/null
+++ b/Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml
@@ -0,0 +1,46 @@
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
+properties:
+  compatible:
+    enum:
+      - ftrace,array-v1
+
+  trace_flags:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Bitmap of all the trace flags that were enabled in the trace array at the
+      point of serialization.
+
+# Subnodes will be of type "ftrace,cpu-v1", one each per CPU
+additionalProperties: true
+
+required:
+  - compatible
+  - trace_flags
+
+examples:
+  - |
+    ftrace {
+        compatible = "ftrace-v1";
+        events = <1 1 2 2 3 3>;
+
+        global_trace {
+          compatible = "ftrace,array-v1";
+          trace_flags = < 0x3354601 >;
+
+          cpu0 {
+            compatible = "ftrace,cpu-v1";
+            cpu = < 0x00 >;
+            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;
+          };
+        };
+      };
diff --git a/Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml b/Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml
new file mode 100644
index 000000000000..58c715e93f37
--- /dev/null
+++ b/Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml
@@ -0,0 +1,56 @@
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
+properties:
+  compatible:
+    enum:
+      - ftrace,cpu-v1
+
+  cpu:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      CPU number of the CPU that this ring buffer belonged to when it was
+      serialized.
+
+  mem:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Array of { u64 phys_addr, u64 len } elements that describe a list of ring
+      buffer pages. Each page consists of two elements. The first element
+      describes the location of the struct buffer_page that contains metadata
+      for a given ring buffer page, such as the ring's head indicator. The
+      second element points to the ring buffer data page which contains the raw
+      trace data.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - cpu
+  - mem
+
+examples:
+  - |
+    ftrace {
+        compatible = "ftrace-v1";
+        events = <1 1 2 2 3 3>;
+
+        global_trace {
+          compatible = "ftrace,array-v1";
+          trace_flags = < 0x3354601 >;
+
+          cpu0 {
+            compatible = "ftrace,cpu-v1";
+            cpu = < 0x00 >;
+            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;
+          };
+        };
+      };
diff --git a/Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml b/Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml
new file mode 100644
index 000000000000..b87a64843af3
--- /dev/null
+++ b/Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml
@@ -0,0 +1,48 @@
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
+# Other child nodes will be of type "ftrace,array-v1". Each of which describe
+# a trace buffer
+additionalProperties: true
+
+required:
+  - compatible
+  - events
+
+examples:
+  - |
+    ftrace {
+        compatible = "ftrace-v1";
+        events = <1 1 2 2 3 3>;
+
+        global_trace {
+          compatible = "ftrace,array-v1";
+          trace_flags = < 0x3354601 >;
+
+          cpu0 {
+            compatible = "ftrace,cpu-v1";
+            cpu = < 0x00 >;
+            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;
+          };
+        };
+      };
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




