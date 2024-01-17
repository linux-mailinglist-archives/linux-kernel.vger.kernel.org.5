Return-Path: <linux-kernel+bounces-29105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FFE8308A8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445C81F22F41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B1D21102;
	Wed, 17 Jan 2024 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LCfGoH4F"
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9091320B34;
	Wed, 17 Jan 2024 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705502977; cv=none; b=eLZuqLGytuQspoKhxn6J+nnd/Cplmy6rSfi6Jt5NKDGWFsHrwmVJurWS4/7WQnfGT8dz/80w//WKg3hBkgPnTzJmzDBx0/3PaAj6WqEYFEjTqNYv85Rkdpl0ioIpf/rsGVXfjCoOjqvEgpq39WdPaXCKe/a8jisGgiSiIGMVgtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705502977; c=relaxed/simple;
	bh=PmZxqMzEfd8INp526cDPs8IXWEgBpGY9EnUtDCgjWgM=;
	h=DKIM-Signature:X-IronPort-AV:Received:Received:Received:
	 X-Farcaster-Flow-ID:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding; b=KRoqlFlcraforj2JySSOYzTKGaEdHqT3h02v+FisZHGMDCj5GkAtJKGW2TlJqNP+lRWMtyrFxIpRD5502hVGmfut5KFAj+YK+NJ0bZQA/ZUFA+cPU3wvQjqlSNAOYIqjC+kgZoSn9oLYMw7SsjXviNesdiI7CHG3j6vuhzBpuW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LCfGoH4F; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705502976; x=1737038976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ruxorAX7sTRaNP9DeVEeTzlVbb3kqSKxCB0MMvWdBXg=;
  b=LCfGoH4FXi4F4kIrs6qp0UFPXqGbJmU1yG3bAIu0jVVDj5JrF9jEISSM
   V1RGHZ2Jckk7ccSA4UW3fUUo+9fj+4pjiYOuIYryehcF/DqXCAdG2pGmG
   gPy/uXy85SSeY5pX74NmKquKI4ed8a2s7rr5Vlyd/IcskswqIVeVbfCDZ
   g=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="698396273"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:49:35 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com (Postfix) with ESMTPS id 6E2D040D43;
	Wed, 17 Jan 2024 14:49:33 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:11385]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.213:2525] with esmtp (Farcaster)
 id 8d349bb0-742a-4194-b22b-5d064281ea8f; Wed, 17 Jan 2024 14:49:33 +0000 (UTC)
X-Farcaster-Flow-ID: 8d349bb0-742a-4194-b22b-5d064281ea8f
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:49:32 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:49:29 +0000
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
Subject: [PATCH v3 14/17] tracing: Add kho serialization of trace events
Date: Wed, 17 Jan 2024 14:47:01 +0000
Message-ID: <20240117144704.602-15-graf@amazon.com>
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

Events and thus their parsing handle in ftrace have dynamic IDs that get
assigned whenever the event is added to the system. If we want to parse
trace events after kexec, we need to link event IDs back to the original
trace event that existed before we kexec'ed.

There are broadly 2 paths we could take for that:

  1) Save full event description across KHO, restore after kexec,
     merge identical trace events into a single identifier.
  2) Recover the ID of post-kexec added events so they get the same
     ID after kexec that they had before kexec

This patch implements the second option. It's simpler and thus less
intrusive. However, it means we can not fully parse affected events
when the kernel removes or modifies trace events across a kho kexec.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - Leave anything that requires a name in trace.c to keep buffers
    unnamed entities
  - Put events as array into a property, use fingerprint instead of
    names to identify them
  - Reduce footprint without CONFIG_FTRACE_KHO

v2 -> v3:

  - s/"global_trace"/"global-trace"/
