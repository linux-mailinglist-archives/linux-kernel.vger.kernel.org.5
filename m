Return-Path: <linux-kernel+bounces-84957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A0086AE2F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CE8296934
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2A42561D;
	Wed, 28 Feb 2024 11:48:29 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC9B73533
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120908; cv=none; b=PIw+ev+RDXessoQ1dTEFq11FkcugWVWnDbKTjIro8h3ymGz/EOgIfCpR7nn7fecXTu3PyLJUjYRU+3JYqyglkVMHtB/H25RQI933QK3qQpHTv81BzX46GD2L0bLM0JRljt1E1C/00EoTHBboEexXc7aDaIGCcT0/4m/CGf3PWPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120908; c=relaxed/simple;
	bh=WL1fpduwUEpRKgpUq+pEj/knyqDpO+pLivu9HQ6uSH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PQir9+oXoD3nYpRtuWnsmrR8i9zlbylznPL1tyqcZAmzMUKK4sFCZfx/GscESPu+fRuqh0d9uOTPowbRm9pqLPWwx8lCDE6D5Thbn3DedxaLCEkvF0WeW7H3vEuVMNZSiVLvQkYptWlw3T+Urwn7pUoBgrw7YONGH0AvNJ2c11A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dde3066479fe4382bc4efadbeab66e36-20240228
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:ed1b5a2b-df31-4a64-b9ae-00bffb2acdba,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:25
X-CID-INFO: VERSION:1.1.37,REQID:ed1b5a2b-df31-4a64-b9ae-00bffb2acdba,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:25
X-CID-META: VersionHash:6f543d0,CLOUDID:bf656884-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240228193342X0FU5XHX,BulkQuantity:5,Recheck:0,SF:24|17|19|44|66|102,
	TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: dde3066479fe4382bc4efadbeab66e36-20240228
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1002070599; Wed, 28 Feb 2024 19:48:20 +0800
From: Hao Ge <gehao@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gehao618@163.com,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] mm/vmstat: Add order's information for extfrag_index and unusable_index
Date: Wed, 28 Feb 2024 19:48:17 +0800
Message-Id: <20240228114817.360084-1-gehao@kylinos.cn>
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

before:
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
index db79935e4a54..fe0b811e9d7f 100644
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
+	seq_printf(m, "%s ", "Unusable index at order:");
+	for (order = 0; order < NR_PAGE_ORDERS; ++order)
+		seq_printf(m, "%5d ", order);
+	seq_putc(m, '\n');
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


