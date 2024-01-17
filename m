Return-Path: <linux-kernel+bounces-29106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 197278308AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 892CDB25F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64CC225A6;
	Wed, 17 Jan 2024 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ixnpWOgr"
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839F22304;
	Wed, 17 Jan 2024 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705502979; cv=none; b=A3GojSENKIihA9DJlRJ0MPPCaaksytVo+9pG1l7/m6Uy1W6xYYuGPM/mHvl4kUnFGX1fiHf0hzr4+rG4I59v2syHjyeWp9NsFnh/BWusp/e4uf0xD7aWPyjswDNhNoJHyvmsyN1iXMStBTSTV6eXBeTdupQXWRJOrYNiWWSjjq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705502979; c=relaxed/simple;
	bh=3f/S3+X9kp9Q3I1hg9/NZigRmTw2msZdKbjK5QTH3bM=;
	h=DKIM-Signature:X-IronPort-AV:Received:Received:Received:
	 X-Farcaster-Flow-ID:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding; b=A46l80Xr67eF55aHFo77v/5/eXundVTgbTG5EOQYMpfD8gp8pi1EWIeGMl2bOBRleDHBMzw1gfxod8BrvAEtCqhWG9V/xN71KE5N3FMmoxmUeWXxoUqY9A5lm6cUTDJQ5rwbrT2KRhbjopicSFBRKjzzlekZJUyfNBdYxz3ne4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ixnpWOgr; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705502978; x=1737038978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U0hyYTkhSxvX6+T1x6RjDPfV1ywV5C7Siqc3ZcSpla8=;
  b=ixnpWOgrDseaBz2UgRtaHwn9uPTF2+tmntBzuG8XRbV7ZFlXpPWv0TXC
   OOA7pJlv06lw5F7Mgj82Op+C+UBrYkstmL7DZv2TUfUUxj3ep8N9F7j2n
   +/FfSOP+Ak0C97S/FRUGtotMGqbo3WWBmiwrjmIvs2ih4NdWIMqKY8eZm
   0=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="322019440"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-14781fa4.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:49:29 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2b-m6i4x-14781fa4.us-west-2.amazon.com (Postfix) with ESMTPS id 6A2AF160007;
	Wed, 17 Jan 2024 14:49:25 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:54156]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.181:2525] with esmtp (Farcaster)
 id 512a89a9-fd01-4e5a-876b-90d048f33ffd; Wed, 17 Jan 2024 14:49:25 +0000 (UTC)
X-Farcaster-Flow-ID: 512a89a9-fd01-4e5a-876b-90d048f33ffd
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:49:24 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:49:21 +0000
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
Subject: [PATCH v3 12/17] tracing: Add kho serialization of trace buffers
Date: Wed, 17 Jan 2024 14:46:59 +0000
Message-ID: <20240117144704.602-13-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117144704.602-1-graf@amazon.com>
References: <20240117144704.602-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
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

v2 -> v3:

  - s/"global_trace"/"global-trace"/
  - s/"trace_flags"/"trace-flags"/
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
index 9286f88fcd32..33b41013cda9 100644
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
@@ -5859,6 +5860,81 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node)
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
index 9a0d96975c9c..9505a929a726 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10577,6 +10577,21 @@ void __init early_trace_init(void)
 	init_events();
 }
 
+static int trace_kho_write_trace_array(void *fdt, struct trace_array *tr)
+{
+	const char *name = tr->name ? tr->name : "global-trace";
+	const char compatible[] = "ftrace,array-v1";
+	int err = 0;
+
+	err |= fdt_begin_node(fdt, name);
+	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+	err |= fdt_property(fdt, "trace-flags", &tr->trace_flags, sizeof(tr->trace_flags));
+	err |= ring_buffer_kho_write(fdt, tr->array_buffer.buffer);
+	err |= fdt_end_node(fdt);
+
+	return err;
+}
+
 static int trace_kho_notifier(struct notifier_block *self,
 			      unsigned long cmd,
 			      void *v)
@@ -10603,6 +10618,7 @@ static int trace_kho_notifier(struct notifier_block *self,
 
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




