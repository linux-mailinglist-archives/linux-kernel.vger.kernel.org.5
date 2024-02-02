Return-Path: <linux-kernel+bounces-49271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77742846811
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4802C1F226DD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986BE179AD;
	Fri,  2 Feb 2024 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XW0nbITO"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD85317571;
	Fri,  2 Feb 2024 06:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706855443; cv=fail; b=qAHC6ksWVu0Ha90idJP3UvKQLO9yuOGl2Imx+4RKdY4NWQZo7AZEijEntX9PIQAFZ3utvdFCPvWTr1jwdmp8z/txphCGCvnWJQl+QS6f1lk91YQdnld/plzNTIXENsr9wNPgrZn8/07ZWofIKqHSaz8VIUGbRPH9cQfCoQ9ilUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706855443; c=relaxed/simple;
	bh=MViT3hkNnubhods/T2GXBOQrZGQGrJ8dq58t1MAnuj8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mlFuNTDIPs4EEexgFvBiEavKC/P4SvuqcOo7dsKIpOaslhRmj7HjKGx2aIaA5X4GvnIe2dgLzk57EoINRIvm0AsHsJG8zAxTEOgN0tOmJlGubE4emHulytbldVIS49Asz8AbB6bW6ZW9XyHHIHlX+hfw/NZyQY2nMZgF2kcUntY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XW0nbITO; arc=fail smtp.client-ip=40.107.7.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SI3sctGxh9rDZ1lxC6vCzagAT0x7mgfjWtSKq2fr1DfiNSvyEs4Dqslgkp/56BGeRJ4jwIUa0SG9DIeF3ztBGVOxHGh11ll42UcZ67KJS8S0uelFtEibFCFPI+DUvS3YrJNbQeSktKrEeEvCn5gKMBTQP3hjbfuJPkh1k/JNQ12p2/dIZrXUQqCM9IyKp7xABtKvybCQhbe9udWE+FqtBZgNlzWK1L3eXqoaioctZxPSvkaEi8iHyiQGS2XuscFRuRvd6w6WvJMzQKjTWh1nR3o+6tOm8zHw19ho2/q+rpYyCqZ9b0sQVeFgzLZKPNGIhup0pkKAQJL+LcUls3PdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIPmRhGYBZcC9nmdc3gAJL3q6sFDELDgVfbdQXGNaGM=;
 b=S6wms+knJHgr4mXFdQNIcI84KfAnT+IIb7eOFYZstt0h/BMmG+ibShgXUu0klaS49XRWZvhcnpzB+OTOGjmJgDdf1qslAqWBcwYEWFloRFRDaPI589SIM//VpI7Y9h0xpq8jKvJI5aItBDpZDUi/TNifKZ3sQGtTir7QwKgmIDi64axgv6B++f4gokLgPY3NpHsbsqdPl7t+GreieQHtHpd2My71Ui7kTsgKCvUT7iQgACBrdU/vS7GuuBBmM0mwmIMJPqvpMhcG6pkTDU/dI5c9+P1MGPqkc2Ii4KCpW8VxX6rnYxoD0+jJTmj3+Z9+IA2kwS7hSdicorIMH9WWFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIPmRhGYBZcC9nmdc3gAJL3q6sFDELDgVfbdQXGNaGM=;
 b=XW0nbITOUrGWvLXHMZzWyv7L7nCCQ+1XTOAlftg/KGq6tWRYcNGytJSR0m9XKV2CgHVERgyivPleNbWTgWscOMAEQCvsm/12YjzPBl5ET84CIPox6wfx3OIk9amid8iGlth2ebjOrjVwjhSG9T5q98oL+NwW+QBBR5l97XdFlrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 06:30:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 06:30:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 02 Feb 2024 14:34:41 +0800
