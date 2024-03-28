Return-Path: <linux-kernel+bounces-123286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68248890605
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700E01C2FCCC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDC513CFAA;
	Thu, 28 Mar 2024 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byxL8PIJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7877E767
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643921; cv=none; b=NrVCmy06RJd2WcEMDrVvvQPP0IAfysujwnVeTPW4BfjKags6xz/EyWUFMuHWmDKrwrAah5j4j0/foF2LYLqYyPcz+M0BMzpr+EY1tG8UYRjkg6FVM6zWNexW/xQPYfC6VeKVp5XwF2kj61sJOd1+JokTXZp++kHjPbEKuGPp0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643921; c=relaxed/simple;
	bh=6yE3e25183BKcSWWEt6QQ+rwfvfmLlX7rye2oLPd2aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7IhK5t79MMDMOE6hEQWj+NtORbAFkzz2dFBgQ0+7bs5HFnwmoECFroz+swl3SnwQnNT7Zh4wrRailRgw5r91qPQIQ1Sw+z2Ms9BC0qhP6MGCwUxZz/eZquSYbEg8024rId1LoEWti/tyFfVh6TbiSC7rGYKBsCfDkN2FAlJTwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=byxL8PIJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08BQVB5a47a8ZK8FFbOaylpdSd6N4VkCmtEx277bjMw=;
	b=byxL8PIJ7InT6PdV+rlRckbLQwVW9x2ZsT5L7OcRozvcxJfhSmkpM8tJwZt5HdJbsmCbaE
	paYpy09XjVjKkTd4NFVVYMouYYW0keuuTqqBd9rGzJgkjws4HJNPzvlJDCugUHs6trDh0d
	2oAzGEkxh3wb1boARCc9sHUNJP6Rrc8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-ESNBE_2_P8S2T8AJ9Ud0UA-1; Thu, 28 Mar 2024 12:38:34 -0400
X-MC-Unique: ESNBE_2_P8S2T8AJ9Ud0UA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC456857E7C;
	Thu, 28 Mar 2024 16:38:31 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9D693200A384;
	Thu, 28 Mar 2024 16:38:28 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: [PATCH 21/26] netfs, 9p: Implement helpers for new write code
Date: Thu, 28 Mar 2024 16:34:13 +0000
Message-ID: <20240328163424.2781320-22-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Implement the helpers for the new write code in 9p.  There's now an
optional ->prepare_write() that allows the filesystem to set the parameters
for the next write, such as maximum size and maximum segment count, and an
->issue_write() that is called to initiate an (asynchronous) write
operation.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: v9fs@lists.linux.dev
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c        | 48 ++++++++++++++++++++++++++++++++++++++++
 include/net/9p/client.h |  2 ++
 net/9p/Kconfig          |  1 +
 net/9p/client.c         | 49 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 5a943c122d83..07d03efdd594 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -26,6 +26,40 @@
 #include "cache.h"
 #include "fid.h"
 
+/*
+ * Writeback calls this when it finds a folio that needs uploading.  This isn't
+ * called if writeback only has copy-to-cache to deal with.
+ */
+static void v9fs_begin_writeback(struct netfs_io_request *wreq)
+{
+	struct p9_fid *fid;
+
+	fid = v9fs_fid_find_inode(wreq->inode, true, INVALID_UID, true);
+	if (!fid) {
+		WARN_ONCE(1, "folio expected an open fid inode->i_ino=%lx\n",
+			  wreq->inode->i_ino);
+		return;
+	}
+
+	wreq->wsize = fid->clnt->msize - P9_IOHDRSZ;
+	if (fid->iounit)
+		wreq->wsize = min(wreq->wsize, fid->iounit);
+	wreq->netfs_priv = fid;
+	wreq->io_streams[0].avail = true;
+}
+
+/*
+ * Issue a subrequest to write to the server.
+ */
+static void v9fs_issue_write(struct netfs_io_subrequest *subreq)
+{
+	struct p9_fid *fid = subreq->rreq->netfs_priv;
+	int err, len;
+
+	len = p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
+	netfs_write_subrequest_terminated(subreq, len ?: err, false);
+}
+
 static void v9fs_upload_to_server(struct netfs_io_subrequest *subreq)
 {
 	struct p9_fid *fid = subreq->rreq->netfs_priv;
@@ -92,6 +126,14 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 			rreq->origin == NETFS_UNBUFFERED_WRITE ||
 			rreq->origin == NETFS_DIO_WRITE);
 
