Return-Path: <linux-kernel+bounces-70232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82693859513
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B51E7B21D12
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE2E6AD7;
	Sun, 18 Feb 2024 06:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bnl/kqPE"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357B14C6D;
	Sun, 18 Feb 2024 06:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708238889; cv=fail; b=IR0UOo8HRIuJRKWQMFIzTizF3vhEUizYScYOW1KIVJ/p/t1GIrBBWlG87Cqg8QOJbpAhEhXhy3UzKA6wDmPENEPUQGdcTIiAGz6pxq/UVHalqQZR/mIclxYxgCe7CLIUpaNRezhaBykkHHL/P5WCwA3KyPUR9N56N/LGLw8sZlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708238889; c=relaxed/simple;
	bh=RPMQNmMFoRtas4k5Bg1YkNlWu43+BMZzlL0nW4tYMW8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=p9nrSSf9J6ImgwB+vof6xHVsDt5Qe8l6ee6vNe1Lk2TW9mA/ADu1iayzr1yT+g5b1xdogLpPRD5fHgTAvmmxn6FWFWQf+uthgn4+hOVuBluYWLCK2O9yEHC5rlWeynx73iASEQxiNDRb4JgDJ6MPRj8rRmjR/FeT3DUSKlNSwBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bnl/kqPE; arc=fail smtp.client-ip=40.107.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgAHLVq+to4+JNcJo5TkPfElXsv1EdpWKxHClu8GduGs10zIweyC6o3Mp7zWWOmzpXqBHnG2YFGvR+GZRmmu2DkSfl7qSATsInK62Po7vOT25q0qtiOelvVI+xi5SD/A7IQFgxScVKOG50CrcaOQO10EBLc9Z98dHALSzjD9HOKjmq06N8ZqBeM1viNAV9T23bdg/dO6wNho714Q2mu4TwnNbq0tkeW3gMBOg99snvXpsvtzms8XDraWO2YTLPC5WymKF9s8cyv1LxJ9JniHwxuK/0Vee/iR/kGyFgQx9mTroRLlgam4Yrt03EPfr2dExEEi2NOXjXobliR2845wKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymlb21vBUizT0FZiHty9VnS0TTqkEfN0efNpvT5Nr5Y=;
 b=i6OMaQZFSfea5Omhjja3llvpDC0UQYroS9AgEPz5VLaAuAZiegzzDImbOCu9IdFI6ClW7Z0AbRus2cq6BzVjlEg3P1SuOs7b/uUKx6xe3Rm/vujkXjqqcmADvA72dG/RG4wRHm9j5BSS66l8LA2VESaYhXsxLV89IvzRxkYgXELuC7CiKvPEfIMbpIUi7E6eToP2GyxS8jnyy8qiTB7NCUaX1EAvtl94wjZ0h4fkdD4YAH7q9cLclwaeBLsxhROIeu2iX36ar9FGYbqod3EqvlrVaoU1HYp8VEu7KECKoeA0Q2F4O4dkDIy/1oCwvwksqaz9qJv51tOGMRpjKCEOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymlb21vBUizT0FZiHty9VnS0TTqkEfN0efNpvT5Nr5Y=;
 b=bnl/kqPEh+tPaEwVyOTompyPyHl9eQoa7eLqr89f/XugL+bJ5hs92+f4exHxHOdy+ExQonGx9b9zibA+PeScEBCCUtEK5XHoOZgNth1qSRMKTftXdzVonqbgaiKoLRzIP9lixNqneaYtXl43EjvMi/tvDZimaU/Fjv8xenwnoE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB8011.eurprd04.prod.outlook.com (2603:10a6:10:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sun, 18 Feb
 2024 06:48:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 06:48:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v7 0/6] mailbox: imx: support i.MX95 ELE/V2X MU
