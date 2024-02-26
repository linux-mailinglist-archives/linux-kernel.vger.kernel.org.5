Return-Path: <linux-kernel+bounces-80362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 387CA86675C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E028E281817
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 00:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6983FC2;
	Mon, 26 Feb 2024 00:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="I0+9DS8g"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC8ED9;
	Mon, 26 Feb 2024 00:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708907336; cv=fail; b=BHeRMAdp8wOqsw0LxR/zqvS5zSA/lkuywze+mVJhbjXXiJIMT9OpZQsc8zp9KKlZTm7qFWCt8bnfpk9bGkoII0qeoV2ZGJmw4dRQ71mFy68XGDIyFTtL1pQTILwGco9opP2Vg+Ownkqfrpp174Fb+OWuabHIbanB3GIyCtVX4fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708907336; c=relaxed/simple;
	bh=kVLBfhQC5nk3GBJw6sb8GiBG6NDTnx2Syhi5Q8pWS/I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Txp1rwW1bNpWlof2iYBMC+kQCFxwhwguPp0+Rql3Lyhvi31WpzNdrl1vm1G383uIBFEvcSRzL9Hi3xNiJ63Z+Nkrk1hmf51YqHgdvBxWYJlUpitQeEy2TrcGVwdqkEyNTkl4QCvYOZ5aCRXiD1fXAr+IxP/hoVvgObPNV5w2tWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=I0+9DS8g; arc=fail smtp.client-ip=40.107.8.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuHUdJncO5EUe8QYLaDMPj+zHtKQ3LLRQ5ma/WYAv4m3fhI9+Wk+xEQ1yQbBif328SJDTMxbPfN4m+kT/V1+1a15oiZdbPSeWxMV3lwJCjBUUzNjpwQy+64D70vDVQmw4tn/8YBLJ+OqWjAyJ1mXEESnS/b8eIVlHiNGwoS2/ugkZKsc+I2Q9DIaHEwi3o3HYz9DD4Y4IUc3tBpso93UvBBfFAnhn0ZfXBO9YZiTN2Yf4KYv6NnQQTEwUhJoi8DoqRuzvGO+i/NubQVV3KBwLYL+FNHhGG6jtNelbnLzTtE8KQgup4Z14mnLy/5qHZz6XJyK1MG3+2YMmMKkJ5gKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lSIVSefzI4Ll1HhaaSr0w8grOd298QhYfjbJ6Ed4kI=;
 b=W08AdrhAIyjc/KUOoA2YEWqt39jcuQCH/fdLvvoS2uwBouAOv6MvZWB1BIYffRZeWRg8ayBPExxeRXNfECBMNicg+zJKsIpFjutAeIqsOYbFoErpWY5FaaRP/j9bt4MogiV7g14FBP9V0PKrkfGkJe6Aa0441SDXGYpi+Dui1RrBZdnDzR10rVzi/QKHzMpt+kxHnVQSayxWoQ5TdHQPf1xUVe+KCURoHb6t2gFcJTv16OEn7WURAa3DWiKFmGW1sf0dkE2+9VVgWhxXp0RwfEjdZG7k+D2ztH5o/fzCEy+bL+WN9vz2AKtT9Rbh/nsKpvXvxwlyH/+oRvFKEKpTuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lSIVSefzI4Ll1HhaaSr0w8grOd298QhYfjbJ6Ed4kI=;
 b=I0+9DS8g9d+xE1EWuRciBiZ/fBbTixbDOekBj2L908V6KWdAN/jVLcm892mj2lRykpqIym51Z93j4SlPPatNPwTdM6pOEGpkHxUJ6VuacVv9cUg+o9aQRDSxp0OhMi4SGawDXSZFPtMxOoaSvlP0hVowtkxOcojUk7xsj3l2nXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7891.eurprd04.prod.outlook.com (2603:10a6:20b:237::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 00:28:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 00:28:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH V2] thermal/drivers/qoriq: fix getting tmu range
