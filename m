Return-Path: <linux-kernel+bounces-87637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FA386D6CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF0B1F24752
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE5E74C0F;
	Thu, 29 Feb 2024 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZI0yr/Up"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A33E74BEC
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245469; cv=none; b=DJdUmDiGF0kNND/2i3YjArhrV1IRprYncpnhxedRbuk2VGmm2yo5ENGsXTzodUk1K4GO2UZsKEFebj3xw5ELmYTWvPhO06g+S967X4VETHxULV4SD+Al6wewLnFCIy+eQFE3zMyTUdQ2Wjm1NKyFPXtinSd6m+q8zCmDZCMo40A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245469; c=relaxed/simple;
	bh=A78cnYeT5c8A7dqzL5kDfZeFAAc9jJVdn7MAkGWqX00=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=Wn3hOfX3FeEkDZbQjb4/15xOqm/83/xqyy5yDI1Lzwu/DjJ+np3ACL3yWqI/CYufObfrfgbjf50nCYQv/SUngkZkhvTmJ5i3wsK4JpgkuZ89lLLF/OnFevKS90SJAHTdytFMg91LJ7/2cjSHgir/AXPLmfmtOXaXpS1XZRrWOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZI0yr/Up; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709245466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fH53wpixgZdMNHSX3Pn8Num8rbA2ozCUf7uf0bZJ4JU=;
	b=ZI0yr/UpZr3qtRuHkllnyyQ9ptWA1+2fq+OoR7mTvbtClvp08Kp5h9Z1Ez/XYnKhKER2KK
	Mj6eMTBpNlLVWmlpFT7dcRiYTZ/eUhhcVLRgmjfo1DTm2f9OXHmvaN6IVNaxbtfqzK6g/t
	BevHDfpw9AEbydHG4vl2qd90Nbu23Mg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-iFyMGc5FMDSQ3ZiDnqT9xw-1; Thu, 29 Feb 2024 17:24:23 -0500
X-MC-Unique: iFyMGc5FMDSQ3ZiDnqT9xw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B77B088F4C7;
	Thu, 29 Feb 2024 22:24:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1C7EC492BC6;
	Thu, 29 Feb 2024 22:24:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix occasional rmdir-then-VNOVNODE with generic/011
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <196424.1709245455.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Feb 2024 22:24:15 +0000
Message-ID: <196425.1709245455@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Sometimes generic/011 causes kafs to follow up an FS.RemoveDir RPC call by
spending around a second sending a slew of FS.FetchStatus RPC calls to the
directory just deleted that then abort with VNOVNODE, indicating deletion
of the target directory.

This seems to stem from userspace attempting to stat the directory or
something in it:

    afs_select_fileserver+0x46d/0xaa2
    afs_wait_for_operation+0x12/0x17e
    afs_fetch_status+0x56/0x75
    afs_validate+0xfb/0x240
    afs_permission+0xef/0x1b0
    inode_permission+0x90/0x139
    link_path_walk.part.0.constprop.0+0x6f/0x2f0
    path_lookupat+0x4c/0xfa
    filename_lookup+0x63/0xd7
    vfs_statx+0x62/0x13f
    vfs_fstatat+0x72/0x8a

The issue appears to be that afs_dir_remove_subdir() marks the callback
promise as being cancelled by setting the expiry time to AFS_NO_CB_PROMISE
- which then confuses afs_validate() which sends the FetchStatus to try an=
d
get a new one before it checks for the AFS_VNODE_DELETED flag which
indicates that we know the directory got deleted.

Fix this by moving the AFS_VNODE_DELETED check up above the expiration
check, and even above the locking.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/validation.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/afs/validation.c b/fs/afs/validation.c
index 46b37f2cce7d..850f5287107d 100644
--- a/fs/afs/validation.c
+++ b/fs/afs/validation.c
@@ -391,6 +391,11 @@ int afs_validate(struct afs_vnode *vnode, struct key =
*key)
 	if (afs_check_validity(vnode))
 		return 0;
 =

+	if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
+		_debug("file already deleted");
+		return -ESTALE;
+	}
+
 	ret =3D down_write_killable(&vnode->validate_lock);
 	if (ret < 0)
 		goto error;
@@ -448,12 +453,6 @@ int afs_validate(struct afs_vnode *vnode, struct key =
*key)
 	vnode->cb_ro_snapshot =3D cb_ro_snapshot;
 	vnode->cb_scrub =3D cb_scrub;
 =

-	if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
-		_debug("file already deleted");
-		ret =3D -ESTALE;
-		goto error_unlock;
-	}
-
 	/* if the vnode's data version number changed then its contents are
 	 * different */
 	zap |=3D test_and_clear_bit(AFS_VNODE_ZAP_DATA, &vnode->flags);


