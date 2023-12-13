Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67F80FBEF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377910AbjLMAH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377879AbjLMAHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:07:47 -0500
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01E810E0;
        Tue, 12 Dec 2023 16:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702426047; x=1733962047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mc8BtMBoJccPwXhN5lfGmopEl26ZPwt65Ef0Tkxcd1Y=;
  b=FnOcI0xGSqHXF1IumCe7s2J3qekB/hoJrmN/2OgRnXsHHDROP/5rRwky
   ificEcPRknowG5k4oTm3djXQsxV/VkzrJzqssOywUQ/eUc5ZeAlsJyCem
   oeBXX1OPquiqqSaCUxRVTVdPCzdkJLN5oGMO/GzSpQTKMedUSRlxrg+dv
   s=;
X-IronPort-AV: E=Sophos;i="6.04,271,1695686400"; 
   d="scan'208";a="368122532"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:07:24 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com (Postfix) with ESMTPS id 5BC7680493;
        Wed, 13 Dec 2023 00:07:16 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:32184]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.236:2525] with esmtp (Farcaster)
 id 342278a3-113e-4653-a12d-678bc8408d80; Wed, 13 Dec 2023 00:07:15 +0000 (UTC)
X-Farcaster-Flow-ID: 342278a3-113e-4653-a12d-678bc8408d80
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:07:15 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:07:11 +0000
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
Subject: [PATCH 13/15] tracing: Add kho serialization of trace events
Date:   Wed, 13 Dec 2023 00:04:50 +0000
Message-ID: <20231213000452.88295-14-graf@amazon.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 kernel/trace/trace.c        |  1 +
 kernel/trace/trace_output.c | 28 ++++++++++++++++++++++++++++
 kernel/trace/trace_output.h |  1 +
 3 files changed, 30 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 71c249cc5b43..26edfd2a85fd 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10639,6 +10639,7 @@ static int trace_kho_notifier(struct notifier_block *self,
 	err |= fdt_begin_node(fdt, "ftrace");
 	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
 	err |= trace_kho_write_trace_array(fdt, &global_trace);
+	err |= trace_kho_write_events(fdt);
 	err |= fdt_end_node(fdt);
 
 	if (!err) {
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index f3677e0da795..113de40c616f 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -12,6 +12,7 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/mm.h>
 #include <linux/idr.h>
+#include <linux/kexec.h>
 
 #include "trace_output.h"
 
@@ -669,6 +670,33 @@ int trace_print_lat_context(struct trace_iterator *iter)
 	return !trace_seq_has_overflowed(s);
 }
 
+int trace_kho_write_events(void *fdt)
+{
+#ifdef CONFIG_FTRACE_KHO
+	const char compatible[] = "ftrace,events-v1";
+	const char *name = "events";
+	struct trace_event *event;
+	unsigned key;
+	int err = 0;
+
+	err |= fdt_begin_node(fdt, name);
+	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+
+	for (key = 0; key < EVENT_HASHSIZE; key++) {
+		hlist_for_each_entry(event, &event_hash[key], node)
+			err |= fdt_property(fdt, event->name, &event->type,
+					    sizeof(event->type));
+	}
+
+	err |= fdt_end_node(fdt);
+
+	return err;
+#else
+	return 0;
+#endif
+}
+
+
 /**
  * ftrace_find_event - find a registered event
  * @type: the type of event to look for
diff --git a/kernel/trace/trace_output.h b/kernel/trace/trace_output.h
index dca40f1f1da4..36dc7963269e 100644
--- a/kernel/trace/trace_output.h
+++ b/kernel/trace/trace_output.h
@@ -25,6 +25,7 @@ extern enum print_line_t print_event_fields(struct trace_iterator *iter,
 extern void trace_event_read_lock(void);
 extern void trace_event_read_unlock(void);
 extern struct trace_event *ftrace_find_event(int type);
+extern int trace_kho_write_events(void *fdt);
 
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



