Return-Path: <linux-kernel+bounces-46050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDC98439BD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC57288DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344BE129A9B;
	Wed, 31 Jan 2024 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="UxwnNSSN"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2049.outbound.protection.outlook.com [40.107.215.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C82067A18;
	Wed, 31 Jan 2024 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690577; cv=fail; b=K8vUY2Y9TXW/qbyXXhzJ4ifjnjHHMZHSbT3xbYUwoCpGzhbar3JrzvYHWz7VCKaGZmZofS1vsKzOemvgYgVvnGMW58pgBtgVakU1gd+w8VhzscxqK7CBm84OO0tSjODQWVQx7iNYCPMOCJiMep4h3uewB6dcApjsvP83vl/2V3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690577; c=relaxed/simple;
	bh=FYFgujueD+5RgUs3I3tZAHQOD/QdF/3ZVpxGJ3VGmOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHl4E4LJyNq6vPewVtqgfyBPp6O07qbPQlsqi1IulFiwbl7PRjtyK4L3ECfboNCW7C9giRRQm6xM8iSVlouFGqFgTMUCAQ3DsqN+5NEaRMShHCjESxzIzUyVaN5ptPXBnHkkRkomtCHRw0kVC14fJXhiubl+we4/FsIkJLpt5Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=UxwnNSSN; arc=fail smtp.client-ip=40.107.215.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL7+SgZUN6R/ASGLSzUJFUOJ5bSTiUd5O4aa09TDk1QMshhNFMIFW4sLbiuxYhJ9MXBArMqIL0ZN54Q5VMp73WxXVsk69xHtb0Lvvdg0ydtchdwy5Lck8MlZLyBdVJjrd3y1FRB3v6w9Lw4CiP5cX+u/WOZWXWZSbU2mEgCgdsN3R3X92TkS0UzpBHMQLvF6/WfxCHkZgRF4/d9hyvkzodkMLECAM2/ltBinnMhlwJN8tCv69esNey9agWHXkOZKNfojqv6V9o4wi84FJmwrY7hLCkV2PSSJFsJGeFoyBmjuYS7L306LA7MC+mJCQgmrlMZ2H1zlPwmAy2Y2PzUXlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DumxQ+D8dlwSG1bj+6vH9T7UFgzWxQzXTIKRiX+pbqk=;
 b=KvAjB6KmadyUNPIM/z8eKr80stU+KWhYhpML7hWXBZEB9K14lqpa1hBJnw247jUU+c/olx8FuPXDvupJz5Uq7yGv81u7Z8jc3thP/QHpUlIEZEjDu9KhZH03pw7kD/svvU5Ea7Cb0HdDp3OQgEyFyPmlJ/zL1ZUfF4dKufKNt63Sq9RGYCC+GbFU+Qoq2J8HLtpsM+l7FhbBxBmvIC/w1mR2g9YJT8at8ojX/SwfkCpEG0zk+mXz/v+R+d2+w+01xSJPpBYKwJlzyksafnny3nA8HUUQFDg+C3Tm98LTqOApmBoittRmYlfsDw7QPhChmWRF5H8Spn2moizBMe0E9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DumxQ+D8dlwSG1bj+6vH9T7UFgzWxQzXTIKRiX+pbqk=;
 b=UxwnNSSNld1vGISPFb3DYXYcOLDYYBikC1oJY40g1q2mg+EsMrbSiqx7f3g83XGFHxr0vH6hVItfRA2uW0OJ+fSQusWICv8d4ydHmehsiFFf9PMvumCQbB8tw2BGIaF1pJJqviZck7nZV1ersGI/yy3J/fkHeQbI3f0+8MPrCGDvK/XC09GtrELI9ug7TV/uujr3Xctr7jMczuC13Ev/vNz/Y4Kn+cLWeMKgqej52avmAp9or0d5x1jYMJ1CUMM1H/elAIe9a9F77CUPYgJqYfD0GaimlEqjW7niyG4qY+67fAJuCta5BUSUwXv/AdbvTWKUHtwHfitbzuPyMmYzSg==
Received: from SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20) by
 KL1PR04MB7345.apcprd04.prod.outlook.com (2603:1096:820:10d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 08:42:52 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::9b) by SG2P153CA0033.outlook.office365.com
 (2603:1096:4:c7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8 via Frontend
 Transport; Wed, 31 Jan 2024 08:42:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:42:51
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
Subject: [PATCH v5 18/21] ARM: dts: aspeed: yosemite4: add mctp config for NIC
Date: Wed, 31 Jan 2024 16:41:29 +0800
Message-Id: <20240131084134.328307-19-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|KL1PR04MB7345:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ca4d0ace-f93e-445e-0327-08dc22389ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ik7RDYGEHzYp+hUOgCKjRxp/A4AGoOGUVFl30sTql7OFEvTfPjupplK246fJSD+/ZFg3Qg6ow3ayZ7UL5QG9gV56LLq3RrAhNxF1gtRF+iL9qOaU8kIzGuR4Lz0n8MiDYm6245Ji2GTAOS4drMTP0F0O19fjYT3P7YiOBNCrvtJYs8uy7yrWLJV9csFgVh/bLO4rQS9ppb+SZdrtk1RBIZ+fkzg1pviovLIuXJ/YhaMhIhHj/8RDmfH9sm5taWv1Df9mQCX9tbBhvfCL9szL8800Frmk5eIjZ6mA3xWHxJTMf63mSWXSp/qW8NM869eQ+d1Ke+foNnc1nXzfRJ6bB6Rthuc46naJ9XWXYSmBuZvSEy1z03e+WU0p0ENtchQjs6AhyqzlmC/iMgW76PbyIJ5H5b+64L12aQFbhJejkFfTwcW/kD5inwlmysFSh2sY/ngw8IAy37DnaRJARapyB4hwAlwfs2PmkEvS0BLsyV+wp1jUGJslHfa+kA8kxtHbLo2q+PBxD8n/vCbTx/Bjt9nT6Wj+943QplUxZEboSXguWrbfik0KguMEhuUSVAMcUKuVWdhgtZSrsUCYPsjIzxwtOMPcnGwhsU6LtqAvJbqGyDd7V64mQMmZ7V8HQxP3BLTWpwWuodUB6XxsitU0W4Fsjbf+1KLt+J3rhokGAfLGmzD+ZosDbNq2sRqgn1nMhYgE+RRRbfylD4IZJqQzQg==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(46966006)(36840700001)(9316004)(6486002)(110136005)(36736006)(8936002)(2906002)(86362001)(8676002)(7416002)(5660300002)(4326008)(70586007)(70206006)(316002)(81166007)(36860700001)(356005)(36756003)(82740400003)(6506007)(478600001)(47076005)(6512007)(6666004)(2616005)(41300700001)(336012)(956004)(26005)(1076003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:42:51.4425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4d0ace-f93e-445e-0327-08dc22389ce0
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7345

add mctp config for NIC

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
Changelog:
  - v4
    - Revise device node name
  - v2
    - Add patch for NIC mctp config
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 7c7c9e85bb92..b9b6fe729cd6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1273,40 +1273,64 @@ imux24: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 
 		imux25: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 
 		imux26: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 
 		imux27: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 	};
 };
-- 
2.25.1


