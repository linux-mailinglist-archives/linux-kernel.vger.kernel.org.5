Return-Path: <linux-kernel+bounces-135993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C0E89CEA1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284291C2104F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F7214D43E;
	Mon,  8 Apr 2024 22:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ygbU97j6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB49149E1E;
	Mon,  8 Apr 2024 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712616678; cv=none; b=pbSiyr3YfhghPpM+4M8bmC4C6e1O30fVW/GZs6j6pyFdvg12GjDQxVsQXSQ5FegfM+tlN+1fF++UStp+YXHks4ykWV2boj5oCH1mqtbsvIYbGINAt6JXA7Ss9reLLAPxb+QrshPcBFbHwuXKW/RjSO66z0BSXipbCxtu+qpkh4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712616678; c=relaxed/simple;
	bh=kN13aI2AEdhhdrsFLGGnxSDLilufbiwke7JxdqO0vzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTY1StogPRqv16yANqczWJueWVNfhBMUC0gAbtTVNFYey6UrrQ8uXKeypKjk2IM5R7LPszan4nccEWIJN7CxcXmyOVLDnXsrCR9drQmd4GYik5Pgc0Z3gYMtN1FAwDpANeXqbjbdAxfFTcCpKPVOik3TqFOBU6wpDD5nV9GavZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ygbU97j6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712616671;
	bh=kN13aI2AEdhhdrsFLGGnxSDLilufbiwke7JxdqO0vzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ygbU97j669pbCnniitafPFFYpYhGemIMdl+4eBCRUB8J3nmFJqgQfLVIXCqw7R/Gp
	 W1FrcLikox7jVGCERz5TwBC4hzfdj8wMlapQ6kS1ah0nuRniAJ6Sf1FVBAMW3ec8Ht
	 ttyHHTrxMmhYnDZLT/NmpbgB9xGnb1dArY5oZtPrrFmZhLRW0wAXTgSbnaX0xZ1DhS
	 pOE8aR/XvcT6dX/N183dbDC26jReHDkUr7i69asUn9lb4cp/cKMqMpV32dMfdBXRX/
	 tXuVjbvlaqGOqf55SZJYZf3X9Z4lmJAcpQ+lVmEay7a99IFC7iSdOvuHP3kiSnE/Td
	 a3MUTrNIQSRNw==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 584B337820FD;
	Mon,  8 Apr 2024 22:51:11 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 4C2314800DD; Tue,  9 Apr 2024 00:51:10 +0200 (CEST)
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
Subject: [PATCH v5 10/10] arm64: dts: rockchip: add lower USB3 port to rock-5b
Date: Tue,  9 Apr 2024 00:50:37 +0200
Message-ID: <20240408225109.128953-11-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240408225109.128953-1-sebastian.reichel@collabora.com>
References: <20240408225109.128953-1-sebastian.reichel@collabora.com>
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
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 1fe8b2a0ed75..bb09d0e1e20c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -742,6 +742,14 @@ &uart2 {
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
@@ -761,6 +769,10 @@ &u2phy3_host {
 	status = "okay";
 };
 
+&usbdp_phy1 {
+	status = "okay";
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
@@ -777,6 +789,11 @@ &usb_host1_ohci {
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


