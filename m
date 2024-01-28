Return-Path: <linux-kernel+bounces-41812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA0E83F7F9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2BD1F2174C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF7414078D;
	Sun, 28 Jan 2024 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKGKGMYr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC81140772;
	Sun, 28 Jan 2024 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458585; cv=none; b=pEfOy5wa5C/3EnQ706FWTashZpbtX1shkEowlg55X8jsh0riwpdjFNlGtAi/1346YLBD6p8nYzgR4PZilIeYSUIJ7qDcRproNV8/IA3DK4UTylfaQq5xiP6+8u+wESvZAq2fyM2sZg/L4vi/ZjDBJ0mjj/S4mbKwPQ54ZzR1Mc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458585; c=relaxed/simple;
	bh=0uqaAEoUBXvtPd09R+cUONJc0/oE9cPVbBmEZYd20Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvE0Zs4ldSF6pgQIAhC9lgxJxMN0RJAqjhYSGlrvJBCAhSoalBGaInd58lIzyQDL5w2kmrQ/No3cQmFg4aG3wtKOGXEPQoCHyjNRthdJl5gm+THKL4nv7mrWwUJPj8+5XUGh2mFxtCTxk1rfbq1t8eSYOGPWmXItTTefb9JKq/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKGKGMYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A54C43390;
	Sun, 28 Jan 2024 16:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458585;
	bh=0uqaAEoUBXvtPd09R+cUONJc0/oE9cPVbBmEZYd20Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RKGKGMYrq7GZVwM/oFUGZMjONrGesXD9jiyXr96rL/Wjmgql4EQis1m3g53hwVg8x
	 odmc49IEOn8dfEQLTTJPKH9Lr78aaw/PeRRr7og46f7o8FTRvTgiy2vW9/HdfwjLdN
	 v1Z7XoFQ40eHNiXYz3NEh9kLcqKK0JwuF0G/nhs5JdC0dWdmQU9soqFZ1LTBEqSY+d
	 hwSWSPZd6YQmLom6bMPh1j2iydqZrp9I0OJMz0xodCV5DNgJvghtyHktXEcDv7pQN9
	 Q1h0DnAKqcmIQ4oQPFJPZtxBRVbuvLnhful7Wp0yDUpNQ1TWqxPssJGWfq3TrM/uN5
	 kWnafmZO/bajw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 11/13] ceph: fix deadlock or deadcode of misusing dget()
Date: Sun, 28 Jan 2024 11:15:57 -0500
Message-ID: <20240128161606.205221-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161606.205221-1-sashal@kernel.org>
References: <20240128161606.205221-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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
index 432dc2a16e28..b0cf79b0dc49 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4598,12 +4598,14 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
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
@@ -4613,14 +4615,9 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
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


