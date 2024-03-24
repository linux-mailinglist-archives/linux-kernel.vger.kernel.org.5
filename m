Return-Path: <linux-kernel+bounces-115315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B229889ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFD61C3362A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1634A1411EE;
	Mon, 25 Mar 2024 02:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjmftE1h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2608C80044;
	Sun, 24 Mar 2024 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320509; cv=none; b=Y1W9DXjqZkICsyHDpcu511YUDN9MpjybEZpJilv7eLd3bCnIkiY7P9+KQV8W3uoPhaO6gTCplos2GZFhmDoBy422WfHN+LVJfc3fJYzyMLB0X4pIW/rcJuz6MilPaOxgurQ/l6jz1w0LCfXKieHA8D19+zY7Ka0KpkPOL2BqHxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320509; c=relaxed/simple;
	bh=8H3S/q5lYOP2vdj03mp5FU8Yxc0yT9/q3KcU1fAJ4V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8csO1VkXkzdaMJh4wdgIUgnYDeV4nVAe+yiYYYJEjGBL9j6dbv2dyCaBkXpNGfaaKJoUVNlU7QJiWxhb5Tfz2bmjXQg73GHy34Zb2Kah9VWZwoomQRI26OLUDRaZJPhq2gEnbFCe/JmlumlX2Lmxgymx0XpNIIxZG59JMfqBBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjmftE1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6385CC433C7;
	Sun, 24 Mar 2024 22:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320509;
	bh=8H3S/q5lYOP2vdj03mp5FU8Yxc0yT9/q3KcU1fAJ4V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PjmftE1h11duJviEgHf1LGlt9bJYoQ/lfdnJUeBohKkNXUepampaLvVBvMv3bEWPn
	 R77US3NN2fAmYf4DQ01OYH4TBl65WuePjztSEzVsarsNwwnEGTyZXOyJhpo7bsKJfl
	 2YTGaDl0NDaWTqHO6QK25HqGn4NmtekMLJRUfjzcQrnl3iOR2uT61w3a+EqxvtjRCm
	 fuDR8L+RgCJVb2cM6O3jJLWK7V/+ARK5kY6ielCXIEyy2GDwY5xfmVYD7+ronjpPQg
	 bXbOdFvbhltcAHLfvCLyV6EZGzR7DfO8YMiJIGXgPHbWUzmPqqggq0IoXlLw1k+wii
	 goJT6yvEk8GbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thierry Reding <treding@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 069/713] arm64: tegra: Set the correct PHY mode for MGBE
Date: Sun, 24 Mar 2024 18:36:35 -0400
Message-ID: <20240324224720.1345309-70-sashal@kernel.org>
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

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 4c892121d43bc2b45896ca207b54f39a8fa6b852 ]

The PHY is configured in 10GBASE-R, so make sure to reflect that in DT.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index ea13c4a7027c4..81a82933e3500 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -175,7 +175,7 @@ ethernet@6800000 {
 			status = "okay";
 
 			phy-handle = <&mgbe0_phy>;
-			phy-mode = "usxgmii";
+			phy-mode = "10gbase-r";
 
 			mdio {
 				#address-cells = <1>;
-- 
2.43.0


