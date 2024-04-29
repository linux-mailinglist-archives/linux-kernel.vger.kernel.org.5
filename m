Return-Path: <linux-kernel+bounces-161809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FED8B5181
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776A11C20321
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD2E17BBE;
	Mon, 29 Apr 2024 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UQCBaPJE"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E6C125AE;
	Mon, 29 Apr 2024 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372310; cv=fail; b=GEm8SQPzWyV9zj09NGHPxgAljmHhMQ+PtYhrIpRfU1lbtFLiK7H1f0KJRYBradSoJIMDXnT7jyYDvD47h3fvdeqwQArAVo3jVcCOag0w1wz3JrlId23uHC+61Ee+hLf4bHpQbZRg16axoEsk/+Jck3liZAZw/JpdlkCJEYxWDmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372310; c=relaxed/simple;
	bh=ILCWX4RI5bLypu+q7jOillTXLN9PM6fM5Bjf9Hqihzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rKgGLpu9iO+uWHFhNKuz3zWFqdSEC4zRQHa06PiwIpoSkaQpvM3GKzKl9fN5pQ3I+ttO5VJ83lNyESE86xwoqN3Y6jSmw/gIu7TWxuFgM0SEnj1JzGTVorRgqlecyIxIINASNWEK2OpXb+L1J43yXGYr31ReLViD5Wwh33BpdaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UQCBaPJE; arc=fail smtp.client-ip=40.107.7.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXZzTvLMZSVmMLeVzURW+o+64NGwDpwu7DuuFxnC/2RiBQmOwfDhy6uEd2ybTj4Ff2iAzJ53NpMg6c7EsTt5Qw9ecVngICyXUvanPs6pDrBCQ7fVDFRZkkXDKcZNr7/xjkbeDpDyRCwt/wLog/yCG+e5PRTGOz2g68drMhG1iN8nu1aBTcfPm5B+JiK8tBI9CNUN/m1+22dhbnv/x5kKG0c1EgRXGBEZUP5GRcKbP7GYi/mbrZRJp7qrdAngIz34BWAis/kNOYJOpE+W7mnZW7vRMfA9j3MhstbE/BlMYdCfIAOiDHbQxo62W0UY4G6xVC9NLjCbNYPrvDNSqMyqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWHZk3m8zovg7GLehv8w9ehZe3UBbtoFImeKn+T3wcE=;
 b=JBQd3LbQZNiPtOktA7hqEGTRLKG7+HJ1AbhCkbJjCo0bUGyBHfJ5j/EWU4n36W5qu1LvWgSNtVLMsITnWQUm7Oc34oYoZhMbMZhp8zWDIrBV819YKtWJ9SdJ3sNSzdgfx3IFoO6jD4Qrq/pquyAiRc9f7vtaOMdIstcGgyIXuPRjjZHDlNXbY/Fv981z6E/R8TSkWN6pfKQj/MbhP8PHSz3nETbxCFe5+ljXgaV4X8rZx3nCnn7O5mBDOvOjMk7dpQM1tJ5F/ddlaCzqyGVtc9lt4/GUUjg1R63pJzsnv/w549k7nI6/SrMBfqkQc9YBglD6dKbAw5R910vXzaxF/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWHZk3m8zovg7GLehv8w9ehZe3UBbtoFImeKn+T3wcE=;
 b=UQCBaPJEvG/JHVyNZqZWRDnYtaG5VVsqtgaS8Jpyf/EdPf7HOIV4WygK12BEyHEddSMnlIdz3z6G3ElkF7Y/uxPjA9fzbUrEcSVgMDFgMRrcVvyeZuNK/jizF8+OV7LJYoFKgfo5zmVh079sSrjxAz7yIpvuei0CVFxzH61olMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB8PR04MB6859.eurprd04.prod.outlook.com (2603:10a6:10:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 06:31:46 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 06:31:46 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: gaurav.jain@nxp.com,
	horia.geanta@nxp.com,
	V.Sethi@nxp.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	iuliana.prodan@nxp.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v4 2/2] drivers: crypto: caam: i.MX8ULP donot have CAAM page0 access
