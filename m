Return-Path: <linux-kernel+bounces-114249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C60888969
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E08B2435D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FB1257FC3;
	Sun, 24 Mar 2024 23:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVXYxUkc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC1020AF62;
	Sun, 24 Mar 2024 23:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321601; cv=none; b=q1gwruAzFCxdEB0xQ7n3nBnPs1Sb7znWlUAE/M91UDfdnGqfkldgOX3huAX9Cytwu8sCUftowJVRsBtbr7espM9clL9eV4lA1bcoBEHNME9jtcFwgk0rTVX6lkxppKMSlXM+joY81IpqvHkjgdxNA3PWiJeaX2hVfzGNJ5tiujI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321601; c=relaxed/simple;
	bh=bqhQ8CzGWTTriI8TaVQ625rSdktHGajB4fQc3wcp1no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rH8BOFO0g8zm1BA/9so12XXS8zFev859qpJn0jZIYQNaf3OO1k21wx9a5PCuWytn0Mh+30SIl0ZrJ9qmpnpLLkRmTKg2ta8WpoOOjTpU6gVjDMN3WPlfzUJo17Zw3zOeZqJNZQJDFDKA/XNW1HX760WC3KBiAaGfUvr+/433FWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVXYxUkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129E0C43609;
	Sun, 24 Mar 2024 23:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321600;
	bh=bqhQ8CzGWTTriI8TaVQ625rSdktHGajB4fQc3wcp1no=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IVXYxUkcIEsZBESKjz1odEpU1VL07mUtOF4/YF+nRZEy+LEbLuWH9eooOTZfgTV7E
	 y9ilsVtwiTXbL8KFoSWgnLWukmJ//nqR5xnPsodKp0/U9Baq9DnvxTSLg12kfL6znV
	 UOKhmWGpy4rb95ny6uSOn3RQoJrORycK1ocj5AnMuy011TJKAYtZWSxp8xjn8G4W56
	 lb2Cdgo4xdVSAaA+nydyd5MIzV8XyKTRun1qazmPbEC/Qij5Bu76cTaI6ZjJJQ2Cco
	 /64ukysNC5hHvaVSsaDPBpiQgM5j0foPTTs6QHPTpbVHN+laWjKa1y+/dnnXfTCMQL
	 hSpKKQC6Mj4ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 330/638] erofs: fix handling kern_mount() failure
Date: Sun, 24 Mar 2024 18:56:07 -0400
Message-ID: <20240324230116.1348576-331-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


