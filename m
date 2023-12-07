Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28AF80939C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444024AbjLGVYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444020AbjLGVX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:23:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6D11994
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701984201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sSgQthXmwxTlFwDY+c8KCOHr89T1Ieig2YSHVcODvNM=;
        b=DXL7a4QfBSBql4R97dyh4pdoVTlfRsVswz9+88mI8z6v+RYMto/3ilTv+1OOaL/TMqLwRp
        HW/FERTSpLeZuS/9/HNiSGaUeJ4hwEZoyN0/BrV7Ypf5PfaUYJwAtpFlJELZfLqBL9DHea
        bCe+A/tVoZxdd3odGGqJzMOZFo0uFpI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-lLTI7jkuPiOWpSUKXjbfsw-1; Thu,
 07 Dec 2023 16:23:18 -0500
X-MC-Unique: lLTI7jkuPiOWpSUKXjbfsw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9654229AC011;
        Thu,  7 Dec 2023 21:23:17 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E616D3C2E;
        Thu,  7 Dec 2023 21:23:14 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/59] netfs: Extend the netfs_io_*request structs to handle writes
Date:   Thu,  7 Dec 2023 21:21:26 +0000
Message-ID: <20231207212206.1379128-20-dhowells@redhat.com>
In-Reply-To: <20231207212206.1379128-1-dhowells@redhat.com>
References: <20231207212206.1379128-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the netfs_io_request struct to act as a point around which writes
can be coordinated.  It represents and pins a range of pages that need
writing and a list of regions of dirty data in that range of pages.

If RMW is required, the original data can be downloaded into the bounce
buffer, decrypted if necessary, the modifications made, then the modified
data can be reencrypted/recompressed and sent back to the server.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/internal.h          |  6 ++++++
 fs/netfs/main.c              |  3 ++-
 fs/netfs/objects.c           |  6 ++++++
 fs/netfs/stats.c             | 16 +++++++++++++---
 include/linux/netfs.h        | 15 ++++++++++++++-
 include/trace/events/netfs.h |  8 ++++++--
 6 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 1f25e8622b8a..2f5a83f4b13a 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -110,6 +110,12 @@ extern atomic_t netfs_n_rh_write_begin;
 extern atomic_t netfs_n_rh_write_done;
 extern atomic_t netfs_n_rh_write_failed;
 extern atomic_t netfs_n_rh_write_zskip;
+extern atomic_t netfs_n_wh_upload;
+extern atomic_t netfs_n_wh_upload_done;
+extern atomic_t netfs_n_wh_upload_failed;
+extern atomic_t netfs_n_wh_write;
+extern atomic_t netfs_n_wh_write_done;
+extern atomic_t netfs_n_wh_write_failed;
 
 int netfs_stats_show(struct seq_file *m, void *v);
 
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 404e68e339bf..6584eafda944 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -28,10 +28,11 @@ MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
 LIST_HEAD(netfs_io_requests);
 DEFINE_SPINLOCK(netfs_proc_lock);
 
