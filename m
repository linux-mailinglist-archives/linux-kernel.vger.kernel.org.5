Return-Path: <linux-kernel+bounces-141740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB8B8A22D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0DA1C21D1B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E164A29;
	Fri, 12 Apr 2024 00:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IP91G4Du"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2077.outbound.protection.outlook.com [40.107.15.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C33E1C33;
	Fri, 12 Apr 2024 00:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712880806; cv=fail; b=uTRt6FTLq39KF6jPokP0c8iANeiv+mpZgVOBC1dZ75eHTzyLEJ1yg68m2X9chgDN7NdW2oI5t1JNV59UiPSy6lkh7aouZgnVVrLO71Jib+u7WLVzkOcFE8RA5t4Ql8VhiszRkJ9VmRkoybosxI2txC+oEQ4qvdtBPPIcH7mlkd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712880806; c=relaxed/simple;
	bh=RhCldLpWFoBisg6JxF8FQ42efMI/x7hxyuGNT8KbSHI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lmQbQaaWpzY+rU6q5NuPMOKhz6EAEHYOLNkxdGtAaH8+jEPHbNFu4kJWyKgnA3l+SwuQE9JptCpmL1lpW1MJeauhuEjvGQq09mNHFhI3oXXDIa6B/My1J1eiCpTVTwiCqM9JiooHgzsqT3rzsfgZNoRl9Dhx3Lgs0U8LlGAoJJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IP91G4Du; arc=fail smtp.client-ip=40.107.15.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVSQykCGrBwiilL1RK9zDkuHInK9UKMS47uklI0fNwJo5gxi2bpVq2FGQ5HQVhpiFR8ZCOWe6VSdOKFxvumRI1dW2XF8ktYnLoKBTMVT3Ka58phT+b9S5TC8xZeu+45XJ17JRv9HLNHBIRoz2rNxbKyKdHkA8rDS94XaIh+pWeaPc62glPa+pKyDnNUSJMBCTELhIaRRe7G4KqF6EF8xYH8UBPxId53SLtY9tXp5NhOGEXQOMG1ERslb0K2zkLSp8BVMpwIfv+GvWWe4uXMlfouxO4OKjtc/VwVlrj771rX5N93SxGkM6oPLwTRyoC8OuNnqzaFzBvnk5AvBwtW1AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y32EPUygoezOrwpSdGDK5Cezq+RoDLA6Ci/XuseYkwM=;
 b=FBmxoILX1UQd5eipnjOl/iDRIHFCU3kcDIZgruNWYe1OsuyViB5CyqwfffkY/xh3IFHGXVBeNsHq4BAzrKxFlOvQsRPmFdcebJicU1pH/fCcqgFm5lgu7ib1iwDy4uUiOqCCKFD+RWpV2MlIxhkuE3GNzUQvYwTFsCHIjSEKqNglJaXvCtGiplRo4OXtZ/GidIJEpQx2sbPlmNmm9bLp64gzX/VZiwxBUHU98DXajbGpu7FmKzGkqUO506RtnMii6k/HdHWDmbqEdm+0/Gs1lRmqaWyZaz8iIUDhV4XrxdlhrN/XN1NOPHhEKXY43SprOkYgxmQgk7cUCTO8vMx4HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y32EPUygoezOrwpSdGDK5Cezq+RoDLA6Ci/XuseYkwM=;
 b=IP91G4DuHjlTUWTamlXwhnDwvt8Ft6rPEptkwn1TRkKYZidd1aKPw69KsHoXFBchXumPz1CE0AaQcbH0gWwsBElOdfy8VXZ/23pku5XlqZXDvvM76XqvZ+OjTW4ZCIMscuwv0kJJkMEqyk4SsdGDQ81XmsfzqJkp+vkI9veRg5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7970.eurprd04.prod.outlook.com (2603:10a6:20b:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 00:13:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 12 Apr 2024
 00:13:21 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Apr 2024 08:21:19 +0800
Subject: [PATCH v9 1/4] firmware: arm_scmi: introduce helper
 get_max_msg_size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-pinctrl-scmi-v9-1-b817344d3a9a@nxp.com>
References: <20240412-pinctrl-scmi-v9-0-b817344d3a9a@nxp.com>
In-Reply-To: <20240412-pinctrl-scmi-v9-0-b817344d3a9a@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Dhruva Gole <d-gole@ti.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712881290; l=2695;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=fC1f9Mz+AZ7lC+TNU94i2E/beyKrQPUiXgoBP0YzZ74=;
 b=OWKxrw9ZZCr68dgQBzT6CIz1bMZDFPVrtHh03miHFm7/FTQeSEo29mpNmafConzXne3ZFHsuR
 uYoyvrruUbdAxU3H7c6tiN+KfEbvC9V4o/xkoNgX202KI65/TihAog7
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc3ff96-531c-4a52-c697-08dc5a855ce3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KgaywSO+DSPV90Ifrs/x6QgWLmkTwU97qvoqeeAVlQEXLPfHliR83Mlp/DJk1+7XRSQ3ucHsLOSZ8icb5YYmlCS4LH0h9yYzs1Fv8raYt6mpxg0SM95UMZQpBAdiLA7ML5BhpvwrWQFkbRX1LtVsHW8+3e7zc3OsT8+jzh8n0iLTlT23nm2+rSe42rEVnBlcwx6X2ncLJd1KvDWjrdfQvjzAT5paJojlNgohPIksFROax1JGj1l+d7nEQR5jgk0mPB0BDAl3mf5vT5HrzR7TgAQF5jhwk1asg53XZArfTu8KKrgHbB8OCjQJX8CFms7Q5xTvjnPXfAn8fT23bfY5fnetU8o1hJxCVA+oDS6wVwhoZsqyHHDZzb0zQtSjCiPSxz+UdjCBO/p5eW4ty1komxBWtWBftT6wiptfO7wd3oBna16x8lKdsvhMtPZhxqDonAQXnd0njT/NwXsUaxyDk58D5LML4/wOUzSotEFVUWNYIqAzJA0mvDDB6cjpwTTxZBQV9r9CmyCrHpY4Vdx2SZhPpmDg074XlDYc721r/6R/LMs8B9z6W8ewuASFZrULZgYY7eTsKI9POoVoW8ZVZa+fk97jDOr8gAbvsk4mHfZC4Rg8cKJ0yaOc5lzKLf27CvqZi9KCWgTZBI0el1fCeN/zC1+AJjAtoz1tO9wMdxYPVbLnd3wpQCTZRadB5bqDCrA0Se0yqYU+oGAwt5Zgbbiswsdh+u1Wvokcs18odyI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clFYaEdqKzJudmFtZFlGdlBBZFlCQlp4MW5rYTgyVWhhaGVYNE1tOFZCT2Q3?=
 =?utf-8?B?NERqOVVGaytiRVNTZ2VUMkNLTnVSOGgxZ0NZU2d3b005bmJYekRaeU1UOVdn?=
 =?utf-8?B?RzIzc3dRcGNKMDQwZ3B0bThjdU53L0NraXBrSkhZYlV2UHRFTkRxNzFybVMz?=
 =?utf-8?B?YTZUdzdpVzIvQzM4RThaRVlXUlc5NHlFc3BvUlpkMDBzVDcwMlE2RUFBUW9L?=
 =?utf-8?B?OVpmZVIxWU9YeXJRS0x6Y01nd3RUVUxQYmR5NkJ6VmlJR1lCSWRyanlGUGk5?=
 =?utf-8?B?NVIwRGNFTFlVMUpxVkd1Q2NJSnRtVVYzSGt3Y21lRWNxcWk4VnkrTU4yd3dZ?=
 =?utf-8?B?bHBESm9BbXZTU1hUVlpzVE9nTTduYmdBOXNvcHVjY2s3M0hiZTluU2FhVStk?=
 =?utf-8?B?eDgzZU9GeHhyQ3Z2OVBCRDRHWm1HL1VsVEIyNFNJNDFqZ29uMHFoRGRvZ2hh?=
 =?utf-8?B?SCs4WHJNMGVESEFhd3d3V0tLNmVWNkZwcTBFKy9jWmJDK2RQK1VrNm1qR1Va?=
 =?utf-8?B?ZlRCWlNGdGlFZzRvOGQwdDZ3QWNwQmVHd1hJOVRCMWRaTEw1Y3NOOGxrS1Rw?=
 =?utf-8?B?emNpS1dqOExaNnpqUlB5TjI5S1pPRDhRTlpsVjJhMTI3U2lnclZXTHZPeUl0?=
 =?utf-8?B?dmxIR1A1UU9DZ2FqTzZ6UW9DSGorWGM3enl5S05QSVBpdzBTMjRUdk13eGs3?=
 =?utf-8?B?dncyK0dEZWFpV0grVUZFblYvVExCUUV4QVNyUVFNQklRa3lHbzVldWNPb1Nh?=
 =?utf-8?B?MTZobG56dWpoVHpJa3lzZXROc1h4WU1oc1F1c01JcWxmb1dZSncySGs3R2Vu?=
 =?utf-8?B?TitJZ1gwWjU1NkF6RUJZVndUMVBDNU1TRzdxdktoejhpbUlIejlZb2FqYWxW?=
 =?utf-8?B?NDJsd2FKR21XQ0RIb09La09mYWRuWC9QQlpBa1NkdmJSN0lGQ3FEOUxZVjd1?=
 =?utf-8?B?dzQwTDhuNTd4UHhpU0pYN1JWZEQwLzdrNXR6T1JHY1plOVgzanY4djZwVXNI?=
 =?utf-8?B?RkZWaFlROVBRSUQybFVZa0poeDRUODR1eTRJMjhYR01CWTJ3N0JhWEJqUXkz?=
 =?utf-8?B?eGhGa2RVUCt0WmxYd3pUbERZeWZ6eXlnRkJLbTdjcHJ1cUYvMXluVWZKVjBR?=
 =?utf-8?B?bG45QmRCZ0JNZUlqMmI0SnJjMC9QQ0ZaalNqQnZYdUI2bWMrSXhJeWlQeEZB?=
 =?utf-8?B?NEx5aWEzQjRHdkZlOXNlV0tmcWNPRXk1dXo3ckpCejArdnhsYlJrLytkUHhJ?=
 =?utf-8?B?OHdPMU5JUUZvdmsrRXBQa2Jvb3lFRFdXSUo2R2tXa3haMTZPeFpXY3EzNWgy?=
 =?utf-8?B?UDZWT1BoeXY5VkNrNFFiZ1pmaEptNEt5UHc4WmVIN09YOUNOU0VYTm5PaEhC?=
 =?utf-8?B?dlFPWEpXNWZuVjBta2p1ZjY0Rkc2Q1pTWG9hdkhic1MrK3NZNFFFWW1QZnhS?=
 =?utf-8?B?RVYySnI1bHR1enBnQy9Fd0JBaHR1U2F3bk5SNzdFeUQvM2VVWk1yMEs1UkxJ?=
 =?utf-8?B?bENtbG0wNVpoQXd1SUcxOFpHTGZndXFmQS9XcFVBTzROVUNLcXVKNzVVL0t0?=
 =?utf-8?B?SzN1Z2kza1VnTmNqNXBldW5hQmI4TmxTdStVTmI2Q2dXRDU2L25xYUs2ZU5t?=
 =?utf-8?B?d3E5ZWFGNThPZEZNWEgxdHdUQXpRNWNzUmp2bVdoSVI3Z3VucTlVYndqdG5H?=
 =?utf-8?B?OW44Y21iYlBYampESE0xdHJNY2VTY2VFTjY1dGRmQUN5YzZ2K0hVQ3JQVldR?=
 =?utf-8?B?YXNyVnVpdlg2U0tJT0NYd0FkejdyU1hPZUxTUmFyVFFRTW5QMHUxWW42VmRU?=
 =?utf-8?B?bTF5SkdTWHVzeGY2Y2R6Y1pGNFpzTno2cjljaWdKUEw3SDM1ZG44b3U4ZVk2?=
 =?utf-8?B?a3pIVk1qYytwU2hkclBzU2xSYlord0dkcDh2VXNQS1o4Y1FXZ01XVzVqcUIx?=
 =?utf-8?B?S0pxTmhlazNqdzdvMXVVa0svZkJQaHBDdmZVWFBpTzZNZTFZTkpCT1NJUTFh?=
 =?utf-8?B?U0JYSS9nb3oxcDFzY3BLK1M5b0VpeHRxRmY2bi9ZM29xMzV0NFBXMWF5TEVP?=
 =?utf-8?B?RXVTUXNhMmZEQ2x1UWRzNHFyTVA3b2hxbVoyallNbE1pNGJXWDZnNnRkOXFV?=
 =?utf-8?Q?6URL9e1ZFk/9Iv9F12RKyz6Iz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc3ff96-531c-4a52-c697-08dc5a855ce3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 00:13:21.6230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GCxTuZdOTM0qWrUgksjH/7eSpRZ8UqaVk1CYhnHpREq4RcktyKd1I6V5pvk2GBO+vAZ+iGgfZTXGj1nS8Axsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7970

From: Peng Fan <peng.fan@nxp.com>

When Agent sending data to SCMI server, the Agent driver could check
the size to avoid protocol buffer overflow. So introduce the helper
get_max_msg_size.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/driver.c    | 15 +++++++++++++++
 drivers/firmware/arm_scmi/protocols.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 36e3eb50a8d4..a1e0e8fa4bb7 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1537,6 +1537,20 @@ static int scmi_common_extended_name_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+/**
+ * scmi_common_get_max_msg_size  - Get maximum message size
+ * @ph: A protocol handle reference.
+ *
+ * Return: Maximum message size for the current protocol.
+ */
+static int scmi_common_get_max_msg_size(const struct scmi_protocol_handle *ph)
+{
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+	struct scmi_info *info = handle_to_scmi_info(pi->handle);
+
+	return info->desc->max_msg_size;
+}
+
 /**
  * struct scmi_iterator  - Iterator descriptor
  * @msg: A reference to the message TX buffer; filled by @prepare_message with
@@ -1848,6 +1862,7 @@ static int scmi_protocol_msg_check(const struct scmi_protocol_handle *ph,
 
 static const struct scmi_proto_helpers_ops helpers_ops = {
 	.extended_name_get = scmi_common_extended_name_get,
+	.get_max_msg_size = scmi_common_get_max_msg_size,
 	.iter_response_init = scmi_iterator_init,
 	.iter_response_run = scmi_iterator_run,
 	.protocol_msg_check = scmi_protocol_msg_check,
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 317d3fb32676..3e91536a77a3 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -258,6 +258,7 @@ struct scmi_fc_info {
  * @fastchannel_init: A common helper used to initialize FC descriptors by
  *		      gathering FC descriptions from the SCMI platform server.
  * @fastchannel_db_ring: A common helper to ring a FC doorbell.
+ * @get_max_msg_size: A common helper to get the maximum message size.
  */
 struct scmi_proto_helpers_ops {
 	int (*extended_name_get)(const struct scmi_protocol_handle *ph,
@@ -277,6 +278,7 @@ struct scmi_proto_helpers_ops {
 				 struct scmi_fc_db_info **p_db,
 				 u32 *rate_limit);
 	void (*fastchannel_db_ring)(struct scmi_fc_db_info *db);
+	int (*get_max_msg_size)(const struct scmi_protocol_handle *ph);
 };
 
 /**

-- 
2.37.1


