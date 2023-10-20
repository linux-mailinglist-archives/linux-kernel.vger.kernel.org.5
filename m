Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC357D062B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346811AbjJTBcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjJTBcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:32:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545F8119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:32:36 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SBRmp2R1BzLpBL;
        Fri, 20 Oct 2023 09:28:26 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 20 Oct 2023 09:32:33 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <dwmw2@infradead.org>, <richard@nod.at>
CC:     <nixiaoming@huawei.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <liucheng32@huawei.com>
Subject: [PATCH] jffs2: Simplify code to remove invalid branches
Date:   Fri, 20 Oct 2023 09:18:42 +0800
Message-ID: <20231020011842.14881-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 2f785402f39b9 ("[JFFS2] Reduce visibility of raw_node_ref to
 upper layers of JFFS2 code."), jffs2_scan_dirty_space() returns only 0.
Therefore, we can simplify the code, change the function prototype to void,
 and delete the code for judging the return value.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 fs/jffs2/nodelist.c |  6 ++--
 fs/jffs2/nodelist.h |  2 +-
 fs/jffs2/scan.c     | 76 +++++++++++++++------------------------------
 fs/jffs2/summary.c  |  6 ++--
 4 files changed, 31 insertions(+), 59 deletions(-)

diff --git a/fs/jffs2/nodelist.c b/fs/jffs2/nodelist.c
index b86c78d178c6..72cefffe205f 100644
--- a/fs/jffs2/nodelist.c
+++ b/fs/jffs2/nodelist.c
@@ -659,11 +659,11 @@ struct jffs2_raw_node_ref *jffs2_link_node_ref(struct jffs2_sb_info *c,
 }
 
 /* No locking, no reservation of 'ref'. Do not use on a live file system */
-int jffs2_scan_dirty_space(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb,
+void jffs2_scan_dirty_space(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb,
 			   uint32_t size)
 {
 	if (!size)
-		return 0;
+		return;
 	if (unlikely(size > jeb->free_size)) {
 		pr_crit("Dirty space 0x%x larger then free_size 0x%x (wasted 0x%x)\n",
 			size, jeb->free_size, jeb->wasted_size);
@@ -685,7 +685,7 @@ int jffs2_scan_dirty_space(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb
 		jffs2_link_node_ref(c, jeb, ofs, size, NULL);
 	}
 
-	return 0;
+	return;
 }
 
 /* Calculate totlen from surrounding nodes or eraseblock */
diff --git a/fs/jffs2/nodelist.h b/fs/jffs2/nodelist.h
index 2e98fa277dab..63541ac7e783 100644
--- a/fs/jffs2/nodelist.h
+++ b/fs/jffs2/nodelist.h
@@ -462,7 +462,7 @@ int jffs2_scan_medium(struct jffs2_sb_info *c);
 void jffs2_rotate_lists(struct jffs2_sb_info *c);
 struct jffs2_inode_cache *jffs2_scan_make_ino_cache(struct jffs2_sb_info *c, uint32_t ino);
 int jffs2_scan_classify_jeb(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb);
-int jffs2_scan_dirty_space(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb, uint32_t size);
+void jffs2_scan_dirty_space(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb, uint32_t size);
 
 /* build.c */
 int jffs2_do_mount_fs(struct jffs2_sb_info *c);
diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 29671e33a171..1e8803a498f9 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -72,8 +72,7 @@ static int file_dirty(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb)
 
 	if ((ret = jffs2_prealloc_raw_node_refs(c, jeb, 1)))
 		return ret;
-	if ((ret = jffs2_scan_dirty_space(c, jeb, jeb->free_size)))
-		return ret;
+	jffs2_scan_dirty_space(c, jeb, jeb->free_size);
 	/* Turned wasted size into dirty, since we apparently 
 	   think it's recoverable now. */
 	jeb->dirty_size += jeb->wasted_size;
@@ -333,14 +332,12 @@ static int jffs2_scan_xattr_node(struct jffs2_sb_info *c, struct jffs2_erasebloc
 {
 	struct jffs2_xattr_datum *xd;
 	uint32_t xid, version, totlen, crc;
-	int err;
 
 	crc = crc32(0, rx, sizeof(struct jffs2_raw_xattr) - 4);
 	if (crc != je32_to_cpu(rx->node_crc)) {
 		JFFS2_WARNING("node CRC failed at %#08x, read=%#08x, calc=%#08x\n",
 			      ofs, je32_to_cpu(rx->node_crc), crc);
-		if ((err = jffs2_scan_dirty_space(c, jeb, je32_to_cpu(rx->totlen))))
-			return err;
+		jffs2_scan_dirty_space(c, jeb, je32_to_cpu(rx->totlen));
 		return 0;
 	}
 
@@ -352,8 +349,7 @@ static int jffs2_scan_xattr_node(struct jffs2_sb_info *c, struct jffs2_erasebloc
 	if (totlen != je32_to_cpu(rx->totlen)) {
 		JFFS2_WARNING("node length mismatch at %#08x, read=%u, calc=%u\n",
 			      ofs, je32_to_cpu(rx->totlen), totlen);
-		if ((err = jffs2_scan_dirty_space(c, jeb, je32_to_cpu(rx->totlen))))
-			return err;
+		jffs2_scan_dirty_space(c, jeb, je32_to_cpu(rx->totlen));
 		return 0;
 	}
 
@@ -389,14 +385,12 @@ static int jffs2_scan_xref_node(struct jffs2_sb_info *c, struct jffs2_eraseblock
 {
 	struct jffs2_xattr_ref *ref;
 	uint32_t crc;
-	int err;
 
 	crc = crc32(0, rr, sizeof(*rr) - 4);
 	if (crc != je32_to_cpu(rr->node_crc)) {
 		JFFS2_WARNING("node CRC failed at %#08x, read=%#08x, calc=%#08x\n",
 			      ofs, je32_to_cpu(rr->node_crc), crc);
-		if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(rr->totlen)))))
-			return err;
+		jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(rr->totlen)));
 		return 0;
 	}
 
@@ -404,8 +398,7 @@ static int jffs2_scan_xref_node(struct jffs2_sb_info *c, struct jffs2_eraseblock
 		JFFS2_WARNING("node length mismatch at %#08x, read=%u, calc=%zd\n",
 			      ofs, je32_to_cpu(rr->totlen),
 			      PAD(sizeof(struct jffs2_raw_xref)));
-		if ((err = jffs2_scan_dirty_space(c, jeb, je32_to_cpu(rr->totlen))))
-			return err;
+		jffs2_scan_dirty_space(c, jeb, je32_to_cpu(rr->totlen));
 		return 0;
 	}
 
@@ -600,8 +593,7 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 			  jeb->offset + ofs);
 		if ((err = jffs2_prealloc_raw_node_refs(c, jeb, 1)))
 			return err;
-		if ((err = jffs2_scan_dirty_space(c, jeb, ofs)))
-			return err;
+		jffs2_scan_dirty_space(c, jeb, ofs);
 	}
 
 	/* Now ofs is a complete physical flash offset as it always was... */
