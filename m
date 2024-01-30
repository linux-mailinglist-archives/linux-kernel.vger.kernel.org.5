Return-Path: <linux-kernel+bounces-44840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6E842807
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324B41C25E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3526667E75;
	Tue, 30 Jan 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mxo6tG1L"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4906382D9A;
	Tue, 30 Jan 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628378; cv=fail; b=UYH+kqsBmClXShD3pTu9vFIyA0dg2RZfgHg3TPSteSLHv6NTSBB+2dx9fTcp8n2drhw7oh6axH6ki4+qFq7fNUJYK4UjLreHwnvDykvmahVzKzo5ZuCrhnE3YQdRMIUc3Y7FHugn+S5W7/9TPvo/1wS/wBapAtPz1IDlEg1LMyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628378; c=relaxed/simple;
	bh=82Uxwb6KYeIwTxl+6pGWHz6jMHunMbz8IIiT4okRNqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o3xDXf/mUaBQdCzczmJ4p6kVW5Q/rm+fm/bWDXSwc1iJtBZ0xQQf0rDI9SrBg5q7sRgdCeB6ITLg4bcWYOfsWnZXC789zmRBd9ppO+l1iKI+o7jB8lqZ2HsjW500sd9Nn4m6nfhQJFTCPpIntD816cccr6FwDYCBYTPd2KlzdR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mxo6tG1L; arc=fail smtp.client-ip=40.107.104.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIMwSYom+mQK6n4tjJDk7QuHYmzNkb79A2J9BNsalCVd4f1UC8+W45OiN0hjz3ALm7eecs6KMQwKHFAe728lXo0Wo6RddwGVrJKkw1tCEeuneRxobr8dTczHf6pC8EMfQUQGAfYMBkb/5fz/AXq9LTKMbNB5zG3VcYKur7Qr/dyFtNE07tB8M4le2iqr0+dcK2Bf3KMDcCTGs6hasbFNbwCDauQ+QgpauzPXTeVWCdjGT1QvuBRI0Z9Ehax3JbSl7671LVnuRP3wdJqsj7aYMgtbL2C9DaY7oc8OV9BngBo3TdgFhImi3ZNNXdmisQPejSJiSeV7CbjDXc2Qu8eUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErO6zUuCBQOc7sKdg/ohZWdnS6bEbQihVwwqb28T/8Q=;
 b=S8OhEPUGIeWlJZm9HcUxgP3dJLknkqtvgZemNdG9OfLsVAFPUE2OCCP47xcgGU8N3JkppQFM5E0ni3B5YEaYc/6JNFFsU0SVSv6tFkjJyL5eeaf4gb0e2hEvkWZBLqVvWo7u6T41LsUd76cqB6uAMHhJn2F7NnWnSIoCGvVEVfFP/uC0Ipl0aR8I0fcRKsWVL4J1+6nZPWF8zIE8JWxRyGBRc0WtOOoFyjJwSzTKbNzonSCquM3UQQCKyWGV200CehKiHjXBoGLpAnp2C6QIvOnEyCBdORZSsY12N06niV1gv1JW2BrwgGruH8uoM3Xi1CPJTepFUULHuJ7Yojux/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErO6zUuCBQOc7sKdg/ohZWdnS6bEbQihVwwqb28T/8Q=;
 b=mxo6tG1LXbw+RzUMJUsnQJ1ijgt9ui//kRPuqtmreU7Z7LzoEVAW3WY7D97abIlkVcI+9ORqLZUe3Ozha+uHIeWPKgn6ixy0atMv28cUYBzfNbEu9jl74lCnvPEhbMJX1wSawgYrwDDjGUS7+1MvTp1IZwgd5qh4h2YmxRoB2hA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9902.eurprd04.prod.outlook.com (2603:10a6:150:116::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 15:26:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:26:07 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 2/3] arm64: dts: imx8dxl-evk: add i2c3 and its children nodes
