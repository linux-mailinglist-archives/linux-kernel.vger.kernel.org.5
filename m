Return-Path: <linux-kernel+bounces-10042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 495EC81CF0F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CCF91C22D66
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEAF2E859;
	Fri, 22 Dec 2023 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="h/IlO34z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0C52E83F;
	Fri, 22 Dec 2023 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703274823; x=1734810823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V7RkoctXcKrPHqjafH3kK9YvW0BnbS/G0GKRcf3+doU=;
  b=h/IlO34zO4KtQw/CivccLj3BXMI5tfEPut59ORmPA/YQHmY9EfGHEeSd
   qNo3GpW0VD3eVWw7RL+YOlon3zWE3dE/pD8bLH2C1Tg0LR47OHXSul4Ez
   HUDC4iNdoHs02FuAyq2tntPuDDcjFEW0E1y4nrdYDKn4nN7D8uZFUKbPx
   w=;
X-IronPort-AV: E=Sophos;i="6.04,297,1695686400"; 
   d="scan'208";a="693396640"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:53:40 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com (Postfix) with ESMTPS id 72469C1DD1;
	Fri, 22 Dec 2023 19:53:31 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:12400]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.188:2525] with esmtp (Farcaster)
 id dfbf3b6e-c104-498b-b8dd-3bacfde49b32; Fri, 22 Dec 2023 19:53:30 +0000 (UTC)
X-Farcaster-Flow-ID: dfbf3b6e-c104-498b-b8dd-3bacfde49b32
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:53:30 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:53:26 +0000
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
Subject: [PATCH v2 15/17] tracing: Recover trace events from kexec handover
Date: Fri, 22 Dec 2023 19:51:42 +0000
Message-ID: <20231222195144.24532-10-graf@amazon.com>
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

This patch implements all logic necessary to match a new trace event
that we add against preserved trace events from kho. If we find a match,
we give the new trace event the old event's identifier. That way, trace
read-outs are able to make sense of buffer contents again because the
parsing code for events looks at the same identifiers.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - make kho_get_fdt() const
  - Get events as array from a property, use fingerprint instead of
    names to identify events
  - Remove ifdefs
---
 kernel/trace/trace_output.c | 158 +++++++++++++++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 7d8815352e20..937002a204e1 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -24,6 +24,8 @@ DECLARE_RWSEM(trace_event_sem);
 
 static struct hlist_head event_hash[EVENT_HASHSIZE] __read_mostly;
 
+static bool trace_is_kho_event(int type);
+
 enum print_line_t trace_print_bputs_msg_only(struct trace_iterator *iter)
 {
 	struct trace_seq *s = &iter->seq;
@@ -784,7 +786,7 @@ static DEFINE_IDA(trace_event_ida);
 
 static void free_trace_event_type(int type)
 {
-	if (type >= __TRACE_LAST_TYPE)
+	if (type >= __TRACE_LAST_TYPE && !trace_is_kho_event(type))
 		ida_free(&trace_event_ida, type);
 }
 
@@ -810,6 +812,156 @@ void trace_event_read_unlock(void)
 	up_read(&trace_event_sem);
 }
 
