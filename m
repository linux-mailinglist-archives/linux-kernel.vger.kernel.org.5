Return-Path: <linux-kernel+bounces-115447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00D6889B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5042A60A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27126215933;
	Mon, 25 Mar 2024 02:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhF+6pDi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15901E4A25;
	Sun, 24 Mar 2024 22:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320811; cv=none; b=ZdUu9bhIbJmcB/3X4qr/yhhhz4Yhte/3p8jsypDg9o9mcyODR11MuMF92daA3TT/SrgojbdOB4x5FBrLoYMdqm17trNdP2Yicg3/MxW6JmcQXk7S3OGjeHbTnOoN44OUnZIeonJ8PSMUqcEUDnamMV2z8rvowx+8cPGMn+IfloE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320811; c=relaxed/simple;
	bh=bqhQ8CzGWTTriI8TaVQ625rSdktHGajB4fQc3wcp1no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSajhmYbVaw3p/TuWG/jNSjwvXh1gWumFhvYR4pZT9VyxqKhjiEw4HLIFjLSDTd5fuv5L1F1+stnD7Xam0gC9QgHcA9vo7DNYprPG4GUzClC6zRMYhlG7vKWJrxkL0xTR+onY6sdhvVjJSDUiKIAl4wWY+78+iRGYj5YKbxhqQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhF+6pDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DE9C433F1;
	Sun, 24 Mar 2024 22:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320810;
	bh=bqhQ8CzGWTTriI8TaVQ625rSdktHGajB4fQc3wcp1no=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GhF+6pDibVZLR33hA/ohFaxIUoAtlA6hUkT0mtlVvqnngzuoRglKaLE4ktNoRy0d8
	 Qs748lxiXhTp3JSZMLTFc9kejhEuw6AO04SJxNtnfVERDWbvEuYI+Vy4ApvihayAio
	 MlCk4q+6IaRlIqzQQuPgkblDgVanyv/Ahq3kJ5OfgcJZqfxwEL+kx9CRhc/WeLsvqm
	 N9PcTV0RbtHKK9s1C8d9IxLL/JzGdkPLVtye3npy73m7B0cWm0N+uzQUd8TChSXwNE
	 aXgD4LzALfjtVxwzDFcHECGq7c/3Y3220HRE7VVfymReU8JEI+uACMEvfuytoU6Cjl
	 VuY1WmtusYV5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 375/713] erofs: fix handling kern_mount() failure
Date: Sun, 24 Mar 2024 18:41:41 -0400
Message-ID: <20240324224720.1345309-376-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 2c88c16dc20e88dd54d2f6f4d01ae1dce6cc9654 ]

if you have a variable that holds NULL or  a pointer to live struct mount,
do not shove ERR_PTR() into it - not if you later treat "not NULL" as
"holds a pointer to object".

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: 0f28be64d132 ("erofs: fix lockdep false positives on initializing erofs_pseudo_mnt")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/fscache.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 87ff35bff8d5b..1052f75d1dfae 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -381,11 +381,12 @@ static int erofs_fscache_init_domain(struct super_block *sb)
 		goto out;
 
 	if (!erofs_pseudo_mnt) {
-		erofs_pseudo_mnt = kern_mount(&erofs_fs_type);
-		if (IS_ERR(erofs_pseudo_mnt)) {
-			err = PTR_ERR(erofs_pseudo_mnt);
+		struct vfsmount *mnt = kern_mount(&erofs_fs_type);
+		if (IS_ERR(mnt)) {
+			err = PTR_ERR(mnt);
 			goto out;
 		}
+		erofs_pseudo_mnt = mnt;
 	}
 
 	domain->volume = sbi->volume;
-- 
2.43.0


