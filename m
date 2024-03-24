Return-Path: <linux-kernel+bounces-115864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EBE8898F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD61DB3757C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C215380812;
	Mon, 25 Mar 2024 03:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgfDWIlB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC4A535AB;
	Sun, 24 Mar 2024 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322021; cv=none; b=o45T4uPXs6cuqXhE4VH/hyvrrjq4s3hUwzvMtRM9Ulb8EsRcwobTWLOB3NII/otaX4NTNFoYpeDwaF3NAisQRqgOL0/KAjopqOFLoKMarKmCTjOtnjbGB9W8Zsh7CsW5Cf6l8/WlrOmd/JGE6rIAh1l5BDlZIIe/+Jf6p31yvb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322021; c=relaxed/simple;
	bh=aQivHdRDzH/uaTKCJGoM2Wbuj+eFNqRsoXYaBwP44/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFVRWYFsFKuc/gZJGwNZ9/KVmTRPPoooJfarljzSV8ytzJ67X82m2ku+9PHvsT/U/7fIO+ro/yHfkAjMhvetNxHJM8hWRkTIHoigvQbNiR7frB6drPUFN1F1bq2xkNPK4L1rR3zFJIlhCnjvQtYZmtYF+eJ2S/P8Uyd1ghlHkXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgfDWIlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650D6C433A6;
	Sun, 24 Mar 2024 23:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322021;
	bh=aQivHdRDzH/uaTKCJGoM2Wbuj+eFNqRsoXYaBwP44/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LgfDWIlBEQiqjKnAf+Lfv0hqt38CUIxFzIj9EmPY0sPflW2vhl/KfUjoCUc/9z/ig
	 ku+uSl1e8T8OREXfQ+YBH/iQdqoWbT9k64NW7RGanC8Y5cqN+S33qahodAFdFUumKZ
	 6CiswVRiNEElzoNqk3wQeA+Pr470mx4swV0UVlcbckLIHVCisAQuonPRmHGR/Em3UY
	 YRlsIVvGNZxvwyB/zVjqjoRyTaBCaRZAy61gn0ENuxx2g2+uIq6koN3dj3qpOBcu5K
	 ph4eNRNcu6US2jvZ6DdfaUTvdjeXGaLJ7tZoIW3q5ZI2drXEfr92SaIzXK4mEghoMO
	 sTu9qXGFEqAXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Russell King <linux@armlinux.org.uk>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 093/451] wifi: mwifiex: debugfs: Drop unnecessary error check for debugfs_create_dir()
Date: Sun, 24 Mar 2024 19:06:09 -0400
Message-ID: <20240324231207.1351418-94-sashal@kernel.org>
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
index 63f232c723374..55ca5b287fe7f 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -964,9 +964,6 @@ mwifiex_dev_debugfs_init(struct mwifiex_private *priv)
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


