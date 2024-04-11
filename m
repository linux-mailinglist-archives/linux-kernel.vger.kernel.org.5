Return-Path: <linux-kernel+bounces-141701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F678A2220
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823F71F23A75
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C8047F46;
	Thu, 11 Apr 2024 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RXClZl08"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CED47A48;
	Thu, 11 Apr 2024 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877099; cv=none; b=hBjr0bD7dYtvnYIk92DZlTIWcfmNnN+WLy1NCDbmjGheK3+rG5tg0x6Mn1OOyFNsZDzd5itjTY3FOZjTjDnAjkoLNwswarIB0wZRMAwTf4y/tqodNpy9v/OkelsFzOQTHxypqtqReWAXbllJ5YX0AmNZ7DMERHGbmW2oPzcfqPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877099; c=relaxed/simple;
	bh=WtLY2DfxGmqqzEfjnXrKQl8GF1EVE0kc/WAx1cPu/h4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tBdWMHW5r+cJlmXL4CnkoDE8Nu6AWr3LwIA4T1HiJgmraOx23a7Q/qLXYLvEwc6s+u40M6BY8Ye7KWvzfXUMf78YIkQ5GAzvdGQhLQWyT4fo+yK/RQm2nQ55fX+Or8QueQI3GIlSXa2QkjTfg7NXOZtBjyVX3Nm1JbQmpqpf+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RXClZl08; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43BNBUwI121096;
	Thu, 11 Apr 2024 18:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712877090;
	bh=6tLnQPe454SO5phWmUJw7OB46GtzZX5nY3F8YwjWpQQ=;
	h=From:To:CC:Subject:Date;
	b=RXClZl084ltGLBPslIgjyPphC/1qbOTlolrY4DkRf5VLYEnpn4qCk5WmUQJAFHpvW
	 C5ToNIEAN8fePX2UwedZYqqBfGwSRRO7BvT8XJRGH1xOWro439ULori/ZSSj8gQWfP
	 1phSlql3HXUwbTR+cqVRutGpwN3bdj+eC+Io4xh8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43BNBU02002917
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 18:11:30 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Apr 2024 18:11:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Apr 2024 18:11:30 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43BNBUsh030769;
	Thu, 11 Apr 2024 18:11:30 -0500
From: Judith Mendez <jm@ti.com>
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren
	<tony@atomide.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm: dts: am335x-evmsk: add alias node for uarts
Date: Thu, 11 Apr 2024 18:11:30 -0500
Message-ID: <20240411231130.386222-1-jm@ti.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The AM335x SK routes the PRUSS UART pins to the Zigbee header.
PRUSS UART is enabled and can be tested using the Zigbee header.
Since there are two UARTS, add alias node to be able to test PRUSS
UART reliably from userspace.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm/boot/dts/ti/omap/am335x-evmsk.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-evmsk.dts b/arch/arm/boot/dts/ti/omap/am335x-evmsk.dts
index eba888dcd60e7..e6925dc263d31 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-evmsk.dts
@@ -29,6 +29,11 @@ memory@80000000 {
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	aliases {
+		serial0 = &uart0;
+		serial1 = &pruss_uart;
+	};
+
 	chosen {
 		stdout-path = &uart0;
 	};

base-commit: 534ad093bb80f19c20b251a89f09ce1a0e3d4f2d
-- 
2.43.2


