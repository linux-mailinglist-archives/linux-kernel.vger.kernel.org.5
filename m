Return-Path: <linux-kernel+bounces-99402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E481C8787E7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A081F282192
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D5260DC6;
	Mon, 11 Mar 2024 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYwYmvcX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A37154FBE;
	Mon, 11 Mar 2024 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182314; cv=none; b=E8rIklwST9naV9XQoyUme4KOfDdDJoTluCnTV9cC1RFBiEF/Jve/yLsnxRfQci5Dj0Y04aAsIvOydbYoJI7he6+bLVqNkUjWmZDB7VbEdb6PseTPE5YzT8j1p0r6YviA4R5BaOH0PjUOseCuK0SuGbdrFZttSg7DydX6hpYc0xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182314; c=relaxed/simple;
	bh=r4GFyKH0h6Apl50/sMqhWNcLGuTweQQToqAfKdoAC6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VCn+SadXtpaGG2n7knQRhc72KiGnvXmfcaJ0ZM8kwYdimb8zRbzxgiVsQWxQ6XeA/VFtx6L/DiVFqDkANmFY+Jps+EhKkE3EntVcqIMz1LD4g+l7JyRDhQM7nZNCC/Q1TLkiJKVBeBJCX1K2lqiuUlypAm5iwPMLGIiCGxvsmiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYwYmvcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12770C433C7;
	Mon, 11 Mar 2024 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182314;
	bh=r4GFyKH0h6Apl50/sMqhWNcLGuTweQQToqAfKdoAC6o=;
	h=From:To:Cc:Subject:Date:From;
	b=aYwYmvcXzikhhfv+cmQAJenXdLDpKStTCwqTrjUeUx14+8jZ0cN1RZGvv9Ur00ffe
	 g7NEuytFiFGNIKVVOSrF/sfnGn4dlZ+2Yq8HztZ9O7jtMWRr8d/kOVKodFXxv09kLe
	 ynt4sEzBPMS0ROpsviuYFm6Kf3tMqTmVnT0kcK9WVAX9fc4vkmIWcgQaQWbi5eX/LP
	 0PAJ9VE0MD8S3K8alFw/4YzBBd0flK86N8gptAG/iKSxHqA5zYOoRX4wpCr6RXFZvM
	 lPSLs6eW+0WR+A2oBqNjoWUgxRA0QJiVL8CDzx/gnJIm2BDKIrvLLn3oFkbU4doZoR
	 +J5CUWNee0OSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thierry Reding <treding@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	thierry.reding@gmail.com,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 1/7] arm64: tegra: Set the correct PHY mode for MGBE
Date: Mon, 11 Mar 2024 14:38:19 -0400
Message-ID: <20240311183826.328535-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.81
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
index f094011be9ed9..8099dc04ed2e1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -2024,7 +2024,7 @@
 			status = "okay";
 
 			phy-handle = <&mgbe0_phy>;
-			phy-mode = "usxgmii";
+			phy-mode = "10gbase-r";
 
 			mdio {
 				#address-cells = <1>;
-- 
2.43.0


