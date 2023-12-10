Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF7780B87B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 04:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjLJCue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 21:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJCuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 21:50:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AAA11C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 18:50:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAA6C433C7;
        Sun, 10 Dec 2023 02:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702176638;
        bh=Fy8/AA1OD+Qy+g3LE8R4kVkWVk6a6OxVXAjg9c/oDIY=;
        h=From:To:Cc:Subject:Date:From;
        b=pvK/Nj6puZuR4qQ1zHHitiOZsigt1+4HGBsGrDBtfYr7I50hE0hsH4ukQRJkB5KXR
         KrKWRD85V7B6RFQ/Cwrenir26zuliG7KuCZQ7iZ4lI7fSlfVnGU+4ukwXHwIU8jQCN
         oAUX9lcCad82VeK3SOWuSjiUK2CSMnP/8uyHSkEJRSm4NlC3hFBp3ouBPAbw/M9NSF
         dB7TcGXF6SWOwINTJN5vCkWmuYyT40AlXoIfIMZI2hASjWU5ujvOmfYYlvNZ0vNqV1
         PtEquO9imX3chXv/W+8R34SmTbR/jvME5P6+ORCJQzNqk/6vFBDcUV8R2eDUKeo+C6
         mygp0yaGKV5aQ==
From:   Chao Yu <chao@kernel.org>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        chao@kernel.org
Subject: [PATCH] quota: convert dquot_claim_space_nodirty() to return void
Date:   Sun, 10 Dec 2023 10:50:28 +0800
Message-Id: <20231210025028.3262900-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dquot_claim_space_nodirty() always return zero, let's convert it
to return void, then, its caller can get rid of handling failure
case.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/quota/dquot.c         |  6 +++---
 include/linux/quotaops.h | 15 +++++----------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 58b5de081b57..44ff2813ae51 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1787,7 +1787,7 @@ EXPORT_SYMBOL(dquot_alloc_inode);
 /*
  * Convert in-memory reserved quotas to real consumed quotas
  */
-int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
+void dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 {
 	struct dquot **dquots;
 	int cnt, index;
@@ -1797,7 +1797,7 @@ int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 		*inode_reserved_space(inode) -= number;
 		__inode_add_bytes(inode, number);
 		spin_unlock(&inode->i_lock);
-		return 0;
+		return;
 	}
 
 	dquots = i_dquot(inode);
@@ -1822,7 +1822,7 @@ int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 	spin_unlock(&inode->i_lock);
 	mark_all_dquot_dirty(dquots);
 	srcu_read_unlock(&dquot_srcu, index);
-	return 0;
+	return;
 }
 EXPORT_SYMBOL(dquot_claim_space_nodirty);
 
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 4fa4ef0a173a..06cc8888199e 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -74,7 +74,7 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags);
 
 int dquot_alloc_inode(struct inode *inode);
 
-int dquot_claim_space_nodirty(struct inode *inode, qsize_t number);
+void dquot_claim_space_nodirty(struct inode *inode, qsize_t number);
 void dquot_free_inode(struct inode *inode);
 void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number);
 
@@ -257,10 +257,9 @@ static inline void __dquot_free_space(struct inode *inode, qsize_t number,
 		inode_sub_bytes(inode, number);
 }
 
-static inline int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
+static inline void dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 {
 	inode_add_bytes(inode, number);
-	return 0;
 }
 
 static inline int dquot_reclaim_space_nodirty(struct inode *inode,
@@ -358,14 +357,10 @@ static inline int dquot_reserve_block(struct inode *inode, qsize_t nr)
 				DQUOT_SPACE_WARN|DQUOT_SPACE_RESERVE);
 }
 
-static inline int dquot_claim_block(struct inode *inode, qsize_t nr)
+static inline void dquot_claim_block(struct inode *inode, qsize_t nr)
 {
-	int ret;
-
-	ret = dquot_claim_space_nodirty(inode, nr << inode->i_blkbits);
-	if (!ret)
-		mark_inode_dirty_sync(inode);
-	return ret;
+	dquot_claim_space_nodirty(inode, nr << inode->i_blkbits);
+	mark_inode_dirty_sync(inode);
 }
 
 static inline void dquot_reclaim_block(struct inode *inode, qsize_t nr)
-- 
2.40.1

