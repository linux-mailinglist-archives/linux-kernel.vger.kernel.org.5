Return-Path: <linux-kernel+bounces-48314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 320FF845A2F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6504B1C271B7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B374626A9;
	Thu,  1 Feb 2024 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f46yo3Mo"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A51626A8;
	Thu,  1 Feb 2024 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797405; cv=none; b=BhhHGmPC3cvhD6h/avCAumW/7fm2aFffR/XaeJzAULsCgodrNGrkuZPGdm8qZHND4CKwfL/Qd1NOXV7HEM5xGUiyc8xYAgewIrY56L4J6Pv/x+Ng04sgU/WGHUmd8nReIPaLZUTf/e8TUaph7lN8an24m+pY7+qOeimVCsBKqCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797405; c=relaxed/simple;
	bh=8NqK0cLavZ8NJ6lPMgs1cg3AQLozfT12HVAJLJFUtkU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ehcQM7gTAL8zx8X4DZaucWNEokYQocjaLH4BmgvSwJ3RHt+h1jb0Pyj4ie9CEOIqA3EUCa/ftd6aL7gC8KY4bcIbuEUTUa7xQ7mb2IWrfckyqSl22WkDW8LH/EdMpGa2yol1PpSLf5BBAQOZbXqsO87oM+58+fZPsw+6d0jmGoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f46yo3Mo; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411ENAk1124291;
	Thu, 1 Feb 2024 08:23:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706797390;
	bh=GP6f60ABIhtPzuyReskSzZ99XCUPZJHbTyCWxm/yLg4=;
	h=From:To:CC:Subject:Date;
	b=f46yo3MoZVQ7FiOe1m2vxvVtyeOYP7P3YnxYge2F6jQejk1Gn1eAMgVZdKjOGn9SY
	 4G09BorUBAC21L9Fm3kznYUrIlkJbD6zc95iUqwlW4Rh07wiXH5Kw+cNiA05hCKV1O
	 uJOunmrccV9recCejtJgUeZS3iT5ma93fpS0gRoo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411ENAj7023230
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 08:23:10 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 08:23:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 08:23:09 -0600
Received: from localhost ([10.249.128.100])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411EN9iR126444;
	Thu, 1 Feb 2024 08:23:09 -0600
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <tomi.valkeinen@ideasonboard.com>, <nm@ti.com>, <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <a-bhatia1@ti.com>, <rogerq@kernel.org>,
        <sabiya.d@ti.com>, <u-kumar1@ti.com>, <eballetbo@redhat.com>,
        <j-choudhary@ti.com>
Subject: [RESEND PATCH v2] arm64: dts: ti: k3-am69-sk: remove assigned-clock-parents for unused VP
Date: Thu, 1 Feb 2024 19:53:08 +0530
Message-ID: <20240201142308.4954-1-j-choudhary@ti.com>
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
The current DM firmware does not support changing parent clock if it
is shared by another component. It returns 0 for the determine_rate
query before causing set_rate to set the clock at default maximum of
1.8GHz which is a lot more than the maximum frequency videoports can
support (600MHz) causing SYNC LOST issues.
So remove the parent clocks for unused VPs to avoid conflict.

Fixes: 6f8605fd7d11 ("arm64: dts: ti: k3-am69-sk: Add DP and HDMI support")
Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---

v1: <https://lore.kernel.org/all/20231221113042.48492-1-j-choudhary@ti.com/>

Changelog v1->v2:
- Updated commit message
- Picked up Tomi's R-by from v1
- Removed "Closes:" link since its invalid now

(NOTE: Sending again as forgot to put mailing list in cc earlier)

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