@@ -631,8 +623,7 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 		if (ofs == prevofs) {
 			pr_warn("ofs 0x%08x has already been seen. Skipping\n",
 				ofs);
-			if ((err = jffs2_scan_dirty_space(c, jeb, 4)))
-				return err;
+			jffs2_scan_dirty_space(c, jeb, 4);
 			ofs += 4;
 			continue;
 		}
@@ -643,8 +634,7 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 				  sizeof(struct jffs2_unknown_node),
 				  jeb->offset, c->sector_size, ofs,
 				  sizeof(*node));
-			if ((err = jffs2_scan_dirty_space(c, jeb, (jeb->offset + c->sector_size)-ofs)))
-				return err;
+			jffs2_scan_dirty_space(c, jeb, (jeb->offset + c->sector_size)-ofs);
 			break;
 		}
 
@@ -676,8 +666,7 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 				if (unlikely(*(uint32_t *)(&buf[inbuf_ofs]) != 0xffffffff)) {
 					pr_warn("Empty flash at 0x%08x ends at 0x%08x\n",
 						empty_start, ofs);
-					if ((err = jffs2_scan_dirty_space(c, jeb, ofs-empty_start)))
-						return err;
+					jffs2_scan_dirty_space(c, jeb, ofs-empty_start);
 					goto scan_more;
 				}
 
