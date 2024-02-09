Return-Path: <linux-kernel+bounces-59790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2085084FBC4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FB81F24913
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A36126F3F;
	Fri,  9 Feb 2024 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z5LRajx6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2859683CB5;
	Fri,  9 Feb 2024 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502719; cv=none; b=jZTcGxY+5fhe26U8WHEjkfDRvBtO4jOlT6xS64Mh3X40PsuRFbyw59rRSTws4qnkSOVaU56eUapHnyJe6Ypxw5dx1Yz4A9EJqo5uAJ+/pGpxF0MuXoyZy5Nn4XCVfYbNsJ52lSd46thUqpo93nkloHDNFJr8emU0LsVxkn8zSc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502719; c=relaxed/simple;
	bh=irXRQ4YZgGtGFtaBzqS7r1OEFusEH88K+e92por6DDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJhntsYMTxbjYkaFAhQt1Kx4ozwB1utZf76a2dmOmYm9aUyTTXCTXt4oF/AuasPaT6j8njivxtVOYEsx3EL3CycRrgZAN8OZbjTklWDEXmHGtysyUcTlZcqkBr0d+sEnp7ZsvtrE7RtUeeP22vMXlKYQAJhBSuT5QgTK2qlV7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z5LRajx6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707502713;
	bh=irXRQ4YZgGtGFtaBzqS7r1OEFusEH88K+e92por6DDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z5LRajx6Dfr3ecG9xMCfxi6QpOw++W22ZkovyotZkMbzmbXc+Zmk7Iahwcu+zLVn/
	 cZMGw5y0Bm+0YN6M3b4VmyyDXfiEOQR3DlnFNkxCUMloji51dErFfyny4s2iRVHqdV
	 ylSssROUX2jdbTsvGwROEaBc/99AqzNX9afx/c1/uIm0sonf6eVJ7o1pNGZ4VEoXvL
	 TTt5pDb3A65kb6ryvL/d0YpUZPalA/y1of5YGCw9wAK2cONOx54EtkTx2H2LhrchBm
	 +hprAqc256MEz2s80YbP89q9IcfB+utpIRQa/g9Qrv5YUmr6gXDClJPWQPZVoUsvIr
	 Y/Qs6x0EtyIxg==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A470137820BC;
	Fri,  9 Feb 2024 18:18:33 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 9CF0A4800DC; Fri,  9 Feb 2024 19:18:32 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v1 09/10] arm64: dts: rockchip: add upper USB3 port to rock-5a
Date: Fri,  9 Feb 2024 19:17:25 +0100
Message-ID: <20240209181831.104687-10-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209181831.104687-1-sebastian.reichel@collabora.com>
References: <20240209181831.104687-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable full support (XHCI, EHCI, OHCI) for the upper USB3 port from
Radxa Rock 5 Model A. The lower one is already supported.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 2002fd0221fa..f78d131a8ca8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -698,6 +698,14 @@ regulator-state-mem {
 	};
 };
 
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
 &u2phy2 {
 	status = "okay";
 };
@@ -721,6 +729,15 @@ &uart2 {
 	status = "okay";
 };
 
+&usbdp_phy0 {
+	status = "okay";
+	rockchip,dp-lane-mux = <2 3>;
+};
+
+&usbdp_phy0_u3 {
+	status = "okay";
+};
+
 &usb_host0_ehci {
 	status = "okay";
 	pinctrl-names = "default";
@@ -731,6 +748,11 @@ &usb_host0_ohci {
 	status = "okay";
 };
 
+&usb_host0_xhci {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usb_host1_ehci {
 	status = "okay";
 };
-- 
2.43.0


