Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4989E80FBC4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377644AbjLMAFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377657AbjLMAFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:05:13 -0500
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB79E8;
        Tue, 12 Dec 2023 16:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702425919; x=1733961919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=omkZqOlO4bdGSVCdXn2us+8UWaNPdUSggP3ul/1DY+c=;
  b=X9Yt1XsmBO8hon59sSvxtQj8sudWqrFA2eMdbdpBcQ7uvQVRzlSxKrQO
   OgbmJ+MikfkjHekk6fTOHfUOOaW5/W3wi27SdbsmJK7gFp6xC4x6MaBSN
   +v/6pCqlkBiJmxKg2mK6bWWImATRTVukCgdh4ubZa9hSTvH9GZbvI2+t8
   Y=;
X-IronPort-AV: E=Sophos;i="6.04,271,1695686400"; 
   d="scan'208";a="258636775"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:05:16 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com (Postfix) with ESMTPS id 8651A80643;
        Wed, 13 Dec 2023 00:05:07 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:38785]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.165:2525] with esmtp (Farcaster)
 id ac23c6ff-3564-413c-9f1d-e68dec397645; Wed, 13 Dec 2023 00:05:06 +0000 (UTC)
X-Farcaster-Flow-ID: ac23c6ff-3564-413c-9f1d-e68dec397645
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:05:06 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:05:02 +0000
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
Subject: [PATCH 02/15] memblock: Declare scratch memory as CMA
Date:   Wed, 13 Dec 2023 00:04:39 +0000
Message-ID: <20231213000452.88295-3-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213000452.88295-1-graf@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
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

When we finish populating our memory, we don't want to lose the scratch
region as memory we can use for useful data. Do do that, we mark it as
CMA memory. That means that any allocation within it only happens with
movable memory which we can then happily discard for the next kexec.

That way we don't lose the scratch region's memory anymore for
allocations after boot.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 mm/memblock.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index e89e6c8f9d75..44741424dab7 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -16,6 +16,7 @@
 #include <linux/kmemleak.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
+#include <linux/page-isolation.h>
 
 #include <asm/sections.h>
 #include <linux/io.h>
@@ -1100,10 +1101,6 @@ static bool should_skip_region(struct memblock_type *type,
 	if ((flags & MEMBLOCK_SCRATCH) && !memblock_is_scratch(m))
 		return true;
 
-	/* Leave scratch memory alone after scratch-only phase */
-	if (!(flags & MEMBLOCK_SCRATCH) && memblock_is_scratch(m))
-		return true;
-
 	return false;
 }
 
@@ -2153,6 +2150,20 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
 	}
 }
 
+static void reserve_scratch_mem(phys_addr_t start, phys_addr_t end)
+{
+#ifdef CONFIG_MEMBLOCK_SCRATCH
+	ulong start_pfn = pageblock_start_pfn(PFN_DOWN(start));
+	ulong end_pfn = pageblock_align(PFN_UP(end));
+	ulong pfn;
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages) {
+		/* Mark as CMA to prevent kernel allocations in it */
+		set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_CMA);
+	}
+#endif
+}
+
 static unsigned long __init __free_memory_core(phys_addr_t start,
 				 phys_addr_t end)
 {
@@ -2214,6 +2225,17 @@ static unsigned long __init free_low_memory_core_early(void)
 
 	memmap_init_reserved_pages();
 
+#ifdef CONFIG_MEMBLOCK_SCRATCH
+	/*
+	 * Mark scratch mem as CMA before we return it. That way we ensure that
+	 * no kernel allocations happen on it. That means we can reuse it as
+	 * scratch memory again later.
+	 */
+	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
+			     MEMBLOCK_SCRATCH, &start, &end, NULL)
+		reserve_scratch_mem(start, end);
+#endif
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



