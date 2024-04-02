Return-Path: <linux-kernel+bounces-127790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CE7895107
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1A11C23394
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1115604B3;
	Tue,  2 Apr 2024 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PympfZDR"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC025D8EB;
	Tue,  2 Apr 2024 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055446; cv=none; b=RBqEOJSGwTQISxWTHNszY1f4sAxThrW/uc4zbQNgQDkqcp+lmop5/iFYjPUlHycK3tJK7GYy/IRTiLYyasAvjZ4sKGMv00a2oSJY96KaWfbrLT/muPSeuUOzpwq7a9wvNMMhhsFp+WxvHH85PQct40tSox4rQeGuY3Cm3WTHlhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055446; c=relaxed/simple;
	bh=kkb/d6x0v4T0ES9p7ItJaUk4MCCN+fKCo/y2LIHmje4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yy4MZmG/vuGEFwRepcFiq4Wy5eIowkSjqbROoRmh/Iksz5Sdcke3UvD0yokYd9fSkykidifIl3fS4h4A0XlzwotzeIMjhuUMT0iEczU3kqD9jEz9j3odpOAP6OHRLoD0CxBgy1akXj85X/0rYKmIPbEgURPOAtzkPEk4ullg11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PympfZDR; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 432AvCTw019888;
	Tue, 2 Apr 2024 05:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712055432;
	bh=3uB2rYs0bDJqtCFhZGoEKJlA5lhJ6eLDa3FK1xtCCOQ=;
	h=From:To:CC:Subject:Date;
	b=PympfZDRP5XV6H9VmNkyi3K3gNEdqWHUz9gLRJ+eRJ56xE6e7gRxgKIh1k/sb6ml+
	 ssAtUZOcSwB2ohzPvpbSWP9o9Bx7tISheFD/bjizaueC2mma6FLRbnu+2xJvanKmW8
	 3NqEg3uEY8IZXJdHPkUF8fouXV0lFXGkLg/S7FSA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 432AvCHJ080312
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Apr 2024 05:57:12 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Apr 2024 05:57:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Apr 2024 05:57:12 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 432Av8Gr078370;
	Tue, 2 Apr 2024 05:57:09 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] dt-bindings: mfd: syscon: Add ti,am62p-cpsw-mac-efuse compatible
Date: Tue, 2 Apr 2024 16:27:08 +0530
Message-ID: <20240402105708.4114146-1-s-vadapalli@ti.com>
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

The CTRLMMR_MAC_IDx registers within the CTRL_MMR space of TI's AM62p SoC
contain the MAC Address programmed in the eFuse. Add compatible for
allowing the CPSW driver to obtain a regmap for the CTRLMMR_MAC_IDx
registers within the System Controller device-tree node. The default MAC
Address for the interface corresponding to the first MAC port will be set
to the value programmed in the eFuse.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

This patch is based on linux-next tagged next-20240402.

Regards,
Siddharth.

 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 9d55bee155ce..4936ac0b5936 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -73,6 +73,7 @@ properties:
               - rockchip,rv1126-qos
               - starfive,jh7100-sysmain
               - ti,am62-usb-phy-ctrl
+              - ti,am62p-cpsw-mac-efuse
               - ti,am654-dss-oldi-io-ctrl
               - ti,am654-serdes-ctrl
               - ti,j784s4-pcie-ctrl
-- 
2.40.1


