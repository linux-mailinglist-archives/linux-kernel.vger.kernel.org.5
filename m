Return-Path: <linux-kernel+bounces-116237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5399C88966E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AA8AB26FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DC83C2524;
	Mon, 25 Mar 2024 03:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTtSQJ5t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71B713C83C;
	Sun, 24 Mar 2024 23:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324008; cv=none; b=nI2c5FXdZnHn3Xp7cuB70aHkx0KjhJDnZHcbrwj31+Z/4P1EucYja3VsyC6v9VLy4rp5iaU+I84fZItZkZqpi4TlwJnSlxLXwLF8ZqdynPTclAHKETsJmPQzubjjoTpk5tXX2AsmKnF6/OLRJIz6q7ZbRSW6ZTdPaALRfWds+lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324008; c=relaxed/simple;
	bh=q/zQI/aVAcj6DReUdBtfbzpmGks9RLFWREZi7JOicZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzbVCKHrK9medmdto64GbR8aREfh6pFm82pNNTGonGw/1mt/mHBqYW0kU1KtQvZh/JSyWskhuuUfUDfLhiM4hgaDqyEUI8OWk2j1sXukjA2muLkck7qMIIxhPkM9f6clwv5XLgJSqLCMnqpuRNFOJgqE264qnTpIqrNlVpSiIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTtSQJ5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024BAC43390;
	Sun, 24 Mar 2024 23:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324007;
	bh=q/zQI/aVAcj6DReUdBtfbzpmGks9RLFWREZi7JOicZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BTtSQJ5tHjGaIJaD5DM+uU+jbDlkdJbzsa4YqiTKRQr8USy9ifwrOB7RwOWi1S5aG
	 YG6gPpkUFPFDbd12l3Uz1vGWFpdiRbWWy4FVIbWoleGzCCn4PMdgVEWEJcMswWAOlS
	 2va2KIA0GTA/q6MnL593fXvnb/VVpA0t49ZO7uliZupQO95ldL5wKrRGqIWgTMdoEL
	 1KK8uu3eqa/oZeAg1AQe3Vor0QxFnclOH+eu9ulCvjqCF3SZbbwdhz5POg0UxMeaMU
	 MnQDYd/BOR5tg2VP+KuXo0hZrCVItK0gNJqISRBaaKteSy0LsUv0uCwSZNEC1kUNPG
	 tRhXS17E+Qqsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 008/183] RDMA/mlx5: Relax DEVX access upon modify commands
Date: Sun, 24 Mar 2024 19:43:41 -0400
Message-ID: <20240324234638.1355609-9-sashal@kernel.org>
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

From: Yishai Hadas <yishaih@nvidia.com>

[ Upstream commit be551ee1574280ef8afbf7c271212ac3e38933ef ]

Relax DEVX access upon modify commands to be UVERBS_ACCESS_READ.

The kernel doesn't need to protect what firmware protects, or what
causes no damage to anyone but the user.

As firmware needs to protect itself from parallel access to the same
object, don't block parallel modify/query commands on the same object in
the kernel side.

This change will allow user space application to run parallel updates to
different entries in the same bulk object.

Tested-by: Tamar Mashiah <tmashiah@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Link: https://lore.kernel.org/r/7407d5ed35dc427c1097699e12b49c01e1073406.1706433934.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/devx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 26cc7bbcdfe6a..7a3b56c150799 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2811,7 +2811,7 @@ DECLARE_UVERBS_NAMED_METHOD(
 	MLX5_IB_METHOD_DEVX_OBJ_MODIFY,
 	UVERBS_ATTR_IDR(MLX5_IB_ATTR_DEVX_OBJ_MODIFY_HANDLE,
 			UVERBS_IDR_ANY_OBJECT,
-			UVERBS_ACCESS_WRITE,
+			UVERBS_ACCESS_READ,
 			UA_MANDATORY),
 	UVERBS_ATTR_PTR_IN(
 		MLX5_IB_ATTR_DEVX_OBJ_MODIFY_CMD_IN,
-- 
2.43.0


