Return-Path: <linux-kernel+bounces-72401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD4E85B2D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141F52828D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F02E5916C;
	Tue, 20 Feb 2024 06:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FHmyR6iB"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FFA58ACD;
	Tue, 20 Feb 2024 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409909; cv=none; b=oivAGQw1Fb+puAiTSmFFIlFJ1jdYIPlhISv7DWlw9A4vI4BvnIDkWe3MCXq/ZwXfTa/qrfihWSGsZNAa0zdvUDWlV8T6iVnUjXztswqeR1Kbu6oB6yVKBgSddjvojM3CBJjLZ3mK2wgOkhLsw2mACZgM4YGtela0sfmKk8tIJeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409909; c=relaxed/simple;
	bh=mOxmtY9st1BCh5hTsuJ9O39rltM8En2NwBJnC+c2x4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=M6LD3jpGZkrgS29vPMmYFrqnJHjvLNmgrxJNV+CH4x6CUEy4usdNqPnuY9TwLSmXqtmVoVvuYldEWCBl6jucLVEX1ERlW091KHolrkghgHJkt2wORN2BGkjBhwrTKwIqSk/LAWxp00uzCAUlBx4DXh9JJTof13ZjDoGZGtSZ46U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FHmyR6iB; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41K6IHZa128561;
	Tue, 20 Feb 2024 00:18:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708409897;
	bh=1Ww2tKra2g8SI/rOHyEKtVJHw2cqSJMM6b5DyVtND4U=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=FHmyR6iBSX45l9QEjIRzpFp6FQb4CRqC8krWUuc7x/gC+j36rc2/qxB4FujLhGOAi
	 EonVUsO/W6oAz/pBMCnH+OGoc0lHGiFMMhLNufHU8Kkpo/fdlqL3MJyxHQhQMv/VPp
	 9SSAnwoYl6w3Stt3HHE90ok3iNXcG9Gj0XsYWPxg=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41K6IHXg017884
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 00:18:17 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 00:18:17 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 00:18:17 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41K6IGql120967;
	Tue, 20 Feb 2024 00:18:17 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Tue, 20 Feb 2024 11:48:05 +0530
Subject: [PATCH v2 4/4] arm64: dts: ti: Enable overlays for SK-AM62P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240220-am62p_csi-v2-4-3e71d9945571@ti.com>
References: <20240220-am62p_csi-v2-0-3e71d9945571@ti.com>
In-Reply-To: <20240220-am62p_csi-v2-0-3e71d9945571@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1928; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=mOxmtY9st1BCh5hTsuJ9O39rltM8En2NwBJnC+c2x4g=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1EQhPPxTSTZCUdaFG3RfCLyvSt17Tz6qj9Q9m
 etSQMA5YWSJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdREIQAKCRBD3pH5JJpx
 Rb7uEADFjRww152PNobZpfle3BZoqucli51S+f4tir2m0U+ybPgiZvGD2vtIUkMNMarJGUdJanQ
 7rebIGOo6w20p8H/XnMo5j543RSjpLxDGl254/bL6BnEM0ySiGhXprRLyE/HxabsDgRhVaaModc
 2czNW4QeLBgVD1/DPeDB/6A9LVClBLJl5ELE+wVF0AP5w3o/kWbxqWgY4YYCVglUNkdrCv06Zu9
 T7RMGlwqiYFQFdwrlOa+gKs431z/aFbdqit6jC0/04gmfAxlaMZ2seG2QFmA05rskXeMZjCAkQ+
 fLLvI+njY7O/A6atovwVMxELg3+iWdWqYPOMaIZvbptiZ+O0pcY0Qn9kkW7caJJ7YOvPWcUvxYN
 6uXHOmJJS1/uXPtMbbWHLQEzHACPMNxak5Dz0EmDtBe7/MKxyPEctZMjiZ2XBR6ny1oqUH18g6K
 K5vltWjGeFiCv8wbZdopg7nbNfcwROlgvLUgmk0WbmX9H9VKAyiLxz+nAtVvl4aGS4z5753GyRY
 +rdW732qwFaMXapONFI66TUOd7p+DEfu7O/1mjoNNYwEyS+lj2eRgAuuEvRalQUkSmWs1fHEZtI
 lpcrMcV057YFRCxlyoxFX9TNG/fbNn0VzczOwjYCWdQEaKvPO8ymcA3ZFMfqu9b1o8O9Hk/cSrM
 VHM0w9bV4vLxfnA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Enable symbols so that overlays can be applied on the base DTB for
SK-AM62P.

Also compile-test known-to-work camera sensor overlays for OV5640 and
IMX219.

Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index d601c52ab181..9843b7656725 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -116,6 +116,12 @@ k3-am62a7-sk-csi2-ov5640-dtbs := k3-am62a7-sk.dtb \
 k3-am62a7-sk-csi2-tevi-ov5640-dtbs := k3-am62a7-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
 k3-am62a7-sk-hdmi-audio-dtbs := k3-am62a7-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
+k3-am62p5-sk-csi2-imx219-dtbs := k3-am62p5-sk.dtb \
+	k3-am62x-sk-csi2-imx219.dtbo
+k3-am62p5-sk-csi2-ov5640-dtbs := k3-am62p5-sk.dtb \
+	k3-am62x-sk-csi2-ov5640.dtbo
+k3-am62p5-sk-csi2-tevi-ov5640-dtbs := k3-am62p5-sk.dtb \
+	k3-am62x-sk-csi2-tevi-ov5640.dtbo
 k3-am642-evm-icssg1-dualemac-dtbs := \
 	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
 k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
@@ -142,6 +148,9 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am62a7-sk-csi2-imx219.dtb \
 	k3-am62a7-sk-csi2-ov5640.dtb \
 	k3-am62a7-sk-hdmi-audio.dtb \
+	k3-am62p5-sk-csi2-imx219.dtb \
+	k3-am62p5-sk-csi2-ov5640.dtb \
+	k3-am62p5-sk-csi2-tevi-ov5640.dtb \
 	k3-am642-evm-icssg1-dualemac.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
@@ -156,6 +165,7 @@ DTC_FLAGS_k3-am625-beagleplay += -@
 DTC_FLAGS_k3-am625-sk += -@
 DTC_FLAGS_k3-am62-lp-sk += -@
 DTC_FLAGS_k3-am62a7-sk += -@
+DTC_FLAGS_k3-am62p5-sk += -@
 DTC_FLAGS_k3-am642-evm += -@
 DTC_FLAGS_k3-am642-tqma64xxl-mbax4xxl += -@
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@

-- 
2.43.0