Subject: [PATCH 3/5] firmware: arm_scmi: add initial support for i.MX MISC
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-imx95-bbm-misc-v1-3-3cb743020933@nxp.com>
References: <20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com>
In-Reply-To: <20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706855688; l=10438;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=tZxW+mINZL8afIXv/OhfnOalP2oB6/24XR+jpplh/t8=;
 b=xFDp/C3pFXPgK+VoEN28yQfJ34LalKuNZCQTiO5cSvfEEMKug30ZKgjXULxmcUK53cqULm0ny
 vOhlbc24tWUAEHfmTMTr4ZUSzSUFaCRFQqD+AON066jNIpAGdg0zXVM
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d53390-c4d5-42ec-c135-08dc23b877d3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JT8KgEXkPxIP1l6ylx2BraRpU6KPmqfr4ixZZ0TFLmCkG27x2p3ZMVv27cA2IEHmmYuASjXFF4BYGDKWsymIZTOlIe3CoAP4a76/V7CdQ1uElfwdALaNYpfmBdC+7XE/LWQr6I4noJXuGgM9AYqLhwMThFyyGl5u1nkb5tJEYhAjtZV+4yNKudkvub8qcLMggNmzXhxI9vyPCD7R66v1f4D43gWM9wnCRaOLsFvH3pXInx/PMNTww5DI4r4ZOaq5vDh2NmBu+Cpt4lFS8WgYrgQ6cndBMgSdMF1cEfr2z9v9UmxprnoEjB4wwy2Tuv0WmEaOY/2K+p+vV8vQx9CMnCgoaZ9VnzZanY1D1xyNXgZxhkFEwwF+cBOCIlUVBdgONgQinoegGv6ASugeH7i3j2qRXJfcS1ZaV1bQrEtzu9U8ssbRToMozkflB1fDAk5DvdMWwXJehK7Cw1Sr/7KS0v7cA3u+JufUZAnaxxDQG0eKVPgzvxn3JpEQBvj4Sv7s5DJIH4UY/HuyGN5Vf8N+IEh+g4dMFqOkUYDnXdRvV5SxGbyEgxo1ttTjCe1OM6xN6k8Dcdc1xtElNVW3rCCty3mRIgSUqU8GxClOD9Ehgw5+MpLTHcYXGAybu2UmMf+RoqQXdcZFA+DXyxKyoLE36A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(9686003)(6512007)(6666004)(6506007)(52116002)(8936002)(921011)(4326008)(7416002)(2906002)(5660300002)(316002)(8676002)(66476007)(86362001)(66556008)(66946007)(38350700005)(26005)(36756003)(110136005)(41300700001)(6486002)(478600001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDZneldTbVZkVm5JU1dHZXEwTkVhakFZMUJmczhKYVR3U2N6MWtDTVRMTXRn?=
 =?utf-8?B?YUE3eGFLbFIzakVyT3NJaEhaWGZzNnU1STlhL2NUbGdMaE9Zay84ditqSTNQ?=
 =?utf-8?B?c3h1OXhKZHVPbW04dnRqWW1HdVBQempqRFhJZEFKMnpWU0EzTVlDR0lJbXFE?=
 =?utf-8?B?WTVGYU5NVGZtVy9wQXFDOHhzWm1QbmwrckVSaHljcXhtNTIwZmRRanVENW90?=
 =?utf-8?B?amdKR2IvMW83Y0FtVG0vQ2kvdEZnRm1VTDAyZjhNSFNwSFFsei83Wnc3eDRy?=
 =?utf-8?B?ZkN5VG80ZnpqZjBhVU95NTdzTjFxcmNsTTE2VTdMS0NIRzVXTk1LWFQ0cm1X?=
 =?utf-8?B?dmF2UzNLS0xDbzBIc21JQm5VWlZ2c2F3b0VMQWxZZVFjVUxEL2hCT21tZU1j?=
 =?utf-8?B?bTY0ZXNqT1RpajJrZ0RQbWQ4NGg0WWJDSXoxQVNHYXJZZFZPRkVTRHo3NTVZ?=
 =?utf-8?B?WUUrcjgrNEZzc0JtblZ4bWxqQmdNT2N6OWhIRDd2eFY1YXpiM3NnbmJPTm91?=
 =?utf-8?B?NE9qYU9IeFhMbTh1L0UyZGs2MW1IWmtTTW9CTVh0VU5jeWFMMHRSUng4ejk3?=
 =?utf-8?B?VGY5cVlKYWE3bitvLzR3OU84MWhYNkJWQnl2REhBZHRTaG5EOFQveVFKOEda?=
 =?utf-8?B?UjJjWmNicE92QVBzS0FFYkYwTTBVS0ExNmRMZFdVRHpnN0pjMUVLRVNMbCsv?=
 =?utf-8?B?dVZLaGx4RGtoOEdSVGpZTGdMZVVxVkY1VzBkZjc5VjRTamRBL1RQVkg3NUIy?=
 =?utf-8?B?VzlVZG5sZXpuZ2M0SzZmMTc2c0FxRnZoVlN6akJZNmd1d0MwZCs5N2Q2VmVh?=
 =?utf-8?B?NDZ3Ty9jVFJnNCtPSWFQMWZyV0NKckQ5TGgxa0N1UEJNOFgzUk1LSTFnT1Ey?=
 =?utf-8?B?V3h3SDVGSlBmUjJYTm40ZG1EKzNMR1pVd1R6TmVXeDBSSnkrWE9DUWFQN00w?=
 =?utf-8?B?TlA2ZnlqMG9aQXVMb3hxVHhyd2hjTzJ6SUVYZlpiOFFyeTRyRVUwNGpPKytl?=
 =?utf-8?B?eDZVaUVqMjQyVHFVYk1ZWVdsTXZIQTZ2akZmcDZXYUJkOXpYSE9Ya2V2TnE2?=
 =?utf-8?B?TysxdHdtTnlqZFNLaGZDcGhxVXdIZ2xocnNVd0hIeEg3elljem5JaGJFeG5X?=
 =?utf-8?B?NGF1d2RudE5odHZNcDdkK3JTQklYVTZIRG5pM3NZYVFmS1hBa2o1cTM5VG0y?=
 =?utf-8?B?ZmxEWG1Xb3RKZ0tRMUJPUE1vTzR1aDVoL3ptdG9FZHY2VTRZS0NxUDBEV3Nu?=
 =?utf-8?B?TVlYN3kzWXdJRS9LY3VBSDhUWXV0bVEzcXBBVFBQUmVJZUZ0bDIyMXhTQndT?=
 =?utf-8?B?SDd6c3pUampxMkU2cW5wZzIzeGJTa0FZUjAzRU9zU1hteEo2bVh2eWkvU2Js?=
 =?utf-8?B?cW1ma1lYem9lQ2dKTTNkV0hjWldrOHlxRzVsT2d3RUdCUm9LRGZJQnIydWls?=
 =?utf-8?B?UUxsVzB1K2pDLzQvZ0tRd2pvT2l6T1hvcXhvWFh1Y0NRaHR2NE11VlZYajA0?=
 =?utf-8?B?TmNSZUpiVXdGRUxLRFRNdlhmUUpBVE1PbFhyWk42WmZLakwwaU05L283NUha?=
 =?utf-8?B?aDYxbnlDOW8rakNUYXQrZmFrQVBCM0dFcHFiYmhsQkFjWjc0RmFZWnZRb0Zx?=
 =?utf-8?B?K3VmMThpdWEwYk1LdDE3MXVZU280WjNhZCs0VWlubGM0cEhzWUM0V3hoUUFh?=
 =?utf-8?B?T1RjWVhIL3JzYnVUYnp2TXNSZnRTbUhaWS8zZlB3YWdibkJmaWRySXB5SXhX?=
 =?utf-8?B?SHp5K2lEWlltdU1QTWpOdTJxUzlHcSsyOSs3WEZNQk5rdW92OWhsRmcyZFFy?=
 =?utf-8?B?dkV5V1haaW4vWmdmL1hZNEtBeFUwN1NqZ1JZNkhHUzlYcnN1N1MraHpxdzlk?=
 =?utf-8?B?cmVxcEpESjRtY1JDYXJYK2p2OHU0SGkzaTBRQWZxZDRqaTNnMzBISGg2ZlB6?=
 =?utf-8?B?YVJiVEQzVEw1dk02NitnMG51eTVVMVZjQmcvRi9wYUJYZG9sb28rbGp3MDdh?=
 =?utf-8?B?NVF2U0RPZnNHV2xNRUx3SG9YM092a3duRksxYmUwbEZERDBiV29lY2NzVEZm?=
 =?utf-8?B?RlI5b1IrbWUvSUV6cytQNllaSWJiWkIwajFLTE8wa0JiM05hcy83ZGMvQlZm?=
 =?utf-8?Q?s0ZwsZJSRkKeBtneAZAHi/es9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d53390-c4d5-42ec-c135-08dc23b877d3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 06:30:37.2111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pM8Ua20QLUpgZbfYKvI+futhA7/qAusPTTqIDy359ri9Fu5xy8hhxIyCxEjoKG9lHVhvWHlz6jWDbRbrNUg/bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8604

From: Peng Fan <peng.fan@nxp.com>

The i.MX MISC protocol is for misc settings, such as gpio expander
wakeup.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/Kconfig       |  10 ++
 drivers/firmware/arm_scmi/Makefile      |   1 +
 drivers/firmware/arm_scmi/imx-sm-misc.c | 289 ++++++++++++++++++++++++++++++++
 include/linux/scmi_nxp_protocol.h       |  17 ++
 4 files changed, 317 insertions(+)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 56d11c9d9f47..bfeae92f6420 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -191,3 +191,13 @@ config IMX_SCMI_BBM_EXT
 	  and BUTTON.
 
 	  This driver can also be built as a module.
+
+config IMX_SCMI_MISC_EXT
+	tristate "i.MX SCMI MISC EXTENSION"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y if ARCH_MXC
+	help
+	  This enables i.MX System MISC control logic such as gpio expander
+	  wakeup
+
+	  This driver can also be built as a module.
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 327687acf857..a23fde721222 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -12,6 +12,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
 scmi-protocols-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
+scmi-protocols-$(CONFIG_IMX_SCMI_MISC_EXT) += imx-sm-misc.o
 scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
diff --git a/drivers/firmware/arm_scmi/imx-sm-misc.c b/drivers/firmware/arm_scmi/imx-sm-misc.c
new file mode 100644
index 000000000000..7805d41cca4d
--- /dev/null
+++ b/drivers/firmware/arm_scmi/imx-sm-misc.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System control and Management Interface (SCMI) NXP MISC Protocol
+ *
+ * Copyright 2024 NXP
+ */
+
+#define pr_fmt(fmt) "SCMI Notifications MISC - " fmt
+
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_nxp_protocol.h>
+
+#include "protocols.h"
+#include "notify.h"
+
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x0
+
+enum scmi_imx_misc_protocol_cmd {
+	SCMI_IMX_MISC_CTRL_SET	= 0x3,
+	SCMI_IMX_MISC_CTRL_GET	= 0x4,
+	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
+};
+
+struct scmi_imx_misc_info {
+	u32 version;
+	u32 nr_ctrl;
+	u32 nr_reason;
+};
+
+struct scmi_msg_imx_misc_protocol_attributes {
+	__le32 attributes;
+};
+
+#define GET_REASONS_NR(x)	le32_get_bits((x), GENMASK(23, 16))
+#define GET_CTRLS_NR(x)		le32_get_bits((x), GENMASK(15, 0))
+
+struct scmi_imx_misc_ctrl_set_in {
+	__le32 id;
+	__le32 num;
+	__le32 value[MISC_MAX_VAL];
+};
+
+struct scmi_imx_misc_ctrl_notify_in {
+	__le32 ctrl_id;
+	__le32 flags;
+};
+
+struct scmi_imx_misc_ctrl_notify_payld {
+	__le32 ctrl_id;
+	__le32 flags;
+};
+
+struct scmi_imx_misc_ctrl_get_out {
+	__le32 num;
+	__le32 val[MISC_MAX_VAL];
+};
+
+static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
+					struct scmi_imx_misc_info *mi)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_imx_misc_protocol_attributes *attr;
+
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
+				      sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		mi->nr_ctrl = GET_CTRLS_NR(attr->attributes);
+		mi->nr_reason = GET_REASONS_NR(attr->attributes);
+		dev_info(ph->dev, "i.MX MISC NUM CTRL: %d, NUM Reason: %d\n",
+			 mi->nr_ctrl, mi->nr_reason);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_misc_ctrl_notify(const struct scmi_protocol_handle *ph,
+				     u32 ctrl_id, u32 flags)
+{
+	struct scmi_imx_misc_info *mi = ph->get_priv(ph);
+	struct scmi_imx_misc_ctrl_notify_in *in;
+	struct scmi_xfer *t;
+	int ret;
+
+	if (ctrl_id >= mi->nr_ctrl)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_NOTIFY,
+				      sizeof(*in), 0, &t);
+	if (ret)
+		return ret;
+
+	in = t->tx.buf;
+	in->ctrl_id = cpu_to_le32(ctrl_id);
+	in->flags = cpu_to_le32(flags);
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int
+scmi_imx_misc_ctrl_set_notify_enabled(const struct scmi_protocol_handle *ph,
+				      u8 evt_id, u32 src_id, bool enable)
+{
+	int ret;
+
+	ret = scmi_imx_misc_ctrl_notify(ph, src_id, enable ? evt_id : 0);
+	if (ret) {
+		dev_err(ph->dev, "FAIL_ENABLED - evt[%X] src[%d] - ret:%d\n",
+			evt_id, src_id, ret);
+	}
+
+	return ret;
+}
+
+static int
+scmi_imx_misc_ctrl_get_num_sources(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_imx_misc_info *mi = ph->get_priv(ph);
+
+	return mi->nr_ctrl;
+}
+
+static void *
+scmi_imx_misc_ctrl_fill_custom_report(const struct scmi_protocol_handle *ph,
+				      u8 evt_id, ktime_t timestamp,
+				      const void *payld, size_t payld_sz,
+				      void *report, u32 *src_id)
+{
+	const struct scmi_imx_misc_ctrl_notify_payld *p = payld;
+	struct scmi_imx_misc_ctrl_notify_report *r = report;
+
+	if (sizeof(*p) != payld_sz)
+		return NULL;
+
+	r->timestamp = timestamp;
+	r->ctrl_id = p->ctrl_id;
+	r->flags = p->flags;
+	if (src_id)
+		*src_id = r->ctrl_id;
+	dev_dbg(ph->dev, "%s: ctrl_id: %d flags: %d\n", __func__, r->ctrl_id, r->flags);
+
+	return r;
+}
+
+static const struct scmi_event_ops scmi_imx_misc_event_ops = {
+	.get_num_sources = scmi_imx_misc_ctrl_get_num_sources,
+	.set_notify_enabled = scmi_imx_misc_ctrl_set_notify_enabled,
+	.fill_custom_report = scmi_imx_misc_ctrl_fill_custom_report,
+};
+
+static const struct scmi_event scmi_imx_misc_events[] = {
+	{
+		.id = SCMI_EVENT_IMX_MISC_CONTROL_DISABLED,
+		.max_payld_sz = sizeof(struct scmi_imx_misc_ctrl_notify_payld),
+		.max_report_sz = sizeof(struct scmi_imx_misc_ctrl_notify_report),
+	},
+	{
+		.id = SCMI_EVENT_IMX_MISC_CONTROL_FALLING_EDGE,
+		.max_payld_sz = sizeof(struct scmi_imx_misc_ctrl_notify_payld),
+		.max_report_sz = sizeof(struct scmi_imx_misc_ctrl_notify_report),
+	},
+	{
+		.id = SCMI_EVENT_IMX_MISC_CONTROL_RISING_EDGE,
+		.max_payld_sz = sizeof(struct scmi_imx_misc_ctrl_notify_payld),
+		.max_report_sz = sizeof(struct scmi_imx_misc_ctrl_notify_report),
+	}
+};
+
+static struct scmi_protocol_events scmi_imx_misc_protocol_events = {
+	.queue_sz = SCMI_PROTO_QUEUE_SZ,
+	.ops = &scmi_imx_misc_event_ops,
+	.evts = scmi_imx_misc_events,
+	.num_events = ARRAY_SIZE(scmi_imx_misc_events),
+};
+
+static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_imx_misc_info *minfo;
+	u32 version;
+	int ret;
+
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_info(ph->dev, "NXP SM MISC Version %d.%d\n",
+		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	minfo = devm_kzalloc(ph->dev, sizeof(*minfo), GFP_KERNEL);
+	if (!minfo)
+		return -ENOMEM;
+
+	ret = scmi_imx_misc_attributes_get(ph, minfo);
+	if (ret)
+		return ret;
+
+	return ph->set_priv(ph, minfo, version);
+}
+
+static int scmi_imx_misc_ctrl_get(const struct scmi_protocol_handle *ph,
+				  u32 ctrl_id, u32 *num, u32 *val)
+{
+	struct scmi_imx_misc_info *mi = ph->get_priv(ph);
+	struct scmi_imx_misc_ctrl_get_out *out;
+	struct scmi_xfer *t;
+	int ret, i;
+
+	if (ctrl_id >= mi->nr_ctrl)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_GET, sizeof(u32),
+				      sizeof(*out), &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(ctrl_id, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		*num = le32_to_cpu(out->num);
+		for (i = 0; i < *num; i++)
+			val[i] = le32_to_cpu(out->val[i]);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_misc_ctrl_set(const struct scmi_protocol_handle *ph,
+				  u32 ctrl_id, u32 num, u32 *val)
+{
+	struct scmi_imx_misc_info *mi = ph->get_priv(ph);
+	struct scmi_imx_misc_ctrl_set_in *in;
+	struct scmi_xfer *t;
+	int ret, i;
+
+	if (ctrl_id >= mi->nr_ctrl)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_SET, sizeof(*in),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	in = t->tx.buf;
+	in->id = cpu_to_le32(ctrl_id);
+	in->num = cpu_to_le32(num);
+	for (i = 0; i < num; i++)
+		in->value[i] = cpu_to_le32(val[i]);
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
+	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
+	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
+};
+
+static const struct scmi_protocol scmi_imx_misc = {
+	.id = SCMI_PROTOCOL_IMX_MISC,
+	.owner = THIS_MODULE,
+	.instance_init = &scmi_imx_misc_protocol_init,
+	.ops = &scmi_imx_misc_proto_ops,
+	.events = &scmi_imx_misc_protocol_events,
+};
+
+module_scmi_protocol(scmi_imx_misc);
diff --git a/include/linux/scmi_nxp_protocol.h b/include/linux/scmi_nxp_protocol.h
index a2077e1ef5d8..45415a6ff845 100644
--- a/include/linux/scmi_nxp_protocol.h
+++ b/include/linux/scmi_nxp_protocol.h
@@ -13,8 +13,14 @@
 #include <linux/notifier.h>
 #include <linux/types.h>
 
+#define SCMI_PAYLOAD_LEN	100
+
+#define SCMI_ARRAY(X, Y)	((SCMI_PAYLOAD_LEN - (X)) / sizeof(Y))
+#define MISC_MAX_VAL		SCMI_ARRAY(8, uint32_t)
+
 enum scmi_nxp_protocol {
 	SCMI_PROTOCOL_IMX_BBM = 0x81,
+	SCMI_PROTOCOL_IMX_MISC = 0x84,
 };
 
 struct scmi_imx_bbm_proto_ops {
@@ -47,4 +53,15 @@ struct scmi_imx_bbm_notif_report {
 	unsigned int		rtc_id;
 	unsigned int		rtc_evt;
 };
+
+struct scmi_imx_misc_ctrl_notify_report {
+	ktime_t			timestamp;
+	unsigned int		ctrl_id;
+	unsigned int		flags;
+};
+
+struct scmi_imx_misc_proto_ops {
+	int (*misc_ctrl_set)(const struct scmi_protocol_handle *ph, u32 id, u32 num, u32 *val);
+	int (*misc_ctrl_get)(const struct scmi_protocol_handle *ph, u32 id, u32 *num, u32 *val);
+};
 #endif

-- 
2.37.1


