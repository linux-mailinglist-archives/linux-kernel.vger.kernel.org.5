Return-Path: <linux-kernel+bounces-84927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD28986ADC9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD95B24C94
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C29145B3F;
	Wed, 28 Feb 2024 11:33:57 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714FB12FB03
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120037; cv=none; b=TaVHZpHSiDUlI9jrPWRceyCjvIvJ2nGW5ei5hEXE3eOk9luSasKEt/Ay2CQixRD3XrbJG3ZAszszNv7rPmmPpkPVVSSn6ud88pHObXnJn2lRWfTGl4bopaPjspz3Lvs8FO174uY5uQYdWaZvhEzI9F864V1KLs3px4z8S/mn3Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120037; c=relaxed/simple;
	bh=gUfyeQvNV1/M2U0Vbeqsob8hqIPj0nlYRS3hMAuVYvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ffT3c9+ZZJircFnhrX0FjcMgHJ21tN1R3dTrCjlR0ZeHfSn810PW6OeMS7jGzNjQbDE2nSQ/Sock5rx9y4Ui+eSB9LW3AiW42OjSFPzbVvE2ZBk7bmgI83OfHjnkIuFWDv91gUZy4qRoO7TtmAW9LD4g21tIHtA2u/Y1ba2eEPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b331c0d2936e4880b6bfc3d435175d7c-20240228
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:dba71da5-5978-45d9-9c37-9661dd073651,IP:25,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:35
X-CID-INFO: VERSION:1.1.37,REQID:dba71da5-5978-45d9-9c37-9661dd073651,IP:25,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-META: VersionHash:6f543d0,CLOUDID:17184dff-c16b-4159-a099-3b9d0558e447,B
	ulkID:240228193342X0FU5XHX,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: b331c0d2936e4880b6bfc3d435175d7c-20240228
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1088047072; Wed, 28 Feb 2024 19:33:40 +0800
From: Hao Ge <gehao@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gehao618@163.com,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] mm/vmstat: Add order's information for extfrag_index and unusable_index
Date: Wed, 28 Feb 2024 19:33:32 +0800
Message-Id: <20240228113332.358801-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current cat /sys/kernel/debug/extfrag/extfrag_index and
/sys/kernel/debug/extfrag/unusable_index is not friendly to userspace.

We should add order's information so that users can clearly understand
the situation of each order at a glance like pagetypeinfo.

befor:
cat /sys/kernel/debug/extfrag/extfrag_index:
Node 0, zone    DMA32 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 ...
Node 0, zone   Normal -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 ...

cat /sys/kernel/debug/extfrag/unusable_index:
Node 0, zone    DMA32 0.000 0.000 0.000 0.000 0.001 0.003 0.007 ...
Node 0, zone   Normal 0.000 0.053 0.106 0.159 0.205 0.244 0.265 ...

after:
cat /sys/kernel/debug/extfrag/extfrag_index:
Extfrag index at order:      0      1      2      3      4      5 ...
Node 0, zone        DMA -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 ...
Node 0, zone     Normal -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 ...

cat /sys/kernel/debug/extfrag/unusable_index:
Unusable index at order:     0     1     2     3     4     5 ...
Node 0, zone         DMA 0.000 0.030 0.059 0.085 0.096 0.102 ...
Node 0, zone      Normal 0.000 0.225 0.427 0.569 0.776 0.827 ...

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 mm/vmstat.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index db79935e4a54..f604d91e904c 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -2178,7 +2178,7 @@ static void unusable_show_print(struct seq_file *m,
 	int index;
 	struct contig_page_info info;
 
-	seq_printf(m, "Node %d, zone %8s ",
+	seq_printf(m, "Node %d, zone %11s ",
 				pgdat->node_id,
 				zone->name);
 	for (order = 0; order < NR_PAGE_ORDERS; ++order) {
@@ -2201,12 +2201,19 @@ static void unusable_show_print(struct seq_file *m,
  */
 static int unusable_show(struct seq_file *m, void *arg)
 {
+	int order;
 	pg_data_t *pgdat = (pg_data_t *)arg;
 
 	/* check memoryless node */
 	if (!node_state(pgdat->node_id, N_MEMORY))
 		return 0;
 
+	/* Print header */
+        seq_printf(m, "%s ", "Unusable index at order:");
+        for (order = 0; order < NR_PAGE_ORDERS; ++order)
+                seq_printf(m, "%5d ", order);
+        seq_putc(m, '\n');
+
 	walk_zones_in_node(m, pgdat, true, false, unusable_show_print);
 
 	return 0;
@@ -2230,7 +2237,7 @@ static void extfrag_show_print(struct seq_file *m,
 	/* Alloc on stack as interrupts are disabled for zone walk */
 	struct contig_page_info info;
 
-	seq_printf(m, "Node %d, zone %8s ",
+	seq_printf(m, "Node %d, zone %10s ",
 				pgdat->node_id,
 				zone->name);
 	for (order = 0; order < NR_PAGE_ORDERS; ++order) {
@@ -2247,8 +2254,15 @@ static void extfrag_show_print(struct seq_file *m,
  */
 static int extfrag_show(struct seq_file *m, void *arg)
 {
+	int order;
 	pg_data_t *pgdat = (pg_data_t *)arg;
 
+	/* Print header */
+	seq_printf(m, "%s ", "Extfrag index at order:");
+	for (order = 0; order < NR_PAGE_ORDERS; ++order)
+		seq_printf(m, "%6d ", order);
+	seq_putc(m, '\n');
+
 	walk_zones_in_node(m, pgdat, true, false, extfrag_show_print);
 
 	return 0;
-- 
2.25.1


