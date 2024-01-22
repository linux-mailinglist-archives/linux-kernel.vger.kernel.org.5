Return-Path: <linux-kernel+bounces-34247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EEA837650
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2933B24AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA0C4BABA;
	Mon, 22 Jan 2024 22:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFtr8aQN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9524BA88
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705962783; cv=none; b=ukXEQwqYlF88AOi9t9YvMUf5fv2DPvjwyxtiW3IySsY7wLU7m6M9TC58+qfCK964rAo05hs8qXYXfMqruvneRw84k+3XoDgtCgc7rKnf9yW9hYFW/Ud08rN+PZBgKmnlkd+jUi75onjiIB9WI0CTme4fvTAmno9Ek3jA82fmVa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705962783; c=relaxed/simple;
	bh=6H3U2xFlfhw33p6fngsaEo/JwWggI7/BGAeipSgCLFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deZKjaETmRWGFmPu9VzX2+fqFgQ+AudTlxQIE+3PoHv8K1VMxc19DquW5B6IbMjJf3kqIQSbKVfrZOuDMkuBObfZsSu4fh6juqSy/nNfWovZI36SqJB37MTgTTL3UYeQk4Z8HrcNkf0IAZlH0nlDB0qqVNRfxC6F/IXUHTm8O2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFtr8aQN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705962779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQmuqxaeIGZelSODTss8gWd4P9SrQf4vDlsO0SnTpdE=;
	b=HFtr8aQNrEW4Uv4Kckk8BJeFDYH84J8zfuAo0/XBqOfOe7zsG801VnYjA92AZj8lekOblc
	3vrqRm8NAtJU+WJAHmqz5sHo94rPb4JkFgIDj8MZeyuBYow2GXsn+uHOr+OZ0WAueBfO5p
	NZ+MglXINlp6yvjtsjrK72uETJ7B+dA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-I213UdhrNQ-UHiAkjXvHRQ-1; Mon, 22 Jan 2024 17:32:54 -0500
X-MC-Unique: I213UdhrNQ-UHiAkjXvHRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4F7980007C;
	Mon, 22 Jan 2024 22:32:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D97A93C2E;
	Mon, 22 Jan 2024 22:32:51 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH v2 07/10] afs: Hide silly-rename files from userspace
Date: Mon, 22 Jan 2024 22:32:20 +0000
Message-ID: <20240122223230.4000595-8-dhowells@redhat.com>
In-Reply-To: <20240122223230.4000595-1-dhowells@redhat.com>
References: <20240122223230.4000595-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

There appears to be a race between silly-rename files being created/removed
and various userspace tools iterating over the contents of a directory,
leading to such errors as:

	find: './kernel/.tmp_cpio_dir/include/dt-bindings/reset/.__afs2080': No such file or directory
	tar: ./include/linux/greybus/.__afs3C95: File removed before we read it

when building a kernel.

Fix afs_readdir() so that it doesn't return .__afsXXXX silly-rename files
to userspace.  This doesn't stop them being looked up directly by name as
we need to be able to look them up from within the kernel as part of the
silly-rename algorithm.

Fixes: 79ddbfa500b3 ("afs: Implement sillyrename for unlink and rename")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dir.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 3f73d61f7c8a..eface67ccc06 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -474,6 +474,14 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 			continue;
 		}
 
+		/* Don't expose silly rename entries to userspace. */
+		if (nlen > 6 &&
+		    dire->u.name[0] == '.' &&
+		    ctx->actor != afs_lookup_filldir &&
+		    ctx->actor != afs_lookup_one_filldir &&
+		    memcmp(dire->u.name, ".__afs", 6) == 0)
+			continue;
+
 		/* found the next entry */
 		if (!dir_emit(ctx, dire->u.name, nlen,
 			      ntohl(dire->u.vnode),