Date: Mon, 26 Feb 2024 08:36:57 +0800
Message-Id: <20240226003657.3012880-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: eee1fefd-8e38-41b8-1cf1-08dc3661e76d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O6HcQV5TiUNQyaLntKKV+SAx+uC0tYFG49Lr+Zs1DlWKHCFFTV9Myuep4MExCvpTWi+Jcysff8cxj/7JTNrP0yvH7VbmUFpHw5ZOugq2Ui+7fxLEKr7i4LKgW2mYIiYkJPmaKLvJZ2jUaDCBV+AUza9EluU4vHR8mpsR+snvN59HJvQu1y7qln2yPT+tjCpIRa7ZXpdz8E/9NSs2UEzXtX/XT/cx8xCSyh9v8LI9KdvIpEAXL2X1bQ+Zbj/46eSvEQqLs1IwPKcXx6ON5yYLgXbuBKkho3JO1UceKPhDr0s9MwMTrMCnW98TedeD+HIFkOB1EFtbkwMq2jTFt50agEkq+tYNoRt2TqAnx4DU2XMWF4ohbhocjJijbvcBykRO0HALkNo1GpaxmOMW/M7TwIhB1HYs5GSM5qvnRcI56varYMslO4qrAsdq+boYzvl8kqEHYjLJrJNjhy1e+LaPyOg5g1NEu6Pu3adAhvi72vx4TugSRdFjjqxY1vSl2PQucIJRUE5wW2+6EvdAMxmWRffhi7awVPF3x2GDGNWvCSbxr/TgjQGPpT4/IU1lFialu2oV08xLATvN7PfHeCl17wSZ21xCbRz0WcfbjHLBVCEMTe66UTnsrpQQSWpngVC61yrYN/468jZkqYHOdSPrsNstUIxBU0okgOPdJJ7s1wP+ErHoOsztCYe2jbd5idhdk35oiKoWBq8KsCiCbXkm8A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aPrPbdHtgJXsqI+eD1oRcO7DzGCog+d1dQ8UZfvd89Lz9+sOAsIqKUumTtuO?=
 =?us-ascii?Q?1aBF5uVHoAvyXlg1XFBTRrUSb062jXmvv/UOWk4KkqNl0m/2pbRf9tVygzKC?=
 =?us-ascii?Q?Hc9SJlvKFBnism9EGHr8T74lS3HiQhfxhtKd1g8kQ0YRZhOTx+uyaY+ysyP3?=
 =?us-ascii?Q?BKXQKEEe0xbb7amAvEyuk1+6PRS7Ebktow0BDbDcB24RA4GVQhDujaJIG505?=
 =?us-ascii?Q?DFRxFu0J2C5Pt8JM5pu3BGp3g/iagpWVALmq7ueBii6aGYiUFQFFpu8Wp03S?=
 =?us-ascii?Q?hoM9ERnu54GYFfkdolHc5E6cfWYWuGCgTT4oMVMpsCFMegPPrlmWooIWFzjP?=
 =?us-ascii?Q?mU1lKN/+Zq6A/5VSSYhb+b5nKxOdoYbeVO4jxX69J3QpkCflVCrKCMzOAGA0?=
 =?us-ascii?Q?EbaMSMlldh98mouI34A8cz+aWD7bGpTaNWV5xANSmqHp2w8ze4QbgW0emMxh?=
 =?us-ascii?Q?cbc9sFpozbwB6nZcLGquOEqA/F3x9MkOkmEz/IdJiZg0YAR/rdoygUHjRF9h?=
 =?us-ascii?Q?6z19gFDpn5VxS6eicBynDjdgolpnLT1d3q4ZCZ59p/xiOhzb1on5+Lh2WFxA?=
 =?us-ascii?Q?Aq1NC5/w2LR8C4KqwQvWhQiHA17LzkfU+2iEPGB8V8HLLd9NOzJjGk3BBzI4?=
 =?us-ascii?Q?zSpZyGViwUSNrDkJdS7h/MVEcti7UEL6B38irMna6DpiZAYr9c8thiGxQ5d0?=
 =?us-ascii?Q?IZ51PW8b6y7NT1EZFSS4eD7WF8otZwPe43tmDT4TURTO46jvaL6VXmA5vbqD?=
 =?us-ascii?Q?mAvYfoGgQpnGfYAgUj/pYaMW6RQb73J/Aw33cIrfWRW+QkLxmlvbrwm4/q6D?=
 =?us-ascii?Q?UqsmW3icIoK4CDUFeIG9jPpLcTBKU3sOADlRWezEJu7XocZ3MnNfHqsZV0KF?=
 =?us-ascii?Q?2y8r1OoQGLMME9JsIqYDXMt6whJfgrkVejlK8I/Gfn8oqFAccQJzntXLQHOx?=
 =?us-ascii?Q?SVWekujrHuU/RxtmUvWtcnNQtHCgnKdeJlakUQBweIWj8kvPkTaEnhJr8R8n?=
 =?us-ascii?Q?tmqsRnQRm1RAx4+urW0HQDb9gTT4+GGOOrv1kUmb5xGoEw18+E08Lus2KPK8?=
 =?us-ascii?Q?qafbirgj1y9tVOV0wVTvh6afAAlpSeSvzAP9PiOHH/XUqcjwXb3o6g0QOqAY?=
 =?us-ascii?Q?inGQjreUwZ3S6NQapA03dKFE2ZgWdQxXJm6woEEdDliXohezlBhErgNuWwp8?=
 =?us-ascii?Q?9rB6fKoksYmSIL/l6qC5lYtsyvMXNMowQQT63BesU49C7/rPdyufIhAz7IcB?=
 =?us-ascii?Q?WAz71LKAY3+DabJjyrdmXb7Qo/KXutEJrz5kMVaowqRHEg9x7K5wbBwjBJ3E?=
 =?us-ascii?Q?iIqSGWavCC7R3bVHf6uSmSgO05KLGvlFDXO7uG5mkw60wz5DGlpc2Knu8XCz?=
 =?us-ascii?Q?khnbIVQmZUZuEasyM7UZTfhk3gTf48XNjnQ7bpBzWsTh8HHk+29gWhTjL4CP?=
 =?us-ascii?Q?5lzLeMDlghBLYOeqI6GLrt9KbY5+tzlUZcICVQ3g1heNpaNOjoIV7gxHNT4c?=
 =?us-ascii?Q?JpyJcTBeu0Ps+3Y7XO4ykvDVjxlxRnLRT71i+e23+WMHVMxFGh5Nc1/sDmfm?=
 =?us-ascii?Q?lzl3SqVIg76ko0t9JcLg6g/6Uxn4xdbXZW2KbfJq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee1fefd-8e38-41b8-1cf1-08dc3661e76d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 00:28:50.7229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Tpq3F07LHF7AeYiPnVgPo45H0I4FVcFJu6VasENgdOk2byP767mupyuDHMoPIU8inj84/KbTIG/zYo5QhDCOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7891

