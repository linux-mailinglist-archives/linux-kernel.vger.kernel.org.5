Return-Path: <linux-kernel+bounces-70722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4CF859B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC62281A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C801CF95;
	Mon, 19 Feb 2024 05:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RDyEAF5C"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2054.outbound.protection.outlook.com [40.107.13.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5E9257D;
	Mon, 19 Feb 2024 05:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708319666; cv=fail; b=dugLeM1koFpQXKBG81Zglt08hUOLaCjDdo37kLWuEeXL/mCy1oCz5wVaQq3RM65aF2uarcWEy51EcoJpW1bbODQzB3lGLw2xrvOV23ioblX5o120Xbb+mduNOKY+xUS+eXaYQ6v8GWZ+g5WA4lQNVWGvspV5t3d1SdZSiWlozdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708319666; c=relaxed/simple;
	bh=zY6UXXKyBj0qqZ+nkF9V/M8wXac3nwd5osTeWH2petI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=j3O5IL8g6h4dEavS8dOYgEdnT+Tsl6nrvFzv4CD/ZKOH7QZg9qva/Xn268dfDRF55Pd8owG4ehiMt0TrdJ/AATlS7xyrneOxrYyG8MWKJFD8IndX+6DABbDug5lRRiynVPYXv4uRSPWWu4mNcTSHXVZOo8hbINMnrCygezD0Ta8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RDyEAF5C; arc=fail smtp.client-ip=40.107.13.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqDFuWyZZLRsiZ42Sq5riY+p++6KUzYTy4kHfmyl66D/PioJRINsxRAZS2tw7zmq30cJN+fUDFRHyZPqRybyKflXrAfjCspVc8xpIF/1GCQo81KC2vGkSfZSBGN0N3SUBYuRnCtpWi5jOKeNWLPQza2C8F38jQXVxqhdEhY/pqibAvKZPAvMas9AKKOe//V4NV6G8dbgTMsIyRKcaxDT9yjPoLSA8JPmexVlYiHLGZImrUloqha0M+aWJDF2Om+oqPjVzObSs2EUosahmR5PioLozAm00qx3gCI3z35wTyaKtvP4w0pc7GPdR8l5E6T/kLD2aZd+mUbMpPDdz3vU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvKB+A5hMOF3DRA6aDHLPY41uexTzYoXFpenqLVMc48=;
 b=ADrQxflxNZUhqyDTWRnqmajY2gRmo1Al8CcgGUUig3wGnrOD9kS6/50uYytQU1zpFxey5c9fpnw7gCHW4//3clgpXwCT6MwnR83RTD/M2H+Oxy8F5DIoJwbhhSfYgbwzBcMGEGE2WUZbmCV83QWpXIpcNGnNzAFUO6uiqcBS7ApBcLyS7aCShpjuIEIKO1OnguZ2pGxWe2e4nJ4WpROAvEbyt4zqOAOEk2/ZsIEFBYrDpkoq1HyacGJ9hoqZbDK5kWP35jXEimKqIj9LPnV6bmCI/JNhAdsPKkhpaUbD1ZvIkgtHp5VfVu1VRiwXQo5eY7jaXNaJNS0tf2DiKJEyBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvKB+A5hMOF3DRA6aDHLPY41uexTzYoXFpenqLVMc48=;
 b=RDyEAF5CQPT0tMurSK9Nrirrx/4nxz5A6zboCzGZfFuu5jxxLifGoaOWZ2wW7ccxx3MuReXUuUVf4J/8K+qkGh6AfHXy2XV6snHjqHswe4BMhygAss/987HNMRzmfM1GoGG47053YpyMWrdpcdZoRAQcRlFTtA+UW+XJQbAnRZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7228.eurprd04.prod.outlook.com (2603:10a6:102:8c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 05:14:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 05:14:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v8 0/5] mailbox: imx: support i.MX95 ELE/V2X MU