+#if 0 // TODO: Cut over
+	if (rreq->origin == NETFS_WRITEBACK)
+		return 0; /* We don't get the write handle until we find we
+			   * have actually dirty data and not just
+			   * copy-to-cache data.
+			   */
+#endif
+
 	if (file) {
 		fid = file->private_data;
 		if (!fid)
@@ -103,6 +145,10 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 			goto no_fid;
 	}
 
+	rreq->wsize = fid->clnt->msize - P9_IOHDRSZ;
+	if (fid->iounit)
+		rreq->wsize = min(rreq->wsize, fid->iounit);
+
 	/* we might need to read from a fid that was opened write-only
 	 * for read-modify-write of page cache, use the writeback fid
 	 * for that */
@@ -131,6 +177,8 @@ const struct netfs_request_ops v9fs_req_ops = {
 	.init_request		= v9fs_init_request,
 	.free_request		= v9fs_free_request,
 	.issue_read		= v9fs_issue_read,
+	.begin_writeback	= v9fs_begin_writeback,
+	.issue_write		= v9fs_issue_write,
 	.create_write_requests	= v9fs_create_write_requests,
 };
 
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 78ebcf782ce5..4f785098c67a 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -207,6 +207,8 @@ int p9_client_read(struct p9_fid *fid, u64 offset, struct iov_iter *to, int *err
 int p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 		int *err);
 int p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err);
+struct netfs_io_subrequest;
+void p9_client_write_subreq(struct netfs_io_subrequest *subreq);
 int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset);
 int p9dirent_read(struct p9_client *clnt, char *buf, int len,
 		  struct p9_dirent *dirent);
diff --git a/net/9p/Kconfig b/net/9p/Kconfig
index 00ebce9e5a65..bcdab9c23b40 100644
--- a/net/9p/Kconfig
+++ b/net/9p/Kconfig
@@ -5,6 +5,7 @@
 
 menuconfig NET_9P
 	tristate "Plan 9 Resource Sharing Support (9P2000)"
+	select NETFS_SUPPORT
 	help
 	  If you say Y here, you will get experimental support for
 	  Plan 9 resource sharing via the 9P2000 protocol.
diff --git a/net/9p/client.c b/net/9p/client.c
index e265a0ca6bdd..844aca4fe4d8 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -18,6 +18,7 @@
 #include <linux/sched/signal.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
+#include <linux/netfs.h>
 #include <net/9p/9p.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
@@ -1661,6 +1662,54 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 }
 EXPORT_SYMBOL(p9_client_write);
 
+void
+p9_client_write_subreq(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *wreq = subreq->rreq;
+	struct p9_fid *fid = wreq->netfs_priv;
+	struct p9_client *clnt = fid->clnt;
+	struct p9_req_t *req;
+	unsigned long long start = subreq->start + subreq->transferred;
+	size_t len = subreq->len - subreq->transferred;
+	int written, err;
+
+	p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu len %zd\n",
+		 fid->fid, start, len);
+
+	/* Don't bother zerocopy for small IO (< 1024) */
+	if (clnt->trans_mod->zc_request && len > 1024) {
+		req = p9_client_zc_rpc(clnt, P9_TWRITE, NULL, &subreq->io_iter,
+				       0, wreq->len, P9_ZC_HDR_SZ, "dqd",
+				       fid->fid, start, len);
+	} else {
+		req = p9_client_rpc(clnt, P9_TWRITE, "dqV", fid->fid,
+				    start, len, &subreq->io_iter);
+	}
+	if (IS_ERR(req)) {
+		netfs_write_subrequest_terminated(subreq, PTR_ERR(req), false);
+		return;
+	}
+
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "d", &written);
+	if (err) {
+		trace_9p_protocol_dump(clnt, &req->rc);
+		p9_req_put(clnt, req);
+		netfs_write_subrequest_terminated(subreq, err, false);
+		return;
+	}
+
+	if (written > len) {
+		pr_err("bogus RWRITE count (%d > %lu)\n", written, len);
+		written = len;
+	}
+
+	p9_debug(P9_DEBUG_9P, "<<< RWRITE count %zd\n", len);
+
+	p9_req_put(clnt, req);
+	netfs_write_subrequest_terminated(subreq, written, false);
+}
+EXPORT_SYMBOL(p9_client_write_subreq);
+
 struct p9_wstat *p9_client_stat(struct p9_fid *fid)
 {
 	int err;


