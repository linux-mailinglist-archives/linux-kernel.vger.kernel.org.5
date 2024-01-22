Return-Path: <linux-kernel+bounces-32604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B85835DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8782886AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F52A39AD1;
	Mon, 22 Jan 2024 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="j8Jg5oz/"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2057.outbound.protection.outlook.com [40.107.249.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF803984B;
	Mon, 22 Jan 2024 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914810; cv=fail; b=fdgEi6JAr8nIZfRjiOgf6bOxBF8nlhmAYqCSnwbL3rPrxFO4N/yuCzoIkQ8TY8eUshmQ+GME2/CixX1B7RXrYEUio1AIFU1j81puTXK/T+c305D9SdzRBe5NthXGRNhfc348Z/qOC119k0n4Ra2+NgPHh04c/QREG6CB41ysVcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914810; c=relaxed/simple;
	bh=Sx5ueojNCX/R4jNCvEuAgiFDhuL/ht3iFSgcC9pbFLk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MyDQLX/yAmZebSZ3OkaFTY9/lzyATtT/n+YmRjwh8PFXmj7WqAoLbuiLOylCROVrFKc2rdtxT+Ex6MzRJpeLvx94ooW6Jx9lnnvESZIyfomFev2a4keIJ4IqR+hJ9LfMVVK/T8AxwhJxnu1T1kemucUCnzBg3Na2zuAX95gTKBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=j8Jg5oz/; arc=fail smtp.client-ip=40.107.249.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MapojS6/KajYjmvDuF/cbcSc1nDB5e0f4qhyUtyCmSQ4SFYjO0axRfyA+WpJgGaYaQ/fxdJDqBslxwg/zZbqSl2Oyk6o9PvFuib8mIhefjm48T4MZ1Y8PCIFx1EkTpPYSNujFWFZ0W2DdmJ1tzfq2Ijt6DIiwE/dSU8dlI+OVXQ2P8m6FHC5tBHn7YWtYHTGriV+raRBIlALje3Ebo9QuZ1gZJRgDfDoDrkCl8LuGZTK3Hnvluy79tEgGBObnaXHzSSicF+t8giGmN4nbWx4zj15PYrZJ6N2Mj5EErHS/tQl8mdzgxLDZ8rm7B1ryVugBhq8YwMi0e0jgd/k8H6oVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OjG4AoWwuAMRUmAAaN3es7l0fJ7Pa2qkw1U/8hqRyA=;
 b=REbdxf+5vb94eGm67waZmqu2R2HZ7bUApjuM8oxVUaJBnv/OYHta+9+ylrvdyatcVdqjLCLyBruKDPCHq0mf1CxForCXGtjdq5VlrZZSZcEqGwg9Dxd4eV1vwQB5740pRRjPZButJH8czp1XCNhsw3rdkX47032UIS+dsTMgE2XhIIUmaLxxdnoj0gNxMFfmZfkCwLobeMI3O1D7TPiVYEQoUbcKHz+YTegFt/gMY9ZKcaA8Xo7mfAp9MoxObjDU7HPxYjXeit4z3ONyuxexHgmF2pKEtMHhwN+RjadWCvjFiF5Jb00/dHU8lj3EGqQEihJwZajffyu6A6eLAl8Mug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OjG4AoWwuAMRUmAAaN3es7l0fJ7Pa2qkw1U/8hqRyA=;
 b=j8Jg5oz/lo2NAu6nxfV/lhAubB9mTUepcGrtdAyUE3uaCfsJG1txdabG+rI9JqWTZA4hbOxIDG1ZYO2++YsZRVhlLs463Go+OsJI1d1qHMacD32uTyC+ija2nTlRJsY+NJt1dACcL94UHF1kjz6SzcuicnMln7iKMsdgUoyqPGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9333.eurprd04.prod.outlook.com (2603:10a6:20b:4df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 09:13:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 09:13:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: wg@grandegger.com,
	mkl@pengutronix.de,
	conor+dt@kernel.org,
	davem@davemloft.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: can: fsl,flexcan: add i.MX95 compatible string
Date: Mon, 22 Jan 2024 17:17:38 +0800
Message-Id: <20240122091738.2078746-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS1PR04MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c34e138-fe73-456c-fd34-08dc1b2a6170
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M6iDr4Tk11rYGg0uRAL8C81CAYO5JdHFzB7a5Ljsp+ZHk3gg/CpBsK6a6zRrykLpVwc8NLvOJ3I1iikMp4/eNA2jcuH5KyOnSalXIiL5D77otjTquueeyxzXqmxQiQxBszPFRRqkH0lZJs1CiuZn9QZA+7A5GDWFhLJ25wuxmdcnYoGyjW3/t7HgZmaMrPRwBv+TLG1HrP8TKPa48JSCmBAHCmkXgdYaOCTsuJiwK1/ZifbH40w7VbO41sCjbD5n1ZQl2dye8zOLtakuzoVCwpglPmNs/nwVyrQmNo1x7pXeyE+ziLu4z5kXJWzcUBh9zmquDVlaqXBz2v1TDNVkZjYv/LwTkOz99xUWqgVQuV6RpgNWVNG21ZoCrbUHljXkvII/tCNu9JyGPcIGyyEKEbCxX3EbpJ0v0DBzyHJyS/LX7ktY94VhWFM0roVGPIqtsrelfBvkEL3M/F3yOseIl5twKHTFCTFx/vLkM8R14b5+PQoDcm3wdeCBRDiyzNSXIvQC2xRF4S5fwR+w3mkszynafXkLgWxRhm7waL9g39+5q+L1cWDaNsPu6cizE4iViaUk8XMzvWQD8oxr3GNCiiVnPDXPcfsGjjixr7ak8zKAnjpAfZjety8segSNm2oi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(1076003)(6512007)(6666004)(2616005)(26005)(6506007)(52116002)(7416002)(5660300002)(8676002)(4326008)(4744005)(8936002)(41300700001)(2906002)(478600001)(316002)(66476007)(66556008)(66946007)(6486002)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?65brI60ITT7+TSXQ91XZ3cXExBD693AiO42Z/QstFAKIQNOo0Fu8CRDjJTpQ?=
 =?us-ascii?Q?ogE3vjpfW7r3XNo/LNpI93ZI1sAGSYQrRuox2/zYeposcpOn8kWxiDrGi0Gr?=
 =?us-ascii?Q?xN2y61GEp86SByRBlqngcntS4tEaFTPTUg9A4bbW7Y6pcngrlJieCBv0bTv/?=
 =?us-ascii?Q?bc62hzXlit2NgInni8taPoD8mW6qHJtqWIP0BtIsCQlO+VXF6LaRIUb2HzYg?=
 =?us-ascii?Q?EKlXdSahRw7L2va3CFjKK0vvCf14I9geVVhaICvzbcRMLGtF7oF6kmbDpsZ6?=
 =?us-ascii?Q?q2YVn7+ItxvOOs6RH74GKthAbPGq3bBCQvxOfoSqiH+bYMmfHEOTkzipcycU?=
 =?us-ascii?Q?8JccUPYK7jvlvkZqt+hUaZhbJB5C8/lG5ZSl7UqkhecaILbD8BG84Gkt9bJx?=
 =?us-ascii?Q?lx4HiJcFTbcN+wxQz2IvzDFojdNwsrXmD67YPB/3DWQlBBTyNY2YDxIiJKpQ?=
 =?us-ascii?Q?EQNXa6cJzVUJiWbwvS1EY/PVPk9I06JoZhQvZa/BuXLGHScMt8ohtNVvv+V1?=
 =?us-ascii?Q?/of/snmxs5hXo2wmeNpnhw/sda79ksMd3JbnRVZ6yicjr1PtFLYJIXgTnl0D?=
 =?us-ascii?Q?9v+OJKPzGklqgQPg2+iooeKYEQ3IQhbTzjNXYYhYQp++54a32em0kHLhnPkX?=
 =?us-ascii?Q?u7pyV2FLtzLbIdHh7XZd4eBGnuCUJhiS9z1cNm0LSBAgUVnYAxIYZk4c5Oq3?=
 =?us-ascii?Q?TMZ2FQ77H2PlkH9HFE24wb9SacJcpclGFvjUxQWtC+KzQIHfKuF1WNQy/Z9j?=
 =?us-ascii?Q?udgMf0AWqs+4t9/0SKVvLMjhxua7No+64XApJn5UAYijDJaEsCd6T3ZOBoPs?=
 =?us-ascii?Q?V9VK55mtfLrQcna+TnSCUUOuYDdwEUKJgFb3x7v8QAQu1ghX2V13kwent5UX?=
 =?us-ascii?Q?urh9ylPRg6txm823ZKlcJDZhaf47PtYPQN6vE/VzvWcVOkZuCNcR3f7EkAWI?=
 =?us-ascii?Q?yuFf3nPi8gv7UABHR6vthW4XV25PiAkE4VaJStT30Dj5MKvjGNBkP5Qpg/G5?=
 =?us-ascii?Q?BZYefYUfYDMsXgaJg/MYau/+f20uC1Mph4HgcmczLL2N9u2Xlx5M+GWDlSvU?=
 =?us-ascii?Q?wb6XskD0JKry425T/7pyVAAnsqHTYspa9re3PHyhIUHqKzTrXBBimySCJ5Iy?=
 =?us-ascii?Q?7WoNSsxuxFswIISdGe4z06QinfnKD+MH+pyTK+mfMlhY0p1UNoMEqhMmhBXm?=
 =?us-ascii?Q?i3I04vllqhW35G6LCqD0xse1ePW9gg/+IQdFqDOGnbRk4aAO9ZBzBh0e3VyO?=
 =?us-ascii?Q?HYJl1RhYxEqcA0fkD5hQtDCrXLuLeCpbnzV+ssAbcxRce4GwO3aStSJrhblA?=
 =?us-ascii?Q?ZSA9yUc/yKZWQcj9i7Del/YxgAMpLKnGQuMql+cqUh41Sr5sb7kkCFOWUCE9?=
 =?us-ascii?Q?RXkwqTAsDGAbFOlw+lCi4qBOix8k0bisU11jULQYeQXwlkun2k0JeA+aaFx/?=
 =?us-ascii?Q?GPee2O76uRu2O7/fsnq2HJ5ldI+GRHjLlKXObUCajQSsfrfXOtyzFa7auM4c?=
 =?us-ascii?Q?PYJfZed0q0MvLZRryx4JQo/KS/Wli43g0HVyuTfiYpkfNbylyFpScVs0F7QD?=
 =?us-ascii?Q?Zzi+oq0HxwqSZoV/nzEY7xnndnT5Q1qeUnrKpJgU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c34e138-fe73-456c-fd34-08dc1b2a6170
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:13:22.0437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owGUhEHR4LUx2KwLF5ElPxdDBmxtab6E+iwjGuClgIZ5+deptjAyBZ18wGtcnxJtLpsbJa5G6tZnDwhSi3lf+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9333

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 flexcan which is compatible i.MX93 flexcan

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 4162469c3c08..f197d9b516bb 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -38,6 +38,9 @@ properties:
               - fsl,imx6ul-flexcan
               - fsl,imx6sx-flexcan
           - const: fsl,imx6q-flexcan
+      - items:
+          - const: fsl,imx95-flexcan
+          - const: fsl,imx93-flexcan
       - items:
           - enum:
               - fsl,ls1028ar1-flexcan
-- 
2.37.1


