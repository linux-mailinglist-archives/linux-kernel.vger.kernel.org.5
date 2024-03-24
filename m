Return-Path: <linux-kernel+bounces-115479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7CB889C34
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C6F8B21857
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9798B227E3D;
	Mon, 25 Mar 2024 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tN/F9ML+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A735B1D6862;
	Sun, 24 Mar 2024 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320720; cv=none; b=VNbrpyNXwkQWAAe1sWR8/Az/4AN9skhQJMUvn7IQUXFx4bYvufaXxErUPnStf2sz/vwCHVk+5mfG5t1u7gzfHe00e/1yszyFCouVowB0gONt9kvxFtwYekowBIdvGiSMpSBfGBp8wq/oBglWIe0PIVquCrQUezBvU3HzciqZCaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320720; c=relaxed/simple;
	bh=FqGypTOb490W/ywG+V8ao7/xpZ8vZxNiO43DA4jiXGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4T6iC09b3KrR8xcWtYxYCYADspVCPPMusy0vOOnbIFJM+4mjk0jbRGcrFYQ4J1JILOuIOx/lXGCwJmwObTmuWTPl2/X2RSv7m7SVE2gTJ83sIpYM89nQ8OqgOulAUpup5Pod3BuotuXq80YctDyAaKuf4P8XiAyEm89UBteRrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tN/F9ML+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EFBC433F1;
	Sun, 24 Mar 2024 22:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320719;
	bh=FqGypTOb490W/ywG+V8ao7/xpZ8vZxNiO43DA4jiXGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tN/F9ML+nPBPrptGP+VKQWOv8kj2/qdM3C1zahK8PxAeY2gJ+EZxIC+Sm/GxEhbKb
	 TxDh9hpgCv0MlMBfqHWcOR20MKnpPqaQh2OdYXz87whQydnQgXOpR9Oovz/7JiSe4o
	 SS/n1KQM1drQ0FIdTOOUKsLtCDSPz8IPNR7z91uXQbUociIEXVMPFLLGsh0j8NyUPK
	 3MiS+bd6HyX6Bw5b8Vy2AFWLm8iLS5hdBxqXOzwRbs3SznrzbW4EBNuGIHxPUNZri4
	 dAqauwB049TEyhch/Le+ntBFIOaadnLuK0NS/bS+V6MXAmHzMUGAyGUpLvW77Zm25e
	 AyOBS+ezrY/xg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 282/713] memory: tegra: Correct DLA client names
Date: Sun, 24 Mar 2024 18:40:08 -0400
Message-ID: <20240324224720.1345309-283-sashal@kernel.org>
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

From: Jon Hunter <jonathanh@nvidia.com>

[ Upstream commit 51d915cbeef4c7a154f5d810b1e10d8125f2b0cc ]

Some of the names for the Tegra234 DLA clients are not unique and do not
align with the name of the client ID definitions. Therefore, it is not
possible to determine the exact DLA client from messages that print the
client name. Fix this by correcting the DLA memory client names for
Tegra234 to align with the name of the corresponding memory client ID.

Note that although the client names are also used by the interconnect
framework, interconnect support for the DLA clients has not been added
and so this issue does not impact the interconnect support.

Fixes: 5cd24ca0985f ("memory: tegra: Add DLA clients for Tegra234")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20240220124430.19072-1-jonathanh@nvidia.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memory/tegra/tegra234.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index abff87f917cb4..b8a7af2d36c11 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -121,7 +121,7 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA1RDB,
-		.name = "dla0rdb",
+		.name = "dla1rdb",
 		.sid = TEGRA234_SID_NVDLA1,
 		.regs = {
 			.sid = {
@@ -407,7 +407,7 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA1RDB1,
-		.name = "dla0rdb1",
+		.name = "dla1rdb1",
 		.sid = TEGRA234_SID_NVDLA1,
 		.regs = {
 			.sid = {
@@ -417,7 +417,7 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA1WRB,
-		.name = "dla0wrb",
+		.name = "dla1wrb",
 		.sid = TEGRA234_SID_NVDLA1,
 		.regs = {
 			.sid = {
@@ -699,7 +699,7 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA1RDA,
-		.name = "dla0rda",
+		.name = "dla1rda",
 		.sid = TEGRA234_SID_NVDLA1,
 		.regs = {
 			.sid = {
@@ -709,7 +709,7 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA1FALRDB,
-		.name = "dla0falrdb",
+		.name = "dla1falrdb",
 		.sid = TEGRA234_SID_NVDLA1,
 		.regs = {
 			.sid = {
@@ -719,7 +719,7 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA1WRA,
-		.name = "dla0wra",
+		.name = "dla1wra",
 		.sid = TEGRA234_SID_NVDLA1,
 		.regs = {
 			.sid = {
@@ -729,7 +729,7 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA1FALWRB,
-		.name = "dla0falwrb",
+		.name = "dla1falwrb",
 		.sid = TEGRA234_SID_NVDLA1,
 		.regs = {
 			.sid = {
@@ -917,7 +917,7 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA1RDA1,
-		.name = "dla0rda1",
+		.name = "dla1rda1",
 		.sid = TEGRA234_SID_NVDLA1,
 		.regs = {
 			.sid = {
-- 
2.43.0