Date: Mon, 29 Apr 2024 11:58:55 +0530
Message-Id: <20240429062855.923595-6-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429062855.923595-1-pankaj.gupta@nxp.com>
References: <20240429062855.923595-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB8PR04MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: f945166f-1112-4f6a-feb4-08dc68160aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bnv8AstIPHCz76BLa+kuRaxebVkdGJOAuy8gQZOkwslyE36WcUgdqXgG2CL6?=
 =?us-ascii?Q?94weaRkPMhSeU8jAA7TOFaoYlVgiePaT0YUaMB1i3y6f1Cx0z7txPAXwBCcp?=
 =?us-ascii?Q?r6AoW6KgwnfgvOMeNvlf7gANTbFDncmbPa5MyPtJTDC9pQpzp15irNaK6Gmf?=
 =?us-ascii?Q?7Wny3W1MdqBZjQ5w+lqc1IC9T0WRQs7aMF5jG3fxG8icnu6y4IJrOmeNIM7o?=
 =?us-ascii?Q?gYJ2MrFtpsqwQrDnlKiCTeNQZPT1VmgophAvRo7RKSHw47vVg85koeBTsty5?=
 =?us-ascii?Q?+EPq+qVAhqacpQmbHzpex4Fb/vKVWQ5eA0hvOb+dXi+vaNj489pH53XB+MMj?=
 =?us-ascii?Q?8twkys11+W8670u1wvy+5ebcPBtMxOZZrMlx/7jflh5yTwbi+P+qQDUTbVxz?=
 =?us-ascii?Q?vXR/A3FZ4YPRx4OAafwUKT2jOrTN8TRDpQozDis7LH0C9cl1TbZ+OPUvKpC6?=
 =?us-ascii?Q?bT9CcietUB+9gSyonxse5QwqLPgPuZEdpYLfLMOGVYfQ13aucL0YiIEPxAdA?=
 =?us-ascii?Q?we2GxhlkxcUPEiH0tJraoCtnEvmI1T4CiQKMKZ7AuGZ5bGN53jiwIollo7S5?=
 =?us-ascii?Q?xrHxJN2ywVuWmP+K5uC6POyH+RmahK7QPH7lqucnWgdbFwjdD8vXx3H+T7zr?=
 =?us-ascii?Q?wHyXv+oVGSYdbnMdcyixgkG4dygf1jiOHKxcmUcpaEtVzxwo1rNnym33XHJ3?=
 =?us-ascii?Q?lxFxJk+RgAuBqskCJ26a+xyHiOp8gy0qrDZStRpbgnRgibbLbB1tR2AUqtqy?=
 =?us-ascii?Q?GcR6x7QoEpQKKh9reezf+CGltYTJmuhcDgFMgi7AcR6FRHgtXquwDtSqHXLC?=
 =?us-ascii?Q?XCWxGKPobxZE8YUV+FrOJb1DzBJivf1ai5XPadhdLlVBM5ckrU7wnTn+FQYY?=
 =?us-ascii?Q?J1RT5wiDXyETdAr4i6QLxs9VeM4qG3fEtEMkcFbifW50gYkuqH7uAEKMjzTe?=
 =?us-ascii?Q?uL/G2YzeDwJPKbDtAlUAu2gWb3Da1MwUjNgiWsOZANR+zWZBUJtjMSyhZcuZ?=
 =?us-ascii?Q?S9OcrejWosC8xqO9QooAvq0Pik2/NK3QEHTN3wRJ8I7NIJlZqqouWfmxeEM0?=
 =?us-ascii?Q?MpLZOZopJXrwldM6jGmJsyodCO8dn2yhKaTw6eGTKiz5q8DUZH6pr+CUJtjl?=
 =?us-ascii?Q?eimKsOPeF8vsUCXm/u+2qutekdqF3K5ALE6/h1cYLk1kSI0O+JPmoFr5X8dE?=
 =?us-ascii?Q?XBPCoeEUphgCShCADaPzQzm+P635jtsx2e4PSi3jEzUAEwbDrfLt925Af6Qn?=
 =?us-ascii?Q?Sa0TqzXIH6wVR88IsWgMYP2e3NYg5NHKVLlsQVP6a3Nq6YG+JnP8bxci7Ymh?=
 =?us-ascii?Q?z06SMtmVfhzpmECNImiwYU4Dy2yqwTcGl+wloD4J6iI0Hw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rBB8W4eDQDSnXaeUc43a6QWUlBOh7LTTefYVkzp3vgeCC6PIoTMTx/Fltq4/?=
 =?us-ascii?Q?stYQFrzYmaoaknCMM7kNxHoFFzGwy4zA0wFWVOi2We18NXepXQ6rjj0XJK37?=
 =?us-ascii?Q?2gDZvOzpuA9uyZyPjSAPH6POQWLW9ujHrXzgurFu2W9+naaPV/IRjlQBwbf+?=
 =?us-ascii?Q?zCpxXQj3/UP35ePPrShi6zOvIFw279/yir9odWMbokoI+10I9x27SQC8BZi4?=
 =?us-ascii?Q?A1BNvpbJf6CHNqz/GCwoSPQ7NZpyc/p7YWXCDBmRDfaZ6ck3zXkptvYdWwuu?=
 =?us-ascii?Q?C8KkonoiXskhb1MI2TrUN9YswZfWUpmizNEkyf9wuTHCBJYtsAgYRKnjuTmR?=
 =?us-ascii?Q?BjbnG8B/TcHECc5WAY39yM4b/8+wp73HEEfkXN1YrBclymZ1/LiqRYVdrlX9?=
 =?us-ascii?Q?PQe2vtxTK7/UL+6MOQolbh4+HyzyE1eauGUWYg7qvoQveHJxgtqRBnO3VNzj?=
 =?us-ascii?Q?qcMjjuh8NTH1bezTDxcHZC80oINTaIaiyZmBLcF0euNGo70QQsn8/jZNjX6z?=
 =?us-ascii?Q?nyxcXX6AmhN+h2NuMQMJzrw0owQyKW7FHRuRNg9pro8QM8BjzrbSK0D9RjfJ?=
 =?us-ascii?Q?MfUtDa5nm5jBh5d1aPyqgX8Y8V4RKRKrvq71VZx8IBAM/50CazGDYEXCi2ne?=
 =?us-ascii?Q?JSl9IGpDIXbQN45Q5x1R/JeLMkzrSelrVbsyopUaJGR7ywzcKT64sEAbXI6W?=
 =?us-ascii?Q?K3YJWuykywoV+lXK8ufvDhvCa87CsrTS+lxC3zPMIGeWhrZejN4cxl98EXUe?=
 =?us-ascii?Q?BwDMel07d9JsJBbfJqoQhAiouesD5FzEtwDjSy3UTzr7g7IMXbWB+qUnp68K?=
 =?us-ascii?Q?L8DC6gMW9y+taNgLsfB3NWCCUIL7OK5ahWT9zoOW0Uzc3BuWu/CIB1m/Fhxx?=
 =?us-ascii?Q?qBoJxCwavIkdiFJ6m69AHxwP8uzh7ySz14FoEq46ExD8LyRSSrRweNS6UjvG?=
 =?us-ascii?Q?76uao0rEiCkm3WRxAfpbb2quwCSGvc47h6qRE74fgEVTZZjZ8K2gGgCGvAhe?=
 =?us-ascii?Q?RwTnppyHsmE3mdrdITGKzKXlHNylrgZQ11QYeISCbNW/AyoJRD3jV257X6Kd?=
 =?us-ascii?Q?TGIykF5zEc/B9gT8g1IeuA89v2nkonf33L76dsO0uZKQeuvlmFrJCeDYBAgO?=
 =?us-ascii?Q?0F9MBMNndCqe3sCXDS1I9/Or/c/IYmTOZ5aWEyn9XSPpMdh7jC8NmYUq+Wsk?=
 =?us-ascii?Q?MsDnWreOlWJuP+OJfWs0xt2BBeXB/J5eXDsTApBVF7+36pR0givT9r+rak9/?=
 =?us-ascii?Q?TNQmmpMqmE7OE210toQEpftVgECxM6bucKna3HF8o+49HJO9J6gZKLb8wZcM?=
 =?us-ascii?Q?xiC5JqzeYue+WjJaXdIVZc4DX7f+8jG1hLkejbN1FcEJkULOeg6kjJydbxcL?=
 =?us-ascii?Q?PQba5V5s1F0SMkFt4h1Y4OyBdpKteCaVEhPHvkXyKaqLgTVfolnk/rVvb8Hu?=
 =?us-ascii?Q?ki1pmQs9dR1MCGV49WUL+f2xPZKvxc1eV+03hYtyP5NYypTi5pbN1IdoSsCM?=
 =?us-ascii?Q?oCFxwjCYCNfI4K0hRtiJeCNnCk4M5lfEusWY9rdUL35776xtUi99DW+I4c7q?=
 =?us-ascii?Q?BIvSUoYuMc3f/LXv7gqwlqiNVfwoYjeVN/u4PQA+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f945166f-1112-4f6a-feb4-08dc68160aca
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:31:46.1326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNEfKaRLWhJWSKD84clbE9YIQ71ksUHqgclGzIGX3OvIbSNWGh/KXarcFmv33Ho9lb8s+MYPld35l6gdqCdL0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6859

