Return-Path: <linux-kernel+bounces-113147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A288881D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D128283AA4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31482129E88;
	Sun, 24 Mar 2024 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdVtbNoo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F95016F910;
	Sun, 24 Mar 2024 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319952; cv=none; b=NTZNMRsVXSxNHwuAkVsYASPaDSCvZrCrW3tD74N/lfWFbjfMVxTKESj6T7jgr49OBbm0kijke1XjkTg9GooizZcBIJC89t408qRwg5Od2rtuuDzB+LRYdx9UJMMwchXXHn1oLtBsZgs+IV8hKJZwC9zG5SV9Zji7ekaGh34X4vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319952; c=relaxed/simple;
	bh=Xr8kLLrVwgeoPlmaIABADrI/R7hOw5vbzs+NXDMVYOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehhMvj1VHFaTqxD8QStPhUFg5xBIh74CNdBviEQ2sDhg2qD1axWIe2t/Gztd6zWXt9Qd7ernQ/pveQ9h7MEG48vU10Nu5UeiNc8Jm4y9wjns1kyTGnkV2vYRqr1bvPUtom3yWgRXz1Fltub9ZLg+L9eWXcHLolXe9Icvr/DKCgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdVtbNoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983E7C433A6;
	Sun, 24 Mar 2024 22:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319952;
	bh=Xr8kLLrVwgeoPlmaIABADrI/R7hOw5vbzs+NXDMVYOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kdVtbNooXZqDUSJQ/PcW4kEBfIcJrWhI3Mqf4QSYbB1mVh3wPuPJglV0Zd1oWMbqf
	 ipGn7upTCCS/264CUhevNHa7DNQGv/zJetLIUgyjExyWidly8bh72LqEGAORi+l97s
	 6V6j0NCc1zQlXGxQbY+jb2DTXDJ4ziBK3U7GNY49eAZpXYvR3OuKs31pmmbS3Ro2Lq
	 VRFdDkwhighAN33f9+l0GXJ8NmCdWgwcddGi1rlfMkBkPUgesCE4tv5AcLxDq7NhkQ
	 HN6pa/cHawxbFP2Zgc8ZnqJ2hPPy1yJ+S+dIs6/nbWvyPYpQDU5NSAqHrWKFP4PZFx
	 x9TYyot9tWzgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 258/715] arm64: dts: renesas: rzg3s-smarc-som: Guard Ethernet IRQ GPIO hogs
Date: Sun, 24 Mar 2024 18:27:17 -0400
Message-ID: <20240324223455.1342824-259-sashal@kernel.org>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit 150d81f7a260f36c118cbec253fdd493c671dc29 ]

Ethernet IRQ GPIOs are marked as GPIO hogs.  Thus, these GPIOs are
requested at probe time without considering if there are other
peripherals that need them.  The Ethernet IRQ GPIOs are shared with
SDHI2.  Selection between Ethernet and SDHI2 is done through a hardware
switch.  To avoid scenarios where one wants to boot with SDHI2 support
and some SDHI pins are not propertly configured because of the GPIO
hogs, guard the Ethernet IRQ GPIO hogs with the proper build flag.

Fixes: 932ff0c802c6 ("arm64: dts: renesas: rzg3s-smarc-som: Enable the Ethernet interfaces")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240208124300.2740313-13-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index f062d4ad78b79..d33ab4c887878 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -193,12 +193,14 @@ &sdhi2 {
 #endif
 
 &pinctrl {
+#if SW_CONFIG3 == SW_ON
 	eth0-phy-irq-hog {
 		gpio-hog;
 		gpios = <RZG2L_GPIO(12, 0) GPIO_ACTIVE_LOW>;
 		input;
 		line-name = "eth0-phy-irq";
 	};
+#endif
 
 	eth0_pins: eth0 {
 		txc {
@@ -234,12 +236,14 @@ mux {
 		};
 	};
 
+#if SW_CONFIG3 == SW_ON
 	eth1-phy-irq-hog {
 		gpio-hog;
 		gpios = <RZG2L_GPIO(12, 1) GPIO_ACTIVE_LOW>;
 		input;
 		line-name = "eth1-phy-irq";
 	};
+#endif
 
 	eth1_pins: eth1 {
 		txc {
-- 
2.43.0


