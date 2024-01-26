Return-Path: <linux-kernel+bounces-39687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 754DE83D4FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF86A1F29E05
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF38223751;
	Fri, 26 Jan 2024 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Wpj1Td0m"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E5622F0E;
	Fri, 26 Jan 2024 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706252720; cv=fail; b=ogHQVJZF5KYm4RfHkegTY7pxE07dGM5+Z7wqqllPiZoJRgUPd3dxpMY1Tdydm+EklG/1tSIGRRTBDvnJosZzYqNaYV/9LQemDPApr3uo1Rj+4p41PP4RQ1qWS6Y4kPRaeizX+xCiqUD7HytJg33b916xsjJ9gTt10kgKNZjTYPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706252720; c=relaxed/simple;
	bh=aBLG5QljCVCTEwxxYjv47sVcETnZC/aCIiHAM0aoreM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WPkkhUaDm/R8Yq2Ohi0O/tf1UMmH8OpKWDkVuGxDgdTRO5Z+gnt9ql0nLOGJ+JTeqTAeDLdN0VAWVC7fEuA9tnrgECvIYrfQFtN4RXUtrorTw08UPxOaAPRPMoXcbatJb5ka6r6To3KIQ7Kn3ufLyVygeAHS52FG6jE6MYnmK2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Wpj1Td0m; arc=fail smtp.client-ip=40.107.8.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEIJKc5wY6E4SRgz/cB7qLbMxmCDHUtGLBoNdLbbGiJC+WP4suRV4S0O7lqzpEh5BwcI2jDWZ6gd0qcVZ5U6ZPJJQbQ0l1x2mkd/7zhLOwRIX7T32XlVI75Bh55CEaznx0w2qzB8+PG7u/wGv6ybSbIQC0X83DttaIQ5Xe1b2yKV0IJO2wEq+ELIj5KXlEMLqd3Ewis5ETP9cpd+/m0ogD6SmIb9uzSewe0bfnjInAj30DMaNQmZec4o+XxLp9wZsis0B3SNM5Ap+cmBJycP02oFynMWotbsOHmzNQ27NFBOOs0LYYgolpY1qiVgvvSn4rRspzue/7mC17qCswRTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1lUtjwppp5r6I2j8GSA70ZjQecm5QrSH07ZZ+SCFs0=;
 b=KU21YPkdVIaFRuaw5peeMLWs0q33erqA0BfpqyQUMtm1AMgvIcGl8BW0vPwJXaUZnqNBJckedYZFRzrft7U6ugKDtY9NKULyRZZ/p6+/8C+B5VCPeyh7Hf2DgdC9nANPczKJJObGlGp+bQgrFXVqa4mDVx1PyzigzQgNC8Lu5XVj6iRyxIsJPIQS0s3XNv+Kqpjw/H1eJr1MeA0G2+XGWYna+DPeHHMwlfONuzlQoqsEZsqgX75KzNwkFMg1dtskC6UW3wYqih+RT4VcpKV2fDQOC2namgR1vd4M5FyFa19QTcznWmpcQVDMMk8KpPjQuQJgwULVMfCif4dXSZz1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1lUtjwppp5r6I2j8GSA70ZjQecm5QrSH07ZZ+SCFs0=;
 b=Wpj1Td0ma9NHtMDG40kIpY0GhjSbj5eXS/Ob/L7165PkNJQwkdn4/W4c2RW7ioV5LQSNAHnOuskmxqx2gJNd4xcKX5reTQ34e2ZPqcD6jcgbP0iBZs+SQNgfRssEu0dys6Sgw2iJoYkbP//aRzcgSllMdWyzdNmWANPTh3xz76g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB9825.eurprd04.prod.outlook.com (2603:10a6:20b:672::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 07:05:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 07:05:14 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 26 Jan 2024 15:09:20 +0800
