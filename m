Return-Path: <linux-kernel+bounces-114492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4D788902C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DAA1C2BDFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145361802C4;
	Sun, 24 Mar 2024 23:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yqzd3WR+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4168D22520A;
	Sun, 24 Mar 2024 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321939; cv=none; b=CmrYL/CEH3k/eyZL+VqYjFB7df8QCUhSaIXJWhnUUkhqLk7MPlgjSiliLfZfWi/xAmlkV66f60U9sCSSEj/S3en0X/EG4L4zkq/EyIPZB8fYZW5tCR4zDQ+8hHqC4UFmjMB9oOwFzfhKZHFdZFQK7jwJs54YV5EQqhwneDRy+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321939; c=relaxed/simple;
	bh=3PXM6/UlYfxz9RIjba/zaF2YNNRDwgTifOocEtHlPWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyWGS7h240x1Ba+dXUHkORRpicszecNn3fNXyghkW2nDmjEma8NrEQOHalfuPQ+iiQE29W8OUHU+D+KHWi0B83zyN7AIPlu5J4aT13lZ7XyCEgjvf/Zs7vHLAu1JqPggqtF/K2bEzYgPtMb29u1WuiNFBNUPFCzlFfXzJr+2y3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yqzd3WR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1D7C433C7;
	Sun, 24 Mar 2024 23:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321938;
	bh=3PXM6/UlYfxz9RIjba/zaF2YNNRDwgTifOocEtHlPWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yqzd3WR+YPBok7xYL2Vkg16aOKF5P8j+9gLJ9QwsdMHqgdMri71rg0h5Bcu+T7zCX
	 3K4RV3e0l8hXA12UHPLaUFnln6AMxnIQ8jkL8eZRbrQhIw5gKNWb3+gFAetwUxXzP+
	 lN03rfLU73+1ksPNxV9CgoJ8GXeG0xIg7w4XvE0conNZnC8ckAhYD7PkD5Reby1yVo
	 VaO3zxoQdI0+8TnlTAAADtyFIzWpz15iq/6MINXcmT14YZIDVQR5Kya+n/0lsLzKRx
	 dixSZCtHRh/7GT5ail98WgXVmcRLcS5yW4525sCgjg33GA4k+qbrgp6e5pPBZGWtIo
	 CCrxX+6+IzpVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 009/451] nfsd: don't kill nfsd_files because of lease break error
Date: Sun, 24 Mar 2024 19:04:45 -0400
Message-ID: <20240324231207.1351418-10-sashal@kernel.org>
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

[ Upstream commit c6593366c0bf222be9c7561354dfb921c611745e ]

An error from break_lease is non-fatal, so we needn't destroy the
nfsd_file in that case. Just put the reference like we normally would
and return the error.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 568963b8a4777..ab37b85b72077 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1102,7 +1102,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	nf = nfsd_file_alloc(&key, may_flags);
 	if (!nf) {
 		status = nfserr_jukebox;
-		goto out_status;
+		goto out;
 	}
 
 	ret = rhashtable_lookup_insert_key(&nfsd_file_rhash_tbl,
@@ -1111,13 +1111,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (likely(ret == 0))
 		goto open_file;
 
-	nfsd_file_slab_free(&nf->nf_rcu);
-	nf = NULL;
 	if (ret == -EEXIST)
 		goto retry;
 	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, ret);
 	status = nfserr_jukebox;
-	goto out_status;
+	goto construction_err;
 
 wait_for_construction:
 	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
@@ -1127,29 +1125,25 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		trace_nfsd_file_cons_err(rqstp, key.inode, may_flags, nf);
 		if (!open_retry) {
 			status = nfserr_jukebox;
-			goto out;
+			goto construction_err;
 		}
 		open_retry = false;
-		if (refcount_dec_and_test(&nf->nf_ref))
-			nfsd_file_free(nf);
 		goto retry;
 	}
-
 	this_cpu_inc(nfsd_file_cache_hits);
 
 	status = nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_flags));
+	if (status != nfs_ok) {
+		nfsd_file_put(nf);
+		nf = NULL;
+	}
+
 out:
 	if (status == nfs_ok) {
 		this_cpu_inc(nfsd_file_acquisitions);
 		nfsd_file_check_write_error(nf);
 		*pnf = nf;
-	} else {
-		if (refcount_dec_and_test(&nf->nf_ref))
-			nfsd_file_free(nf);
-		nf = NULL;
 	}
-
-out_status:
 	put_cred(key.cred);
 	trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
 	return status;
@@ -1179,6 +1173,13 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (status != nfs_ok)
 		nfsd_file_unhash(nf);
 	clear_and_wake_up_bit(NFSD_FILE_PENDING, &nf->nf_flags);
+	if (status == nfs_ok)
+		goto out;
+
+construction_err:
+	if (refcount_dec_and_test(&nf->nf_ref))
+		nfsd_file_free(nf);
+	nf = NULL;
 	goto out;
 }
 
-- 
2.43.0


