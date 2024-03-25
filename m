Return-Path: <linux-kernel+bounces-117224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2C488A8D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965B1347F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A401214EC72;
	Mon, 25 Mar 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TEuYmlie"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DB514BFB3;
	Mon, 25 Mar 2024 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376224; cv=none; b=BbO0av5wNeLa2UAxzsLf91wbel9m5R91afEDntOt4Xil7bV5ZaApDvnUf2fvZJ+YhNx6A4YSpf/wh16LN+MI0AQvYFvPRTst5RxtezfbzmeqVALOBtvVuMQEAH1snvpYB2ncHDHeu2UfL28cqZ3rJBPcO6nJan81LAt6k3WYjws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376224; c=relaxed/simple;
	bh=czCfbCIPjGP9pvjr6UIUI+9KpI2JwNoa8jr1BZd0FOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeCagcs9KZbQqaIiHV/4C02W+qQalYZJElvEBGBPTPJnKq8pkMsfONsUAEKx/U3piAjQLJMRdASDgYH/OSgP6e4xd3xfez1krylEZQ1U1vnEVwsmhzu8RM88EU3pEJlWD3oKh/Wt2+SGjnF/jN2KgdTPunKaCfVfJACpd3iNgN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TEuYmlie; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711376217;
	bh=czCfbCIPjGP9pvjr6UIUI+9KpI2JwNoa8jr1BZd0FOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TEuYmlieIurR7QkMGQV2W5zESDLchoqp7x4uEhP+k89BWsqodu3OaJk5Q22ap60ST
	 +/eL+LrTZj0MmmJ44lFQztTg3+W+BSWhMo4i4nphJ6x9Chd7Zx2+U7scWb2ASpovfC
	 +pJ+1Ee+MwncbmvX+dhwIi95QWORjdvtwit/OdGznVp+6HHR2C5O7baDxZ9UA9OJXw
	 rYujz0/946o/5sA2YbHfW8w+GlNRhAajOLanMeRZd+xmDA4yoOSTGxGKeIwW930CfR
	 7X7QTWPrItcyzCvLvOdnbN684GbqYr5bJksqLgJibsOfW3AtiRN6B459qHk2Xf1gYp
	 V9bZKjEAzBAtQ==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B3DA737820E7;
	Mon, 25 Mar 2024 14:16:57 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id A1F504800D6; Mon, 25 Mar 2024 15:16:56 +0100 (CET)
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
Subject: [PATCH v4 09/10] arm64: dts: rockchip: add upper USB3 port to rock-5a
Date: Mon, 25 Mar 2024 15:15:39 +0100
Message-ID: <20240325141653.84910-10-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325141653.84910-1-sebastian.reichel@collabora.com>
References: <20240325141653.84910-1-sebastian.reichel@collabora.com>
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


