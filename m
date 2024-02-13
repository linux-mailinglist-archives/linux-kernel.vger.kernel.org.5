Return-Path: <linux-kernel+bounces-63907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8380853640
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B36B28269
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D9A604D2;
	Tue, 13 Feb 2024 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T6IojCJQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B695FEF1;
	Tue, 13 Feb 2024 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842179; cv=none; b=Il1F5hOPRaSIak+2/CZUUbqXC4p1vBspa9fZ5ZMvkFTqHNe/xmxvAYZEut5RsJJh+evSDBv+M1GAaFYGopZRDKuwqcbDPOyhJkvfIRxLT5wfUZ9n/eOx2jZAnDZSweOG3HQc6Vpd+VV/hy1CifYr+Ebai5GA94SI2gS8VLfd6Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842179; c=relaxed/simple;
	bh=WeIVl1zwKI+IWUXLWKWVFzcLpHB4iw+lJXds4NyJ6UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQBCtGXllnrqFZ063N9jkC+j7jJbxDgSFgzR5Ovjmmx+ihWXLemXdM9fsbNQrJgUXKknA4wTqYyMDMogB7SIJhMwU9pvRxr5MKj+uyECJaLlT3Nqn4XIhxYeHbtChhinYCtEwS2AZqX42CkNXVJjH4rOFLkBNLp59kNucxoKwU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T6IojCJQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707842172;
	bh=WeIVl1zwKI+IWUXLWKWVFzcLpHB4iw+lJXds4NyJ6UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T6IojCJQcKuaD4s03s3nHmGEWbprPDIvQX1swRdEkPFGlk5G7cfftfyiuDobL7MtX
	 Xrzf7afTZJO4aGF2GMTGI50+KbqxetsqakKAhvaHi+HXN3+IySuENymWnvrQxcF6zc
	 Bm03aSWhTC1TgSnEHLKsSPFNQTKyoJIHhNzCmjhlbypQFx+JYUye3UuE5jaVQDQOMI
	 u/pk2ni2D0NQG8r9V/J4+ZBzg6UqPDrsacxo5ckSj/h9wikeQ9F5vPBWtDSeafP6aJ
	 IPcL1RqYwg5RWpTTW2a1+Gb3PWXDELJtlH5AtB0myz8pJKP7LiIh8dZbsApBKz63XS
	 8unYd0BDo9Phw==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 28B6B3782087;
	Tue, 13 Feb 2024 16:36:12 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 0FEBD4800E1; Tue, 13 Feb 2024 17:36:11 +0100 (CET)
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
Subject: [PATCH v2 12/12] arm64: dts: rockchip: add lower USB3 port to rock-5b
Date: Tue, 13 Feb 2024 17:32:46 +0100
Message-ID: <20240213163609.44930-13-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213163609.44930-1-sebastian.reichel@collabora.com>
References: <20240213163609.44930-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable full support (XHCI, EHCI, OHCI) for the lower USB3 port from
Radxa Rock 5 Model B. The upper one is already supported.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../boot/dts/rockchip/rk3588-rock-5b.dts      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index a0e303c3a1dc..db6f0e91f62d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -736,6 +736,14 @@ &uart2 {
 	status = "okay";
 };
 
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	status = "okay";
+};
+
 &u2phy2 {
 	status = "okay";
 };
@@ -755,6 +763,14 @@ &u2phy3_host {
 	status = "okay";
 };
 
+&usbdp_phy1 {
+	status = "okay";
+};
+
+&usbdp_phy1_u3 {
+	status = "okay";
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
@@ -771,6 +787,11 @@ &usb_host1_ohci {
 	status = "okay";
 };
 
+&usb_host1_xhci {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usb_host2_xhci {
 	status = "okay";
 };
-- 
2.43.0


