Return-Path: <linux-kernel+bounces-113119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C261488819C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D03A281DAD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B428515B10E;
	Sun, 24 Mar 2024 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHBeiNQb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E641115B0F7;
	Sun, 24 Mar 2024 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319927; cv=none; b=h0xHgVq904on9CMS9gcX5VpgpW9hMWXnTHYWxL3+oaA0sL5jo8rXXA6zAZPY8wzhMxLmMR7awoNuGCW1o63kzhMNx7h5pWHjyizdv8D+qvJkoYHB1E22nWPgz70GY7I3B3HotxhFvII0qvaINsxccXN762OAjEol+wU1qTpuD7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319927; c=relaxed/simple;
	bh=FqGypTOb490W/ywG+V8ao7/xpZ8vZxNiO43DA4jiXGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbXJMA4Hw9fFo0CM18eRSnow2C0RwuVmEzVozHND4zEUdBkCQIscKBwLJZ/V/Ak1V44NiHS2Uw10LcLYpVIC2xKrzZMfuqR2QaVnCTZPFvnQViUCcPudMuFpSKlHwyWXqGQmUVkv1udWnGYSrfxRYuLiaRc/TfFLMN71wFiINbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHBeiNQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CD6C43399;
	Sun, 24 Mar 2024 22:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319926;
	bh=FqGypTOb490W/ywG+V8ao7/xpZ8vZxNiO43DA4jiXGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oHBeiNQb+Bhi4uL5yQT9gNH6JgwLO2RDImgQ4cIAvP/LmYxR1XkSHau9ZiHs1EOn5
	 EB2tmayZcroWnN0VwGcuzgmVizE//aO20UIgH04ber2GC15Kdh/zUjDbQSSgAABD6q
	 G8BE6+qkD2dPAKqcebRgCgCk0q0S1DzQdQV+1DI/cCRx8A7Ri06lCHZnvoT3Kc+/Uy
	 2rhG9FC1d6oJtVHbrf45o+02Fd0qcQIcLTvnIzqesmP6o7UtIqYLZb1GFE9URu2Ug7
	 ZlduYO1YuI92dm08Sdgf3kSjq57WlTqVvA2lJo9vI7D30X1/KDPWCBbaUd1B1SdwHd
	 Rlmedjw+xohPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 232/715] memory: tegra: Correct DLA client names
Date: Sun, 24 Mar 2024 18:26:51 -0400
Message-ID: <20240324223455.1342824-233-sashal@kernel.org>
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


