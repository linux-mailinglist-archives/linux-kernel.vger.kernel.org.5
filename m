Return-Path: <linux-kernel+bounces-127650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D2D894EEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A73F1C22A93
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FD158ADD;
	Tue,  2 Apr 2024 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ujZ4pXu0"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4A059B56;
	Tue,  2 Apr 2024 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050942; cv=none; b=HidHOgTCMOgOUrvDO+DaKD7srwo+Jlnj2CFvtaOmO//9Wl+GG9ajSWtm3O/suincfsu03YnMZIMJVCUkfnQIKVYIhlvpPQF4LIHq9EuuLEXEGCmfDtVJgyZ4Xvryl9YG4wWAM2Wl+C2nL0i3Agwqq6j/0wb/OWi4QfWqNrIS4ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050942; c=relaxed/simple;
	bh=yf9r/6SopMFuZhaNn+MXyWWpnd0xjINz4F+UoSL6AhU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VcJCltEP/KsB6vUEUl5IaK9AfyacKz306hxvZyf4CSfaOfurgFYd6NeCjKlq2UL3y7nUG8SZsMAvMnddVrFEvJENRSHScZdOcK66kVPgsl3BZiHjVFThYuaTJkAn+I20PLmMDk3/4qxcCSRqsArYmDiR/dQJH36v7iYH5YMj7Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ujZ4pXu0; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4329g5qH000711;
	Tue, 2 Apr 2024 04:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712050925;
	bh=RVJIRhf9OE48KjtfXlkMI0tiXSgGPZuuM6Be1NHhXkI=;
	h=From:To:CC:Subject:Date;
	b=ujZ4pXu0WdUgRJRDxhU/0S7gBoFr7OpS/JuODx811RTAFf33CpYlsNGPHCqdBXWvs
	 2loBiRFakF71xHLdnyT2VVeqdFdLnkPUmtgKIY1+3D1hAUVaokMIqdkq6lFYjTGSgc
	 NcbaOuqNL0QDrthcVZeMBAkoHeNuWD6/KcrxhKx8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4329g5uH017960
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Apr 2024 04:42:05 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Apr 2024 04:42:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Apr 2024 04:42:05 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4329g1TE046392;
	Tue, 2 Apr 2024 04:42:02 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am62p-main: use eFuse MAC Address for CPSW3G Port 1
Date: Tue, 2 Apr 2024 15:12:00 +0530
Message-ID: <20240402094200.4036076-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Assign the MAC Address programmed in the eFuse registers as the default
MAC Address for CPSW3G MAC Port 1. Utilize the "ti,syscon-efuse"
device-tree property to do so.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

This patch is based on linux-next tagged next-20240402.

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 7337a9e13535..eb126f4a04dd 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -696,6 +696,7 @@ cpsw_port1: port@1 {
 				label = "port1";
 				phys = <&phy_gmii_sel 1>;
 				mac-address = [00 00 00 00 00 00];
+				ti,syscon-efuse = <&wkup_conf 0x200>;
 			};
 
 			cpsw_port2: port@2 {
-- 
2.40.1


