Return-Path: <linux-kernel+bounces-135990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AE389CE9D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFDC1F233BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C883514D2A6;
	Mon,  8 Apr 2024 22:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="grA6DCAd"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02407149DEF;
	Mon,  8 Apr 2024 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712616677; cv=none; b=gN0jmV6eQxTLzO/5m8zOv4n6w2Ajd36dhBa0vzCqULBHiMLKXlxobqtcVqQIMUXogh6TmFJ2u9EQ9JGtIo2YrTAaWqwf72Qa6tR8p1hu4LgnJU8nORjDeDLREi1L8qwipGUPJn9Ol+rylLNT5bFxNDyFzZLAyhfM7OhKkpbjTZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712616677; c=relaxed/simple;
	bh=czCfbCIPjGP9pvjr6UIUI+9KpI2JwNoa8jr1BZd0FOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y05rYwn7ybmsJHHSXWaH4kvcFsf1EvT50gknExYwfWOjekuE7rnMjGb5xCbr5QZkwf3/WXUVx0uw/rJZ0RvL/N/28X2v3iLWgPe7ymF64I6dR4NYDmPKvH25UuCIeXyKYrmSYT/Hnsno4bP6dPNBIuAkgMVD5YAJ2Man7ZJW3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=grA6DCAd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712616671;
	bh=czCfbCIPjGP9pvjr6UIUI+9KpI2JwNoa8jr1BZd0FOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=grA6DCAd81R08RrZfoAPZ2CHrphx0CmPZWcEy7Ax4cpp5yUkc0FxffrJcDFiI1a2O
	 iqotO08/6QM4anRXSvgSZzY/mnUdqzIXtEyR2zYm4Pu55di7p1dk4xQJe48YL1Fpr6
	 Q0g8pRefm72qUZdzYXmVHxw1LvB9Jh68Fc5ZIVhhEzyJ2xJi1qmvcuTmQpaTqOZH9R
	 hvk+5sJcYryfT79X7eCtCv/50fdukaHmXV+BDb9iqIrYvufATrON6JBFdycB+D+Wa2
	 zl8iyf9SFhUgDO7bIZQdwA/oRbYNOwXxdYev2NL0Qc4LqxeUL/5Q2oOd7Sp3bBuexO
	 /Ml3XKIX8gm9Q==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5246A37820F8;
	Mon,  8 Apr 2024 22:51:11 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 4A71C4800DC; Tue,  9 Apr 2024 00:51:10 +0200 (CEST)
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
Subject: [PATCH v5 09/10] arm64: dts: rockchip: add upper USB3 port to rock-5a
Date: Tue,  9 Apr 2024 00:50:36 +0200
Message-ID: <20240408225109.128953-10-sebastian.reichel@collabora.com>
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

Enable full support (XHCI, EHCI, OHCI) for the upper USB3 port from
Radxa Rock 5 Model A. The lower one is already supported.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../boot/dts/rockchip/rk3588s-rock-5a.dts      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 00afb90d4eb1..b8ca3ee4c89a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -697,6 +697,14 @@ regulator-state-mem {
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
@@ -720,6 +728,11 @@ &uart2 {
 	status = "okay";
 };
 
+&usbdp_phy0 {
+	status = "okay";
+	rockchip,dp-lane-mux = <2 3>;
+};
+
 &usb_host0_ehci {
 	status = "okay";
 	pinctrl-names = "default";
@@ -730,6 +743,11 @@ &usb_host0_ohci {
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


