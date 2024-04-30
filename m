Return-Path: <linux-kernel+bounces-164107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8888B7911
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1BF280291
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971AF194C95;
	Tue, 30 Apr 2024 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LT0OycUW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE20194C7A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486206; cv=none; b=m85ywT85MU3DdSYDz1IP2UXk1ecoItiL8OcrZAqA3UdDAZX3UceNC+28stV/D42eKdrebQzoY7OyX5CFqoPcHe/G3U8ExDd5DZk84vZz3AGg94gLyrz7Uzna4WeV5nHFkd07p9WayMfOAoYyZVEA9DcKAV3Nktdfn0kJ/8noWqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486206; c=relaxed/simple;
	bh=3vDroqz4wBb0+b6oD898Z1hU3JuRyWNuTtQc2fqIvZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLBmjA0iY9MLdLD4+YPA0lZn22KRDJd0jRAcNLP+1bDTtmMT3XvyNrWnp34t6lqxP/elHuHMWvx2v9dDuRKUuyh7EebKNURZ0DCnjf+TTmZlMGKF0lyA2FuQjXS72L5Ohpao3yhaBsifnNj6/0jqF84Qui5vllVXuRI/d8qjcUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LT0OycUW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714486204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=03X3mo87gUSC3MAyuZV5fNC14uqUEaNxsRd7sX93elM=;
	b=LT0OycUWj7GSzDAUhax/8Y/6yybnNvz/4mZZ4wvHIeoiqntOvr4QaT657HiiYG0VN0kVGz
	ftPmB/u1FsK1TaH0l4hu8MUHK2D6ezAQHoP/zL8EAak1L9Zqg5U1fCGbCn0eellFZgZOuf
	j63r7IO+gVNPZ55eL8n2JYhekHMGlOU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-aLKFvJZZPZOE1ZYQeWXoiA-1; Tue,
 30 Apr 2024 10:09:58 -0400
X-MC-Unique: aLKFvJZZPZOE1ZYQeWXoiA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDC561C03145;
	Tue, 30 Apr 2024 14:09:57 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 999ED400EB2;
	Tue, 30 Apr 2024 14:09:55 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH v7 09/16] cifs: Add mempools for cifs_io_request and cifs_io_subrequest structs
Date: Tue, 30 Apr 2024 15:09:21 +0100
Message-ID: <20240430140930.262762-10-dhowells@redhat.com>
In-Reply-To: <20240430140930.262762-1-dhowells@redhat.com>
References: <20240430140930.262762-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Add mempools for the allocation of cifs_io_request and cifs_io_subrequest
structs for netfslib to use so that it can guarantee eventual allocation in
writeback.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/cifsfs.c   | 55 +++++++++++++++++++++++++++++++++++++++-
 fs/smb/client/cifsglob.h |  2 ++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 9d656a08f617..763d17870e0b 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -371,9 +371,13 @@ static struct kmem_cache *cifs_inode_cachep;
 static struct kmem_cache *cifs_req_cachep;
 static struct kmem_cache *cifs_mid_cachep;
 static struct kmem_cache *cifs_sm_req_cachep;
+static struct kmem_cache *cifs_io_request_cachep;
+static struct kmem_cache *cifs_io_subrequest_cachep;
 mempool_t *cifs_sm_req_poolp;
 mempool_t *cifs_req_poolp;
 mempool_t *cifs_mid_poolp;
+mempool_t cifs_io_request_pool;
+mempool_t cifs_io_subrequest_pool;
 
 static struct inode *
 cifs_alloc_inode(struct super_block *sb)
@@ -1750,6 +1754,48 @@ static void destroy_mids(void)
 	kmem_cache_destroy(cifs_mid_cachep);
 }
 
+static int cifs_init_netfs(void)
+{
+	cifs_io_request_cachep =
+		kmem_cache_create("cifs_io_request",
+				  sizeof(struct netfs_io_request), 0,
+				  SLAB_HWCACHE_ALIGN, NULL);
+	if (!cifs_io_request_cachep)
+		goto nomem_req;
+
+	if (mempool_init_slab_pool(&cifs_io_request_pool, 100, cifs_io_request_cachep) < 0)
+		goto nomem_reqpool;
+
+	cifs_io_subrequest_cachep =
+		kmem_cache_create("cifs_io_subrequest",
+				  sizeof(struct cifs_io_subrequest), 0,
+				  SLAB_HWCACHE_ALIGN, NULL);
+	if (!cifs_io_subrequest_cachep)
+		goto nomem_subreq;
+
+	if (mempool_init_slab_pool(&cifs_io_subrequest_pool, 100, cifs_io_subrequest_cachep) < 0)
+		goto nomem_subreqpool;
+
+	return 0;
+
+nomem_subreqpool:
+	kmem_cache_destroy(cifs_io_subrequest_cachep);
+nomem_subreq:
+	mempool_destroy(&cifs_io_request_pool);
+nomem_reqpool:
+	kmem_cache_destroy(cifs_io_request_cachep);
+nomem_req:
+	return -ENOMEM;
+}
+
+static void cifs_destroy_netfs(void)
+{
+	mempool_destroy(&cifs_io_subrequest_pool);
+	kmem_cache_destroy(cifs_io_subrequest_cachep);
+	mempool_destroy(&cifs_io_request_pool);
+	kmem_cache_destroy(cifs_io_request_cachep);
+}
+
 static int __init
 init_cifs(void)
 {
@@ -1854,10 +1900,14 @@ init_cifs(void)
 	if (rc)
 		goto out_destroy_deferredclose_wq;
 
-	rc = init_mids();
+	rc = cifs_init_netfs();
 	if (rc)
 		goto out_destroy_inodecache;
 
+	rc = init_mids();
+	if (rc)
+		goto out_destroy_netfs;
+
 	rc = cifs_init_request_bufs();
 	if (rc)
 		goto out_destroy_mids;
@@ -1912,6 +1962,8 @@ init_cifs(void)
 	cifs_destroy_request_bufs();
 out_destroy_mids:
 	destroy_mids();
+out_destroy_netfs:
+	cifs_destroy_netfs();
 out_destroy_inodecache:
 	cifs_destroy_inodecache();
 out_destroy_deferredclose_wq:
@@ -1950,6 +2002,7 @@ exit_cifs(void)
 #endif
 	cifs_destroy_request_bufs();
 	destroy_mids();
+	cifs_destroy_netfs();
 	cifs_destroy_inodecache();
 	destroy_workqueue(deferredclose_wq);
 	destroy_workqueue(cifsoplockd_wq);
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 13161e0b5cc0..29c9ee2dd304 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -2094,6 +2094,8 @@ extern __u32 cifs_lock_secret;
 extern mempool_t *cifs_sm_req_poolp;
 extern mempool_t *cifs_req_poolp;
 extern mempool_t *cifs_mid_poolp;
+extern mempool_t cifs_io_request_pool;
+extern mempool_t cifs_io_subrequest_pool;
 
 /* Operations for different SMB versions */
 #define SMB1_VERSION_STRING	"1.0"


