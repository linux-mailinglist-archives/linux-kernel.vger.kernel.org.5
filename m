Return-Path: <linux-kernel+bounces-101412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D632787A6CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811721F23782
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AD245025;
	Wed, 13 Mar 2024 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqwPM5Ed"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316C42078
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328131; cv=none; b=RNW8BJ84naPr990gd5H6PO4lsLi+N6D4e1wZAgssSnexuTm1PW2OBjh6K3N1lgTo9IXUXgcKRSIEzBXXP9R3F03fKXW31C7ldOzOrqCZkJB2ps8BOg9+joyRJVFZRua9O4JHsVK49E6dXfv0te+qEr/z5UHLKc6wamOWJocZeXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328131; c=relaxed/simple;
	bh=luniAF9OyE9AxjoQ87oukSfN2nAfisuW4QkMcg5MzAo=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=fzQTyO+bGjuKqXXJJx+AdWac16ahGhEec4aSoCJYS+sa34MuIw1j4R0WgNkTicpPwLttVCujvNZKKZY1kIlLngelsgeir1BZYLJVLCP4vSkJbSUjR3KjQSsLmLkJVi1haQNx7K5x7/rjN9ELRxJ/uZL4gDj7cekz0Bh9W5Jslvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqwPM5Ed; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710328128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QTP9uAHVPvXi9wcTkRv8pSjlNhXJ/YsIlYMbNyFLnuo=;
	b=aqwPM5EdJHj5NBqurSJBWazBJosJNG3OBBLQqFLiz+cadqb0HxfcgH/1C5qCTa5l9alXtn
	/lvRx6nkLRRms5npr/uUnDQVsOLHm4+jRW5DyCk5tn6s2TBmS2FZ6LnW7IRViHV0ZlR+QY
	4m24C0NXdrHMBZigIHRFzQ7u03thL3o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-6Zq0fiNLPpuMq8oycQT-rA-1; Wed, 13 Mar 2024 07:08:43 -0400
X-MC-Unique: 6Zq0fiNLPpuMq8oycQT-rA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2579487280B;
	Wed, 13 Mar 2024 11:08:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2D2DB492BC7;
	Wed, 13 Mar 2024 11:08:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>,
    Markus Suvanto <markus.suvanto@gmail.com>
cc: dhowells@redhat.com, Jeffrey Altman <jaltman@auristor.com>,
    Christian Brauner <brauner@kernel.org>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Revert "afs: Hide silly-rename files from userspace"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3085694.1710328121.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Mar 2024 11:08:41 +0000
Message-ID: <3085695.1710328121@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

    =

This reverts commit 57e9d49c54528c49b8bffe6d99d782ea051ea534.

This undoes the hiding of .__afsXXXX silly-rename files.  The problem with
hiding them is that rm can't then manually delete them.

This also reverts commit 5f7a07646655fb4108da527565dcdc80124b14c4 ("afs: F=
ix
endless loop in directory parsing") as that's a bugfix for the above.

Fixes: 57e9d49c5452 ("afs: Hide silly-rename files from userspace")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Link: https://lists.infradead.org/pipermail/linux-afs/2024-February/008102=
html
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dir.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 8a67fc427e74..67afe68972d5 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -474,16 +474,6 @@ static int afs_dir_iterate_block(struct afs_vnode *dv=
node,
 			continue;
 		}
 =

-		/* Don't expose silly rename entries to userspace. */
-		if (nlen > 6 &&
-		    dire->u.name[0] =3D=3D '.' &&
-		    ctx->actor !=3D afs_lookup_filldir &&
-		    ctx->actor !=3D afs_lookup_one_filldir &&
-		    memcmp(dire->u.name, ".__afs", 6) =3D=3D 0) {
-			ctx->pos =3D blkoff + next * sizeof(union afs_xdr_dirent);
-			continue;
-		}
-
 		/* found the next entry */
 		if (!dir_emit(ctx, dire->u.name, nlen,
 			      ntohl(dire->u.vnode),


