Return-Path: <linux-kernel+bounces-48149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C9A8457FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B3D28220A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C38F86642;
	Thu,  1 Feb 2024 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sUCnkcM6"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB36153368;
	Thu,  1 Feb 2024 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791459; cv=none; b=MK5SUdd7yC5ot0H6WE13N9k2U+KyuH107pOaRC4WVXkYPpFbMZol9tzUYS/rE1RPKc2optPv0Fdrl+wMFg/8vP9Ufnb5E0pzdJF99hIPYzv8jf6f8Ti91TYKey971IyhOx1djOyAJhRC2NGH5K6RZJW95iTcFOkjJpmjJvRdeqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791459; c=relaxed/simple;
	bh=ekdmWWPnU8wjMv7Ncp9A0YVrygo/13fAwLl17Mlg+cE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=aGTrenAVBJrgf3lwKRwEfiQdLBktqywq4X29yPPExdmQPX0tUIgi+QL3KfR9UktRel1opGMZYr5msfaB8BVfcHJV1jaM9PVIlVTHtyzdiLysCfyIFvcX/cYWUYk1jyxYnh3tEb2SaYrGkUCyp7DkdgClcvKHKANjl/8mhTLwGvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sUCnkcM6; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411Ci6YB107043;
	Thu, 1 Feb 2024 06:44:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706791446;
	bh=1g2GFC9uCtQY4+wl4Cf5c06QCZuX7dOcjEvDV9pleVw=;
	h=From:Date:Subject:To:CC;
	b=sUCnkcM6Tonvy1t4suXzTZ/uvz2ms5JVyRZaAU+Y2uC21K9yzDN/IU9xyLkZrzk8f
	 PKGAvKQxKxhZzHQisfxqNAdElsXVZnmlMXSivFgNx++iz4v63A0Afv1Few3IzUXGQH
	 MNeKewj9GgVmtoIth9RCitsvMGJQuZ4S980h4qOY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411Ci6DW097121
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 06:44:06 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 06:44:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 06:44:06 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411Ci5ht051739;
	Thu, 1 Feb 2024 06:44:05 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 1 Feb 2024 18:13:53 +0530
Subject: [PATCH] arm64: dts: ti: k3-am62p5-sk: Enable CPSW MDIO node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240201-am62p_cpsw_mdio-v1-1-05f758300f6e@ti.com>
X-B4-Tracking: v=1; b=H4sIAAiSu2UC/x3MTQqAIBBA4avErBNsCouuEhGSY83CHxQqkO6et
 PwW7xXIlJgyzE2BRBdnDr6iaxvYT+0PEmyqASUOEmUntFMYtz3me3OGg8DRKt1rQxNJqFVMZPn
 5j8v6vh/pH8F6YQAAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Bryan Brattlof <bb@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>, Jai
 Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=PJtYPF7B+6q2U3RMryrKKpIH+WItrEDgBkayGdFOZQ8=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlu5IUkOeoRI62IyANgxeGsgTy3QKJ5xNrDXCAF
 1avnDFTey+JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZbuSFAAKCRBD3pH5JJpx
 RSMMD/9QxEHuc/9jIB5y6GA8E4wdh1fxtEH4OKeFHRsW3BCllRqqNfEPZtBArT6EV0jzJl3nRHv
 oS7GNpO2TTxesz78yfJztk0yMhF1tB72d6VAgzS35uwbG/PZAq8uTUXihH+xfBteln6a0XUAbY4
 SPfiWuMR8UgXISkqYu5SDuWabKTlZD+cFkFHUr0StozbWiAyj4gvbcxak1qAeVz6ITpCKeFkAqH
 t9ZOL57nbRGVHaa0FBicVSfzDGkHkyIXuN4kPIL5Ph214aNbUNurXFPxhBi/AR0KvLckaZtIOhl
 9napIoV2NJBSupK70VENMgxWWgS/Olf3tVaYSJ785t7o77R6CZyQjZIQBvfIjmNSXCQRL7D8cX+
 FY7q1fp7oMfcQpWMshfdlWRSA7JNqdZgqBDq/UTiZtGSKtas/FJWpTbKOcZvpFhevhGilmj4ZAo
 POLujOex4tvwIZLhVS9AkZGls8gVCEV/7ZZRbMDL8yP3JE3XA3MvNAPwgxjNCZJ5nw2IbvCRwGM
 2AUtP3KioN4mwLOenMc358WQ752/noTVSXWj9rfoDmcz2Z5IAAF7/Qh3lWVEXAnCnrwt++ovwHP
 uEyW/txKBfpBxxa0dbKnmRcCj+zHLfZng5E/kj2xfhKczalVP3DlOuVdX62+pekqakx7AkTzZv3
 7Ee8IiePAQwfDdQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Ravi Gunasekaran <r-gunasekaran@ti.com>

Enable the CPSW MDIO node, and link the pinctrl information to enable
ethernet on SK-AM62P.

Ethernet was unintentally broken on this board, even though these nodes
were already present, as enabling them was missed in the original
patch.

Fixes: c00504ea42c0 ("arm64: dts: ti: k3-am62p5-sk: Updates for SK EVM")
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Boot logs: https://0x0.st/HDOO.txt
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 1773c05f752c..60868862e3b4 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -445,6 +445,10 @@ &cpsw_port2 {
 };
 
 &cpsw3g_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mdio1_pins_default>;
+	status = "okay";
+
 	cpsw3g_phy0: ethernet-phy@0 {
 		reg = <0>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;

---
base-commit: 01af33cc9894b4489fb68fa35c40e9fe85df63dc
change-id: 20240201-am62p_cpsw_mdio-27f6a3ade8e0

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>


