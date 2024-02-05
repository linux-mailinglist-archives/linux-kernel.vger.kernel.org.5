Return-Path: <linux-kernel+bounces-52005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0335E8492B1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B1B1C20D51
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BD5B64C;
	Mon,  5 Feb 2024 03:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FccyDkCc"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57F2AD21;
	Mon,  5 Feb 2024 03:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707102826; cv=fail; b=nxUYeqJS87SsDkM7kbmnUONqgzMhAu/SFzpoGvE0s2YqLPq/mHV1AW6oiBePB7CXZGZXfjhN8Dxa+vIRpOiq0FqmP1PD0viGulo6bD9CiSn3G/y71cxEPmw9/qzcQGcno2R0fNGA4yad/2SJJGyg8RolhZMwXLYrOCicB+1nyA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707102826; c=relaxed/simple;
	bh=s9G+71tPkns3tJbaPqdwLtIcxDTfdPPhPBzYx1UNYcA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=nHrAop+h8LdYbCP2Nz4fTDYibIOGJf5xKCWcQKMuvjyQdaXv1ao/yOHuHKP2OrZxSXQ5kkoJepze4Nm1+yyS2Oqceb+5+MGjxQv/KIl8dnfEi5LOKSSpvHu6wQV2EZFqXKk3YCmKq94lgiUauTg4Tgsm4N5IzjII2FyWpKIA0dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FccyDkCc; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkFv3GajaD+1pCGJKkOaS6K9+h9JEyfe6gbnkvp3xjb6rBJyXG9vKeskxaVslaEJ1A26kY/HUvBZuF+DX6HH4+isoxK3uwrg6KSMweyRWV1FaWL2ndv8/fmR+IyYVyVrtTX3mjYbRx3S091fpunvuQtxLOTNJzxPlMwP7ts8fhlh5gK2J8LE5F27dRK9FoMAFwBLOMJaOR18zox33aEbBcnvCY4I6MqjjuFiMia8gcAlvB0gJAGzrBZ0L3vqaLNEBpv1luOQpuliScOcqXre2A34tEgnYAdN24PmJ8IbJmuEKvz5ObRwist5DbPmA9Ty7XnZ68hfRg4drv07GOXL7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IiOJrVFnr4zhlj8JpXz5IH3hUjJ+iOT8QmVy+Iws/4=;
 b=VXNbOpLI0K46hLqMKaABuU8cIWktxYx0F8KVMSh0kuFvBwyUjkRTFeBvualG7gXJUEE5UuXMd7SNLxfpB1ueq6CaYjukpu7NDRs8eELNO3J/9Bx/bcs7N+k4dWBCoj3mZtvx4/xlHsNHAfbImGASyhhmlzb+MUlX0qkkubNp1K/ffOccB76BjStyC2x89slSEUWUC0A4K0LxJ4zM+1llbaFQlyQi0CHw6od/FuYRTGJxgzkMKg/LIRqcOMrA3jGC+/kH4VlOMT4tI+L/NCK6HPz5rpu6Shd7kcogAMS4gLw61gSr7zcHaySS7IIv4x6IOXxFj4dB/U3FXnp7JoC4oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IiOJrVFnr4zhlj8JpXz5IH3hUjJ+iOT8QmVy+Iws/4=;
 b=FccyDkCcWw/tjbcql2IsQsZliKCbSkF6ls0uYJ3i26LG0WyBgdO/HiLegOmG5vRiSMu2XDAEqH41ehzVAyzVPMc7AGuPoeyVqfyGK3E0nUGOhOsnU5QPpDYtKZXhiePS17KeAzWlwhYvSsaMHnSkL/Zw/U8nSQGByPdsgdTV3LQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7775.eurprd04.prod.outlook.com (2603:10a6:102:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 03:13:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 03:13:39 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v4 0/3] clocksource: imx-sysctr: support i.MX95
