Return-Path: <linux-kernel+bounces-115062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEFB888CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3DD28B81F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9811C32A5;
	Mon, 25 Mar 2024 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp2z/UI8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A312892A5;
	Sun, 24 Mar 2024 23:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324038; cv=none; b=N8fjuiXMZz0i0zcMFpyBZAK0PbfwQ3sSZvrdVPJqFUkxHFOyJzBc52HWlFvJ1tnZqHrszXIPXfWB1QotxIhm9vctRvHB1kPt3Q9e+cAz6bQ7ZRbOZSuyCSKKrx8yjas/HG0EKF21vEI9htw4T3vB5d3LvKN4BjOAJy+99siEvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324038; c=relaxed/simple;
	bh=C1jtr2IK9Bcqh0oulVRpOiJTkuNCJ2ncu/i7FKNApMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ks26+w3MWvrac0IgrSJlblRresBASEFj5AFXP8G6+xN8aYB4vw2xdMRXG9MDE5MoPGCGxZI2dTd8QIMEhR0Lm9Fdk31Qa+aKz/JnVcAVpCu/DKr6ySLFPVQv6kDcWpiUs6+yIEUPjhS7dyIEDmaAfZvNnA0SwBz1vsFhdMMN1pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp2z/UI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533ABC433A6;
	Sun, 24 Mar 2024 23:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324037;
	bh=C1jtr2IK9Bcqh0oulVRpOiJTkuNCJ2ncu/i7FKNApMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gp2z/UI8RnVsRxexvLdvz1FriKi4Ys4ggGLh8ui9oMEKH5i43ypHtAYLWOjK0n5hq
	 KfU6QNE+CUAj2qn+DBzfHR19uf1fxxUOcNlF1owhkAHJE4jqN8yO91qL4nUE8FVlAZ
	 iA0W9A824RZZ7Jw7ic9FvQAWarOLUbvzxeHvWQyNs86mv+8uLpISDK1Qtk/XyuqLgj
	 ouI2Kco/pq8gEh7o5oBp04ogS8bEEWmjlAH1uM4XqHOefnKiT5PM7wE8MPfQ2bmeDr
	 cj7z7pJFgBefpyXng74ioGPwk9/7ykLibcmFmA6nQTS8X7RCULvNl9FmtPpyx6/p7H
	 eVq2ZWufviivw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Russell King <linux@armlinux.org.uk>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 038/183] wifi: mwifiex: debugfs: Drop unnecessary error check for debugfs_create_dir()
Date: Sun, 24 Mar 2024 19:44:11 -0400
Message-ID: <20240324234638.1355609-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit 50180c7f8e3de7c2d87f619131776598fcb1478d ]

debugfs_create_dir() returns ERR_PTR and never return NULL.

As Russell suggested, this patch removes the error checking for
debugfs_create_dir(). This is because the DebugFS kernel API is developed
in a way that the caller can safely ignore the errors that occur during
the creation of DebugFS nodes. The debugfs APIs have a IS_ERR() judge in
start_creating() which can handle it gracefully. So these checks are
unnecessary.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20230903030216.1509013-3-ruanjinjie@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/debugfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index e4cb7ce1c8b85..a6f4655b301d6 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -976,9 +976,6 @@ mwifiex_dev_debugfs_init(struct mwifiex_private *priv)
 	priv->dfs_dev_dir = debugfs_create_dir(priv->netdev->name,
 					       mwifiex_dfs_dir);
 
-	if (!priv->dfs_dev_dir)
-		return;
-
 	MWIFIEX_DFS_ADD_FILE(info);
 	MWIFIEX_DFS_ADD_FILE(debug);
 	MWIFIEX_DFS_ADD_FILE(getlog);
-- 
2.43.0


