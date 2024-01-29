Return-Path: <linux-kernel+bounces-42650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E431884045F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223061C21A11
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8D1605DD;
	Mon, 29 Jan 2024 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoQLYHBC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C916604C4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529334; cv=none; b=NsGbXIbXT/7vXDXOmTDPQsJ5JqI4oUY5GZjPqTTB9AM/cQJJwi4rncfGpwSGdycRh2wwT+vc1kaOaJ2jeveXF43hEzGzuKsR2rRxd3foQBD+qg4pReYi0JuYoXmauXMyKPQ7ycZFUr7BbTpd6TAiy26nJooOdZvNevre5nRITbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529334; c=relaxed/simple;
	bh=1byjLmjT6ZOpcnDHKbSQxLlzmYce9B40FvFh6bkgVOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mguKpIacKRlNSO5xVpslsfQzOughJQlMZ0kZ/OS/TQkNzGbqCkV4OHz2EIY+si23isTCk+FXAWEnNjfWQpBlu8EjE3t1BoBjVglhtImhdBQrL6kQcwdq/0a8tojInDpt0U/2+1tFpIRl8AqZjK7eMBao5FMYMeUY1OyrltnMw00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PoQLYHBC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706529328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/klC/ghutWIOc1+EVzXLrxXcGHqt0/sieVr6S5RVKE=;
	b=PoQLYHBCBwd7orH+JsGCpdf27fqQp8Wm9CKFvAKkbC2ggvoPAK/oemBi5pdtEJ2evyukQD
	yMEE9C+71o+fNc9LHhHwmB8sHdRkvwwprRsRsLxo1ng6d5vaHVSVveHNqB4PHLB6qSLFef
	D0eXgMr/fC/IAnXkNYhmSJKabztPi1M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-d1lzjPdMMbCmhQXLAPqJfA-1; Mon, 29 Jan 2024 06:55:25 -0500
X-MC-Unique: d1lzjPdMMbCmhQXLAPqJfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADC73185A782;
	Mon, 29 Jan 2024 11:55:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 013882166B31;
	Mon, 29 Jan 2024 11:55:22 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Latchesar Ionkov <lucho@ionkov.net>
Cc: David Howells <dhowells@redhat.com>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <christian@brauner.io>,
	netfs@lists.linux.dev,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cachefs@redhat.com
Subject: [RFC PATCH 3/3] 9p: Always update remote_i_size in stat2inode
Date: Mon, 29 Jan 2024 11:54:37 +0000
Message-ID: <20240129115512.1281624-4-dhowells@redhat.com>
In-Reply-To: <20240129115512.1281624-1-dhowells@redhat.com>
References: <20240129115512.1281624-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Always update remote_i_size in v9fs_stat2inode*() if the size is available,
even if we are asked not to update i_isize

Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
Link: https://lore.kernel.org/r/ZZVctju5TEjS218p@codewreck.org/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_inode_dotl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 3505227e1704..aa3a77bb5e86 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -684,10 +684,10 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
 			mode |= inode->i_mode & ~S_IALLUGO;
 			inode->i_mode = mode;
 		}
-		if (!(flags & V9FS_STAT2INODE_KEEP_ISIZE) &&
-		    stat->st_result_mask & P9_STATS_SIZE) {
+		if (stat->st_result_mask & P9_STATS_SIZE) {
 			v9inode->netfs.remote_i_size = stat->st_size;
-			v9fs_i_size_write(inode, stat->st_size);
+			if (!(flags & V9FS_STAT2INODE_KEEP_ISIZE))
+				v9fs_i_size_write(inode, stat->st_size);
 		}
 		if (stat->st_result_mask & P9_STATS_BLOCKS)
 			inode->i_blocks = stat->st_blocks;


