Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2C57BCACF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 02:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbjJHAtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 20:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjJHAtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 20:49:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDA8137;
        Sat,  7 Oct 2023 17:49:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED300C433CC;
        Sun,  8 Oct 2023 00:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726158;
        bh=NCKzeikpXlCwrEjGU+bArViVhPuqsORKdK3xuq6sQwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hzv5J2jDeDG4nXh4BnJAYqh47E+ONqPpi8aLeF9l3wGHu44H9E0u+dbuRyswCeoSu
         gSFSoXr2ElfXSqCtXpnd5eRlm8ZYuO/vnYjxEln0ZhT612szzgOyh9/QeQWkoAKC8z
         TW1xNlRIXZV8PO1UspQnAWJEAtCs7tCDGjFLwplyIgTZL8vOPsYEtvG2VmWVJKZs6b
         kCAoeLoGdMSWXZEQAp9iceIcqOMwGFG6C7G4Mf6snfo9l2WJRghUHYcvmjrjz0cNzQ
         QZW5foJ52/TLZTuUmZGq2JAhBOqa6ZsdQgHjia7rihUqsz4hW4C09o2nOWidsup4Oa
         Go6cc09eTx6qw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Sasha Levin <sashal@kernel.org>, axboe@kernel.dk,
        ceph-devel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 13/18] rbd: decouple parent info read-in from updating rbd_dev
Date:   Sat,  7 Oct 2023 20:48:47 -0400
Message-Id: <20231008004853.3767621-13-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008004853.3767621-1-sashal@kernel.org>
References: <20231008004853.3767621-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Dryomov <idryomov@gmail.com>

[ Upstream commit c10311776f0a8ddea2276df96e255625b07045a8 ]

Unlike header read-in, parent info read-in is already decoupled in
get_parent_info(), but it's buried in rbd_dev_v2_parent_info() along
with the processing logic.

Separate the initial read-in and update read-in logic into
rbd_dev_setup_parent() and rbd_dev_update_parent() respectively and
have rbd_dev_v2_parent_info() just populate struct parent_image_info
(i.e. what get_parent_info() did).  Some existing QoI issues, like
flatten of a standalone clone being disregarded on refresh, remain.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/rbd.c | 142 +++++++++++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 62 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 90a78176dbc89..4e381ba158dce 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5594,6 +5594,14 @@ struct parent_image_info {
 	u64		overlap;
 };
 
+static void rbd_parent_info_cleanup(struct parent_image_info *pii)
+{
+	kfree(pii->pool_ns);
+	kfree(pii->image_id);
+
+	memset(pii, 0, sizeof(*pii));
+}
+
 /*
  * The caller is responsible for @pii.
  */
@@ -5663,6 +5671,9 @@ static int __get_parent_info(struct rbd_device *rbd_dev,
 	if (pii->has_overlap)
 		ceph_decode_64_safe(&p, end, pii->overlap, e_inval);
 
+	dout("%s pool_id %llu pool_ns %s image_id %s snap_id %llu has_overlap %d overlap %llu\n",
+	     __func__, pii->pool_id, pii->pool_ns, pii->image_id, pii->snap_id,
+	     pii->has_overlap, pii->overlap);
 	return 0;
 
 e_inval:
@@ -5701,14 +5712,17 @@ static int __get_parent_info_legacy(struct rbd_device *rbd_dev,
 	pii->has_overlap = true;
 	ceph_decode_64_safe(&p, end, pii->overlap, e_inval);
 
+	dout("%s pool_id %llu pool_ns %s image_id %s snap_id %llu has_overlap %d overlap %llu\n",
+	     __func__, pii->pool_id, pii->pool_ns, pii->image_id, pii->snap_id,
+	     pii->has_overlap, pii->overlap);
 	return 0;
 
 e_inval:
 	return -EINVAL;
 }
 
-static int get_parent_info(struct rbd_device *rbd_dev,
-			   struct parent_image_info *pii)
+static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev,
+				  struct parent_image_info *pii)
 {
 	struct page *req_page, *reply_page;
 	void *p;
@@ -5736,7 +5750,7 @@ static int get_parent_info(struct rbd_device *rbd_dev,
 	return ret;
 }
 
-static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
+static int rbd_dev_setup_parent(struct rbd_device *rbd_dev)
 {
 	struct rbd_spec *parent_spec;
 	struct parent_image_info pii = { 0 };
@@ -5746,37 +5760,12 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 	if (!parent_spec)
 		return -ENOMEM;
 
-	ret = get_parent_info(rbd_dev, &pii);
+	ret = rbd_dev_v2_parent_info(rbd_dev, &pii);
 	if (ret)
 		goto out_err;
 
-	dout("%s pool_id %llu pool_ns %s image_id %s snap_id %llu has_overlap %d overlap %llu\n",
-	     __func__, pii.pool_id, pii.pool_ns, pii.image_id, pii.snap_id,
-	     pii.has_overlap, pii.overlap);
-
-	if (pii.pool_id == CEPH_NOPOOL || !pii.has_overlap) {
-		/*
-		 * Either the parent never existed, or we have
-		 * record of it but the image got flattened so it no
-		 * longer has a parent.  When the parent of a
-		 * layered image disappears we immediately set the
-		 * overlap to 0.  The effect of this is that all new
-		 * requests will be treated as if the image had no
-		 * parent.
-		 *
-		 * If !pii.has_overlap, the parent image spec is not
-		 * applicable.  It's there to avoid duplication in each
-		 * snapshot record.
-		 */
-		if (rbd_dev->parent_overlap) {
-			rbd_dev->parent_overlap = 0;
-			rbd_dev_parent_put(rbd_dev);
-			pr_info("%s: clone image has been flattened\n",
-				rbd_dev->disk->disk_name);
-		}
-
+	if (pii.pool_id == CEPH_NOPOOL || !pii.has_overlap)
 		goto out;	/* No parent?  No problem. */
-	}
 
 	/* The ceph file layout needs to fit pool id in 32 bits */
 
@@ -5788,46 +5777,34 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 	}
 
 	/*
-	 * The parent won't change (except when the clone is
-	 * flattened, already handled that).  So we only need to
-	 * record the parent spec we have not already done so.
+	 * The parent won't change except when the clone is flattened,
+	 * so we only need to record the parent image spec once.
 	 */
-	if (!rbd_dev->parent_spec) {
-		parent_spec->pool_id = pii.pool_id;
-		if (pii.pool_ns && *pii.pool_ns) {
-			parent_spec->pool_ns = pii.pool_ns;
-			pii.pool_ns = NULL;
-		}
-		parent_spec->image_id = pii.image_id;
-		pii.image_id = NULL;
-		parent_spec->snap_id = pii.snap_id;
-
-		rbd_dev->parent_spec = parent_spec;
-		parent_spec = NULL;	/* rbd_dev now owns this */
+	parent_spec->pool_id = pii.pool_id;
+	if (pii.pool_ns && *pii.pool_ns) {
+		parent_spec->pool_ns = pii.pool_ns;
+		pii.pool_ns = NULL;
 	}
+	parent_spec->image_id = pii.image_id;
+	pii.image_id = NULL;
+	parent_spec->snap_id = pii.snap_id;
+
+	rbd_assert(!rbd_dev->parent_spec);
+	rbd_dev->parent_spec = parent_spec;
+	parent_spec = NULL;	/* rbd_dev now owns this */
 
 	/*
-	 * We always update the parent overlap.  If it's zero we issue
-	 * a warning, as we will proceed as if there was no parent.
+	 * Record the parent overlap.  If it's zero, issue a warning as
+	 * we will proceed as if there is no parent.
 	 */
-	if (!pii.overlap) {
-		if (parent_spec) {
-			/* refresh, careful to warn just once */
-			if (rbd_dev->parent_overlap)
-				rbd_warn(rbd_dev,
-				    "clone now standalone (overlap became 0)");
-		} else {
-			/* initial probe */
-			rbd_warn(rbd_dev, "clone is standalone (overlap 0)");
-		}
-	}
+	if (!pii.overlap)
+		rbd_warn(rbd_dev, "clone is standalone (overlap 0)");
 	rbd_dev->parent_overlap = pii.overlap;
 
 out:
 	ret = 0;
 out_err:
-	kfree(pii.pool_ns);
-	kfree(pii.image_id);
+	rbd_parent_info_cleanup(&pii);
 	rbd_spec_put(parent_spec);
 	return ret;
 }
@@ -6977,7 +6954,7 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
 	}
 
 	if (rbd_dev->header.features & RBD_FEATURE_LAYERING) {
-		ret = rbd_dev_v2_parent_info(rbd_dev);
+		ret = rbd_dev_setup_parent(rbd_dev);
 		if (ret)
 			goto err_out_probe;
 	}
