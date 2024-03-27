Return-Path: <linux-kernel+bounces-121900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523A988EF27
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF70B246F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0336131E54;
	Wed, 27 Mar 2024 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="NWHVKnci"
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6049B152515;
	Wed, 27 Mar 2024 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567626; cv=none; b=rken34ksIsUP5vWI+suDbp1quShfc3XCWnxKMhJHWEPFjtvymx5R6UFqnEGGngKrp82PIR/6jpV+JC1N6u+CZbvP0OaYpZpXt2LZOQkdX2B+j4F19kStkPDhzSEVCdrNHSOa+OGxzO6Aimo9Y9u+LDoygqJ9uCqpy8726dXYESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567626; c=relaxed/simple;
	bh=plrKOI/0dfIPwEDH00nMhgV2c3PC1PSWWCuztwgZtMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXPbn360CbdiJIgRZK4YqtnUcCP3ncf0jNe0asUpHfqcSkweYl+6qXF+kzeZ8XmjVCXCKge12fXBOXEq0Le1FXvtBF80ftq1Nffihb5mTiEkfChLBUpFc40yRPNmTuKbTaVnY5NYD/NL6MjIEIb5ARA32zqz3b9BNdf9vdwtrwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=NWHVKnci; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=JvOtujP2hw1jZp38Opj2EyPsjN/F14SK8Ijf8kv0grg=; b=NWHVKnciuFbROEAcxxjmL6mKM5
	G9daR0oSoXCGk1ilMPcgDoF7MStJZfyjFEyL0rlVQRJ6Mt87PAzLyp0MO+sq+tP/m4YImHPeoACHL
	7HAWfzlR0mQ+720/nncIUbFlWSNeGCcIXMr/UeVdQTuwSL1TgpwPQh9G3XLzX0vphuYM7DyLfZ+Nh
	6wivJNpyzd0h03vTtSgzL7Yh5V31G9oDUPzsNTkGwYdLKSXgwptWzvIq0iCNmFoNFke3H2u8bqRmp
	RMnUBlxwG7nOGg4cf2M5VOhU5grsO98XqaYKttE37ZLadzC3IjjqdlylG+25wI1pZ2XrQensl0V2x
	NROXwfSg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1rpYvN-000IrM-74; Wed, 27 Mar 2024 20:27:01 +0100
Received: from [185.209.196.215] (helo=homedev.localdomain)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1rpYvM-000Iyc-GM; Wed, 27 Mar 2024 20:27:00 +0100
From: Folker Schwesinger <dev@folker-schwesinger.de>
To: Vinod Koul <vkoul@kernel.org>,
	Yogesh Hegde <yogi.kernel@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Ruehl <chris.ruehl@gtsys.com.hk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Folker Schwesinger <dev@folker-schwesinger.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Christopher Obbard <chris.obbard@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: rockchip: Add enable-strobe-pulldown to emmc phy on ROCK Pi 4
Date: Wed, 27 Mar 2024 20:26:37 +0100
Message-ID: <20240327192641.14220-2-dev@folker-schwesinger.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327192641.14220-1-dev@folker-schwesinger.de>
References: <20240327192641.14220-1-dev@folker-schwesinger.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27227/Wed Mar 27 09:33:27 2024)

Commit 8b5c2b45b8f0 disabled the internal pull-down for the strobe line
causing I/O errors in HS400 mode for various eMMC modules.

Enable the internal strobe pull-down for ROCK Pi 4 boards. Also re-enable
HS400 mode, that was replaced with HS200 mode as a workaround for the
stability issues in:
cee572756aa2 ("arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4").

This was tested on ROCK 4SE and ROCK Pi 4B+.

Fixes: 8b5c2b45b8f0 ("phy: rockchip: set pulldown for strobe line in dts")
Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 281a12180703..b9d6284bb804 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -194,6 +194,7 @@ &cpu_b1 {
 };
 
 &emmc_phy {
+	rockchip,enable-strobe-pulldown;
 	status = "okay";
 };
 
@@ -648,7 +649,8 @@ &saradc {
 &sdhci {
 	max-frequency = <150000000>;
 	bus-width = <8>;
-	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
 	non-removable;
 	status = "okay";
 };
-- 
2.44.0


