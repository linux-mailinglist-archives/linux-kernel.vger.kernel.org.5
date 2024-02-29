Return-Path: <linux-kernel+bounces-86813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E827486CB2B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A813B2457B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C751369AB;
	Thu, 29 Feb 2024 14:15:08 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE7112F5BF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216108; cv=none; b=FA/3/aYMP+E3Ny7sKR4+fddyti+dPoXB+JkxTB56KXssYjVIWyWj+rr0RMfuEyerD5FlQUacCukDY3bTLw+9Ur9VhoVGFG/iLrlhU/oVUqmjGrhNHo3YpIj5idNQy6+VghOHqUkXirV8aCUh3w7QPQO5dlgsyaFxrReC+SsizoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216108; c=relaxed/simple;
	bh=rzd4JtCwqgERNe+0U2MytHKJF2ruWxwTsPOUunyqin4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AIR1WnctokMlSHSRMSx6AnNFWi36UpChD3kaGAx0Ol3htwWbBDHYx0W3elzNSr5CZMKguA9Nssxit7dYZeEp1cvXVroNOqiWpddpWUgRXF5pRv8rB7v6bIW1pdfKN3TjAXqnCFIJIxZiACZZac4FisJ0dynVP5emAMydS1OxXIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 34a8a4a27f1d4eb58b64b57e66a90f51-20240229
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:a3fe121b-272e-4285-92d4-ef4856197a96,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.37,REQID:a3fe121b-272e-4285-92d4-ef4856197a96,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:85d659ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:240229221451GHP3YYA9,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 34a8a4a27f1d4eb58b64b57e66a90f51-20240229
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 571878668; Thu, 29 Feb 2024 22:14:48 +0800
From: Hao Ge <gehao@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gehao618@163.com,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v2] mm/vmstat: Add order's information for extfrag_index and unusable_index
Date: Thu, 29 Feb 2024 22:14:43 +0800
Message-Id: <20240229141443.99408-1-gehao@kylinos.cn>
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
Node 0, zone    DMA32  ...... ...... ...... ......
Node 0, zone   Normal  ...... ...... ...... ......

cat /sys/kernel/debug/extfrag/unusable_index:
Node 0, zone    DMA32 ..... ..... ..... .....
Node 0, zone   Normal ..... ..... ..... .....

after:
cat /sys/kernel/debug/extfrag/extfrag_index:
Extfrag index at order:       0      1      2      3
Node 0, zone        DMA  ...... ...... ...... ......
Node 0, zone     Normal  ...... ...... ...... ......

cat /sys/kernel/debug/extfrag/unusable_index:
Unusable index at order:     0     1     2     3
Node 0, zone         DMA ..... ..... ..... .....
Node 0, zone      Normal ..... ..... ..... .....

Signed-off-by: Hao Ge <gehao@kylinos.cn>

---
v1 -> v2: Use '.' to replace related values for commit message
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


