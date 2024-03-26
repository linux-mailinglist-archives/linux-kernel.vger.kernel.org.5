Return-Path: <linux-kernel+bounces-119964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8905888CF80
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299FC1F67442
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F9213D50C;
	Tue, 26 Mar 2024 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pyBPDefb"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4493112B142;
	Tue, 26 Mar 2024 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486769; cv=none; b=cH7y/AskqqPtZI1v5r2s1zotfbGigF7CNeW5h/KT+nYPpM39wptRyDWduBvuqcyMxuGG099KYLR2Pc5Agpu409pAzvDE1IaTOFGLyTsF7NjBm16G+50zGIBBx9m/Voav4fZmZD4fDzGgBuL3IU3Ky5SQi+DsDLW1U2Z3TqXP4Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486769; c=relaxed/simple;
	bh=3+OZeZuzP0fPCcu0Yyl60GpwthZVZZbObl44GUV62iY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sdM/yKmEHn2Axna0ynQLGRy9SkTbTpd9MWdfVijlmqOJLD7EorhgdrkzrL4LwcQ1CntWcmIV2hmGJ6Spzj5beIOiT/mHRlJ+ii6wHFfD6Rbr1kcLvesqOtkWl8uc4mRb43WC/mMzEEmGJPiKS0kkqUEd4GWH6MdD8rhciEBohuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pyBPDefb; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QKxMpr096178;
	Tue, 26 Mar 2024 15:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711486762;
	bh=P9kcPkgdVptpxJ+60rtjOwVH4V0CFmGhzklfyK8ceL8=;
	h=From:To:CC:Subject:Date;
	b=pyBPDefbp8QSVZL5o0HjFYZ4bPjQ81IbFy+ocn5zZQp45m73kfHSc3oHDlMDYXgFf
	 NiGecXwbouaLiLXQF6J04xLizrnwgHuB6v8f4jc3zNYg+Rok9xsCN0jj+2yHkKNbfO
	 js90N8ZRGda7P/ITo654jhIu28gyoNxTd11wYNbU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QKxMkR087921
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 15:59:22 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 15:59:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 15:59:22 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QKxLBI082903;
	Tue, 26 Mar 2024 15:59:21 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/4] arm64: dts: ti: k3-am65: Use exact ranges for FSS node
Date: Tue, 26 Mar 2024 15:59:17 -0500
Message-ID: <20240326205920.40147-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The FSS bus contains several register ranges. Using an empty
ranges property works but causes a DT warning when we give
this node an address. Fix this by explicitly defining the
memory ranges in use.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 6ff3ccc39fb44..babfcbb9ecf56 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -286,7 +286,11 @@ fss: bus@47000000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
-		ranges;
+		ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x100>, /* FSS Control */
+			 <0x0 0x47040000 0x0 0x47040000 0x0 0x100>, /* OSPI0 Control */
+			 <0x0 0x47050000 0x0 0x47050000 0x0 0x100>, /* OSPI1 Control */
+			 <0x5 0x00000000 0x5 0x00000000 0x1 0x0000000>, /* OSPI0 Memory */
+			 <0x7 0x00000000 0x7 0x00000000 0x1 0x0000000>; /* OSPI1 Memory */
 
 		ospi0: spi@47040000 {
 			compatible = "ti,am654-ospi", "cdns,qspi-nor";
-- 
2.39.2