Date: Tue, 30 Jan 2024 10:25:46 -0500
Message-Id: <20240130152547.272125-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130152547.272125-1-Frank.Li@nxp.com>
References: <20240130152547.272125-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9902:EE_
X-MS-Office365-Filtering-Correlation-Id: cac82d53-b173-432c-82f3-08dc21a7c7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JqsrA5Xq4DOypkfcjNKEPmr3djrCLKcZ+Pu1oVtpVBAQEDWeKeOgQ8r7ckfbhXZNyNw7avr7KmX784xq5PmvvXUJxlMhGMNokdWcTBEj+jf77zXdBkeAS7lutedzxSss3gWCA+lnk3VnOn2QRKcpAWNy1q5qNropXzBigmuX760szGBJrGXwyuhrPADTcpJTiaIToCVZ+6Q8A66PSH4LyRsBNxR7ZnAi+HunO0dnayPn9b3XJ9qKx8JTcyNc5v4gomwygF2hc3fQHXlubUlkGAZI/7HQbDuwcQsuStV3+U7jFz89tE7j+YTMiHnGhIbHb5ulGK/oorhC9qY1jYrt3wUMHgPpCu1sKd0ClR8iOPWt4WH+SRSLkb65qAfNqltix68aTfF0wjbVg7xPQwaAkuqvqPkM8Cl+2ZHO7BarPddFqyvK5LASoMA9XjzfXPJAxY5/dHyH0D42HIPVXtyBZylz4jpx7RaizHS2Ss+6fRVPLzokF2k3+fcu/i1f4Eoeh/Rj68BWARL/PyegGRC9jTd6tj7XgbyjkjVWgi1ZPgitKDS8yBxc2ceXCtpHEsQrVD1qkyccj6DoSdrINyoiUdmXCteuDSKXMnk7xdpr0DJG5WbGlgi1r50J8XLnJMgq2KIHhjbV6O9LqB/OyjObpBowfk34bGbHTe89uwF66Tk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(6506007)(52116002)(2616005)(6512007)(6666004)(83380400001)(26005)(4326008)(5660300002)(8936002)(1076003)(8676002)(66476007)(478600001)(6486002)(316002)(110136005)(86362001)(66946007)(66556008)(38100700002)(7416002)(38350700005)(921011)(2906002)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n4Wa3i6BV5WWiBYRts3HM7TDQ6ns0s7+B7QVyHgfGxAqxe15d6lbLbJNLNSm?=
 =?us-ascii?Q?teAxVPNU4RvhEvWGCSaf2NhHDWu3b0vYR2n3xcoDDwP2AolsR12yPrVfiAZX?=
 =?us-ascii?Q?G56pElchK7+4i7KU7BmItEDUupKUFa5ROqW5YIEnfxl2HzapEcuIsniafyXU?=
 =?us-ascii?Q?6hHPF7hneMW4KwM079XkXA/jwHDR1sOrnwnMXsqMHrqzN/XipsJ0+HA/NIat?=
 =?us-ascii?Q?WjUfYsqBIa5iKrTxb6VK5jnWXdflRRxGYC9BkRKi4YPh4zJfJiNB+UNn63+U?=
 =?us-ascii?Q?l/Kg8pUBmal+71HMFgeG8G8wob7P9KoN70m3ZLd7gessad3exBEFi5WJpc/k?=
 =?us-ascii?Q?UsafoLpnoahLiANlrQAVLp+VXWjFck829igDm+VOiiYQ7LxJ8eoWLbjbP1ke?=
 =?us-ascii?Q?SE5Z2lRybatsXRUFux/+/2uXaCHzw4mwB95MV/TNqr/yLZOpnsTCV/oCOp5N?=
 =?us-ascii?Q?6gs9CgdewDRHbFgEktD+3Mys5uBCHv0NSj0QzseBRlLvmqAQlyybe1pfOnUe?=
 =?us-ascii?Q?PCPegfzDzn2IzO68Y6LMxK0ZCxZVsf9NJxWj3DMh+abcohrGfGcT79mBdWkL?=
 =?us-ascii?Q?PIY71oYX8s/6Y5K7a+E7SFWdQZF3R4NICzTSidA3jWRJADkXba3djDpEEOvv?=
 =?us-ascii?Q?bBd2/9/PJbAnxsA52CcSiwhGZugHJfgKS9fVmWCe2xeb13AqulxmL4G6V3OG?=
 =?us-ascii?Q?/JMngLQgxj3QXVUhYApD1e4FYl2bp4e4kGte8WtGFLwKx49CALwjRO2uirTW?=
 =?us-ascii?Q?qXMHrI31fJ4dwUIFmy9z9T5VfeqxxuV7HnnAzqAnyPventxW6pUoO3Fanm7n?=
 =?us-ascii?Q?deg0tCWX8Jaqdk9v9BWURFZiEJGagOQNDhA+jrzyxWDPJcTJ9o/CTiYji/uk?=
 =?us-ascii?Q?S34jxXuQIgHhfYTdYR6zzFstHVrps7z1evkqGeRg5uCmLIQMq+PMTSsupjti?=
 =?us-ascii?Q?v18DpJ9ChiLjYtUBObPQ02qC706nJRuRF/8/B+hFGbQb4qF88ARkBf/Hnz95?=
 =?us-ascii?Q?QZMALjlU2KPdOi5vk9WwRk+9Q8OQkwnJDa7z4HvUWASKH4nGkmmVrtG/5oM1?=
 =?us-ascii?Q?X5F5SNhSs7dx5c2w0tQM90ZNhuZkTP2autjNVYXSIzmeCt5fVJ0SpwRnYOiZ?=
 =?us-ascii?Q?hR9VoM77NDDGfPoE0bWYcMdTSblqpGkAH2MguuIPjOfNMHjNSiZtC0NdTolF?=
 =?us-ascii?Q?8P0m94T4p5y2XxkMbiNQBepEh4WjtYW2g8Jc5IhgpBFjMrdCOwE5gBE9V8dV?=
 =?us-ascii?Q?eO11QKk24+PZD5vZomWmrssWGhguPqmVoEwE0RlH2CH3S8bLypLPHIKCYCJX?=
 =?us-ascii?Q?inBFHq5nf9O4NN+RxofuY1PMiyE8o3caYbkwXZD2bj49ceiuLiR+6AOktqP2?=
 =?us-ascii?Q?PkDf+EQFpr3YO9gdOR9BcT8LV/Ue5Wu+VZROiqh2QVZKjdKLbY0KBBnSrTf9?=
 =?us-ascii?Q?lk58XMLA6gTS4/01vOyB7tMO7ozWvayTaI4nXNpzko6TyCy3a6qA2KiUvrq0?=
 =?us-ascii?Q?HR6PM7h59cIaAYL3D4IYFnZfY9s6mD4ePjmUQLSQUWfk5J/XDw4ogTXU+ams?=
 =?us-ascii?Q?BdVLPdjbNVG75gAGiUBLVirzfPZC6VMrkOKmCE7b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac82d53-b173-432c-82f3-08dc21a7c7a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 15:26:07.4128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1NKqw8PjHpWdMZ9JBO1Mx1OwfYnSFksQgcCOdXEgpotPu85OCC9USEQnmG3qBEVqGzWr3o0+kWWYxltbRaUmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9902

Add i2c3 bus node. Add i2c gpio expandor pca6416 and i2c mux pca9548.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - move reg after compatible.

 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index b972658efb176..44da3cc331d84 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -261,6 +261,61 @@ i2c@6 {
 	};
 };
 
+&i2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	pca6416_3: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&lsio_gpio2>;
+		interrupts = <5 IRQ_TYPE_EDGE_RISING>;
+	};
+
+	pca9548_2: i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0>;
+		};
+
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1>;
+		};
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+		};
+
+		i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x4>;
+		};
+	};
+};
+
 &lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
-- 
2.34.1


