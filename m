Return-Path: <linux-kernel+bounces-39684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C470483D49E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E367284565
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17571947F;
	Fri, 26 Jan 2024 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eVRiniwI"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2042.outbound.protection.outlook.com [40.107.241.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2052125CD;
	Fri, 26 Jan 2024 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706252706; cv=fail; b=C4TJGPP/WclasixVUrPvPKooRGcdpMonrdxZ5o9KKMlUJA0I5vcnPWp8hnVS/CH5+vZm3x8HY2ta19FyAayqtguvbUMR5twO1z9+7SNeqmxMmokMpzCqYa8mkjdEIOpuyBTpcrZ92kOzCFKTPHdmS2GB+619pMG5RLTmwvC9mr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706252706; c=relaxed/simple;
	bh=gk/Qm+J25QZpiOBaQCs1blGppZFXm/yY+X9O04PzWWI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=pkPWdUEmYM+6gTkJ/Wy3r17aISdkqRZVcyBIDFQ3NuvAzAR1RQAk2eTSqMzs6ty3hdgt5R+CpIGxvmiFhZIEzAmtNfNXhDOJY9OtJ3x4Zu0USSRFESlPqpZIIl+G/stgPqtmsY0j5ckYUz2nMp9iv5hiRPS1np6T/JLncjH+iJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eVRiniwI; arc=fail smtp.client-ip=40.107.241.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxNtO+w7PeuTpOmvMpeEsoxk2FepC1ctezvnhebXV/YVpPVYJCtqq5fHRKXOMaGIr3R4lZRxCQsAaX9M/HvQ8AnaeQZ+5CfuL9QqTDsNm1blzCpRQZ+t8+ZeAht8JRFZ+EGPTtZydUvh2UQBL0LYfMWg4fFt5IAxYNp04m4wwcGruYmXkjQOvk+Pb5SUTUw6vImeTQLA0MnE+QMD5O6sr82PCwFPcz9540EtpBaDT8z4iZHKXVx/Mvrl01Ynh08jgCnfLW8AVgktg8llBP8qzwgrUX48VqBRM16wywxDcSGljPebd0CF1cNGyR7okuyDtHw8lZ3fdlRginboznjZdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAaNJ0ln9XVjZhG93Q9HTLH5Y9U52JXER+ZsVgo/Vs0=;
 b=c1qzMj4Io0O/+tpOJ08AcNK6zW33duZ+TM7bXMh/uXjPqHUA52xl0J9lZUh2jmhsyfjm9btRE9Tws6q/153TY+/Z9vjEPPRFdSH3tcfRC/VeWMa1uCYlsDGyYawl68sTa6BoRHOuQDSeuvyXo3MKjK/YykyHBAYyYXgq6EwaxDtsoCXBW0xB7lQhJwSRaLcQDnsjgDz4nkUHAfG8wJvG/1/DjC9VN66NGqXlS/stVMbQvnNvIJd8oEIMxS2zYdpHl63dGbbeU6UZHNcm/DrU4oTNnKeGBnT8c+bHHzmf+mL/PMOub4Nb2djIXUtW80o/feMI/JGrNNtodAkdsXIX+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAaNJ0ln9XVjZhG93Q9HTLH5Y9U52JXER+ZsVgo/Vs0=;
 b=eVRiniwIzE0M+wGx1RCt7FpmAIrsbEWd06qx3Ler716GkCRl4NropDHf89/Ad0Uz/qfgViGC/J64wM84bIz5DpsTFUR1WM7gut1F0RRP6vdb/+LjPIhndr1r6kCGOAg95Ub//byevI+mAcKALF4CsqkP2JcpUt6vzyrc66Y9TjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB9825.eurprd04.prod.outlook.com (2603:10a6:20b:672::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 07:05:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 07:04:59 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 0/3] clocksource: imx-sysctr: support i.MX95