---
 kernel/trace/trace.c        |  3 +-
 kernel/trace/trace_output.c | 89 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_output.h |  5 +++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a5d7f5b4c19f..b5a6a2115b75 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9364,7 +9364,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
 
 static int trace_kho_off_tr(struct trace_array *tr)
 {
-	const char *name = tr->name ? tr->name : "global_trace";
+	const char *name = tr->name ? tr->name : "global-trace";
 	const void *fdt = kho_get_fdt();
 	char *path;
 	int off;
@@ -10648,6 +10648,7 @@ static int trace_kho_notifier(struct notifier_block *self,
 
 	err |= fdt_begin_node(fdt, "ftrace");
 	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+	err |= trace_kho_write_events(fdt);
 	err |= trace_kho_write_trace_array(fdt, &global_trace);
 	err |= fdt_end_node(fdt);
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 3e7fa44dc2b2..7d8815352e20 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -12,6 +12,8 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/mm.h>
 #include <linux/idr.h>
+#include <linux/kexec.h>
+#include <linux/crc32.h>
 
 #include "trace_output.h"
 
@@ -669,6 +671,93 @@ int trace_print_lat_context(struct trace_iterator *iter)
 	return !trace_seq_has_overflowed(s);
 }
 
+/**
+ * event2fp - Return fingerprint of an event
+ * @event: The event to fingerprint
+ *
+ * For KHO, we need to match events before and after kexec to recover its type
+ * id. This function returns a hash that combines an event's name, and all of
+ * its fields' lengths.
+ */
+static u32 event2fp(struct trace_event *event)
+{
+	struct ftrace_event_field *field;
+	struct trace_event_call *call;
+	struct list_head *head;
+	const char *name;
+	u32 crc32 = ~0;
+
+	/* Low type numbers are static, nothing to checksum */
+	if (event->type && event->type < __TRACE_LAST_TYPE)
+		return event->type;
+
+	call = container_of(event, struct trace_event_call, event);
+	name = trace_event_name(call);
+	if (name)
+		crc32 = crc32_le(crc32, name, strlen(name));
+
+	head = trace_get_fields(call);
+	list_for_each_entry(field, head, link)
+		crc32 = crc32_le(crc32, (char *)&field->size, sizeof(field->size));
+
+	return crc32;
+}
+
+struct trace_event_map {
+	u32 crc32;
+	u32 type;
+};
+
+static int __maybe_unused _trace_kho_write_events(void *fdt)
+{
+	struct trace_event_call *call;
+	int count = __TRACE_LAST_TYPE - 1;
+	struct trace_event_map *map;
+	int err = 0;
+	int i;
+
+	down_read(&trace_event_sem);
+	/* Allocate an array that we can place all maps into */
+	list_for_each_entry(call, &ftrace_events, list)
+		count++;
+
+	map = vmalloc(count * sizeof(*map));
+	if (!map)
+		return -ENOMEM;
+
+	/* Then fill the array with all crc32 values */
+	count = 0;
+	for (i = 1; i < __TRACE_LAST_TYPE; i++)
+		map[count++] = (struct trace_event_map) {
+			.crc32 = count,
+			.type = count,
+		};
+
+	list_for_each_entry(call, &ftrace_events, list) {
+		struct trace_event *event = &call->event;
+
+		map[count++] = (struct trace_event_map) {
+			.crc32 = event2fp(event),
+			.type = event->type,
+		};
+	}
+	up_read(&trace_event_sem);
+
+	/* And finally write it into a DT variable */
+	err |= fdt_property(fdt, "events", map, count * sizeof(*map));
+
+	vfree(map);
+	return err;
+}
+
+#ifdef CONFIG_FTRACE_KHO
+int trace_kho_write_events(void *fdt)
+{
+	return _trace_kho_write_events(fdt);
+}
+#endif
+
+
 /**
  * ftrace_find_event - find a registered event
  * @type: the type of event to look for
diff --git a/kernel/trace/trace_output.h b/kernel/trace/trace_output.h
index dca40f1f1da4..07481f295436 100644
--- a/kernel/trace/trace_output.h
+++ b/kernel/trace/trace_output.h
@@ -25,6 +25,11 @@ extern enum print_line_t print_event_fields(struct trace_iterator *iter,
 extern void trace_event_read_lock(void);
 extern void trace_event_read_unlock(void);
 extern struct trace_event *ftrace_find_event(int type);
+#ifdef CONFIG_FTRACE_KHO
+extern int trace_kho_write_events(void *fdt);
+#else
+static inline int trace_kho_write_events(void *fdt) { return -EINVAL; }
+#endif
 
 extern enum print_line_t trace_nop_print(struct trace_iterator *iter,
 					 int flags, struct trace_event *event);
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




