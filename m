Return-Path: <linux-kernel+bounces-116315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6E8889E31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE7B1F3745F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120A53D3220;
	Mon, 25 Mar 2024 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zk47uWqI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DCE292B87;
	Sun, 24 Mar 2024 23:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324254; cv=none; b=Y8KTpw2HWUaPRSG1s0zXV2VYz9Ffnx/Xr1KagHvN/+nnDojN2Z9qop8qMt1XgZu99RjJRD0WCLsZfo7m06JOhYceamFsyksV/1wmxZEsuyHpI7SSifDWxHjQdt4e0LEjD3aj+kKy4y5u3Mw78ycxBmknjoWw1iyKeJSIEpeCxJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324254; c=relaxed/simple;
	bh=7XJBJ3ssNqsZXuFbQT4PN2MmLcu/dCRwK9QCwYai6S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fwm+sW+i20aRsYqZH4JM5NBSk9HMoxh2FH+SH7GpK8irP/B/L4FOOjBeV7yciczPDawccKCAelQUPzXPnnUI+cE348dK5ZjjWiD7LJjCJqfLQ8f6M29BG++INXBC+AtlLG75FwSxV/TdWUTz5Jp6HDXVxnE9I6kX03vu5yKcXQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zk47uWqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE274C433C7;
	Sun, 24 Mar 2024 23:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324254;
	bh=7XJBJ3ssNqsZXuFbQT4PN2MmLcu/dCRwK9QCwYai6S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zk47uWqIy/e0+h7AGoXGOgQFosoM8Pbq2UlvCtLsNaTp1lt6BTSJf8M20CY9do7tU
	 Gf61Ww/Ep4oPF6Bd8Hm3cVtKTdK+Lq6OOSNOMcykuxG6yM76WTSuDl7SMoBTjR4G/p
	 jtGs4UfafjWja73+hv75L2fEWoYT8f87P/6bTMLoJwMX8hfVf6aXl5KM6y5YSw34NQ
	 7FipvyiUTiSZjtMTS4X7oGpfdSRF1OmetCow4czCsRbEQxr9Xh4zg8c9Bvg/xTIGQs
	 HmjJFPO4ykd8FxAKk5prjQ+4FgIx8DbjnQZnWzoi1eKJf3zqNXI+EcG7ljbWdK9uxi
	 uJcMJubQf+/6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Russell King <linux@armlinux.org.uk>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 035/148] wifi: mwifiex: debugfs: Drop unnecessary error check for debugfs_create_dir()
Date: Sun, 24 Mar 2024 19:48:19 -0400
Message-ID: <20240324235012.1356413-36-sashal@kernel.org>
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
index 0f62da50e11a2..63af04202d75f 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -977,9 +977,6 @@ mwifiex_dev_debugfs_init(struct mwifiex_private *priv)
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


