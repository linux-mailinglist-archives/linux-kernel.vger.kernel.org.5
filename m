Return-Path: <linux-kernel+bounces-37973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0422383B901
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C8A1C23BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C6610976;
	Thu, 25 Jan 2024 05:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aiY0npBn"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2087.outbound.protection.outlook.com [40.107.249.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4868710A22;
	Thu, 25 Jan 2024 05:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706159763; cv=fail; b=SeBS5u6hTBjSvCf9ssLJkAwOZIp4aKGmK701GIKQiENZOzZ5W5SH5NFixcRtoQKlfp7X2QchFj+MapJCJeuCPLpTD2B1xFCPcXUIYF6rbbmQjIHewCKGFGrWkP4AWFGxlRPogir6opFCVovtnaFb4yQyLgT1o5GjCHolewCyT2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706159763; c=relaxed/simple;
	bh=LDN7O/dpGg31VW4DZx50TL7inOfSwn3xUBm8mLyixjA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=reqsdkKbX2s9xbLwmF8IQYRxTPN97NOi5/BhTc5av3I1RvuNrPG/9hofQueMxhSHwkoT5y6y7G8bFdo9oXTZ999zLBw1Sojm9RFcnS9iAWG4UIk7F4hNqw5b2Zh36rdXgHp5g/uREgaRHXgyaG3oIQEVKBflEq1d48WBsne7h7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aiY0npBn; arc=fail smtp.client-ip=40.107.249.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2Gi5Oi9DIQ/cUmUNXFtKVLA8Z+KR/x+pQdgEvzqvtfjNnCWGevthEPS4ZoPK/uO46DpyfCkzkfwD/9xp8xwNyDZFa5f9NOffgZUyA5Ewc0d1vOqOt5+0TzznHhBpBJgyCXMZqDaYSgqbdLjD0ofuvKP4KK5MwS32gHn/SOy4jsIqBBS3OWMLjncg5sv0t9Np2JQvsrYb4MUxg628rnCTHu/FOtw3yVFwVVXil0e4B/kXdiFbIcVYqUy1akNRpOY60H7HeCKkHPZfCRda5NzwKCKCNAm9qI0hIDWM21QfClfkKcpNNkrIhH9FDM+d8O/O9q59rOU7EE1Y+LP14z67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVF+lIifocnKZkWBqalKhcjKGKvD/NfO5sSqA4z8S+g=;
 b=YAdkZsl8gftGwXDX233yB2UPKe3ACyxCNvKntmsX1dKmqTUXdTFx35mvgHwPxZtfCQW2VQAYDzra1s8jpsOO7NZ2t/dPwhD1qsUz8h0vC7hhDn7TSNG4IsXS8IrLUHm0IjUV+ob6XckiwKsWA0fXBqwEUmy++GnqB5PCaHj0rYHIVEGVcJfY1sKeoWPoVlUIsouE17LVTGXRnO9o/rN7go/X1S3KPkc8mEI8+OR+PoAvQaaT+vLOpeCEXXe2acH+1kpnvemC2Jbj0hhdKahlmds7pvQDmT7Z3wX4PBkeUBQqcW+8zQN3eh+LZlfP2HwBXy0KiYpM59vLHeX5rqjpCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVF+lIifocnKZkWBqalKhcjKGKvD/NfO5sSqA4z8S+g=;
 b=aiY0npBnoP+HnXAgmHH4I1MkN9VffurUBsUxhd7I7chuxpsHbB2vTCuFeyIALnbjO2RU4A+tiVEeW+p2SYvyIymwm9iEPsljcbgLcqxJKlVepwDO08NW0SCo1/AzsyKcKKl4k7nPhk71vsp4t6lw/QLl8RaItODzWTn2HRiJ2Mo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8275.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 05:15:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 05:15:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 25 Jan 2024 13:20:04 +0800