Subject: [PATCH v3 3/3] clocksource/drivers/imx-sysctr: support i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-imx-sysctr-v3-3-33fe801d5f31@nxp.com>
References: <20240126-imx-sysctr-v3-0-33fe801d5f31@nxp.com>
In-Reply-To: <20240126-imx-sysctr-v3-0-33fe801d5f31@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bai Ping <ping.bai@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706252968; l=3432;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=o5T5BQKnKVPTSdGEy9mYdRRrgmMK7+tO3UEptrQOgLk=;
 b=J8pLB3fRXEAMmslF475aaHFSGSuGT4kGBFg2uSkYRcPYP4Nb661vtnNi6jOPgqGJQSF5HJICa
 DRBk9Wb14K1Aq4g2MMy2sCTrRSdqdCtwzth//2VW8eQZc9cjTakl0C4
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS5PR04MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e8f4c4-6ffa-4ccf-44df-08dc1e3d250e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JKulW+EyU31yROhdubTjkcfnsa9ybURBcDhAQuTfhcP5q2XRDHy4S27LS4yYq+3AdmWe54Dfa5/+DmRGMmbKWatRxHyzS03/ONMp/Gnt8loIeQCNKhJX0jl0fRrguXG9DI30yPisgFpGMMpaqjw1WEl3ZCftmNdfZscMxUkqh7/0ftjEBlhcc1a24aHM/U86m+A4eES3WrDgKo62Rj7lelCiWLjTKDLoEMVhzcYLC+NgVx7z6GHUYhjRyrinHwZQQhN8DzIlFtFSzIWmgiVjMmhhsTU77PD4oTlADtzzw19BNmtCVxAa4iFjEj97GEu4seQIxbmEk8vk50bk4rWPwhXO7eN7dA7YLowQjuao+Vntamuig8K2gwNLeQIn9ZCKKegE1vFMyzEriU+cgenhwNzADm5Kq9QcT3EBGL0EKga2/c9gXR7coLb1B7S3JceD8PfJeTHGEB1SR4Tqm5SbWeL3JQPX9CBA0LRC9FpeVOUHi6nHpvCCktGo+xVVc+9JJik++l0Dq5IvecwkATnMTarIMzomqY1DgT0/mhCAgyvG5B94UMx88i2hI9glkG1Xz0yjjZFW9ts9kpF0nC5hssoNpCh6JiOLjUrieTOfYPZ7USYGXkcpjcS3AbT4KFoIp6N+aAMB2RvpsGA2NMGLRQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(921011)(110136005)(36756003)(86362001)(41300700001)(38350700005)(38100700002)(26005)(9686003)(6512007)(6486002)(52116002)(6506007)(2906002)(478600001)(66946007)(316002)(6666004)(66476007)(66556008)(5660300002)(8676002)(4326008)(7416002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXhibkVYRS9mRjlWL2Vmdi9CRkdzdmk4RTdDU2xyYmJaMm9nK293cUJNSVgy?=
 =?utf-8?B?TjNySnJjZDZzc3kwMXcxK2NwVDFVc015a0wxWmsyRDJacGNORDRDUTd3RFln?=
 =?utf-8?B?cGd2Z0psbWFIQ2llbzdJaU9XV3Q3eWpGZmV1SmtCRDl5VzRqRmFhRXZtRHl0?=
 =?utf-8?B?WXVnSWhTVmNBWTJUdW5yeVE4cnN5cW9lcWc1YnhVSzhQSXVrek5BK2podnh3?=
 =?utf-8?B?cm44THg0UUhjR2pQWVFqWENFelJTa0F0MU8vTDAyc1dtVzBWeVNCMUxqaW1a?=
 =?utf-8?B?UDJ0OWpQYWVDL1QzaWZMUFoway9EZktnVVB1RkxNTUxNc0M2dkpVSW9yNCs0?=
 =?utf-8?B?RmpmVk1Ud05RY0dHb1lpbkdEdzRLV09wS094ajgxNmhJd0lnVGFNUVhvWHpl?=
 =?utf-8?B?emZ1S3ZRVTFxZ0pFYnh3aUJ1N3FXYXQ5ZzVnMVlyRVc4ZEFJSzk4dE9hZXUr?=
 =?utf-8?B?RzZtbFlWdkpvK0ZkU1NqWUd6eHBoVmx1S255RW1UUEVvZGdDdWhYL2JtdWw4?=
 =?utf-8?B?SVlZeXMwWDlvL2xvai85c1NlMkE0WU1MTXRtaFFCdWVmT0IvZjA5ZkhXRlRB?=
 =?utf-8?B?R09sUHFPNmxHVExYMG9tYlZaMEV1VEVaamFMQ1lPa2FSYW56RERPbXdmMWl1?=
 =?utf-8?B?WGNSdEk0OTBVaW9QZDNFMzREWnpSQ2preFp1bFNRWm1CeDhvM1VCUzVSSGFT?=
 =?utf-8?B?WXR3R3NtYWpiS3oyYU80RDV2SFZoOUE4Smsxcng4YWJmc3hReFBNeCtPVExs?=
 =?utf-8?B?SEdESVdJUW9hRWtKMHJiRUNHZDhFZ0xtRWtVT01QazFaWUNHdE5LL3A1cW9x?=
 =?utf-8?B?SW11TzJGaE82d3RXbTlseGlReFEvbk9xOStyUXhNR2hrK3JDcWJFNUhLKzUw?=
 =?utf-8?B?a2hGb3FIb084OWZxZnR1eTB1b25OdVhNUHhnQ0tEL0pKU3lsYXZPUElJQ3p3?=
 =?utf-8?B?Q3h2cDJxQ2lOWkdwaVl1cGNlN0hwZ1gyMzh0ekJqRHMzbi92SkJ2L1dRVUtU?=
 =?utf-8?B?N3pLUUU0Ym9rT1lLdW9EbG5TRnFWQ3pNTnFMMFB0MVQ2WHUrbk5LK1ZTYTYv?=
 =?utf-8?B?Nmxyd0V5a2paQ2RJcTNZZ1Z6S2dzOE1laDlWVHA2b2dWM3N3Z0Zia2s3TEha?=
 =?utf-8?B?NUxDQzlRWWkxQTN0SDdjUzVNQmVwQmlSUFlFVUEwWDdHRGJLMjd6M1FQY3Na?=
 =?utf-8?B?NVU5MWsya2lwSHpRS2tGTEpxWENNSjl4L1c3ak9YeFAwQnllYkJoYWE2NnUy?=
 =?utf-8?B?SGdYNjVaOXcvU0lWL2l0Q1ZreE5tL1J6OEE5dmx3S1ZOMmFncks3a1lHM1o2?=
 =?utf-8?B?VGJyMGorUzVNdGZCUm10ZjdvZE1pekloeGtZL2NlbmQ0eVQxWFcwWitzS0s0?=
 =?utf-8?B?SmJUc0dURUljNkVZODRSQ3gxTFV3WmhvdGh1SUdOOXdpMDhEZXVVR2pPOXNp?=
 =?utf-8?B?SG5QcVRUaFRUNFY1ZitLbnM1bzQ3c1Nwd2dKcjZ4RkM5VkpBelc4dGxBVE1G?=
 =?utf-8?B?TmJtR0J5QTZ1Z3lvV3VISWJKdzUwWXEyM1ZDS2VVRnRJNkUyb3RRdTg2S2lv?=
 =?utf-8?B?NVo2UHFXVlFzVnF6N05lNjFicU9CM3NTZTFuQkY4STZFVDVnQmE1bHRFOWZp?=
 =?utf-8?B?N0d0Q2pDSGxtVUFQS1Z3UGthUXJCb1VpTVZZMjhnUjl4UUE1aXdaWGt3aW9U?=
 =?utf-8?B?U3pFbFVWdDFsMURQZzF0cWl1VGszK04vMXFXTGNTZTBMSUhxc0VKWDBaMUp1?=
 =?utf-8?B?Nlo5bkFlL0IrcDJzZVkwRDJ2cFU4bzNiVnpocXUvRjM3cXc4UzhKYkNNT1Mx?=
 =?utf-8?B?TlQvdXErbHQ3cDdvT09LTCs3WFoyNGpZT1Vuc1EzLzZIYmp1K0xsVzFNT3I1?=
 =?utf-8?B?eDVNTENvVnl6Tk1NUVVGUnVJL3lNZU92Mk5sV0ZoUUhva0h6TWlkVmVaZ0Jp?=
 =?utf-8?B?S3pQSGMwRDM5VFFpWGxsdEcvWGNPVE9CMS94STNOZVJHWERNUW10eUNPT0hv?=
 =?utf-8?B?UWhHUFlzaENwK21YUzdLeXIrT3pWdGxFK1BTQmR5NHpVaXlGelRFOWRjQnJn?=
 =?utf-8?B?QUV5MlVuS3FFRDlBN3dUOVhscHZyb2NQOTNldTlZN2gzakhlaUt1ZnV3citQ?=
 =?utf-8?Q?X0xWQ9wMSa+LjlJ0ukZFOKa0e?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e8f4c4-6ffa-4ccf-44df-08dc1e3d250e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 07:05:14.4321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mj6XVMb8FQPoTon2pbQ6es/ZiFGsbIRmEP9wdSs8lSkzDoFIWxkjIiuTIx1q3iZ6WrZjswfCerxPjOhW6OlvDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9825

From: Peng Fan <peng.fan@nxp.com>

To i.MX95 System counter module, we use Read register space to get
the counter, not the Control register space to get the counter, because
System Manager firmware not allow Linux to read Control register space,
so add a new TIMER_OF_DECLARE entry for i.MX95.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clocksource/timer-imx-sysctr.c | 53 +++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index 8d5bfb8470fb..9b7c021c3b46 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -8,12 +8,15 @@
 #include "timer-of.h"
 
 #define CMP_OFFSET	0x10000
+#define RD_OFFSET	0x20000
 
 #define CNTCV_LO	0x8
 #define CNTCV_HI	0xc
 #define CMPCV_LO	(CMP_OFFSET + 0x20)
 #define CMPCV_HI	(CMP_OFFSET + 0x24)
 #define CMPCR		(CMP_OFFSET + 0x2c)
+#define CNTCV_LO_IMX95	(RD_OFFSET + 0x8)
+#define CNTCV_HI_IMX95	(RD_OFFSET + 0xc)
 
 #define SYS_CTR_EN		0x1
 #define SYS_CTR_IRQ_MASK	0x2
@@ -22,6 +25,8 @@
 
 struct sysctr_private {
 	u32 cmpcr;
+	u32 lo_off;
+	u32 hi_off;
 };
 
 static void sysctr_timer_enable(struct clock_event_device *evt, bool enable)
@@ -46,13 +51,14 @@ static void sysctr_irq_acknowledge(struct clock_event_device *evt)
 static inline u64 sysctr_read_counter(struct clock_event_device *evt)
 {
 	struct timer_of *to = to_timer_of(evt);
+	struct sysctr_private *priv = to->private_data;
 	void __iomem *base = timer_of_base(to);
 	u32 cnt_hi, tmp_hi, cnt_lo;
 
 	do {
-		cnt_hi = readl_relaxed(base + CNTCV_HI);
-		cnt_lo = readl_relaxed(base + CNTCV_LO);
-		tmp_hi = readl_relaxed(base + CNTCV_HI);
+		cnt_hi = readl_relaxed(base + priv->hi_off);
+		cnt_lo = readl_relaxed(base + priv->lo_off);
+		tmp_hi = readl_relaxed(base + priv->hi_off);
 	} while (tmp_hi != cnt_hi);
 
 	return  ((u64) cnt_hi << 32) | cnt_lo;
@@ -126,7 +132,7 @@ static struct timer_of to_sysctr = {
 	},
 };
 
-static int __init sysctr_timer_init(struct device_node *np)
+static int __init __sysctr_timer_init(struct device_node *np)
 {
 	struct sysctr_private *priv;
 	void __iomem *base;
@@ -153,9 +159,48 @@ static int __init sysctr_timer_init(struct device_node *np)
 	base = timer_of_base(&to_sysctr);
 	priv->cmpcr = readl(base + CMPCR) & ~SYS_CTR_EN;
 
+	return 0;
+}
+
+static int __init sysctr_timer_init(struct device_node *np)
+{
+	struct sysctr_private *priv;
+	int ret;
+
+	ret = __sysctr_timer_init(np);
+	if (ret)
+		return ret;
+
+	priv = to_sysctr.private_data;
+	priv->lo_off = CNTCV_LO;
+	priv->hi_off = CNTCV_HI;
+
 	clockevents_config_and_register(&to_sysctr.clkevt,
 					timer_of_rate(&to_sysctr),
 					0xff, 0x7fffffff);
+
 	return 0;
 }
+
+static int __init sysctr_timer_imx95_init(struct device_node *np)
+{
+	struct sysctr_private *priv;
+	int ret;
+
+	ret = __sysctr_timer_init(np);
+	if (ret)
+		return ret;
+
+	priv = to_sysctr.private_data;
+	priv->lo_off = CNTCV_LO_IMX95;
+	priv->hi_off = CNTCV_HI_IMX95;
+
+	clockevents_config_and_register(&to_sysctr.clkevt,
+					timer_of_rate(&to_sysctr),
+					0xff, 0x7fffffff);
+
+	return 0;
+}
+
 TIMER_OF_DECLARE(sysctr_timer, "nxp,sysctr-timer", sysctr_timer_init);
+TIMER_OF_DECLARE(sysctr_timer_imx95, "nxp,imx95-sysctr-timer", sysctr_timer_imx95_init);

-- 
2.37.1


