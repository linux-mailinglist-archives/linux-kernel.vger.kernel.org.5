Return-Path: <linux-kernel+bounces-51528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A62D848C34
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7531F2439E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5EE1428E;
	Sun,  4 Feb 2024 08:34:58 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF714277
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707035697; cv=none; b=p2NboSnbXsXFp7jNSu/iJptCihFfjvR+KwAh7w6S/tFgWx/yBfKkCCACpvOWMWSdY9XIijnDm0TQ3lGqn2KYZYYtZHp17jWngFIxU5bkvTx3S2btKVnMMe2MBoFXbgev8w2/pRB2F8NXdD/L8po+C2swjxZBELOoOYXD9K/HzEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707035697; c=relaxed/simple;
	bh=52IuM5w4zXtuLhzfWQ+0wIQOBvpLw9tXlOp2CIEBv1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbB11rs5IvyeYH8tbTfMSoTivxTIilUFH7Y4UK5rCaEXW1wGFN/Ap+jhb73ecAT0GIDZEW0FAx++4FA+0jZiHEY03e1qjadbhMLTjpX12CxAG8c1AXAxc6AgobG2QRHKinGQQjzuq7YQqlft4C9Wcenu0UxyyCg7/eCgr/aW+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost.localdomain (unknown [111.206.94.146])
	by smtp.qiye.163.com (Hmail) with ESMTPA id E6B9C7E011C;
	Sun,  4 Feb 2024 16:34:16 +0800 (CST)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: gregkh@linuxfoundation.org
Cc: rafael@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH] meminfo: provide estimated per-node's available memory
Date: Sun,  4 Feb 2024 03:34:14 -0500
Message-ID: <20240204083414.107799-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZS0pOVk0eGEJOSR5KH04eGVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKSlVJS01VQk9VSk9NWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8d7341047e03a2kunme6b9c7e011c
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PT46Hhw6GjMLHz8VH0wWAjw9
	PCIKCwlVSlVKTEtMS0hOTU5MTENOVTMWGhIXVRcOFBgTDhUIEx4VHDsOCA8YVR4fDkVZV1kSC1lB
	WUpKSlVJS01VQk9VSk9NWVdZCAFZQU5IQks3Bg++

The system offers an estimate of the per-node's available memory,
in addition to the system's available memory provided by /proc/meminfo.

like commit 34e431b0ae39("/proc/meminfo: provide estimated available
memory"), it is more convenient to provide such an estimate in
/sys/bus/node/devices/nodex/meminfo. If things change in the future,
we only have to change it in one place.

Shown below:
/sys/bus/node/devices/node1/meminfo:
Node 1 MemTotal:        4084480 kB
Node 1 MemFree:         3348820 kB
Node 1 MemAvailable:    3647972 kB
Node 1 MemUsed:          735660 kB
...

Link: https://github.com/numactl/numactl/issues/210

Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
---
 drivers/base/node.c |  4 ++++
 include/linux/mm.h  |  1 +
 mm/show_mem.c       | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 1c05640461dd..ba27f25d2b81 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -372,11 +372,13 @@ static ssize_t node_read_meminfo(struct device *dev,
 	int len = 0;
 	int nid = dev->id;
 	struct pglist_data *pgdat = NODE_DATA(nid);
+	long available;
 	struct sysinfo i;
 	unsigned long sreclaimable, sunreclaimable;
 	unsigned long swapcached = 0;
 
 	si_meminfo_node(&i, nid);
+	available = si_mem_node_available(nid);
 	sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
 	sunreclaimable = node_page_state_pages(pgdat, NR_SLAB_UNRECLAIMABLE_B);
 #ifdef CONFIG_SWAP
@@ -385,6 +387,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 	len = sysfs_emit_at(buf, len,
 			    "Node %d MemTotal:       %8lu kB\n"
 			    "Node %d MemFree:        %8lu kB\n"
+			    "Node %d MemAvailable:   %8lu kB\n"
 			    "Node %d MemUsed:        %8lu kB\n"
 			    "Node %d SwapCached:     %8lu kB\n"
 			    "Node %d Active:         %8lu kB\n"
@@ -397,6 +400,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			    "Node %d Mlocked:        %8lu kB\n",
 			    nid, K(i.totalram),
 			    nid, K(i.freeram),
+			    nid, K(available),
 			    nid, K(i.totalram - i.freeram),
 			    nid, K(swapcached),
 			    nid, K(node_page_state(pgdat, NR_ACTIVE_ANON) +
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..3caef083fe5b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3202,6 +3202,7 @@ static inline void show_mem(void)
 extern long si_mem_available(void);
 extern void si_meminfo(struct sysinfo * val);
 extern void si_meminfo_node(struct sysinfo *val, int nid);
+extern long si_mem_node_available(int nid);
 #ifdef __HAVE_ARCH_RESERVED_KERNEL_PAGES
 extern unsigned long arch_reserved_kernel_pages(void);
 #endif
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 8dcfafbd283c..37d4c7212b06 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -86,6 +86,49 @@ void si_meminfo(struct sysinfo *val)
 EXPORT_SYMBOL(si_meminfo);
 
 #ifdef CONFIG_NUMA
+long si_mem_node_available(int nid)
+{
+	int zone_type;
+	long available;
+	unsigned long pagecache;
+	unsigned long wmark_low = 0;
+	unsigned long reclaimable;
+	pg_data_t *pgdat = NODE_DATA(nid);
+
+	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++)
+		wmark_low += low_wmark_pages((&pgdat->node_zones[zone_type]));
+
+	/*
+	 * Estimate the amount of memory available for userspace allocations,
+	 * without causing swapping for mbind process.
+	 */
+	available = sum_zone_node_page_state(nid, NR_FREE_PAGES) - pgdat->totalreserve_pages;
+
+	/*
+	 * Not all the page cache can be freed, otherwise the system will
+	 * start swapping or thrashing. Assume at least half of the page
+	 * cache, or the low watermark worth of cache, needs to stay.
+	 */
+	pagecache = node_page_state(pgdat, NR_ACTIVE_FILE) +
+		node_page_state(pgdat, NR_INACTIVE_FILE);
+	pagecache -= min(pagecache / 2, wmark_low);
+	available += pagecache;
+
+	/*
+	 * Part of the reclaimable slab and other kernel memory consists of
+	 * items that are in use, and cannot be freed. Cap this estimate at the
+	 * low watermark.
+	 */
+	reclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B) +
+		node_page_state(pgdat, NR_KERNEL_MISC_RECLAIMABLE);
+	reclaimable -= min(reclaimable / 2, wmark_low);
+	available += reclaimable;
+
+	if (available < 0)
+		available = 0;
+	return available;
+}
+
 void si_meminfo_node(struct sysinfo *val, int nid)
 {
 	int zone_type;		/* needs to be signed */
-- 
2.43.0


