Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394D07FEE5E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345287AbjK3L5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345214AbjK3L5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:57:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA9599
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701345449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=6RcSbHR7cFN6wAchAsaYdBBxf6WBZ1koqQk/TqaNhwk=;
        b=Xwupty/nMJJhM/yZticViVqt36a0O2GGZSLPnwYwxxdWGRjA1TMHB122zTXcg5hti9MwSY
        bHFWH/6m6a6H87MZCTi6aY+WEJENuH0Q59/ZCP5tVjDIgkVlJMoIGb3qAiikch1KHE5Q+U
        TTTr8k2Y/dBo6QagV4BsJAGNmwVfUzg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-cbkPqBosOSuYjqSifHfZyA-1; Thu,
 30 Nov 2023 06:57:25 -0500
X-MC-Unique: cbkPqBosOSuYjqSifHfZyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4944238117F3;
        Thu, 30 Nov 2023 11:57:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.2])
        by smtp.corp.redhat.com (Postfix) with SMTP id ED0951C060B1;
        Thu, 30 Nov 2023 11:57:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 30 Nov 2023 12:56:19 +0100 (CET)
Date:   Thu, 30 Nov 2023 12:56:17 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] afs: use read_seqbegin() in afs_check_validity() and
 afs_getattr()
Message-ID: <20231130115617.GA21584@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130115537.GA21550@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells says:

 (3) afs_check_validity().
 (4) afs_getattr().

     These are both pretty short, so your solution is probably good for them.
     That said, afs_vnode_commit_status() can spend a long time under the
     write lock - and pretty much every file RPC op returns a status update.

Change these functions to use read_seqbegin(). This simplifies the code
and doesn't change the current behaviour, the "seq" counter is always even
so read_seqbegin_or_lock() can never take the lock.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/afs/inode.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 78efc9719349..a6ae74d5b698 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -629,10 +629,10 @@ bool afs_check_validity(struct afs_vnode *vnode)
 	enum afs_cb_break_reason need_clear = afs_cb_break_no_break;
 	time64_t now = ktime_get_real_seconds();
 	unsigned int cb_break;
-	int seq = 0;
+	int seq;
 
 	do {
-		read_seqbegin_or_lock(&vnode->cb_lock, &seq);
+		seq = read_seqbegin(&vnode->cb_lock);
 		cb_break = vnode->cb_break;
 
 		if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
@@ -650,9 +650,7 @@ bool afs_check_validity(struct afs_vnode *vnode)
 			need_clear = afs_cb_break_no_promise;
 		}
 
-	} while (need_seqretry(&vnode->cb_lock, seq));
-
-	done_seqretry(&vnode->cb_lock, seq);
+	} while (read_seqretry(&vnode->cb_lock, seq));
 
 	if (need_clear == afs_cb_break_no_break)
 		return true;
@@ -755,7 +753,7 @@ int afs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	struct inode *inode = d_inode(path->dentry);
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	struct key *key;
-	int ret, seq = 0;
+	int ret, seq;
 
 	_enter("{ ino=%lu v=%u }", inode->i_ino, inode->i_generation);
 
@@ -772,7 +770,7 @@ int afs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	}
 
 	do {
-		read_seqbegin_or_lock(&vnode->cb_lock, &seq);
+		seq = read_seqbegin(&vnode->cb_lock);
 		generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
 		if (test_bit(AFS_VNODE_SILLY_DELETED, &vnode->flags) &&
 		    stat->nlink > 0)
@@ -784,9 +782,8 @@ int afs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 */
 		if (S_ISDIR(inode->i_mode))
 			stat->size = vnode->netfs.remote_i_size;
-	} while (need_seqretry(&vnode->cb_lock, seq));
+	} while (read_seqretry(&vnode->cb_lock, seq));
 
-	done_seqretry(&vnode->cb_lock, seq);
 	return 0;
 }
 
-- 
2.25.1.362.g51ebf55

