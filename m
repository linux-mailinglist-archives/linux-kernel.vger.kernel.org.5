Return-Path: <linux-kernel+bounces-41714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF1483F6EB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00A40B20BC6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554D556474;
	Sun, 28 Jan 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lK1g+hyl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9321056454;
	Sun, 28 Jan 2024 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458362; cv=none; b=s4DieHyYxp1/ZirbXGh6a6WdxuX1JsvVYxhXWvfGkVlWwNKzmCXOfyhojlyPl3JGDmYVgBQrkM07jS7PedJi8KgPUpDoMY1qqJqlkeMmshgyLC+qOB/g7zrkNeablPqqIFSlGmZ6AZTbj1QhouHvLvGCZPxbWn5ebMpiSdlMX7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458362; c=relaxed/simple;
	bh=jRuelF6orccHsBwwAdGxa2vDDoeavvFfxMPnSe9WWQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/wJjJzNE41YucmJ2eSZ3YtsCm+iXsdmwFh4HsOai0ZVJquAswGga5gKLBzHFX/zB0SIs4nDtDZF/sRbVml+Hzq6ZP9rpCBd4zuG28PWX37aK4w9tvxLwGJbtWTpo6urVvRUokHWgizvlyLbznO4AM2u3XEU3Z2sWxUuthxTufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lK1g+hyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851D9C43390;
	Sun, 28 Jan 2024 16:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458362;
	bh=jRuelF6orccHsBwwAdGxa2vDDoeavvFfxMPnSe9WWQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lK1g+hyltIahJYmjwKinayXWL8TO5yKcGZY7WtcceAWUwHrbi9JCPKec+Eb0OoRGp
	 B4vBzxscCSwnLeiKs5M83QNq80ul/e8+7mOP21hapB+UK7vcFDMCbIRq5EbeF4As+j
	 wqPciZw+rlJxl0+gtYe4iezzZN+PTxZnYeyPtyLD2vETeohU+Al4OUfmkJ7dxU3xEc
	 W8JA+8+1c9cx5eoSoRBB+ocn8DmscozXzjfjk3kDR6Ad+K7I4EUtNgkGHXkI3yXJbx
	 tS0wnnHLRG0u1na0QWLNtH14zUZl1K/hQZG/Yo9FkNeBDajXwFl6+sqLPkgwdJcuFH
	 5M+LmbJCo15Pg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 32/39] ceph: fix deadlock or deadcode of misusing dget()
Date: Sun, 28 Jan 2024 11:10:52 -0500
Message-ID: <20240128161130.200783-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
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
index 2c0b8dc3dd0d..9c02f328c966 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4887,13 +4887,15 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 			       struct inode *dir,
 			       int mds, int drop, int unless)
 {
-	struct dentry *parent = NULL;
 	struct ceph_mds_request_release *rel = *p;
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	struct ceph_client *cl;
 	int force = 0;
 	int ret;
 
+	/* This shouldn't happen */
+	BUG_ON(!dir);
+
 	/*
 	 * force an record for the directory caps if we have a dentry lease.
 	 * this is racy (can't take i_ceph_lock and d_lock together), but it
@@ -4903,14 +4905,9 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
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
 
 	cl = ceph_inode_to_client(dir);
 	spin_lock(&dentry->d_lock);
-- 
2.43.0