From: Peng Fan <peng.fan@nxp.com>

TMU Version 1 has 4 TTRCRs, while TMU Version >=2 has 16 TTRCRs.
So limit the len to 4 will report "invalid range data" for i.MX93.

This patch drop the local array with allocated ttrcr array and
able to support larger tmu ranges.

Fixes: f12d60c81fce ("thermal/drivers/qoriq: Support version 2.1")
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Rebased to linux-next
 Add T-b
 Link to v1: https://lore.kernel.org/all/20231020081337.3141488-1-peng.fan@oss.nxp.com/

 drivers/thermal/qoriq_thermal.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 8552d2ca87ad..0cc883818878 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -62,6 +62,9 @@
 #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
 					   * Control Register
 					   */
+#define NUM_TTRCR_V1	4
+#define NUM_TTRCR_MAX	16
+
 #define REGS_IPBRR(n)		(0xbf8 + 4 * (n)) /* IP Block Revision
 						   * Register n
 						   */
@@ -79,6 +82,7 @@ struct qoriq_sensor {
 
 struct qoriq_tmu_data {
 	int ver;
+	u32 ttrcr[NUM_TTRCR_MAX];
 	struct regmap *regmap;
 	struct clk *clk;
 	struct qoriq_sensor	sensor[SITES_MAX];
@@ -255,17 +259,17 @@ static int qoriq_tmu_calibration(struct device *dev,
 				 struct qoriq_tmu_data *data)
 {
 	int i, val, len;
-	u32 range[4];
 	const u32 *calibration;
 	struct device_node *np = dev->of_node;
 
 	len = of_property_count_u32_elems(np, "fsl,tmu-range");
-	if (len < 0 || len > 4) {
+	if (len < 0 || (data->ver == TMU_VER1 && len > NUM_TTRCR_V1) ||
+	    (data->ver > TMU_VER1 && len > NUM_TTRCR_MAX)) {
 		dev_err(dev, "invalid range data.\n");
 		return len;
 	}
 
-	val = of_property_read_u32_array(np, "fsl,tmu-range", range, len);
+	val = of_property_read_u32_array(np, "fsl,tmu-range", data->ttrcr, len);
 	if (val != 0) {
 		dev_err(dev, "failed to read range data.\n");
 		return val;
@@ -273,7 +277,7 @@ static int qoriq_tmu_calibration(struct device *dev,
 
 	/* Init temperature range registers */
 	for (i = 0; i < len; i++)
-		regmap_write(data->regmap, REGS_TTRnCR(i), range[i]);
+		regmap_write(data->regmap, REGS_TTRnCR(i), data->ttrcr[i]);
 
 	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
 	if (calibration == NULL || len % 8) {
-- 
2.37.1


