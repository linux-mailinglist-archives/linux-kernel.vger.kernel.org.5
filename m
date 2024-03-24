Return-Path: <linux-kernel+bounces-115788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F868897CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1CC29D4AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C388E262056;
	Mon, 25 Mar 2024 03:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TB3jVqwi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA970143C5F;
	Sun, 24 Mar 2024 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321979; cv=none; b=sdM5357HXqsCBCGEt2i1ZlnR2AmLoZzcj89yNrltwBavhp3X8PMIZwhk10t60aTGv+DlnheMpMmBvQcMwkfpSDKDBu6Io+dBeWXuJoq2O1tF4BiH1luyH0+ci9+nT37bAcZd/myRGGnmcRJiM9OIEod9HV0cl7CSo7O2W2aaJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321979; c=relaxed/simple;
	bh=swJwg6DjneyFGIi5z+YW+S1cskoZNEJxEN6z/gFE+oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s60RWmKiy+AZfjPrNOAKgB6FtHGxYiCDslKXg/uMMpPr+kC+rm72mGA6Gum+3XORXiXQRoQsPVEgKg/nmuUIGJ8lsTR/eeVfPxZaCOYfZeH3/r2OKE7MXmk7aULBV0vEgo35OfG4WKODPjY+aepHlkDb9axz1mTth/g6O/N3dC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TB3jVqwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFE0C43390;
	Sun, 24 Mar 2024 23:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321979;
	bh=swJwg6DjneyFGIi5z+YW+S1cskoZNEJxEN6z/gFE+oQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TB3jVqwiWWCmI0QnHwuriWws7Cit9QQpFRwCZu0oQOd86oDCdifvkUOMQIxLprNiA
	 TkgLXkT7m8CaOYLFw0MYaWnaXqQK8iwxGSO/byurr2qaFsPBDu2UR4KRAFR/cpTVc3
	 Sf2bnAP8tKsaV8XvA/zbHLChiCnFNxck3l7YZ0fsVeWWligopo8xB8rjB6jy39/W0J
	 owWJ2/MaFrh4ZoLRy5+eN2ZqSmAmOKrDwXqah2hpnyajVXUp0fuF0FX8KWg6ArCwyX
	 XTa4JTbXcJSjP0vRXaHh3EXYR6Q9LMfV1ai2SH2zW7NfpZtF8K6woQz0NOl/eK9aOh
	 VfAVLhMiUTCiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thierry Reding <treding@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 052/451] arm64: tegra: Set the correct PHY mode for MGBE
Date: Sun, 24 Mar 2024 19:05:28 -0400
Message-ID: <20240324231207.1351418-53-sashal@kernel.org>
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
@@ -2024,7 +2024,7 @@ ethernet@6800000 {
 			status = "okay";
 
 			phy-handle = <&mgbe0_phy>;
-			phy-mode = "usxgmii";
+			phy-mode = "10gbase-r";
 
 			mdio {
 				#address-cells = <1>;
-- 
2.43.0