-static const char *netfs_origins[] = {
+static const char *netfs_origins[nr__netfs_io_origin] = {
 	[NETFS_READAHEAD]	= "RA",
 	[NETFS_READPAGE]	= "RP",
 	[NETFS_READ_FOR_WRITE]	= "RW",
+	[NETFS_WRITEBACK]	= "WB",
 };
 
 /*
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index a7947e82374a..7ef804e8915c 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -20,6 +20,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	struct inode *inode = file ? file_inode(file) : mapping->host;
 	struct netfs_inode *ctx = netfs_inode(inode);
 	struct netfs_io_request *rreq;
+	bool cached = netfs_is_cache_enabled(ctx);
 	int ret;
 
 	rreq = kzalloc(ctx->ops->io_request_size ?: sizeof(struct netfs_io_request),
@@ -38,7 +39,10 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	xa_init(&rreq->bounce);
 	INIT_LIST_HEAD(&rreq->subrequests);
 	refcount_set(&rreq->ref, 1);
+
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
+	if (cached)
+		__set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
 	if (rreq->netfs_ops->init_request) {
 		ret = rreq->netfs_ops->init_request(rreq, file);
 		if (ret < 0) {
@@ -48,6 +52,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 		}
 	}
 
+	trace_netfs_rreq_ref(rreq->debug_id, 1, netfs_rreq_trace_new);
 	netfs_proc_add_rreq(rreq);
 	netfs_stat(&netfs_n_rh_rreq);
 	return rreq;
@@ -132,6 +137,7 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq
 			 sizeof(struct netfs_io_subrequest),
 			 GFP_KERNEL);
 	if (subreq) {
+		INIT_WORK(&subreq->work, NULL);
 		INIT_LIST_HEAD(&subreq->rreq_link);
 		refcount_set(&subreq->ref, 2);
 		subreq->rreq = rreq;
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index 6025dc485f7e..c1f85cd595a4 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -27,6 +27,12 @@ atomic_t netfs_n_rh_write_begin;
 atomic_t netfs_n_rh_write_done;
 atomic_t netfs_n_rh_write_failed;
 atomic_t netfs_n_rh_write_zskip;
+atomic_t netfs_n_wh_upload;
+atomic_t netfs_n_wh_upload_done;
+atomic_t netfs_n_wh_upload_failed;
+atomic_t netfs_n_wh_write;
+atomic_t netfs_n_wh_write_done;
+atomic_t netfs_n_wh_write_failed;
 
 int netfs_stats_show(struct seq_file *m, void *v)
 {
@@ -50,10 +56,14 @@ int netfs_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&netfs_n_rh_read),
 		   atomic_read(&netfs_n_rh_read_done),
 		   atomic_read(&netfs_n_rh_read_failed));
+	seq_printf(m, "Netfs  : UL=%u us=%u uf=%u\n",
+		   atomic_read(&netfs_n_wh_upload),
+		   atomic_read(&netfs_n_wh_upload_done),
+		   atomic_read(&netfs_n_wh_upload_failed));
 	seq_printf(m, "Netfs  : WR=%u ws=%u wf=%u\n",
-		   atomic_read(&netfs_n_rh_write),
-		   atomic_read(&netfs_n_rh_write_done),
-		   atomic_read(&netfs_n_rh_write_failed));
+		   atomic_read(&netfs_n_wh_write),
+		   atomic_read(&netfs_n_wh_write_done),
+		   atomic_read(&netfs_n_wh_write_failed));
 	return fscache_stats_show(m);
 }
 EXPORT_SYMBOL(netfs_stats_show);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 406d5a3a3298..fce7a5a86e8e 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -118,6 +118,9 @@ enum netfs_io_source {
 	NETFS_DOWNLOAD_FROM_SERVER,
 	NETFS_READ_FROM_CACHE,
 	NETFS_INVALID_READ,
+	NETFS_UPLOAD_TO_SERVER,
+	NETFS_WRITE_TO_CACHE,
+	NETFS_INVALID_WRITE,
 } __mode(byte);
 
 typedef void (*netfs_io_terminated_t)(void *priv, ssize_t transferred_or_error,
@@ -149,9 +152,14 @@ struct netfs_cache_resources {
 };
 
 /*
- * Descriptor for a single component subrequest.
+ * Descriptor for a single component subrequest.  Each operation represents an
+ * individual read/write from/to a server, a cache, a journal, etc..
+ *
+ * The buffer iterator is persistent for the life of the subrequest struct and
+ * the pages it points to can be relied on to exist for the duration.
  */
 struct netfs_io_subrequest {
+	struct work_struct	work;
 	struct netfs_io_request *rreq;		/* Supervising I/O request */
 	struct list_head	rreq_link;	/* Link in rreq->subrequests */
 	struct iov_iter		io_iter;	/* Iterator for this subrequest */
@@ -176,6 +184,8 @@ enum netfs_io_origin {
 	NETFS_READAHEAD,		/* This read was triggered by readahead */
 	NETFS_READPAGE,			/* This read is a synchronous read */
 	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
+	NETFS_WRITEBACK,		/* This write was triggered by writepages */
+	nr__netfs_io_origin
 } __mode(byte);
 
 /*
@@ -200,6 +210,7 @@ struct netfs_io_request {
 	__counted_by(direct_bv_count);
 	unsigned int		direct_bv_count; /* Number of elements in direct_bv[] */
 	unsigned int		debug_id;
+	unsigned int		subreq_counter;	/* Next subreq->debug_index */
 	atomic_t		nr_outstanding;	/* Number of ops in progress */
 	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in progress */
 	size_t			submitted;	/* Amount submitted for I/O so far */
@@ -219,6 +230,8 @@ struct netfs_io_request {
 #define NETFS_RREQ_FAILED		4	/* The request failed */
 #define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes */
 #define NETFS_RREQ_USE_BOUNCE_BUFFER	6	/* Use bounce buffer */
+#define NETFS_RREQ_WRITE_TO_CACHE	7	/* Need to write to the cache */
+#define NETFS_RREQ_UPLOAD_TO_SERVER	8	/* Need to write to the server */
 	const struct netfs_request_ops *netfs_ops;
 };
 
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index fce6d0bc78e5..4ea4e34d279f 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -24,7 +24,8 @@
 #define netfs_rreq_origins					\
 	EM(NETFS_READAHEAD,			"RA")		\
 	EM(NETFS_READPAGE,			"RP")		\
-	E_(NETFS_READ_FOR_WRITE,		"RW")
+	EM(NETFS_READ_FOR_WRITE,		"RW")		\
+	E_(NETFS_WRITEBACK,			"WB")
 
 #define netfs_rreq_traces					\
 	EM(netfs_rreq_trace_assess,		"ASSESS ")	\
@@ -39,7 +40,10 @@
 	EM(NETFS_FILL_WITH_ZEROES,		"ZERO")		\
 	EM(NETFS_DOWNLOAD_FROM_SERVER,		"DOWN")		\
 	EM(NETFS_READ_FROM_CACHE,		"READ")		\
-	E_(NETFS_INVALID_READ,			"INVL")		\
+	EM(NETFS_INVALID_READ,			"INVL")		\
+	EM(NETFS_UPLOAD_TO_SERVER,		"UPLD")		\
+	EM(NETFS_WRITE_TO_CACHE,		"WRIT")		\
+	E_(NETFS_INVALID_WRITE,			"INVL")
 
 #define netfs_sreq_traces					\
 	EM(netfs_sreq_trace_download_instead,	"RDOWN")	\

