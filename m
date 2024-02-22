Return-Path: <linux-kernel+bounces-76419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAFE85F71A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506031C23564
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385264C63F;
	Thu, 22 Feb 2024 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="baZirKwC"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5533FB27;
	Thu, 22 Feb 2024 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601617; cv=none; b=bD+ESougOtetMmnjfloUfAmD//V2hirm9SQylstX+oj6udKeuOap+ZUGtnju8znq7EH/YowgUe2wBegQ7+3EIziqJB1y/8r11Jr2M7LUkysaYjpW1t086DudCxsjwkDswFhSWGPPJnfqcPUS208DsR2X/SFys4DLucy7tVPFiYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601617; c=relaxed/simple;
	bh=xGHj86FA+f6kWv3VdyKdm4QdgFyq8JS4xFMjziCTvbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eIlieR6gmvu8m3HWItjFyUXd9aif5v5Tl5u8JyI2EGEe+TDGMp/qI0+pTrIAEa2bHRuh1Of4jMvyXbHQTb11cgU3Gk5yHt0oDgS9GEC4gUxUSHeSOqgSJaiviOtDBOjPX6TfL65o2TarrbXmECVU4t396/CLnbx1HspWZH87iHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=baZirKwC; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXD2N018037;
	Thu, 22 Feb 2024 05:33:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601593;
	bh=fdOYox9DC6gaFbNXKWSXcI2XCkmrQ8/pFo/KcAvlo6Y=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=baZirKwC6JwTXys1cSizX8hmCuvpYWaycLHOivCO876kUyga01TegbnYTvgBFCwNz
	 NfHBHM3dpOsNKU7wUt6KsAuZ99olZPZ2pRtw9pOa47rOhPbLSHWarVxlNRmiRKevWU
	 R+Phkz9v09SeQ4SdhpmWuR4YUyvM9rqCfR55+EBc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBXDtd057088
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:13 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:12 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXBa5128545;
	Thu, 22 Feb 2024 05:33:12 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 22 Feb 2024 17:01:20 +0530
Subject: [PATCH RFC 04/21] dt-bindings: media: ti,j721e-csi2rx-shim:
 Support 32 dma chans
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-multistream-v1-4-1837ed916eeb@ti.com>
References: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
In-Reply-To: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans
 Verkuil <hverkuil-cisco@xs4all.nl>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Aradhya
 Bhatia <a-bhatia1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
        Changhuang
 Liang <changhuang.liang@starfivetech.com>,
        Jack Zhu
	<jack.zhu@starfivetech.com>,
        Julien Massot <julien.massot@collabora.com>,
        Jayshri Pawar <jpawar@cadence.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2376; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=xGHj86FA+f6kWv3VdyKdm4QdgFyq8JS4xFMjziCTvbI=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDdzbRg1271XX4f/9jlXsbLOF3Q6G/iDZBAy
 YSvFhRrrLyJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw3QAKCRBD3pH5JJpx
 RbdeEACkJL3LWLqFl21Xy4DfTqvA1tkg/L8MgPXSHOtf9TKPwYY7jW6SeqhJlSq0tu/UiRVq4yE
 fKo4KKhyPA0ZLwcyKWR1RoPey8JKwlYwq8ok3LzLw7x9IZ/OucXwCnv/FPS7HoIKZ6gRPB+/eJ9
 7ocgcPHmp5p6Sy9qCyhaUZRkwn3XYyTIo1gUjE3I3j9gBR8BbJ8Ox8fahCNfYmYUCewUcBRZJes
 JWW5N2F34HBeBY0ziJOLwmOm0HGtPmCTty44VwJLs0fQ5ovi/QBOr2by7nD80IlRnCU8rlU2XKp
 n4z2CiapprI4yWVHrnJdEwcmec3Bhmx1tSjNV3wnObDkIsRa9b+kjUG2SfRnAyNfP7gBmcxX9GT
 XUZEXiHcqLKKRZc7ruLH7bwcBShXCvQvljOGqcu3CBmcsuA54lUHXbr0SB7FnOF2faf7MXCecDR
 VZ+0OoDcPJYxmAQO8SHdfRGhfUJFk2ivyhQcOLk+OOetGq2l3SwGn9kIx4jHBFp5YadO0IuKWw0
 81PZ6IxVGb52CvJTCtr6Mj7mBHK4JzlPBH+yNrJV8D0E+i823O6wPpk0hLGY9JwR1zqpv4/D8XU
 lLD8CLr4O6T2M5zq63gvnEFKIjFSc0XXnLTXBb+UAcAQBpB5xIU8SenJwAhO0drPW/SLdURurIX
 owGra5fy3Gdgl7g==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The CSI2RX SHIM IP can support a maximum of 32x DMA channels.

These can be used to split incoming "streams" of data on the CSI-RX
port, distinguished by MIPI Virtual Channel (or Data Type), into
different locations in memory (/dev/videoX nodes).

Actual number of DMA channels reserved is different for each SoC
integrating this IP, but a maximum of 32x channels are always available
in this IP's register space, so set minimum as 1 and maximum as 32.

Link: https://www.ti.com/lit/pdf/spruiv7
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 .../bindings/media/ti,j721e-csi2rx-shim.yaml       | 40 ++++++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.yaml b/Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.yaml
index f762fdc05e4d..e47dab7b959e 100644
--- a/Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.yaml
+++ b/Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.yaml
@@ -20,11 +20,45 @@ properties:
     const: ti,j721e-csi2rx-shim
 
   dmas:
-    maxItems: 1
+    minItems: 1
+    maxItems: 32
 
   dma-names:
+    minItems: 1
+    maxItems: 32
     items:
       - const: rx0
+      - const: rx1
+      - const: rx2
+      - const: rx3
+      - const: rx4
+      - const: rx5
+      - const: rx6
+      - const: rx7
+      - const: rx8
+      - const: rx9
+      - const: rx10
+      - const: rx11
+      - const: rx12
+      - const: rx13
+      - const: rx14
+      - const: rx15
+      - const: rx16
+      - const: rx17
+      - const: rx18
+      - const: rx19
+      - const: rx20
+      - const: rx21
+      - const: rx22
+      - const: rx23
+      - const: rx24
+      - const: rx25
+      - const: rx26
+      - const: rx27
+      - const: rx28
+      - const: rx29
+      - const: rx30
+      - const: rx31
 
   reg:
     maxItems: 1
@@ -62,8 +96,8 @@ examples:
 
     ti_csi2rx0: ticsi2rx@4500000 {
         compatible = "ti,j721e-csi2rx-shim";
-        dmas = <&main_udmap 0x4940>;
-        dma-names = "rx0";
+        dmas = <&main_udmap 0x4940>, <&main_udmap 0x4941>;
+        dma-names = "rx0", "rx1";
         reg = <0x4500000 0x1000>;
         power-domains = <&k3_pds 26 TI_SCI_PD_EXCLUSIVE>;
         #address-cells = <1>;

-- 
2.43.0


