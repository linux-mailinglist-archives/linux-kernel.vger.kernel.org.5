Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CE27BC9CF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 22:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbjJGUgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 16:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344180AbjJGUgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 16:36:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9F695;
        Sat,  7 Oct 2023 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=M8hQeLdTKHD1dkcSFiFXLuX/qDihXIc+aJqbr2IAWzY=; b=lQcmH1QCtfWiamaUkdggT/KxOo
        OK0QlZrv3IuBk3rgCNbSb2qFSC5vOBeAFcN8mrzvdhDtou8RV6BMahNOsV1MSS3hJGeedDAplZ/cV
        YyZccOspWO/IbpA8IroZfVlWGHQo5O+RCZo0GoNt5Yux+UC2DMSWlPddd+fjtxxMg5V5rPKo917iV
        WjmPfeKI9oYkPHpC3LSi9i3iUyWzvGuW88sPcLpQLhA1QXCCqoAa2MqrVH0X0URx34oIh7eWvoHi7
        JFUsXkX6bwQdA1WfweORl4aGPqfBoGr6P0DIIn4hQWkVuXzWWIWuUVR7MIui0t5jKGZAvoGc/z6VP
        kst7qR8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qpE1Y-005mLI-Ux; Sat, 07 Oct 2023 20:35:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 5/5] fs: Add inode_assert_locked() and inode_assert_locked_excl()
Date:   Sat,  7 Oct 2023 21:35:43 +0100
Message-Id: <20231007203543.1377452-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231007203543.1377452-1-willy@infradead.org>
References: <20231007203543.1377452-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new rwsem_assert_held functions to implement these new
assertions.  Convert the inode_is_locked() callers in the VFS to
use them.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/attr.c          |  2 +-
 fs/namei.c         |  6 +++---
 include/linux/fs.h | 10 ++++++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index a8ae5f6d9b16..5e32b0a4f8c2 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -387,7 +387,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct timespec64 now;
 	unsigned int ia_valid = attr->ia_valid;
 
-	WARN_ON_ONCE(!inode_is_locked(inode));
+	inode_assert_locked_excl(inode);
 
 	error = may_setattr(idmap, inode, ia_valid);
 	if (error)
diff --git a/fs/namei.c b/fs/namei.c
index 567ee547492b..6b595ad4318d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2708,7 +2708,7 @@ struct dentry *try_lookup_one_len(const char *name, struct dentry *base, int len
 	struct qstr this;
 	int err;
 
-	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
+	inode_assert_locked(base->d_inode);
 
 	err = lookup_one_common(&nop_mnt_idmap, name, base, len, &this);
 	if (err)
@@ -2735,7 +2735,7 @@ struct dentry *lookup_one_len(const char *name, struct dentry *base, int len)
 	struct qstr this;
 	int err;
 
-	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
+	inode_assert_locked(base->d_inode);
 
 	err = lookup_one_common(&nop_mnt_idmap, name, base, len, &this);
 	if (err)
@@ -2765,7 +2765,7 @@ struct dentry *lookup_one(struct mnt_idmap *idmap, const char *name,
 	struct qstr this;
 	int err;
 
-	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
+	inode_assert_locked(base->d_inode);
 
 	err = lookup_one_common(idmap, name, base, len, &this);
 	if (err)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b528f063e8ff..e01e041c102b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -832,6 +832,16 @@ static inline int inode_is_locked(struct inode *inode)
 	return rwsem_is_locked(&inode->i_rwsem);
 }
 
+static inline void inode_assert_locked(const struct inode *inode)
+{
+	rwsem_assert_held(&inode->i_rwsem);
+}
+
+static inline void inode_assert_locked_excl(const struct inode *inode)
+{
+	rwsem_assert_held_write(&inode->i_rwsem);
+}
+
 static inline void inode_lock_nested(struct inode *inode, unsigned subclass)
 {
 	down_write_nested(&inode->i_rwsem, subclass);
-- 
2.40.1

