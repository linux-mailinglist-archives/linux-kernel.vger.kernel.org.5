Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D127F6C09
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344753AbjKXGFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjKXGEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:04:21 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B3310D9;
        Thu, 23 Nov 2023 22:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vT3nlpEZeGzr7/rKI49SrykB8InZNoD2Xu4i2yt9WsU=; b=uDg1IyQegNlFWVu0oGh2fv3IeR
        Q+1AfhR6srH1dTYlCIIxMnjuw6eWw72YGI476+CHpv8+IpIiYHT3R5tHoZ4QoDWYmSyjkggahMyjU
        r9NMDx/kT/wnQzMl2jYXAeXA74uRZpOVl60g7yFhRx9iqOC42vLo4oH2/0Zg9d6B4hHYwjlzrUTPi
        3w/S4z0lajGYCF9nJbSTOC7OPs2uLgAsphCl34xn5Ieq6AC0PZa7ZtsJl/0hQdTSHwI+FN4zmKP3u
        ULQESX2UWp4xdLKfHSoWHxpTRYlrOWDKgiXDt/qf1qzz3DQXFAEW9yPDEiiLy4LzLOlv/dtQESue7
        PBBZJAFw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PIf-002Puo-2a;
        Fri, 24 Nov 2023 06:04:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/21] fold the call of retain_dentry() into fast_dput()
Date:   Fri, 24 Nov 2023 06:04:15 +0000
Message-Id: <20231124060422.576198-14-viro@zeniv.linux.org.uk>
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

Calls of retain_dentry() happen immediately after getting false
from fast_dput() and getting true from retain_dentry() is
treated the same way as non-zero refcount would be treated by
fast_dput() - unlock dentry and bugger off.

Doing that in fast_dput() itself is simpler.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 8ce0fe70f303..b69ff3a0b30f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -757,6 +757,8 @@ static struct dentry *dentry_kill(struct dentry *dentry)
  * Try to do a lockless dput(), and return whether that was successful.
  *
  * If unsuccessful, we return false, having already taken the dentry lock.
+ * In that case refcount is guaranteed to be zero and we have already
+ * decided that it's not worth keeping around.
  *
  * The caller needs to hold the RCU read lock, so that the dentry is
  * guaranteed to stay around even if the refcount goes down to zero!
@@ -842,7 +844,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * don't need to do anything else.
 	 */
 locked:
-	if (dentry->d_lockref.count) {
+	if (dentry->d_lockref.count || retain_dentry(dentry)) {
 		spin_unlock(&dentry->d_lock);
 		return true;
 	}
@@ -889,12 +891,6 @@ void dput(struct dentry *dentry)
 
 		/* Slow case: now with the dentry lock held */
 		rcu_read_unlock();
-
-		if (likely(retain_dentry(dentry))) {
-			spin_unlock(&dentry->d_lock);
-			return;
-		}
-
 		dentry->d_lockref.count = 1;
 		dentry = dentry_kill(dentry);
 	}
@@ -920,8 +916,7 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
 		return;
 	}
 	rcu_read_unlock();
-	if (!retain_dentry(dentry))
-		to_shrink_list(dentry, list);
+	to_shrink_list(dentry, list);
 	spin_unlock(&dentry->d_lock);
 }
 
-- 
2.39.2