@@ -7026,9 +7003,47 @@ static void rbd_dev_update_header(struct rbd_device *rbd_dev,
 	}
 }
 
+static void rbd_dev_update_parent(struct rbd_device *rbd_dev,
+				  struct parent_image_info *pii)
+{
+	if (pii->pool_id == CEPH_NOPOOL || !pii->has_overlap) {
+		/*
+		 * Either the parent never existed, or we have
+		 * record of it but the image got flattened so it no
+		 * longer has a parent.  When the parent of a
+		 * layered image disappears we immediately set the
+		 * overlap to 0.  The effect of this is that all new
+		 * requests will be treated as if the image had no
+		 * parent.
+		 *
+		 * If !pii.has_overlap, the parent image spec is not
+		 * applicable.  It's there to avoid duplication in each
+		 * snapshot record.
+		 */
+		if (rbd_dev->parent_overlap) {
+			rbd_dev->parent_overlap = 0;
+			rbd_dev_parent_put(rbd_dev);
+			pr_info("%s: clone has been flattened\n",
+				rbd_dev->disk->disk_name);
+		}
+	} else {
+		rbd_assert(rbd_dev->parent_spec);
+
+		/*
+		 * Update the parent overlap.  If it became zero, issue
+		 * a warning as we will proceed as if there is no parent.
+		 */
+		if (!pii->overlap && rbd_dev->parent_overlap)
+			rbd_warn(rbd_dev,
+				 "clone has become standalone (overlap 0)");
+		rbd_dev->parent_overlap = pii->overlap;
+	}
+}
+
 static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 {
 	struct rbd_image_header	header = { 0 };
+	struct parent_image_info pii = { 0 };
 	u64 mapping_size;
 	int ret;
 
@@ -7044,12 +7059,14 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 	 * mapped image getting flattened.
 	 */
 	if (rbd_dev->parent) {
-		ret = rbd_dev_v2_parent_info(rbd_dev);
+		ret = rbd_dev_v2_parent_info(rbd_dev, &pii);
 		if (ret)
 			goto out;
 	}
 
 	rbd_dev_update_header(rbd_dev, &header);
+	if (rbd_dev->parent)
+		rbd_dev_update_parent(rbd_dev, &pii);
 
 	rbd_assert(!rbd_is_snap(rbd_dev));
 	rbd_dev->mapping.size = rbd_dev->header.image_size;
@@ -7059,6 +7076,7 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 	if (!ret && mapping_size != rbd_dev->mapping.size)
 		rbd_dev_update_size(rbd_dev);
 
+	rbd_parent_info_cleanup(&pii);
 	rbd_image_header_cleanup(&header);
 	return ret;
 }
-- 
2.40.1

