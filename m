Return-Path: <linux-kernel+bounces-42649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E4484045B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5820282E10
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960E25FEFE;
	Mon, 29 Jan 2024 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNJ6OpF8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BEB5FDCB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529328; cv=none; b=EenRjo+gdj6uF5EkAeKsYjQrYWZPd5i+60HXXk3GXzDUCKApAgJ0kOij55r0T74q/XJ7+N79Gy0T8vuyo7VnVwyX7klWNU9Gop6G5+r+f8FT1ap5eeTLkl6NZnFpt8seKlXf1flm+VDev7TwU25W+7Ui6zj4cdwxP0BTx0XlLmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529328; c=relaxed/simple;
	bh=8IPI0i4AIUbrhnIiq1QZ8oL6smmFsdTdPo6Or4XKuYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLFLvjXReJrwG/1ph2TK0x0XWp9vleDTNGz6IPgF4nlULOUJbPaZOCLuyZnxpDxo+qmkHCUlsIDmXBV3CLcbdmxWqjbEPkpUwQKphXwB1MHh7Vbsnp/HQpaVH24vh6BJjWgIqm8HXiqfiZgqetsNBU6BPFUMlO/67moVptw9QeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNJ6OpF8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706529326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSmN7QyWcycaQv80GOOzAGn7oioEgCdIaauNWX6x3RI=;
	b=hNJ6OpF8Njs6A+lNUzIVtugcDWUPUHYbz1rXVqt5cIBmq1NU6QDmOp/+9u4nNKhZmgANkv
	Zcu56mukASmSQQy33CEx7VvwFZV2xmcnte4oglTPUcbAknwYoHoL1Kcx03SFR9oCSMf3hf
	GWnm0iJhwX4XfSvQa7u07ooPpAZi4qg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-J2RsO0QYPT-EtJNyg6lBzA-1; Mon, 29 Jan 2024 06:55:22 -0500
X-MC-Unique: J2RsO0QYPT-EtJNyg6lBzA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4919785A58E;
	Mon, 29 Jan 2024 11:55:22 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D36022166B31;
	Mon, 29 Jan 2024 11:55:20 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] 9p: Make better use of netfslib's writethrough caching
Date: Mon, 29 Jan 2024 11:54:36 +0000
Message-ID: <20240129115512.1281624-3-dhowells@redhat.com>
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

netfslib offers the opportunity to do a form of writethrough caching on the
pagecache, whereby netfs_perform_write() will set up and dispatch writes to
the network as it copies data into the cache, falling back to the ordinary
writeback path for the dirty data if this fails.  This is selected if the
user sets O_DSYNC, O_SYNC, RWF_DSYNC or RWF_SYNC or if the filesystem sets
NETFS_ICTX_WRITETHROUGH.

Change v9fs_fid_add_modes() to use this if O_DSYNC is set - and assuming
that CACHE_WRITEBACK is set and V9FS_SYNC is not set.

[?] Does it make sense to add an additional caching mode that uses
    write-through for all non-DIO writes?

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
 fs/9p/fid.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 29281b7c3887..0b25b4c9781d 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -56,8 +56,7 @@ static inline void v9fs_fid_add_modes(struct p9_fid *fid, unsigned int s_flags,
 	   ((fid->qid.version == 0) && !(s_flags & V9FS_IGNORE_QV)) ||
 	   (s_flags & V9FS_DIRECT_IO) || (f_flags & O_DIRECT)) {
 		fid->mode |= P9L_DIRECT; /* no read or write cache */
-	} else if ((!(s_cache & CACHE_WRITEBACK)) ||
-				(f_flags & O_DSYNC) || (s_flags & V9FS_SYNC)) {
+	} else if ((!(s_cache & CACHE_WRITEBACK)) || (s_flags & V9FS_SYNC)) {
 		fid->mode |= P9L_NOWRITECACHE;
 	}
 }


