Return-Path: <linux-kernel+bounces-109773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C0F885587
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C711C20749
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EB179DAB;
	Thu, 21 Mar 2024 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QAKRAPvc"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB477F04;
	Thu, 21 Mar 2024 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008922; cv=fail; b=hDphq/3j3YPTb0kz2zeJGmHIcwnUl19venY7UJWQPJ0GOLG209njzgO6xT5UoFG+ggpJdY4xU0vJ/8KnZiPXMC25czsPtkYdOrURsBFlFW11vOmKujfzdIF+UvqO6eHtNJaRkwR+Hxt0WGn/IHMPWgjO8l30iVSH8HDja0R0Xl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008922; c=relaxed/simple;
	bh=rGFPvr8r9dTrPBNEP6IuigFulbWkfsv6cDDw67HDwi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JA/TpkJ++BbLRBIo35U7yFdu3DYB7CmBmeGS6g/RYfybXnNuu0mxB454eCedvnKd9rNrKNB1Q1/5Oopz1ZR8tzCaLCLy0o2HFWHWy+rfJu/jbCfHWTAp/j5HQ0yuUMaCREj3f5rm9CPf8U6d1WkqB3y+vE91aj6Z5LCKiepBT/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QAKRAPvc; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSBesQ5UiRATwjC7I1SjBKhxJleECTVrNXlvni4HJkYNcNZC21SOeVw0w4HSwUV8ZJ/3DAEuG+QjFzNgp0uWUf+RPBT6R1MpS9oxeJNSwZsgXU4w+GfG63iF8j15Nj2vgMczc6O5uomji/UloLCYR81Y4TjG7rPmITF7UevzibiBjtvKFc4Pxwf9ygeAgeSc+pTYjLSknwDAwI3SB+bcYNsqeWCioD/lXrRKQcRKEWh0PHJSkzw7RFZUZRddpEPpiyvLbzrwYxh7wXlXTuxqAw2D0t2259zwYKjvClegP9Z7F7noU8yLeUjhks4o5HgLKZNSRN/AJ4iej03k3kWTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3aN3mn3/1byl4cCx2AzlLt7Mf6/QUZrln6qLM161qg=;
 b=dVsHqMKMqrlTBktpSzn2mM3Nisc/DuFHx6ITYeqXmOhbblFIgCXtuV4hwl+ZK38DFgPV93fnUJ5VH7GQtI0TFRKMI1bBxVyEpOpzXUJw47Vf7VTka3gbTIX1OYAdJUZ3oROhYztSUZk+i+IPw2Do2GsvduwH1g5KRfMDFXCUY6JR7z+KEfO6OBaTn8C0OlrkKt+EWzKx40+EK+SWwYbBNQ5sDT9Zt8qMmYaqCkgtu9Bf3xrWOgMP9HpG/6ewRZp4xIFPytTmaC7cavXvnyM96HJIp/jOznUPWJFmqZbHiNq3CivCXEZ7IA0ZSq7cx4lKZ8GRQIWJWqqACi7svVwqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3aN3mn3/1byl4cCx2AzlLt7Mf6/QUZrln6qLM161qg=;
 b=QAKRAPvccJEyqKZQhZSvliNGiEU9oul+3r5WcmWwaHcoQbkCRqw5FpCkmqg7hB+2BkRv0/kPK1h0Dh1R6qnQC78Cr2nIDO18KP/TcHGkfPorcyiYdk4H+6zhNUh8jTcXlT21Yvx8cZehZsx+c+9OvmcduxJg9mYXyNJnG62ZA9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB9191.eurprd04.prod.outlook.com (2603:10a6:20b:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 08:15:17 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.023; Thu, 21 Mar 2024
 08:15:17 +0000
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
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 11/11] usb: chipidea: ci_hdrc_imx: align usb wakeup clock name with dt-bindings
Date: Thu, 21 Mar 2024 16:14:39 +0800
Message-Id: <20240321081439.541799-11-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321081439.541799-1-xu.yang_2@nxp.com>
References: <20240321081439.541799-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:3:17::34) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b2b2c5-4670-4491-bb8b-08dc497f0ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AVOHk4c80K79x5Kmh/czX5jLUrE4uGxmBUySDG0rHZ5LUA/kaA3bylBWJyv1/4qtgrgjjaO8EgQ7u60TizlYai7AJVfDFYQ/3RukDwjGpIUwWISTJie5eFSFNQ3L0N70DMTAWsKHICU2QKqj08tG28jj96+zU7Prc4pHWxrTt2UD+44ptbrrgVDQggfepjAA9Y9WsAVLjV5eco5c50THluNr7w3+02PIh0sqW/3wumyrFMZw3KqzN8M53DYPIG91TpWElSeLqX8sNCsffDz5KH+v9IYNDm6ZjN+Wk7i2FV+XLUPlLmpKc2V8ya/B0uyS8Guzbm5EpUncQdwy12AebHh2VwM9jzuI2D2Qf+PRdAWR33VA00KSYgsNxf/Yx1coLurj5IX6hn7CiBU8H7Gb6/thCMdzMZCfo4aofYVB/HzXSJSqz8/voqoKUWtK5pKHNfCEVxyvWu2lZ2bIxDaUydHxTtGhHK/lrcfZRs6FqtRihgNAWR/thNrH3mnkXJGBGZ8+qLNJrrAKDdpfo3aTH7jqBS2Crfi0Gef014Go2uNiiMjhcI61k0Oo/e5IfspWqUKUqHujFCIP9CiIc0DUChkg/1WLKkgup7o41wsjcjUVy9Jt3lutrDN4V0QUP3fSGkg5AsUBefBBqI4RIxNpY27PWDNSOxYgMmYMdD0wbm1hXXVqZZaOqqMdqAkAjleSRudofGwrV9gsGI25VeOfVOD791tCH5C5un6/w+RNSwo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h1hwpql7VFXicOYsz1k0L7RfSAp+GuxUT2u4zy+WTORTolY3dC6GnAryyZ/g?=
 =?us-ascii?Q?JyX9kXSMkeSOEmcwvbJ2LErZFGEO2hAWQh3RVuY5n2Uod0VR0pAiDuPORy9E?=
 =?us-ascii?Q?Acj+FC8eTQSFmXtTNytPh13d1rT9q/ayNC507lpd8NiX0mph0fqgFiHZQTDl?=
 =?us-ascii?Q?5/pxotARtlQLCsl8m4kVnBANZgJufmPFcIFyDdKBk+1ICgP61rFUPgmPixMq?=
 =?us-ascii?Q?yhFjJ9YbcmSmlP1EBVGHCyMyQTNo84S+F2FuCgdywWc+xieONGLl8XuDnTGy?=
 =?us-ascii?Q?L5Bbg32BKnk22SJAspIMmyuQn3LP9NkW1ts2OQHaUDubF3g23narKa9QG5Jw?=
 =?us-ascii?Q?x8S37/zXUOfgvxjId2pj5QYzC1a/QeK6PBe825dtvcRd9WUrIGu53G6dVLde?=
 =?us-ascii?Q?WDilqI+ZtnQn965F4WXvI7cveo9zA6EHnzbFTq9XsRs38Ccx0pWxO8t2Olh3?=
 =?us-ascii?Q?5/McZbdYJWlxO94cI2vlTMp4T1lNJFfshm6szXXtOaVEFA8IHlLHNkPg1SaO?=
 =?us-ascii?Q?v2qNw9Pada4W5FnDMVPmLqfhIByISXL8aNF565eg/y4N6qjDl6BKIBxGtq6l?=
 =?us-ascii?Q?LLao41S1XaD26tTbjDzgNf2vOzKIb+byRA2HxU0tUwtsDmrQKakFg40lWUlS?=
 =?us-ascii?Q?FGkslh1Vku6dfHB964mFtDr4aoC/gviUnD6XBu7tawSF3+8obdUDMGyYksf6?=
 =?us-ascii?Q?660AFxzM50dvwB7PHzIpeLBg9cL5PdfgAwbYj4PDWP06+zP5ApMY4qgqTzg2?=
 =?us-ascii?Q?xhQjXaF9Fuf1iH4z+H6DtADPFLFk5sKPeDPHI6Bx2Y76kqOOSqD1YBEh2wxW?=
 =?us-ascii?Q?uZluoecSsXr8Da+uuZHL/Fx3s5A7wPuZ8CDB6P6kyjQC1PS/zCByq2txQLPH?=
 =?us-ascii?Q?Mh35midVCy7xgGiml+rvb3iq1A7hg+kPpuJHcvPPGxriYl/pOUpU4Z2zqxvE?=
 =?us-ascii?Q?aZQepQsmQZ+sjtD8VcKO1x/houDF2QfCtT/4sOhY53qHwCP8pFCjohm+Bcea?=
 =?us-ascii?Q?WJkqPkMIaoB4/4U3y9GVfVUZIGd/N3mJE1otuelOddWme94JWlFJzbUdFvv7?=
 =?us-ascii?Q?fD4968CGrFtd+MevULh616ZnlcqcwANrunPLTT/XA7nKDf84o5O4Mg0xk/O8?=
 =?us-ascii?Q?MAaS18gUORLvE0xT9awnOsLHR4AU2ivvxF86y5fP6v6kwj4iLslzgLmWuGUJ?=
 =?us-ascii?Q?EJ0BtsXuVzQcDPDb9il40HvFXlBLC2NevDnXWKrF5HoXL1cQynZotydrDJj0?=
 =?us-ascii?Q?ZOWk6qIqDMLM9bdb5Bq9s+O1gBVDpOYPcbNnk/aXtEjGiIpsxwv6aqwGZkWP?=
 =?us-ascii?Q?vyG8ZpR3dbtbMHyqyAAtAlpabo7Djy4JGO89Xgtm7I+C1zePb97VfGPjgReC?=
 =?us-ascii?Q?mHgwQPl743EOqRNoahdSrl4dArr0ARyBmdB0ZYRBKbUWXFDlOu8y32sIvFRU?=
 =?us-ascii?Q?EXMp6WthMcWNyXTKhQVg9kPwbfLMruohkftHHSAOHqA8ePkZ/DTUoY4fMn0c?=
 =?us-ascii?Q?5Kv7qOuxkls7y9fstQ+R73Nm2yVh2hufLlYIQWxK+92FOllpAwoJB7hI4zkE?=
 =?us-ascii?Q?rUfDsJWcR+ZpQXnBtxjXGSBT+Y98Hbo1c6ubfMpJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b2b2c5-4670-4491-bb8b-08dc497f0ade
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 08:15:17.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMK5FdPkPku/cLPXjl3KPopZqAFAhDQ1eGf8d/1XVBdMjMyYUeWxCC2HynQKLQVHcUBV0lMdtc1vo8nPo5TybQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191

The dt-bindings is going to use "usb_wakeup" as wakup clock name. This will
align the change with dt-bindings.

Acked-by: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v5:
 - new patch
Changes in v6:
 - add Acked-by tag
Changes in v7:
 - no changes
Changes in v8:
 - no changes
Changes in v9:
 - no changes
Changes in v10:
 - no changes
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


