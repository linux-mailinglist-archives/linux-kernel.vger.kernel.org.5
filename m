Return-Path: <linux-kernel+bounces-114935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D15F8892A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1910E29D866
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CBF73534;
	Mon, 25 Mar 2024 00:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsRyly+b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A717967E;
	Sun, 24 Mar 2024 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323643; cv=none; b=U6GMe6cybsX/7+7QmMTJiYU1l0MZccVCwLVT3QD4Mlt5//hGvFmoYuj7Nk5jvxlUbiw0Ko94+6HotfPREhs/eGiIoEKmCDJvd3EEU+omsChYFflv2QkGmyd+AQgERuaK3J4o6pV6JZbPcRyOyu3P1E4d5jLwisXOw5zdfULKnjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323643; c=relaxed/simple;
	bh=9eC06TIqVP4YEX5xtazcIFSDbMDbYTC3Hpi0cb+4aWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZxZTs9WIKrKhn5wU9RG8G/dl4JZsrepzUThsgWKVdwCPAlD0VUFOSHqUGBkWxaJ1n6xfGHjERrv+aLo3u56j4D7AomhBaVJSxW89A292tmO+6qODhY2I7d3GatRmT3R0xcPnDNIvYdJvYuvSfK+eoKl/IeETA0PD/+1Vas7V8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsRyly+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B6FC433F1;
	Sun, 24 Mar 2024 23:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323641;
	bh=9eC06TIqVP4YEX5xtazcIFSDbMDbYTC3Hpi0cb+4aWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KsRyly+bdyJVs10sCVleve2HoaYGh0ojO6Yj5PsnwfnJb0sxkunMSCvhPx9Law1kf
	 q/POwOHKe9O3zcGxX/WeegwL8ja+aRGuEgzzYf2VeaNYXlZRHBDd4Bw8TWg21zCQIr
	 dD+6i8YEMDqpzL86o/p+WokHk8x6XEKmXft13rPE0oov3ktG+2fB/cr/NwFaSkz5jz
	 Nq/XcNfDCeV6eRV9apH5rtWeOzDlLQqFsPGOZr7jed4Eg4Z/Q1jI2ozQG3cPgmxzFv
	 ikFdq2ezSXpYDuBE8g9be9Y2aGq/DG2cEe9muCtuBJJrMwGucO0mQJi/X5hILjWoGm
	 Fke+6U+9esM9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 013/238] RDMA/mlx5: Relax DEVX access upon modify commands
Date: Sun, 24 Mar 2024 19:36:41 -0400
Message-ID: <20240324234027.1354210-14-sashal@kernel.org>
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
index a56ebdc15723c..f67ebd9f3cdd1 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2780,7 +2780,7 @@ DECLARE_UVERBS_NAMED_METHOD(
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


