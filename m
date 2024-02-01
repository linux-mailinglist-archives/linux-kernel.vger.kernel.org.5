Return-Path: <linux-kernel+bounces-48193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC3A845875
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45C228D326
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4885286655;
	Thu,  1 Feb 2024 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C47/rN9o"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F285D5338F;
	Thu,  1 Feb 2024 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792841; cv=none; b=FBpVNIY9stKg6JYcJr+TGvxxvYp/OijZss/o7E+uVH1/fhVHCWL4Z4cFirt0cXEpzObxVovHK0IKDKAak3zfNJ87UsOgh1CKPGS606zoOhVB5RJOgerXPBK4CLUetmotuGbSGC53oRr2D+PIuOyQTzDqwSArntRAmfBdeWCQyfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792841; c=relaxed/simple;
	bh=UF/wTRkCBeSb8cxlWX4RH3B9zRm7N76jYm2OQQnwfow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nZbwbTjIWs1kkAxoGC1Qlmk/etvKjCjHEBUUqGM27S1zF4VVGxmdfnosJwUZ2zvAXh/sPztZkabLeEKJRCS8JEsyiLL7cesqsOVoV83z1fqv/YteCd72gjvdFxaEiSydcHZv/Oprf9R/VEN/D84zyf9um6J1drNmZ3kG2KUqlu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C47/rN9o; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411D7Ear033015;
	Thu, 1 Feb 2024 07:07:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706792834;
	bh=f78/TiYQWSs2UyVBQjw3PMCxAbjW9clzYimuvSBrtVc=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=C47/rN9of7gLyc9G8pcRV6hoirn0byFBai8sReDKk/qEuU32QYZT3qpyEOYW+mYsc
	 Gp6uV7CgfIKDkbeVfPt+OcBa19JOBbkS+/Fg5N4MnuS7wu3GN8SFV+/QMcdnm+uJjw
	 Y4ka2bNNeA6sBhPshjHwkVTI/k+rEulOLKpWzGDI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411D7EUv107617
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 07:07:14 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 07:07:13 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 07:07:13 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411D7D0q083023;
	Thu, 1 Feb 2024 07:07:13 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 1 Feb 2024 18:37:03 +0530
Subject: [PATCH 4/4] arm64: dts: ti: Enable overlays for SK-AM62P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240201-am62p_csi-v1-4-c83bb9eaeb49@ti.com>
References: <20240201-am62p_csi-v1-0-c83bb9eaeb49@ti.com>
In-Reply-To: <20240201-am62p_csi-v1-0-c83bb9eaeb49@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Bryan Brattlof <bb@ti.com>, Dhruva Gole <d-gole@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>,
        Devarsh
 Thakkar <devarsht@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
        Jai Luthra
	<j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=UF/wTRkCBeSb8cxlWX4RH3B9zRm7N76jYm2OQQnwfow=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlu5d5ggj6eDGV+qFC0hHhlwijoK/lEq5yInmdf
 nqM9oV/Og2JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZbuXeQAKCRBD3pH5JJpx
 RQjGD/9a7lnJKaJcAfYM1SgG6R2OjsMCdP/w/B9X28MNrQ6z+P6FQSI7AW7KkPuiCIO+BCQBMzi
 3t0VLGBL4Hj6fuKvFYz+KMSqSoNE3Kp0Hd6B5MD7vtuMwrEs4yjU3EHBKUI2ckrDwMiV1sgLDlU
 pg2r9RVa8bVPn2ScJ1OwFrIa8Est3OB7iYfA8R5ZPiFhT/7JwN91Pb7DB/Dj6ufqoIemzqJ3nWs
 35ltScewMvi7xuH4L5L5Y1YxVcIXh56vRGA1y9mIEHKszZDr8jsDIV79j5yoUV5AvvSsQEOfCrn
 eSs5JCG97YQ+UxrppqDnM5zeP0VjwO+NdKO4CQyv0gXWLzHaXfqV/5gK9T2xufB4ed9NYz2FEAV
 tIgI1Vb6E1fGOiX8preAB4Zv0o4l841m/xU7lolQTD46IqFOBWQfwmerU2Nl3VgxUIw9G1ckfYD
 tfYup1Iyci9sMR59hPrIUU6Hyn43ppyBUjA/YmnRO6RQs60IMfqVBCvAaP0zSsozsFBiNlwRPEJ
 6VWU77z4mM50nWcu4SFGLb8eTZXFhiwdNkmfy/LK5oGCBfu1x91144j7VmdhIIOuEdGrhrFdLgZ
 gHdqEum1b5mN4wjOUdprHZrk1M9zhzrCZ+WUw4mDCUO1PsM836X5jRvaSepOmndZ2vuXFCpi2J4
 1Hlf5rC+9mwdx+w==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Enable symbols so that overlays can be applied on the base DTB for
SK-AM62P.

Also compile-test known-to-work camera sensor overlays for OV5640 and
IMX219.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 52c1dc910308..80733ed747a2 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -101,6 +101,12 @@ k3-am62a7-sk-csi2-ov5640-dtbs := k3-am62a7-sk.dtb \
 	k3-am62x-sk-csi2-ov5640.dtbo
 k3-am62a7-sk-csi2-tevi-ov5640-dtbs := k3-am62a7-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
+k3-am62p5-sk-csi2-imx219-dtbs := k3-am62p5-sk.dtb \
+	k3-am62x-sk-csi2-imx219.dtbo
+k3-am62p5-sk-csi2-ov5640-dtbs := k3-am62p5-sk.dtb \
+	k3-am62x-sk-csi2-ov5640.dtbo
+k3-am62p5-sk-csi2-tevi-ov5640-dtbs := k3-am62p5-sk.dtb \
+	k3-am62x-sk-csi2-tevi-ov5640.dtbo
 k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
 	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
 k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
@@ -118,6 +124,9 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am62-lp-sk-hdmi-audio.dtb \
 	k3-am62a7-sk-csi2-imx219.dtb \
 	k3-am62a7-sk-csi2-ov5640.dtb \
+	k3-am62p5-sk-csi2-imx219.dtb \
+	k3-am62p5-sk-csi2-ov5640.dtb \
+	k3-am62p5-sk-csi2-tevi-ov5640.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
 	k3-j721e-evm-pcie0-ep.dtb \
@@ -128,6 +137,7 @@ DTC_FLAGS_k3-am625-beagleplay += -@
 DTC_FLAGS_k3-am625-sk += -@
 DTC_FLAGS_k3-am62-lp-sk += -@
 DTC_FLAGS_k3-am62a7-sk += -@
+DTC_FLAGS_k3-am62p5-sk += -@
 DTC_FLAGS_k3-am642-tqma64xxl-mbax4xxl += -@
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
 DTC_FLAGS_k3-j721e-common-proc-board += -@

-- 
2.43.0


