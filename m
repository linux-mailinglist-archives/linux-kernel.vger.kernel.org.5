Return-Path: <linux-kernel+bounces-28579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5565C830043
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C13A1C221F6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57C2BE6B;
	Wed, 17 Jan 2024 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b="BfDHJ7sy"
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEFCB662
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705474220; cv=none; b=KEko4IAPpmSQ77efEZaR1ZvWejrg5nwBFsBxJep+t3gFPeYZzulW6NM1vT+Gynqte5G7trn90H2A6pb/fv2/9GKnc19iFqCEcKdH/Tr/oGCtNSoSnlNgKfPPConD7FLp8QmN2CHIMC638PHUIPAag2HoqjU3uiTmorIpEAt26ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705474220; c=relaxed/simple;
	bh=IjijvpEGm8++x6JhsQhCG9lVruoFVQRR3WtUZVDgXNY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:X-Flowmailer-Platform:
	 Feedback-ID; b=f4TcFjSh+oA2mM2pqymnm76wfzHJKZEdbrbn2WsqSPlh4cAAcVdXRCv1k4iZiiSRh6ykUv0vvIyx2VIsC0kiO3i2lAPmY6wTIGn7oZBIPWamRFouLLWRPCubPWHVqYu+sTgj/jTJnnVf6Kwxfc8aGYTOJadcsm6Bm9Kga187Zas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b=BfDHJ7sy; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240117065008c6a5161643268dc634
        for <linux-kernel@vger.kernel.org>;
        Wed, 17 Jan 2024 07:50:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=WHNI8XrH7RiUQQDT+96DG1fkua1fIsab1rZp4r5XFs4=;
 b=BfDHJ7syRSlkwGdS0Drr3I6/xmBDrCUrtT0RCX9y8jV0qgNpEhvDZ6fZxMOG3Dw0jCxcWo
 JEn0JPRgCNyKkaqGz6KATwUuD2YU+MyL9zQ9RThG2ju0LGMh0nQTsQBmNHyWRIuyI8mL12aZ
 qvJ748Qz2BO3Is0ywsn/Bcrm2V8uI=;
From: huaqian.li@siemens.com
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jan.kiszka@siemens.com,
	baocheng.su@siemens.com,
	Li Hua Qian <huaqian.li@siemens.com>
Subject: [PATCH] arm64: dts: ti: Add reserved memory for watchdog
Date: Wed, 17 Jan 2024 14:06:56 +0800
Message-Id: <20240117060654.109424-1-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer

From: Li Hua Qian <huaqian.li@siemens.com>

This patch adds a reserved memory for the TI AM65X platform watchdog
to reserve the specific info, triggering the watchdog reset in last
boot, to know if the board reboot is due to a watchdog reset.

Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
---
The driver and binding have hit the master, which could be found in the
following link.
- watchdog:rit_wdt: Add support for WDIOF_CARDRESET
- dt-bindings: watchdog: ti,rti-wdt: Add support for WDIOF_CARDRESET
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=29057cc5bddc785ea0a11534d7ad2546fa0872d3

 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 61a634afaa4f..88321799d468 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -75,6 +75,12 @@ rtos_ipc_memory_region: ipc-memories@a2000000 {
 			alignment = <0x1000>;
 			no-map;
 		};
+
+		/* To reserve the power-on(PON) reason for watchdog reset */
+		wdt_reset_memory_region: wdt-memory@a2200000 {
+			reg = <0x00 0xa2200000 0x00 0x1000>;
+			no-map;
+		};
 	};
 
 	leds {
@@ -1427,6 +1433,10 @@ &mcu_r5fss0_core1 {
 	mboxes = <&mailbox0_cluster1>, <&mbox_mcu_r5fss0_core1>;
 };
 
+&mcu_rti1 {
+	memory-region = <&wdt_reset_memory_region>;
+};
+
 &icssg0_mdio {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.34.1


