Return-Path: <linux-kernel+bounces-109574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D28881B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7769B1C20F29
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0874A79FD;
	Thu, 21 Mar 2024 02:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="4U7xe3ni"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2085.outbound.protection.outlook.com [40.107.117.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580442B9BB;
	Thu, 21 Mar 2024 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987195; cv=fail; b=aQ7XZEbmLIEZJmRT16sZMYiQNCnTG3H2uLwNF8QjNUAHM/YV57xkwoDamuHC2vXCDlmnosu6KxLuz56uSjHFZMjAwgySa7La7WHiUb8hp1EsKX61yFBUJ40+NFKywD6EY1YeeA3x0dGCEtBpDyo9HQ6G1x0qHeJNcoGiGCrjHCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987195; c=relaxed/simple;
	bh=txWVjxf5M1azjUBFsdoh5hY7ZlZFY10WpwKXe3IxzYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNygPrOvENrGrI5o/uwl+s9hJjKD+HkBkltPt6kad3+3CIHiv0534UKHAUyVYw/VZuuLg75ImLImhwNPuSEwq22OcdYczz34pBexFCUm+AIAflATgAxVpGjbx/NKrvmnOmtnCNY55Z5b+4NAtF1AT8oILEPLDiceNNlL8fDTTWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=4U7xe3ni; arc=fail smtp.client-ip=40.107.117.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSu0u4mYedv2m36Shh3iBWcES+TDAK0bswAl5adi3+3JzaJLENqiyGnfvajMLJcTGPcK3kQQ18kseHBfXHWz2+eqruMdEsbMPMgX6UF/Cah77JQPP8gZmo7H9maq1gIMx32Ego2cDMuQzs3EGaSnukupz/SMF+Zc2foOtyjl6ggbsivIHfkk9ZNa5z/pY/NypV5d2QzhO20mwUXR/V3lIaNKXV2IDgt+Mop+wei5XAKR7lTw7aeOtKAQNkR64QtMzzcR3+E4PLR6udf/dJRGPSDJRCYi8RIsFXSWH2GgKfzYiFzWtOiuIE90bh8PS/Co8JKuQlEjWr5NCY5IwOQlTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXnpIj2eH8AGfWV6lrwwFZGZK/9D6DpLcSqQXWjnNyI=;
 b=QGcLf7F4YzrDWGjoAiGhnKztY9WIMDQBGIaPjB9r0Lm4Frlp5fKnnhtYXTqtJNYv+H9mlXUPuNp3SA2jBVIhsBpL3sMrixLyt4zEd8varI0mS4d2n2iFrQyq7kyMLD3FWfhwMGIK9dEZn1ikv4X50yOd626kv/Bl1hl80BZ/snANlR9n1nclyQOq1H7OGxVEjtgpd6cHpUXs3SggFgw8l8UiNHCC2IXeonnB+3JJ3NWSJjSuk+DyO4ozP29n0IHZwAv0xT2rbK9PLNFlrGYfwgzRwAsssIji7q7u3n9borJgf2rJOtbqXARE97j2xSa3L8gCSvih+fYMKNK1isfafA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXnpIj2eH8AGfWV6lrwwFZGZK/9D6DpLcSqQXWjnNyI=;
 b=4U7xe3nivYty4gqunnAmwXuPi7br7U2PXxePTefsNfkY+MiWL8R0DlGi0o4p/j4vSFp2/BV/bdKcSQQejv0ggkb1dfa8zTt4R9H0CCrcoI2sOmzkoX8CoZrUbGALEDdZu8X9+1XwJwyAZVRRthPM7lcm6ZuOexX6bdjVXt2R4bCmtu7iHsxXXi4FXZCBh8acQjg9DFBtIOkQz/AsLYaJfLaNQ8UE7J4N2oFuVuvOC2eWEMg76o0i9GLfUll4QHbXoXnmfSRqZPdr0rZWFvJIdFi5P0gsa75E0oK5b7A0Myv9nY+eOC6ZdHcni3pyW+x4IpSEExMGExW0U882SKgiFg==
Received: from PU1PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::22) by SI2PR04MB6129.apcprd04.prod.outlook.com
 (2603:1096:4:1fa::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Thu, 21 Mar
 2024 02:13:10 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::a) by PU1PR01CA0010.outlook.office365.com
 (2603:1096:803:15::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Thu, 21 Mar 2024 02:13:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:13:09
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 10/22] ARM: dts: aspeed: yosemite4: Add power sensor for power module reading
Date: Thu, 21 Mar 2024 10:12:22 +0800
Message-Id: <20240321021236.1823693-11-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240321021236.1823693-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240321021236.1823693-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|SI2PR04MB6129:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 06f578c3-0b9d-4014-6e40-08dc494c748f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HZDFQ1xqk04aLYFVQvTZHCALG0zOnEzKiVL2Ypa9Yq1ji6e+jogsX5p32Dn7O9k2z9SKXRLADcKTj5UTi9gDCXl2JSLzV4deH36ZiH/FTWitSHU4xUkFJkI9FXqyElwWINr10gU+2G40mSlXJ9R+HjoAcNYCpS0DohERW6znfQC8UrdZVC6XS1KMZBCMwfRd6X/aXeCPzjuYGM3QlLs2hSGe0dtp2FQJ1kU4Pmh7RMK2/9XX6hK4ZvG3T2E1UycyzYYmTcGYwG6NPPdc2p31yK5gwzQNqMspBGXe+LbTdA/pz3qQ3M7XWUaBRsy22OLxcT1yvCAagQSPJlHattyFPnG2ecw9i6C1liHUEA0dKem2ZReK3YBUMFOHm+Z5fZf10t9LFcK9Y4o85jDmS/dBZppUfl8uCaKZu6RFpyY2iCkOt5zMfUKVI55lgSQ1iw32ImMRvxlXX+1Th302pXLJbrFLNMbI2eiPu2/KVyOr+9ci/ys1zJhn3NT2vRS7eXKEHjeeklamlUoTHsrEnFMCodKOIE87F6pyb89725DfQovbMDWXKfbyhkbQLWtrDenWWhr+xCvHkdrjr4IjzLMa071q7xZqtrO5f32olUzOyKxgAjEJOFbYQl9bRjhpWW6Ex1yKwaErfAxyhpbZgNnkHY2UNIgJAf9gS8reUwrSBrlqBeAVJkPA0SULUUAkBEUj9TEzb95zoUihAQ958+Y0FZiMP5pnQbNQuAJhz5xFZ+l/Z5njpPn5CB8N789bUt33
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400014)(376005)(7416005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:13:09.9479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f578c3-0b9d-4014-6e40-08dc494c748f
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB6129

Add power sensor for power module reading

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index d1ee5a6bd7d3..175bb5849e1a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -906,6 +906,11 @@ gpio@23 {
 		"HSC7-ALERT2-R-N","HSC8-ALERT2-R-N";
 	};
 
+	power-sensor@40 {
+		compatible = "mps,mp5023";
+		reg = <0x40>;
+	};
+
 	temperature-sensor@48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
@@ -930,6 +935,26 @@ eeprom@54 {
 		compatible = "atmel,24c256";
 		reg = <0x54>;
 	};
+
+	power-sensor@62 {
+		compatible = "pmbus";
+		reg = <0x62>;
+	};
+
+	power-sensor@64 {
+		compatible = "pmbus";
+		reg = <0x64>;
+	};
+
+	power-sensor@65 {
+		compatible = "pmbus";
+		reg = <0x65>;
+	};
+
+	power-sensor@68 {
+		compatible = "pmbus";
+		reg = <0x68>;
+	};
 };
 
 &i2c12 {
-- 
2.25.1


