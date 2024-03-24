Return-Path: <linux-kernel+bounces-115652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27BE889D10
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106361C34E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0366351173;
	Mon, 25 Mar 2024 02:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiGFJYGN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC6A1350E3;
	Sun, 24 Mar 2024 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321525; cv=none; b=OInW74bscTYPDbcX1aU8Nv9EtYckjb1tLsZYMsljMStqapIsHsEAeW3k2mxjqQjCUSIMne5075WM11qYh+Yz6GqSNjWrLmoBPu8NdyCRqX+rQe2IlhoxF/36p4w42u+0qpIawml+mY0d5a65SPhM7sERLc1LjX2UPZlbTm77PEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321525; c=relaxed/simple;
	bh=/a1WHaJ3M+aXmVmWxz7JExxl6J9UcQdq0czcxVxW7vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2jKerM8NJEmkFv3QcrEhr46GpM1wuqdYiJJr4MXh8teKjOUzaHetzx3KdduFQEA+nzIAkYTgf6/HiS+LEAlCeGBOx7k8Al8xguHZ5oqwt5rHRc8H52lzS9JdIM1zf9znWbwUzC5PFPZMlUtR7/oI1JPb3eEqzjIKRNzHcUzP98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiGFJYGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D13DC43399;
	Sun, 24 Mar 2024 23:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321524;
	bh=/a1WHaJ3M+aXmVmWxz7JExxl6J9UcQdq0czcxVxW7vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CiGFJYGNBZFfXCKcIQtg4QA7lixdN9YbI2/+Vn7cxyk8TnoX/2bY0YpZal75FDRRB
	 KEDKHWAufQnahHMQLzvdABwZaZ4uSZZx6l7jMXmVIGGButM4Tqzp2/i6ElxNHXSH8B
	 sPlfW5sWMakVNAm3oU0YhG9pgiIYnPQbNf+V0TSqcJsybTFRLbnjtROoMmS79l+Fmj
	 L02YuIO5RYxZgBMX8qW9rpnUUFIVuJWWXbm3TsUsrNjh3PlBJ2y9SaXLN4H1ENoNiE
	 L3Qk4VsE56kXa1tXj2OBSGHq3sSEv5Yk0W1HHQmBuhSQ0w+7qommOoNiTnD1/+LcWy
	 atAYDbHolDXTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 251/638] memory: tegra: Correct DLA client names
Date: Sun, 24 Mar 2024 18:54:48 -0400
Message-ID: <20240324230116.1348576-252-sashal@kernel.org>
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
index 2845041f32d69..fa40c49b070d0 100644
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
@@ -663,7 +663,7 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA1RDA,
-		.name = "dla0rda",
+		.name = "dla1rda",
 		.sid = TEGRA234_SID_NVDLA1,
 		.regs = {
 			.sid = {
@@ -673,7 +673,7 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA1FALRDB,
-		.name = "dla0falrdb",
+		.name = "dla1falrdb",
 		.sid = TEGRA234_SID_NVDLA1,
 		.regs = {
 			.sid = {
@@ -683,7 +683,7 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA1WRA,
-		.name = "dla0wra",
+		.name = "dla1wra",
 		.sid = TEGRA234_SID_NVDLA1,
 		.regs = {
 			.sid = {
@@ -693,7 +693,7 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA1FALWRB,
-		.name = "dla0falwrb",
+		.name = "dla1falwrb",
 		.sid = TEGRA234_SID_NVDLA1,
 		.regs = {
 			.sid = {
@@ -857,7 +857,7 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
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


