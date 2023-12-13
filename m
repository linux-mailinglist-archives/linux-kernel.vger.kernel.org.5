Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA7B80FBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377858AbjLMAHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377872AbjLMAHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:07:46 -0500
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F01910F1;
        Tue, 12 Dec 2023 16:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702426048; x=1733962048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DMVF+g90vjiGQ2+mH0UneD/R5uFZpo7f74QocXGx4Fo=;
  b=tDAMyHkzpGHvBkdyysb06lS0YYGx5ezQ6YbmvJ3XqhoDtF8wFG5ExLIa
   RMHdlLPnUnHCLj64VSqYAJy6umccZXapJtArq5ntEeM77Yngc5N+or+UQ
   HU2rKyBdkvz+RjqvKqZvDnxglCgiJlUKECb4SEMcl4Xi1W7AhkWzyoZUS
   U=;
X-IronPort-AV: E=Sophos;i="6.04,271,1695686400"; 
   d="scan'208";a="259290097"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:07:24 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com (Postfix) with ESMTPS id 9684F806AE;
        Wed, 13 Dec 2023 00:07:12 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:42528]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.165:2525] with esmtp (Farcaster)
 id d4eed612-db0d-44d2-b4c4-2cf51a2e8457; Wed, 13 Dec 2023 00:07:11 +0000 (UTC)
X-Farcaster-Flow-ID: d4eed612-db0d-44d2-b4c4-2cf51a2e8457
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:07:11 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:07:07 +0000
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
Subject: [PATCH 12/15] tracing: Recover trace buffers from kexec handover
Date:   Wed, 13 Dec 2023 00:04:49 +0000
Message-ID: <20231213000452.88295-13-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213000452.88295-1-graf@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kexec handover is in place, we now know the location of all
previous buffers for ftrace rings. With this patch applied, ftrace
reassembles any new trace buffer that carries the same name as a
previous one with the same data pages that the previous buffer had.

That way, a buffer that we had in place before kexec becomes readable
after kexec again as soon as it gets initialized with the same name.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 kernel/trace/ring_buffer.c | 173 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 171 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 691d1236eeb1..f3d07cb90762 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -575,6 +575,28 @@ struct ring_buffer_iter {
 	int				missed_events;
 };
 
+struct trace_kho_cpu {
+	const struct kho_mem *mem;
+	uint32_t nr_mems;
+};
+
+#ifdef CONFIG_FTRACE_KHO
+static int trace_kho_replace_buffers(struct ring_buffer_per_cpu *cpu_buffer,
+				     struct trace_kho_cpu *kho);
+static int trace_kho_read_cpu(const char *name, int cpu, struct trace_kho_cpu *kho);
+#else
+static int trace_kho_replace_buffers(struct ring_buffer_per_cpu *cpu_buffer,
+				     struct trace_kho_cpu *kho)
+{
+	return -EINVAL;
+}
+
+static int trace_kho_read_cpu(const char *name, int cpu, struct trace_kho_cpu *kho)
+{
+	return -EINVAL;
+}
+#endif
+
 #ifdef RB_TIME_32
 
 /*
@@ -1807,10 +1829,12 @@ struct trace_buffer *__ring_buffer_alloc(const char *name,
 					unsigned long size, unsigned flags,
 					struct lock_class_key *key)
 {
+	int cpu = raw_smp_processor_id();
+	struct trace_kho_cpu kho = {};
 	struct trace_buffer *buffer;
+	bool use_kho = false;
 	long nr_pages;
 	int bsize;
-	int cpu;
 	int ret;
 
 	/* keep it in its own cache line */
@@ -1823,6 +1847,12 @@ struct trace_buffer *__ring_buffer_alloc(const char *name,
 		goto fail_free_buffer;
 
 	nr_pages = DIV_ROUND_UP(size, BUF_PAGE_SIZE);
+	if (!trace_kho_read_cpu(name, cpu, &kho) && kho.nr_mems > 4) {
+		nr_pages = kho.nr_mems / 2;
+		use_kho = true;
+		pr_debug("Using kho for buffer '%s' on CPU [%03d]", name, cpu);
+	}
+
 	buffer->flags = flags;
 	buffer->clock = trace_clock_local;
 	buffer->reader_lock_key = key;
@@ -1843,12 +1873,14 @@ struct trace_buffer *__ring_buffer_alloc(const char *name,
 	if (!buffer->buffers)
 		goto fail_free_cpumask;
 
-	cpu = raw_smp_processor_id();
 	cpumask_set_cpu(cpu, buffer->cpumask);
 	buffer->buffers[cpu] = rb_allocate_cpu_buffer(buffer, nr_pages, cpu);
 	if (!buffer->buffers[cpu])
 		goto fail_free_buffers;
 
+	if (use_kho && trace_kho_replace_buffers(buffer->buffers[cpu], &kho))
+		pr_warn("Could not revive all previous trace data");
+
 	ret = cpuhp_state_add_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
 	if (ret < 0)
 		goto fail_free_buffers;
@@ -5886,7 +5918,9 @@ EXPORT_SYMBOL_GPL(ring_buffer_read_page);
  */
 int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node)
 {
+	struct trace_kho_cpu kho = {};
 	struct trace_buffer *buffer;
+	bool use_kho = false;
 	long nr_pages_same;
 	int cpu_i;
 	unsigned long nr_pages;
@@ -5910,6 +5944,12 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node)
 	/* allocate minimum pages, user can later expand it */
 	if (!nr_pages_same)
 		nr_pages = 2;
+
+	if (!trace_kho_read_cpu(buffer->name, cpu, &kho) && kho.nr_mems > 4) {
+		nr_pages = kho.nr_mems / 2;
+		use_kho = true;
+	}
+
 	buffer->buffers[cpu] =
 		rb_allocate_cpu_buffer(buffer, nr_pages, cpu);
 	if (!buffer->buffers[cpu]) {
@@ -5917,12 +5957,141 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node)
 		     cpu);
 		return -ENOMEM;
 	}
