Return-Path: <linux-kernel+bounces-115272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3458889C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42AD286050
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DFF15B137;
	Mon, 25 Mar 2024 02:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY3G22KK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAD77640E;
	Sun, 24 Mar 2024 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320469; cv=none; b=jdOgcIPxvk7ws3+zU3hFZWp9WtNNDIQI/QrfxsVhekpBkN3+tsCHfMufZYV3JiadA+jlb51ZTBRKPpAoh6WoAsk9dP4W/nprMYFkm4ZMXegquxzH3p16XQBVafdMEZ6TwX57OIdTvwzN65nl9nuN3aiA/PX9VUdQU/wRIIo5mJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320469; c=relaxed/simple;
	bh=KSF7boKFkFUKI5Y7wTzgbmgkVIR1+Hf5SXgY2kEF1mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FS7AJmhuJnkp1cT141gjTB+o4Eg7sgkxZVM8ccGDSiQZU8oJ3ep6jsTMW/fMQ3llHHXmFma1ZMLRVB2JTYIePxBnm4Y4Yyhb1nZih8eyqO899r/RsJ5SqNWkA5I5Cp7VwKiZ8lNIOHm6lBAvLUAPCROjIH8E/fVLHB6M0blSMt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY3G22KK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2CFC43390;
	Sun, 24 Mar 2024 22:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320469;
	bh=KSF7boKFkFUKI5Y7wTzgbmgkVIR1+Hf5SXgY2kEF1mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GY3G22KKEVEaUjJmT/WpSgpoW10OsQ/muKK+H18AjOXLaYiyeEUJx1oNjW20j5x5U
	 n2gpDeiiOf8OfBHEUn334Zkg+ZuXCSV61zioGxizzrYcM2FRU1vde3Nazi7lFLs7NG
	 0t4WFbDJr1PmSEhIHVX33hf4rbWZhxnIkAyDdoTPC78skFNTg2VxgVO2OY77/wjjk0
	 5w/ecF0+KysDmm9WyQhfWflrTSsQuS06rBhefsjcyt0zx8GWn5IvxoU7bgdA4UtDRk
	 k/vwAmiU4C+olc+7wO7HYjkv7wUfA1nffZaEUCI6eNQi3+2h7xhGh5hsk1yfNg+5xC
	 cAeuCAHTurEMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 028/713] RDMA/mlx5: Relax DEVX access upon modify commands
Date: Sun, 24 Mar 2024 18:35:54 -0400
Message-ID: <20240324224720.1345309-29-sashal@kernel.org>
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


