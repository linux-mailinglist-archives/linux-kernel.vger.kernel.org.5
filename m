Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E977D94E5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345614AbjJ0KOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJ0KOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:14:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52386C4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698401592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=wxcQgKtX6m+qD6u/msT0KhsPiwmGQf0kDwNCqogkF8M=;
        b=GqSD6Z7nMsKbF9j2bYBckhcX3UKVaXfDOpaC9Uk30xF1h9s0hdXUt9POjP+L7QovovqF9h
        Zs7Aj3Ot/TmzIDGWh9AbXXXGUzwOhK7pi3z01vllyK4mWlQFipssyRSVpZq9nJzIpR8m1Q
        anRryAUyCp1yShNpTIigHE9joM6uP30=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-vbzuj7P2PXWFSoZWe3dG2A-1; Fri,
 27 Oct 2023 06:13:09 -0400
X-MC-Unique: vbzuj7P2PXWFSoZWe3dG2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB50A1C06904;
        Fri, 27 Oct 2023 10:13:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6CD9E2166B26;
        Fri, 27 Oct 2023 10:13:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 27 Oct 2023 12:12:07 +0200 (CEST)
Date:   Fri, 27 Oct 2023 12:12:05 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/afs: use read_seqbegin() rather than
 read_seqbegin_or_lock()
Message-ID: <20231027101205.GA31430@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

read_seqbegin_or_lock() makes no sense unless you make "seq" odd
after the lockless access failed. See thread_group_cputime() as
an example, note that it does nextseq = 1 for the 2nd round.

So this code can use read_seqbegin() without changing the current
behaviour.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/afs/callback.c |  7 +++----
 fs/afs/inode.c    | 15 ++++++---------
 fs/afs/server.c   | 17 +++++++----------
 3 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index a484fa642808..b33d8a4901f8 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -110,14 +110,14 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
 {
 	struct afs_volume *volume = NULL;
 	struct rb_node *p;
-	int seq = 0;
+	int seq;
 
 	do {
 		/* Unfortunately, rbtree walking doesn't give reliable results
 		 * under just the RCU read lock, so we have to check for
 		 * changes.
 		 */
-		read_seqbegin_or_lock(&cell->volume_lock, &seq);
+		seq = read_seqbegin(&cell->volume_lock);
 
 		p = rcu_dereference_raw(cell->volumes.rb_node);
 		while (p) {
@@ -132,9 +132,8 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
 			volume = NULL;
 		}
 
-	} while (need_seqretry(&cell->volume_lock, seq));
+	} while (read_seqretry(&cell->volume_lock, seq));
 
-	done_seqretry(&cell->volume_lock, seq);
 	return volume;
 }
 
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 1c794a1896aa..88003fefff71 100644
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
 
diff --git a/fs/afs/server.c b/fs/afs/server.c
index b5237206eac3..01a26c0e0d28 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -27,7 +27,7 @@ struct afs_server *afs_find_server(struct afs_net *net,
 	const struct afs_addr_list *alist;
 	struct afs_server *server = NULL;
 	unsigned int i;
-	int seq = 0, diff;
+	int seq, diff;
 
 	rcu_read_lock();
 
@@ -35,7 +35,8 @@ struct afs_server *afs_find_server(struct afs_net *net,
 		if (server)
 			afs_unuse_server_notime(net, server, afs_server_trace_put_find_rsq);
 		server = NULL;
-		read_seqbegin_or_lock(&net->fs_addr_lock, &seq);
+
+		seq = read_seqbegin(&net->fs_addr_lock);
 
 		if (srx->transport.family == AF_INET6) {
 			const struct sockaddr_in6 *a = &srx->transport.sin6, *b;
@@ -75,9 +76,7 @@ struct afs_server *afs_find_server(struct afs_net *net,
 	found:
 		server = afs_maybe_use_server(server, afs_server_trace_get_by_addr);
 
-	} while (need_seqretry(&net->fs_addr_lock, seq));
-
-	done_seqretry(&net->fs_addr_lock, seq);
+	} while (read_seqretry(&net->fs_addr_lock, seq));
 
 	rcu_read_unlock();
 	return server;
@@ -90,7 +89,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 {
 	struct afs_server *server = NULL;
 	struct rb_node *p;
-	int diff, seq = 0;
+	int diff, seq;
 
 	_enter("%pU", uuid);
 
@@ -103,7 +102,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 			afs_unuse_server(net, server, afs_server_trace_put_uuid_rsq);
 		server = NULL;
 
-		read_seqbegin_or_lock(&net->fs_lock, &seq);
+		seq = read_seqbegin(&net->fs_lock);
 
 		p = net->fs_servers.rb_node;
 		while (p) {
@@ -121,9 +120,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 
 			server = NULL;
 		}
-	} while (need_seqretry(&net->fs_lock, seq));
-
-	done_seqretry(&net->fs_lock, seq);
+	} while (read_seqretry(&net->fs_lock, seq));
 
 	_leave(" = %p", server);
 	return server;
-- 
2.25.1.362.g51ebf55