+
+	if (use_kho && trace_kho_replace_buffers(buffer->buffers[cpu], &kho))
+		pr_warn("Could not revive all previous trace data");
+
 	smp_wmb();
 	cpumask_set_cpu(cpu, buffer->cpumask);
 	return 0;
 }
 
 #ifdef CONFIG_FTRACE_KHO
+static int trace_kho_replace_buffers(struct ring_buffer_per_cpu *cpu_buffer,
+				     struct trace_kho_cpu *kho)
+{
+	bool first_loop = true;
+	struct list_head *tmp;
+	int err = 0;
+	int i = 0;
+
+	if (kho->nr_mems != cpu_buffer->nr_pages * 2)
+		return -EINVAL;
+
+	for (tmp = rb_list_head(cpu_buffer->pages);
+	     tmp != rb_list_head(cpu_buffer->pages) || first_loop;
+	     tmp = rb_list_head(tmp->next), first_loop = false) {
+		struct buffer_page *bpage = (struct buffer_page *)tmp;
+		const struct kho_mem *mem_bpage = &kho->mem[i++];
+		const struct kho_mem *mem_page = &kho->mem[i++];
+		const uint64_t rb_page_head = 1;
+		struct buffer_page *old_bpage;
+		void *old_page;
+
+		old_bpage = __va(mem_bpage->addr);
+		if (!bpage)
+			goto out;
+
+		if ((ulong)old_bpage->list.next & rb_page_head) {
+			struct list_head *new_lhead;
+			struct buffer_page *new_head;
+
+			new_lhead = rb_list_head(bpage->list.next);
+			new_head = (struct buffer_page *)new_lhead;
+
+			/* Assume the buffer is completely full */
+			cpu_buffer->tail_page = bpage;
+			cpu_buffer->commit_page = bpage;
+			/* Set the head pointers to what they were before */
+			cpu_buffer->head_page->list.prev->next = (struct list_head *)
+				((ulong)cpu_buffer->head_page->list.prev->next & ~rb_page_head);
+			cpu_buffer->head_page = new_head;
+			bpage->list.next = (struct list_head *)((ulong)new_lhead | rb_page_head);
+		}
+
+		if (rb_page_entries(old_bpage) || rb_page_write(old_bpage)) {
+			/*
+			 * We want to recycle the pre-kho page, it contains
+			 * trace data. To do so, we unreserve it and swap the
+			 * current data page with the pre-kho one
+			 */
+			old_page = kho_claim_mem(mem_page);
+
+			/* Recycle the old page, it contains data */
+			free_page((ulong)bpage->page);
+			bpage->page = old_page;
+
+			bpage->write = old_bpage->write;
+			bpage->entries = old_bpage->entries;
+			bpage->real_end = old_bpage->real_end;
+
+			local_inc(&cpu_buffer->pages_touched);
+		} else {
+			kho_return_mem(mem_page);
+		}
+
+		kho_return_mem(mem_bpage);
+	}
+
+out:
+	return err;
+}
+
+static int trace_kho_read_cpu(const char *name, int cpu,
+			      struct trace_kho_cpu *kho)
+{
+	void *fdt = kho_get_fdt();
+	int mem_len;
+	int err = 0;
+	char *path;
+	int off;
+
+	if (!fdt)
+		return -ENOENT;
+
+	if (!kho)
+		return -EINVAL;
+
+	path = kasprintf(GFP_KERNEL, "/ftrace/%s/buffer/cpu%x", name, cpu);
+	if (!path)
+		return -ENOMEM;
+
+	pr_debug("Trying to revive trace buffer '%s'", path);
+
+	off = fdt_path_offset(fdt, path);
+	if (off < 0) {
+		pr_debug("Could not find '%s' in DT", path);
+		err = -ENOENT;
+		goto out;
+	}
+
+	err = fdt_node_check_compatible(fdt, off, "ftrace,cpu-v1");
+	if (err) {
+		pr_warn("Node '%s' has invalid compatible", path);
+		err = -EINVAL;
+		goto out;
+	}
+
+	kho->mem = fdt_getprop(fdt, off, "mem", &mem_len);
+	if (!kho->mem) {
+		pr_warn("Node '%s' has invalid mem property", path);
+		err = -EINVAL;
+		goto out;
+	}
+
+	kho->nr_mems = mem_len / sizeof(*kho->mem);
+
+	/* Should follow "bpage 0, page 0, bpage 1, page 1, ..." pattern */
+	if ((kho->nr_mems & 1)) {
+		err = -EINVAL;
+		goto out;
+	}
+
+out:
+	kfree(path);
+	return err;
+}
+
 static int trace_kho_write_cpu(void *fdt, struct trace_buffer *buffer, int cpu)
 {
 	int i = 0;
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



