Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA84D80FBED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377822AbjLMAH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377876AbjLMAHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:07:47 -0500
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7DC171F;
        Tue, 12 Dec 2023 16:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702426050; x=1733962050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ijxY/skruFfgxp/KO2yhFBX0a87YYNVgJHNp25q/K2g=;
  b=R7NSmQrUAop5SGqsD8840QQUTTgeEG6R8+wfoNYtOjYuIbwvdLvde1VW
   5d+VaOun9FxuUzm6mgBiYxJCAbrImxyXOx0apfhi3NCOUk9CjJGeu+nYh
   HdTUt24cbcxcal1AevcOQhzmzyDXmDfkEkXBCI622UVvK0RppoC1zKDlZ
   Y=;
X-IronPort-AV: E=Sophos;i="6.04,271,1695686400"; 
   d="scan'208";a="50248355"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:07:28 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com (Postfix) with ESMTPS id 96E81A0B0F;
        Wed, 13 Dec 2023 00:07:20 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:13591]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.31:2525] with esmtp (Farcaster)
 id d7626d9c-b144-446f-b11a-bed8a3932442; Wed, 13 Dec 2023 00:07:19 +0000 (UTC)
X-Farcaster-Flow-ID: d7626d9c-b144-446f-b11a-bed8a3932442
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:07:19 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:07:15 +0000
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
Subject: [PATCH 14/15] tracing: Recover trace events from kexec handover
Date:   Wed, 13 Dec 2023 00:04:51 +0000
Message-ID: <20231213000452.88295-15-graf@amazon.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements all logic necessary to match a new trace event
that we add against preserved trace events from kho. If we find a match,
we give the new trace event the old event's identifier. That way, trace
read-outs are able to make sense of buffer contents again because the
parsing code for events looks at the same identifiers.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 kernel/trace/trace_output.c | 65 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 113de40c616f..d2e2a6346322 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -749,6 +749,67 @@ void trace_event_read_unlock(void)
 	up_read(&trace_event_sem);
 }
 
+/**
+ * trace_kho_fill_event_type - restore event type info from KHO
+ * @event: the event type to enumerate
+ *
+ * Event types are semi-dynamically generated. To ensure that
+ * their identifiers match before and after kexec with KHO,
+ * let's match up unique name identifiers and fill in the
+ * respective ID information if we booted with KHO.
+ */
+static bool trace_kho_fill_event_type(struct trace_event *event)
+{
+#ifdef CONFIG_FTRACE_KHO
+	const char *path = "/ftrace/events";
+	void *fdt = kho_get_fdt();
+	int err, len, off, id;
+	const void *p;
+
+	if (!fdt)
+		return false;
+
+	if (WARN_ON(!event->name))
+		return false;
+
+	pr_debug("Trying to revive event '%s'", event->name);
+
+	off = fdt_path_offset(fdt, path);
+	if (off < 0) {
+		pr_debug("Could not find '%s' in DT", path);
+		return false;
+	}
+
+	err = fdt_node_check_compatible(fdt, off, "ftrace,events-v1");
+	if (err) {
+		pr_warn("Node '%s' has invalid compatible", path);
+		return false;
+	}
+
+	p = fdt_getprop(fdt, off, event->name, &len);
+	if (!p) {
+		pr_warn("Event '%s' not found", event->name);
+		return false;
+	}
+
+	if (len != sizeof(event->type)) {
+		pr_warn("Event '%s' has invalid length", event->name);
+		return false;
+	}
+
+	id = *(const u32 *)p;
+
+	/* Mark ID as in use */
+	if (ida_alloc_range(&trace_event_ida, id, id, GFP_KERNEL) != id)
+		return false;
+
+	event->type = id;
+	return true;
+#endif
+
+	return false;
+}
+
 /**
  * register_trace_event - register output for an event type
  * @event: the event type to register
@@ -777,7 +838,9 @@ int register_trace_event(struct trace_event *event)
 	if (WARN_ON(!event->funcs))
 		goto out;
 
-	if (!event->type) {
+	if (trace_kho_fill_event_type(event)) {
+		pr_debug("Recovered '%s' as id=%d", event->name, event->type);
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



