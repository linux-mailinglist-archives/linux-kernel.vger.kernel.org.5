Return-Path: <linux-kernel+bounces-109583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DE1881B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B3F1F22B72
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D6477F27;
	Thu, 21 Mar 2024 02:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="EgpFbO1K"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2067.outbound.protection.outlook.com [40.107.215.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8BFBA30;
	Thu, 21 Mar 2024 02:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987221; cv=fail; b=HCnYL2/4VPsm1u2rD9bX9LFadkoae7ctJEz4OQZ4OluuEGFrs/4d6xVoaKQt7o/oSWLC5w4WN3Dy22ao2cytGqIyLOo6kNhzd6uxXNdXjJaWl6zqHEtyYDnJxXxuByUHUpgJAMSe91rb9M5MXqwuVfEiJKOmn6ijvgWwXND49Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987221; c=relaxed/simple;
	bh=wMDdSilVQpFX3ai1pqdv2bP7f1UehEBrTt0w+hE/bbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNvOrRpwVPKZYs30p/sYaJjjn4jCrQs1C+MKZYrk8xGw7nak8rMXvTi4pyD916et9bk+fDO6oRYMJJ5N7G/GbpqeL5wtpwvYAQfIvmINCdiCV92koc1GSrkgOrxjDnAvgfj/1nJzY/ctV4+3DLFSsmv9wXym0hpZCtj/THqdR88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=EgpFbO1K; arc=fail smtp.client-ip=40.107.215.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9DvkKzhCZm63paaaNn+6Dk7wjAGDId4vF6QDY92fwQRQtEhIrj94xfqEc8YFumJ0x9dR8zLRl+dR8hryE5qQEDBVEmMFqhN95TskXoCTbj70hz9sSET8b0BTUrpO1h0R6M/QOoHgZRrahoqoFPyuPsOSL1mHlXr2diTx70TaL9lHYrgA7AnPfmHADjEjjnbItanoT0NIxDi9qRAfL3SGS0eQZkXpt03Z+ie/CHmL3oy+zFe4X9xcEpFb+ItGl8uhZ6EqVxEO3VFk0BpyT5GLyGQe4MQJ00SxFNICMCgKUUZLS3ph7glLpnLrSZ4lQ1vG5OYEmUnrejZoFQQKz2R2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9YPN4+GKhRVOD+PVplTunx/K5X+lj3LHdrFGWn0TtE=;
 b=lyx6Ns4zOE1HgC9bZf9mieLRRxXBDpp3IquOqotsB/C3+wdoDaBP0QL1OWsDrWa3sZpUc5czUvMoxdLFx3Mi2X57frtn0J0mI/tbhlaqnzMc2YdX5/0BIEAokzPffy5n63lufR7hXBhmqxVxpXjZAk95HbG48WguK6crt2bYJiCPHBuFJk/TfQjuRmg6NSYcTeRunQ2k3SJ/O3v0sVMQBvL8gZ5IXT7qg7PF2/mf+PQsM7dtaA7+8SvGbubK4t3mqFXJASaiBJrsgJlFdHuQkFLB+jAv4+ko+Ppytp9G4Y173luPfltOkgMv1TqjXbkBkymuflOOjucyhkOUkMLt9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9YPN4+GKhRVOD+PVplTunx/K5X+lj3LHdrFGWn0TtE=;
 b=EgpFbO1K5AF0NVEpbrcTnTW9QrIc97kQoTQLp1jq1wP20YG5aQb5wYWyzE3K8Y6gaVrbFlTyJ71VIK9ypP7tDF6Q1WW147/sKmLScnRFEHAv5fVF6YHFnpCg5Lt6OeWHcDsbe1xkj3BuXNF8n0tpm1zHcNO8DmdiWcR6+QANFfh1m3ZQJn0dByRfTMOI5s2EFtfOZd0dnaYq+xHRolVMfTlqBl0FDHR0bXs2dJW+kXbVWL4bPYh9aQLBEdss+GG5kjKJaOVS3vVgkrMdTiVEXhyMSE+wrEVc6H3Migpzt6WO/HHxdqz7gQXEtvuiORAfUph4iLo5BwBB2Cs+j7+QSw==
Received: from PU1PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::32) by SEYPR04MB7040.apcprd04.prod.outlook.com
 (2603:1096:101:171::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Thu, 21 Mar
 2024 02:13:33 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::a9) by PU1PR01CA0020.outlook.office365.com
 (2603:1096:803:15::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Thu, 21 Mar 2024 02:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:13:32
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
Subject: [PATCH v7 18/22] ARM: dts: aspeed: yosemite4: add mctp config for NIC
Date: Thu, 21 Mar 2024 10:12:30 +0800
Message-Id: <20240321021236.1823693-19-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|SEYPR04MB7040:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c0d9dfdc-6866-4af1-aa56-08dc494c8236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4v6Pfl9T08ed2m/kgyBDkLs6U6/WDsnq2lGqODcycP6LCcLgfY1/KE7s63Fa2afjsl6NNv5Vf5rnXLQuXQ0v0VoCt+9bDWycg2lWMrDF2ZFK1j1AtFpfKb0RcwB1Q3t+FXML6dgFAh0ZaUVTF/xe+efsAUicMRBxg7wIxjwzCHpkzqQUTEjzyJwNZ6RoJk13qxnOUS5Up6lBygZovXREpqpjchwGFrbCT+l/k7i7kGwMxa4QeIqUcZVEpjF445ap8abr8EYxAlh+54Mki5rSqNO9p91Qa5O4AWG8U1i/Qst3W0c6oek5cXXv+MSJOPcf7oOzeRxVnkAgN+RE+dLMD+934oWlVO3tlMiR3w02zunfurqKCUsIY5HKEEmSWEXr925VulNb3tWOMmCl72nekH1mY73gYHmk31ekniXmxK2er6erdWfJPpbrVLUlO0stzuYpWV3OLqzBIFliiQ1gXIOA777T1NhaNlJjltFv1C6jYHQiA885RhuairmClqeMH0lj5/xWMsK2JFJmkKPzMEPP/CoGXWNSJACOj5EXREXeY/2pL4mSlAtvVv9L/AOQslp0yMZVC9KSssJksKrkkA/BN9hgexR4cWbeY+ELGTsudeAFDEDi26vh3GEIrOQ0Adb6IPafUnpo8pzW/lbGyzOIeQ+/36TeN8EhMghpMcvjos8c5sO03OlkJ5wsPtIywDOx0B74sHxuFZsO9giP6WQ0Gf3quVyKyp5bpdT7ogQjPCLgFLOtUU2o9N7LmemT
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(376005)(82310400014)(7416005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:13:32.8543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d9dfdc-6866-4af1-aa56-08dc494c8236
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7040

add mctp config for NIC

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index e0ca0f7b65ea..0d2f0c589944 100644
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


