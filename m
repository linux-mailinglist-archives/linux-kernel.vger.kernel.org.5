Return-Path: <linux-kernel+bounces-116133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A62889984
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19D82C2804
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FFD3AE29C;
	Mon, 25 Mar 2024 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YT83ap+C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312592811B5;
	Sun, 24 Mar 2024 23:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323676; cv=none; b=sPCcIZA5t3vUf8VnEsYueGKCCYafyUsnGAAWN+OI/Q/oVH4EQNltbYP8WU4yzmwFu1uKoB7nsQrH+Ac8Tq4fJwoy13/2w8VKznpDQ/likfEAEJ+U8fZEB9rUu9ko4VF6wrNkRD/72CNvaWw5Fdf832kQmHEFNQV7GPY7sHYjB1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323676; c=relaxed/simple;
	bh=dMAyWF23agArvAO80uHD1LcxVbaqvdgHxmgzfLuynDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNSDbi8wxRGRsjPwnqcx00vTS037f0pDjg/6hM1st49V13bcR1pi6pgi9g/CP3VE21BZTDwLFVfwnieSrsUQz2ABY7atwMWcrJjY1x0CONw9XBWkX+97eK0dyDd4LyWL93DiTglM7gSdAk2FECQQew2DK7rEiwtIf4Mlyrc2Zq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YT83ap+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550FDC433A6;
	Sun, 24 Mar 2024 23:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323676;
	bh=dMAyWF23agArvAO80uHD1LcxVbaqvdgHxmgzfLuynDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YT83ap+CH98fD2uRGUBHZ149uOmTz76scSt8H6FLDe/q48GQ8eIFwFZk7896Ch9rO
	 fvBjMxjo+chQjVQ8A81oXKaJsX/GAiOPpj1+o+kDpOYQtyRO4nk5a/q7iRsv0ci2TK
	 7UG90q7gEmY0pEjQweWQzK/fm7MblcTj++piaYwcywOQM6lvezM+SoPxgpwcp9Ai9b
	 T5g2HwE1sOxgcmD+y1RBmbCBdxZScvmc3UvC7d8oAqsVuFa3r1mbceY+oSZnjg6d/4
	 84Q8Mof1vYhU8fq81PwP8eSmPHB9UnVurMRWudBBaeyDBkzGxTnw9WJBqCAJ5riU8x
	 tM+l+5Wm8Iy/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Russell King <linux@armlinux.org.uk>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 048/238] wifi: mwifiex: debugfs: Drop unnecessary error check for debugfs_create_dir()
Date: Sun, 24 Mar 2024 19:37:16 -0400
Message-ID: <20240324234027.1354210-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 1e7dc724c6a94..d48a3e0b36060 100644
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


