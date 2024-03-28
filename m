Return-Path: <linux-kernel+bounces-123271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1C58905C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4149129A069
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014ED1386D3;
	Thu, 28 Mar 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPgnir6U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B39F137C36
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643832; cv=none; b=SQr8Tnj+JBtApclLM1QalMPdUvCjKb1Bv8M74LbQbZeyJaL8QMsieFm+no3VU+nSMIyhD3RB/hj3qUiqvlsF+rqoTTquHOh3ozSgbR4NcsbOg2cZHPaojZTLXj13wEJx/kYp7kX+8n8MeTHqM0mw6fg1V7zKzcESThMzPv+YkW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643832; c=relaxed/simple;
	bh=sdVM49R5pf4iYw6+e32PlvypUiyNCnM8S4phChaUfIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2QEAi6XKsEqIIsIc55XzGdiktle0ZIJvzd2DONSptSGtnRq3EAsQn42K8mUHz3Pwr4idDmX0254o/a3ldcldnzwG/4YGe7eVNJt5Vxw5f4eOaHT54YLvcmB1/S7AyHMkyMnYcn9DOqYIpQCSiiByZ9JJ73nApA71Dm9UlrU7Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPgnir6U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ynxqw2O6Fn8BCqwyUG55TcbJftNzL16LOIMZCwa+6jc=;
	b=WPgnir6UMMjjuhEmHcSRUVow363CgY4xLjtGIie1HwN1Z6syO5vGRl3zG7jMmj3OP/AteU
	zmKkOiavoS8jsU0MISvLdvQECzeKAPdCYMp5tgT8YoV4ZOzeWRJZh4gWCcg1tbJ1VLI8I7
	jK9BU2RIXAr8LBgvw/ZdLa2RDSTjVQc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-Suy6mr8HNd28fD3IYgT4vw-1; Thu,
 28 Mar 2024 12:37:07 -0400
X-MC-Unique: Suy6mr8HNd28fD3IYgT4vw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA02B383CD7A;
	Thu, 28 Mar 2024 16:37:06 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB8F0492BD0;
	Thu, 28 Mar 2024 16:37:03 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/26] afs: Use alternative invalidation to using launder_folio
Date: Thu, 28 Mar 2024 16:34:04 +0000
Message-ID: <20240328163424.2781320-13-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Use writepages-based flushing invalidation instead of
invalidate_inode_pages2() and ->launder_folio().  This will allow
->launder_folio() to be removed eventually.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/file.c       |  1 -
 fs/afs/internal.h   |  1 -
 fs/afs/validation.c |  4 ++--
 fs/afs/write.c      | 10 +++-------
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index ef2cc8f565d2..dfd8f60f5e1f 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -54,7 +54,6 @@ const struct address_space_operations afs_file_aops = {
 	.read_folio	= netfs_read_folio,
 	.readahead	= netfs_readahead,
 	.dirty_folio	= netfs_dirty_folio,
-	.launder_folio	= netfs_launder_folio,
 	.release_folio	= netfs_release_folio,
 	.invalidate_folio = netfs_invalidate_folio,
 	.migrate_folio	= filemap_migrate_folio,
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 6ce5a612937c..b93aa026daa4 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -916,7 +916,6 @@ struct afs_operation {
 			loff_t	pos;
 			loff_t	size;
 			loff_t	i_size;
-			bool	laundering;	/* Laundering page, PG_writeback not set */
 		} store;
 		struct {
 			struct iattr	*attr;
diff --git a/fs/afs/validation.c b/fs/afs/validation.c
index 32a53fc8dfb2..1d8bbc46f734 100644
--- a/fs/afs/validation.c
+++ b/fs/afs/validation.c
@@ -365,9 +365,9 @@ static void afs_zap_data(struct afs_vnode *vnode)
 	 * written back in a regular file and completely discard the pages in a
 	 * directory or symlink */
 	if (S_ISREG(vnode->netfs.inode.i_mode))
-		invalidate_remote_inode(&vnode->netfs.inode);
+		filemap_invalidate_inode(&vnode->netfs.inode, true);
 	else
-		invalidate_inode_pages2(vnode->netfs.inode.i_mapping);
+		filemap_invalidate_inode(&vnode->netfs.inode, false);
 }
 
 /*
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 74402d95a884..1bc26466eb72 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -75,8 +75,7 @@ static void afs_store_data_success(struct afs_operation *op)
 	op->ctime = op->file[0].scb.status.mtime_client;
 	afs_vnode_commit_status(op, &op->file[0]);
 	if (!afs_op_error(op)) {
-		if (!op->store.laundering)
-			afs_pages_written_back(vnode, op->store.pos, op->store.size);
+		afs_pages_written_back(vnode, op->store.pos, op->store.size);
 		afs_stat_v(vnode, n_stores);
 		atomic_long_add(op->store.size, &afs_v2net(vnode)->n_store_bytes);
 	}
@@ -91,8 +90,7 @@ static const struct afs_operation_ops afs_store_data_operation = {
 /*
  * write to a file
  */
-static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t pos,
-			  bool laundering)
+static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t pos)
 {
 	struct afs_operation *op;
 	struct afs_wb_key *wbk = NULL;
@@ -123,7 +121,6 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t
 	op->file[0].modification = true;
 	op->store.pos = pos;
 	op->store.size = size;
-	op->store.laundering = laundering;
 	op->flags |= AFS_OPERATION_UNINTR;
 	op->ops = &afs_store_data_operation;
 
@@ -168,8 +165,7 @@ static void afs_upload_to_server(struct netfs_io_subrequest *subreq)
 	       subreq->rreq->debug_id, subreq->debug_index, subreq->io_iter.count);
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-	ret = afs_store_data(vnode, &subreq->io_iter, subreq->start,
-			     subreq->rreq->origin == NETFS_LAUNDER_WRITE);
+	ret = afs_store_data(vnode, &subreq->io_iter, subreq->start);
 	netfs_write_subrequest_terminated(subreq, ret < 0 ? ret : subreq->len,
 					  false);
 }


