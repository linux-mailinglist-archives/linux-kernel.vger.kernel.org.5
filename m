Return-Path: <linux-kernel+bounces-41832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B65283F832
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479CF28AF0B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577FA1487E7;
	Sun, 28 Jan 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKQ+qqTC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E30149018;
	Sun, 28 Jan 2024 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458637; cv=none; b=tWdGDs6benhWgVys09ORDKTzofH1K5GAxj/iNGJl/FpzZPSJg4TxGnODRGp8yKIKliIYNikcIoo88EOVdoFP5/JOnykEk/7jHgE72iPsy9VkGH4clZB5mS2OWyD5DEX0KHX4jsJco3Z/Ptt52eAO98Soc2OYaCjYFnN/78nr0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458637; c=relaxed/simple;
	bh=z8WOhSuMuU4xQk9PPWESuzexZQYbDH3KPotX49Jz+bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHehs70HKtKXSDOMLOdQy1SBOxy0MroCOXD8BwRNS9JqpMwcp+SLTkk8dtUaPAArhpSBAvUO3pj2FWNVMlyMGz0sXZjGT3lBd43t7jrovDvbs7XnB5zyaydIVaNaHrGcAOtBJVsHGr2v1s/CzP2zicw4Fu5k7kwujML07vIkxhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKQ+qqTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0FBC433F1;
	Sun, 28 Jan 2024 16:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458637;
	bh=z8WOhSuMuU4xQk9PPWESuzexZQYbDH3KPotX49Jz+bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKQ+qqTCcOyXq2d1ttWooJncTMOfhCoxfgsEuGof5X+rmaHmnP2NCB+1pr3jiSAE5
	 JbvrVMene/6SWgjHZzcR+0qQKn0USpEkvQ7Sm2tVyQNvZyWSHK/1zzSfUSmi5uOVtM
	 w0HomKxGRhNT8xgQwkqU6BFN2iBt9zg3LvGcLsAb8J1QWSg9qrbRnXa/Bk1ZedU7h2
	 GKoRnE3ufecDUdjg9dmfH+2LWMU9bRUFJE0l6JxskTEbAbufZ5sRuqiFyibIhvUIUT
	 qZPFffb0NcbnDmQBE2TQGERP3a5bQqLOeBQ8cPMXRp29FFn4UCOsBzNSvbixnCNF69
	 xWzb0ERjg2ZRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 7/8] ceph: fix deadlock or deadcode of misusing dget()
Date: Sun, 28 Jan 2024 11:16:58 -0500
Message-ID: <20240128161704.205756-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161704.205756-1-sashal@kernel.org>
References: <20240128161704.205756-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.306
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
index fcfba2af5f98..729a67700a4f 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4216,12 +4216,14 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
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
@@ -4231,14 +4233,9 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
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


