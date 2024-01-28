Return-Path: <linux-kernel+bounces-41776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F0A83F796
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4A4283114
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E2D86AED;
	Sun, 28 Jan 2024 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiJtax4w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0254C63D;
	Sun, 28 Jan 2024 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458501; cv=none; b=mlmrGz1z1cP+GyFoQPtPq5MKyD/3PdixsbzXyNw+LO20S4rKoFqsscZRiu9MVDbvuQdPrOoRVPMu9rp260hCl+vgaRURxdbYMoKGIM8KQfFAVAFxpe4jAgF9g9aPL3JE8H7vVcSQGqaFYdSfhAbet5ZwlBIbIsv8aFWbLKbYZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458501; c=relaxed/simple;
	bh=fgEoNMAmdzq+GH78n4vSr+hQbXY3niDb03WDMqtRDgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HR/HDnG4DDe/Ge7mKRw/tpBKV9Uq5jeGdqzVPkb+eL73sgZ8MgeK3Xe0p3oHdG4iB8rICbiI6iEZFKWZB6iEH/v9lxvTpI0Rj8Lemc1qvz2Ak4xRM6XHCub4t4GY0NTex0JNE8ihCUJYDF0ziA5X++sP5XulQt1Yc0w/eLYTkFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiJtax4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE5FC43399;
	Sun, 28 Jan 2024 16:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458500;
	bh=fgEoNMAmdzq+GH78n4vSr+hQbXY3niDb03WDMqtRDgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RiJtax4w6tuDEzkEV1v+ESDkfgCp5DX76oOl0Bd9JVblTaQ/Wc1qcdh/C1hakZ577
	 jcfWv2mpfSU50T08ZcB8gKmluiNoWuR+zOEfIi7zmQUSGzCLi8e3Aw7Frzfzsz1Eds
	 T2GDytm0/9DuG9FPxrNsYy+qnycoW08+ZLSoeAjZ5OJtmxQmOXHI1jiToKpeqkU1ep
	 /saPwfEKFYblPcw6eEJAFDeuJ4SnFZFa+qD0fWn3x1ftLaoK985kVQRgzzjHaeuWwR
	 v0k4iqGWPaJTU+cFj/w86JV5I1i6mujmMzc9qesewZYtaKkZn34wKBIuloa8rikKVH
	 V53zSz4VAi7Bg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 21/27] ceph: fix deadlock or deadcode of misusing dget()
Date: Sun, 28 Jan 2024 11:14:06 -0500
Message-ID: <20240128161424.203600-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161424.203600-1-sashal@kernel.org>
References: <20240128161424.203600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.75
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
index 36052a362683..111938a6307e 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4597,12 +4597,14 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
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
@@ -4612,14 +4614,9 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
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