+
+/**
+ * trace_kho_get_map - Return the KHO event map
+ * @pmap: Pointer to a trace map array. Will be filled on success.
+ * @plen: Pointer to the length of the map. Will be filled on success.
+ * @unallocated: True if the event does not have an ID yet
+ *
+ * Event types are semi-dynamically generated. To ensure that
+ * their identifiers match before and after kexec with KHO,
+ * we store an event map in the KHO DT. Whenever we need the
+ * map, this function provides it.
+ *
+ * The first time we request a map, it also walks through it and
+ * reserves all identifiers so later event registration has find their
+ * identifier already reserved.
+ */
+static int trace_kho_get_map(const struct trace_event_map **pmap, int *plen,
+			     bool unallocated)
+{
+	static const struct trace_event_map *event_map;
+	static int event_map_len;
+	static bool event_map_reserved;
+	const struct trace_event_map *map = NULL;
+	const void *fdt = kho_get_fdt();
+	const char *path = "/ftrace";
+	int off, err, len = 0;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_FTRACE_KHO) || !fdt)
+		return -EINVAL;
+
+	if (event_map) {
+		map = event_map;
+		len = event_map_len;
+	}
+
+	if (!map) {
+		off = fdt_path_offset(fdt, path);
+
+		if (off < 0) {
+			pr_debug("Could not find '%s' in DT", path);
+			return -EINVAL;
+		}
+
+		err = fdt_node_check_compatible(fdt, off, "ftrace-v1");
+		if (err) {
+			pr_warn("Node '%s' has invalid compatible", path);
+			return -EINVAL;
+		}
+
+		map = fdt_getprop(fdt, off, "events", &len);
+		if (!map)
+			return -EINVAL;
+
+		event_map = map;
+		event_map_len = len;
+	}
+
+	if (unallocated && !event_map_reserved) {
+		/*
+		 * Reserve all IDs in our IDA. We only have a working IDA later
+		 * in boot, so restrict it to when we allocate a dynamic type id
+		 * for an event.
+		 */
+		for (i = 0; i < len; i += sizeof(*map)) {
+			const struct trace_event_map *imap = (void *)map + i;
+
+			if (imap->type < __TRACE_LAST_TYPE)
+				continue;
+			if (ida_alloc_range(&trace_event_ida, imap->type, imap->type,
+					    GFP_KERNEL) != imap->type) {
+				pr_warn("Unable to reserve id %d", imap->type);
+				return -EINVAL;
+			}
+		}
+
+		event_map_reserved = true;
+	}
+
+	*pmap = map;
+	*plen = len;
+
+	return 0;
+}
+
+/**
+ * trace_is_kho_event - returns true if the event type is KHO reserved
+ * @event: the event type to enumerate
+ *
+ * With KHO, we reserve all previous kernel's trace event types in the
+ * KHO DT. Then, when we allocate a type, we just reuse the previous
+ * kernel's value. However, that means we have to keep these type identifiers
+ * reserved across the lifetime of the system, because we may get a new event
+ * that matches the old kernel's event fingerprint. This function is a small
+ * helper that allows us to check whether a type ID is in use by KHO.
+ */
+static bool trace_is_kho_event(int type)
+{
+	const struct trace_event_map *map = NULL;
+	int len, i;
+
+	if (trace_kho_get_map(&map, &len, false))
+		return false;
+
+	if (!map)
+		return false;
+
+	for (i = 0; i < len; i += sizeof(*map), map++)
+		if (map->type == type)
+			return true;
+
+	return false;
+}
+
+/**
+ * trace_kho_fill_event_type - restore event type info from KHO
+ * @event: the event to enumerate
+ *
+ * Event types are semi-dynamically generated. To ensure that
+ * their identifiers match before and after kexec with KHO,
+ * let's match up unique fingerprint - either their predetermined
+ * type or their crc32 value - and fill in the respective type
+ * information if we booted with KHO.
+ */
+static bool trace_kho_fill_event_type(struct trace_event *event)
+{
+	const struct trace_event_map *map = NULL;
+	int len = 0, i;
+	u32 crc32;
+
+	if (trace_kho_get_map(&map, &len, !event->type))
+		return false;
+
+	crc32 = event2fp(event);
+
+	for (i = 0; i < len; i += sizeof(*map), map++) {
+		if (map->crc32 == crc32) {
+			if (!map->type)
+				return false;
+
+			event->type = map->type;
+			return true;
+		}
+	}
+
+	pr_debug("Could not find event");
+
+	return false;
+}
+
 /**
  * register_trace_event - register output for an event type
  * @event: the event type to register
@@ -838,7 +990,9 @@ int register_trace_event(struct trace_event *event)
 	if (WARN_ON(!event->funcs))
 		goto out;
 
-	if (!event->type) {
+	if (trace_kho_fill_event_type(event)) {
+		pr_debug("Recovered id=%d", event->type);
+	} else if (!event->type) {
 		event->type = alloc_trace_event_type();
 		if (!event->type)
 			goto out;
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




