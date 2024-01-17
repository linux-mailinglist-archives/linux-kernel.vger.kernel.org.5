Return-Path: <linux-kernel+bounces-29094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8581083086A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE891C2159F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3FF20B34;
	Wed, 17 Jan 2024 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QkW2E6hS"
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FEE21114;
	Wed, 17 Jan 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705502857; cv=none; b=tmB/cTJas/M1pT+MKWC6DLnAeNOOQVLIeTYQRhcYdfxkHxr9sIRriKf4WKqoiO35vR6JtiRcjM4zu3u54KqdZfuJ7mTaHrZGxY1APVGRyWP5WbTigKA+nyzkbnKvckfLrSwRUNl6IQeZc0Am1WKH94C1hw/nfPMXc5CUpb55vFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705502857; c=relaxed/simple;
	bh=9vXj90IiKGKBGvNDqdwpYG4pX+UAZIFE8rG9oSA4jPY=;
	h=DKIM-Signature:X-IronPort-AV:Received:Received:Received:
	 X-Farcaster-Flow-ID:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding; b=cpugme1uh9yvKX9CnMTd/durRwMb8XVu4ldcpYTyIps6VrSjbA6Chis0nvBMJMKb1j4k+r2GeJylFbPOCtYx7mbNtj758vfmtC4uJazQdk8E26o0WpwMljzgrMZq7WbWUcVSq3CjPPuRS6D802P1t+/b7j500FegyxbM84ZevOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QkW2E6hS; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705502856; x=1737038856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jf05Sl5lvM0QZsncorT5lB2H0a51ZRNMVxi6LqgXCm8=;
  b=QkW2E6hSg/y4fZGWyEP1J0TYjoG6V2QDeA6DuH7nYHoz2XW22rkpo6fl
   hwNyVti9SYJ51wMwBESAjOY4fxDYsaWRsy1wEVnGcpz7iAKJwjwhp1/py
   jh/T7KhTvX/ULrZcC/Wf7y3Z+js4w7lLPK5hWLJRcLg3gJ/F6Ql0AlqsX
   M=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="698395732"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:47:29 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com (Postfix) with ESMTPS id 733C7C15BD;
	Wed, 17 Jan 2024 14:47:19 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:23414]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.60:2525] with esmtp (Farcaster)
 id 39c2bda5-5806-43df-98c0-f0c689dbdf36; Wed, 17 Jan 2024 14:47:18 +0000 (UTC)
X-Farcaster-Flow-ID: 39c2bda5-5806-43df-98c0-f0c689dbdf36
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:47:18 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:47:14 +0000
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
Subject: [PATCH v3 02/17] memblock: Declare scratch memory as CMA
Date: Wed, 17 Jan 2024 14:46:49 +0000
Message-ID: <20240117144704.602-3-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117144704.602-1-graf@amazon.com>
References: <20240117144704.602-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When we finish populating our memory, we don't want to lose the scratch
region as memory we can use for useful data. Do do that, we mark it as
CMA memory. That means that any allocation within it only happens with
movable memory which we can then happily discard for the next kexec.

That way we don't lose the scratch region's memory anymore for
allocations after boot.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - test bot warning fix

v2 -> v3:

  - s/reserve_scratch_mem/mark_phys_as_cma/
  - Declare scratch memory as CMA: Remove ifdeffery
  - Declare scratch memory as CMA: Remove superfluous comment
---
 mm/memblock.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index fbb98981a202..56530d0469a8 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -16,6 +16,7 @@
 #include <linux/kmemleak.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
+#include <linux/page-isolation.h>
 
 #include <asm/sections.h>
 #include <linux/io.h>
@@ -1134,10 +1135,6 @@ static bool should_skip_region(struct memblock_type *type,
 	if ((flags & MEMBLOCK_SCRATCH) && !memblock_is_scratch(m))
 		return true;
 
-	/* Leave scratch memory alone after scratch-only phase */
-	if (!(flags & MEMBLOCK_SCRATCH) && memblock_is_scratch(m))
-		return true;
-
 	return false;
 }
 
@@ -2188,6 +2185,16 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
 	}
 }
 
+static void mark_phys_as_cma(phys_addr_t start, phys_addr_t end)
+{
+	ulong start_pfn = pageblock_start_pfn(PFN_DOWN(start));
+	ulong end_pfn = pageblock_align(PFN_UP(end));
+	ulong pfn;
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages)
+		set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_CMA);
+}
+
 static unsigned long __init __free_memory_core(phys_addr_t start,
 				 phys_addr_t end)
 {
@@ -2249,6 +2256,17 @@ static unsigned long __init free_low_memory_core_early(void)
 
 	memmap_init_reserved_pages();
 
+	if (IS_ENABLED(CONFIG_MEMBLOCK_SCRATCH)) {
+		/*
+		 * Mark scratch mem as CMA before we return it. That way we
+		 * ensure that no kernel allocations happen on it. That means
+		 * we can reuse it as scratch memory again later.
+		 */
+		__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
+				     MEMBLOCK_SCRATCH, &start, &end, NULL)
+			mark_phys_as_cma(start, end);
+	}
+
 	/*
 	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
 	 *  because in some case like Node0 doesn't have RAM installed
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




