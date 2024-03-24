Return-Path: <linux-kernel+bounces-116333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2065F88A15D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 844EFBA1FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3F129AE18;
	Mon, 25 Mar 2024 03:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4QB37Ry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C752296BB1;
	Sun, 24 Mar 2024 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324323; cv=none; b=JsxhaTJJY0q0AGnOmJgmBdAjjG0vIkXRa35POt2bR/fcBzKW7dzX/7VOyxqUjBPeRKpZCOZi84+SS54X1LAd67GFVj0Qzw7Pca+ojTOa/Ei8KvtsFVWTwKyNJPTvq487uC0ZTYkX7vxyJvwY9ssHaKaDO3iw6Tyxoj1Y1KFZZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324323; c=relaxed/simple;
	bh=vFwkb/ECA43oJr9FZc50G4ViBhPU2rPobIrvVl1aWxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s984+d8ol0QZez2qyDku5HgacWM8XrnoVtFRa0k4tyXC2V6ijR0WzfeoQ5iCToezrrtrA8QgQAkhhhZ4+lBxbhrYFZMWu5TYsKvPIP8fi26WAWVQ23P+gbwRr0JEHVLu+RzStTnSVqIVX7Ij4UyyrLN/vZXDKcBWgRxitbZL1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4QB37Ry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D74C433C7;
	Sun, 24 Mar 2024 23:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324323;
	bh=vFwkb/ECA43oJr9FZc50G4ViBhPU2rPobIrvVl1aWxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E4QB37Ry6yrpDepTTiXZdUfKFqp7VZHp4xDFoubKjiaQmtyv9RKm77Xov/cJrC3P1
	 IPTld1V2DL2QbwvFcMejsRaN/p5HCDqY01bywR8yxDN3mCIs4LP9E6z6to0PYIZUV9
	 PLJHfOFz4GWPVDTwFocg9IDk4qNOHu57kn5au7hou14UE+pnQ5BMYlRHPk8eKkR6td
	 DFGJBDI/Db19+qOOEeYumQfIsEN5PKDE0fMFgvxluXbNLHrWJWiD8r0WDHesH6llJU
	 eM6b5RI20LBvlXXBlEU8PQN550Gx+2fAx7lY77VE8dAXg0SB25Qzcl5NTeMyIdRhYU
	 Gu1UXF+ewwWVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chengguang Xu <cgxu519@gmx.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 094/148] quota: check time limit when back out space/inode change
Date: Sun, 24 Mar 2024 19:49:18 -0400
Message-ID: <20240324235012.1356413-95-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Chengguang Xu <cgxu519@gmx.com>

[ Upstream commit 632a9f3acd6687376cbb0b178df6048e19cbacc9 ]

When we fail from allocating inode/space, we back out
the change we already did. In a special case which has
exceeded soft limit by the change, we should also check
time limit and reset it properly.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Stable-dep-of: 179b8c97ebf6 ("quota: Fix rcu annotations of inode dquot pointers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/quota/dquot.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index b55d91d3d87c2..895636fd655f6 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1760,13 +1760,11 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 				if (!dquots[cnt])
 					continue;
 				spin_lock(&dquots[cnt]->dq_dqb_lock);
-				if (reserve) {
-					dquots[cnt]->dq_dqb.dqb_rsvspace -=
-									number;
-				} else {
-					dquots[cnt]->dq_dqb.dqb_curspace -=
-									number;
-				}
+				if (reserve)
+					dquot_free_reserved_space(dquots[cnt],
+								  number);
+				else
+					dquot_decr_space(dquots[cnt], number);
 				spin_unlock(&dquots[cnt]->dq_dqb_lock);
 			}
 			spin_unlock(&inode->i_lock);
@@ -1817,7 +1815,7 @@ int dquot_alloc_inode(struct inode *inode)
 					continue;
 				/* Back out changes we already did */
 				spin_lock(&dquots[cnt]->dq_dqb_lock);
-				dquots[cnt]->dq_dqb.dqb_curinodes--;
+				dquot_decr_inodes(dquots[cnt], 1);
 				spin_unlock(&dquots[cnt]->dq_dqb_lock);
 			}
 			goto warn_put_all;
-- 
2.43.0


