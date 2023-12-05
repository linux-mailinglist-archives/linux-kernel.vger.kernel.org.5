Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFC980499E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 06:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344273AbjLEF7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 00:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjLEF73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 00:59:29 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E57AA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 21:59:35 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c1a75a4b6cso1762402a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 21:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701755975; x=1702360775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSezztPpzbnoN5Gm9WnigSfdiZPls8znLUzzdIBA48c=;
        b=Wl2jk2W6B7HPT6M6mVcvffSkk0T4RcgcDfxY3YbOHs1nrAhEsNnO2GyTyd114+MPPJ
         vq+dXaAescZgq+ikkfC+dBuhduJNcYVcKb/tF4X6vJKQm4n47i+ZyG3vN1TSC4iFiaZn
         gjKHhow90OLn2SiFPUA9PYCmqCEXWG3mqKQsBX7D9Yz+FZsWZTkY3TDFErDDbP54eT4L
         OdydVgdP+Yo2wgyp3i/J+lwEEUuLkYz4YAacMgenQnUOomddyfLFNtChqov2jRG5c9bX
         IJZRbpydGHklaNCObbCwhptnryowAbnzi7zutGpifksjd/y0f2JzErPHbxhheQhYzE3r
         LKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701755975; x=1702360775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSezztPpzbnoN5Gm9WnigSfdiZPls8znLUzzdIBA48c=;
        b=svjKiulTsQMu+QuIOuQ+eryvJqLHVPC2hf6b6618q/3sW6fXifR3wfoOANDWjTjKVg
         h5yRGt4OGk+/6Zq2ZiBkOE/bACsErq+qVqXFfJ2Yw4DYP9Obpo2smKhyz8deq8nP2ss+
         d950fHU68fiLCDlV5k9xjP5VuuwJnpnJXEHA2jYnYt1RlrB1Jkc+Luj6uLvIdBw6kjp4
         jeUG7R9cVWzuq+VMaF4rNsEzCFo6+1KDTYbmbg5jJUnzMYx7dqlo1YSXzqSzBA+LRhd2
         ct34kBXkbx9FauPq9FXg3grZCmXlZFbVBtESyElKtOKxnNpx/50jAr/iHPr0pNDJz5BH
         OAiw==
X-Gm-Message-State: AOJu0YyKC6HIGyt7iSHSzJQgJHLiu3MpOJkAqItaQuA5KTWbh7MMH07l
        XKKt1XtDnCADNM8pzFeF8KQsL19Z3mjZn6+AD0jgc7D+
X-Google-Smtp-Source: AGHT+IEiW1htDnrqBUR2CJ+H2GvnE37UjdNxvSFQjEJkVfXtex4MbpDKgKKk/LPhOcqJuCZ68bU30g==
X-Received: by 2002:a17:902:8b85:b0:1d0:6ffd:ae0e with SMTP id ay5-20020a1709028b8500b001d06ffdae0emr2561663plb.117.1701755975368;
        Mon, 04 Dec 2023 21:59:35 -0800 (PST)
Received: from localhost.localdomain ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id jb7-20020a170903258700b001d05bb77b43sm7111605plb.19.2023.12.04.21.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 21:59:35 -0800 (PST)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com, me@jcix.top,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 3/3] xfs: extract xfs_da_buf_copy() helper function
Date:   Tue,  5 Dec 2023 13:59:00 +0800
Message-Id: <20231205055900.62855-4-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231205055900.62855-1-zhangjiachen.jaycee@bytedance.com>
References: <20231205055900.62855-1-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Tianci <zhangtianci.1997@bytedance.com>

This patch does not modify logic.

