Return-Path: <linux-kernel+bounces-114762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCE0889116
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DE91C2CFC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391C41B7F53;
	Mon, 25 Mar 2024 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBBTfRBT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74711218555;
	Sun, 24 Mar 2024 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323360; cv=none; b=uoJQ8Y7sUfsmE/U7RNq0R4cZJAjBf5J2itcyarmdGkfnJcyrqDoWa9Tav0OtlIhDbM7Nxom9f4Z8HDjnGVqhBferNyCTTbsNp96tmioKEYZhSjNratJHdwYt3UlJi8bvqFuROd8QY59xR6BhDzDvZTwtv4IzuHGPHUdt/8J2SDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323360; c=relaxed/simple;
	bh=dMAyWF23agArvAO80uHD1LcxVbaqvdgHxmgzfLuynDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMjBQW94j7sY+qBkfKjZ4x93TnWInw3uf+sO4WtR8ACaFC9kQl+KbsT04cJ4Wqd/6pWx64fiynvcOvqdyYS0CNR/apfDogdexSEcB16CDcP/gkDfcaTWHA2vycDwFxNDwfGfO5wPncKsbU6coer3yykI5GJs3i6cu8t4Lqy7zZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBBTfRBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0F7C43390;
	Sun, 24 Mar 2024 23:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323359;
	bh=dMAyWF23agArvAO80uHD1LcxVbaqvdgHxmgzfLuynDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EBBTfRBTUnzqc9HLDLHYf0kQNBDBvwkBWJ1c6ZgwsIyJIncBkTio6sYI62XfaeDAy
	 TCGX4URXUne8XMUcVW6GxasETWhxGqMgjZWOtpSlk3jGONeO+p/sYiy+Ygnh0qXLfo
	 A/vhLR3KgCtkwdeH6G0yYRsHvDVmQiWvq8jXxRSmfkW0KjrUdvgZS+cs2VDbzu55VT
	 MRXysIwmFHkxhH5IX6u3d2n6gLe17ibjQ2w2+o1zdI/KE/qafJwnEPPSmypS7eZ3dA
	 E9UUDjmB5noxI/t2PN3NPciTzZNYlt58hDG7oKcgTyxYZYcYiszdhhz0vwlG6/lxTX
	 B/EBj2LSBwh1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Russell King <linux@armlinux.org.uk>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 059/317] wifi: mwifiex: debugfs: Drop unnecessary error check for debugfs_create_dir()
Date: Sun, 24 Mar 2024 19:30:39 -0400
Message-ID: <20240324233458.1352854-60-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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


