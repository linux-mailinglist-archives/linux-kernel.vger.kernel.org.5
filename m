Return-Path: <linux-kernel+bounces-116334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D8F8895F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E161F309C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16531186380;
	Mon, 25 Mar 2024 03:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCTk7SUS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C83D296BA9;
	Sun, 24 Mar 2024 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324322; cv=none; b=npn15b92koY/rwAb5aIIMK5aS+qujzh7FzUhtba81t6gnvTemMl+L89tQpMGyQTN9iqfESNW0AJyw3vSHuOHT2MySFlJ0L/YtFTi9yeuo88Jvt5FPfJn/8L6mP1P21WgSriXJi/V4dqbjV6/4ADVeJN8LNWVxVVvhhLRwgeHjcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324322; c=relaxed/simple;
	bh=v2O7Te2gUiMryxEplDSahEdoCwle9NUThvljuAWldk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDZSgaatIH9gRQ2aofSkUKHO9QWZknFCw+XwXS+9pUldofPzepzvnhtwIIBcv+8qOgvSESXwJKd66SIbM3F9vF/FepGEUzzm4nIuKCtm/eQ7eJczspuURzMOd/Y/HDZCQ1QId/9mMOd18+7wZICXgET4eDGIYvU3cEmRJeyuSUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCTk7SUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A43C43390;
	Sun, 24 Mar 2024 23:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324322;
	bh=v2O7Te2gUiMryxEplDSahEdoCwle9NUThvljuAWldk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCTk7SUSDu0tfaWODCgr7vcmS7OLiUPoK8NQ9k2tmBlm4s67dFBwu3BkAIdO5AfUt
	 cAeyktC2Y5XdHDMtZZcoEZ7T/SPuvYa7nZlu+aQv99gg5two2DxOZSFvbVj6g/w9Ux
	 /z6RLjISKeCA8HLldtfUItBkJihlZ4Ic3jbthBsiWlKiidm0LagJxd/xBC1z2ZW8Ij
	 23pXJfMnbh7tZc68YKnIceksgnnKXhCJzuobFA5VKqjjfxmT0LvoX5kYDJp8WxImwh
	 yMCrRHxFliPC2h9/aKu17IP8nawfZY9KIjRYuDDR7Fp04rY0LVkEfCEXb7ZJKt5cdE
	 W6QW/KUre+pKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiang Biao <benbjiang@tencent.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 093/148] fs/quota: erase unused but set variable warning
Date: Sun, 24 Mar 2024 19:49:17 -0400
Message-ID: <20240324235012.1356413-94-sashal@kernel.org>
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

From: Jiang Biao <benbjiang@tencent.com>

[ Upstream commit 78bc3334a69ff289dbc973a9db7c52a2d7757e5b ]

Local variable *reserved* of remove_dquot_ref() is only used if
define CONFIG_QUOTA_DEBUG, but not ebraced in CONFIG_QUOTA_DEBUG
macro, which leads to unused-but-set-variable warning when compiling.

This patch ebrace it into CONFIG_QUOTA_DEBUG macro like what is done
in add_dquot_ref().

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Stable-dep-of: 179b8c97ebf6 ("quota: Fix rcu annotations of inode dquot pointers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/quota/dquot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 683727c5758c0..b55d91d3d87c2 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1129,7 +1129,9 @@ static void remove_dquot_ref(struct super_block *sb, int type,
 		struct list_head *tofree_head)
 {
 	struct inode *inode;
+#ifdef CONFIG_QUOTA_DEBUG
 	int reserved = 0;
+#endif
 
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
@@ -1141,8 +1143,10 @@ static void remove_dquot_ref(struct super_block *sb, int type,
 		 */
 		spin_lock(&dq_data_lock);
 		if (!IS_NOQUOTA(inode)) {
+#ifdef CONFIG_QUOTA_DEBUG
 			if (unlikely(inode_get_rsv_space(inode) > 0))
 				reserved = 1;
+#endif
 			remove_inode_dquot_ref(inode, type, tofree_head);
 		}
 		spin_unlock(&dq_data_lock);
-- 
2.43.0