Date: Mon, 05 Feb 2024 11:17:56 +0800
Message-Id: <20240205-imx-sysctr-v4-0-ca5a6e1552e7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGRTwGUC/23Myw6CMBCF4Vcxs7amzABFV76HcdGUQWbBJS1pI
 IR3t7BRE5fnJN+/QmAvHOB2WsFzlCBDn0Z+PoFrbf9iJXXagBpznWGhpJtVWIKbvCJbXa2uCiR
 TQgKj50bmI/Z4pt1KmAa/HO2I+/s3E1FpZYgwN9rVxvK9n8eLGzrYI5G+YfkDKUGihiud1UVD2
 Qdu2/YGv7At9NsAAAA=
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bai Ping <ping.bai@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707103086; l=1346;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=s9G+71tPkns3tJbaPqdwLtIcxDTfdPPhPBzYx1UNYcA=;
 b=Nk4lvIgIEwi2RhT65PML/BO4uk6udMYofZW9edusRAiirWIeqH1o+bNtJMA7CVvt+ldWhkLCa
 pUYa5iHx6GgALVSuGry4tIUHGPrnCuQUW15pk6MslcH0A/pm50LYJk3
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee43cdc-0b69-4b53-1400-08dc25f8734c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8nDitdvmxkBbUCKRgH4khpcvIFuPodg7tGBTcc/0/HxTV2o/h1JIYcHdsVrDlxs/x84w6SbOuXJhMW1T9gk6hSP028lLcDlkcTFkUlNsnw6R6TQp9Ps1OuMCuC429Wq+HBH2AH33jIvVJA56O+dQww1E5+mEF1tGraocjk4G/JRRUvSRvYVEYQIvNtKyj2sfDT5vPlOzQp/ATFmbmtLMzA9DgFp4rxPXgAg/gapSPxmpwJEUYLI9+3n8Mq9kawz+1XoUGnqwwpAlzWtptumiNyk2tJSt4AV/KgEocMt+BPdWzW+AmKtqNvJzOOC//+aKmUVLXji3PJg8EVokEH5AF7dAbarkL6jcT9IVk99rH9+9XBVcEcKo0N1EOyfbMSXkBvWcAnumPDMaVvkWQzK22RvYuQY5tRqAr8bx+6sCh+Snx8HXIWVjwuzpvRloVTG4BNiF9C7NFCOPEOfux19wfaGDtqUg0g3kWOfuGmue8MOa0SNbwt5ANt6yuGZyEoJzonXV0WaWGL1kgSRzG1Ze2bDY8b4tT+qCNKmyTFnVoc7W4jz+0BUfe39YdKu7o86FTkyyEOyYIFtb7c/Xus5Lre0j5M71LBzJb2aNyaX4S1nEluMrrUVc1ao+eA5OnFs1bRURh/1Ijz8t0wnkE0cnm2JdDMoyH/s6dn5VHN46ouM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6666004)(52116002)(6506007)(83380400001)(38100700002)(26005)(86362001)(41300700001)(4326008)(36756003)(8936002)(8676002)(9686003)(6512007)(921011)(478600001)(2906002)(966005)(6486002)(7416002)(5660300002)(66476007)(54906003)(316002)(66946007)(66556008)(38350700005)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejl2cXRRWUtLWDFnNWc5ampIN0hjeGdKSjhja29oakZPM3hpTTYrbjZldVkw?=
 =?utf-8?B?RTEvV0RCY1UyazNtSmZWT09YK1JrbkRuUytaMndsdUEyMXdvTGN1VmQ5Nmo4?=
 =?utf-8?B?NWZGcGpiUVZVZ2FqUlZETEpuMTUvQnJ1cVI5WjQ3bU1lRWltRVdpZFBYY1V2?=
 =?utf-8?B?YjdXNGt4aWJ2QTVycHlwTy9DMnRKUkh0M2RNM0xHNHFOSjNZYmxRSm1mWFQv?=
 =?utf-8?B?eldUZUY3NDB0dElKNittQkJ0OUVZYS9oTnk3OGhlbEhBOEcxT0RQdnFqYk5Y?=
 =?utf-8?B?MDh5QlVFSFZHYnRUYVJkVUhRMTlIcFBVUlAzR3RPSjFvVjhQWHBtZWZQUFIy?=
 =?utf-8?B?T0NoZHJJVUdEVm5JbEkwbVE4OG1FcEpqR21tUW8xclRIaEZMYVhrN1pidmRt?=
 =?utf-8?B?YVVQZnN2VE1IWDhaeTE1a0pjWkd0M21MdnJDZmdFcHJJTVI2YWpyakptYkxU?=
 =?utf-8?B?LzArUGRPbzJUaVZ5YWx4dUtnYmphN1JQTk9zNjQwaURsU29KeVI3U2pjU1gz?=
 =?utf-8?B?WElZUHZPVnNnMnh3VVJlblN4UDRFdkFBODVLY290REV5TExOcS8zMEpmWC9h?=
 =?utf-8?B?MmFVYnhlQlVVd3p4U1pQdDMzNWd3Tkx0S2cxYXVVeWVhVUdJT0pVYmt6a25U?=
 =?utf-8?B?Nkpsb25GSmE5dmwyL2pHeUhSaGd5SnQydm83azc0N0FuQjdPankrTEF4QUw2?=
 =?utf-8?B?a2FRTnJ1WWhPWGRQSU54MWpzODlFaUdhbEF0eWxDeE5KbFdiL0NqZDlmRnRl?=
 =?utf-8?B?WVpFT1lvRStOdGRES05WY1ZBdXlhZlRnVlBBQ1lTOUUyeHpiMnRsN0NQVExF?=
 =?utf-8?B?UHhCL1VHYXJ4emtUL1dRRURLdlFXTVYrWitGOElRK01SSWRSbWlVbEs2SE5Q?=
 =?utf-8?B?RDlqZmJaTjNkb2RrTVgwUXZEMFpBVExiV2IyeGx5ZDdZRS9rZUVTbUY3RmVD?=
 =?utf-8?B?UjhkNm5XMnVkMHRlZzBLQTBKeFltdGtLUE1Mc0JXeXg3S3MxbTg0QnY2SDZu?=
 =?utf-8?B?aDZvUEFBMFpWUUtkK2hKZ08wbFJzaCtrVzdFeGNvdWI5eGZWbG9ZdGg3cmIy?=
 =?utf-8?B?SmRMYjBlK2ttT2N0UldZbXBuRWgzelRQWk9PZmt4cVkyTEY5SzkyeTdkQjBR?=
 =?utf-8?B?QnVLS3pNd0N2N3krb2Fwd3Z2eTROZk90eEZxRTVweHd1blJibU9ldmR5Ry9V?=
 =?utf-8?B?RWZPSHhPYm1EU05ZNkxmTmhRaHg3Q1l0QzZLYnlxWmtOZnpFTkhON3RsYy83?=
 =?utf-8?B?bVdTZjJORllUUkxkMHNqRy9KOHB6UGcybkk2M1o4VHhzcStjSkVsTE9Fd0Nx?=
 =?utf-8?B?bWhIWVVuWTI3YTl4Y0k2LzJkQ2VtN3VoL3hxNFVOZkoraDdkKzF0dGp0bkE5?=
 =?utf-8?B?d2trTC9uZzRNT3dqTllzVjZ5VE0wY1ZhR045UExFQlFycHZ3Z3VPUjMzd3ZE?=
 =?utf-8?B?Mm16UFdwTzdFaVZtUUZhTy9qNFQ3bElLMjB2b21nVWkrSk5aaVdHcnNKODVW?=
 =?utf-8?B?ZVMzUEdyVG1sN2VOM09rcll5czRtRU1pNGJtM1hYWjBIYndWakFIaDdLTGFT?=
 =?utf-8?B?ZkxqOGN1cU1vU3E5UmpiU25CaFBZNUtldldkQlV0eDZ1VElwdW1VVkdjdWdx?=
 =?utf-8?B?TWp5NUFNNDdYaDFLTUdpamN1eVlLZmxacW1EbkpHZlQ2K1dITXpyenlIYjFk?=
 =?utf-8?B?YVRQS042UDBpNFR4QTI0RW0rcGN1Q2lWVXArZTRJL3BVZDRBeFNnNU1UTHFp?=
 =?utf-8?B?dUxsdDFWSzNqQkt1STM3RVU2TkVwNlJza2huRnlETHN4TkVhcHE4VEFyNjNV?=
 =?utf-8?B?L3E1UVVHblk3ZGJqMVdoSlB1NGVMWEhIKzd2NERHaGRaOGJWemFFTGZUYSsv?=
 =?utf-8?B?YWRRWVFvaktVM2JibTRFUzJIZDdLbjdBZWNDdGxxc2l1Z2hoZnBFTUZHdzFI?=
 =?utf-8?B?MjNwOCtBeCtFYmptSTB2U1N0Y3Y2RjZjR2Z0RlRheXpaNGE2MVplenYzRTBG?=
 =?utf-8?B?MXhqa0pxUzRhMy9vMk9YOUNVcFNMVTNxajdYb2tRZXlXczl0QSs4ZEFOYzl4?=
 =?utf-8?B?Y3M4ZkFFR2FSS2VPc2hYMTZkZjF6bjFXc2VFR1pvOGJwUTRMNkhUc3RIcERG?=
 =?utf-8?Q?0+DRkz3THAI9H0YvAH4ZPcSRx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee43cdc-0b69-4b53-1400-08dc25f8734c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 03:13:39.7475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5UoTZWQEJ0DlnmTFT1q+BQw1PKnAY1Lr1f/+eGXz0LCYXXsopLgRkpO6uxkYqCeMx0RSkyyPnrTYP2d5exG0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7775

