Return-Path: <linux-kernel+bounces-113494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7298884C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DF31C241AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D351B8FAE;
	Sun, 24 Mar 2024 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2BdbIlP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0DB1B885F;
	Sun, 24 Mar 2024 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320296; cv=none; b=k/Y8UeaaX6yJaBcFu134+7jB8w5ZMlwBS3EiLFmbV5gl7Vsv95wtxzM2an56918T5EiQ1X66MRbMfO03LLvHLNfpUK0mc/3Rxr7x5o0XgPIF5LYKm3Gesl07QlU7Uiz7bpkFZt67Mm3oXHRZdK4F5LE84yhEInRLSmdd33ikPlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320296; c=relaxed/simple;
	bh=67eAQKcAC4gVWRQlrJDdEVJNqMFb1SeOyoS/9NlUAbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPx4zBfN8SiVlubu32pDlCKPQS0pZXRfodylZ+WmDCKBPVzqeD8LeIvn/iYzYg/DNjauPGY3NL1YRwh+eDyidTQiEDqz8oQmakLByAAxMiq8wgMfVev6W/lj5CbsNxAhJTTPf3K2TEIBtOimDJmLY+27jMqmkDUzW/K2+gGlOHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2BdbIlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CCDC433F1;
	Sun, 24 Mar 2024 22:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320295;
	bh=67eAQKcAC4gVWRQlrJDdEVJNqMFb1SeOyoS/9NlUAbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K2BdbIlPI1L21da7cZCB2e0j3uEhXUS/oYJaeygzU5gpuBT9Z5sgDL3fyb8FT1NCe
	 Q4OS5QDdUj0jmujLeerFsEteyRrkgF4XcXBxZr9zsbHXJXBf5aOTqLN6wwALY0988U
	 7wfPnYnDdfpPJ73jMQ7DUOgNVaNHAR6dbw4TFF5c1Iu3B5Rjuvf6Gr7dFRxjwDO5Sw
	 BiJZ6cvmYTAaU//ADd3op18rzT+FHwMXDfR5lntmSTEVOR0/bfajxRnkQNHAt72m1S
	 A5XCWddQubALUOq+c54/OAHYezlC+fxCtxj4m6k7jv1UvKEENl6M0Js/GujTiB5PjF
	 i6qivxrAZeV8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 603/715] afs: Fix occasional rmdir-then-VNOVNODE with generic/011
Date: Sun, 24 Mar 2024 18:33:02 -0400
Message-ID: <20240324223455.1342824-604-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit b74c02a37987d3ea755f96119c527f5e91950592 ]

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
- which then confuses afs_validate() which sends the FetchStatus to try and
get a new one before it checks for the AFS_VNODE_DELETED flag which
indicates that we know the directory got deleted.

Fix this by:

 (1) Make afs_check_validity() return true if AFS_VNODE_DELETED is set, and
     then tweak the return from afs_validate() if the DELETED flag is set.

 (2) Move the AFS_VNODE_DELETED check in afs_validate() up above the
     expiration check to immediately after we've grabbed the validate_lock.

Fixes: 453924de6212 ("afs: Overhaul invalidation handling to better support RO volumes")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20240313081505.3060173-3-dhowells@redhat.com
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/validation.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/afs/validation.c b/fs/afs/validation.c
index 46b37f2cce7d9..32a53fc8dfb26 100644
--- a/fs/afs/validation.c
+++ b/fs/afs/validation.c
@@ -122,6 +122,9 @@ bool afs_check_validity(const struct afs_vnode *vnode)
 	const struct afs_volume *volume = vnode->volume;
 	time64_t deadline = ktime_get_real_seconds() + 10;
 
+	if (test_bit(AFS_VNODE_DELETED, &vnode->flags))
+		return true;
+
 	if (atomic_read(&volume->cb_v_check) != atomic_read(&volume->cb_v_break) ||
 	    atomic64_read(&vnode->cb_expires_at)  <= deadline ||
 	    volume->cb_expires_at <= deadline ||
@@ -389,12 +392,17 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 	       key_serial(key));
 
 	if (afs_check_validity(vnode))
-		return 0;
+		return test_bit(AFS_VNODE_DELETED, &vnode->flags) ? -ESTALE : 0;
 
 	ret = down_write_killable(&vnode->validate_lock);
 	if (ret < 0)
 		goto error;
 
+	if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
+		ret = -ESTALE;
+		goto error_unlock;
+	}
+
 	/* Validate a volume after the v_break has changed or the volume
 	 * callback expired.  We only want to do this once per volume per
 	 * v_break change.  The actual work will be done when parsing the
@@ -448,12 +456,6 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 	vnode->cb_ro_snapshot = cb_ro_snapshot;
 	vnode->cb_scrub = cb_scrub;
 
-	if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
-		_debug("file already deleted");
-		ret = -ESTALE;
-		goto error_unlock;
-	}
-
 	/* if the vnode's data version number changed then its contents are
 	 * different */
 	zap |= test_and_clear_bit(AFS_VNODE_ZAP_DATA, &vnode->flags);
-- 
2.43.0


