Return-Path: <linux-kernel+bounces-29110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5053C8308C4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6102C1C22D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF34D2377C;
	Wed, 17 Jan 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SY/xaT2i"
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC5B2233E;
	Wed, 17 Jan 2024 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503014; cv=none; b=GsMI7zn00Dxoffnqh+WS0NB/e4pWzDJLzDSXChqEWlf74CgsZUi11QEvDIN6bMAdy9caFRIuaOW/7TPKx1OZy9QdxmhqfNfdTg3fCYv8WDH7pCIJCY7eIY+iYxq2rao4bTYQ7dSb4GomcsGol7Rn+VJvw03s9MBibJheFure8MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503014; c=relaxed/simple;
	bh=UUfJqxwzaJfKgat15q/d3JONEvY5L8ZpIJR57kcne6I=;
	h=DKIM-Signature:X-IronPort-AV:Received:Received:Received:
	 X-Farcaster-Flow-ID:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding; b=BJHvZqRhnG07OAsiFa+gPPSrhdWH6IVpqHbtbop8t94nsVh9EzCfwaY7b9YN4tqnGDyQgC3vQQg8zP3JKAns7grNGTf9g4kcmn2iJxuFf0NQtItdku2gHk/ImoJiC6DYcpqfNWdfykijpetUFO7RXqxjliBvcMI6NE+lZCU+TgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SY/xaT2i; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705503013; x=1737039013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K22H13Upw8ZJvq6V1e5pgkkFku3zAKlZ1ZPbskJJqpo=;
  b=SY/xaT2i20T4hrpzetlE1V0HFVckm5+tLUPrJfEIJk19tXYpiYqwI0iG
   Pfq16mALcaNfH6/ZbPe3RRQkqp+lZpzreg/O9xXNPwyT+Sdx7IJzwVX33
   KxKnXwlXj3bPZPUgR06plYhZ/u1axC+vHRPYYWde5yKuSVUQ7EL09ivoq
   g=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="697789089"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:50:12 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com (Postfix) with ESMTPS id B58F8100FC5;
	Wed, 17 Jan 2024 14:50:03 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:29526]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.57:2525] with esmtp (Farcaster)
 id bc9be742-cddd-4430-a2bc-c8966b4ce96c; Wed, 17 Jan 2024 14:50:03 +0000 (UTC)
X-Farcaster-Flow-ID: bc9be742-cddd-4430-a2bc-c8966b4ce96c
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:50:02 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:49:58 +0000
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
Subject: [PATCH v3 16/17] tracing: Add config option for kexec handover
Date: Wed, 17 Jan 2024 14:47:03 +0000
Message-ID: <20240117144704.602-17-graf@amazon.com>
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

Now that all bits are in place to allow ftrace to pass its trace data
into the next kernel on kexec, let's give users a kconfig option to
enable the functionality.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - Select crc32
---
 kernel/trace/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 61c541c36596..418a5ae11aac 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -1169,6 +1169,20 @@ config HIST_TRIGGERS_DEBUG
 
           If unsure, say N.
 
+config FTRACE_KHO
+	bool "Ftrace Kexec handover support"
+	depends on KEXEC_KHO
+	select CRC32
+	help
+          Enable support for ftrace to pass metadata across kexec so the new
+	  kernel continues to use the previous kernel's trace buffers.
+
+	  This can be useful when debugging kexec performance or correctness
+	  issues: The new kernel can dump the old kernel's trace buffer which
+	  contains all events until reboot.
+
+	  If unsure, say N.
+
 source "kernel/trace/rv/Kconfig"
 
 endif # FTRACE
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




