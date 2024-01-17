Return-Path: <linux-kernel+bounces-29108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C718308B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8350E1F24856
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6E62232B;
	Wed, 17 Jan 2024 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="l3/Lz/l9"
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B121356;
	Wed, 17 Jan 2024 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503007; cv=none; b=Tvam91RkCAPbi/UOoIj25TX04liF6/q+IUyVZxdZyEoyYUlgkHuiZOlU3XEvptnZggSNd3yJtRIbcYNp+2BCnlg7zqRzMxMm1gWZl9yqHSD57XJrBRObIGEXMFZjrLe1j4Pe5vk2JMuVcLetcQupRYTZANMyX8HksBS3mmbLL1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503007; c=relaxed/simple;
	bh=9u6BK+UlFxRilMhNjGBFH3LvV7U2DOlD4K2JyCZ48AU=;
	h=DKIM-Signature:X-IronPort-AV:Received:Received:Received:
	 X-Farcaster-Flow-ID:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding; b=srAOXl4EnLBNcIrgg1X3C5CcwbR1LXofQV9dKhcwuL+g7Snx0ZZUmc5NBQ2lFVBmUCojeYHwPrY9KPqZW+hWZ3Iy6J6afkeQ4W6nBWJneDcTv6xUdSKAyTu8ul87cZWTfNEktO60pT60Rq10oaM+vsDmdCDDlNREj+IFCbAuHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=l3/Lz/l9; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705503006; x=1737039006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V7RkoctXcKrPHqjafH3kK9YvW0BnbS/G0GKRcf3+doU=;
  b=l3/Lz/l9o2egQ1M+lRh589LVsnsi859F9jtjDq7IZkfSkKNKKKj1y5f4
   v3wYWJhAjqvF3H+S4rMX7wtHpmSvExNFF11eVB20qHIgREiWsPxBrRcS0
   1vE4aGM3AWVhRRe/xgDgrMZpgbLs1ct8VUYkWCnHsycc1EruHREPUsPAm
   I=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="380369071"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:50:01 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id 1F47E8A896;
	Wed, 17 Jan 2024 14:49:59 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:26388]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.60:2525] with esmtp (Farcaster)
 id 20269b52-e38b-433c-9abe-1cc6bb154dc9; Wed, 17 Jan 2024 14:49:58 +0000 (UTC)
X-Farcaster-Flow-ID: 20269b52-e38b-433c-9abe-1cc6bb154dc9
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:49:58 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:49:54 +0000
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
Subject: [PATCH v3 15/17] tracing: Recover trace events from kexec handover
Date: Wed, 17 Jan 2024 14:47:02 +0000
Message-ID: <20240117144704.602-16-graf@amazon.com>
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




