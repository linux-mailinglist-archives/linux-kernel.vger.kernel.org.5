Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A6B7F6C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344831AbjKXGFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjKXGEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:04:21 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5516D10DB;
        Thu, 23 Nov 2023 22:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mXHiL5jT4HWug97N8fmljXi5pqA1wUSIaz0ILd8i6xg=; b=SrxCswC5KP3HPm1kphjwbrGVFr
        cQ2gMIqsnVQZ2MQE9e6+0VxWPCypk9TZsJ9RF2s+197pABR7T0IL7pezuG1++5WYdUXbLv/0sHKZd
        INlY9h/gDrFrJQ+V+rJy6b9xlJyy9mQO/WGdDBjeJzhD674ynD4W4maMX0/es9jgv6fuypynlvidf
        fmrxsUhqGjZxrxQgN4SCCC55aHaS5HhBMLNmfBxr15iJDBv8Nc847B3ipNSqGVpk8Qf6y+qav+G0c
        r7Bh8hF4fG2lqTw4txzX4qeD5HOvkZ1SCYFLMmCfLFyM+Ul56m+4/5aGDsutgF4lhpahdChK/D8KX
        KY5x8QuA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PIf-002Pus-2z;
        Fri, 24 Nov 2023 06:04:26 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/21] don't try to cut corners in shrink_lock_dentry()
Date:   Fri, 24 Nov 2023 06:04:16 +0000
Message-Id: <20231124060422.576198-15-viro@zeniv.linux.org.uk>
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

That is to say, do *not* treat the ->d_inode or ->d_parent changes
as "it's hard, return false; somebody must have grabbed it, so
even if has zero refcount, we don't need to bother killing it -
final dput() from whoever grabbed it would've done everything".

First of all, that is not guaranteed.  It might have been dropped
by shrink_kill() handling of victim's parent, which would've found
it already on a shrink list (ours) and decided that they don't need
to put it on their shrink list.

What's more, dentry_kill() is doing pretty much the same thing,
cutting its own set of corners (it assumes that dentry can't
go from positive to negative, so its inode can change but only once
and only in one direction).

Doing that right allows to get rid of that not-quite-duplication
and removes the only reason for re-incrementing refcount before
the call of dentry_kill().

Replacement is called lock_for_kill(); called under rcu_read_lock
and with ->d_lock held.  If it returns false, dentry has non-zero
refcount and the same locks are held.  If it returns true,
dentry has zero refcount and all locks required by __dentry_kill()
are taken.

Part of __lock_parent() had been lifted into lock_parent() to
allow its reuse.  Now it's called with rcu_read_lock already
held and dentry already unlocked.

Note that this is not the final change - locking requirements for
__dentry_kill() are going to change later in the series and the
set of locks taken by lock_for_kill() will be adjusted.  Both
lock_parent() and __lock_parent() will be gone once that happens.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 159 ++++++++++++++++++++++------------------------------
 1 file changed, 66 insertions(+), 93 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index b69ff3a0b30f..a7f99d46c41b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -625,8 +625,6 @@ static void __dentry_kill(struct dentry *dentry)
 static struct dentry *__lock_parent(struct dentry *dentry)
 {
 	struct dentry *parent;
-	rcu_read_lock();
-	spin_unlock(&dentry->d_lock);
 again:
 	parent = READ_ONCE(dentry->d_parent);
 	spin_lock(&parent->d_lock);
@@ -642,7 +640,6 @@ static struct dentry *__lock_parent(struct dentry *dentry)
 		spin_unlock(&parent->d_lock);
 		goto again;
 	}
-	rcu_read_unlock();
 	if (parent != dentry)
 		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
 	else
@@ -657,7 +654,64 @@ static inline struct dentry *lock_parent(struct dentry *dentry)
 		return NULL;
 	if (likely(spin_trylock(&parent->d_lock)))
 		return parent;
-	return __lock_parent(dentry);
+	rcu_read_lock();
+	spin_unlock(&dentry->d_lock);
+	parent = __lock_parent(dentry);
+	rcu_read_unlock();
+	return parent;
+}
+
+/*
+ * Lock a dentry for feeding it to __dentry_kill().
+ * Called under rcu_read_lock() and dentry->d_lock; the former
+ * guarantees that nothing we access will be freed under us.
+ * Note that dentry is *not* protected from concurrent dentry_kill(),
+ * d_delete(), etc.
+ *
+ * Return false if dentry is busy.  Otherwise, return true and have
+ * that dentry's inode and parent both locked.
+ */
+
+static bool lock_for_kill(struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	struct dentry *parent = dentry->d_parent;
+
+	if (unlikely(dentry->d_lockref.count))
+		return false;
+
+	if (inode && unlikely(!spin_trylock(&inode->i_lock)))
+		goto slow;
+	if (dentry == parent)
+		return true;
+	if (likely(spin_trylock(&parent->d_lock)))
+		return true;
+
+	if (inode)
+		spin_unlock(&inode->i_lock);
+slow:
+	spin_unlock(&dentry->d_lock);
+
+	for (;;) {
+		if (inode)
+			spin_lock(&inode->i_lock);
+		parent = __lock_parent(dentry);
+		if (likely(inode == dentry->d_inode))
+			break;
+		if (inode)
+			spin_unlock(&inode->i_lock);
+		inode = dentry->d_inode;
+		spin_unlock(&dentry->d_lock);
+		if (parent)
+			spin_unlock(&parent->d_lock);
+	}
+	if (likely(!dentry->d_lockref.count))
+		return true;
+	if (inode)
+		spin_unlock(&inode->i_lock);
+	if (parent)
+		spin_unlock(&parent->d_lock);
+	return false;
 }
 
 static inline bool retain_dentry(struct dentry *dentry)
