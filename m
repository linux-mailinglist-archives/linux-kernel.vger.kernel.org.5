Return-Path: <linux-kernel+bounces-144879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F18A4C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD310287E81
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A9C47F50;
	Mon, 15 Apr 2024 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FucjmjMQ"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486F745944
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175432; cv=fail; b=psBreweLcLGMR+sa3YixmoI0d/IDTVOtOp6z60mQZnSgSjiGJ9OL/UXxm8Kpgg1dDc5neuotzt908MnkYTOQ+os0e19QHizK6xC5kx9zI3Em8qJc62PSLzYqbVlT1AJITruuxTBOdoEKktpGv54KgiqNiipSHwDZXbF7ly88ePs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175432; c=relaxed/simple;
	bh=LsW1ZtxlfiTqewUab5BGAIAtMjhGJErONRJKby5SBI4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PsU1avf2nzSUQc1IlB4FV/4hwpqH9NZq/5IIDTc2i8kXleqZTJUi/W+Y9arQKItEzZXxIDH/ZMHNAPeYgZQPnAQ3ygdc8IoeNQQvmubKSo8+ZmlAaOKLcApZFs9lTzeZYSlE0LNTJhTl+qCeQd+22Hyk5xtsrEJn9uB+h9yncLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FucjmjMQ; arc=fail smtp.client-ip=40.107.8.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNMip9l1SMkihMhfIPq4U01MaiNLX6ktQdAQxQJHB67PY4y8BsR1Dmz4GvwO0u0Wl5+/g5a0UBxxcYoU2lggRZeWhBkGeh3EH4kpBAofNLY0N1IL5b7+hqFJJ56ZBAEpPfY9FluAWrHFACBWFaJHKVvXoicK2BWdHeBElqqTw308ziOs5AwW+M2X3lAKWmxPY3DxvWqz0NYzyYBkPf9fyP7Jn6OjPhtwY8cg23B88UbWj+oChMcigMeI0BR+42xRa8fWyTMzn3FNDrH+xDR2LrjQkaXzeOALpr8Fm4VUUUEebvH8fflq1kcDz7B4t0e92/K7927Jij5UpUcejDAkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnNP+2usiOZ7qSszaw5Whgtm+rJJAzRCthljTwg8Pp0=;
 b=gIJhrr+jxRh71spy07YqxrxrCMRGV1PP3cO659eS2RS5DE6Bh8ZhEdPcyMTzzUnfn/ExgvsimsSRhmK2dKJNDI7ZuBoQiaoEBmCa1354G7LatdYCiiplBm+MNCPKdg3nuGAyu1rfrvWm8z9hruMDXTH7R4R4VFUgqaK5DyZ7985cYNsjXenr16RZ7yQgAp537v7VJywSbjVjzPrOlGa6JQuXw5VTZpWhqFaDbyEM1y+t178+XPp+4pnhQ97jVEvwGyt9J9IwSahxPVndUMPZsMlwqc0nJMyAoYGSsrUM7RIDBF/06FJ99Buo0pODlkuKuVgV9tU7wcJ2v4CbInYuww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnNP+2usiOZ7qSszaw5Whgtm+rJJAzRCthljTwg8Pp0=;
 b=FucjmjMQtoaGIKYc0PXpGmVEUO5mOuTBWf+AR6vLgBCY5rFQiuOTx64i/30gRfb8bJ/XDV9J8azpb46uQhQGQM6Kp69Sr0+/6BG0aKk5/2YZkVdXg1ZATZ/ISpBL2ylD0YC0OkbrdMpkHLOCVIyyaQLP1ovtM/oSLZRwth1CoLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8911.eurprd04.prod.outlook.com (2603:10a6:102:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 10:03:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 10:03:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] firmware: arm_scmi: power_control: support suspend command
