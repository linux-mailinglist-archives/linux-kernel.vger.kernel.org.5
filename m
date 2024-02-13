Return-Path: <linux-kernel+bounces-63070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C393852A71
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5142829C4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E536B1799A;
	Tue, 13 Feb 2024 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S8Jho6AI"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BED6182BE;
	Tue, 13 Feb 2024 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707811447; cv=none; b=rCoDer9pmhwagLOrpQLvsDpo4jrAmZc+I5guP+xblviGqrNPhze6pDRiqoTQx6n2WI1yDHxNyEFVUtbkcotx39wKeKJ1sQxQvKNPDxINLheYHoeNY9xsfnsEEykRsvhz/CDtQb9uR+oyiA2mwAdutV50TKbm9Mt+FWzzDtN7Ta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707811447; c=relaxed/simple;
	bh=r1gw4eEHQDadsJ4+WMyRJ3mYkL3JPF57Rjxv9EGqEic=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n3YsJYEPpswVpY5gM/UTqnDpd1eoPx1K7vulQYcLmB8yrd2UsNePw7gBYlA9OpKw87EIdjFHQToQq7fFfvIfDLPsgWW1+CP8QvyzTR+9b10XQEX2eFoOyCIOrI0auzVIxLOffQHCcmiIuUhPE9IesvR+oARaEb64lxxkgNGAf84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S8Jho6AI; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41D83rk4045006;
	Tue, 13 Feb 2024 02:03:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707811433;
	bh=xFJdH5D8oRdeSN0w0kQ5lxzFXQwgpIsAFAk3dHwUpmA=;
	h=From:To:CC:Subject:Date;
	b=S8Jho6AIx7herkxOkD+g/1GB4m/qt12BCzXMK7yRYqtrSe8EVndRgF9ImbeDa8cks
	 HoUIseMsQ9e790IFkZgOVwQqk0JK9LQhiG6HZkWDF17+cSjualeHcDGiaDMA3YITOy
	 LRCBat0qbWVtI7rZPxwr3GjpfdqTa6S2voDV6RF8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41D83r10118887
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Feb 2024 02:03:53 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Feb 2024 02:03:53 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Feb 2024 02:03:53 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41D83m6Q074348;
	Tue, 13 Feb 2024 02:03:49 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <peda@axentia.se>, <afd@ti.com>, <gregkh@linuxfoundation.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <c-vankar@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5] arm64: dts: ti: k3-j784s4-main: Fix mux-reg-masks in serdes_ln_ctrl
Date: Tue, 13 Feb 2024 13:33:48 +0530
Message-ID: <20240213080348.248916-1-s-vadapalli@ti.com>
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

From: Chintan Vankar <c-vankar@ti.com>

Change offset in mux-reg-masks property for serdes_ln_ctrl node
since reg-mux property is used in compatible.

Fixes: 2765149273f4 ("mux: mmio: use reg property when parent device is not a syscon")
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
Acked-by: Andrew Davis <afd@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
Hello,

This patch is based on linux-next tagged next-20240213.
The v4 of this patch is a part of the series at:
https://lore.kernel.org/r/20240131101441.1362409-1-c-vankar@ti.com/

Since the v4 series mentioned above has open comments on the other
patches in the series, this patch is being posted separately to unblock
other dependent series which rely on the fix implemented by this patch.

Changes since v4:
- Rebased patch on linux-next tagged next-20240213.

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 3cb964982792..3b7f0eca977b 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -52,12 +52,12 @@ serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "reg-mux";
 			reg = <0x00004080 0x30>;
 			#mux-control-cells = <1>;
-			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
-					<0x4088 0x3>, <0x408c 0x3>, /* SERDES0 lane2/3 select */
-					<0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
-					<0x4098 0x3>, <0x409c 0x3>, /* SERDES1 lane2/3 select */
-					<0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
-					<0x40a8 0x3>, <0x40ac 0x3>; /* SERDES2 lane2/3 select */
+			mux-reg-masks = <0x0 0x3>, <0x4 0x3>, /* SERDES0 lane0/1 select */
+					<0x8 0x3>, <0xc 0x3>, /* SERDES0 lane2/3 select */
+					<0x10 0x3>, <0x14 0x3>, /* SERDES1 lane0/1 select */
+					<0x18 0x3>, <0x1c 0x3>, /* SERDES1 lane2/3 select */
+					<0x20 0x3>, <0x24 0x3>, /* SERDES2 lane0/1 select */
+					<0x28 0x3>, <0x2c 0x3>; /* SERDES2 lane2/3 select */
 			idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,
 				      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
 				      <J784S4_SERDES0_LANE2_IP3_UNUSED>,
-- 
2.34.1