@@ -724,23 +713,20 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 		if (ofs == jeb->offset && je16_to_cpu(node->magic) == KSAMTIB_CIGAM_2SFFJ) {
 			pr_warn("Magic bitmask is backwards at offset 0x%08x. Wrong endian filesystem?\n",
 				ofs);
-			if ((err = jffs2_scan_dirty_space(c, jeb, 4)))
-				return err;
+			jffs2_scan_dirty_space(c, jeb, 4);
 			ofs += 4;
 			continue;
 		}
 		if (je16_to_cpu(node->magic) == JFFS2_DIRTY_BITMASK) {
 			jffs2_dbg(1, "Dirty bitmask at 0x%08x\n", ofs);
-			if ((err = jffs2_scan_dirty_space(c, jeb, 4)))
-				return err;
+			jffs2_scan_dirty_space(c, jeb, 4);
 			ofs += 4;
 			continue;
 		}
 		if (je16_to_cpu(node->magic) == JFFS2_OLD_MAGIC_BITMASK) {
 			pr_warn("Old JFFS2 bitmask found at 0x%08x\n", ofs);
 			pr_warn("You cannot use older JFFS2 filesystems with newer kernels\n");
-			if ((err = jffs2_scan_dirty_space(c, jeb, 4)))
-				return err;
+			jffs2_scan_dirty_space(c, jeb, 4);
 			ofs += 4;
 			continue;
 		}
@@ -750,8 +736,7 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 				     __func__,
 				     JFFS2_MAGIC_BITMASK, ofs,
 				     je16_to_cpu(node->magic));
-			if ((err = jffs2_scan_dirty_space(c, jeb, 4)))
-				return err;
+			jffs2_scan_dirty_space(c, jeb, 4);
 			ofs += 4;
 			continue;
 		}
@@ -769,8 +754,7 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 				     je32_to_cpu(node->totlen),
 				     je32_to_cpu(node->hdr_crc),
 				     hdr_crc);
-			if ((err = jffs2_scan_dirty_space(c, jeb, 4)))
-				return err;
+			jffs2_scan_dirty_space(c, jeb, 4);
 			ofs += 4;
 			continue;
 		}
@@ -780,8 +764,7 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 			pr_warn("Node at 0x%08x with length 0x%08x would run over the end of the erase block\n",
 				ofs, je32_to_cpu(node->totlen));
 			pr_warn("Perhaps the file system was created with the wrong erase size?\n");
-			if ((err = jffs2_scan_dirty_space(c, jeb, 4)))
-				return err;
+			jffs2_scan_dirty_space(c, jeb, 4);
 			ofs += 4;
 			continue;
 		}
@@ -790,8 +773,7 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 			/* Wheee. This is an obsoleted node */
 			jffs2_dbg(2, "Node at 0x%08x is obsolete. Skipping\n",
 				  ofs);
-			if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(node->totlen)))))
-				return err;
+			jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(node->totlen)));
 			ofs += PAD(je32_to_cpu(node->totlen));
 			continue;
 		}
@@ -874,14 +856,12 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 				pr_notice("CLEANMARKER node found at 0x%08x has totlen 0x%x != normal 0x%x\n",
 					  ofs, je32_to_cpu(node->totlen),
 					  c->cleanmarker_size);
-				if ((err = jffs2_scan_dirty_space(c, jeb, PAD(sizeof(struct jffs2_unknown_node)))))
-					return err;
+				jffs2_scan_dirty_space(c, jeb, PAD(sizeof(struct jffs2_unknown_node)));
 				ofs += PAD(sizeof(struct jffs2_unknown_node));
 			} else if (jeb->first_node) {
 				pr_notice("CLEANMARKER node found at 0x%08x, not first node in block (0x%08x)\n",
 					  ofs, jeb->offset);
-				if ((err = jffs2_scan_dirty_space(c, jeb, PAD(sizeof(struct jffs2_unknown_node)))))
-					return err;
+				jffs2_scan_dirty_space(c, jeb, PAD(sizeof(struct jffs2_unknown_node)));
 				ofs += PAD(sizeof(struct jffs2_unknown_node));
 			} else {
 				jffs2_link_node_ref(c, jeb, ofs | REF_NORMAL, c->cleanmarker_size, NULL);
@@ -893,8 +873,7 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 		case JFFS2_NODETYPE_PADDING:
 			if (jffs2_sum_active())
 				jffs2_sum_add_padding_mem(s, je32_to_cpu(node->totlen));
-			if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(node->totlen)))))
-				return err;
+			jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(node->totlen)));
 			ofs += PAD(je32_to_cpu(node->totlen));
 			break;
 