iMX8ULP have a secure-enclave hardware IP called EdgeLock Enclave(ELE),
that control access to caam controller's register page, i.e., page0.

At all, if the ELE release access to CAAM controller's register page,
it will release to secure-world only.

Clocks are turned on automatically for iMX8ULP. There exists the caam
clock gating bit, but it is not advised to gate the clock at linux, as
optee-os or any other entity might be using it.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
---
 drivers/crypto/caam/ctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 02363c467cf3..bd418dea586d 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -563,11 +563,14 @@ static const struct caam_imx_data caam_vf610_data = {
 	.num_clks = ARRAY_SIZE(caam_vf610_clks),
 };
 
+static const struct caam_imx_data caam_imx8ulp_data;
+
 static const struct soc_device_attribute caam_imx_soc_table[] = {
 	{ .soc_id = "i.MX6UL", .data = &caam_imx6ul_data },
 	{ .soc_id = "i.MX6*",  .data = &caam_imx6_data },
 	{ .soc_id = "i.MX7*",  .data = &caam_imx7_data },
 	{ .soc_id = "i.MX8M*", .data = &caam_imx7_data },
+	{ .soc_id = "i.MX8ULP", .data = &caam_imx8ulp_data },
 	{ .soc_id = "VF*",     .data = &caam_vf610_data },
 	{ .family = "Freescale i.MX" },
 	{ /* sentinel */ }
-- 
2.34.1