Subject: [PATCH v4 2/4] mailbox: imx: support return value of init
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-imx-mailbox-v4-2-800be5383c20@nxp.com>
References: <20240125-imx-mailbox-v4-0-800be5383c20@nxp.com>
In-Reply-To: <20240125-imx-mailbox-v4-0-800be5383c20@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706160018; l=3343;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=+Gd+/hMaY4KbnLg+mAxCKcpz6HM1MVsMqwBCKUxGXc0=;
 b=jrGwXVeZrCtbYrIpbRKhaIScl3XUdA+WXHE/EacTeNle57CnLCZIKACIFeDK89AvN3fHwe9tI
 4MDYljwA7q8A3JhGUFzit8fMhXe/JFzTG4Cg/wkmuRPNPOYK8fbwNH+
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8404d7-f91a-4935-e6bd-08dc1d64b6bb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0XLVHGm0TQtfyZ+GRaHKsRhGF+/pMX3u1nP3TzZaDYXL7xiHEbibeFl335IbROGydLawBqisWyADKxFrTYcDT5hnegbj3DGNwSICZ63BVLnm+UlN6vz3HHsewpljDIu9lTA+Wr0+vMfpC22E3sJv7TLae2gr7BHBcOCDYV5NfJYKQ74KbwLEBs9SY1NakFG3OQtzp4mwmd7O6tZdZ40dCQEm+fHjJhSkRoJJjJCZLELLvU1DwF1g6w7Z6FK5BplsJDLTBSTcT8lyRJ6Yjw0+oFXe3QzEwJ6zS8r/nasKHN49qfVKU1gWFWWm6EpASPdpQBIzjahN4W/bPPdBTnH3Twq1ioJvD2ZEiMI4wpU9gOmNYYh9yitcgZpqyrte+q3naHdcKD3jmy4eyl6/mREgD0OpUVgzGrHqqCrd945wFZG/MYxfO4uKEHDGB8ocIBE6UTkAKsQcGEeXgjf+AIGxF1obfaKhZ/6T9Z8nuucj2lBC5B/QJuLA4iG6hOvjKOHs/r60GzGzwVRQk+/r7eUxeDHl6r3qKAoo6BpHq+eHPr+cEMRjl9bEV8U8YOnGNzJLav5kEnZkV/iiGs2/ufDGnA92rm37GsgcN2ZszN6CykDpHXUzlf5kTzKqDWLUVOji
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(921011)(41300700001)(26005)(38350700005)(36756003)(9686003)(52116002)(6512007)(6506007)(6666004)(478600001)(6486002)(83380400001)(38100700002)(316002)(5660300002)(66476007)(15650500001)(66556008)(66946007)(7416002)(86362001)(110136005)(2906002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGhma3FPeFF2SXdSQjZNQTNNYzV6QTJ2WE5WejNPeHYrdXZyRWxvdEFsUElT?=
 =?utf-8?B?dWgyRzBNbk5KNjdURDdRZTB3SVVNU3E5SkpoZ0tPWWJXZjlPQjc3endXUlVW?=
 =?utf-8?B?eGdHTmVEMElCZk9nY3VMWHhrb2s3eVg1UU5aTTVTc1h4MEtlMFlXeGF6QllL?=
 =?utf-8?B?b1JLVWxkTUJCUnhWK1RnSDJUOTQ3SkJRYXVyWWpuemtQaHM2M3pOdzFQYmll?=
 =?utf-8?B?ZXZTQ1c5TE1NSjg0OXhEZ3NTTUhRWHYyN1RlanVhQnFaN2VQWWFqQXpId0U4?=
 =?utf-8?B?RzQvYlVUMUk3YTgwTkFPWUYvRkJVZFFLWWZkZ2w1ZEVzQ0lIM0FOVVY0aUtM?=
 =?utf-8?B?VCtnU3V0LzBJQzN4d3ZZdjJkc0YyS05rZmRKbFBORWpGcEdldDVWdmhab2Nk?=
 =?utf-8?B?UTdjaDlaTjZNc0FEb3ZPcHdBNkh1MW9lL1U0NWUybUxsQXdoRVU0T1lQTG5t?=
 =?utf-8?B?Y3dNRXJUTE04blNTNW13TjRPZ3E1V3NRdGV6VzdxZmp2Ylp2VDdUT21wWURY?=
 =?utf-8?B?YlpUWVkvTW4wWnJVMnhpWVMyUi9tbkhWQ1o3RlQ0b3lJWlFrWkJXMUVhUUF2?=
 =?utf-8?B?bTNTQ1A3VFFVY1FYWlZzNG5GcHB6TC9OUmNrempGeVM2QUtkeDZNUnNPTnI4?=
 =?utf-8?B?d05RRWovdVRVSy92cWdaNzllTFRqSC9EU0dibkFWU2Jxa1kwbUZSTEtPSmRW?=
 =?utf-8?B?V2xIaVJmaVVOMmNod215dEtuaVVZUUlzSVNNMEtYYm1PbFJDSE5HREh0Rlpo?=
 =?utf-8?B?aTNKdTJhdUlPeGhmSWtjMzZqb0NsdTduckU5VzJ2NlFNYWwvSkRSeHZNdCto?=
 =?utf-8?B?TU8zUzFzdFNHNjhTVVpPNTlubHJac1piWm5Td0RjWXlDRzl3b0kyL3Zkdlll?=
 =?utf-8?B?YnZMZE1DcGp3UWNHblF6REkwQmtYSktRYkZVeFVRaXUvY0ZqcEY5cHluNFRQ?=
 =?utf-8?B?Um5qTnNaZXBadmFsazRBOW1oQkpyNC9JbkJiWnNuM0NjMFIzcUpXdWdGTUNo?=
 =?utf-8?B?a3lIcStkRkxUaGZ5dTYwdWw3bE9oVENTakpiQS9IdStGYUcrWFQvY3l2RmNE?=
 =?utf-8?B?RS9xUmErMUNOSk1QNGV5T3VQZXRKYW0yVnNhM3RaUmQ1YnV2cXNaeVpNY0xa?=
 =?utf-8?B?a0dLY2txSE55WEI4U3BZbzVvd3NSZ0Q2VkVyRkhaOUdjMWZwckptZEMxclVH?=
 =?utf-8?B?MEZyUUVERXgwNjl5Z25xblR1QnlUUDluSnZuVU9MWVZWV3ZUNEIxUzBLUUkv?=
 =?utf-8?B?UldaWWRDcURMckNkM1FKMnV5VXduNm4zeWlFaDZFcy82VGp1UUhFWkgxSENI?=
 =?utf-8?B?Q1M1N0FrNkQ4UzVJVTdmL0J3RTdxMWplUkRDOWpId1dleW1sVFlKcWJNOU1W?=
 =?utf-8?B?VHlyYzlEMTQ4UUg1Zmx6NjArK1g2aWZCMWQrbDhiWWFENXR1aDQ2QkVxTFAy?=
 =?utf-8?B?MmUrMUtvQ1VkeGZLeERKQkhyVUpnd2NuY2tRTkg3c004aGxJV3RBM0gzQ0xO?=
 =?utf-8?B?bUlDM29PWmd4OTJYNTdVZGtxVXo1cEg1WlZGOU9xMWkyaDd1TGErQ0VjZTlK?=
 =?utf-8?B?OG9PcnVvRmZmV1d5Ny91eFA0MDBHOHYwYW5vMGdiUXZxRWpSZlppbWU1VGpG?=
 =?utf-8?B?VmtCc1RyUDVPcTNsai9MdVBDMHJQWGVOMmpiV1h5dm93ZCtvMGptdlhDV2tE?=
 =?utf-8?B?cXQ3ck9NVkNtbC9hNGUrOVZRVjJjK1hFR3JnYTNvdUIyWjdLMW9LL2VXUXlQ?=
 =?utf-8?B?ZHBCYm1QYjdKZ0lBdkpydmR0cnlEYy9qYWpDNnM3Y0hBR0RuYWpTRTBqTkZR?=
 =?utf-8?B?UGpPVkprZVI3cjRCZmx0akk1MVNXY2s4SUQyNU80R3hVclc4d0dBVTA0R0JZ?=
 =?utf-8?B?R3ptZnNjRERDdzhwbGJWUGJqaCtMRFVvUlA5WDJZUHVSUGYyZEgwME1vS3Zp?=
 =?utf-8?B?M2JsMllpMGpMU1d3cHUzUEltd1oxQm1BZW9FbDJSdUlYckVjbU8wOStXKzV5?=
 =?utf-8?B?NkloM2ZzVVVEQ1dJU20wMXZzTGpNck1EZ082Rk1jTCt3aWczVkk2ZkQ0eXpD?=
 =?utf-8?B?STJkRGVCU09kQk1iSGE4NEwwbnVKdWk3V0hUZkpnb3Jiczg5SEcrcUlUUGFK?=
 =?utf-8?Q?rLFHTxfHuoavMYmUfUKT4DjGx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8404d7-f91a-4935-e6bd-08dc1d64b6bb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 05:15:58.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcxfgHzifFWKwc4xx7I5CJuTBUDhoEF4auJ4qkPLuTGTmGcfVbKVgT6rieC5BAEBYVUA/CsUI0+5aENyrCyhlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8275

From: Peng Fan <peng.fan@nxp.com>

There will be changes that init may fail, so adding return value for
init function.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 656171362fe9..dced4614065f 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -110,7 +110,7 @@ struct imx_mu_dcfg {
 	int (*tx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data);
 	int (*rx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
 	int (*rxdb)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
-	void (*init)(struct imx_mu_priv *priv);
+	int (*init)(struct imx_mu_priv *priv);
 	enum imx_mu_type type;
 	u32	xTR;		/* Transmit Register0 */
 	u32	xRR;		/* Receive Register0 */
@@ -737,7 +737,7 @@ static struct mbox_chan *imx_mu_seco_xlate(struct mbox_controller *mbox,
 	return imx_mu_xlate(mbox, sp);
 }
 
-static void imx_mu_init_generic(struct imx_mu_priv *priv)
+static int imx_mu_init_generic(struct imx_mu_priv *priv)
 {
 	unsigned int i;
 	unsigned int val;
@@ -757,7 +757,7 @@ static void imx_mu_init_generic(struct imx_mu_priv *priv)
 	priv->mbox.of_xlate = imx_mu_xlate;
 
 	if (priv->side_b)
-		return;
+		return 0;
 
 	/* Set default MU configuration */
 	for (i = 0; i < IMX_MU_xCR_MAX; i++)
@@ -770,9 +770,11 @@ static void imx_mu_init_generic(struct imx_mu_priv *priv)
 	/* Clear any pending RSR */
 	for (i = 0; i < IMX_MU_NUM_RR; i++)
 		imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4);
+
+	return 0;
 }
 
-static void imx_mu_init_specific(struct imx_mu_priv *priv)
+static int imx_mu_init_specific(struct imx_mu_priv *priv)
 {
 	unsigned int i;
 	int num_chans = priv->dcfg->type & IMX_MU_V2_S4 ? IMX_MU_S4_CHANS : IMX_MU_SCU_CHANS;
@@ -794,12 +796,20 @@ static void imx_mu_init_specific(struct imx_mu_priv *priv)
 	/* Set default MU configuration */
 	for (i = 0; i < IMX_MU_xCR_MAX; i++)
 		imx_mu_write(priv, 0, priv->dcfg->xCR[i]);
+
+	return 0;
 }
 
-static void imx_mu_init_seco(struct imx_mu_priv *priv)
+static int imx_mu_init_seco(struct imx_mu_priv *priv)
 {
-	imx_mu_init_generic(priv);
+	int ret;
+
+	ret = imx_mu_init_generic(priv);
+	if (ret)
+		return ret;
 	priv->mbox.of_xlate = imx_mu_seco_xlate;
+
+	return 0;
 }
 
 static int imx_mu_probe(struct platform_device *pdev)
@@ -866,7 +876,11 @@ static int imx_mu_probe(struct platform_device *pdev)
 
 	priv->side_b = of_property_read_bool(np, "fsl,mu-side-b");
 
-	priv->dcfg->init(priv);
+	ret = priv->dcfg->init(priv);
+	if (ret) {
+		dev_err(dev, "Failed to init MU\n");
+		goto disable_clk;
+	}
 
 	spin_lock_init(&priv->xcr_lock);
 
@@ -878,10 +892,8 @@ static int imx_mu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 
 	ret = devm_mbox_controller_register(dev, &priv->mbox);
-	if (ret) {
-		clk_disable_unprepare(priv->clk);
-		return ret;
-	}
+	if (ret)
+		goto disable_clk;
 
 	pm_runtime_enable(dev);
 
@@ -899,6 +911,7 @@ static int imx_mu_probe(struct platform_device *pdev)
 
 disable_runtime_pm:
 	pm_runtime_disable(dev);
+disable_clk:
 	clk_disable_unprepare(priv->clk);
 	return ret;
 }

-- 
2.37.1


