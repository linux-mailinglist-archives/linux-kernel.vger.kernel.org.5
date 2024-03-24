Return-Path: <linux-kernel+bounces-115403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C357C8893CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D90129587D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825A0202190;
	Mon, 25 Mar 2024 02:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tv0lCSew"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F61D6977;
	Sun, 24 Mar 2024 22:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320581; cv=none; b=h9MaJaJLsm+0JZYhOxvNhOR7YcuFDWo5nEkHu/ssJZ4qXF0PCtEXr48QzKjnsAT3darCbpXqe3keF/hTnwBPmX765R79D25P24vooSjiQIT5rYFUnoBPy9kv3mEjeLS8afNWpl4ZbNugGoaOtjdneadElumEUiLhNg8yCSm9TMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320581; c=relaxed/simple;
	bh=60vo75mBcZsaaWRfia1pLHWloNQ83WhNjty4gGNM0pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHbQjoShkZM04O4f5k0wWHG94ey/6A946gWmvntbiNd1ENMuJ3wHV7jFnTdtv7kV/2dIHgbznXtELn3ELdihgygzjud9vH7tvnD3rkh1EstWx3iTqzoGQ/24nKjUI+0NuNHYYsmwjcJFxBygUVpsH0ku+K5Qob//nKQMfkQZvCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tv0lCSew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0D4C43394;
	Sun, 24 Mar 2024 22:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320580;
	bh=60vo75mBcZsaaWRfia1pLHWloNQ83WhNjty4gGNM0pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tv0lCSewDMEEwtfPiNMYNKCA5SJOxJayngE/4tsZMb5mW7nPzTVnehNtJMNrZ34Up
	 Jm1VGNjp7PYyXkwya+TLHgeah8BRMwQO+sKWGshNk/rFWIGuznurwG8yzr6JHIRUNW
	 A6rTUXb+V+RNajruwS4K+sGqKUpXB2ZL5++XzQfIlxM1YZsPMcIIXgmgT6P/metmfb
	 ncYo/gqeS4aTzm+eMINLgzLtvV0NZ7R5hcG2d62uUCzu9DQQLfqCPEUmqVVEfWwufh
	 bhgjywZDEpdpeUkWqqFCTWsAnMGmQ/W09b1wjtZv2akpK8+t4Y8ZHxIBZJ50MoZDfp
	 1VtHpJkAPzm7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Russell King <linux@armlinux.org.uk>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 141/713] wifi: mwifiex: debugfs: Drop unnecessary error check for debugfs_create_dir()
Date: Sun, 24 Mar 2024 18:37:47 -0400
Message-ID: <20240324224720.1345309-142-sashal@kernel.org>
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
index f9c9fec7c792a..d14a0f4c1b6d7 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -970,9 +970,6 @@ mwifiex_dev_debugfs_init(struct mwifiex_private *priv)
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


