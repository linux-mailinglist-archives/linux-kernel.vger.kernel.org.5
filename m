Return-Path: <linux-kernel+bounces-103296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FB087BDAA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3A9281F86
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B646EB74;
	Thu, 14 Mar 2024 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jc8jhzbX"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7636EB6E;
	Thu, 14 Mar 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422857; cv=fail; b=GS/rbd31PN2n/o1bSX2SZVc99rJI4XBmHfSX4fzKRUsrlW4Mwzf43/a8nDwpmywFc8XDJ9Nca4QiffVC09isrCHoedHPv7wpD8VzmRwXJd1928xsZx+kku243DtdRMQ/8b0buXevRq33YlDUDa5kn8k6ZuLOPHD9B0EYkylvfbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422857; c=relaxed/simple;
	bh=UnDOff+Ugxpm9ISuXVn0WsuMZ575zMEYgwV3AI8HJNg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OKZLVEo1zzjF/FkCTVrlFGe4zqwXRyI1YKelRZ7HWYN266XJrEOuDdy4wnzM32COTZeQeCX2nXjQUCzYYLvHMH5ihqh4MdFB+RIqaFnCGy+3eiwFJpZsUyQ/0bynwWNgGpo6KsxoOr0WP/mTfEBBeO+omPiigvhvkRK+/YVjAoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jc8jhzbX; arc=fail smtp.client-ip=40.107.8.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPT0xYnQIoiDoqfFbp3PYf/fCWnZ3AyUXE8POFtKU8/Yto4opDYDTT1mjaG02Lk7DswVJj3U8WqMmhKaLn+PVuh2fmdmj+pnJafYpuDJVNUrP3Azx+2KiXO6J9HNQ7/yRuDbBL7ESQ4TBqIppQ8G3s/9dLRZZbPEq3tTID/RrBtPFGbR9ALgSL81wBenzNek4SG77KEmJGaAV1/vGmYxndhKTPtw/6a7l9pbjX+cp52OueJFrTn1ZORCupLRoB52xbkzfC8+7wNvRbR6NK29sl1ZqYq3dcOfaep5+nXcdblbNkT9ZMa9dm51ItLtCUGtQkfeO9sTk2rZucFx0V35Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQl9dhhnjGjSao3RfqErnZmcadVzodCzM1wsuuq4MF0=;
 b=bKFNLQns2Yh15RabLVz4ipCneHVLHsHo2da89a8InywlMh8HeeEenHwmQWqQb5h7wocyy/vYUAE30h8r2uQysB9VLkmDt5G+D5RE10QHf3hxFMOXWh6Pym8l8ivcSLAAmIHyvzUcAMVZDYhibV8e0XPJLvJGKJ23M9jO/itlcvZlmiYZD+QegU0EZpXoGZggXWWF5AQlJQ2Zj9GCU+X9376AfCutnPV1lElVrvrFnsdEadfN33DWFHWdVYmYR0GoRlNfDlg2ERHdK+8Z3dXl2JmRdh0PewrFRpOGQw3zl8UHAgBHLaBTD20NAyouL2xFJiqR67K9oNCiixSNInxHDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQl9dhhnjGjSao3RfqErnZmcadVzodCzM1wsuuq4MF0=;
 b=jc8jhzbXjhYIHDpMK5FtBDyDaVqq2wNprq7+kV7c/jI7IvQCh2PCWcu/fjh415Xj1hZiDHocwDdSsZsWHUM+QX34GWmmd9OuG/TD00+PX4fFeXsSxQwy21vgGUOmaw91PNx1i57S9KzcKXk/ICOURX8vQGtPVpKDRAuCQS0aPog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAWPR04MB9861.eurprd04.prod.outlook.com (2603:10a6:102:381::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 13:27:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 13:27:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 14 Mar 2024 21:35:21 +0800
Subject: [PATCH v5 4/4] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-pinctrl-scmi-v5-4-b19576e557f2@nxp.com>
References: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
In-Reply-To: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksii Moisieiev <oleksii_moisieiev@epam.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710423327; l=19239;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=QS4um6Bx3c1L9Yftty5oVvx70EDHXttygs6rhhcPjjE=;
 b=WtQ+GUndxmIpFOUF6e/DHsQEeXK9zHJPold0rzkTR8g4/PToLcn4MR0uNvgD9U0Zka10YUFfk
 yyGuKs3DwveBtwbazd6YPi3MZ1lsjtgn188m/oaf9ngiRZ+qvxhKWp0
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0188.apcprd06.prod.outlook.com (2603:1096:4:1::20)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAWPR04MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: 410a746e-271d-48ee-9d7f-08dc442a7fbb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+PBtMekM02v2lCv4a2AgUCrTDk6Z9PaZyiQ9uPunAwjrDwBg86+0Qd71IQXsYYznuePsU9Nh/7ISP6JZDcON1YxHJNAUjd/EwvESdz3fwK6mehD6cytAVA3SxaXENzOG9G7Rq1QaSYwnOSX2+7RUvDFQmD1waS6D94mw1O6GeTL1mEtidIhv66JFvkEr7AenccknL2kRgalbPX3BQMwFEvgMsn12z9GC5aDNyj0tkZOl3IbRC3Uzn3fS3WFKz3UzE1NUwVHhFMfZ/scvF2cqDc3jH8J2qSaHoi/dST1etDL5EhQ9uNc482ZsrD0V7HweUBN+KsKVqcWGg34mKIjztxr7fEGdxcPwj5Jaj5Rh5O62ZOKVchJn5Di8yESYG33gUOQPYGUod5pOr0e0WGhksyoSD8vl/2miUA3Er24faUhKTGroyv2OJ17Saf8nj0OHUgPLtq6zeo5TjMpq//Pps5xWYjUIHV1UzK4ZVMk7TMTWK3niNu1VJRgP4QYG9ZGheeWbdn0butDe/Xh221MLoK+TLrbioDHmDIqquvv/O+qru0dUx84naiB0em214vMA75HB9alX7yqiluf5XfW8o4LVnDJYuRK2+QXywYu0SgzL4djKa5nViNgIArezSko9SjkYR8cqOpN7TvinevlLgVfJEgUoRNq80b2Lv+9BDHNwg2Owuhl2DOYuulZ1M3StZHK6/OmmGYSoJNsoK7oIDCEngA9o+lvwHLWdAV98lS8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3lydjVjZE5BMkNRUEFRZVVPTVlwVG42S3Z6TkhDL3BKbW9NdnVpSlJOZDFV?=
 =?utf-8?B?WVJmOFBDL1hiamttbHNERXdQaWdRZnFpanZ1ZlAyZWhrbWZPbi90cUg5QWhW?=
 =?utf-8?B?WWRUZWplQ2g1TFpWdWF3T1ZGV1pjZmpmQ2I5bCtpRENTRWJid0tDSVR5THU0?=
 =?utf-8?B?YUI5cXE1RUViZ0d5aWVUcTNxdTNQa3Viak1mbkZuQ1NaR0daY2o3NFpFdTdD?=
 =?utf-8?B?Z0dEbzhNYzFXWCtBTkdJZTd4TzQ0OXZtcEZyZmQ3VFE2aU53dCtBOGRUWnE1?=
 =?utf-8?B?aEJXcTRuQlR1NVdLeGVmVWVSalkvOGpzdUxQS3YvSWJGMEJYM1Uva2ZIcCti?=
 =?utf-8?B?K3FwR1lBQ01sUmUzTitRQy9HM1R5QWhaL2hYd1ZOdGZRTmFpdFVNMERzdU00?=
 =?utf-8?B?c0NjeWdQTlVvb2tWUlA4WlRra2hWeDFDSUFTc1NCNnVxa2VuekMyM3ZyNTBh?=
 =?utf-8?B?UGphYTNRcEJOcG9HT3c2d3UyOGpGL2c4Y1A2ZFVZRHRIQ1hqL0dydGwwNXNC?=
 =?utf-8?B?RmZrY0t4czVtR0JPd1YwSG1pQVVBR3M3ZFI5R2IxajMxUWJkWjY3Y252MEJx?=
 =?utf-8?B?WXdXZ1laNkg5VTRYVW9sc2hVd2lkeXJrYmswakZIRUhubDhqcm5IdnVpSEhr?=
 =?utf-8?B?bGpPcEROVmV3aC9UYUZ2M0dTLzhZY0dMaWQxc205WnpRZURaUVI3SGo1SnFD?=
 =?utf-8?B?aFI0cGdsVEgyOWpraHJHKzFYOGw1NkFOQkpmOGFQMDN1cEUzT0ExY2dGQ0RI?=
 =?utf-8?B?Q3E2bzFnSFhCa3JObWZueFNLQm9IOE16UURQN1FzclhNazduT0UveUZtZWNx?=
 =?utf-8?B?UFozbVkvTE5GNjYvVStQN2k2QXFEYTVzbkZsRTF1TFUyUEpnRklzYjBEaHBp?=
 =?utf-8?B?ZW1aNUFQNGR0UDcyNEtKTHBCcjd2WEtZeUd6aGtjVk1xQTlKMGd5ak5pcmlw?=
 =?utf-8?B?VUcwZGxhaHhQNVlMMTBBZ1ViNkU3VllXWE9hNWNtSXN1THpzTjZ4WlVwNHE5?=
 =?utf-8?B?dmR1U1Z1bWFlcFZEeWw4dU9CWEhXb3BEU2MvTm1heDY2VUcrNkdSYjJtNjZF?=
 =?utf-8?B?L2FUTWM1dEZ6MnVZWCtOeDlEc2VLVWxTR2tVend1eEFlZWRpNWdWU0V5MVVJ?=
 =?utf-8?B?T1lUUk8wTHIxbDJjVkJXMUxKd0RRYXpjT1Z6cVlqNVVDZU5aVE91R2hYUHhO?=
 =?utf-8?B?M3ZMcDdlMFd2VUo5aUZkSDl5RjJLNk93enlXSkFBR0c2V1lVd3hoSTFMSnEr?=
 =?utf-8?B?RS9yUXlWeFBBbjd6bmREa0pndXV6RUt5SjQ2M1BMeGhKOEEwNzNCbzAxSGZu?=
 =?utf-8?B?cW03S04zc0VDSDY4L2tqa2lBZUx6V1BLUW9Kakc2YXkxRVpadDczejB1aWNt?=
 =?utf-8?B?SkZkdDhhNS9QNFpSeTgwTjNUM1E5TkdNbHJEZ08yQmM4NVZrVWZpN1YrMzRW?=
 =?utf-8?B?bk1Ba3pwTVZ2Vk5NNitVNENaU01xRGxWMGozVGRUWituU1UrQVI3NEREeFlK?=
 =?utf-8?B?aGRuM2txK1lKd0RkSEhFT2NSWCt5bXZWKzVzZXMvaUJlTDRKRGlZNzB6Y0Jv?=
 =?utf-8?B?dHVoZ24xNUNEZElhTm9PdFZYTFQxUlJHaTliWFZTZXBOV3B2QnE1TTRUbjB3?=
 =?utf-8?B?SVpSNVZ1TFMxWUZOV0JkOEdHR2FlYzFETjc5NlhmdDBPM1YxdzlySXBtNjFt?=
 =?utf-8?B?azRuK3JCUzFJZk1BSnRaSURXLzFqVld6aytyQU5hR1M2RnBCTEY5cmd1R2U5?=
 =?utf-8?B?TlZCdVdtTkFyL095VUMzbnNNZmdzU2JNZ2JkNHczZmpnQ3NQVVcwS2JCeVhn?=
 =?utf-8?B?bndIczFZMWovRHZHejJsZFNaQUpJaTIzUjZFekhTaHY1WkMxMWkwU3pWYW1Q?=
 =?utf-8?B?MFVTSTc1Uk96L1ZzMkpHS3VLczR0bG9PU1MvWUNzVU5jRDdvRHpLa01POHJs?=
 =?utf-8?B?ODRQRnlSVEtlL0ZzQkw1TmxZdVpmeGQzYm5OcmtIKy9ON0tTQm1rUG1xcjFM?=
 =?utf-8?B?NHBaZU5jb2NtUlk3cmduYU9Ed09vN3JnZ0Vmb3JtWEl0cmJ4VVpiNEpYQlc4?=
 =?utf-8?B?NmM0bDBnZzdBWjlhR3ZSSnBiaksxV3NydGtiRXc3T1BUZHJCVW5oY1pvTlRs?=
 =?utf-8?Q?qQUb2PunhqzgFqvubiliZQebo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410a746e-271d-48ee-9d7f-08dc442a7fbb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 13:27:30.4116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZKOVBrHIA+y1ZI1zXAJgJi1zaP0AUzSr6PVV+7jMT7JFLWTTZiTluWtK//yCx2IqCcLLWBGVNIlNe2DeziVGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9861

From: Peng Fan <peng.fan@nxp.com>

scmi-pinctrl driver implements pinctrl driver interface and using
SCMI protocol to redirect messages from pinctrl subsystem SDK to
SCMI platform firmware, which does the changes in HW.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 MAINTAINERS                    |   1 +
 drivers/pinctrl/Kconfig        |  11 +
 drivers/pinctrl/Makefile       |   1 +
 drivers/pinctrl/pinctrl-scmi.c | 593 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 606 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b43102ca365d..aa9eb9476bbd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21474,6 +21474,7 @@ F:	drivers/cpufreq/sc[mp]i-cpufreq.c
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
index 000000000000..f2fef3fb85ae
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -0,0 +1,593 @@
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
+struct scmi_pinctrl_funcs {
+	unsigned int num_groups;
+	const char **groups;
+};
+
+struct scmi_pinctrl {
+	struct device *dev;
+	struct scmi_protocol_handle *ph;
+	struct pinctrl_dev *pctldev;
+	struct pinctrl_desc pctl_desc;
+	struct scmi_pinctrl_funcs *functions;
+	unsigned int nr_functions;
+	char **groups;
+	unsigned int nr_groups;
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
+					    const char * const **groups,
+					    unsigned int * const num_groups)
+{
+	const unsigned int *group_ids;
+	int ret, i;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	if (!groups || !num_groups)
+		return -EINVAL;
+
+	if (selector < pmx->nr_functions &&
+	    pmx->functions[selector].num_groups) {
+		*groups = (const char * const *)pmx->functions[selector].groups;
+		*num_groups = pmx->functions[selector].num_groups;
+		return 0;
+	}
+
+	ret = pinctrl_ops->function_groups_get(pmx->ph, selector,
+					       &pmx->functions[selector].num_groups,
+					       &group_ids);
+	if (ret) {
+		dev_err(pmx->dev, "Unable to get function groups, err %d", ret);
+		return ret;
+	}
+
+	*num_groups = pmx->functions[selector].num_groups;
+	if (!*num_groups)
+		return -EINVAL;
+
+	pmx->functions[selector].groups =
+		devm_kcalloc(pmx->dev, *num_groups,
+			     sizeof(*pmx->functions[selector].groups),
+			     GFP_KERNEL);
+	if (!pmx->functions[selector].groups)
+		return -ENOMEM;
+
+	for (i = 0; i < *num_groups; i++) {
+		pmx->functions[selector].groups[i] =
+			pinctrl_scmi_get_group_name(pmx->pctldev,
+						    group_ids[i]);
+		if (!pmx->functions[selector].groups[i]) {
+			ret = -ENOMEM;
+			goto err_free;
+		}
+	}
+
+	*groups = (const char * const *)pmx->functions[selector].groups;
+
+	return 0;
+
+err_free:
+	devm_kfree(pmx->dev, pmx->functions[selector].groups);
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
+		return -EOPNOTSUPP;
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
+	if (ret) {
+		dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
+		return ret;
+	}
+
+	ret = pinctrl_ops->config_get(pmx->ph, _pin, PIN_TYPE, type,
+				      &config_value);
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
+	*p_config_value = kcalloc(num_configs, sizeof(u32), GFP_KERNEL);
+	*p_config_type = kcalloc(num_configs,
+				 sizeof(enum scmi_pinctrl_conf_type),
+				 GFP_KERNEL);
+
+	if (!*p_config_value || !*p_config_type) {
+		kfree(*p_config_value);
+		kfree(*p_config_type);
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
+	ret = pinctrl_ops->config_set(pmx->ph, _pin, PIN_TYPE, num_configs,
+				      p_config_type,  p_config_value);
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
+	ret = pinctrl_ops->config_set(pmx->ph, group, GROUP_TYPE, num_configs,
+				      p_config_type, p_config_value);
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
+	ret = pinctrl_ops->config_get(pmx->ph, group, GROUP_TYPE, type,
+				      &config_value);
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
+				 unsigned int *nr_pins,
+				 const struct pinctrl_pin_desc **pins)
+{
+	int ret, i;
+
+	if (!pins || !nr_pins)
+		return -EINVAL;
+
+	if (pmx->nr_pins) {
+		*pins = pmx->pins;
+		*nr_pins = pmx->nr_pins;
+		return 0;
+	}
+
+	*nr_pins = pinctrl_ops->count_get(pmx->ph, PIN_TYPE);
+
+	pmx->nr_pins = *nr_pins;
+	pmx->pins = devm_kmalloc_array(pmx->dev, *nr_pins, sizeof(*pmx->pins),
+				       GFP_KERNEL);
+	if (!pmx->pins)
+		return -ENOMEM;
+
+	for (i = 0; i < *nr_pins; i++) {
+		pmx->pins[i].number = i;
+		ret = pinctrl_ops->name_get(pmx->ph, i, PIN_TYPE,
+					    &pmx->pins[i].name);
+		if (ret) {
+			dev_err(pmx->dev, "Can't get name for pin %d: rc %d", i, ret);
+			pmx->nr_pins = 0;
+			return ret;
+		}
+	}
+
+	*pins = pmx->pins;
+	dev_dbg(pmx->dev, "got pins %d", *nr_pins);
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
+	if (!sdev || !sdev->handle)
+		return -EINVAL;
+
+	handle = sdev->handle;
+
+	pinctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PINCTRL,
+						&ph);
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
+	ret = pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc.npins,
+				    &pmx->pctl_desc.pins);
+	if (ret)
+		return ret;
+
+	ret = devm_pinctrl_register_and_init(dev, &pmx->pctl_desc, pmx,
+					     &pmx->pctldev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register pinctrl\n");
+
+	pmx->nr_functions = pinctrl_scmi_get_functions_count(pmx->pctldev);
+	pmx->nr_groups = pinctrl_scmi_get_groups_count(pmx->pctldev);
+
+	if (pmx->nr_functions) {
+		pmx->functions = devm_kcalloc(dev, pmx->nr_functions,
+					      sizeof(*pmx->functions),
+					      GFP_KERNEL);
+		if (!pmx->functions)
+			return -ENOMEM;
+	}
+
+	if (pmx->nr_groups) {
+		pmx->groups = devm_kcalloc(dev, pmx->nr_groups,
+					   sizeof(*pmx->groups), GFP_KERNEL);
+		if (!pmx->groups)
+			return -ENOMEM;
+	}
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