i.MX95 System Counter module control register space is blocked
by SCMI firmware, so we use Read Register space to get the counter.

V2:
  - imx95 is not compatible with the existing hardware, so add a
    seperate entry for i.MX95 in dt-binding.
  - Per Marco's comments, the global variables was removed except
    to_sysctr. And add a new TIMER_OF_DECLARE entry for i.MX95

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v4:
- Add A-b in patch 1
- Include slab.h in patch 2 to fix kernel build failure for i386 compile
test.
- Link to v3: https://lore.kernel.org/r/20240126-imx-sysctr-v3-0-33fe801d5f31@nxp.com

Changes in v3:
- Drop items in patch 1 per Conor's comments
- Link to v2: https://lore.kernel.org/r/20240125-imx-sysctr-v2-0-7332470cd7ae@nxp.com

---
Peng Fan (3):
      dt-bindings: timer: nxp,sysctr-timer: support i.MX95
      clocksource/drivers/imx-sysctr: drop use global variables
      clocksource/drivers/imx-sysctr: support i.MX95

 .../bindings/timer/nxp,sysctr-timer.yaml           |   4 +-
 drivers/clocksource/timer-imx-sysctr.c             | 117 +++++++++++++++------
 2 files changed, 90 insertions(+), 31 deletions(-)
---
base-commit: 01af33cc9894b4489fb68fa35c40e9fe85df63dc
change-id: 20240125-imx-sysctr-3a89a0852376

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


