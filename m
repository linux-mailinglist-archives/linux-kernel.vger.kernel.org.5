Return-Path: <linux-kernel+bounces-74174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1175D85D0B9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE3D28351A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022CF3CF44;
	Wed, 21 Feb 2024 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ixea7G9V"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD23C6A3;
	Wed, 21 Feb 2024 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498339; cv=fail; b=cnbMuMqRIMNcq7leKhIYLGh4Og5B9n9hHMhVHmUnnd5sPpxW0tJoVbKu3Wk9Yehekhmr1Ku+euRAC5vH/HtUJNp5gpvgLr7lr9h0rqGTvCTlsPODRCNJIUKoqSKNRSNb56Ysb6PnY/E+3JrYOcCBUc2fuIeAZA7RDxqCZ8lB88k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498339; c=relaxed/simple;
	bh=1rOvfG3CVvw0sQpSUWtVmBbFTH39Wh/LYtTjrBe3UyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F+vx6FapokLijO+Z/LnpFHu9jXJsYdij0N+dE57Tvaveai2Kjl83f66RYNnovMtZ9Im1sVEifDdY3O/uMDU9kYNwQTR6HgocPOUgNLXCLt+nN3H3qausPRxwcNv5QoxbtewyV6Upo265Rx2Ly/zoNySWaOA0fcwQMEs0N/cWCfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ixea7G9V; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+cLPdQ6xKGYE1065jtr1Md7uvwVXZyNPAut1v5tuMEiuOKZZpC2bXEsS+tBj/AqGzRUPARUrmbhPPVZq1lpnjuqtMVVwIzylbl45huh+3YsaTsqaqnmvbUQjU4Uivxumki2d2IJR5dwXCCSt2RuK2gWZH5tHuiVXFLn0+qu0QWc5BaZeOsNxshnXvUVHRsYVCt3thxInj8ArotbkC9k95+KmVYTMvISriTHHQTGMxBJhyK7Szz15pbWX/gK2xg7l0BU5icJiljjFIMAVJBIDh1y1zho4sM1Zy+xw/RrlzCHOZeqSHcBj8CI9YrybXMswg2dPVesDEOgwA33mZMrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxAZWu6W5ALc+lct55lahttCBBz52BPvq60V32g4JA4=;
 b=OgnqWbZQh2gYSef6dHOyWumHyayys1YwNfBTH2WYh4kXze7Vz6OHrjHAiOCWipx0CSOyvzgIOzHR+eAgY453Z80G36tEF0wcAGKBXMVFkdWs9K7ydEMmDxZGQpgjTS167pRi1WLb2Fld427Smai5HsCXo+z49dko9EjIh1ei8Gp0KAimRlvKAeCEdjLgTVZSHACAjGiu7Gd6th3Z9vnItaXtbc0mcqU36BMzZMQHtDuF7Y+UAWP9XQ3Tgok8+w6+s4dkp5BDWe+pSdlgcIJD1silUM0ALRwkSWT0JzQwkYofKjHDBYkQZ/kU+Y2exTV3/fGKrccwB8y20Sdpzn1qbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxAZWu6W5ALc+lct55lahttCBBz52BPvq60V32g4JA4=;
 b=Ixea7G9VccDnmAti13nPmC6KIKXYHE9hzDVjS68VABEX1QQL/2tOff3J1dZ6oUwiHNNhVSIiWBilWGq3O1jJK8T0wFu7mFFYu43FZbruQKv83S0rLZG2QO16LadrUJet7JhRZ1syVWh3VhxOhypMGCxpWO0VcPHXzdvcoqydibg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 06:52:14 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 06:52:14 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org,
	conor+dt@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	peter.chen@kernel.org,
	xu.yang_2@nxp.com,
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 9/9] usb: chipidea: ci_hdrc_imx: align usb wakeup clock name with dt-bindings
Date: Wed, 21 Feb 2024 22:58:46 +0800
Message-Id: <20240221145846.1611627-9-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221145846.1611627-1-xu.yang_2@nxp.com>
References: <20240221145846.1611627-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: cfceda00-74ba-4603-cdef-08dc32a9a29c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P5rGBSGF57maMcxnnVs1EC7WbBTXOGKJ7EIZE8PG/Fex4JcUXD49Qi/CcndkIZiueryz/pkWz5xpkjCg/8md2J+i0rgeGcgWgocy2C0wFFAcEqJp9l6T4XVnfJBUjLQcLui157fG+UhONp3hJM78urX/9ZftQwPS7EByaWTs1DSCqR7lcShLTrbLurTIsOSAE+p9SADOexDvc1ueArDrmTdEsHdDUOI0Ok478q9CxrnUDmsrb8sqVVUqdSfcw9ohKkfLnU+QLL21Ve5hvn51OiLvNfqYb28XjQY0SjACbVq7b1N30C50ayyOj6YveWEDGepejEQUkM/BC04hjY8XqEK0eYiIo/qEodtJaujFeCcyAnyatMB6ye5PyAEa1/o18DLdwOT5Ao4JE+tBkfwoT906ZSbJcBjD3RCTg83q6MfjU7jpWnIe8V+dhPQue1Sb6tn2Xhn4ZWtp3SzGXhl+Sg5vL9CiuOSRBJjjLZotAaoob4PuX6dgtJqUjrEEInrYamy3CiZIcX4Ig+lpuxZs+R/na+9HsZQMhGorVrULJrrkFmW70WbPazgC9LoJlEDEhOIH48IQ0fRkVyqFcqhOFlOwkUjDw2F9PwiVD/4e87YOydFQ2FUC56wZs8QF1IwC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nRjOThzWJVGGqnpCPF+/YvxK+m8bP5Uburfcn2EApzNvPVj161o8xBfC10Yu?=
 =?us-ascii?Q?YAw9zlBlugr4RJIoLGClVGVrqKGVMjx6Xv2+rmx1+Z5zCYpuTu0fSyvqLrop?=
 =?us-ascii?Q?YhC/BlItF2TytyssdRM/lrHqcmF0swkX86SzEOEEvGTCZDnxqlSYhvj8WPsM?=
 =?us-ascii?Q?sA8nJ+pDvb7HXmvOne3rc7M2DEpmY3VtWxi3MZNm3ujBfNgpAjnAP0/rlpzU?=
 =?us-ascii?Q?KT3s8sPEyXIZasGL1GFA460ZOhQn6RjGwuaWewxp4iw3BTgLbzqMLEdHOOlQ?=
 =?us-ascii?Q?XfucSTzrMpzumeAYJ+1MkqgRZ1PeWbjJGlRZDo0FtOpxee3wJqOygRC+rxUC?=
 =?us-ascii?Q?ndEt+4VJen2JzsHrhrylW0ZPXaCVz+uIQk+HiBAWORMXANyf2eYb4faereKO?=
 =?us-ascii?Q?qjfje03DV6DVRe5gCI7uIJHK6vejFhwAEaJuZmIjpfq9ZhrqiVJTMl0z2fCF?=
 =?us-ascii?Q?w6xqtgDa771kzVSQ+3+xaEyaZJgntLcpDxemHb509gVsG3f5Xr7jSbFuqZuX?=
 =?us-ascii?Q?JRLTEEns3jHlEIevcmMk8VbKuocz1tSNO+6VxHCnQf86bgZjC9XlsFu8haMj?=
 =?us-ascii?Q?K0wyqJKtyr3lKYaIMvPuVBo4CjokEedrnlKD3iV5g9c4TfZaPfWyHtB7q8VI?=
 =?us-ascii?Q?LhFiIPBvAg6mUwksY+5rAPGEcyX0RASR0lfRhKSbVHxFKtCroQey/cuXvhG0?=
 =?us-ascii?Q?dyXdcyq522ItbGyovcO9+1t1Ev4C4cRXiobrzrPOyPlnsv2jLEqLmugqMc/M?=
 =?us-ascii?Q?28bOceA8JKi9rSUPtdFEJ5N2HkQTw6a11CdyEHx8jhm+X1UKUS8AoGQ7KVWM?=
 =?us-ascii?Q?KqR8NYZEK7bEjr8ZT1gTl6fYWznaya9iMkQKzN9rb4K/UWRosKLhLpzp8g7z?=
 =?us-ascii?Q?hL2FS1cBVWiPO55WQMaAjdvBQcwRF3XCrQlu9z3s1+C3NtG/JcY36MhqwUKO?=
 =?us-ascii?Q?8CWI3xTY78pysMMO8QhQZeSsLtxXc7R7Zrcr81AZktn83NdQM0JJ4E97e+Cv?=
 =?us-ascii?Q?uH+2Sm5eRWfew7p/hVoCjxGkqkxh20S4/hmTCmvbgWkozgsle3KgWm7C3tef?=
 =?us-ascii?Q?Tk8qR9vvVpbcorx1vqHpsN0iXnnMjyvD3M3Du0eHHcPv72FwQcX2RtISPykY?=
 =?us-ascii?Q?Jkx9oLPmL1kdzY0PSsp91BLjoyuuOmztnxf6vZoqdwo7x+qF7RxfABecoSR9?=
 =?us-ascii?Q?7UY00Nn1gp4trXMykaGmG6/7155UwPy0WU2x8mzRFCFdcMBwyBeN5zXbdnCt?=
 =?us-ascii?Q?fe1JbK/mPxW+7KG1rixhUaBHQNe50bJAPTdZFnF1dyGgsCkKGdY9yHU2ZIvh?=
 =?us-ascii?Q?YmloMtfL9kHeTS1HFQWSEoPrA//QJlI7+Q+4Jsk6YDBMEeZYGfT7w3Vwy2s7?=
 =?us-ascii?Q?DIvktlF0gj+8+aYPHvHL3BDBj+Eq8dIbyfQSx1BoonJy5EQPuVCcFvhcrCTM?=
 =?us-ascii?Q?EXZeXlS7jvniwNIp4VLf0EcqVB2tljoREIhYsr7R6OsTXeO3nhrls0zZcFgh?=
 =?us-ascii?Q?EZA+YfW/ar6wFQ5AAKbv0dxvOs3iIt9+PaEARAJECSR8a0faTG+asdz3faHI?=
 =?us-ascii?Q?IXqDKY3AUhlUhzH67/f5baRxHouitCift6YXGwlJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfceda00-74ba-4603-cdef-08dc32a9a29c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 06:52:14.2028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dx9KCLhE30o0Tz07a61x61Lh5wKjG4a/257wXMkr4IVvoEW6VbOjCIl+ghUbBMcDM80TEN6yQPLwhb1bAGpeAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476

The dt-bindings is going to use "usb_wakeup" as wakup clock name. This will
align the change with dt-bindings.

Acked-by: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v5:
 - new patch
Changes in v6:
 - add Acked-by tag
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index ae9a6a17ec6e..a17b6d619305 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -212,7 +212,7 @@ static int imx_get_clks(struct device *dev)
 		/* Get wakeup clock. Not all of the platforms need to
 		 * handle this clock. So make it optional.
 		 */
-		data->clk_wakeup = devm_clk_get_optional(dev, "usb_wakeup_clk");
+		data->clk_wakeup = devm_clk_get_optional(dev, "usb_wakeup");
 		if (IS_ERR(data->clk_wakeup))
 			ret = dev_err_probe(dev, PTR_ERR(data->clk_wakeup),
 					"Failed to get wakeup clk\n");
-- 
2.34.1


