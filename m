Return-Path: <linux-kernel+bounces-25062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E1F82C719
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0093F1F2171B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA56D17731;
	Fri, 12 Jan 2024 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLYWGKbK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A61017727
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705097953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+ymLRP9JILIvekC5MUVhC7iuVNk/iKgeY3xqk9V2RCk=;
	b=eLYWGKbKad0kJFbalXeaKiQxkIEQ9DbfVe1Bx+MhdbVO0cyl7fnjPV38H35sJVOsj/bf0q
	6834hwdH8Vf9yfUHhHEH7pO4BGpQCEvGwGIsUjnwnS8V3Ydr8/ITx2R1rzDlXtJY3P5L5m
	km/XRE6YmgMLlgZGUM4iKi8AuH/uwcY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-RNbbXOKHNB-wLojw4WRUbw-1; Fri,
 12 Jan 2024 17:19:10 -0500
X-MC-Unique: RNbbXOKHNB-wLojw4WRUbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EB103C1E9D6;
	Fri, 12 Jan 2024 22:19:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 647672166B31;
	Fri, 12 Jan 2024 22:19:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Remove afs_dynroot_d_revalidate() as it is redundant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2387316.1705097947.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jan 2024 22:19:07 +0000
Message-ID: <2387317.1705097947@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Remove afs_dynroot_d_revalidate() as it is redundant as all it does is
return 1 and the caller assumes that if the op is not given.

Suggested-by: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/dynroot.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 2cd40ba601f1..814c65f54d6e 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -258,16 +258,7 @@ const struct inode_operations afs_dynroot_inode_opera=
tions =3D {
 	.lookup		=3D afs_dynroot_lookup,
 };
 =

-/*
- * Dirs in the dynamic root don't need revalidation.
- */
-static int afs_dynroot_d_revalidate(struct dentry *dentry, unsigned int f=
lags)
-{
-	return 1;
-}
-
 const struct dentry_operations afs_dynroot_dentry_operations =3D {
-	.d_revalidate	=3D afs_dynroot_d_revalidate,
 	.d_delete	=3D always_delete_dentry,
 	.d_release	=3D afs_d_release,
 	.d_automount	=3D afs_d_automount,


