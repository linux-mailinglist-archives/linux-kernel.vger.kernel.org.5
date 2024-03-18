Return-Path: <linux-kernel+bounces-106212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A466A87EACF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FA31F21861
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F594F21F;
	Mon, 18 Mar 2024 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NemGzvaQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602294F201
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771726; cv=none; b=K4onqpiKMaYm6rCLTJmRTgX+A/Y1wSQoRjIIghIZbD8AJwdTaRho8PxfaLcO6yhW9VZeNBAIxb7rQlIMwX/1+mUsIbkYDhR5J7tlbNYPoMMWfJqp4Ei9PXRDvo0naNhQH1gQNYUFEE185/tElJtk6E44HhbAu2zhjufIGjJy5wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771726; c=relaxed/simple;
	bh=/3x9uU4JEdnWRIIFRxv/hyPYL+QmN9SSLlG04ZxhdSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=nyxXodNZN9YTxslHYkj6wovDJQcu+S7PWlVcGzHtx485k0MTAlONgmTPpdQZCzwu0P/0Rlb8YAhStBk3cGf4mZCmLPNhL9Ckz+VFM+gGHqzy3YqLsHX9+jsog8j1iLghs2icffi7IJXysFkcZvriltYpUKGdFVETRj81EXeCRk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NemGzvaQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710771724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Ez2QF5MYw9LVg300C2Oo4I1YSujmhzgBkyBgmFJgxw=;
	b=NemGzvaQz6x+9Tvmazy9vlvUIO21sLbjiOkcA5S13eU4fAPFVkHhSew531dQILq15ZDgvN
	yUM1bJpsBmEghjwOoxm7lAup5MIf+J1T3m8CPfs/LUed8h1MxzyB6j2CuelNA88+L7zdcl
	QwVAplpjhg/l1c9IZ6a9reVhfZ2hZqc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-Ksx67UdVPXy4bpjfV4ra_w-1; Mon, 18 Mar 2024 10:22:00 -0400
X-MC-Unique: Ksx67UdVPXy4bpjfV4ra_w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A2F4800269;
	Mon, 18 Mar 2024 14:22:00 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 510F6492BD4;
	Mon, 18 Mar 2024 14:21:57 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/6] mm/mm_init.c: add new function calc_nr_kernel_pages()
Date: Mon, 18 Mar 2024 22:21:35 +0800
Message-ID: <20240318142138.783350-4-bhe@redhat.com>
In-Reply-To: <20240318142138.783350-1-bhe@redhat.com>
References: <20240318142138.783350-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

This is a preparation to calculate nr_kernel_pages and nr_all_pages,
both of which will be used later in alloc_large_system_hash().

nr_all_pages counts up all free but not reserved memory in memblock
allocator, including HIGHMEM memory. While nr_kernel_pages counts up
all free but not reserved low memory in memblock allocator, excluding
HIGHMEM memory.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/mm_init.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 153fb2dc666f..c57a7fc97a16 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1264,6 +1264,30 @@ static void __init reset_memoryless_node_totalpages(struct pglist_data *pgdat)
 	pr_debug("On node %d totalpages: 0\n", pgdat->node_id);
 }
 
+static void __init calc_nr_kernel_pages(void)
+{
+	unsigned long start_pfn, end_pfn;
+	phys_addr_t start_addr, end_addr;
+	u64 u;
+#ifdef CONFIG_HIGHMEM
+	unsigned long high_zone_low = arch_zone_lowest_possible_pfn[ZONE_HIGHMEM];
+#endif
+
+	for_each_free_mem_range(u, NUMA_NO_NODE, MEMBLOCK_NONE, &start_addr, &end_addr, NULL) {
+		start_pfn = PFN_UP(start_addr);
+		end_pfn   = PFN_DOWN(end_addr);
+
+		if (start_pfn < end_pfn) {
+			nr_all_pages += end_pfn - start_pfn;
+#ifdef CONFIG_HIGHMEM
+			start_pfn = clamp(start_pfn, 0, high_zone_low);
+			end_pfn = clamp(end_pfn, 0, high_zone_low);
+#endif
+			nr_kernel_pages += end_pfn - start_pfn;
+		}
+	}
+}
+
 static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 						unsigned long node_start_pfn,
 						unsigned long node_end_pfn)
-- 
2.41.0


