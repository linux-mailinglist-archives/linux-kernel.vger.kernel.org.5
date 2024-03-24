Return-Path: <linux-kernel+bounces-114498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCCA888BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D1FBB2EB44
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B0628A588;
	Sun, 24 Mar 2024 23:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/GfnSjU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E404A157A5C;
	Sun, 24 Mar 2024 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321946; cv=none; b=Mv7G/XPZYfE+uQieYw1kvIYpwIrjWTKXrabpZW0mKEFGKRPqOFJgcZCItFffUTrx4ePYOE0+MOh6sJDU2ZR0ozc9cgXfy5aBKwajQIG6sVfyf/T36+uN7cmu2/0vRSitOas0x7cjRJx4werfR9o6O3IPTLFwhZnZdcSLXjijVfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321946; c=relaxed/simple;
	bh=GheQLFaUsVo/0Mbc1b3BO9EcJbkijdAQ4AoyCjgmt1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gkx1DufH9nZE0Gf0IHe6nF1/7d2d1Yb0MABRRYutRyS6LH6T/7Nb46OPKZVQsqa7FNtlO+tNkMgDMg/zJI9fEDa7gf/CQT8AkSCS7E3Jb2z6vccQbDS5qq7tyk6YGtJ6HdgHOTANgHwSbW0eSo97CMzg5lzZmKd0M4/+g08aDr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/GfnSjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A5DC433A6;
	Sun, 24 Mar 2024 23:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321944;
	bh=GheQLFaUsVo/0Mbc1b3BO9EcJbkijdAQ4AoyCjgmt1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/GfnSjU4ZsNgyVC0CnlRsDDDVrhOcLQmXLmJJi2vNDxF+cgiGsFEt2Snpqn0KTu2
	 /vMkIn5ZQwT09cSqcFr+5N2doEC7/V7q9f4woP+zAsiDPzTkMzrfJyz1w5CWo0uQ/9
	 d5eAg5egDb4ccig8D0W2rqBV2McWnSimVEgDDZavJsFEYcNjxnEKNCd9GYZ/XTFkQw
	 BXv0+022qUOMvtGb8cKK8anv1Wt4xd5MuF5K2KFJnArQljIiXsWMurKnUDYiXtC02c
	 b9+4rQ2OCp6q9Fac8gx/z3zH89+S/+/3VrQ0x+fQg69tMJNGAQvNSy7cqRrPk3accd
	 7TzudhrHHShWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dai Ngo <dai.ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 016/451] NFSD: Fix problem of COMMIT and NFS4ERR_DELAY in infinite loop
Date: Sun, 24 Mar 2024 19:04:52 -0400
Message-ID: <20240324231207.1351418-17-sashal@kernel.org>
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

From: Dai Ngo <dai.ngo@oracle.com>

[ Upstream commit 147abcacee33781e75588869e944ddb07528a897 ]

The following request sequence to the same file causes the NFS client and
server getting into an infinite loop with COMMIT and NFS4ERR_DELAY:

OPEN
REMOVE
WRITE
COMMIT

Problem reported by recall11, recall12, recall14, recall20, recall22,
recall40, recall42, recall48, recall50 of nfstest suite.

This patch restores the handling of race condition in nfsd_file_do_acquire
with unlink to that prior of the regression.

Fixes: ac3a2585f018 ("nfsd: rework refcounting in filecache")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index f40d8f3b35a4c..ee9c923192e08 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1099,8 +1099,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * then unhash.
 	 */
 	if (status != nfs_ok || inode->i_nlink == 0)
-		status = nfserr_jukebox;
-	if (status != nfs_ok)
 		nfsd_file_unhash(nf);
 	clear_and_wake_up_bit(NFSD_FILE_PENDING, &nf->nf_flags);
 	if (status == nfs_ok)
-- 
2.43.0


