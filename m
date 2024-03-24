Return-Path: <linux-kernel+bounces-115763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0570888990A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F0ECB35378
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B9F2618C2;
	Mon, 25 Mar 2024 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJe/DZKS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627101448EE;
	Sun, 24 Mar 2024 23:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321959; cv=none; b=JVll19vW1/SpAVuQQ22zDA06GoJDTSuD+ovwTnNK5rU37a8ULf+jouW8oiCNOyKhTUljeZLLyK6c7mtph9Dqw+LtY6V9eNPwu1+hXeHboKwfDU9XzKTX4ufk0DYIWIbnPDcoLk4IRIc1TYx+we0SswdRX1ICFaabHZu3muevzSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321959; c=relaxed/simple;
	bh=xQC6o6+q3OtIE2gwfV+uYfObv8PJwHK9mSaRmCA0uMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hh3EporKyPjoBzaGaR6IMbdAdf5P4BFHzwyZSrGkMhp68FghOA5x+7Q5EL8D4WI9chYn4tbwKzQWWccr30PZ2N7GDBKkSlWTdOpcpzzBgjQB2p4Q/zEZriGIYYkvXoSJv8V/8nipBdnrs4zMN2bFXvFsmiMnJp+9mblHLz6DJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJe/DZKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2E7C433C7;
	Sun, 24 Mar 2024 23:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321959;
	bh=xQC6o6+q3OtIE2gwfV+uYfObv8PJwHK9mSaRmCA0uMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hJe/DZKSt/S7ZE6m/VwbW57VsxPLy9aHdpy1KWXmuGkpGQ8FaxvOAAG5NZ5dyLuZm
	 E+QgRCPIf+yDXbLEoUTD76SPFnF00z4dJH8rXexLcSUTHj5Yjg+ytzj8rCr+mHlWNv
	 b26Ohf8AmTL3PpPCxUSbF1CYTjtlLisZVNGYdA5LfGBdmT9g2PBQ5cc/V5mB/Sqs34
	 8Y+L0u4vKZV9TgNXofRusaxtZYV0L8KrMzjCfMPmkx8KFHocQYkvysuQMOattiG8BS
	 HCHlPkTgambYWGqgTp4iKs3CrwDZF/TzncT2PAyL54MQVPeYO8Be+U1t9CuPyo3bYR
	 GIlYHzSvBux0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 031/451] RDMA/mlx5: Relax DEVX access upon modify commands
Date: Sun, 24 Mar 2024 19:05:07 -0400
Message-ID: <20240324231207.1351418-32-sashal@kernel.org>
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
index f8e2baed27a5c..7013ce20549bd 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2951,7 +2951,7 @@ DECLARE_UVERBS_NAMED_METHOD(
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


