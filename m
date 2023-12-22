Return-Path: <linux-kernel+bounces-10039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B03881CF06
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA381C22E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CF72EB1B;
	Fri, 22 Dec 2023 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BEho3prE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEAC3172B;
	Fri, 22 Dec 2023 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703274788; x=1734810788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L4TnKEXfb2ccBb1Wze720VBcN3l/JR7BbWfBBtzRgXo=;
  b=BEho3prE3JTfW5yzDoTISnY4tY4iExcR5l4z7UCH4mGc10+tjmO0WRd9
   Gxz640uSLl/m2lw4L7wD3c2W0mBYfrPkp7LZ9woxDeKJhcXW4sqDdWXk2
   Ox8AMfXgJr/C6Tkbnca8D+Q3uKt8CvMYs9QwaI43oy9lfbmHgCvpwgc0D
   g=;
X-IronPort-AV: E=Sophos;i="6.04,297,1695686400"; 
   d="scan'208";a="378271995"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:53:06 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id 60A32A3F3F;
	Fri, 22 Dec 2023 19:52:58 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:7922]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.146:2525] with esmtp (Farcaster)
 id e9c6b21e-270d-43aa-aac6-432f3a7148e1; Fri, 22 Dec 2023 19:52:57 +0000 (UTC)
X-Farcaster-Flow-ID: e9c6b21e-270d-43aa-aac6-432f3a7148e1
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:52:56 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:52:52 +0000
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
Subject: [PATCH v2 12/17] tracing: Add kho serialization of trace buffers
Date: Fri, 22 Dec 2023 19:51:39 +0000
Message-ID: <20231222195144.24532-7-graf@amazon.com>
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
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When we do a kexec handover, we want to preserve previous ftrace data
into the new kernel. At the point when we write out the handover data,
ftrace may still be running and recording new events and we want to
capture all of those too.

To allow the new kernel to revive all trace data up to reboot, we store
all locations of trace buffers as well as their linked list metadata. We
can then later reuse the linked list to reconstruct the head pointer.

This patch implements the write-out logic for trace buffers.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - Leave the node generation code that needs to know the name in
    trace.c so that ring buffers can stay anonymous
---
 include/linux/ring_buffer.h |  2 +
 kernel/trace/ring_buffer.c  | 76 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.c        | 16 ++++++++
 3 files changed, 94 insertions(+)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 782e14f62201..1c5eb33f0cb5 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -211,4 +211,6 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
 #define trace_rb_cpu_prepare	NULL
 #endif
 
+int ring_buffer_kho_write(void *fdt, struct trace_buffer *buffer);
+
 #endif /* _LINUX_RING_BUFFER_H */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 83eab547f1d1..971af7ee35da 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -20,6 +20,7 @@
 #include <linux/percpu.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
+#include <linux/kexec.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/hash.h>
@@ -5853,6 +5854,81 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+#ifdef CONFIG_FTRACE_KHO
+static int rb_kho_write_cpu(void *fdt, struct trace_buffer *buffer, int cpu)
+{
+	int i = 0;
+	int err = 0;
+	struct list_head *tmp;
+	const char compatible[] = "ftrace,cpu-v1";
+	char name[] = "cpuffffffff";
+	int nr_pages;
+	struct ring_buffer_per_cpu *cpu_buffer;
+	bool first_loop = true;
+	struct kho_mem *mem;
+	uint64_t mem_len;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return 0;
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	nr_pages = cpu_buffer->nr_pages;
+	mem_len = sizeof(*mem) * nr_pages * 2;
+	mem = vmalloc(mem_len);
+
+	snprintf(name, sizeof(name), "cpu%x", cpu);
+
+	err |= fdt_begin_node(fdt, name);
+	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+	err |= fdt_property(fdt, "cpu", &cpu, sizeof(cpu));
+
+	for (tmp = rb_list_head(cpu_buffer->pages);
+	     tmp != rb_list_head(cpu_buffer->pages) || first_loop;
+	     tmp = rb_list_head(tmp->next), first_loop = false) {
+		struct buffer_page *bpage = (struct buffer_page *)tmp;
+
+		/* Ring is larger than it should be? */
+		if (i >= (nr_pages * 2)) {
+			pr_err("ftrace ring has more pages than nr_pages (%d / %d)", i, nr_pages);
+			err = -EINVAL;
+			break;
+		}
+
+		/* First describe the bpage */
+		mem[i++] = (struct kho_mem) {
+			.addr = __pa(bpage),
+			.len = sizeof(*bpage)
+		};
+
+		/* Then the data page */
+		mem[i++] = (struct kho_mem) {
+			.addr = __pa(bpage->page),
+			.len = PAGE_SIZE
+		};
+	}
+
+	err |= fdt_property(fdt, "mem", mem, mem_len);
+	err |= fdt_end_node(fdt);
+
+	vfree(mem);
+	return err;
+}
+
+int ring_buffer_kho_write(void *fdt, struct trace_buffer *buffer)
+{
+	int err, i;
+
+	for (i = 0; i < buffer->cpus; i++) {
+		err = rb_kho_write_cpu(fdt, buffer, i);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_RING_BUFFER_STARTUP_TEST
 /*
  * This is a basic integrity check of the ring buffer.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6ec31879b4eb..2ccea4c1965b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10563,6 +10563,21 @@ void __init early_trace_init(void)
 	init_events();
 }
 
+static int trace_kho_write_trace_array(void *fdt, struct trace_array *tr)
+{
+	const char *name = tr->name ? tr->name : "global_trace";
+	const char compatible[] = "ftrace,array-v1";
+	int err = 0;
+
+	err |= fdt_begin_node(fdt, name);
+	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+	err |= fdt_property(fdt, "trace_flags", &tr->trace_flags, sizeof(tr->trace_flags));
+	err |= ring_buffer_kho_write(fdt, tr->array_buffer.buffer);
+	err |= fdt_end_node(fdt);
+
+	return err;
+}
+
 static int trace_kho_notifier(struct notifier_block *self,
 			      unsigned long cmd,
 			      void *v)
@@ -10589,6 +10604,7 @@ static int trace_kho_notifier(struct notifier_block *self,
 
 	err |= fdt_begin_node(fdt, "ftrace");
 	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+	err |= trace_kho_write_trace_array(fdt, &global_trace);
 	err |= fdt_end_node(fdt);
 
 	if (!err) {
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




