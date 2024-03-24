Return-Path: <linux-kernel+bounces-114026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF7E8887F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCEDF292CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FDC22AB94;
	Sun, 24 Mar 2024 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2HY68e8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67321FB6F0;
	Sun, 24 Mar 2024 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321303; cv=none; b=KV1qZRN4BqobuMhdbqXtYu2Bkpmng4mLnuyEPS8FTgg18PyQ1NJX0S1xBC53NfFUeiP8n76oMyS5qiLmEQ2xTvi4nUTIilYhGlHoloblZr4i77nAhZL19Pwdzyuw8IB1ZNFJC08dmj6sIq/xWCoEI5UIL0AN3494KjNbcYzM7Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321303; c=relaxed/simple;
	bh=KSF7boKFkFUKI5Y7wTzgbmgkVIR1+Hf5SXgY2kEF1mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7JrEuxis0Zsun53viVWoSUWCXnvenqYCRbaa/Bh4opB8E1n28igAcU9J8x/sJtFhke/R08PhgBmX0TMxAuE03pMhpM1PFEte6qLd4ZND5B17WFZdpxgWrWgfbSLFOHiYDV144GWQV6sXemw7FZp0W+0inHYE30fo7SC71/OMEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2HY68e8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAF5C43394;
	Sun, 24 Mar 2024 23:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321301;
	bh=KSF7boKFkFUKI5Y7wTzgbmgkVIR1+Hf5SXgY2kEF1mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c2HY68e8DArQ3uxQxtVBrtbXfxVEbhvmYEcrCmstyWwm87DEVrjNG8mIh9JFOAXa2
	 QufsDkQ9bcpXALzc2OKGOJdk8mMu18egKVD5U71TtutrDczfFDfjcOafkganPksyq7
	 DhtAARSxffKF3lAZx6MSj3fgneS0OaTPuxXX5oBrhSgBf1q7tKKx77C3VWq0jxae24
	 ShbSK1Eh3qS66SfOXb77Ei6DbMSrhlGCcNYK7v6tateMogHFHU6y+abubO6WDjyC51
	 Ph4SXrFtdG2wJDoMwjTqwT2XuFJ3CxD0pDf4ACAXREzS7m0MjU3Pl61z+zkS+tNpIs
	 lxGf/kge3UFBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 024/638] RDMA/mlx5: Relax DEVX access upon modify commands
Date: Sun, 24 Mar 2024 18:51:01 -0400
Message-ID: <20240324230116.1348576-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 8ba53edf23119..6e19974ecf6e7 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2949,7 +2949,7 @@ DECLARE_UVERBS_NAMED_METHOD(
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


