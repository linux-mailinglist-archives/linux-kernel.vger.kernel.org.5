Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43CF7F6C43
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344398AbjKXGTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344492AbjKXGSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:18:32 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5529A19B5;
        Thu, 23 Nov 2023 22:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WdlMjmeNJfREGqWuANDJU4VuiNfuWxzfrjdKu58i0yk=; b=Bv6kmSv4FG6J0DTEPHbR95nSz4
        doiTVehJfYzFMS3rNkrRfiX+O4r6AAi1oSWpBLw64Cmz7Lj+h8tvXY13dWwy2UDG6JoghwTrHIAtE
        pOcESk4I1Xbcha3QU6pWh85eKmqAqhPcsy5SfVjiBEM/aDPQBzpC3no3Z+wkb/1u/uw9KWNo9V6QL
        QUHMb5yp3S/cfJKRA3yEBRtz+L4dbTwsUDO5ytRam91+BBed5qESxTKhSa1LEfI4sNju9DJ4Ub3S1
        ADPGgzWDs3Ri/uKUAqX6OyXnBBNQAS5LG9Rcj9PdYMNohRrLKwivTJawhmxmZbJNurGAdeUDXXawE
        JHbpKgCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PKx-002Q1s-2g;
        Fri, 24 Nov 2023 06:06:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/20] __d_unalias() doesn't use inode argument
Date:   Fri, 24 Nov 2023 06:06:42 +0000
Message-Id: <20231124060644.576611-18-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060644.576611-1-viro@zeniv.linux.org.uk>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
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

... and hasn't since 2015.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 51e2f777a2c5..b8f502a66e53 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3043,8 +3043,7 @@ struct dentry *d_ancestor(struct dentry *p1, struct dentry *p2)
  * Note: If ever the locking in lock_rename() changes, then please
  * remember to update this too...
  */
-static int __d_unalias(struct inode *inode,
-		struct dentry *dentry, struct dentry *alias)
+static int __d_unalias(struct dentry *dentry, struct dentry *alias)
 {
 	struct mutex *m1 = NULL;
 	struct rw_semaphore *m2 = NULL;
@@ -3125,7 +3124,7 @@ struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
 					inode->i_sb->s_id);
 			} else if (!IS_ROOT(new)) {
 				struct dentry *old_parent = dget(new->d_parent);
-				int err = __d_unalias(inode, dentry, new);
+				int err = __d_unalias(dentry, new);
 				write_sequnlock(&rename_lock);
 				if (err) {
 					dput(new);
-- 
2.39.2

