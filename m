Return-Path: <linux-kernel+bounces-12363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CF981F3B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9E22834F6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A97DDB2;
	Thu, 28 Dec 2023 01:39:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E768D51B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4T0rlC2hZTz1vqJh;
	Thu, 28 Dec 2023 09:39:03 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 9877F1A0195;
	Thu, 28 Dec 2023 09:38:58 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Dec
 2023 09:38:14 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <s.hauer@pengutronix.de>,
	<Tudor.Ambarus@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH RFC 14/17] ubifs: repair: Clean up log and orphan area
Date: Thu, 28 Dec 2023 09:41:09 +0800
Message-ID: <20231228014112.2836317-15-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231228014112.2836317-1-chengzhihao1@huawei.com>
References: <20231228014112.2836317-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000013.china.huawei.com (7.193.23.81)

This is the 12/13 step of repairing. Clean up log and orphan area, all
nodes have been recovered, these two areas should be cleared, otherwise
old content in journal/orphan could be replayed in next mounting.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/repair.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/fs/ubifs/repair.c b/fs/ubifs/repair.c
index 8d40cff26f7a..42124cda5d7d 100644
--- a/fs/ubifs/repair.c
+++ b/fs/ubifs/repair.c
@@ -2367,6 +2367,43 @@ int build_lpt(struct ubifs_info *c)
 	return ubifs_create_lpt(c, c->repair->lpts, c->main_lebs, hash_lpt);
 }
 
+/**
+ * clean_log - clean up log area.
+ * @c: UBIFS file-system description object
+ *
+ * This function cleans up log area, since there is no need to do recovery
+ * in next mounting.
+ */
+static int clean_log(struct ubifs_info *c)
+{
+	int lnum, err;
+	struct ubifs_cs_node *cs;
+
+	for (lnum = UBIFS_LOG_LNUM; lnum <= c->log_last; lnum++) {
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		cond_resched();
+
+		err = ubifs_leb_unmap(c, lnum);
+		if (err)
+			return err;
+	}
+
+	cs = kzalloc(ALIGN(UBIFS_CS_NODE_SZ, c->min_io_size), GFP_KERNEL);
+	if (!cs)
+		return -ENOMEM;
+
+	cs->ch.node_type = UBIFS_CS_NODE;
+	cs->cmt_no = cpu_to_le64(0);
+
+	err = ubifs_write_node(c, cs, UBIFS_CS_NODE_SZ, UBIFS_LOG_LNUM, 0);
+	kfree(cs);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static int do_repair(struct ubifs_info *c)
 {
 	int err = 0;
@@ -2416,6 +2453,16 @@ static int do_repair(struct ubifs_info *c)
 	/* Step 11. Build LPT. */
 	ubifs_msg(c, "Step 11: Build LPT");
 	err = build_lpt(c);
+	if (err)
+		goto out;
+
+	/* Step 12. Clean up log & orphan. */
+	ubifs_msg(c, "Step 12: Clean up log & orphan");
+	err = clean_log(c);
+	if (err)
+		goto out;
+
+	err = ubifs_clear_orphans(c);
 
 out:
 	destroy_scanned_info(c, &si);
-- 
2.31.1


