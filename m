Return-Path: <linux-kernel+bounces-115063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36066888CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1FB1F29411
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3B01C3212;
	Mon, 25 Mar 2024 01:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZOgX1fJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B177528A58E;
	Sun, 24 Mar 2024 23:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324062; cv=none; b=N2fw6f4Wo4sbi2/6v/UHbmQksGl3eoi55h6Q3tYWEhkc0QXw98hQ5GqY4CHmtqyz0avgDXxmSBot+KBdwl3KelGsVR4vJqfKqloaICGDLQjfkl1NLBQz3Gt0E7QWASPRDT9KKpuKgz0IzfalFx5UoDC2pN8SAXCeJ1J2BjUgIsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324062; c=relaxed/simple;
	bh=qWzNswTagMzZ48FQkcgy/Cc+8eoWbnQerR1hfc10A88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBEjh4od+0qQSUegvqPM7w7zKDeKdk5MZVz2sdDMNu5FBw52CeKCbMISycWMoPl7FmLwMp7TY3eFzNDo6yzTnFOydSmUkb+b0HCD3Ery9kOCriynk+8cOVKfnMRm6C8uqwzR+a15anJ2MVA8Q1GMqTZLijTc/IHdMUc7Dr/3Mj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZOgX1fJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F088EC433F1;
	Sun, 24 Mar 2024 23:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324061;
	bh=qWzNswTagMzZ48FQkcgy/Cc+8eoWbnQerR1hfc10A88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DZOgX1fJbnAcIo8vAb7UizVTIOpyO1ffjuJ/TkRv8GEb7GIfyGzVGfJzIUqqY6zrF
	 AsioLqgk2tpaa6fYYD3u8EiJ2w25CYWkyex9UseDROd2KfwtgwOP6pw2hSKTuGbpXb
	 y12DSa9trwG6O/uF/P4vvqgbE+c4hde/ZzcU/IfXtP7RmfEIGl1JgILnOT17zQrnVi
	 d0pi+BLC9fBajZtnGYKQWvFWi6HnFmPuLzfGpwty9cOd9+IK/wn8/rNelTC3V5L2pl
	 JDPjc50Na+nQUEf7YoH4Lf7BhdB3xtpJVCvEqoB3zQ3v56/x18GMqvkvmP6VENjj9d
	 6/nbhhe8x/BQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 062/183] ARM: dts: imx6dl-yapp4: Move the internal switch PHYs under the switch node
Date: Sun, 24 Mar 2024 19:44:35 -0400
Message-ID: <20240324234638.1355609-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 23 ++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index e86f409ca8801..68af441e78948 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -108,14 +108,6 @@ mdio {
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
@@ -140,15 +132,30 @@ fixed-link {
 				port@2 {
 					reg = <2>;
 					label = "eth2";
+					phy-mode = "internal";
 					phy-handle = <&phy_port2>;
 				};
 
 				port@3 {
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