Date: Sun, 18 Feb 2024 14:56:12 +0800
Message-Id: <20240218-imx-mailbox-v7-0-8fb665eeae40@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAyq0WUC/33OwWrDMBAE0F8JOkdltatV7J76H6UHy14lgtgOd
 jEuwf9eKZdYpeQ4A2+Yu5plijKr98NdTbLEOY5DCqfjQbWXZjiLjl3KCgEtGEQd+1X3Tbz6cdV
 oCdB0BoFAJXGbJMT1sfb5lfIlzt/j9PMYX0xu/99ZjAZdGWsoOGY08DGst7d27FVeWfCFxCRPn
 toKiMjXWEraSyolJSldTVhbFvChlHYvuZQ2vwXwwlRRi3/e8l66UnJ+GwI11DEx1qV0T4lgSum
 ydMEGYm+B5Cm3bfsFeziXQMYBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708239387; l=2240;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=RPMQNmMFoRtas4k5Bg1YkNlWu43+BMZzlL0nW4tYMW8=;
 b=7guWhfSTHOUviTv4xlH3DCU3IRljZUNLSqxn6SPKoN1rEalTl0W7cTgb/AitlscHDA1jc24G3
 uVGrp53syKqAwFbFnl8Qhr+UHprULLA2BmS2v232YXYRsaOmqO2KljJ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: d6fb2440-310b-4566-8bba-08dc304d8db0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3nC/B2ZWV99M+qNSGCfYnjHvm0nHB0eqULAwnZE8tFnbU23fe5u+eOz5GqedZln/laAAVhcPerwXWL1wO594b1OBfulniKYmB+5X4keWkRi7tBNQS+SKEmqyn7bbYakWIbNMkK0VOckxerHHTUUCQK+/VC+YOqurir9ZDh67YMal8C1682c1uUBuyRzN6JuW1mAk5wo9RZMgSex+wDJ/G7pSLEqBaDjCBFIXwA01DCFW7CPY8VqREp9MxhjUXAngYypLat0qe/SewoZrA+z2hMwwBqh4dshcTZc5n/j7qYZSxWPepsg1qPL3Ml72ksOMbdfLQeG9/YiaUPlyw+09YPfNG4vsWEL5woz/NXqDmPNJKT/Q3elrOGl5b/3imSbB2fDGZueW9Wj6CyRSr8gHqkj/lrZLRDoChFFrckNLEZqftDfIPwqvfsf1vJIcekNex/wgiwgDrMEgzmrPq7Q8wlA/CyiNZ0F29o9fyaQp7BJqUZhMPu9Dce8u/udydd9/qeudLDFiXfI1cMMTwHLAZsSC07jD6uqokc9Z4nxa2l3XW3CM9k7XoD4hWx4BI1kZZFJwPMxBlAohIZrgFZ0bYXOgVVBAO3asihpyneYEcxjm9YsE6Havku7byvLkANSb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(5660300002)(66946007)(15650500001)(4326008)(2906002)(8936002)(7416002)(8676002)(66476007)(66556008)(86362001)(36756003)(966005)(921011)(38350700005)(478600001)(83380400001)(110136005)(9686003)(54906003)(6666004)(6512007)(41300700001)(316002)(6506007)(26005)(52116002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHY4Skd3Y1kwYlFjZHB6REZlYkRWUjBnTkwrekdQMzdwZHBSVVJWa2g4bE4x?=
 =?utf-8?B?NHhncVBrTnBKdWlTclBaRHl4SkVoZVJKaXZXTkx6TzYyMndCZ0lUZW8rY2JG?=
 =?utf-8?B?a0tqcXBZNjlNWUdHckFDNnJsbFI1Z1V5VTJPbENKZ1BXSitmb0ZYa3BJOStu?=
 =?utf-8?B?aURIMWY0WGxWUXl1NExCMDNyWXlYL1o4U05LZExHMFZUbG5BeG9kb2t0SE8r?=
 =?utf-8?B?aVFYdkdTUFVHb0lwZzU3UzFaYk1rSmJvYWZRbEhmNHpqZFd1NXU5TGhLbktj?=
 =?utf-8?B?dG1aZDZWeTRPREZoRSszVm5CUkk4V2hwdEc4bnI4TEM5SmlCbm1tblJ4REp3?=
 =?utf-8?B?V21PN2pCMmlVWk9EUzR4NStCbHJ0ZEM3REk5blZPMnNvd3FnVzA1ekJyT041?=
 =?utf-8?B?UzBEUjZrRHN0TzBxWEM4RVk3Yy9UZnhCbE9VSGtiWGFZZmhwNlJkemJIYUdm?=
 =?utf-8?B?ZXVZdUFzMzVKeStQT0gxbitQZkhkN25aSUpyY3VQNHdsT08wR1lyQzNhNGRa?=
 =?utf-8?B?OFJTM1krR0Fpa2xRWlc0UDJpNlRCTmJNTFVhUUtSNk9jemUybllMUjNUWTdv?=
 =?utf-8?B?UkFWd1Jqdjg2K2QwQjYxeStESzJmdGtud1lFNlVMellsak0zOTlZMFRTdVlq?=
 =?utf-8?B?ZXJ3QUM5NnZEdmZPdk1ZTzFSbWsxcU5TNGZ1bDhMSzNtWVpNSHc0TlNHamxP?=
 =?utf-8?B?NXNhbXVSS2FWMTZ0QlVzbDF2dzlZaDJia25mNTllMTJkVWNyN1ZCUkFQZll0?=
 =?utf-8?B?MUtSYkRRMGJuVExTZmlPYytNMDNvSGZBUFpyTXp4N2ZYL3Z0L0JDeXlBK3ps?=
 =?utf-8?B?NFNienhJR1RRdHBhTTZhNmk2QnRsRVdGSERhaWl0aTFna2JJMnVSMTFEanl5?=
 =?utf-8?B?a0JlbmF5T2ExMmc1cG1iN1dQOGZNN2luYmZycmR3dU4zVkFIWkhKand5UHFG?=
 =?utf-8?B?eGtDTWFuOEhmQjRSODFqZ2FvRThueHZlMDA4RDVlSHZ4RmRSVklOS2hIdFgz?=
 =?utf-8?B?NjRUTnpNNnUwM3dYNlJ6dDFad1hHZzZhNzZSbTJuazlxUm9vWGUyUkhhdXY0?=
 =?utf-8?B?Mmg4b25QanFiQ1dMOFN1UjB1em1WaDB2WFdDNE5GK0laSW40Y1FpTXQ3OWF5?=
 =?utf-8?B?NVJrVTM3c0Z3bkZVUTlvTEJvZWNZRkhkNjQ1VFFZak1GWmMyRVc5eDBmY3Bw?=
 =?utf-8?B?VysyQVdac0MwYVR0NHZmTkpoT2tHTEN1SlpnTVlVMVBrODgxRWZKN3pyWDJF?=
 =?utf-8?B?N1dqZXNqOTVoLzlSQVBVeW5KNGkwRW9kUTBIM2Y2cDRyNnowVnZnL0tvZys5?=
 =?utf-8?B?L1dESS8yUFZpR3dZVTJvZGRtWEtPYXF0MlBrSzI3RXZ1SEx0Rnl0aDY1MllR?=
 =?utf-8?B?SHF1RHVBUDFyRXJwOXRSUnFSQ0V0aDFaSUY0Zjd5MFJOY0FZeXVKaUcrcmk3?=
 =?utf-8?B?dGJJMVVPaEpFdHJyTFJMVkZabXJNNzR4TU9mMkhLaE9CcVcvaUlJUjJ5UERp?=
 =?utf-8?B?OStYM1UwRm1aNmlLK1preVdtZENUK3BMU3Y5eUhzOWdwUCtrUVg5dENHSFBZ?=
 =?utf-8?B?UjM2elZNaHVhTHFMUHZ1cXR1aHE0V0JEMVlwRnBhL0pSbk9qVjFWMnNMM2pO?=
 =?utf-8?B?b2RwMDk4dTlEdzMxN290d1gxdGg1YUZ6clhGblhJam5jdXdvRUV6QStObXds?=
 =?utf-8?B?R1lDcGt1dUMxQ1FEemZwck4wUlVvaTJmbGVOYncwcDNzeWVSaTZ0VzhmVm05?=
 =?utf-8?B?YTQ3S213MTZES2dtTkhWRWw3RlNyVFMxODdUQm5IMnhkWGU2aEtOZzdzb3l5?=
 =?utf-8?B?amJHUnFqOXVZQnpRc1RlR1Vvb3krMTU2ektjeTJtWXplNGZRdFA5QXN5OWxv?=
 =?utf-8?B?NnFNWUt4Q0FibmhPQ0ZwVytWVGxsZUQ4dXMxa0o4Nk9xY3g3bUFybGtTK0dV?=
 =?utf-8?B?V0E3TWpuNTAxNjh3ejVDdW1wcDIwZm1QckJjQWFNM3gzMVNOaFdVTnExTVRn?=
 =?utf-8?B?aFpMR1JoTld6emFYejZGVXUzYjdpUC8vS0kzSlpIWjM1NzhOeUdqcHl4RFJQ?=
 =?utf-8?B?ZjBWQURQeTlTb0FUdlhUUHk2OHlhSHpyYlh3NDB5blVVUld3V1Y1VFBPbFlP?=
 =?utf-8?Q?1zxMo27ribcQhZ6tOU/IcHXvi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fb2440-310b-4566-8bba-08dc304d8db0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 06:48:02.8487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbzCzGOYWWcqNHUURhH7srSXgP27cfYEQHFBBpHaTs/tgWHtvAFznsmvTjAwxhRxl2GYx7OjBykyzagdXRRMSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8011

- Add dt-bindings
- i.MX95 ELE/V2X use same register layout as i.MX8ULP S4 MU, but
  the TR/RR num is different. To make code reusable and not add too much
  macros, add runtime detect number of TR and RR by reading PAR_OFF
  registers.
- Add i.MX95 ELE/V2X MU entry in driver

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
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
Peng Fan (6):
      dt-bindings: mailbox: fsl,mu: add i.MX95 Generic/ELE/V2X MU compatible
      mailbox: imx: support return value of init
      mailbox: imx: get RR/TR registers num from Parameter register
      tt
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


