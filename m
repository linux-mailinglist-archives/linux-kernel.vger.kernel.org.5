Return-Path: <linux-kernel+bounces-29103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C90830899
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924681C203BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04969225A5;
	Wed, 17 Jan 2024 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Fk3Fg3PO"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638A224F2;
	Wed, 17 Jan 2024 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705502951; cv=none; b=Whd8af2VP1VyMFcdyfVhlx3tj6piZ3MhHQXLHZHBgI+T0tm7n7wcqRH4FMTJFP2eeYpAdpbemPBFoJ8ZhNvr8lBYyPIXfOH/mwK4CA4gKOQ4mI7odSiNcrURnmBi06RjWM1mdSkwNnxfiwg00np8Z9ZHpNv/E/Ffe0WV8VSnpHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705502951; c=relaxed/simple;
	bh=tQEtk+nRj3gXe70LaVAmp5Voy0p30WSyNWrq9JbTHqs=;
	h=DKIM-Signature:X-IronPort-AV:Received:Received:Received:
	 X-Farcaster-Flow-ID:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding; b=ZalRZBilPDN9opEGsyCEfk2I2VxJee9nhNdt50XOal1tf85Sb0Y0uH6bWNkNyE1jrbuwWVc+X4Y/jUSLQasW1O2pBFM0BoUZo/7sxteQX4+B6GE24dZnOL27Xy2SAT4BCoIqXi0fiMHtVR99+TXJg3EMzwFKiWUeAvgxXuh/4Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Fk3Fg3PO; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705502950; x=1737038950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V9z9IM4flUSgP0z2cJrShPiLgbianVVfqfmMvTzhOC8=;
  b=Fk3Fg3POmoMBg590sWBzjL6TXGrXjs9d3rPaxXQiRnPXho/ly8L7x84Q
   ZssHmWbD1r/3PzZWEx75mkpomLvfvWC0LfwMexEY1ZJzvfgQwdwqpih3H
   ui5Lk7qgjtUIATpxf1FnA7XRwpM6JzTzlnqvxpPoH+MeDQg8ptQ3JpZ/7
   U=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="374981813"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:49:08 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com (Postfix) with ESMTPS id 18794804F6;
	Wed, 17 Jan 2024 14:49:00 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:46192]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.164:2525] with esmtp (Farcaster)
 id c6bac9f3-2890-4c55-abf3-0050bf6f217f; Wed, 17 Jan 2024 14:48:59 +0000 (UTC)
X-Farcaster-Flow-ID: c6bac9f3-2890-4c55-abf3-0050bf6f217f
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:48:59 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:48:55 +0000
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
Subject: [PATCH v3 11/17] tracing: Introduce kho serialization
Date: Wed, 17 Jan 2024 14:46:58 +0000
Message-ID: <20240117144704.602-12-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117144704.602-1-graf@amazon.com>
References: <20240117144704.602-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We want to be able to transfer ftrace state from one kernel to the next.
To start off with, let's establish all the boiler plate to get a write
hook when KHO wants to serialize and fill out basic data.

Follow-up patches will fill in serialization of ring buffers and events.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - Remove ifdefs
---
 kernel/trace/trace.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a0defe156b57..9a0d96975c9c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -32,6 +32,7 @@
 #include <linux/percpu.h>
 #include <linux/splice.h>
 #include <linux/kdebug.h>
+#include <linux/kexec.h>
 #include <linux/string.h>
 #include <linux/mount.h>
 #include <linux/rwsem.h>
@@ -866,6 +867,8 @@ static struct tracer		*trace_types __read_mostly;
  */
 DEFINE_MUTEX(trace_types_lock);
 
+static bool trace_in_kho;
+
 /*
  * serialize the access of the ring buffer
  *
@@ -10574,12 +10577,56 @@ void __init early_trace_init(void)
 	init_events();
 }
 
+static int trace_kho_notifier(struct notifier_block *self,
+			      unsigned long cmd,
+			      void *v)
+{
+	const char compatible[] = "ftrace-v1";
+	void *fdt = v;
+	int err = 0;
+
+	switch (cmd) {
+	case KEXEC_KHO_ABORT:
+		if (trace_in_kho)
+			mutex_unlock(&trace_types_lock);
+		trace_in_kho = false;
+		return NOTIFY_DONE;
+	case KEXEC_KHO_DUMP:
+		/* Handled below */
+		break;
+	default:
+		return NOTIFY_BAD;
+	}
+
+	if (unlikely(tracing_disabled))
+		return NOTIFY_DONE;
+
+	err |= fdt_begin_node(fdt, "ftrace");
+	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+	err |= fdt_end_node(fdt);
+
+	if (!err) {
+		/* Hold all future allocations */
+		mutex_lock(&trace_types_lock);
+		trace_in_kho = true;
+	}
+
+	return err ? NOTIFY_BAD : NOTIFY_DONE;
+}
+
+static struct notifier_block trace_kho_nb = {
+	.notifier_call = trace_kho_notifier,
+};
+
 void __init trace_init(void)
 {
 	trace_event_init();
 
 	if (boot_instance_index)
 		enable_instances();
+
+	if (IS_ENABLED(CONFIG_FTRACE_KHO))
+		register_kho_notifier(&trace_kho_nb);
 }
 
 __init static void clear_boot_tracer(void)
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




