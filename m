Return-Path: <linux-kernel+bounces-63908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CD6853642
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C9C4B28851
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C255C605B0;
	Tue, 13 Feb 2024 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mC3snQdQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F193F5FEF8;
	Tue, 13 Feb 2024 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842179; cv=none; b=pnqjONntcRK9wYbQC9I638BSXX5giaoiA1uRMXdV78YvoKtpG68vc+/5w1s2L5LSz+des456C/MK2ITYTNJX+esUO7c8PBhVqNbTUM503mxWk5iixTn9FqXR95sI+xEUoU8Fm+u/9kIMlVT1qcYWWQeErRIJsPpoe4IPKdxNVpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842179; c=relaxed/simple;
	bh=irXRQ4YZgGtGFtaBzqS7r1OEFusEH88K+e92por6DDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAxc3CdRk5vRZuMKJHwcFMwVvup3V3ttle+jmTBQLJz7zTK/k2L6IfHxdv7T3gisFd8itgfuzDCJ3n3e41J/c7rElZOuYe6eDIeDObYT47JxQzBhu3cLsdNkbu1yuBuYb+3g30NcIuPQ6zaK1cHPhDly0VePqrmJIVlx15D+VoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mC3snQdQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707842172;
	bh=irXRQ4YZgGtGFtaBzqS7r1OEFusEH88K+e92por6DDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mC3snQdQhgRuykvk/QL9OjtyFv1+Fd+9s8kdvnnoyUQWGhvTNkklk+i+Jh6c4RMPV
	 Tj0gnLvs76mDbrI48gPOdDGKfX8fsUXmkrLzd9XQepQn5EHCYeRvBhGLAxf7ubNAiB
	 H8u8cNzkgC1SbPeHjylvk8CgVHTpO7SDe6jwlJpz+PTjPkdK7vyNoPTUtlfyHhxWFv
	 0PRz9jFbujBYdHeDuL7NP6JrUGI596W2iQpUcRND9l8ikeJfLj+CUZPOaDnvDdCV6s
	 E6d1+ssNjY/2XH9sdYnw8yjVgu9InCNIT/3TtCFQLiVdeSyw/HwCFUF3fjUcZ/G/vf
	 BXVNdUkpu6HTQ==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 23C243782085;
	Tue, 13 Feb 2024 16:36:12 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 0DDDD4800E0; Tue, 13 Feb 2024 17:36:11 +0100 (CET)
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
Subject: [PATCH v2 11/12] arm64: dts: rockchip: add upper USB3 port to rock-5a
Date: Tue, 13 Feb 2024 17:32:45 +0100
Message-ID: <20240213163609.44930-12-sebastian.reichel@collabora.com>
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


