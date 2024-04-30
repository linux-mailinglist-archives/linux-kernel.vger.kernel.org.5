Return-Path: <linux-kernel+bounces-163592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAE28B6D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46976284B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2F6127E30;
	Tue, 30 Apr 2024 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FecDbuGS"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABD8127B45;
	Tue, 30 Apr 2024 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467061; cv=none; b=edFEwNmbuKZ9n1LJJF8qbv6LYMdAwmBoUbIarw2nBF9kGW4hL4Bvv3GgP2vzqFCBadgSEdswAiqs5AUSDNB9vD92ZNTsR12ChLh6G/RXb6qM+BKce0vuW4D7g0IFYL8HoaP4quqaIk348zlfor47qfQHhP4SljvAk6CrLKnLHRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467061; c=relaxed/simple;
	bh=IypIK3kBxWNpgYpv9gUQHPuPuf3nErj2l8FfJU/iaaw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qJoGYv7EfYmYE+V142TI1p8vMU/yX7hXdMCiGhDuEca2CFEphgk67qQwBJ1IgMftmpQcAHN2TmcJODB8S2BvyWNrTdfK5mip8E1dXXzOiQ88WZQBqYxz1uVihHaq1DcFjOBuzq7cPaddglW+OAU11yPC7PLuZT1BVd+fD7NLCeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FecDbuGS; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43U8ooKV100185;
	Tue, 30 Apr 2024 03:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714467050;
	bh=vbAq38zwd5R+EsdOCXYpzBxmXWGqdKAmPOWIfsVG70U=;
	h=From:To:CC:Subject:Date;
	b=FecDbuGS/TgdNaDRfwanjqE/476CWxyDdW4PpFOS5Ozjd4iaSZEm/ct60AOqgT3XW
	 TT2rJkI1F/ciuegZQg2aLY/JVg14qYb7/HBezhBFVwMJFrnY0jk5wXFeQ/SPj3FKcZ
	 jC8H4mXacAZ9iJmUQBOKz/3c/1QGPdAXWTj0dgK0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43U8ooQA064115
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Apr 2024 03:50:50 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 03:50:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 03:50:50 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43U8on0d059618;
	Tue, 30 Apr 2024 03:50:50 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <s-vadapalli@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH v3] arm64: dts: ti: k3-am62x-sk-common: Add bootph-all property in phy_gmii_sel node
Date: Tue, 30 Apr 2024 14:20:48 +0530
Message-ID: <20240430085048.3143665-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add missing bootph-all property for CPSW MAC's PHY node
phy_gmii_sel.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is based on linux-next tagged next-20240430.

Link to v2:
https://lore.kernel.org/r/20240429061600.2723904-1-c-vankar@ti.com/

Changes from v2 to v3:
- Removed "bootph-all" property from "k3-am625-sk.dts" and added it
  to "k3-am62x-sk-common.dtsi" since we need the same functionality
  for "SK-AM62-LP" board.

 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 3c45782ab2b7..96378b19c419 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -128,6 +128,10 @@ hdmi_connector_in: endpoint {
 	};
 };
 
+&phy_gmii_sel {
+	bootph-all;
+};
+
 &main_pmx0 {
 	/* First pad number is ALW package and second is AMC package */
 	main_uart0_pins_default: main-uart0-default-pins {
-- 
2.34.1


