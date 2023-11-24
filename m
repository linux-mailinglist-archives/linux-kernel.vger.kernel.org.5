Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420937F6BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbjKXGE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjKXGES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:04:18 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539EDD73;
        Thu, 23 Nov 2023 22:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YQd0sVENc8vNXo6fQBPFKWdKkcW/WYyDOS5A5P7KNmA=; b=pumoDACQA2Uo0ujIWHZBRBpsgm
        CZIGBoegoxuq/d30GAq6Pi5W9phVZkI7LreLbyXIKup34Nd8DtH9JcV8CyglqU0JPfXFNfEr8vYZD
        tOUh404G2VjiwZG4fn9moucUogjH5HFCkaGYOrzlSSBwY1Gt8Jc4Vy8larIdFXnzqT9uQ6wRNbwmU
        GvjuGMEnaozVB/LnO+/w5Pdx5x9QyD+G5vwl4EmeGHg5kWYkvEavOcPWbQ3RAjqWg3z8vpEgcrdxZ
        uK/ARVrauObzOsxj0o2xrC7b2PtjuPv7LhwAozlxKTcYoSU6UphF3qmv6pWeAJdEaH+oDAjx/1BZk
        KhJHS4GA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PIc-002Ptn-32;
        Fri, 24 Nov 2023 06:04:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/21] centralize killing dentry from shrink list
Date:   Fri, 24 Nov 2023 06:04:05 +0000
Message-Id: <20231124060422.576198-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060422.576198-1-viro@zeniv.linux.org.uk>
References: <20231124060200.GR38156@ZenIV>
 <20231124060422.576198-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

new helper unifying identical bits of shrink_dentry_list() and
shring_dcache_for_umount()

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 59f76c9a15d1..bb862a304e1b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1174,10 +1174,18 @@ static bool shrink_lock_dentry(struct dentry *dentry)
 	return false;
 }
 
+static inline void shrink_kill(struct dentry *victim, struct list_head *list)
+{
+	struct dentry *parent = victim->d_parent;
+	if (parent != victim)
+		__dput_to_list(parent, list);
+	__dentry_kill(victim);
+}
+
 void shrink_dentry_list(struct list_head *list)
 {
 	while (!list_empty(list)) {
-		struct dentry *dentry, *parent;
+		struct dentry *dentry;
 
 		dentry = list_entry(list->prev, struct dentry, d_lru);
 		spin_lock(&dentry->d_lock);
@@ -1195,10 +1203,7 @@ void shrink_dentry_list(struct list_head *list)
 		}
 		rcu_read_unlock();
 		d_shrink_del(dentry);
-		parent = dentry->d_parent;
-		if (parent != dentry)
-			__dput_to_list(parent, list);
-		__dentry_kill(dentry);
+		shrink_kill(dentry, list);
 	}
 }
 
@@ -1629,17 +1634,13 @@ void shrink_dcache_parent(struct dentry *parent)
 		data.victim = NULL;
 		d_walk(parent, &data, select_collect2);
 		if (data.victim) {
-			struct dentry *parent;
 			spin_lock(&data.victim->d_lock);
 			if (!shrink_lock_dentry(data.victim)) {
 				spin_unlock(&data.victim->d_lock);
 				rcu_read_unlock();
 			} else {
 				rcu_read_unlock();
-				parent = data.victim->d_parent;
-				if (parent != data.victim)
-					__dput_to_list(parent, &data.dispose);
-				__dentry_kill(data.victim);
+				shrink_kill(data.victim, &data.dispose);
 			}
 		}
 		if (!list_empty(&data.dispose))
-- 
2.39.2

