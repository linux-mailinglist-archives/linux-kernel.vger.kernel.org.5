Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FD480FBE5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377739AbjLMAHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377689AbjLMAHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:07:32 -0500
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95AB18B;
        Tue, 12 Dec 2023 16:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702426036; x=1733962036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AEaNvGFNPvF0yeo/Uvj2gVs9WvSmpPsv4M/fAIzD1+w=;
  b=nniyo2lK+qzsrwSsUkYm/annSPRQk6N/wIWmWsKWLS4bnVZf/Ie1qmb3
   K5UmJdW+kW70q34kVgnODCWoF5efbg+fP3Il0rEmjqkaQXEpW7sg35bur
   IGyxj0onWP0cyLKPhA//4dCkV9ACLTvTI1Mg6VNyKnEyesDWPTga/GS+U
   g=;
X-IronPort-AV: E=Sophos;i="6.04,271,1695686400"; 
   d="scan'208";a="50248318"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:07:03 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
        by email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com (Postfix) with ESMTPS id 2F0D1E118A;
        Wed, 13 Dec 2023 00:06:55 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:49570]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.165:2525] with esmtp (Farcaster)
 id 1bfa1fde-7b72-4349-97e0-73423d0282ab; Wed, 13 Dec 2023 00:06:55 +0000 (UTC)
X-Farcaster-Flow-ID: 1bfa1fde-7b72-4349-97e0-73423d0282ab
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:06:46 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:06:42 +0000
From:   Alexander Graf <graf@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <x86@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        James Gowans <jgowans@amazon.com>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        <arnd@arndb.de>, <pbonzini@redhat.com>,
        <madvenka@linux.microsoft.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Usama Arif <usama.arif@bytedance.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 11/15] tracing: Add kho serialization of trace buffers
Date:   Wed, 13 Dec 2023 00:04:48 +0000
Message-ID: <20231213000452.88295-12-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213000452.88295-1-graf@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 include/linux/ring_buffer.h |  2 +
 kernel/trace/ring_buffer.c  | 89 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.c        | 16 +++++++
 3 files changed, 107 insertions(+)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index f34538f97c75..049565677ef8 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -212,4 +212,6 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
 #define trace_rb_cpu_prepare	NULL
 #endif
 
+int trace_kho_write_trace_buffer(void *fdt, struct trace_buffer *buffer);
+
 #endif /* _LINUX_RING_BUFFER_H */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index eaaf823ddedb..691d1236eeb1 100644
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
@@ -5921,6 +5922,94 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+#ifdef CONFIG_FTRACE_KHO
+static int trace_kho_write_cpu(void *fdt, struct trace_buffer *buffer, int cpu)
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
+int trace_kho_write_trace_buffer(void *fdt, struct trace_buffer *buffer)
+{
+	const char compatible[] = "ftrace,buffer-v1";
+	char name[] = "buffer";
+	int err;
+	int i;
+
+	err = fdt_begin_node(fdt, name);
+	if (err)
+		return err;
+
+	fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+
+	for (i = 0; i < buffer->cpus; i++) {
+		err = trace_kho_write_cpu(fdt, buffer, i);
+		if (err)
+			return err;
+	}
+
+	err =  fdt_end_node(fdt);
+	if (err)
+		return err;
+
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_RING_BUFFER_STARTUP_TEST
 /*
  * This is a basic integrity check of the ring buffer.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3e7f61cf773e..71c249cc5b43 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10597,6 +10597,21 @@ void __init early_trace_init(void)
 }
 
 #ifdef CONFIG_FTRACE_KHO
+static int trace_kho_write_trace_array(void *fdt, struct trace_array *tr)
+{
+	const char *name = tr->name ? tr->name : "global_trace";
+	const char compatible[] = "ftrace,array-v1";
+	int err = 0;
+
+	err |= fdt_begin_node(fdt, name);
+	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+	err |= fdt_property(fdt, "trace_flags", &tr->trace_flags, sizeof(tr->trace_flags));
+	err |= trace_kho_write_trace_buffer(fdt, tr->array_buffer.buffer);
+	err |= fdt_end_node(fdt);
+
+	return err;
+}
+
 static int trace_kho_notifier(struct notifier_block *self,
 			      unsigned long cmd,
 			      void *v)
@@ -10623,6 +10638,7 @@ static int trace_kho_notifier(struct notifier_block *self,
 
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



