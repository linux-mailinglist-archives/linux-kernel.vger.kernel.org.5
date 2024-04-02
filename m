Return-Path: <linux-kernel+bounces-127285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B0B894939
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0FD1C22419
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D85317582;
	Tue,  2 Apr 2024 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JiKmC5BU"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2123.outbound.protection.outlook.com [40.107.22.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150AE567;
	Tue,  2 Apr 2024 02:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024083; cv=fail; b=MfO+wV88bjRyOEKH24DmSM28nAUqMQR/DW5HopqA6NFGwuzlFrbQl1zXOgc7ly6BV2kBYdPmb8oGOyCOeurUNeioAvDrXtbc4rv1bWePpidHOLdU4p4Lp8dd+JIgC5LgDR6ix35zSa2kPUqfFyZg3cpVUuxBSW086XbMey/aOQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024083; c=relaxed/simple;
	bh=6J/2U3MBcgwTOb7JaaRY5Ac5QLAoKng0CNnjvTWqLu8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aq2l8Q9X2Z5hsEE1qFS9e0qDMXJx3cL6nWmVtApK2tlGefxXgK7u+fYTAqnh2Cra2NkrhUSBMxXbvdrhYthEd0IzdasGycyn2E2678nMhLwEmm81mGCCf9Uw1cCeXniMHpesVy/IqzIWxAJJARAUXfVZgpjkymA8Hc+5QcGA3lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JiKmC5BU; arc=fail smtp.client-ip=40.107.22.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoVaPyIvQsKkKVQdMbyieEw/oVpcDd8aeZUD9c+G8DtkHYrZwIU5zZQey3lZf1rL7NdU0jEC2NStu96FKSoczof+ZKjeKPTXkJEt+VXh6/MRJdFOnQuFYG70Kr3A4kwFOP/9Okpwby7qAzbxZ2aRpCDoYu2lgUr8DxHem913/6tWmhXhMXF/I2AKUngqre8TkoUV4bb1XBoY2FboViy73L7csFdYq0S9Coh+99K8JXK+3StfP7rg5oEciAQo8rSIBaCqwfvHiZDry3icT0/TpcNKs9I9YcJxkUVSHNbX272PbOCkPi7jAXsqI3xpUNrKzZGN35WNQOIWzxyXEp6IuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulWCSZyziQTxWvaZEW0oMbGrfl0h+XL8SpBOOdVk7y0=;
 b=aZhQ09xg+Lzdyu3QnG6U3jssZ59R0bTbuWxFE5iuf7Nn/sxWzTfklces38YHLSkOEJReuVMH/8OZ7eVDBmsDbNrNyiBZqqH8B9J1apmHW81PZagzEJ3LZBj3gFha9lJKMpcyl8za+4WhpIH2/E/zcES16aDX40Nh5awbTTrjttQSDOXlKr0j0/oR7xjtFqi5owkGNOebXs4NyGBfHAVf+iMoFaoTnhWNmAIUNOpqQXJLqAoIDwXIIxFtsH1bowE1YQv4sIRJVzQRm40sYDavDQeZn48uLM+qD1RyDoLHsVjwHKsyuWpuOXyR2+qWyDlUbS22t0iR4JZkF2xNTygmHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulWCSZyziQTxWvaZEW0oMbGrfl0h+XL8SpBOOdVk7y0=;
 b=JiKmC5BUJQvDFpI30SG1a+NhYz3h1J1gweNd1oa04jgbD32hTkwMk51E8sr03x1xdd2pyfeVhyxAWyVmRD1aPayFgFhybd8sVqdIqRGk1sJ+fBlNeq5NTNETE/7u8trsbp2/z5K2yMMNW+BsYL8Gi/ZgU+QNwpr1I0gKRIcVhXU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI0PR04MB10163.eurprd04.prod.outlook.com (2603:10a6:800:245::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 02:14:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Tue, 2 Apr 2024
 02:14:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 02 Apr 2024 10:22:24 +0800
Subject: [PATCH v7 4/4] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-pinctrl-scmi-v7-4-3ea519d12cf7@nxp.com>
References: <20240402-pinctrl-scmi-v7-0-3ea519d12cf7@nxp.com>
In-Reply-To: <20240402-pinctrl-scmi-v7-0-3ea519d12cf7@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712024558; l=18146;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=UERHr4F3f6FwDhLabCgl27ZHbM2x1cDubkQC3wdRx5o=;
 b=CVloQHrBmHVxwE8wLsRPF6FF1ByjjUYi/nZNtOSac4108lJcaBoOp/156083/TpSpzM4bZ37G
 LI+vHdWIQ1qBmJCSsQNSaWBwEwhv1Fu6gEbYWEeAaEtRglfiod0W/4M
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI0PR04MB10163:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g/pOLDh28GcJKfqwVXgbQHWFiSIPm6IGm5MerASFPeQbmdjXzM2DO7QWtMVUEo4ysEKfrsspRI3FAPUNr7laiD+/VdalzlLAJtzFpJuoVEDZy6X5grFdtAQLxgHLQ2yDz2Q9HKUaBPyvuATQIo4XQ8q23VL7mnu/sZmKvkV/SLS1bEq3dtCN8HI1zA+C+blWfMxZc2pJdnSZKRCYk5OUZoh5WST+f4kBqAcC6rSajGCdcHV0m0shpARhe8FvhsBdCnmUawUqzAtVuoiZlJ8j/rwluiONADl3+Jj4H70qFfgBYjWZe54FfHdlx2C27fcrZnHOKmlhNpwij68y4FZeIsCi2jM+zswRVlxeoGrfH+W9l2lQpOPGYs1dv/R6CiZut7/HuBjefluUr6IxoOQg+Z32zFd5uCptk6G5yJrsVJg3E1l7PkcGaNqCnWoaAysvhCBje++37QVolaVxhhMqZ09IRq2aQ5NQPeDKSqblRuOVaJFPCqMWtU+YliQo1q26nZHYehFXZkVlvS0oQMNzE+uWoIp2TVKYPzu4FJziVOAIiOt5GnIkPcEhzH/9Tm2ewRI7rzDqlrx/kuv1/BDe/3aYz5GCodrUR8k7afBy5O6cGAzYjuveBOCfEjKkEz+VQroxVTl74ZCxEsEOgdNQZvd6J9TLX9LLK9Bo+9IvKULFqYEg12zpVFxqwK7LeLIGHQBPywDr4wSzTcoSs0tcU4BhL7OeVxm0z9hRHOcRRgk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUFzUVFhZEFPT3U2NXRZbUVsaDhxMnhYU29aQWs3OW81M3ErNCt3ZFZuK1Uw?=
 =?utf-8?B?UEl4ZWJUR3U2VkQ2RnNPaUtEV0FRSjVpVlM4Z2ZGMVNNZjFJdVZhSlZ0QnN1?=
 =?utf-8?B?U3h5SVRwWDUycUZzMi9iYklZWEZSbHV4aXV6b0JHdGhKYmwrZWZoemE2Z1Zq?=
 =?utf-8?B?bm80Vmg4bHZQMDA4SzRMVjMxclpmREtwdCsvZ0hNYm9pSDlLczMrQTVOVmU0?=
 =?utf-8?B?QjRTOG5RemlUekNaYW9qY0JHV1M2NDBPeXhKK3RTRXdsR2J5SjBudStNaUwy?=
 =?utf-8?B?SHZGQVdpQzJDOGtiQWt1NTRDcWlYRmhQVXhxM1A3V0phU0p6WjlvNTQ0aEFW?=
 =?utf-8?B?aUVjdXNPSUo0QVdHZHlpbFpGdTBXNFBPekFrODU4T21GVlNTRWdxNy9oTlJn?=
 =?utf-8?B?YitCMSsvSkdpMDlzMUV5enVhRFdacXNJdEdtQmhWbFhvS2NQRE5IM0dEbFlq?=
 =?utf-8?B?UTh4QktCRnU2WHZhMDNpOS9UL2JMUm9EL2tRME8wdEttaXhubDFSVDdwdU5q?=
 =?utf-8?B?WWxzMTUyR0RXckx4dFhmZ2NxMnErY2tKbUNNUlk4L3IwNnVQNnkyd2w1T1lZ?=
 =?utf-8?B?ZUJTMW5nOERKQlhhRll2RlNXWUVPd2pnRTNhb044RVh0OWh3UmNYaEJpSGVm?=
 =?utf-8?B?OFN0REVCcm9SQ0xMSnJqRXNMczhBbDBNZUwzN21xdFpmMENxaGdOaHY1a0VX?=
 =?utf-8?B?b2RueDlJcENoZkFUWGJPK2NLaHFSQ1d3ay9RcDNELzR3dG5iVmpqMzZvRHdN?=
 =?utf-8?B?TWZwYktRVmlyVzdNcFdDQ21NbVZ4amdmRXVmNFhzWWRCVDlEWXJuNURXR2lD?=
 =?utf-8?B?ZEpEYjJvTnhWbWRaa3A5d0F5VmE2dEQyRUpsRjlkUmk4UVVXSW93RlYwb2Ft?=
 =?utf-8?B?b2JNdjhRa3BSNW5POWxhSUVWTUVmS2dITndTUXBIcU5tWXg1M3V1THZ3bS9X?=
 =?utf-8?B?YmYwZjlVUDRGUkZpa1ErM1hVN0RwQmh5czRvSUVlKzM2NitnanZIbm1DZ0dM?=
 =?utf-8?B?NE4vOXJzY3NqRm1lRENSKzdsaDBSUE13TEQ4M0R1WTc0NGtVYlo5ZTB5UCt3?=
 =?utf-8?B?MzY2dTAzSWcrbldXWHJNTlg4cU9rYkFVWUJRVlg5VE81clVxdE5ETThrcVli?=
 =?utf-8?B?N2NNYmFjTzkxNGc3aHF3YTNaRlFpcmdmdXVzbCtpQXdnMkk1a3YybXFIUkE2?=
 =?utf-8?B?WTRDYUFkeVhjM25wUkk5NlVac3A2aDU1MC9KS0RJZFdDa1RUTDh2MDFpa3RF?=
 =?utf-8?B?aW9nb01TMmhEaWdJV28zWWJON2Fkb0Rzb25RZDZMYUdKTElNUjhtSmRCK3Zj?=
 =?utf-8?B?WXJObGNxcmlQbVQ4VlJHd2ZiU2NtQ3BmY0pXOUZRdnBzcndYbmlqb1VSdllG?=
 =?utf-8?B?NUkyK3Fja08vSnNoQzVQNlB5NkJRTzh4SW90VkNRSTExTXNldy9ORzBBK2xn?=
 =?utf-8?B?VE1UTC9reWkxb3gzb3pmWkh3UnpyZUVvbW9ZTkt0RndYZEJVREI5azlMTGJs?=
 =?utf-8?B?Qk1VTkFyVGUzbk5jNlNTdm9scTNBaThhM1BsTE1iWnU4U29PNFFKaGY1U1Zq?=
 =?utf-8?B?U1htSkhFVjc1VVB4ajM2S2hFaDNnd1o5cVo4NWsxZjJHOGZzOGFFWFJXRlVW?=
 =?utf-8?B?S2N2NnhPYlV1UU11amI2VE5RRG8wSXEzQzI1Vkk1amRZRGYyQW1HSkJsRVdH?=
 =?utf-8?B?dk15NnB6aXlvdnRQWCswVDArcTVmYXlkdk9SdmMzWld3ZUJzaXRsWDBrdVlL?=
 =?utf-8?B?Q2tGS080dVlIdTlkSjR5amNnVW5RYVZCemVEZEViS3d1QjVrOVNJUkZVckRp?=
 =?utf-8?B?Nkk4bEc5bzYvOWVvelBhTnJpYU9VajQ1aW5DL3lhVzhhb0s0aXRwTUNmL29y?=
 =?utf-8?B?Ulo3R29TVEtaSVNCd25kd0hXNXVOdTNoNUpNelMvS21DZzAzeTVtb29NSzhL?=
 =?utf-8?B?M21UNDQyeHN2VmZsSUpKQWpWL2l1QjBUNXdkdlVnM0tmNkRBRTk1d1prOUZk?=
 =?utf-8?B?ODY4bTRGU2FHc1B2SEpnZERsS0RZQ3YrOVVVSU1tUnJkanBqOC9CTk9CZjAr?=
 =?utf-8?B?WVlhTzQxWlZ2N3JNWStEUFRocjZsUTNzd0I4bGVGY3U0U3VCL3NjQ2dLOXVn?=
 =?utf-8?Q?rRvf6lpGRTme/KWRcYyYrte8o?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cecb838-cd3f-485d-ea05-08dc52baa658
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 02:14:38.8687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oeWFTm9xaQ1GUDCBi8N7l2hvw0fYFw9ud+GmLAvlGhbMUFu/XhoeVOX3AJlcWCeH/zVrlSPsfhT8nL7lIYiLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10163

From: Peng Fan <peng.fan@nxp.com>

scmi-pinctrl driver implements pinctrl driver interface and using
SCMI protocol to redirect messages from pinctrl subsystem SDK to
SCMI platform firmware, which does the changes in HW.

Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 MAINTAINERS                    |   1 +
 drivers/pinctrl/Kconfig        |  11 +
 drivers/pinctrl/Makefile       |   1 +
 drivers/pinctrl/pinctrl-scmi.c | 560 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 573 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b511a55101c..d8270ac6651a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21457,6 +21457,7 @@ F:	drivers/cpufreq/sc[mp]i-cpufreq.c
 F:	drivers/firmware/arm_scmi/
 F:	drivers/firmware/arm_scpi.c
 F:	drivers/hwmon/scmi-hwmon.c
+F:	drivers/pinctrl/pinctrl-scmi.c
 F:	drivers/pmdomain/arm/
 F:	drivers/powercap/arm_scmi_powercap.c
 F:	drivers/regulator/scmi-regulator.c
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index d45657aa986a..4e6f65cf0e76 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -450,6 +450,17 @@ config PINCTRL_ROCKCHIP
 	help
           This support pinctrl and GPIO driver for Rockchip SoCs.
 
+config PINCTRL_SCMI
+	tristate "Pinctrl driver using SCMI protocol interface"
+	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
+	select PINMUX
+	select GENERIC_PINCONF
+	help
+	  This driver provides support for pinctrl which is controlled
+	  by firmware that implements the SCMI interface.
+	  It uses SCMI Message Protocol to interact with the
+	  firmware providing all the pinctrl controls.
+
 config PINCTRL_SINGLE
 	tristate "One-register-per-pin type device tree based pinctrl driver"
 	depends on OF
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 2152539b53d5..cc809669405a 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl-pic32.o
 obj-$(CONFIG_PINCTRL_PISTACHIO)	+= pinctrl-pistachio.o
 obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
 obj-$(CONFIG_PINCTRL_ROCKCHIP)	+= pinctrl-rockchip.o
+obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
 obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
 obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
 obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
new file mode 100644
index 000000000000..827d9ef8a209
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -0,0 +1,560 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Power Interface (SCMI) Protocol based pinctrl driver
+ *
+ * Copyright (C) 2024 EPAM
+ * Copyright 2024 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include "pinctrl-utils.h"
+#include "core.h"
+#include "pinconf.h"
+
+#define DRV_NAME "scmi-pinctrl"
+
+/* Define num configs, if not large than 4 use stack, else use kcalloc */
+#define SCMI_NUM_CONFIGS	4
+
+static const struct scmi_pinctrl_proto_ops *pinctrl_ops;
+
+struct scmi_pinctrl {
+	struct device *dev;
+	struct scmi_protocol_handle *ph;
+	struct pinctrl_dev *pctldev;
+	struct pinctrl_desc pctl_desc;
+	struct pinfunction *functions;
+	unsigned int nr_functions;
+	struct pinctrl_pin_desc *pins;
+	unsigned int nr_pins;
+};
+
+static int pinctrl_scmi_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->count_get(pmx->ph, GROUP_TYPE);
+}
+
+static const char *pinctrl_scmi_get_group_name(struct pinctrl_dev *pctldev,
+					       unsigned int selector)
+{
+	int ret;
+	const char *name;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	ret = pinctrl_ops->name_get(pmx->ph, selector, GROUP_TYPE, &name);
+	if (ret) {
+		dev_err(pmx->dev, "get name failed with err %d", ret);
+		return NULL;
+	}
+
+	return name;
+}
+
+static int pinctrl_scmi_get_group_pins(struct pinctrl_dev *pctldev,
+				       unsigned int selector,
+				       const unsigned int **pins,
+				       unsigned int *num_pins)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->group_pins_get(pmx->ph, selector, pins, num_pins);
+}
+
+static const struct pinctrl_ops pinctrl_scmi_pinctrl_ops = {
+	.get_groups_count = pinctrl_scmi_get_groups_count,
+	.get_group_name = pinctrl_scmi_get_group_name,
+	.get_group_pins = pinctrl_scmi_get_group_pins,
+#ifdef CONFIG_OF
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
+	.dt_free_map = pinconf_generic_dt_free_map,
+#endif
+};
+
+static int pinctrl_scmi_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->count_get(pmx->ph, FUNCTION_TYPE);
+}
+
+static const char *pinctrl_scmi_get_function_name(struct pinctrl_dev *pctldev,
+						  unsigned int selector)
+{
+	int ret;
+	const char *name;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	ret = pinctrl_ops->name_get(pmx->ph, selector, FUNCTION_TYPE, &name);
+	if (ret) {
+		dev_err(pmx->dev, "get name failed with err %d", ret);
+		return NULL;
+	}
+
+	return name;
+}
+
+static int pinctrl_scmi_get_function_groups(struct pinctrl_dev *pctldev,
+					    unsigned int selector,
+					    const char * const **p_groups,
+					    unsigned int * const p_num_groups)
+{
+	struct pinfunction *func;
+	const unsigned int *group_ids;
+	unsigned int num_groups;
+	const char **groups;
+	int ret, i;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	if (!p_groups || !p_num_groups)
+		return -EINVAL;
+
+	if (selector >= pmx->nr_functions)
+		return -EINVAL;
+
+	func = &pmx->functions[selector];
+	if (func->ngroups)
+		goto done;
+
+	ret = pinctrl_ops->function_groups_get(pmx->ph, selector, &num_groups,
+					       &group_ids);
+	if (ret) {
+		dev_err(pmx->dev, "Unable to get function groups, err %d", ret);
+		return ret;
+	}
+	if (!num_groups)
+		return -EINVAL;
+
+	groups = kcalloc(num_groups, sizeof(*groups), GFP_KERNEL);
+	if (!groups)
+		return -ENOMEM;
+
+	for (i = 0; i < num_groups; i++) {
+		groups[i] = pinctrl_scmi_get_group_name(pctldev, group_ids[i]);
+		if (!groups[i]) {
+			ret = -EINVAL;
+			goto err_free;
+		}
+	}
+
+	func->ngroups = num_groups;
+	func->groups = groups;
+done:
+	*p_groups = (const char * const *)func->groups;
+	*p_num_groups = func->ngroups;
+
+	return 0;
+
+err_free:
+	kfree(groups);
+
+	return ret;
+}
+
+static int pinctrl_scmi_func_set_mux(struct pinctrl_dev *pctldev,
+				     unsigned int selector, unsigned int group)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->mux_set(pmx->ph, selector, group);
+}
+
+static int pinctrl_scmi_request(struct pinctrl_dev *pctldev,
+				unsigned int offset)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->pin_request(pmx->ph, offset);
+}
+
+static int pinctrl_scmi_free(struct pinctrl_dev *pctldev, unsigned int offset)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->pin_free(pmx->ph, offset);
+}
+
+static const struct pinmux_ops pinctrl_scmi_pinmux_ops = {
+	.request = pinctrl_scmi_request,
+	.free = pinctrl_scmi_free,
+	.get_functions_count = pinctrl_scmi_get_functions_count,
+	.get_function_name = pinctrl_scmi_get_function_name,
+	.get_function_groups = pinctrl_scmi_get_function_groups,
+	.set_mux = pinctrl_scmi_func_set_mux,
+};
+
+static int pinctrl_scmi_map_pinconf_type(enum pin_config_param param,
+					 enum scmi_pinctrl_conf_type *type)
+{
+	u32 arg = param;
+
+	switch (arg) {
+	case PIN_CONFIG_BIAS_BUS_HOLD:
+		*type = SCMI_PIN_BIAS_BUS_HOLD;
+		break;
+	case PIN_CONFIG_BIAS_DISABLE:
+		*type = SCMI_PIN_BIAS_DISABLE;
+		break;
+	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
+		*type = SCMI_PIN_BIAS_HIGH_IMPEDANCE;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		*type = SCMI_PIN_BIAS_PULL_DOWN;
+		break;
+	case PIN_CONFIG_BIAS_PULL_PIN_DEFAULT:
+		*type = SCMI_PIN_BIAS_PULL_DEFAULT;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		*type = SCMI_PIN_BIAS_PULL_UP;
+		break;
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		*type = SCMI_PIN_DRIVE_OPEN_DRAIN;
+		break;
+	case PIN_CONFIG_DRIVE_OPEN_SOURCE:
+		*type = SCMI_PIN_DRIVE_OPEN_SOURCE;
+		break;
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		*type = SCMI_PIN_DRIVE_PUSH_PULL;
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		*type = SCMI_PIN_DRIVE_STRENGTH;
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH_UA:
+		*type = SCMI_PIN_DRIVE_STRENGTH;
+		break;
+	case PIN_CONFIG_INPUT_DEBOUNCE:
+		*type = SCMI_PIN_INPUT_DEBOUNCE;
+		break;
+	case PIN_CONFIG_INPUT_ENABLE:
+		*type = SCMI_PIN_INPUT_MODE;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT:
+		*type = SCMI_PIN_INPUT_SCHMITT;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		*type = SCMI_PIN_INPUT_MODE;
+		break;
+	case PIN_CONFIG_MODE_LOW_POWER:
+		*type = SCMI_PIN_LOW_POWER_MODE;
+		break;
+	case PIN_CONFIG_OUTPUT:
+		*type = SCMI_PIN_OUTPUT_VALUE;
+		break;
+	case PIN_CONFIG_OUTPUT_ENABLE:
+		*type = SCMI_PIN_OUTPUT_MODE;
+		break;
+	case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS:
+		*type = SCMI_PIN_OUTPUT_VALUE;
+		break;
+	case PIN_CONFIG_POWER_SOURCE:
+		*type = SCMI_PIN_POWER_SOURCE;
+		break;
+	case PIN_CONFIG_SLEW_RATE:
+		*type = SCMI_PIN_SLEW_RATE;
+		break;
+	case SCMI_PIN_OEM_START ... SCMI_PIN_OEM_END:
+		*type = arg;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int pinctrl_scmi_pinconf_get(struct pinctrl_dev *pctldev,
+				    unsigned int _pin, unsigned long *config)
+{
+	int ret;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param config_type;
+	enum scmi_pinctrl_conf_type type;
+	u32 config_value;
+
+	if (!config)
+		return -EINVAL;
+
+	config_type = pinconf_to_config_param(*config);
+
+	ret = pinctrl_scmi_map_pinconf_type(config_type, &type);
+	if (ret)
+		return ret;
+
+	ret = pinctrl_ops->settings_get_one(pmx->ph, _pin, PIN_TYPE, type,
+					    &config_value);
+	if (ret)
+		return ret;
+
+	*config = pinconf_to_config_packed(config_type, config_value);
+
+	return 0;
+}
+
+static int
+pinctrl_scmi_alloc_configs(struct pinctrl_dev *pctldev, u32 num_configs,
+			   u32 **p_config_value,
+			   enum scmi_pinctrl_conf_type **p_config_type)
+{
+	if (num_configs <= SCMI_NUM_CONFIGS)
+		return 0;
+
+	*p_config_value = kcalloc(num_configs, sizeof(**p_config_value), GFP_KERNEL);
+	if (!*p_config_value)
+		return -ENOMEM;
+
+	*p_config_type = kcalloc(num_configs, sizeof(**p_config_type), GFP_KERNEL);
+	if (!*p_config_type) {
+		kfree(*p_config_value);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void
+pinctrl_scmi_free_configs(struct pinctrl_dev *pctldev, u32 num_configs,
+			  u32 **p_config_value,
+			  enum scmi_pinctrl_conf_type **p_config_type)
+{
+	if (num_configs <= SCMI_NUM_CONFIGS)
+		return;
+
+	kfree(*p_config_value);
+	kfree(*p_config_type);
+}
+
+static int pinctrl_scmi_pinconf_set(struct pinctrl_dev *pctldev,
+				    unsigned int _pin,
+				    unsigned long *configs,
+				    unsigned int num_configs)
+{
+	int i, ret;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	enum scmi_pinctrl_conf_type config_type[SCMI_NUM_CONFIGS];
+	u32 config_value[SCMI_NUM_CONFIGS];
+	enum scmi_pinctrl_conf_type *p_config_type = config_type;
+	u32 *p_config_value = config_value;
+	enum pin_config_param param;
+
+	if (!configs || !num_configs)
+		return -EINVAL;
+
+	ret = pinctrl_scmi_alloc_configs(pctldev, num_configs, &p_config_type,
+					 &p_config_value);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < num_configs; i++) {
+		param = pinconf_to_config_param(configs[i]);
+		ret = pinctrl_scmi_map_pinconf_type(param, &p_config_type[i]);
+		if (ret) {
+			dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
+			goto free_config;
+		}
+		p_config_value[i] = pinconf_to_config_argument(configs[i]);
+	}
+
+	ret = pinctrl_ops->settings_conf(pmx->ph, _pin, PIN_TYPE, num_configs,
+					 p_config_type,  p_config_value);
+	if (ret)
+		dev_err(pmx->dev, "Error parsing config %d\n", ret);
+
+free_config:
+	pinctrl_scmi_free_configs(pctldev, num_configs, &p_config_type,
+				  &p_config_value);
+	return ret;
+}
+
+static int pinctrl_scmi_pinconf_group_set(struct pinctrl_dev *pctldev,
+					  unsigned int group,
+					  unsigned long *configs,
+					  unsigned int num_configs)
+{
+	int i, ret;
+	struct scmi_pinctrl *pmx =  pinctrl_dev_get_drvdata(pctldev);
+	enum scmi_pinctrl_conf_type config_type[SCMI_NUM_CONFIGS];
+	u32 config_value[SCMI_NUM_CONFIGS];
+	enum scmi_pinctrl_conf_type *p_config_type = config_type;
+	u32 *p_config_value = config_value;
+	enum pin_config_param param;
+
+	if (!configs || !num_configs)
+		return -EINVAL;
+
+	ret = pinctrl_scmi_alloc_configs(pctldev, num_configs, &p_config_type,
+					 &p_config_value);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < num_configs; i++) {
+		param = pinconf_to_config_param(configs[i]);
+		ret = pinctrl_scmi_map_pinconf_type(param,
+						    &p_config_type[i]);
+		if (ret) {
+			dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
+			goto free_config;
+		}
+
+		p_config_value[i] = pinconf_to_config_argument(configs[i]);
+	}
+
+	ret = pinctrl_ops->settings_conf(pmx->ph, group, GROUP_TYPE,
+					 num_configs, p_config_type,
+					 p_config_value);
+	if (ret)
+		dev_err(pmx->dev, "Error parsing config %d", ret);
+
+free_config:
+	pinctrl_scmi_free_configs(pctldev, num_configs, &p_config_type,
+				  &p_config_value);
+	return ret;
+};
+
+static int pinctrl_scmi_pinconf_group_get(struct pinctrl_dev *pctldev,
+					  unsigned int group,
+					  unsigned long *config)
+{
+	int ret;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param config_type;
+	enum scmi_pinctrl_conf_type type;
+	u32 config_value;
+
+	if (!config)
+		return -EINVAL;
+
+	config_type = pinconf_to_config_param(*config);
+	ret = pinctrl_scmi_map_pinconf_type(config_type, &type);
+	if (ret) {
+		dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
+		return ret;
+	}
+
+	ret = pinctrl_ops->settings_get_one(pmx->ph, group, GROUP_TYPE, type,
+					    &config_value);
+	if (ret)
+		return ret;
+
+	*config = pinconf_to_config_packed(config_type, config_value);
+
+	return 0;
+}
+
+static const struct pinconf_ops pinctrl_scmi_pinconf_ops = {
+	.is_generic = true,
+	.pin_config_get = pinctrl_scmi_pinconf_get,
+	.pin_config_set = pinctrl_scmi_pinconf_set,
+	.pin_config_group_set = pinctrl_scmi_pinconf_group_set,
+	.pin_config_group_get = pinctrl_scmi_pinconf_group_get,
+	.pin_config_config_dbg_show = pinconf_generic_dump_config,
+};
+
+static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
+				 struct pinctrl_desc *desc)
+{
+	struct pinctrl_pin_desc *pins;
+	unsigned int npins;
+	int ret, i;
+
+	npins = pinctrl_ops->count_get(pmx->ph, PIN_TYPE);
+	/*
+	 * npins will never be zero, the scmi pinctrl driver has bailed out
+	 * if npins is zero.
+	 */
+	pins = devm_kmalloc_array(pmx->dev, npins, sizeof(*pins), GFP_KERNEL);
+	if (!pins)
+		return -ENOMEM;
+
+	for (i = 0; i < npins; i++) {
+		pins[i].number = i;
+		ret = pinctrl_ops->name_get(pmx->ph, i, PIN_TYPE, &pins[i].name);
+		if (ret)
+			return dev_err_probe(pmx->dev, ret,
+					     "Can't get name for pin %d", i);
+	}
+
+	desc->npins = npins;
+	desc->pins = pins;
+	dev_dbg(pmx->dev, "got pins %u", npins);
+
+	return 0;
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
+	{ }
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static int scmi_pinctrl_probe(struct scmi_device *sdev)
+{
+	int ret;
+	struct device *dev = &sdev->dev;
+	struct scmi_pinctrl *pmx;
+	const struct scmi_handle *handle;
+	struct scmi_protocol_handle *ph;
+
+	if (!sdev->handle)
+		return -EINVAL;
+
+	handle = sdev->handle;
+
+	pinctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PINCTRL, &ph);
+	if (IS_ERR(pinctrl_ops))
+		return PTR_ERR(pinctrl_ops);
+
+	pmx = devm_kzalloc(dev, sizeof(*pmx), GFP_KERNEL);
+	if (!pmx)
+		return -ENOMEM;
+
+	pmx->ph = ph;
+
+	pmx->dev = dev;
+	pmx->pctl_desc.name = DRV_NAME;
+	pmx->pctl_desc.owner = THIS_MODULE;
+	pmx->pctl_desc.pctlops = &pinctrl_scmi_pinctrl_ops;
+	pmx->pctl_desc.pmxops = &pinctrl_scmi_pinmux_ops;
+	pmx->pctl_desc.confops = &pinctrl_scmi_pinconf_ops;
+
+	ret = pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc);
+	if (ret)
+		return ret;
+
+	ret = devm_pinctrl_register_and_init(dev, &pmx->pctl_desc, pmx,
+					     &pmx->pctldev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register pinctrl\n");
+
+	pmx->nr_functions = pinctrl_scmi_get_functions_count(pmx->pctldev);
+	pmx->functions = devm_kcalloc(dev, pmx->nr_functions,
+				      sizeof(*pmx->functions), GFP_KERNEL);
+	if (!pmx->functions)
+		return -ENOMEM;
+
+	return pinctrl_enable(pmx->pctldev);
+}
+
+static struct scmi_driver scmi_pinctrl_driver = {
+	.name = DRV_NAME,
+	.probe = scmi_pinctrl_probe,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_pinctrl_driver);
+
+MODULE_AUTHOR("Oleksii Moisieiev <oleksii_moisieiev@epam.com>");
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("ARM SCMI pin controller driver");
+MODULE_LICENSE("GPL");

-- 
2.37.1


