Return-Path: <linux-kernel+bounces-8286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9FB81B4EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF233B22AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3EC6BB57;
	Thu, 21 Dec 2023 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TMUq8aL5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58C06AB8F;
	Thu, 21 Dec 2023 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLBUiNf034805;
	Thu, 21 Dec 2023 05:30:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703158244;
	bh=6XD1jb8MxKl/t5iIscqlDyNbd90j4JalDS5QKVzFyrc=;
	h=From:To:CC:Subject:Date;
	b=TMUq8aL5Gak5v0NumMGMQVYa9q6cVI9MSX/CH/RBxwbQLwl8wRsg895HuITotTugp
	 f+X9EAC19VBIXot0+q3PKw9Xj031YScr4dDXhFPfgY31URtKPTUh8hV5rzL/6BF0Uk
	 V9sD8/YbaY0ApMEOyTpdCXbdcwNcwbl8g7HvXb44=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLBUiiZ007840
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 Dec 2023 05:30:44 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 05:30:43 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 05:30:43 -0600
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.112])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLBUhP9024306;
	Thu, 21 Dec 2023 05:30:43 -0600
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <a-bhatia1@ti.com>, <rogerq@kernel.org>, <sabiya.d@ti.com>,
        <u-kumar1@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <j-choudhary@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am69-sk: remove assigned-clock-parents for unused VP
Date: Thu, 21 Dec 2023 17:00:42 +0530
Message-ID: <20231221113042.48492-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

VP2 and VP3 are unused video ports and VP3 share the same parent
clock as VP1 causing issue with pixel clock setting for HDMI (VP1).
So remove the parent clocks for unused VPs.

Fixes: 6f8605fd7d11 ("arm64: dts: ti: k3-am69-sk: Add DP and HDMI support")
Reported-by: Nishanth Menon <nm@ti.com>
Closes: https://storage.kernelci.org/mainline/master/v6.7-rc6/arm64/defconfig/gcc-10/lab-ti/baseline-nfs-am69_sk-fs.txt
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---

Local testing log for HDMI on AM69-SK:
<https://gist.github.com/Jayesh2000/517395cd85eb28d65b8ee4568cefb809>

 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 8da591579868..370980eb59b0 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -918,13 +918,9 @@ &dss {
 	pinctrl-names = "default";
 	pinctrl-0 = <&dss_vout0_pins_default>;
 	assigned-clocks = <&k3_clks 218 2>,
-			  <&k3_clks 218 5>,
-			  <&k3_clks 218 14>,
-			  <&k3_clks 218 18>;
+			  <&k3_clks 218 5>;
 	assigned-clock-parents = <&k3_clks 218 3>,
-				 <&k3_clks 218 7>,
-				 <&k3_clks 218 16>,
-				 <&k3_clks 218 22>;
+				 <&k3_clks 218 7>;
 };
 
 &serdes_wiz4 {
-- 
2.25.1


