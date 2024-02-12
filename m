Return-Path: <linux-kernel+bounces-61345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7EA851151
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2891D283DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DC839ACC;
	Mon, 12 Feb 2024 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lmU+8njt"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB94D38FA8;
	Mon, 12 Feb 2024 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734669; cv=none; b=YRPAL309djxV4gsH9A9gqGYDUieujyw3kIH+Nu5iP/7vPQ92FiHfblyYEW1if2IQtdiqwmLmeWrfG6LKdFRXj3Fi9QYv2sb9HVs6bPVjkW1JiBM8h/PoLEZpxEL/T3c820Z9m69fhO9I+crAFws73tbyVdvQdk4yjxBV6PXdAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734669; c=relaxed/simple;
	bh=ukNpWM0lrX7BiFznpMz+Abo47J3CgF+7SvYmhQOUjIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRWPfg3/Z7zbkLn42/nOicVNhEXPIxHfNGSi2UQ0kcnXsbJRMhrxXh5ynF0G4GZ+Dz5j0ZNwuxt09c0pRkFJ+3PJfO5vvJ2qWXdnh54LtUTQVhMgBGgylN1RMCbWZPRPOBm60skb45mLbpav35wyyMEwubVl/j0DEsrkPsXiBGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lmU+8njt; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CAiLQn097944;
	Mon, 12 Feb 2024 04:44:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707734661;
	bh=yG+L0ImzlSDe6UHNf20VXNYzvNU5btsZb8a+ADHi/pw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lmU+8njtmqVxP7g0ovOK1IUSxuX6mO4dPrITev02RFWAge5paADzZiixOMKx471fU
	 gaMHGU77JPw+oGIEOh9lf2GM/kKhfM/GuvwClVnfmhvDxRoWCGnUAVyLip0fnMi5ee
	 j4vhXLay/0/TSCh6aNJLqCK+TKM3nHQ7gSKxykVg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CAiLBe071073
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 04:44:21 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 04:44:21 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 04:44:21 -0600
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CAiKge116461;
	Mon, 12 Feb 2024 04:44:20 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>
Subject: [RESEND PATCH v2 2/4] arm64: dts: ti: k3-j7200-common-proc-board: Remove clock-frequency from mcu_uart0
Date: Mon, 12 Feb 2024 16:14:15 +0530
Message-ID: <20240212104417.1058993-3-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212104417.1058993-1-b-kapoor@ti.com>
References: <20240212104417.1058993-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Clock-frequency property is already present in mcu_uart0 node of the
k3-j7200-mcu-wakeup.dtsi file. Thus, remove redundant clock-frequency
property from mcu_uart0 node.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 160580a0584a..6593c5da82c0 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -273,7 +273,6 @@ &mcu_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_uart0_pins_default>;
-	clock-frequency = <96000000>;
 };
 
 &main_uart0 {
-- 
2.34.1


