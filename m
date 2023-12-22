Return-Path: <linux-kernel+bounces-10025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 941BD81CEE1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DEC01F23D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7462FC5C;
	Fri, 22 Dec 2023 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Nc+djFcL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFCB2EAFB;
	Fri, 22 Dec 2023 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703273882; x=1734809882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dwhP9TX+qhNuxIBvRPP4G1COkpJHtM0yxRM6jOIEYyk=;
  b=Nc+djFcLtOo1/jrRWNhcnyN36l9OooUXEchfkaUJkwzb4hlHwHWJtSQG
   rt51UPPkILwo+2859r+K9vwkQCIUe02+qdqo2a3kzgdIKXuJ0cb23zSyl
   gRxssphazQFfBVlXb/Ib1gEuKxmunfHOGPdyQXy0czncBDwxm2bFpP59b
   8=;
X-IronPort-AV: E=Sophos;i="6.04,297,1695686400"; 
   d="scan'208";a="262157740"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:38:00 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com (Postfix) with ESMTPS id BDB358B25B;
	Fri, 22 Dec 2023 19:37:58 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:5256]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.144:2525] with esmtp (Farcaster)
 id ce48a30f-05bb-48a3-9e16-f52e7034e6f9; Fri, 22 Dec 2023 19:37:58 +0000 (UTC)
X-Farcaster-Flow-ID: ce48a30f-05bb-48a3-9e16-f52e7034e6f9
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:37:58 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:37:54 +0000
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
Subject: [PATCH v2 10/17] tracing: Initialize fields before registering
Date: Fri, 22 Dec 2023 19:36:00 +0000
Message-ID: <20231222193607.15474-11-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231222193607.15474-1-graf@amazon.com>
References: <20231222193607.15474-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D041UWA004.ant.amazon.com (10.13.139.9) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

With KHO, we need to know all event fields before we allocate an event
type for a trace event so that we can recover it based on a previous
execution context.

Before this patch, fields were only initialized after we allocated a
type id. After this patch, we try to allocate it early as well.

This patch leaves the old late initialization logic in place. The field
init code already validates whether there are any fields present, which
means it's legal to call it multiple times. This way we're sure we don't
miss any call sites.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 include/linux/trace_events.h      |  1 +
 kernel/trace/trace_events.c       | 14 +++++++++-----
 kernel/trace/trace_events_synth.c | 14 +++++++++-----
 kernel/trace/trace_events_user.c  |  4 ++++
 kernel/trace/trace_probe.c        |  4 ++++
 5 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d68ff9b1247f..8fe8970b48e3 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -842,6 +842,7 @@ extern int trace_define_field(struct trace_event_call *call, const char *type,
 extern int trace_add_event_call(struct trace_event_call *call);
 extern int trace_remove_event_call(struct trace_event_call *call);
 extern int trace_event_get_offsets(struct trace_event_call *call);
+extern int trace_event_define_fields(struct trace_event_call *call);
 
 int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 int trace_set_clr_event(const char *system, const char *event, int set);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f29e815ca5b2..fbf8be1d2806 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -462,6 +462,11 @@ static void test_event_printk(struct trace_event_call *call)
 int trace_event_raw_init(struct trace_event_call *call)
 {
 	int id;
+	int ret;
+
+	ret = trace_event_define_fields(call);
+	if (ret)
+		return ret;
 
 	id = register_trace_event(&call->event);
 	if (!id)
@@ -2402,8 +2407,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	return NULL;
 }
 
-static int
-event_define_fields(struct trace_event_call *call)
+int trace_event_define_fields(struct trace_event_call *call)
 {
 	struct list_head *head;
 	int ret = 0;
@@ -2592,7 +2596,7 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 
 	file->ei = ei;
 
-	ret = event_define_fields(call);
+	ret = trace_event_define_fields(call);
 	if (ret < 0) {
 		pr_warn("Could not initialize trace point events/%s\n", name);
 		return ret;
@@ -2978,7 +2982,7 @@ __trace_add_new_event(struct trace_event_call *call, struct trace_array *tr)
 	if (eventdir_initialized)
 		return event_create_dir(tr->event_dir, file);
 	else
-		return event_define_fields(call);
+		return trace_event_define_fields(call);
 }
 
 static void trace_early_triggers(struct trace_event_file *file, const char *name)
@@ -3015,7 +3019,7 @@ __trace_early_add_new_event(struct trace_event_call *call,
 	if (!file)
 		return -ENOMEM;
 
-	ret = event_define_fields(call);
+	ret = trace_event_define_fields(call);
 	if (ret)
 		return ret;
 
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 846e02c0fb59..4db41218ccf7 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -880,17 +880,21 @@ static int register_synth_event(struct synth_event *event)
 	INIT_LIST_HEAD(&call->class->fields);
 	call->event.funcs = &synth_event_funcs;
 	call->class->fields_array = synth_event_fields_array;
+	call->flags = TRACE_EVENT_FL_TRACEPOINT;
+	call->class->reg = trace_event_reg;
+	call->class->probe = trace_event_raw_event_synth;
+	call->data = event;
+	call->tp = event->tp;
+
+	ret = trace_event_define_fields(call);
+	if (ret)
+		goto out;
 
 	ret = register_trace_event(&call->event);
 	if (!ret) {
 		ret = -ENODEV;
 		goto out;
 	}
-	call->flags = TRACE_EVENT_FL_TRACEPOINT;
-	call->class->reg = trace_event_reg;
-	call->class->probe = trace_event_raw_event_synth;
-	call->data = event;
-	call->tp = event->tp;
 
 	ret = trace_add_event_call(call);
 	if (ret) {
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 9365ce407426..b9837e987525 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1900,6 +1900,10 @@ static int user_event_trace_register(struct user_event *user)
 {
 	int ret;
 
+	ret = trace_event_define_fields(&user->call);
+	if (ret)
+		return ret;
+
 	ret = register_trace_event(&user->call.event);
 
 	if (!ret)
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 4dc74d73fc1d..da73a02246d8 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1835,6 +1835,10 @@ int trace_probe_register_event_call(struct trace_probe *tp)
 				  trace_probe_name(tp)))
 		return -EEXIST;
 
+	ret = trace_event_define_fields(call);
+	if (ret)
+		return ret;
+
 	ret = register_trace_event(&call->event);
 	if (!ret)
 		return -ENODEV;
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




