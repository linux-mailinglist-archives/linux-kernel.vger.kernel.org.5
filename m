Return-Path: <linux-kernel+bounces-41824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0717383F81C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B341C226CA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F9714691E;
	Sun, 28 Jan 2024 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zewjo0rj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A82146901;
	Sun, 28 Jan 2024 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458615; cv=none; b=rDolzuA5s9tpZDq6ahtIiPWPvi+dfI3GeHmjI2TTQllIDMOgWFqDDevlZCryHVzcCseGIGl8EW3ENz6J3iG8lR6ixokuUNZapp3Qpve+HaHlAH5WMBlmUSMCu0RPDxHfXD3xuj0QTTHaSE7wlsgMHTXAx1bNfpyIY7n87ErSl2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458615; c=relaxed/simple;
	bh=+7lTP5uTbjLdLjS8zddCHsem+QvSmGZ8iv7dh5FS9fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moJ0SWIqP90Qu7o621WP0UhIoNulQGkb0oZTx7Nfauo0FWV0+kWkL6zXIt47BVP4rbVOQ8cvGxOYUkt3C1Rqp60Bh7OC+RFvwxEQrSg0vjRAjw+9fGZwsMWp3NYiCsQGm+MVS/9AGYXyqitDl6iNhzfUvGVxiMZXu7rW+WZ7SFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zewjo0rj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CC7C433B1;
	Sun, 28 Jan 2024 16:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458614;
	bh=+7lTP5uTbjLdLjS8zddCHsem+QvSmGZ8iv7dh5FS9fU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zewjo0rjnRoHAKTWy/2yETyui5BlFHQjV9w2BLkqpRJXH101pkP4OYdeBe4AUOwZG
	 tE2BcZf3Ijq2DezHalf2WXgpwRxBaui5lOSwLNHwO7yWzTHg0MILg5xrPsqO3XKEIV
	 sqWsmZmfEU67tz4hy+yZbR7QzpiO3m+SUsA1ImzR9DyuLmq5duNXUJqdmDGW0cQyFS
	 nV7NDA5ZIGWphZ1jZROItUPFuy/GJw6kGHT0YpY6hyDz2lG/iMoBVdIVaPXys0rK4e
	 goZKDPuX4xFOhtCIjMJX/agWsN8EnPb5Y+dOKILIjiLLBUBp034OW4WO8rXTnhkqkh
	 1oW8gOT4FGJWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 10/11] ceph: fix deadlock or deadcode of misusing dget()
Date: Sun, 28 Jan 2024 11:16:31 -0500
Message-ID: <20240128161637.205509-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161637.205509-1-sashal@kernel.org>
References: <20240128161637.205509-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
Content-Transfer-Encoding: 8bit

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit b493ad718b1f0357394d2cdecbf00a44a36fa085 ]

The lock order is incorrect between denty and its parent, we should
always make sure that the parent get the lock first.

But since this deadcode is never used and the parent dir will always
be set from the callers, let's just remove it.

Link: https://lore.kernel.org/r/20231116081919.GZ1957730@ZenIV
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/caps.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 4e88cb990723..45b8f6741f8d 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4304,12 +4304,14 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 			       struct inode *dir,
 			       int mds, int drop, int unless)
 {
-	struct dentry *parent = NULL;
 	struct ceph_mds_request_release *rel = *p;
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	int force = 0;
 	int ret;
 
+	/* This shouldn't happen */
+	BUG_ON(!dir);
+
 	/*
 	 * force an record for the directory caps if we have a dentry lease.
 	 * this is racy (can't take i_ceph_lock and d_lock together), but it
@@ -4319,14 +4321,9 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 	spin_lock(&dentry->d_lock);
 	if (di->lease_session && di->lease_session->s_mds == mds)
 		force = 1;
-	if (!dir) {
-		parent = dget(dentry->d_parent);
-		dir = d_inode(parent);
-	}
 	spin_unlock(&dentry->d_lock);
 
 	ret = ceph_encode_inode_release(p, dir, mds, drop, unless, force);
-	dput(parent);
 
 	spin_lock(&dentry->d_lock);
 	if (ret && di->lease_session && di->lease_session->s_mds == mds) {
-- 
2.43.0


