Return-Path: <linux-kernel+bounces-113156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0227B8881E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A0C1F20B53
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF9117265B;
	Sun, 24 Mar 2024 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPa9t2tK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA5172635;
	Sun, 24 Mar 2024 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319958; cv=none; b=b950t6KY73cTw6OsYo5dpMAVQdq3v1PfFYdtL+C35AnWW6YsLMkn1Y9Bg1hQTCg6a8wePQHD02gvbYFB/T3j+ljuBe3jc0w6hHb47n+r/cfwXRtRerI08j2elR4R2FT7GEaNTwX0kpxKetOsUi/aKhi4wGiEuKCrSLz2Nv9c/8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319958; c=relaxed/simple;
	bh=qDdkBp52whbIdsEQJeQ73Fo2VF9QAYIUfc9LlJxEzNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YW1aAUOWy3k8KTHThpZwDiFaf6wcvS9qsbYIwb8qqUB6mutRsgaPLPDBBo0JXuSvVTqoL1jf3Vi5GqwYtGwSoZ3sSlqSsYhZ316ogtZPUQcwv9DmmzTLhLxwJDK8MRaVNAi4LxeX7UwNJURsGG+iAyjIJ7pXVyl6oSRS4Wtw0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPa9t2tK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFFAC433C7;
	Sun, 24 Mar 2024 22:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319958;
	bh=qDdkBp52whbIdsEQJeQ73Fo2VF9QAYIUfc9LlJxEzNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rPa9t2tKJr0nhCbPYgHzAS57oK111cezEV4sOEMkTIThMvXmdE1sYpZBv3Q3pflc1
	 XlPkFgf8xWIEDchuFOCaw9z5OX4eFfbpmLckFBVdx0Sw1Rz+ZuijsfAyMnqIhsaR9m
	 4DxhpZMBBS9YCw55Ua7hmoiOJOZlSlsi2mDXpIMdIe6Qdak4r2mHu911ATjXM5GzKz
	 yoQ7VlDMDFG63VWo6EDa4WB5YK62fB8oPHUB6lZImzfVrOfTFRqTDn41lxOfdu6E5u
	 MhQiiWw8WilEoZFnaLAlrr/bKUAU2rSGzYS7WAJ7cuL7OGke2FvUd7Jpjxxy1ybICa
	 gwW6tDNtxzXrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 265/715] ARM: dts: imx6dl-yapp4: Move the internal switch PHYs under the switch node
Date: Sun, 24 Mar 2024 18:27:24 -0400
Message-ID: <20240324223455.1342824-266-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Michal Vokáč <michal.vokac@ysoft.com>

[ Upstream commit 79978bff2e4b8e05ebdf5fc3ee6b794002393484 ]

We identified that the PHYs actually do not work since commit 7da7b84fee58
("ARM: dts: imx6dl-yapp4: Move phy reset into switch node") as
a coincidence of several circumstances.

The reset signal is kept asserted by a pull-down resistor on the board
unless it is deasserted by GPIO from the SoC. This is to keep the switch
dead until it is configured properly by the kernel and user space.

Prior to the referenced commit the switch was reset by the FEC driver
and the reset GPIO was actively deasserted. The mdio-bus was scanned
and the attached switch and its PHYs were found and configured.

With the referenced commit the switch is reset by the qca8k driver.
Because of another bug in the qca8k driver, functionality of the reset
pin depends on its pre-kernel configuration. See commit c44fc98f0a8f
("net: dsa: qca8k: fix illegal usage of GPIO")

The problem did not appear until we removed support for the switch
and configuration of its reset pin from the bootloader.

To fix that, properly describe the internal mdio-bus configuration of
the qca8334 switch. The PHYs are internal to the switch and sit on its
internal mdio-bus.

Fixes: 7da7b84fee58 ("ARM: dts: imx6dl-yapp4: Move phy reset into switch node")
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
index d2b3e09eb7df8..c32ea040fecdd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
@@ -117,14 +117,6 @@ mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		phy_port2: phy@1 {
-			reg = <1>;
-		};
-
-		phy_port3: phy@2 {
-			reg = <2>;
-		};
-
 		switch@10 {
 			compatible = "qca,qca8334";
 			reg = <0x10>;
@@ -149,15 +141,30 @@ fixed-link {
 				eth2: port@2 {
 					reg = <2>;
 					label = "eth2";
+					phy-mode = "internal";
 					phy-handle = <&phy_port2>;
 				};
 
 				eth1: port@3 {
 					reg = <3>;
 					label = "eth1";
+					phy-mode = "internal";
 					phy-handle = <&phy_port3>;
 				};
 			};
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				phy_port2: ethernet-phy@1 {
+					reg = <1>;
+				};
+
+				phy_port3: ethernet-phy@2 {
+					reg = <2>;
+				};
+			};
 		};
 	};
 };
-- 
2.43.0


