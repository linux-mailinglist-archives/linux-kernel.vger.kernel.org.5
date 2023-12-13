Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E3580FBD5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377665AbjLMAGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377734AbjLMAGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:06:37 -0500
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4883811A;
        Tue, 12 Dec 2023 16:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702425994; x=1733961994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IHxE/iueMjg5jk3J7QeMpZujdfbmXnsIes6SvH8utzQ=;
  b=h2YU4YR9wcBn2kwVG+LxOLzaht5wGiWplBrw1iQvgQEnfE/GWJhznk7r
   kn/3+aUb/TwmwTlEEOclmOuQ+rDPLPiAmR4MVtM96JUaXdrOc1suHL+nf
   PDnNuuXCoW2qfXJwrjg0vijQQq3Vka0KecZGru6djuNuZyuShw/931eWC
   s=;
X-IronPort-AV: E=Sophos;i="6.04,271,1695686400"; 
   d="scan'208";a="382524268"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:06:27 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com (Postfix) with ESMTPS id E9CFD8179B;
        Wed, 13 Dec 2023 00:06:13 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:11247]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.147:2525] with esmtp (Farcaster)
 id 7d1c1fe5-8e35-45c9-ab5b-5b98cbcd951c; Wed, 13 Dec 2023 00:06:12 +0000 (UTC)
X-Farcaster-Flow-ID: 7d1c1fe5-8e35-45c9-ab5b-5b98cbcd951c
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:06:12 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:06:08 +0000
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
Subject: [PATCH 08/15] tracing: Introduce names for ring buffers
Date:   Wed, 13 Dec 2023 00:04:45 +0000
Message-ID: <20231213000452.88295-9-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213000452.88295-1-graf@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
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

With KHO (Kexec HandOver), we want to preserve trace buffers across
kexec. To carry over their state between kernels, the kernel needs a
common handle for them that exists on both sides. As handle we introduce
names for ring buffers. In a follow-up patch, the kernel can then use
these names to recover buffer contents for specific ring buffers.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 include/linux/ring_buffer.h | 7 ++++---
 kernel/trace/ring_buffer.c  | 5 ++++-
 kernel/trace/trace.c        | 7 ++++---
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 782e14f62201..f34538f97c75 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -85,17 +85,18 @@ void ring_buffer_discard_commit(struct trace_buffer *buffer,
  * size is in bytes for each per CPU buffer.
  */
 struct trace_buffer *
-__ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *key);
+__ring_buffer_alloc(const char *name, unsigned long size, unsigned flags,
+		    struct lock_class_key *key);
 
 /*
  * Because the ring buffer is generic, if other users of the ring buffer get
  * traced by ftrace, it can produce lockdep warnings. We need to keep each
  * ring buffer's lock class separate.
  */
-#define ring_buffer_alloc(size, flags)			\
+#define ring_buffer_alloc(name, size, flags)			\
 ({							\
 	static struct lock_class_key __key;		\
-	__ring_buffer_alloc((size), (flags), &__key);	\
+	__ring_buffer_alloc((name), (size), (flags), &__key);	\
 })
 
 int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 43cc47d7faaf..eaaf823ddedb 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -557,6 +557,7 @@ struct trace_buffer {
 
 	struct rb_irq_work		irq_work;
 	bool				time_stamp_abs;
+	const char			*name;
 };
 
 struct ring_buffer_iter {
@@ -1801,7 +1802,8 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
  * when the buffer wraps. If this flag is not set, the buffer will
  * drop data when the tail hits the head.
  */
-struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
+struct trace_buffer *__ring_buffer_alloc(const char *name,
+					unsigned long size, unsigned flags,
 					struct lock_class_key *key)
 {
 	struct trace_buffer *buffer;
@@ -1823,6 +1825,7 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 	buffer->flags = flags;
 	buffer->clock = trace_clock_local;
 	buffer->reader_lock_key = key;
+	buffer->name = name;
 
 	init_irq_work(&buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&buffer->irq_work.waiters);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9aebf904ff97..7700ca1be2a5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9384,7 +9384,8 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 
 	buf->tr = tr;
 
-	buf->buffer = ring_buffer_alloc(size, rb_flags);
+	buf->buffer = ring_buffer_alloc(tr->name ? tr->name : "global_trace",
+					size, rb_flags);
 	if (!buf->buffer)
 		return -ENOMEM;
 
@@ -9421,7 +9422,7 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 		return ret;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	ret = allocate_trace_buffer(tr, &tr->max_buffer,
+	ret = allocate_trace_buffer(NULL, &tr->max_buffer,
 				    allocate_snapshot ? size : 1);
 	if (MEM_FAIL(ret, "Failed to allocate trace buffer\n")) {
 		free_trace_buffer(&tr->array_buffer);
@@ -10473,7 +10474,7 @@ __init static int tracer_alloc_buffers(void)
 		goto out_free_cpumask;
 	/* Used for event triggers */
 	ret = -ENOMEM;
-	temp_buffer = ring_buffer_alloc(PAGE_SIZE, RB_FL_OVERWRITE);
+	temp_buffer = ring_buffer_alloc("temp_buffer", PAGE_SIZE, RB_FL_OVERWRITE);
 	if (!temp_buffer)
 		goto out_rm_hp_state;
 
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



