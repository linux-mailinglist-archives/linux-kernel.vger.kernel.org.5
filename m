Return-Path: <linux-kernel+bounces-41745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B621783F742
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1FD1F21748
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9B2657D0;
	Sun, 28 Jan 2024 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSctNSKj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B115657AE;
	Sun, 28 Jan 2024 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458436; cv=none; b=YDCwEXFErGg65xzEFAweiQ7tVzrSZwjdZNWhQXipfRvgdBSraTpMPsFQ7ig32t4X90SjdKwyN1lLqshInx0lqLam8XcF+0H3N2KTv5V/fEgPrOIBuuC2P8mGvRKTDdlb6/f9btLNb63MkIQ1NmRCdQRqm7Wg3KLqFU2j8bcdBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458436; c=relaxed/simple;
	bh=BB0Z5xCGeLFstbYtpPvPo/T5EjNZ/WwcZ0MPokWWJdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyrfHbccVRNK7tnkCjZr+k3XFR9DR8fOEre3b9eBt620RBpCrf4e5vTeMMtNW+TJO/SIFI3yFenZzjJz3GS6cDUyghHJiGoOar03EzyTNYQLvucepah/WmUcf/A2OI2iStFBe47RzU4F8obLc0C4k3pjj5qr5obTHKV1kAK2lbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSctNSKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE87C433C7;
	Sun, 28 Jan 2024 16:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458435;
	bh=BB0Z5xCGeLFstbYtpPvPo/T5EjNZ/WwcZ0MPokWWJdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uSctNSKjjrTnw3XZ0qO0tbBsbNSqRWGk0tw4bErdtNVfBBIEKuj9Uke/2sg9VS1TI
	 Zio9wTKbhgWfsXZpcB9T6/yP2Cxv7xX8Uth58t8cmnvG3UhfKL3jdJlmfO9T2uutHX
	 jw7f7aPhy0f3doTLv3k9ZqWJP/oR7JOdsc0NOjiDDDRqIzf5eUdkRy1AvX+5EkonXX
	 YtQiNgetkoxrnsJA2PMGIXP16dRAzWXyT57P0VscZWEn+FNlHRqkl5Yo3UkeLrZpJk
	 1E9rTmR5POoUKaUYbCIQ91lm/I9+bSKcNbDXgo1QvcAsn7cpbleCCREDmbqw03JlC/
	 fHdnBHLhqoVFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 24/31] ceph: fix deadlock or deadcode of misusing dget()
Date: Sun, 28 Jan 2024 11:12:54 -0500
Message-ID: <20240128161315.201999-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161315.201999-1-sashal@kernel.org>
References: <20240128161315.201999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
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
index 14215ec646f7..7f7e5f5d643c 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4780,12 +4780,14 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
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
@@ -4795,14 +4797,9 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
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


