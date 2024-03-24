Return-Path: <linux-kernel+bounces-112955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A051F888008
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF891F24733
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F067B86642;
	Sun, 24 Mar 2024 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vc205BCC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346228627C;
	Sun, 24 Mar 2024 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319768; cv=none; b=tOEjfVnOOcD+mwgU3PTjjecsw8n/8UD/GF6yTW+FPhufhozAc3PFSVyo62BPG3HJfUq4WFN/Rx8OsHyGHJIhM7F473V2OVhzPyEPcMwTjFePK0TfHoYGZ+r4umbZpgJAQEok1VmlytWLTSYnd4CiiMPdFkHFF69WDUQLeR3CaSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319768; c=relaxed/simple;
	bh=60vo75mBcZsaaWRfia1pLHWloNQ83WhNjty4gGNM0pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9q1itLe/pjk/9Y2caqdeQCl+QCmCSucJtdm9gmVD5CCvlxPZ9ChAraJmVciQeZeqGpp7trk00zbriGu7x52A7ZkSKCXRfsTSjz+KGNV7eAK7jGTa6t/NmCxHSgW7W+/pr6KTYrb9mD+KjppwYMuhuGAFfoG4MZAYg08HQ/QWMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vc205BCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C6AC43394;
	Sun, 24 Mar 2024 22:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319767;
	bh=60vo75mBcZsaaWRfia1pLHWloNQ83WhNjty4gGNM0pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vc205BCCEVCFiYWwWzvseHOPtPkhFlDbIIl4FRkWLziRWsO+n4jbzuLfZWg9zktmj
	 +sxnbtc+3LvVrvr61LqfmPEP25+YQ04Gxr66GVPsrZyxVEKkubIjaAEvHx1MmoE1qA
	 Ft8995VwS1fDfSrRDDibA/TKl5KKx+s+zOl8/EY2MIpf/HfJ4gNcWa83d/g7pp6KUK
	 q/wt2oSKPaDICRp/KDWUe86ZTw3xL8wwpigURfbYhdpBMya+PARB2frPon14QhR9ox
	 xNKQCUOLD1YPW+YTylBYSKg+gYtMra05Tr6KhLFFbarLiO+OBGpyJ4RWQ/P86zOUeh
	 H0L5nJhkUMPow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Russell King <linux@armlinux.org.uk>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 068/715] wifi: mwifiex: debugfs: Drop unnecessary error check for debugfs_create_dir()
Date: Sun, 24 Mar 2024 18:24:07 -0400
Message-ID: <20240324223455.1342824-69-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


