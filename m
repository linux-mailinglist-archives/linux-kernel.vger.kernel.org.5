Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA357F0AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjKTDT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjKTDTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:19:55 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC1F137
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:19:50 -0800 (PST)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SYXj30Chkz1P6j8;
        Mon, 20 Nov 2023 11:16:23 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 Nov
 2023 11:19:48 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <Carson.Li1@unisoc.com>,
        <s.hauer@pengutronix.de>, <houtao1@huawei.com>,
        <ext-adrian.hunter@nokia.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] ubifs: ubifs_tnc_locate: Drop TNC mutex lockless reading path
Date:   Mon, 20 Nov 2023 19:13:46 +0800
Message-ID: <20231120111347.2254153-3-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120111347.2254153-1-chengzhihao1@huawei.com>
References: <20231120111347.2254153-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This problem is described in [1], and Tao has proposed a solution in [2].
There exists a race between node reading and gc, which is shown as:
         P1                 P2
ubifs_tnc_locate
 zbr.lnum = lnum_a
                         GC // node is moved from lnum_a to lnum_b
			 journal head switching // lnum_a becomes a bud
 ubifs_get_wbuf(c, zbr.lnum) // true
 ubifs_tnc_read_node
  ubifs_read_node_wbuf // read data from lnum_a
  check node failed !

There are two ways of reading node(See ubifs_tnc_read_node()):
1. Reading from wbuf. The node is written in wbuf(in mem), and wbuf is
   not written back to flash.
2. Otherwise, reading from flash.

In most cases, ubifs_tnc_read_node() is invoked with TNC mutex locked,
but except the lockless path in ubifs_tnc_locate() which is imported
by commit 601c0bc46753("UBIFS: allow for racing between GC and TNC").

Function ubifs_tnc_locate() is mainly used for path lookup and file
reading, VFS has inode/dentry/page cache for multiple times reading, the
lockless optimization only works for first reading. Based on the
discussion in [2], this patch simply drops the TNC mutex lockless reading
path in ubifs_tnc_locate().

Fetch a reproducer in [3].

[1] https://lore.kernel.org/all/fda84926-09d1-1fc7-4b78-99e0d04508bc@huawei.com/T/
[2] https://lore.kernel.org/linux-mtd/20200305092205.127758-1-houtao1@huawei.com/
[3] https://bugzilla.kernel.org/show_bug.cgi?id=218163

Fixes: 601c0bc46753 ("UBIFS: allow for racing between GC and TNC")
Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Reported-by: 李傲傲 (Carson Li1/9542) <Carson.Li1@unisoc.com>
Analyzed-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/tnc.c | 31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index f4728e65d1bd..7b7d75ed3ec7 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -1478,11 +1478,10 @@ static int maybe_leb_gced(struct ubifs_info *c, int lnum, int gc_seq1)
 int ubifs_tnc_locate(struct ubifs_info *c, const union ubifs_key *key,
 		     void *node, int *lnum, int *offs)
 {
-	int found, n, err, safely = 0, gc_seq1;
+	int found, n, err;
 	struct ubifs_znode *znode;
-	struct ubifs_zbranch zbr, *zt;
+	struct ubifs_zbranch *zt;
 
-again:
 	mutex_lock(&c->tnc_mutex);
 	found = ubifs_lookup_level0(c, key, &znode, &n);
 	if (!found) {
@@ -1505,31 +1504,7 @@ int ubifs_tnc_locate(struct ubifs_info *c, const union ubifs_key *key,
 		err = tnc_read_hashed_node(c, zt, node);
 		goto out;
 	}
-	if (safely) {
-		err = ubifs_tnc_read_node(c, zt, node);
-		goto out;
-	}
-	/* Drop the TNC mutex prematurely and race with garbage collection */
-	zbr = znode->zbranch[n];
-	gc_seq1 = c->gc_seq;
-	mutex_unlock(&c->tnc_mutex);
-
-	if (ubifs_get_wbuf(c, zbr.lnum)) {
-		/* We do not GC journal heads */
-		err = ubifs_tnc_read_node(c, &zbr, node);
-		return err;
-	}
-
-	err = fallible_read_node(c, key, &zbr, node);
-	if (err <= 0 || maybe_leb_gced(c, zbr.lnum, gc_seq1)) {
-		/*
-		 * The node may have been GC'ed out from under us so try again
-		 * while keeping the TNC mutex locked.
-		 */
-		safely = 1;
-		goto again;
-	}
-	return 0;
+	err = ubifs_tnc_read_node(c, zt, node);
 
 out:
 	mutex_unlock(&c->tnc_mutex);
-- 
2.39.2

