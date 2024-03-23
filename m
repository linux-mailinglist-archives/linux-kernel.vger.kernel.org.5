Return-Path: <linux-kernel+bounces-112322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F470887859
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B735B216F2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE68A3E48C;
	Sat, 23 Mar 2024 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HDtr/cMl"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54A718659;
	Sat, 23 Mar 2024 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711195667; cv=fail; b=OOH7Ec4Y5OURlmDhLjJypxVCdnBHsWtQtq8FyfLxa5SlHrmVrTEDoarLDdvtZ5+CIIptYaDn3sOv9AHGZ0OC0Fryv+tGLLp+o4uuheKXx33GztUQ35Bz5f+8vZ2Ybk8Agxlr1KOCNrmcFG7bo8t1gkO10FUXyqXeI5hvDCwqZ/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711195667; c=relaxed/simple;
	bh=qjTs8qUzl7EwnxIdGYafwnlcF95X9rt0+iZVibIBUbg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Jwd355Y9p7ropWDxkt95oMO0/jtSEgQPVBf3V0c7UtmZZwbCR3+PMLH/6ONJ7x1xFbVp4t4QtWbk2a2QQKv/8rJulFd6LZxaMRG03+HJKmwcyxuhqexQoT85hke1GZwdFOEAttdLAdG2PW2pFB64+ydDHBzxirP2B9yGK1MO3E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HDtr/cMl; arc=fail smtp.client-ip=40.107.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+Kdy+q/UhTCbpuSKdf5IZ83UTKEaj8O2nmgPz9V77HS2vm/LJ1phTLbFeO/XiMprOupIs9YXfaBBXHeNEPyXyK1VqkAaxX2JRWnOa6sRr6UfX+5zFsz4BAiEiaeFpjNbulXEyA+o7xMWeOMALPqAR+/OFCJYee0yFVQ1IiYKTA/eHnmSMdfS49UPxv6cyTayHglBpo0318dyn2q1jVoOiJEx07SQFiHcndKM1Yxq7cE3fkUNTY0kAovPGa7T1U+EdsSx7imiIxDxKjgUBFI3Y+X6zANVIs+BQQDPvGPDnrBu1ey1Z6tP5BJwHMT7bfEHKP2nOC7SZjRBvL3T8MEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHNPcWftLWLkAPGzxEJd0Ra+N8iCWeIB6WzKxpGVt0E=;
 b=Et6eHrD2l6McztzjnX5iqurfuEWnsxTbN53F/EV1w/Xxb7MZkjJOYM58QFXUVtsmn9LFmkSCkYiSOPkwdUEdk7VQC8MCXfk6SB77BiD+25LwaWpjD/nL8jNaLC9Kw7SUdPl/SK6j9Akl/NUJsEzHudoRY9xbU5ZhNnt2TPcdciB7uODaBYCQBbNTrDm1OeF/ZZWXewhtF21GJlb8GbD7xxwcBWwPrVYl6s6GgOnLsy3YWdFEvvq5xsp7Wjtie0D/4Q8uAt5gnbHBXqfYUbWzlgqNowIAwvnTW9AN+ia/k4KW1LrjfnRpRMfrVLEu3DDlyEiHDBk6xaEHamqIgjpO0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHNPcWftLWLkAPGzxEJd0Ra+N8iCWeIB6WzKxpGVt0E=;
 b=HDtr/cMl4fwvn5rJLFMLMpn7u3/uB3cRP66ibDKmUi8GE3afgv+nRMkHE3Gp/jf6iuPOXQ0Rqr0pXye7rwf5gpOsn2RzSvZvF3x0P5hTw5DJ85UKuxJlrWQqhDt3/8ABtuOCElFlqTYiUncu+fbN66+CKfhJr87ooetF+JCARn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9585.eurprd04.prod.outlook.com (2603:10a6:10:316::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Sat, 23 Mar
 2024 12:07:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Sat, 23 Mar 2024
 12:07:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 23 Mar 2024 20:15:17 +0800
Subject: [PATCH v6 4/4] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-pinctrl-scmi-v6-4-a895243257c0@nxp.com>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
In-Reply-To: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711196144; l=18822;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=CC/Ed22/gPMkDQdaZQ+VKjMKDbtmNv4mvTyv3eV3s0k=;
 b=gInnj1qN5lHrtMY6nUSCvkbArwX9FYihGGSeC1LOyi/qOPkULWdmNyWxLeBsxIYIuO+wH/lKA
 28fRJNb7Iy5BUFEcm4VFruwUycDMAPYUwqkOOco2CROj/jPb0EFY30U
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU0PR04MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: aba87ca8-2571-43ff-3e90-08dc4b31d7b8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oVNBUvxCq+XlroWBY6CXF2C0Vf2t1XoqD24Gz9KToB/z06JOoksXrbp6XUax5U9KJBfY5fALYGl27G5DK+t8+5DeXkTBHEBWM5c5RncU2rXgLBhJPhspWj+NehczObsdBziExpAkaY2en+1osXEA/9CvlGJhjKbH336B2xEh4hkp8g3nn1Be0bm570X5PFN2VHqrH7vJvuqkzP1LKRiwoHLN5utalxo3fCBZazzWDW/6QGbb+9zf79ocOP/Pu3OiFuQLOxEFnQPEiN5x0iwIStNs4XuHBNkiLJMCymO0r5Gy/7dkrXhT3dayyqTB3TEQOVt6yn0EYrw7R2jr1PIt7SNeUsRf2/BX1vpScPEinNAMT1dsoX6nBynY27GNpreGLfFOFY4zcwHD5BE1wCI6nJiJtG0aGosOhS18slHI+G5BDU4sbJq+TjK2aHl1xyPH1aQ3RP6KspM9b7SE38QJwpb1rylVOVz4NuWV38kARvHkux7rXNGlcayOyGpjPJXi18Oh5ZY2ZdtywGw3FX4ixXOAC3YdWXIPcYJRuxnPRuhFoqcFpFUelm4l0gaf84qub3Fkffi9dYRccYQsaPMq3StbgmIe3wMFP3hUaXF4+Aw6eocmDt+dHI33Hn3DnxWqgKxgyIfWhAsubjG/sZX19evqSOLoZeI0TjhtC7pHOyO0wZ8I259q+qWhV8qO0OCz1WP5jrW8c7Tp5cPAaEw7gGzAJmeJTzB1qrxu/WdVcn0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(7416005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEZLVndManZlOU1RMkVOaVhIdXdsRTcxcENoMzduQ0xhYmxubWovMVZCWkxH?=
 =?utf-8?B?WkhuL0RBV2tqTUpoTDNEdlNNTUZnWlg4OURTT1FqT2FZai92MENFU0NicUwx?=
 =?utf-8?B?ZmxlS1p1ZE5DOEVVUWExQTBDL09MK1JlVTlPRVNTZXZmdVAzZDVRS2pMLzBE?=
 =?utf-8?B?NVhnczBqZjEyYmJBWlZsRVY2MkJoaktOQW8yUlkrVzJuZ0ZPTXp6TzJUdjc3?=
 =?utf-8?B?cHJWbmhFRitxc0xtd1dIdWJnVmxHY1ljaldXY3lQekdZM1NoNHNIR09iaDdK?=
 =?utf-8?B?Z1Vvc25mbitZMVFjaE0rdXBSOXE4MERERkVOQ0ROeEZ2V3JER0pET0dOYlh4?=
 =?utf-8?B?TEFQWURNL0FFcExDeUErc1BKcU9SU2ZRT1huVlNVSDQ5M3p6WVAzWDhFMmFk?=
 =?utf-8?B?ZEQxS2FQZUdJT1A1WENLdDVpNW50cURyVkxEdlNreEdXUmIrZjU1ekFsKytS?=
 =?utf-8?B?NG84QndidUdMMEthckMvK0l0Zm1wSTkvUC9iZmxKTFJ5djlQNGNudXNzYzIw?=
 =?utf-8?B?T0h4YzdiT3ZwTFp5cU9qMkRXVXJBMHVsUm54RlE1bDY2ZW1qc2N4UkVrdHRT?=
 =?utf-8?B?OGl5bFlPSzJmRXdOQWJrNWVQYUU2emNyTDNnL0RxYVRZODNhVkdpM0J2UmNF?=
 =?utf-8?B?UDBXUzEwSmN0cktVdkc3dWZ1SWp4YTlMUWJUUHFVNXZ6NDlOY255aEhUaEgv?=
 =?utf-8?B?LzViK3BIYk42N094K2h5Z0RjU0VGUjJQTVU2REdOZVNvbHFpUS93R3pDY3dL?=
 =?utf-8?B?dlo1OXc2MmRKZjRtM1k1bzcycE1ISEJreUJhQ0xYZHVKK3FwanE1enpJTnY1?=
 =?utf-8?B?d0Z2VVJIVlRrM1BYcDczem95QjJaRXJETVZGUks4OUljUHg5L2FudU5aY2t6?=
 =?utf-8?B?WkNkUDBmNE1WUVNOZjZ4RDlJM3pPQjNYd1Q2eWZVMEFiYnJPL0pPODZwLzZn?=
 =?utf-8?B?YVpEZzgrZW1EUG5ERlB0UWFKQjcwQ3N6ZFJTeUtmb3lQSjlXNHFBeTFVd2ty?=
 =?utf-8?B?amdHRS8wY3VqWWdGK3VDSC9HY2VzMGZVWkt1QmEvUUdmcHNNRVVUNW5kNlQ5?=
 =?utf-8?B?TmVrNmJKY3ZScENYakRZMEhldkQvWnFzMzV4R0E0N0QzTXRoTVh4bTM0WUhI?=
 =?utf-8?B?SEM3Ti9ZUWxXeWI2QzFObk91YnpBb3RiK25JdVpnN2c2QzFiRjh0cDVpekNF?=
 =?utf-8?B?OGpFa0RWbTZ0MHlYODVoY01FUllycm9JWXlUYk1jMWVGM3pPdnArbjAzeXV0?=
 =?utf-8?B?UWM2YmRkdi80cHJpdXZiNDFNUjFmZFJuSUp6bUtyOVk4TGFlSmoxUmRXQVdp?=
 =?utf-8?B?WW1PTzdTdG1FakVVSVp6bWxhZWVBekZDaGJ3ZXpGUlJrUW92cmlENldQTVJW?=
 =?utf-8?B?Vkp0d2RhWStpclB5T0RvQUlrQy9ieGJpYVB6UUJxRXAxZDM1MVJQTmZNOXRM?=
 =?utf-8?B?clFLRVFmdXY4S09ObUtnczlBQXhVV1pPczlmUkhXR2RlQmV4Y00xTHR1NWhi?=
 =?utf-8?B?RGloZEdIYkFuMHFvUlJYK0pLbHUzR2hoQXJ4cGl5dXRjOXFlQng5RlpqaWVo?=
 =?utf-8?B?c2tqWnF4OTdhTGsyQmdjeWZHRDRWd2wvUUF2UVNjMDhqLzRhTllqZlF5Yndo?=
 =?utf-8?B?TUlIaGtOS0V1MUNueWc5dW5PYVljaXRNUXNpYjNGSTUvaFU4MHo2ME1XTVJR?=
 =?utf-8?B?QVZuMk4yK09VeFlvWk5xKzVKT1lBUlpGckFzZmdtM1JIK1hGVU5ycTRKcGo2?=
 =?utf-8?B?YVRUM3RCUmppYkgrc2Uyb0Q4M3RzbzYydm1CMFdjYjdwQkJFRDNQMEoxTDA0?=
 =?utf-8?B?dzVNejFaS2VWTE5VOFJIcmMwZ3FHUDNyT0xrcUE0c2VmTG5vbG1tRTRtck1F?=
 =?utf-8?B?N0NlbG41SmtxeFpDVGNqNUtJU0VSSkVqWkN2K1N1RDFvYm9LbmdpZWh2SUhN?=
 =?utf-8?B?OXdTNjZ5S2RGVG5GSHlZZ2Z0T0liUVRQNFVqNnYzbS9vLzVHbmYxY2s2aE5V?=
 =?utf-8?B?SktoNFdXRjFjN240WkloTnJla0plQVRTV2g0QittTzI0L0hhb3FmbUdNYXE1?=
 =?utf-8?B?U0JFR2FydXdXbk5aMkxRYVBLSDJqRlIyZk5MMW50ZzA0a0RreGNseitPSWhz?=
 =?utf-8?Q?Bt3fABHIDFozetk6IX/cKkbfl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba87ca8-2571-43ff-3e90-08dc4b31d7b8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2024 12:07:42.6198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iAnwUM82qpPQcplqnNLKD7fP7q27LvhiuO/AnIjQZ5QNulyhhdD5jInPViMuiqIcHaTMe5HWyxYur30eYJUpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9585

From: Peng Fan <peng.fan@nxp.com>

scmi-pinctrl driver implements pinctrl driver interface and using
SCMI protocol to redirect messages from pinctrl subsystem SDK to
SCMI platform firmware, which does the changes in HW.

Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 MAINTAINERS                         |   1 +
 drivers/firmware/arm_scmi/pinctrl.c |   1 +
 drivers/pinctrl/Kconfig             |  11 +
 drivers/pinctrl/Makefile            |   1 +
 drivers/pinctrl/pinctrl-scmi.c      | 564 ++++++++++++++++++++++++++++++++++++
 5 files changed, 578 insertions(+)

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
diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
index 87d9b89cab13..0ecefe855432 100644
--- a/drivers/firmware/arm_scmi/pinctrl.c
+++ b/drivers/firmware/arm_scmi/pinctrl.c
@@ -465,6 +465,7 @@ scmi_pinctrl_settings_conf(const struct scmi_protocol_handle *ph,
 
 		tx = t->tx.buf;
 		tx->identifier = cpu_to_le32(selector);
+		tx->function_id = cpu_to_le32(0xFFFFFFFF);
 		attributes = FIELD_PREP(GENMASK(1, 0), type) |
 			FIELD_PREP(GENMASK(9, 2), chunk);
 		tx->attributes = cpu_to_le32(attributes);
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
index 000000000000..b23533bff63a
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -0,0 +1,564 @@
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
+	struct scmi_pinctrl_funcs *func;
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
+	if (func->num_groups)
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
+	groups = devm_kcalloc(pmx->dev, num_groups, sizeof(*groups), GFP_KERNEL);
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
+	func->num_groups = num_groups;
+	func->groups = groups;
+done:
+	*p_groups = (const char * const *)func->groups;
+	*p_num_groups = func->num_groups;
+
+	return 0;
+
+err_free:
+	devm_kfree(pmx->dev, groups);
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
+	ret = pinctrl_ops->settings_get(pmx->ph, _pin, PIN_TYPE, type,
+					&config_value);
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
+	ret = pinctrl_ops->settings_get(pmx->ph, group, GROUP_TYPE, type,
+					&config_value);
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
+	dev_dbg(pmx->dev, "got pins %d", npins);
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
+				      sizeof(*pmx->functions),
+				      GFP_KERNEL);
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