Date: Fri, 26 Jan 2024 15:09:17 +0800
Message-Id: <20240126-imx-sysctr-v3-0-33fe801d5f31@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ1as2UC/23MQQ6DIBCF4auYWZeGDlqsq96jcUGQ1lkIhjEEY
 7h7qesu/5e87wB2kRzD0BwQXSKm4GuoSwN2Nv7jBE21ASW28oadoCUL3tluUSjTP4zsO1T6DvW
 wRvemfGKvsfZMvIW4n3bC3/qXSSik0Ephq6WdtHFPn9erDQuMpZQvfoFemaIAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706252968; l=1138;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=gk/Qm+J25QZpiOBaQCs1blGppZFXm/yY+X9O04PzWWI=;
 b=SZLBC/Q+Ol2cyTxRw7e01fhLSNjLPla9SPl5Ps1zCZPXnRiXRjW6xlJ2sF5tFBcvuGqqU7hb9
 MNJ+9D4VMDHDYLHLD/z7ECai0xkgrCL2L543bJgZ/Pt+R6uerwKOAX0
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
X-MS-Office365-Filtering-Correlation-Id: 89ce91c5-213b-4636-66f8-08dc1e3d1c58
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hz5zeitsMO0M7SYTdb3jebiT2efMMWy9OHzFkmh4eegbyIPuA6+HjhCGAqr1/iJdrSmkXQi4l9LLKpZJJJBEM/19wWBmiyqpYSPyJJ4+CvSsF/atwuWEzuwLD4mgtTP+MLptnjqQuhcg5jyMCi0aplc69AEmt+JA2evx9DE0d0aIiu9dVvddgl5qn2vO7DT4h/YZCfqH6va1ZatxuxgOyHvQ4Ve86kYEnkyplsPK+AG3f+fP8BSpFHA42aRCV3IlZdM0oz90lR10kqw/yYuZvhQtBfQ8eVuAbcj8l1A0LsJfXH6hR3sUrZfs/+vcCg09cqU6RQZYfYzVaClajFKnBEtU2mSNo2yjZP7eZM7jyC8cI2vt8azDwpZaFPgof7/j8eYPwy7XEhDy498Bo+wlJAegoTNoTmyBoT1AMd0lfkzbG/oT6aMCJUBLT5gJmulYvicWbYKk57gbDQR3+ZZb7ygqP4MVPzrOkVDNyCO7d6YzgLiI1LRgDBhLuiKqiKXKxM2M8LcjHuZtnrgp+Id7xcmQCqVewPFvsWyAddKMIQBTiFReF3Obx5Okr13gy2GB5qKs4rhgQnL9PilUzyKGiqaanf5aYraybjDjBBUsmjchiy5RRXQ1I8IDQv6LtHhc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(921011)(110136005)(36756003)(86362001)(41300700001)(38350700005)(38100700002)(26005)(9686003)(6512007)(966005)(6486002)(52116002)(6506007)(2906002)(478600001)(66946007)(316002)(6666004)(66476007)(66556008)(5660300002)(8676002)(4326008)(7416002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2E2UVVOOHRSVmZ1Y3R2TndzL0ZsWG9PQ0Q4RkVFNmt0T2ZpbU95L0h2Wjc0?=
 =?utf-8?B?bHI2eFFMdVVob0U3aHRrcnJpU0N0VHhSWlJ0b01NaUhTL0xSYzhJSk9zb1li?=
 =?utf-8?B?ZHltbDArNS9TeWp0RGZlTjV2Y3NQbVh2cnNLTE1rL1h2bS9sM0tIZnNvODlv?=
 =?utf-8?B?VnVKSHNKeXIyUXozTnJuVXN2NTBKenIySlNnaS8zUWRrS3FFV00zNUM1MnJv?=
 =?utf-8?B?NHdPMHE0SU9mYjdDVG1lSHdpN0pLOEJyMG52Ly94NUJnT3NFQytCRDVId3VR?=
 =?utf-8?B?S1JHWFU0VUFRazR5Wkl4Qk1nZWtPbTN1Z09WRXNUNHlyWng2KzErS2ZzZjZU?=
 =?utf-8?B?Tjc2Z05kS2VCWWYxd0ZTajFpcG1FMkswTHVhZ0lmV0UvZ3RRQmtCZlJPbGFN?=
 =?utf-8?B?WWJIa0l5OXE0bFFld0ZZaUpDVDI5akRkZHZDSXR1RlpmSFZLRFhVYmNKdUU0?=
 =?utf-8?B?c21NdGpHeVhlSXJ0d3hoblFXTkpPaldwYkMwVGNzamtJQm5VZnRNaTBUYzFr?=
 =?utf-8?B?MStkSGRSSVptVmZvQTAzNS90WXZjM0tsY1FOb0Jkb25FKzNNb1YwTFBabWxq?=
 =?utf-8?B?MTR5OWNmWU82bDRPc0FDRGg3RlBSdUJ5cFpiMW56NFlBbmlKaFI0bytnS3FO?=
 =?utf-8?B?MHJ3QzUxMWVwNmN5cFp1T09POWZSYUVPd21IMVk4dmVlbTBkcCtYZjJDcDdY?=
 =?utf-8?B?OXgwQTM2WU12YklnMmNWQ0ZLUkNPNGszeWxMRWVFRU5mSHR5dDR1aStjd2Fq?=
 =?utf-8?B?QXZNeVBvZWU4bDdtM0ZDTGxRcjlQOXcxRmlxajhNMGZQMXJ1N0F3NTQ1c3hG?=
 =?utf-8?B?YWczK2hENmNiWlZGNFNUeW1Xc3VranZubmdEM1FrR1E3djhWYlpreG9aT1VQ?=
 =?utf-8?B?eURlay9MVjNBK1hpdW9SNjBzcjZtWHFzSnJZQmFodlhKNDAyZ1puUk9oQU1H?=
 =?utf-8?B?dGpKNGxreEF5Slo1aFlVV2k2TFJtcDFYTStLcCtNSHNndlZ1KzNMemJXQ3dm?=
 =?utf-8?B?bEtKTVdLOERxQ2pJMFJ5Q3ZMU3Q3VVZIbkNzVXFaeGRxVHhZeDc3SlVXR21h?=
 =?utf-8?B?TWJRUmRFRk5nVUNxVUFaZVdZYTc1d3l1U2lTYUlhVFFGb21aQzNpUXgrSEt4?=
 =?utf-8?B?RlJpbjJyUXVXdEg3UUgzcjlWRldJb2VlWEl5aHRpWjZKeGRjbXJvSVpyZVNq?=
 =?utf-8?B?RFpCZEVSSDFWblRqSlJWSXNhM05TaDQ5b0hsN2hCdmdGMHRodHpvSmFsc3dF?=
 =?utf-8?B?WGRaR1hUMCttaTM1RlVpUm5KaU5MSnBhbEZRNm1jd0c1M3JqSzFvbGZFZE5Z?=
 =?utf-8?B?U3k3NFl4K0ZtTWdiL1NLbUNtQm50bkVJL0h2bFB3VjBGUkFaeXNKMlg1Z1pJ?=
 =?utf-8?B?ck5nZGVESW55aUlweXdNWVkwdzEyKzBHS2ZZNVpYNkNEc0NFNFAyNDRHcnpQ?=
 =?utf-8?B?M2lPYnlXR21YSmJ5MmZTMFcweDZOMHdaRnEyUUdFSHRBUFV4cC9ZbUh5dENW?=
 =?utf-8?B?MkdmT2k3SFh4WG5aQklGZ3lIZ0E4NXhCZFJ2UnprUzhRdHBGREdiQjYybXpo?=
 =?utf-8?B?M1NxNVdLRkFrVFhkNkJlVzVkd1BZZVFPZFVwZUtyY25LdThSUjl6YlpLQkxm?=
 =?utf-8?B?V0YvbkhhOGZIbTVXY2o4SElTR2hnY3VlNzI2U295K2phMjVPNlIxakFsdHRj?=
 =?utf-8?B?K0NEUlc1MEdiME1xUFVTU21BK3FWNFNmcUdsS1BlVGFOT0FjY2ZFdy9CbDRa?=
 =?utf-8?B?MnZpdkNkMkFycTh4Z0tKejFlUHdQRTM4STZ3di9la1E5SjNxNXh0KzQ4QUlt?=
 =?utf-8?B?RWVrdFBINTN5UkJnMUJQY2xmeUx2UEhwSFNscStwcHdkUVowZ1pLOTJ0UTFH?=
 =?utf-8?B?dHN1Q0tXcmlZNlB3bGRLeURGT0p2N3RMaFdaSjcySXZYd0lUcWVyQ28wUGJv?=
 =?utf-8?B?MHFHV3ZVUEV0S1BwT0Z0ZWt5b3BGTS9COElPMVlqRmg4WkJwbk1WOGtwVXNX?=
 =?utf-8?B?V1B1eUNXNmlMMEZVbTFoU1pITUppWGduTUdEMUs3VVBJKys3YWtCRmN6U2Iw?=
 =?utf-8?B?WVQzSlRYMWN5bElqUFBCWEtJNVIwRDg4VUpGUVBDTjBzTmNmZFBXa1UrSVh1?=
 =?utf-8?Q?K1UZhBJ11vgZ7/zIVW2yfEAva?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ce91c5-213b-4636-66f8-08dc1e3d1c58
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 07:04:59.9083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kGptGqzSzbjtkFIACJWEHVf9MqLuyEiWhJfihhZMEjlXzw/ZMC4qAq+nHQ4tu+jPKTJKbA/FqgLRse/OtkJzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9825

i.MX95 System Counter module control register space is blocked
by SCMI firmware, so we use Read Register space to get the counter.

V2:
  - imx95 is not compatible with the existing hardware, so add a
    seperate entry for i.MX95 in dt-binding.
  - Per Marco's comments, the global variables was removed except
    to_sysctr. And add a new TIMER_OF_DECLARE entry for i.MX95

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Drop items in patch 1 per Conor's comments
- Link to v2: https://lore.kernel.org/r/20240125-imx-sysctr-v2-0-7332470cd7ae@nxp.com

---
Peng Fan (3):
      dt-bindings: timer: nxp,sysctr-timer: support i.MX95
      clocksource/drivers/imx-sysctr: drop use global variables
      clocksource/drivers/imx-sysctr: support i.MX95

 .../bindings/timer/nxp,sysctr-timer.yaml           |   4 +-
 drivers/clocksource/timer-imx-sysctr.c             | 116 +++++++++++++++------
 2 files changed, 89 insertions(+), 31 deletions(-)
---
base-commit: 01af33cc9894b4489fb68fa35c40e9fe85df63dc
change-id: 20240125-imx-sysctr-3a89a0852376

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


