Return-Path: <linux-kernel+bounces-132992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7230A899CFE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B4E288B41
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0886116ABDE;
	Fri,  5 Apr 2024 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HqFbqaLQ"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2133.outbound.protection.outlook.com [40.107.14.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA4716D4D1;
	Fri,  5 Apr 2024 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320316; cv=fail; b=Ma1IbtOTviK8L0Zk+NDQ62Qso5byxiiVBTmZWWTIVstfHYsxLRnPIPfpJohJTAD4QDZtw7fj0kIZccPOCqR7OMKG4DDc5kkropJwJ0gvggBvl0jnwTZFcbjj9hu/bxErRbvmYKIZ29HI54JId0rUMIHADo6JE3yFncBXfYByJnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320316; c=relaxed/simple;
	bh=Pb9SysegyYE0kNRoVfJpPtma28bQmPtlD+aoy+bIel4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tl5NM2HD4i3LnXb7tcXF0tk8T0eqSGNxjPj7VVxxY4bYLdDn+SBAwrtc+zwzI+bi6Ssi0OEkG3vV2SsXGKyWZVDgKdhbG2bgLmOO6eAO80dPusXADNxWNQrErkHWL8JFbdKM6VUrRUL1BAWKNWfKy2thNJbZImYVxuMRKYSCtI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HqFbqaLQ; arc=fail smtp.client-ip=40.107.14.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TndyTur/Md4JNFQsM6AiE5/inr88+tsVSVpVxPzgXoFxOtMubo9RuB+EjJVctnlGy42j/LqgmVnIIOikHVa2sePmhAJalU8O4gPQYlon3vkvSY/tqvEEZ4ISMRsaz5XW3KKhHQBbSADMeTBRbAdWYtvznmTEpg65HzwYx8dgHFKbsnW0ayzOk3Dd8pxC+wPSlULgXyeZX2bdsgq28jCYLEL1ZYJegPBSRh3RCPyqMFcMO4aHBFkeekFBPba1CkN8qfh93lHkQxn+ecszATLjxK1Oq+8tFjCi4RMyDWfyS3gOS20U+Ze23DPbrNmQ5RL3eIv1QrMQAF1xCp1VzrP5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DneiBipWLSqto+cMFsG+2hNqPiVlCSkqIUslw3YnNwg=;
 b=RV1AItWOgwqr36iGHefJlyGpdKAjZuFLOO1X0Xt7vwfTQhKXfAb4paChDNCIrA53fVlup2pIc3kpJoFTcto75NxZn4J4eAVehVT1KoTG/DIWY2ulItfwBDLS5KJ3SwS/c5h2MMoDLI8nWoY+gPxYMf/MbbrM2CBFnn1EV1Zo2ZiCUZdUGTdmBH8zLUIFoF1nUqxci7uUg9+0Z0Iuwhf734aS90Om2SrZ/PGDugbD9v294ox6nju7kyMMi918/m9HWWfjYYyN7D5eISqpPOueIOthZ5hLbcms4FDjszIXg9dX0zgNKMEYvLXujmlaNuyAJd4wdNNwE3ozGm54R2McHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DneiBipWLSqto+cMFsG+2hNqPiVlCSkqIUslw3YnNwg=;
 b=HqFbqaLQaCjU6dKCz8kQ3tGYFQSu4FdMd9YaRPB5IwCFZsXUFJ4ZeAFkGnKy6leREWDwvjzP8alRmLdSPk0RLNrTeHf9gEjudbbMkPw/JGXZNqUiS/EZc/+UGabv2BdjKmpt/kQpAHQzlHTxT/XL7PRWs/nLF44aWcg2SQeLC1w=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7744.eurprd04.prod.outlook.com (2603:10a6:102:c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 12:31:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 5 Apr 2024
 12:31:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 05 Apr 2024 20:39:25 +0800
Subject: [PATCH v2 3/6] firmware: arm_scmi: add initial support for i.MX
 BBM protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-imx95-bbm-misc-v2-v2-3-9fc9186856c2@nxp.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
In-Reply-To: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712320792; l=13006;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=f8vlPBXn372rggvzOyHbJ5Zxx2+A6HQ7e1t5EnI+uH8=;
 b=hrRd/zOB9wRTivSfoEAYrbEX1SEt231GmG75/CkvGJ9wItgxh2FqbadqghFhnY3u/fOaFbGUQ
 3ubU1s8sv1gBXUFPcRvPhvz9Nqzgs6FxXPpYSknpVbxbjy7wjLeX9OJ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7744:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P8GnPa61LeF/+GL2I/OmH5YSRPD7XviWRGDCE8mV3EjSa33pPWm3EO+dWV32YPWz4/pROfAPoR37X2VeSIOspRac9dKzA9pYZy+MGuX7mIA7btMwS5rO07rY7RFyOeH/p0g9AlBPjvIYWN2oMc2Z5ZbHD8NiYwM2kdJ6heLwsy7b/3/PDklghYsrxugbDGssyWAJvGJPHjVGYX6VPIAfGbwwGjTcTM2UGcq4RUUILfqToHPtDPFVWkR4QKa+KXYH8MvruHbdGN3TODwUNwO61Y5bPKiy2fdvJ/HYfhXKMelT9Fzpv8aihH3dHTUS+86PcA5Uzn6OkZ2jeizshL4pVKlnWB391ZWuLme4QDPPh4RWyQyc9PYXdanpUzeC5wwCq2zuabgyfewWiQSt5etqCCW1ao5Dmb6x8K2QTVhJUNZZt25fPssg2zkrwkOT+5KpmCzRHSARaxqIHXc3o392A6Tpa29PQcpqIxcZJpKEAiVPzk1N4Q02c3RjAObXYAL3Bp3rJNzNpKJxSbFF6VyvSzPVTAMUBfw4LinhyEqQTbiUizHk5yDrArfS4NDWshydZK5UhAfi7eAHt7xMWMQuIg1dknDs66QCPmx/w647j4EI3Mj5Wo81HwsnY7QjEPDaxeZK7iH2/HsOdFHINbFM3R1PYLYT9q+vFjGgNrboGF5LxquKQeGuiI0WBPC5AHzbHZynblGCKj/frz5hW66gwduAdZcfb3N2f2SWsOQI0RE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjJxelByRUpkcmhpeW9lSjlkVGRDbk9hM0c0YjdrYy9TZ1QxSFlSQktyYVBI?=
 =?utf-8?B?a2J4eWhkdGlhTmlsdnlCNnQwT25JelZXaDV3bEo3aVpGN2lRK0FpTXVXV0o3?=
 =?utf-8?B?YU1YRXdWUjQvVVJUekJpQVBVWHVJWm03RG9QUlZzTnh3aEExd0tLZUFRK1lJ?=
 =?utf-8?B?UnZBNDFXOUlDaEMybVA1SnN0OEJmNHg4a05sYzd4OEVCUHBlbzZlalVxMkkr?=
 =?utf-8?B?cXVhMG5PeXBLanhxaFpZbVl4VDNOcS9YUzNhVnZockdEbk4xRjk1eTArYTVH?=
 =?utf-8?B?RnV3VXZ6c1ZqSmhaWVJrQW1lNkw2VnpDQ0hHbHUvSnR3VzAwL21jMlAxN3VQ?=
 =?utf-8?B?YTdCbFp5RmpBWXZXeEpDdjQvYTk3RzR6NDFlVERFa3lIS01YcnVkNEtqNStN?=
 =?utf-8?B?UFJCUWp5YUc4MUtmVmdLU2hkUEhkaDkvTWx5V3VUZno4STF2Rm9rRThvOEcw?=
 =?utf-8?B?WU1yMzZlc1JHekxGak5BMFJ6MFFtYVVZeTNnTW9BVC9jaEJTWFdpVDBibW1y?=
 =?utf-8?B?dEZNMjVUaUVNSkMxM2NGK0YyQWtGR29iZXdMbjBNUitKd2FKYjhhY3ViTXdV?=
 =?utf-8?B?MExqWGRFZHJ1MUU0MklEbDlhMFI3NWFSZnNwY2NoTWJtWmJEN0xrUVAwNUJT?=
 =?utf-8?B?b0xVWmNjekZ0KzFzcTl2b0ZYSWp2U3pWOFdQcjFnbm5iR2tZdVhUOWNnTlF1?=
 =?utf-8?B?K3VIRDEvNEZ1Q1dqU1pyemFwMWNGZkZpVWN5UFFLdlM1bXR4L2J3eVlua0Vi?=
 =?utf-8?B?RXZ4Vm1hTHdwbG1GSGVXeTZpOTgrenlzMW12RUw2NjcvVm8vUVd6UXB2aDVN?=
 =?utf-8?B?a1NJalNac3FaRER2VjREUGMxRStFL1RveGZlc1Zoc3ZNU1BoZDUxVTBnSjNB?=
 =?utf-8?B?cEozZXM2Mmh3UytKb2lNYkIwWmxGMHVlVmVVMEM0b3RWaXhWcDVYWkxTVWVP?=
 =?utf-8?B?NEZJakE0RE9aNUJNdlFkVFRRcWVhTk05TmpRTm5EQmRLc0V3N3BkNktGU1Bn?=
 =?utf-8?B?bTN2bkR2Y1VQUVNmZkdjSzNNT25XQUtpOW9yakNpcmh1aU5VZlNBYlBuN0lO?=
 =?utf-8?B?OExUUm9OUWdVWEsyRk45SnJONnpBUnVkRWpwbVc2bjhpOUpWR1lxTFRpd0hS?=
 =?utf-8?B?WGRYRkdVZVpSdHZmRW9uemVVS0V6L0ZkVU5uNkQ5SGFRaE5NZUU3NENBcksx?=
 =?utf-8?B?TTZCQnI2U0JEMUF4L3FscDZNRU5hRHBRaEZvOFpCRGNkQzZMbjg0Y0JEaWNl?=
 =?utf-8?B?WWU3OWI0SXZsVDFRNFVpM01YSGtpK1BONWsveVlLUC9CbnFqdVZzQ2dYc0tl?=
 =?utf-8?B?SHdwb2FUTnJZaUVUUUF2NnFXSDJFVnJuZ04xY0NJUkJ4V2llblpvcTZmaDQ3?=
 =?utf-8?B?c1c3WXFqOFpwQzJINVVCYjg4UktDMmxXWnFkOU4wUVlQTGFVRHB0Y1RDU1hV?=
 =?utf-8?B?SEhCeW5KWWJhM0NjcnR1TWI1R2krM1BpRnlmd2dmclRvaU5XQ0NJVHVNQmpp?=
 =?utf-8?B?SHoxWG91TDMrMCs3ZWZ2cGhrbkczUHZCK3pxYk9TeHFHY0k3R0xsME1mM2Vs?=
 =?utf-8?B?QUVqQlJwdzlPblVCWjdqT1YzSER0S0VWVFNteTU0M2drTDNvdEV1bzMzYVY2?=
 =?utf-8?B?dCttMjVRWlg1NzZLUENEdUFZMlZTRWVzSDZZbnBOOXc3K3FvYTd6aXdNY2ti?=
 =?utf-8?B?MVRHQWMvMXZ6UEU2WkRxeDhBYXRqZnhwTVgxNVduRVh1Q05paENaZC9jWlRD?=
 =?utf-8?B?WkRRWFB5TGcrS0RFYStaQy9mQVhiWC9sT1pCbzhON2FERTZUMldoSEk0emF5?=
 =?utf-8?B?R2MrK3NmejFWSWtIWDdCWVcrR0ExZXFBbHdTcTJoR3YzK3N0cFFQU3U0d3lx?=
 =?utf-8?B?OERwdm9uWXlJUGtJUTJ1ZjVEWk5ncDZhc3U5eDVQeWZHOHZ6NWF0Smc3MmNz?=
 =?utf-8?B?dk55TWdyUFh3eGNGMTdXMjN3WVVQOVNOSWdyck00YTJQeHdmZVlJaFA5a2VQ?=
 =?utf-8?B?Tk9YTW8veVRVY3NNclNlVmY5ZWFmdUMrNEt4bkxhdjM4V1d2MEQ1S2hRLy9o?=
 =?utf-8?B?RGJzOTZVMERlbHdUVWZ5RGJoZ0I4WGFlYkc4Y2VZRFFIWUFxR0JqcG55QUt2?=
 =?utf-8?Q?W+YDhVfoUvtyznIN6m6XL84Om?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a700ed-04c3-47e2-34f9-08dc556c5e39
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 12:31:50.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEgqRkLBZ1kwvo31rdRBSqSrVHpNPiX0nKPMAaZluWMgLWKosOSIFgVSHGfmrIydU0xoLR1EB74b7CtE/aAbMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7744

From: Peng Fan <peng.fan@nxp.com>

The i.MX BBM protocol is for managing i.MX BBM module which provides
RTC and BUTTON feature.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/Kconfig      |  10 +
 drivers/firmware/arm_scmi/Makefile     |   1 +
 drivers/firmware/arm_scmi/imx-sm-bbm.c | 378 +++++++++++++++++++++++++++++++++
 include/linux/scmi_imx_protocol.h      |  45 ++++
 4 files changed, 434 insertions(+)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index aa5842be19b2..56d11c9d9f47 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -181,3 +181,13 @@ config ARM_SCMI_POWER_CONTROL
 	  early shutdown/reboot SCMI requests.
 
 endmenu
+
+config IMX_SCMI_BBM_EXT
+	tristate "i.MX SCMI BBM EXTENSION"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y if ARCH_MXC
+	help
+	  This enables i.MX System BBM control logic which supports RTC
+	  and BUTTON.
+
+	  This driver can also be built as a module.
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index a7bc4796519c..327687acf857 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -11,6 +11,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
+scmi-protocols-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
 scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
diff --git a/drivers/firmware/arm_scmi/imx-sm-bbm.c b/drivers/firmware/arm_scmi/imx-sm-bbm.c
new file mode 100644
index 000000000000..92c0aedf65cc
--- /dev/null
+++ b/drivers/firmware/arm_scmi/imx-sm-bbm.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) NXP BBM Protocol
+ *
+ * Copyright 2024 NXP
+ */
+
+#define pr_fmt(fmt) "SCMI Notifications BBM - " fmt
+
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+
+#include "protocols.h"
+#include "notify.h"
+
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
+
+enum scmi_imx_bbm_protocol_cmd {
+	IMX_BBM_GPR_SET = 0x3,
+	IMX_BBM_GPR_GET = 0x4,
+	IMX_BBM_RTC_ATTRIBUTES = 0x5,
+	IMX_BBM_RTC_TIME_SET = 0x6,
+	IMX_BBM_RTC_TIME_GET = 0x7,
+	IMX_BBM_RTC_ALARM_SET = 0x8,
+	IMX_BBM_BUTTON_GET = 0x9,
+	IMX_BBM_RTC_NOTIFY = 0xA,
+	IMX_BBM_BUTTON_NOTIFY = 0xB,
+};
+
+#define GET_RTCS_NR(x)	le32_get_bits((x), GENMASK(23, 16))
+#define GET_GPRS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
+
+#define SCMI_IMX_BBM_NOTIFY_RTC_UPDATED		BIT(2)
+#define SCMI_IMX_BBM_NOTIFY_RTC_ROLLOVER	BIT(1)
+#define SCMI_IMX_BBM_NOTIFY_RTC_ALARM		BIT(0)
+
+#define SCMI_IMX_BBM_RTC_ALARM_ENABLE_FLAG	BIT(0)
+
+#define SCMI_IMX_BBM_NOTIFY_RTC_FLAG	\
+	(SCMI_IMX_BBM_NOTIFY_RTC_UPDATED | SCMI_IMX_BBM_NOTIFY_RTC_ROLLOVER | \
+	 SCMI_IMX_BBM_NOTIFY_RTC_ALARM)
+
+#define SCMI_IMX_BBM_EVENT_RTC_MASK		GENMASK(31, 24)
+
+struct scmi_imx_bbm_info {
+	u32 version;
+	int nr_rtc;
+	int nr_gpr;
+};
+
+struct scmi_msg_imx_bbm_protocol_attributes {
+	__le32 attributes;
+};
+
+struct scmi_imx_bbm_set_time {
+	__le32 id;
+	__le32 flags;
+	__le32 value_low;
+	__le32 value_high;
+};
+
+struct scmi_imx_bbm_get_time {
+	__le32 id;
+	__le32 flags;
+};
+
+struct scmi_imx_bbm_alarm_time {
+	__le32 id;
+	__le32 flags;
+	__le32 value_low;
+	__le32 value_high;
+};
+
+struct scmi_msg_imx_bbm_rtc_notify {
+	__le32 rtc_id;
+	__le32 flags;
+};
+
+struct scmi_msg_imx_bbm_button_notify {
+	__le32 flags;
+};
+
+struct scmi_imx_bbm_notify_payld {
+	__le32 flags;
+};
+
+static int scmi_imx_bbm_attributes_get(const struct scmi_protocol_handle *ph,
+				       struct scmi_imx_bbm_info *pi)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_imx_bbm_protocol_attributes *attr;
+
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0, sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		pi->nr_rtc = GET_RTCS_NR(attr->attributes);
+		pi->nr_gpr = GET_GPRS_NR(attr->attributes);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_bbm_notify(const struct scmi_protocol_handle *ph,
+			       u32 src_id, int message_id, bool enable)
+{
+	int ret;
+	struct scmi_xfer *t;
+
+	if (message_id == IMX_BBM_RTC_NOTIFY) {
+		struct scmi_msg_imx_bbm_rtc_notify *rtc_notify;
+
+		ret = ph->xops->xfer_get_init(ph, message_id,
+					      sizeof(*rtc_notify), 0, &t);
+		if (ret)
+			return ret;
+
+		rtc_notify = t->tx.buf;
+		rtc_notify->rtc_id = cpu_to_le32(0);
+		rtc_notify->flags =
+			cpu_to_le32(enable ? SCMI_IMX_BBM_NOTIFY_RTC_FLAG : 0);
+	} else if (message_id == IMX_BBM_BUTTON_NOTIFY) {
+		struct scmi_msg_imx_bbm_button_notify *button_notify;
+
+		ret = ph->xops->xfer_get_init(ph, message_id,
+					      sizeof(*button_notify), 0, &t);
+		if (ret)
+			return ret;
+
+		button_notify = t->tx.buf;
+		button_notify->flags = cpu_to_le32(enable ? 1 : 0);
+	} else {
+		return -EINVAL;
+	}
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static enum scmi_imx_bbm_protocol_cmd evt_2_cmd[] = {
+	IMX_BBM_RTC_NOTIFY,
+	IMX_BBM_BUTTON_NOTIFY
+};
+
+static int scmi_imx_bbm_set_notify_enabled(const struct scmi_protocol_handle *ph,
+					   u8 evt_id, u32 src_id, bool enable)
+{
+	int ret, cmd_id;
+
+	if (evt_id >= ARRAY_SIZE(evt_2_cmd))
+		return -EINVAL;
+
+	cmd_id = evt_2_cmd[evt_id];
+	ret = scmi_imx_bbm_notify(ph, src_id, cmd_id, enable);
+	if (ret)
+		pr_debug("FAIL_ENABLED - evt[%X] dom[%d] - ret:%d\n",
+			 evt_id, src_id, ret);
+
+	return ret;
+}
+
+static void *scmi_imx_bbm_fill_custom_report(const struct scmi_protocol_handle *ph,
+					     u8 evt_id, ktime_t timestamp,
+					     const void *payld, size_t payld_sz,
+					     void *report, u32 *src_id)
+{
+	const struct scmi_imx_bbm_notify_payld *p = payld;
+	struct scmi_imx_bbm_notif_report *r = report;
+
+	if (sizeof(*p) != payld_sz)
+		return NULL;
+
+	if (evt_id == SCMI_EVENT_IMX_BBM_RTC) {
+		r->is_rtc = true;
+		r->is_button = false;
+		r->timestamp = timestamp;
+		r->rtc_id = le32_get_bits(p->flags, SCMI_IMX_BBM_EVENT_RTC_MASK);
+		r->rtc_evt = le32_get_bits(p->flags, SCMI_IMX_BBM_NOTIFY_RTC_FLAG);
+		dev_dbg(ph->dev, "RTC: %d evt: %x\n", r->rtc_id, r->rtc_evt);
+		*src_id = r->rtc_evt;
+	} else if (evt_id == SCMI_EVENT_IMX_BBM_BUTTON) {
+		r->is_rtc = false;
+		r->is_button = true;
+		r->timestamp = timestamp;
+		dev_dbg(ph->dev, "BBM Button\n");
+		*src_id = 0;
+	} else {
+		WARN_ON_ONCE(1);
+		return NULL;
+	}
+
+	return r;
+}
+
+static const struct scmi_event scmi_imx_bbm_events[] = {
+	{
+		.id = SCMI_EVENT_IMX_BBM_RTC,
+		.max_payld_sz = sizeof(struct scmi_imx_bbm_notify_payld),
+		.max_report_sz = sizeof(struct scmi_imx_bbm_notif_report),
+	},
+	{
+		.id = SCMI_EVENT_IMX_BBM_BUTTON,
+		.max_payld_sz = sizeof(struct scmi_imx_bbm_notify_payld),
+		.max_report_sz = sizeof(struct scmi_imx_bbm_notif_report),
+	},
+};
+
+static const struct scmi_event_ops scmi_imx_bbm_event_ops = {
+	.set_notify_enabled = scmi_imx_bbm_set_notify_enabled,
+	.fill_custom_report = scmi_imx_bbm_fill_custom_report,
+};
+
+static const struct scmi_protocol_events scmi_imx_bbm_protocol_events = {
+	.queue_sz = SCMI_PROTO_QUEUE_SZ,
+	.ops = &scmi_imx_bbm_event_ops,
+	.evts = scmi_imx_bbm_events,
+	.num_events = ARRAY_SIZE(scmi_imx_bbm_events),
+	.num_sources = 1,
+};
+
+static int scmi_imx_bbm_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	u32 version;
+	int ret;
+	struct scmi_imx_bbm_info *binfo;
+
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_info(ph->dev, "NXP SM BBM Version %d.%d\n",
+		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	binfo = devm_kzalloc(ph->dev, sizeof(*binfo), GFP_KERNEL);
+	if (!binfo)
+		return -ENOMEM;
+
+	ret = scmi_imx_bbm_attributes_get(ph, binfo);
+	if (ret)
+		return ret;
+
+	return ph->set_priv(ph, binfo, version);
+}
+
+static int scmi_imx_bbm_rtc_time_set(const struct scmi_protocol_handle *ph,
+				     u32 rtc_id, u64 sec)
+{
+	struct scmi_imx_bbm_info *pi = ph->get_priv(ph);
+	struct scmi_imx_bbm_set_time *cfg;
+	struct scmi_xfer *t;
+	int ret;
+
+	if (rtc_id >= pi->nr_rtc)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, IMX_BBM_RTC_TIME_SET, sizeof(*cfg), 0, &t);
+	if (ret)
+		return ret;
+
+	cfg = t->tx.buf;
+	cfg->id = cpu_to_le32(rtc_id);
+	cfg->flags = 0;
+	cfg->value_low = lower_32_bits(sec);
+	cfg->value_high = upper_32_bits(sec);
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_bbm_rtc_time_get(const struct scmi_protocol_handle *ph,
+				     u32 rtc_id, u64 *value)
+{
+	struct scmi_imx_bbm_info *pi = ph->get_priv(ph);
+	struct scmi_imx_bbm_get_time *cfg;
+	struct scmi_xfer *t;
+	int ret;
+
+	if (rtc_id >= pi->nr_rtc)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, IMX_BBM_RTC_TIME_GET, sizeof(*cfg),
+				      sizeof(u64), &t);
+	if (ret)
+		return ret;
+
+	cfg = t->tx.buf;
+	cfg->id = cpu_to_le32(rtc_id);
+	cfg->flags = 0;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*value = get_unaligned_le64(t->rx.buf);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_bbm_rtc_alarm_set(const struct scmi_protocol_handle *ph,
+				      u32 rtc_id, u64 sec)
+{
+	struct scmi_imx_bbm_info *pi = ph->get_priv(ph);
+	struct scmi_imx_bbm_alarm_time *cfg;
+	struct scmi_xfer *t;
+	int ret;
+
+	if (rtc_id >= pi->nr_rtc)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, IMX_BBM_RTC_ALARM_SET, sizeof(*cfg), 0, &t);
+	if (ret)
+		return ret;
+
+	cfg = t->tx.buf;
+	cfg->id = cpu_to_le32(rtc_id);
+	cfg->flags = SCMI_IMX_BBM_RTC_ALARM_ENABLE_FLAG;
+	cfg->value_low = lower_32_bits(sec);
+	cfg->value_high = upper_32_bits(sec);
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_bbm_button_get(const struct scmi_protocol_handle *ph, u32 *state)
+{
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, IMX_BBM_BUTTON_GET, 0, sizeof(u32), &t);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*state = get_unaligned_le32(t->rx.buf);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static const struct scmi_imx_bbm_proto_ops scmi_imx_bbm_proto_ops = {
+	.rtc_time_get = scmi_imx_bbm_rtc_time_get,
+	.rtc_time_set = scmi_imx_bbm_rtc_time_set,
+	.rtc_alarm_set = scmi_imx_bbm_rtc_alarm_set,
+	.button_get = scmi_imx_bbm_button_get,
+};
+
+static const struct scmi_protocol scmi_imx_bbm = {
+	.id = SCMI_PROTOCOL_IMX_BBM,
+	.owner = THIS_MODULE,
+	.instance_init = &scmi_imx_bbm_protocol_init,
+	.ops = &scmi_imx_bbm_proto_ops,
+	.events = &scmi_imx_bbm_protocol_events,
+	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
+};
+
+module_scmi_protocol(scmi_imx_bbm);
diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
new file mode 100644
index 000000000000..90ce011a4429
--- /dev/null
+++ b/include/linux/scmi_imx_protocol.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SCMI Message Protocol driver NXP extension header
+ *
+ * Copyright 2024 NXP.
+ */
+
+#ifndef _LINUX_SCMI_NXP_PROTOCOL_H
+#define _LINUX_SCMI_NXP_PROTOCOL_H
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/notifier.h>
+#include <linux/types.h>
+
+enum scmi_nxp_protocol {
+	SCMI_PROTOCOL_IMX_BBM = 0x81,
+};
+
+struct scmi_imx_bbm_proto_ops {
+	int (*rtc_time_set)(const struct scmi_protocol_handle *ph, u32 id,
+			    uint64_t sec);
+	int (*rtc_time_get)(const struct scmi_protocol_handle *ph, u32 id,
+			    u64 *val);
+	int (*rtc_alarm_set)(const struct scmi_protocol_handle *ph, u32 id,
+			     u64 sec);
+	int (*button_get)(const struct scmi_protocol_handle *ph, u32 *state);
+};
+
+enum scmi_nxp_notification_events {
+	SCMI_EVENT_IMX_BBM_RTC = 0x0,
+	SCMI_EVENT_IMX_BBM_BUTTON = 0x1,
+	SCMI_EVENT_IMX_MISC_CONTROL_DISABLED = 0x0,
+	SCMI_EVENT_IMX_MISC_CONTROL_FALLING_EDGE = 0x1,
+	SCMI_EVENT_IMX_MISC_CONTROL_RISING_EDGE = 0x2,
+};
+
+struct scmi_imx_bbm_notif_report {
+	bool			is_rtc;
+	bool			is_button;
+	ktime_t			timestamp;
+	unsigned int		rtc_id;
+	unsigned int		rtc_evt;
+};
+#endif

-- 
2.37.1