@@ -710,45 +764,16 @@ EXPORT_SYMBOL(d_mark_dontcache);
 static struct dentry *dentry_kill(struct dentry *dentry)
 	__releases(dentry->d_lock)
 {
-	struct inode *inode = dentry->d_inode;
-	struct dentry *parent = NULL;
 
-	if (inode && unlikely(!spin_trylock(&inode->i_lock)))
-		goto slow_positive;
-
-	if (!IS_ROOT(dentry)) {
-		parent = dentry->d_parent;
-		if (unlikely(!spin_trylock(&parent->d_lock))) {
-			parent = __lock_parent(dentry);
-			if (likely(inode || !dentry->d_inode))
-				goto got_locks;
-			/* negative that became positive */
-			if (parent)
-				spin_unlock(&parent->d_lock);
-			inode = dentry->d_inode;
-			goto slow_positive;
-		}
-	}
 	dentry->d_lockref.count--;
-	__dentry_kill(dentry);
-	return parent;
-
-slow_positive:
-	spin_unlock(&dentry->d_lock);
-	spin_lock(&inode->i_lock);
-	spin_lock(&dentry->d_lock);
-	parent = lock_parent(dentry);
-got_locks:
-	dentry->d_lockref.count--;
-	if (likely(dentry->d_lockref.count == 0)) {
+	rcu_read_lock();
+	if (likely(lock_for_kill(dentry))) {
+		struct dentry *parent = dentry->d_parent;
+		rcu_read_unlock();
 		__dentry_kill(dentry);
-		return parent;
+		return parent != dentry ? parent : NULL;
 	}
-	/* we are keeping it, after all */
-	if (inode)
-		spin_unlock(&inode->i_lock);
-	if (parent)
-		spin_unlock(&parent->d_lock);
+	rcu_read_unlock();
 	spin_unlock(&dentry->d_lock);
 	return NULL;
 }
@@ -1100,58 +1125,6 @@ void d_prune_aliases(struct inode *inode)
 }
 EXPORT_SYMBOL(d_prune_aliases);
 
-/*
- * Lock a dentry from shrink list.
- * Called under rcu_read_lock() and dentry->d_lock; the former
- * guarantees that nothing we access will be freed under us.
- * Note that dentry is *not* protected from concurrent dentry_kill(),
- * d_delete(), etc.
- *
- * Return false if dentry has been disrupted or grabbed, leaving
- * the caller to kick it off-list.  Otherwise, return true and have
- * that dentry's inode and parent both locked.
- */
-static bool shrink_lock_dentry(struct dentry *dentry)
-{
-	struct inode *inode;
-	struct dentry *parent;
-
-	if (dentry->d_lockref.count)
-		return false;
-
-	inode = dentry->d_inode;
-	if (inode && unlikely(!spin_trylock(&inode->i_lock))) {
-		spin_unlock(&dentry->d_lock);
-		spin_lock(&inode->i_lock);
-		spin_lock(&dentry->d_lock);
-		if (unlikely(dentry->d_lockref.count))
-			goto out;
-		/* changed inode means that somebody had grabbed it */
-		if (unlikely(inode != dentry->d_inode))
-			goto out;
-	}
-
-	parent = dentry->d_parent;
-	if (IS_ROOT(dentry) || likely(spin_trylock(&parent->d_lock)))
-		return true;
-
-	spin_unlock(&dentry->d_lock);
-	spin_lock(&parent->d_lock);
-	if (unlikely(parent != dentry->d_parent)) {
-		spin_unlock(&parent->d_lock);
-		spin_lock(&dentry->d_lock);
-		goto out;
-	}
-	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
-	if (likely(!dentry->d_lockref.count))
-		return true;
-	spin_unlock(&parent->d_lock);
-out:
-	if (inode)
-		spin_unlock(&inode->i_lock);
-	return false;
-}
-
 static inline void shrink_kill(struct dentry *victim, struct list_head *list)
 {
 	struct dentry *parent = victim->d_parent;
@@ -1170,7 +1143,7 @@ void shrink_dentry_list(struct list_head *list)
 		dentry = list_entry(list->prev, struct dentry, d_lru);
 		spin_lock(&dentry->d_lock);
 		rcu_read_lock();
-		if (!shrink_lock_dentry(dentry)) {
+		if (!lock_for_kill(dentry)) {
 			bool can_free;
 			rcu_read_unlock();
 			d_shrink_del(dentry);
@@ -1614,7 +1587,7 @@ void shrink_dcache_parent(struct dentry *parent)
 		d_walk(parent, &data, select_collect2);
 		if (data.victim) {
 			spin_lock(&data.victim->d_lock);
-			if (!shrink_lock_dentry(data.victim)) {
+			if (!lock_for_kill(data.victim)) {
 				spin_unlock(&data.victim->d_lock);
 				rcu_read_unlock();
 			} else {
-- 
2.39.2