Date: Mon, 19 Feb 2024 13:22:35 +0800
Message-Id: <20240219-imx-mailbox-v8-0-75535a87794e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJvl0mUC/33OwW6DMAzG8Vepcl4mx44D9LT3qHYg4KyRBlQwI
 aqKd1/Sy8g07WhLv0//h1pkjrKo8+mhZlnjEqcxHfXLSXXXdvwQHft0KwS0YBB1HDY9tPHTT5t
 GS4CmNwgEKonbLCFuz7XLe7qvcfma5vtzfDX5+/fOajTo2lhDwTGjgbdxu71206Dyyor/SEyy8
 tTVQES+wVLSUVIpKUnpG8LGsoAPpbRHyaW0uRbAC1NNHf6q5aN0peRcGwK11DMxNqV0PxLBlNJ
 l6YINxN4CSSmrgzR1KatcG7xzLNKKPdTu+/4NhrU6hAACAAA=
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708320164; l=2405;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=zY6UXXKyBj0qqZ+nkF9V/M8wXac3nwd5osTeWH2petI=;
 b=EAw1mp6DJ+bU0/Cg4yrG7k079fMjpiyfyR3Kocm2FScGvkW65Pw4+WFoJZaZiwnU2EZGa2Tk2
 rSclioxF1gqAFS7pMunSHKuC7hmrlI7WVmTX6q90PLfaKtxj6OblQFB
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 4176be90-2210-490c-5643-08dc3109a098
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AyoGCKPaJpfoFKO4a8gmKo9r+dV4Wr/PyAMt7BQ8TFIf7Ky/aaAI0kXT55CntbBdhJ+H0b6PiqHgHOq4SdnA/j2XEAIWAk1TJgRJrDw8J81KPnPgFbpLAbJIbz0kk5r9zwuYq1u72N714KHJJFEVrDtCwzmCC34HwEdwINsPnsj2xxUdx4LkFb67c8NrGvGqFtrvszpknZW2JwwN7vewVKdcvf5+KiUsA7NRVvQ0aaLaCXGyklYSmq71ekNK608kEpx/bazg9FoYtdejuaG70hOx7YzwbHPt5gWdPljh+Axx9i5dXlGtbFtBErEz8HLnSc3O2gFubMCpDsNjhCnPlGxGLiTtcLTe/H8xawFpNIYhzvd6upbERosrnlyNiuN8wdJuuw6I7DTfj+SVPLTV0aO3adwnQanCfdWQRZiKT0N7p9S9Qgf3ZuHQVMxS8/fwneCzhTkrUzdhWY/XRn4uz9w3W4s8fX+/mDN7lpZtlCN3np/DZPvL5cW61s4tvrrc9Zwdg/KM1M2Am6mMy9C/3/U2UtyXqhd4c1cR40RF0+pc+PhKdwq56y1TlUAfgincJ3JIlI8PR8qaB3UZirzfTnqb0fwagfofiWLTbr86Ckh8BIE+lchWdDNB8PtPNntV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(8676002)(4326008)(2906002)(8936002)(66476007)(66946007)(7416002)(66556008)(38100700002)(5660300002)(15650500001)(86362001)(52116002)(6512007)(6666004)(316002)(36756003)(54906003)(6506007)(9686003)(6486002)(966005)(921011)(83380400001)(110136005)(478600001)(26005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkNrTTl1K1RpeTZIRHlFbjJ2TU41WTVWdkNTcTB0SjZ5QmNvajZ1UXRwUWlt?=
 =?utf-8?B?MEVEeUh4Z2c5NHRTeVJKMEFxRm1QNU5wUjJwNU5zZ2Z2UUd4ZXZGdHltSndu?=
 =?utf-8?B?Y3FtWHk3UXBzWXoxRi9mMVZMaW51R2lDUnZ5d1VnejJwSGJ6Q3ZydGZCSUMy?=
 =?utf-8?B?OVFLaU1TQ1RWZjg2NmVsWngrRTlTSUhMdUdxTzZ2Si84SExpRnI0ZjMzWEhS?=
 =?utf-8?B?OUpGSTR1ZGdsc2h2cDB2UVE1SVZSaFZmMEE3OFh2M3M4Y0drVUI0V09mNzZk?=
 =?utf-8?B?dWIraTZGcTcvdXFqUjZMRzN4TnB3SS8vSDhRb2JibkFwZGVmL1grTmdrcVcy?=
 =?utf-8?B?Z0ZYcVU0M3pReCtxclJ2R0tMblRTVGl1L3FuWi9FWmFXTHhzM2Jhb05zcXcy?=
 =?utf-8?B?WFJ5bzdObk9BSWVlUGFzcFh2Sk0raFVKdFhpd25YcmRaSHZnbDg2aFVLU0Ux?=
 =?utf-8?B?MDZWOGh1WXR0MGFlbHFsdTRnaWsraWRBWG90U0wzbWlCRDJ2NHJ3N2dQSXg5?=
 =?utf-8?B?cjUzSmZvRGVXY2lGWlhNeFdXY1dPVDZsenMwL1BkeXhnb3VnaWpjY2xHTHBN?=
 =?utf-8?B?ODI2WUR3eVM0VnVnem1XUk5FcExhTW5QdWJhbkdiRE1iaGtlTUd6d1NoQmNh?=
 =?utf-8?B?WC9wQlBRTVorVHlnSXNVbFEzb3RoL2Z2OFVxb1J5czYyMEVsYU9jZUt6SmJq?=
 =?utf-8?B?QlpCcXB4QU5vRU11NDc4K1gxbzdoU1ZKYTczQWZBc0VLOWorWEZWYW1xMlQ5?=
 =?utf-8?B?MDlNSTdINHczeGdoeUdBemVmZnc3Z2ZHb3FxdDEzZHFpL0V2Mi9tcjNCOWdw?=
 =?utf-8?B?ak16aXE2Y2xJR0ZYSFhCT2NDYWtwVTA2TzExY254TEIvVFIwWUp5LzREdFYz?=
 =?utf-8?B?ZDk2R2JjeWtxVVpjNmlDVTNDZ3E1NDRzVENDajREZ3RXTTIxS2VyUUI3enRv?=
 =?utf-8?B?U1VTb0c5Y0RXbm5BMm1TVCs1R243eTlVMjVGRkw2THE2RXE1ek1NU0FvTnBk?=
 =?utf-8?B?QXU2S2lBWHkwWnpFTWp3N1NTQkljR1RSWklJOFVyeDdXYW9mUUZUZXFJeGoy?=
 =?utf-8?B?V0NLSUsyMytPVitMZzFpVzN2Z2FlakFNUGJJVG9oaDZ1eHhsbVZJd1Z0VEJV?=
 =?utf-8?B?bkJpT0lCaTRVMkErcUQrb25odkZ3ZWxYTkdGSlV5eWlMem03Q3Zoc2JYY3Zq?=
 =?utf-8?B?RUVnTE53WTN2MEFEVStWMGZzTW9hby9IbTgvVTMveHQ1MnRxWnlTOG9uQUUy?=
 =?utf-8?B?aW1hS0F0enNHKy93b1NuZGlSRlFRNVFEcUdqUG9uOTlpT2dPZEFGcGkxc01Q?=
 =?utf-8?B?dUU3NDVFWWkybHpxdTBqNC9VQVh1TTNRWTliZ3N6ejltSDlZVGN0cGdHR010?=
 =?utf-8?B?TW1zT1Q1UjlMc0hEUTd1VkRSdms5RHBLTm0waXcwcis4bWJDekpGOFFDbTd0?=
 =?utf-8?B?UW9tRU5BeFFid3h4cUdzaVhuMm9nQ2YrUXJEWWw2S2dlREtoV29CSnZ5emtB?=
 =?utf-8?B?c2tPd0JCbkwwandxQ0p2ZHF6S2NNTWRFVEJWNmMrZkVOdm9ROWFKNU1PdEkr?=
 =?utf-8?B?cTBxKzN0UUdKTjA3VzNRVllReUdOQnVzTXFybWlCaFhzaEJWZUpOdWswdlRK?=
 =?utf-8?B?NWJyRytkTlBobHUrUk9jSFl4TmdKVi9YSUtUNnhaWUMzUU1qMWlEOGNmL2cv?=
 =?utf-8?B?KzFFTUhjV0JVSnFDTTRPQ3VPRjhldGdDbVh6UmtqUndGalBxbmR0anFhN0FH?=
 =?utf-8?B?cXAzd3hoc3krenhOUU5rRWppRGc3ZW9qL0x2ekZST0VFVkd2TVh3NjRscWw1?=
 =?utf-8?B?M3Y5U0ZXNHZHQUpqV3BUa1VCUitDNlFwcy9JRkYxelJWVzZYNXlXN0JxOWww?=
 =?utf-8?B?QnkvMkZCamNpU05FaFR3MU9aeHBLUm16KzJyOGRhSFNpYVNUVm8yazQ4NzI4?=
 =?utf-8?B?QzdVV1JtUnhFV2VONFJnWWdaV2c1L0lFVll3dEp4NGtYS3huYUloQ0UrVDBi?=
 =?utf-8?B?SzBpcEZCV0pxdTl5WDhoQk5sT2dtclQ5SDBqaHlCOWF2ZXFBNkdLK2tBSUxw?=
 =?utf-8?B?aWxzc3pHSXRSaG1GNExKR0RLUTJmUlc2M3pkWWhjUVBqaFZ5ZENRUStybmtH?=
 =?utf-8?Q?t79txQ2hKa7tPMfhlvZ2N1gXk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4176be90-2210-490c-5643-08dc3109a098
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 05:14:20.1567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 702ylhu0bFdx3GkoVj1+u78IcwF1h0/2zPOr1Jtk1CrqfO+Vf5Z6/FCBEyo2c3gbBM83iZdWBSxEUbUA0cInFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7228

- Add dt-bindings
- i.MX95 ELE/V2X use same register layout as i.MX8ULP S4 MU, but
  the TR/RR num is different. To make code reusable and not add too much
  macros, add runtime detect number of TR and RR by reading PAR_OFF
  registers.
- Add i.MX95 ELE/V2X MU entry in driver

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v8:
- Drop [patch v7 4/6] which is wrongly included when doing cleanup.
- Link to v7: https://lore.kernel.org/r/20240218-imx-mailbox-v7-0-8fb665eeae40@nxp.com

Changes in v7:
- Per Jassi, separate the patch to add of_platform_populate.
- Link to v6: https://lore.kernel.org/r/20240201-imx-mailbox-v6-0-76f4f35b403e@nxp.com

Changes in v6:
- Drop node labels and add Conor's R-b
- Link to v5: https://lore.kernel.org/r/20240126-imx-mailbox-v5-0-7ff3a3d53529@nxp.com

Changes in v5:
- Per Conor, add restriction to sram property.
- Since i.MX95 MU has SRAM, we may not see it is compatible with
i.MX8ULP MU, so drop the fallback compatible
- Add R-b for patch 2&3
- Link to v4: https://lore.kernel.org/r/20240125-imx-mailbox-v4-0-800be5383c20@nxp.com

Changes in v4:
- Address dt-binding comments in V2 from Krzysztof
- Link to v3: https://lore.kernel.org/r/20240123-imx-mailbox-v3-0-ed932945e0bf@nxp.com

Changes in v3:
- Following dts coding style Per Krzysztof
- Add return type for init function, patch 2 is new
- Check return value when tr/rr is larger than 4 and return error.
- Link to v2: https://lore.kernel.org/r/20240122-imx-mailbox-v2-0-7b3c80333b92@nxp.com

Changes in v2:
- Support sram property and add example
- Populate the sram node in driver
- Link to v1: https://lore.kernel.org/r/20240122-imx-mailbox-v1-0-81413f655210@nxp.com

---
Peng Fan (5):
      dt-bindings: mailbox: fsl,mu: add i.MX95 Generic/ELE/V2X MU compatible
      mailbox: imx: support return value of init
      mailbox: imx: get RR/TR registers num from Parameter register
      mailbox: imx: populate sub-nodes
      mailbox: imx: support i.MX95 Generic/ELE/V2X MU

 .../devicetree/bindings/mailbox/fsl,mu.yaml        | 58 +++++++++++++-
 drivers/mailbox/imx-mailbox.c                      | 88 ++++++++++++++++------
 2 files changed, 123 insertions(+), 23 deletions(-)
---
base-commit: ad5c60d66016e544c51ed98635a74073f761f45d
change-id: 20240122-imx-mailbox-243021d12030

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


