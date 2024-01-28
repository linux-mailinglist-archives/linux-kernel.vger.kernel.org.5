Return-Path: <linux-kernel+bounces-41798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E8E83F7D1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9986B1C20E77
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0C7137C5E;
	Sun, 28 Jan 2024 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeHUXLag"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB43A136678;
	Sun, 28 Jan 2024 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458550; cv=none; b=LrQ3TgIHcB+yNzQ/vYyZ0xe98JSqAdnx/SR4jnasRvzJrEz5coI2RviDLlCjuHBqo29RRJsh/A3Xc1SmWRG2jJTB9m5tcpciSSBYSvwBK9xSNLwwJK7wDHrxrMl7pjRuarV5RoiXo95HcZo67h/t8hrx5yIEYunu9TGOO2VRU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458550; c=relaxed/simple;
	bh=njYwlIJ4QT+9eleVVuV35hjJf9CZzY+jLpXWSdnaPuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBY4+8RuLuej2LE8IycfhZgjCg6d9STRPbkT3RFPbJjTKVPYQMu1YrDuf+zMWtCJqaIK0rlNeNRZTI+4yymClXlIks2XULnisNeMz6gXdSyX3zTs3B4rNq8wxGQ7hpymXGesNRSws3DcS2epda8d6Pfr4KVdHPb7TSI9c+sOj6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeHUXLag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DACBC433F1;
	Sun, 28 Jan 2024 16:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458550;
	bh=njYwlIJ4QT+9eleVVuV35hjJf9CZzY+jLpXWSdnaPuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SeHUXLagDFzMEIFEktvAOheUG1/+nTt+bi+5L7R1nqh4KdPPoQ04c4veurJnWmER+
	 WM7GZUygm1Lw/rwWWhUJCUJCM/lNIVmiebP/Gf9UEedJP0AOy+StKse3ry+EfL2lWX
	 e4AAcYX6mjwbZUVzcVR4Rvgsmzftxn++EKN3sBUUhVzW0HZm7LSrcsUEAnEjx9D5qT
	 7h4Om9VvcdTbRqTW3CO8v8qZZy5zfmoY7XWOJsozZK77O1rmDUHhZSPN/RaeicEd2i
	 jMBwoavOzIptVVPgx4reOLsCCWvTc2CiTcbTUcvA43UWR9If3XnXKBaecKTyqbLljD
	 y34mYcVFuu3Tg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 16/19] ceph: fix deadlock or deadcode of misusing dget()
Date: Sun, 28 Jan 2024 11:15:13 -0500
Message-ID: <20240128161524.204182-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161524.204182-1-sashal@kernel.org>
References: <20240128161524.204182-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index ca92f2d2f3c7..e4e79392a2df 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4536,12 +4536,14 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
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
@@ -4551,14 +4553,9 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
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