@@ -906,8 +885,7 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 				c->flags |= JFFS2_SB_FLAG_RO;
 				if (!(jffs2_is_readonly(c)))
 					return -EROFS;
-				if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(node->totlen)))))
-					return err;
+				jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(node->totlen)));
 				ofs += PAD(je32_to_cpu(node->totlen));
 				break;
 
@@ -919,8 +897,7 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 			case JFFS2_FEATURE_RWCOMPAT_DELETE:
 				jffs2_dbg(1, "Unknown but compatible feature node (0x%04x) found at offset 0x%08x\n",
 					  je16_to_cpu(node->nodetype), ofs);
-				if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(node->totlen)))))
-					return err;
+				jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(node->totlen)));
 				ofs += PAD(je32_to_cpu(node->totlen));
 				break;
 
@@ -1014,8 +991,8 @@ static int jffs2_scan_inode_node(struct jffs2_sb_info *c, struct jffs2_erasebloc
 		 * We believe totlen because the CRC on the node
 		 * _header_ was OK, just the node itself failed.
 		 */
-		return jffs2_scan_dirty_space(c, jeb,
-					      PAD(je32_to_cpu(ri->totlen)));
+		jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(ri->totlen)));
+		return 0;
 	}
 
 	ic = jffs2_get_ino_cache(c, ino);
@@ -1049,7 +1026,6 @@ static int jffs2_scan_dirent_node(struct jffs2_sb_info *c, struct jffs2_eraseblo
 	struct jffs2_inode_cache *ic;
 	uint32_t checkedlen;
 	uint32_t crc;
-	int err;
 
 	jffs2_dbg(1, "%s(): Node at 0x%08x\n", __func__, ofs);
 
@@ -1061,8 +1037,7 @@ static int jffs2_scan_dirent_node(struct jffs2_sb_info *c, struct jffs2_eraseblo
 		pr_notice("%s(): Node CRC failed on node at 0x%08x: Read 0x%08x, calculated 0x%08x\n",
 			  __func__, ofs, je32_to_cpu(rd->node_crc), crc);
 		/* We believe totlen because the CRC on the node _header_ was OK, just the node itself failed. */
-		if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(rd->totlen)))))
-			return err;
+		jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(rd->totlen)));
 		return 0;
 	}
 
@@ -1090,8 +1065,7 @@ static int jffs2_scan_dirent_node(struct jffs2_sb_info *c, struct jffs2_eraseblo
 		jffs2_free_full_dirent(fd);
 		/* FIXME: Why do we believe totlen? */
 		/* We believe totlen because the CRC on the node _header_ was OK, just the name failed. */
-		if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(rd->totlen)))))
-			return err;
+		jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(rd->totlen)));
 		return 0;
 	}
 	ic = jffs2_scan_make_ino_cache(c, je32_to_cpu(rd->pino));
diff --git a/fs/jffs2/summary.c b/fs/jffs2/summary.c
index 4fe64519870f..d95fb03bebe5 100644
--- a/fs/jffs2/summary.c
+++ b/fs/jffs2/summary.c
@@ -624,13 +624,11 @@ int jffs2_sum_scan_sumnode(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb
 		if (je32_to_cpu(summary->cln_mkr) != c->cleanmarker_size) {
 			dbg_summary("CLEANMARKER node has totlen 0x%x != normal 0x%x\n",
 				je32_to_cpu(summary->cln_mkr), c->cleanmarker_size);
-			if ((ret = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(summary->cln_mkr)))))
-				return ret;
+			jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(summary->cln_mkr)));
 		} else if (jeb->first_node) {
 			dbg_summary("CLEANMARKER node not first node in block "
 					"(0x%08x)\n", jeb->offset);
-			if ((ret = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(summary->cln_mkr)))))
-				return ret;
+			jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(summary->cln_mkr)));
 		} else {
 			jffs2_link_node_ref(c, jeb, jeb->offset | REF_NORMAL,
 					    je32_to_cpu(summary->cln_mkr), NULL);
-- 
2.27.0