xfs_da_buf_copy() will copy one block from src xfs_buf to
dst xfs_buf, and update the block metadata in dst directly.

Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_attr_leaf.c | 12 ++----
 fs/xfs/libxfs/xfs_da_btree.c  | 74 ++++++++++++++---------------------
 fs/xfs/libxfs/xfs_da_btree.h  |  2 +
 3 files changed, 36 insertions(+), 52 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index 2580ae47209a..654e17e6610d 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -1244,14 +1244,10 @@ xfs_attr3_leaf_to_node(
 	if (error)
 		goto out;
 
-	/* copy leaf to new buffer, update identifiers */
-	xfs_trans_buf_set_type(args->trans, bp2, XFS_BLFT_ATTR_LEAF_BUF);
-	bp2->b_ops = bp1->b_ops;
-	memcpy(bp2->b_addr, bp1->b_addr, args->geo->blksize);
-	if (xfs_has_crc(mp)) {
-		struct xfs_da3_blkinfo *hdr3 = bp2->b_addr;
-		hdr3->blkno = cpu_to_be64(xfs_buf_daddr(bp2));
-	}
+	/*
+	 * Copy leaf to new buffer and log it.
+	 */
+	xfs_da_buf_copy(bp2, bp1, args->geo->blksize);
 	xfs_trans_log_buf(args->trans, bp2, 0, args->geo->blksize - 1);
 
 	/*
diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index 282c7cf032f4..5457188bb4de 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -421,6 +421,25 @@ xfs_da3_node_read_mapped(
 	return xfs_da3_node_set_type(tp, *bpp);
 }
 
+/*
+ * Copy src directory/attr leaf/node buffer to the dst.
+ * For v5 file systems make sure the right blkno is stamped in.
+ */
+void
+xfs_da_buf_copy(
+	struct xfs_buf *dst,
+	struct xfs_buf *src,
+	size_t size)
+{
+	struct xfs_da3_blkinfo *da3 = dst->b_addr;
+
+	memcpy(dst->b_addr, src->b_addr, size);
+	dst->b_ops = src->b_ops;
+	xfs_trans_buf_copy_type(dst, src);
+	if (xfs_has_crc(dst->b_mount))
+		da3->blkno = cpu_to_be64(xfs_buf_daddr(dst));
+}
+
 /*========================================================================
  * Routines used for growing the Btree.
  *========================================================================*/
@@ -690,12 +709,6 @@ xfs_da3_root_split(
 		btree = icnodehdr.btree;
 		size = (int)((char *)&btree[icnodehdr.count] - (char *)oldroot);
 		level = icnodehdr.level;
-
-		/*
-		 * we are about to copy oldroot to bp, so set up the type
-		 * of bp while we know exactly what it will be.
-		 */
-		xfs_trans_buf_set_type(tp, bp, XFS_BLFT_DA_NODE_BUF);
 	} else {
 		struct xfs_dir3_icleaf_hdr leafhdr;
 
@@ -707,31 +720,17 @@ xfs_da3_root_split(
 		size = (int)((char *)&leafhdr.ents[leafhdr.count] -
 			(char *)leaf);
 		level = 0;
-
-		/*
-		 * we are about to copy oldroot to bp, so set up the type
-		 * of bp while we know exactly what it will be.
-		 */
-		xfs_trans_buf_set_type(tp, bp, XFS_BLFT_DIR_LEAFN_BUF);
 	}
 
 	/*
-	 * we can copy most of the information in the node from one block to
-	 * another, but for CRC enabled headers we have to make sure that the
-	 * block specific identifiers are kept intact. We update the buffer
-	 * directly for this.
+	 * Copy old root to new buffer and log it.
 	 */
-	memcpy(node, oldroot, size);
-	if (oldroot->hdr.info.magic == cpu_to_be16(XFS_DA3_NODE_MAGIC) ||
-	    oldroot->hdr.info.magic == cpu_to_be16(XFS_DIR3_LEAFN_MAGIC)) {
-		struct xfs_da3_intnode *node3 = (struct xfs_da3_intnode *)node;
-
-		node3->hdr.info.blkno = cpu_to_be64(xfs_buf_daddr(bp));
-	}
+	xfs_da_buf_copy(bp, blk1->bp, size);
 	xfs_trans_log_buf(tp, bp, 0, size - 1);
 
-	bp->b_ops = blk1->bp->b_ops;
-	xfs_trans_buf_copy_type(bp, blk1->bp);
+	/*
+	 * Update blk1 to point to new buffer.
+	 */
 	blk1->bp = bp;
 	blk1->blkno = blkno;
 
@@ -1220,21 +1219,14 @@ xfs_da3_root_join(
 	xfs_da_blkinfo_onlychild_validate(bp->b_addr, oldroothdr.level);
 
 	/*
-	 * This could be copying a leaf back into the root block in the case of
-	 * there only being a single leaf block left in the tree. Hence we have
-	 * to update the b_ops pointer as well to match the buffer type change
-	 * that could occur. For dir3 blocks we also need to update the block
-	 * number in the buffer header.
+	 * Copy child to root buffer and log it.
 	 */
-	memcpy(root_blk->bp->b_addr, bp->b_addr, args->geo->blksize);
-	root_blk->bp->b_ops = bp->b_ops;
-	xfs_trans_buf_copy_type(root_blk->bp, bp);
-	if (oldroothdr.magic == XFS_DA3_NODE_MAGIC) {
-		struct xfs_da3_blkinfo *da3 = root_blk->bp->b_addr;
-		da3->blkno = cpu_to_be64(xfs_buf_daddr(root_blk->bp));
-	}
+	xfs_da_buf_copy(root_blk->bp, bp, args->geo->blksize);
 	xfs_trans_log_buf(args->trans, root_blk->bp, 0,
 			  args->geo->blksize - 1);
+	/*
+	 * Now we can drop the child buffer.
+	 */
 	error = xfs_da_shrink_inode(args, child, bp);
 	return error;
 }
@@ -2316,14 +2308,8 @@ xfs_da3_swap_lastblock(
 		return error;
 	/*
 	 * Copy the last block into the dead buffer and log it.
-	 * On CRC-enabled file systems, also update the stamped in blkno.
 	 */
-	memcpy(dead_buf->b_addr, last_buf->b_addr, args->geo->blksize);
-	if (xfs_has_crc(mp)) {
-		struct xfs_da3_blkinfo *da3 = dead_buf->b_addr;
-
-		da3->blkno = cpu_to_be64(xfs_buf_daddr(dead_buf));
-	}
+	xfs_da_buf_copy(dead_buf, last_buf, args->geo->blksize);
 	xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);
 	dead_info = dead_buf->b_addr;
 
diff --git a/fs/xfs/libxfs/xfs_da_btree.h b/fs/xfs/libxfs/xfs_da_btree.h
index ffa3df5b2893..706baf36e175 100644
--- a/fs/xfs/libxfs/xfs_da_btree.h
+++ b/fs/xfs/libxfs/xfs_da_btree.h
@@ -219,6 +219,8 @@ int	xfs_da_reada_buf(struct xfs_inode *dp, xfs_dablk_t bno,
 		const struct xfs_buf_ops *ops);
 int	xfs_da_shrink_inode(xfs_da_args_t *args, xfs_dablk_t dead_blkno,
 					  struct xfs_buf *dead_buf);
+void	xfs_da_buf_copy(struct xfs_buf *dst, struct xfs_buf *src,
+			size_t size);
 
 uint xfs_da_hashname(const uint8_t *name_string, int name_length);
 enum xfs_dacmp xfs_da_compname(struct xfs_da_args *args,
-- 
2.20.1

