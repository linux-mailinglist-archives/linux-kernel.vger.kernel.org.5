Return-Path: <linux-kernel+bounces-114489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E8188902A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA31291402
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26C31448D3;
	Sun, 24 Mar 2024 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBj6l8+m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41214BFAB;
	Sun, 24 Mar 2024 23:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321935; cv=none; b=ExOxUoruy4k/9gQL/z0s+HRngqY6xzPlxq52DnzBDS6BzT3a9a+A9xNzZgJZgozVInHnvQqPQqoOCzInwH2JlavoCPb8Tcx5hUoUqV3IlYrh328KkbFr0UpfdhoKn+LweOAUXMuhx7YCpKGR5vTez3+YtbPOeh8kuvss5MXx4dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321935; c=relaxed/simple;
	bh=xSqm5hpmn8rjHUNVgUnpokBBF5ulUyrDbH02AuxPdn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpZXrSE1JaMNYZR2M47Cw/kjWPLonpRx1EUzgTMIFDXbHONl9CshZcCdvITVsyGcvhMyNmQg3P9MMy69VQ3hzwnSr6HZ0c2Li2wGFCJktcYzOIxx2KXgUtp6FOG0lhv+q+C2zZaGnGIinzOQwnwfktQIpEdQMzgYyDc92pHh/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBj6l8+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6993C43390;
	Sun, 24 Mar 2024 23:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321934;
	bh=xSqm5hpmn8rjHUNVgUnpokBBF5ulUyrDbH02AuxPdn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HBj6l8+m7aOMbCLe7fU7Bm0WuLrR6A1MVHNDXbSCj5/AW8DpKWjp7CpD/G1FCswr3
	 LuhVDdnwcUcokO59eC9jBKcYfKTwXu6w1hAprVr2MrJqfR/QDOaMGjcIf1cNRE221K
	 tvNPKXvt74GzBdBDXazpX+XTNhUWBraZ5OHPJdWSWuylMMOhtgqG6wbeUKJGbnSsAM
	 jnZUfj24Ue4BuvHcWByH3bp8x68gzRMeuf6nIg8ZDSFqyjG9AE2YgZg8iNOZgCpOQt
	 plouEPFDeTz41yt5e1D8xCSx7JjZQR1TO0/qxwvIFfbtR15Hy35xE5kg+y19cqP+U1
	 URBF0Pmtr/NZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 005/451] nfsd: allow nfsd_file_get to sanely handle a NULL pointer
Date: Sun, 24 Mar 2024 19:04:41 -0400
Message-ID: <20240324231207.1351418-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 70f62231cdfd52357836733dd31db787e0412ab2 ]

..and remove some now-useless NULL pointer checks in its callers.

Suggested-by: NeilBrown <neilb@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 5 ++---
 fs/nfsd/nfs4state.c | 4 +---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 697acf5c3c681..6e8712bd7c998 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -431,7 +431,7 @@ static bool nfsd_file_lru_remove(struct nfsd_file *nf)
 struct nfsd_file *
 nfsd_file_get(struct nfsd_file *nf)
 {
-	if (likely(refcount_inc_not_zero(&nf->nf_ref)))
+	if (nf && refcount_inc_not_zero(&nf->nf_ref))
 		return nf;
 	return NULL;
 }
@@ -1086,8 +1086,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	rcu_read_lock();
 	nf = rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
 			       nfsd_file_rhash_params);
-	if (nf)
-		nf = nfsd_file_get(nf);
+	nf = nfsd_file_get(nf);
 	rcu_read_unlock();
 
 	if (nf) {
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b9d694ec25d19..e4522e86e984e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -602,9 +602,7 @@ put_nfs4_file(struct nfs4_file *fi)
 static struct nfsd_file *
 __nfs4_get_fd(struct nfs4_file *f, int oflag)
 {
-	if (f->fi_fds[oflag])
-		return nfsd_file_get(f->fi_fds[oflag]);
-	return NULL;
+	return nfsd_file_get(f->fi_fds[oflag]);
 }
 
 static struct nfsd_file *
-- 
2.43.0


