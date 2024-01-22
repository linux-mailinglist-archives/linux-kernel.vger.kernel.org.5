Return-Path: <linux-kernel+bounces-33221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF41836698
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A322839B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591A8482DB;
	Mon, 22 Jan 2024 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3mIsgHw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9267B482C2;
	Mon, 22 Jan 2024 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935385; cv=none; b=Sl/ujP0r0Vu/R03d6JfRb6QTS94LTst5qLCS8gWCJrSYFZLA1Lh35plyechjYTxxc5NUXm+Wz44VUsE2KydEarn8MYpbjjhK36pvZrJ53NnwzWhqRRnFLt94o0eYB06CfIVBgX7owF9KJ5evsqGPaHndTL/PyVxBhE/Yu4Ll/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935385; c=relaxed/simple;
	bh=RCHZgFOmcSkuR3bbBmxsuTF1POjlRMHqQdnD2exlWfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjBHMkAVlVU2zKYLddpEWEmy8rsgmeswhF8BE7O3yxD24OV5pHg+2X9OU0Soc2hD2MfoWfdDtzeFXtkIa0oPLBk70mMYxEy2pQWoW4aG+ir+gtMaQQRfyw3bGfCEFDO6uzMGtcBfxFKTcka+0Tu8kRBSK/wqN9IYSOFuS3d6AEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3mIsgHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1765EC43390;
	Mon, 22 Jan 2024 14:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935384;
	bh=RCHZgFOmcSkuR3bbBmxsuTF1POjlRMHqQdnD2exlWfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3mIsgHw1GFXYlXX7oiBTK7BToUNTTf47kTqyKaCqnCX47PmHVrikxapYibHmmM3F
	 wi3MaltNJjUfdMjsZ2zBXQhzKEB6Hz19y6TWuf8VJ8bS+DqRj8HPzcT3r/F57eELYU
	 NiEhsaIH5nUHx6qSoyX4Jr/wBA9XLidHte2z1B903im03rlQIR6xiUtRd8Jrmx+DN1
	 sY0ZQeoDWk4ItMuvTcpAjmic1123aG4IPGhdGKNG+F+LaXPUPUPVco8OMiXLTFx1A9
	 0U3veh4ixKW1GbaOBxLU9K+hvFHnX4hfMB7aG7DVNgPxi9eFRVVhu4MifcSymKWiAY
	 dqAzFURvNunJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>,
	mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	ocfs2-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 07/88] ocfs2: Avoid touching renamed directory if parent does not change
Date: Mon, 22 Jan 2024 09:50:40 -0500
Message-ID: <20240122145608.990137-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 9d618d19b29c2943527e3a43da0a35aea91062fc ]

The VFS will not be locking moved directory if its parent does not
change. Change ocfs2 rename code to avoid touching renamed directory if
its parent does not change as without locking that can corrupt the
filesystem.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/namei.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 814733ba2f4b..9221a33f917b 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -1336,7 +1336,7 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
 		goto bail;
 	}
 
-	if (S_ISDIR(old_inode->i_mode)) {
+	if (S_ISDIR(old_inode->i_mode) && new_dir != old_dir) {
 		u64 old_inode_parent;
 
 		update_dot_dot = 1;
@@ -1353,8 +1353,7 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
 			goto bail;
 		}
 
-		if (!new_inode && new_dir != old_dir &&
-		    new_dir->i_nlink >= ocfs2_link_max(osb)) {
+		if (!new_inode && new_dir->i_nlink >= ocfs2_link_max(osb)) {
 			status = -EMLINK;
 			goto bail;
 		}
@@ -1601,6 +1600,9 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
 			mlog_errno(status);
 			goto bail;
 		}
+	}
+
+	if (S_ISDIR(old_inode->i_mode)) {
 		drop_nlink(old_dir);
 		if (new_inode) {
 			drop_nlink(new_inode);
-- 
2.43.0


