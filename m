Return-Path: <linux-kernel+bounces-113115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B94888194
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526601C21AE1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DE256740;
	Sun, 24 Mar 2024 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kN126w52"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5E015A4B2;
	Sun, 24 Mar 2024 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319923; cv=none; b=QFnJek4hb5s4p6CeDrqKsTMG7nsc+4DF85mID9Ppsqx40PHXVvuRh1f9sHP3rLPV6/8MNrm8pVXH7XP4dYGSmc89uIiMFYoc7K5WGrYszrhzr98K3xHArqWqzX7P4G/xrp6KJdk4CSPoSoT24/CiO0sM+HJwD53Q2jOihxx6Ois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319923; c=relaxed/simple;
	bh=zUMXudOLJzroedM2iuRziZdAstmhElFFeH8iJ3zqLMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUO1lpBzXM3vvZeFD1ownd0FC4orXyIoH1ZdTxjr4sbgMdLjGm/PUrQ+KWZpxZVWColDXO6QI3yjoh450wRK30x9plRjiqTtbjP+GlE6629Of5bEd6xSwkrTqLW+Am5/ztRp/YGU8rRMjOkJq+pguyFZiWlvlq1YBJAFx+T5ib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kN126w52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC63C43399;
	Sun, 24 Mar 2024 22:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319922;
	bh=zUMXudOLJzroedM2iuRziZdAstmhElFFeH8iJ3zqLMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kN126w52hxJU5eUd6SSPhU+QgMRxupk/oDNvzw1t90C0BUwQBN15HnWkdDQgyYvOL
	 +0RWgw1NGfHSI5oFzKdzf1NOKkW2G8mq35YGNQsN1a+3zkd8ppuIvOcnA0jSHaj103
	 Agm18Do8CeI420RZTV5/dUI0NQBx0bWUCh4QcGNhziDXB8y8RXO3HvtUs4I42fumRh
	 rtVGbppeFQHVvSFpC2xjSxmEHbGN3+TckEoS3Z3Mx/zs3eYoLGcKHMh2mUpyBiOs8X
	 izch5N2agR6krpN59rIrwH9X/368hiyz+2X+QWGSGihh2dPepTFpNBc0JgRY4GpCuG
	 khImLDLqLkp8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chintan Vankar <c-vankar@ti.com>,
	Andrew Davis <afd@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 228/715] arm64: dts: ti: k3-j784s4-main: Fix mux-reg-masks in serdes_ln_ctrl
Date: Sun, 24 Mar 2024 18:26:47 -0400
Message-ID: <20240324223455.1342824-229-sashal@kernel.org>
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

From: Chintan Vankar <c-vankar@ti.com>

[ Upstream commit 9a0c0a9baa2d1f906589d715f9baeab93e7fcdcb ]

Change offset in mux-reg-masks property for serdes_ln_ctrl node
since reg-mux property is used in compatible.

Fixes: 2765149273f4 ("mux: mmio: use reg property when parent device is not a syscon")
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
Acked-by: Andrew Davis <afd@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Link: https://lore.kernel.org/r/20240213080348.248916-1-s-vadapalli@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index f2b720ed1e4f2..56c8eaad6324b 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -52,12 +52,12 @@ serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "reg-mux";
 			reg = <0x00004080 0x30>;
 			#mux-control-cells = <1>;
-			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
-					<0x4088 0x3>, <0x408c 0x3>, /* SERDES0 lane2/3 select */
-					<0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
-					<0x4098 0x3>, <0x409c 0x3>, /* SERDES1 lane2/3 select */
-					<0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
-					<0x40a8 0x3>, <0x40ac 0x3>; /* SERDES2 lane2/3 select */
+			mux-reg-masks = <0x0 0x3>, <0x4 0x3>, /* SERDES0 lane0/1 select */
+					<0x8 0x3>, <0xc 0x3>, /* SERDES0 lane2/3 select */
+					<0x10 0x3>, <0x14 0x3>, /* SERDES1 lane0/1 select */
+					<0x18 0x3>, <0x1c 0x3>, /* SERDES1 lane2/3 select */
+					<0x20 0x3>, <0x24 0x3>, /* SERDES2 lane0/1 select */
+					<0x28 0x3>, <0x2c 0x3>; /* SERDES2 lane2/3 select */
 			idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,
 				      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
 				      <J784S4_SERDES0_LANE2_IP3_UNUSED>,
-- 
2.43.0