Date: Mon, 15 Apr 2024 18:11:41 +0800
Message-Id: <20240415101141.1591112-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0229.apcprd06.prod.outlook.com
 (2603:1096:4:ac::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 17863839-7025-43b0-e53c-08dc5d335485
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rWsE1rqYXAyR5trwblLl6o3K3/gT4xxgPnnDRk0dXSFJCymQjhRnIdnMhfv6wNnUTb79hU5Cf1FvZR6ZhMsGZ6TQffSwAV930ozY2OhkKYiLc3sYR4/yGJgGgkVTvYnApILDRlhkEE0c4FEfd2eUMGnx5ZVAN1lPhfuVUNQo2Y7F3ZVlbtMQPPj4fTlYtqUYWPZSa71K9ryWoDi3iGJGc+X/W+DczBwQnXzLqe47Du9PRKLGnWrGlxixOy8SlCylsEbdMGRPrKQa8xnZ7sfnCaIalFo7jSbovLuJl+X1zA8Zmee/7sdg0gNXuGcpwZ/w48j0jie6Qwz1N1BzyQi15PZ146ibflaAy/R4HSrhzoNfYw5+w0X8949hC8KSkJSKWrrYRM8X4U+/RxGz2khnviAFu2uqmOhNN3cng6kzw46Lzok1OIjV95O2cFcuTJ24jt1lx9Xs1SratU8Aaxv5q+HQ9pwtgMq5HDh6aDvkCEH2m6748MPUGy+MPcjMGkFZUcWVvI2sJk3MrB1L4qhq/4TBmGiVosniHllhJzpgDjNrf3fvvXV/8HdLFCuNqPD6ZteY78g1YAeJiUiTiLkDT+i67i5gH4D+u4PyzbO6AAJfsaTRAOjzv2XuJcIFxPJ0hg2roe0yPQ7z96lh1avOYn/W9yRon5S0MicVIM1dNHHnKkbfd1Kx9Zx8sz68pnHU1OTbgG3XT2unjvsHjvinD0oDs506zPSnmht0jC83Zrs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mh160fTa+fCPRExHtEzmpr+LYPFbgFHmCNhOZSMwGYYwZ8YvDkkSFUs2pC4m?=
 =?us-ascii?Q?WF52TxztaMpcXGp+wt0f1tCNxCd4vg7N8J1B8cAxrWrth6Az/kOVirSBsnLT?=
 =?us-ascii?Q?ysGiOzFXE1NascWLzzuDNWEy21DTL6J2Vqb1hxLcGN3eFyiIkv0qv+30mXVu?=
 =?us-ascii?Q?eWbIaFGF9o3gI62loT2/QWb/b+u3LX4Ob1OKx7XPk47oFHediWvujxfO3bXg?=
 =?us-ascii?Q?0esxEtnp5hUTDzFojngioJz0eAUKMpTLyQE5ZqMmflJvn/3WwFZRDtNo6MfH?=
 =?us-ascii?Q?mjoUnqpkg0m+zjk3yyYyiFnkDhOApp00ToQcWAjcsonDVS45ITnUvmyZQ2L1?=
 =?us-ascii?Q?HN9zwxKMFWEcZbTXawZVequKfzr3WpjgaKl1wMl0fJyVGx2ozcXmS+cLuuZY?=
 =?us-ascii?Q?hlxCJ8x3gDAjaROKph2oNnyDqVs6LSFvhV5wAEFWKTNPild2ty8lw2ly7FMg?=
 =?us-ascii?Q?g1QUfyUCuFJV5TCUTq2wa3GsJyapwk6pT2GDES36rWsqyoirUDKYDGetULgC?=
 =?us-ascii?Q?LSam0HcCkcuSlfoVOEjspPh/dpR1ffVyXnPO6dHbFJq9t384GjF1+O70iYbz?=
 =?us-ascii?Q?mYZW5hT5JnFaJqh/OQHUDdnRTNzxBU5DVKYen55GqrVd8OxgCkq1vByehWtY?=
 =?us-ascii?Q?UV0GgMyrhi7cn/oxMwDgffHzD2FQZE8vAyIcHYlVTsgHk0DLJ0zbBFDeaeUR?=
 =?us-ascii?Q?LxoFHiEtrqG+UWptOO+TjibB2hQY3CtLU+TRKChOqKz7Ii2Wlx4UBR05LlTr?=
 =?us-ascii?Q?PWmyxJYL7GkLEoYSOY1LQDbkWNvYEJXoSvyg9i3mVwIV3PClvi93/xj1TwDw?=
 =?us-ascii?Q?YFvlz2wF43omiwyRGJIdW4OK3MrUxp7tIL2lJa+Lg089O5/MDV9ZsPnXBWzd?=
 =?us-ascii?Q?AZ1II927b6zbCreaOb5tXM/xakuCTffu/5/qUw2LAQQiy8b7HxvzLUlRNf7e?=
 =?us-ascii?Q?4LgKsyDJ/0C3MPAyg8rJWTHt9ktVdhXuz0y7UeFjO6fs8hfg0NDV3d6CF2yZ?=
 =?us-ascii?Q?B+TIUesekyWfvexJolJYo5/iIPtlDV/F7BzYVFK3xATqUeuLWFd01cZr36M8?=
 =?us-ascii?Q?nTdkYIim2YgZHe3Ewbb12HhYrrtEN3kuxrkdAwnItBV01f52MKAWMhzinL4c?=
 =?us-ascii?Q?1RVV6w9y80wclofGqtFeniHH5d+YOmH8QBRbyhaaNyU+4xQmR7xQsULelnXh?=
 =?us-ascii?Q?n5SC3FNq4nzEo3DTUJ3JXTKS2RE6UCNKCevOpro9ekwimfV2/Cg0zmeRMvdv?=
 =?us-ascii?Q?IzXd8ZZeG4aGWN9b7bRialTr1Rb6KoKDC9O7CQzLT+ovuNLT71uXm/5644GJ?=
 =?us-ascii?Q?H5Zti/O98JqgbZfmxW7PZQPmfJBOUKEsR4Q7ygslFj/W5jOgYQSUIx+pQy5+?=
 =?us-ascii?Q?OLmAi55wHfyB51k7vY80xRqpghZGDXbg9rT0wKGgOjoqYA6skC2aZBlA1WOp?=
 =?us-ascii?Q?4FqQPscOjFRgbgMopfYio97MgS9jv2+nvUXZVbyOxkt01QZhJ7hdyVxmypwT?=
 =?us-ascii?Q?8gH3JSXS+Py1oaQdjyy4CS0pGP+ISt2rzRJXKxUWLo/0DS3uXClMtdA1Q3F3?=
 =?us-ascii?Q?/uSRqcDDUxqQOSk+0Flg8+TVAjr/HTuDwhtE895N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17863839-7025-43b0-e53c-08dc5d335485
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 10:03:42.8882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PGSlhOLG2ol3s9IMj2M65oLS+3P/mT3wDGfymg8834YMThQAzM57nKKQC/+azJqhhWZGUeJysHPV5qD3jWbJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8911

From: Peng Fan <peng.fan@nxp.com>

Support System suspend notification. Using a work struct to call
pm_suspend. There is no way to pass suspend level to pm_suspend,
so use MEM as of now.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../firmware/arm_scmi/scmi_power_control.c    | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/scmi_power_control.c b/drivers/firmware/arm_scmi/scmi_power_control.c
index 6eb7d2a4b6b1..beafca9957c7 100644
--- a/drivers/firmware/arm_scmi/scmi_power_control.c
+++ b/drivers/firmware/arm_scmi/scmi_power_control.c
@@ -50,6 +50,7 @@
 #include <linux/reboot.h>
 #include <linux/scmi_protocol.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <linux/time64.h>
 #include <linux/timer.h>
 #include <linux/types.h>
@@ -90,6 +91,7 @@ struct scmi_syspower_conf {
 	struct notifier_block reboot_nb;
 
 	struct delayed_work forceful_work;
+	struct work_struct suspend_work;
 };
 
 #define userspace_nb_to_sconf(x)	\
@@ -249,6 +251,9 @@ static void scmi_request_graceful_transition(struct scmi_syspower_conf *sc,
 	case SCMI_SYSTEM_WARMRESET:
 		orderly_reboot();
 		break;
+	case SCMI_SYSTEM_SUSPEND:
+		schedule_work(&sc->suspend_work);
+		break;
 	default:
 		break;
 	}
@@ -277,7 +282,8 @@ static int scmi_userspace_notifier(struct notifier_block *nb,
 	struct scmi_system_power_state_notifier_report *er = data;
 	struct scmi_syspower_conf *sc = userspace_nb_to_sconf(nb);
 
-	if (er->system_state >= SCMI_SYSTEM_POWERUP) {
+	if (er->system_state >= SCMI_SYSTEM_MAX ||
+	    er->system_state == SCMI_SYSTEM_POWERUP) {
 		dev_err(sc->dev, "Ignoring unsupported system_state: 0x%X\n",
 			er->system_state);
 		return NOTIFY_DONE;
@@ -315,6 +321,16 @@ static int scmi_userspace_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static void scmi_suspend_work_func(struct work_struct *work)
+{
+	struct scmi_syspower_conf *sc =
+		container_of(work, struct scmi_syspower_conf, suspend_work);
+
+	pm_suspend(PM_SUSPEND_MEM);
+
+	sc->state = SCMI_SYSPOWER_IDLE;
+}
+
 static int scmi_syspower_probe(struct scmi_device *sdev)
 {
 	int ret;
@@ -338,6 +354,8 @@ static int scmi_syspower_probe(struct scmi_device *sdev)
 	sc->userspace_nb.notifier_call = &scmi_userspace_notifier;
 	sc->dev = &sdev->dev;
 
+	INIT_WORK(&sc->suspend_work, scmi_suspend_work_func);
+
 	return handle->notify_ops->devm_event_notifier_register(sdev,
 							   SCMI_PROTOCOL_SYSTEM,
 					 SCMI_EVENT_SYSTEM_POWER_STATE_NOTIFIER,
-- 
2.37.1


