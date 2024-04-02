Return-Path: <linux-kernel+bounces-127282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD7D894930
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E9ADB22BA7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0813A134B0;
	Tue,  2 Apr 2024 02:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="N8sKeHH/"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2109.outbound.protection.outlook.com [40.107.6.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA91DDAB;
	Tue,  2 Apr 2024 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024072; cv=fail; b=Qi75WqGSPt2+OedqB1MQHZpJ1fktJYgh6ioNo81qzOg/t6crpUYLc/OHYvraVcxV8DnyiOR1MDJXaZU/ppcTwGws7nKmNQi3qB61x990amct71GiekzBiTgDmJeiMlCk0Oya59MI24Ck0HcYXft8q1RLOd2lYHiwX92+uKIHEsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024072; c=relaxed/simple;
	bh=t5HLy5gFexuRUd/gcXkLur0tNUBqrWNFLScENOV0ZWY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KzU9zNHe7tO9PuSQfL/NkG1c854sOeMWDYYP9/l6RRuPl3y+QfmbzadlksMYERYCSrhIktvAHPMqv7qIv3ig0WCcXtAwH+AK3kbgZFoEf09XHZIAtiJRq0jeXd315umtujNkd4LVWO9VHdynBhrQaeXpc/nVS/oVHUBSrHugHu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=N8sKeHH/; arc=fail smtp.client-ip=40.107.6.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGY80pORGK0V5WXK5F+QvloLNgl0JFKxwdj5JOvCbDAhJnV5wHT/BdwyjvgaPA6wlyCmPfDd+xHb0SaQbdv/LCws3Wm7vkwsLrxDu+iv2VQaMvuW+NfRmQq4YULds20BXvPIHL0+0KSck7evtYWXQVzJ+W2mVmmp33hiHEhyzKhgcWDx71TJRy5+0UyjltGDsy3014A3Sgbf0d8qsqu5pT9tv6BZuY2NgrvoDiR9MSD7477oj05aJ3a2jsbrHcax85IOc7Fw6pRgsvqLv4u9cYMtK7YoKS1hbNGdyLqig86WAP3lv27Q07oY92AZy8DB/wA0zq18FG+JoyS9gnA/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkhFzy347CReKh8Y/3De5x5m9e7u839I/9k6SdaIf8U=;
 b=mV5KuqQjWfeKmIYlAK9YyOO/Cr7iTLfv3O+0NTI5nSKZY4/F4FHmgczr2um6oGD+xmCyEtYCogYVKTTiqPfJhANUfzUzGe8LVOdn7O4rG3GUlWnIP5AU6OSRfUral7bezCRp1pV/rjno8wmACdC+SAzr0NC2ibdbRjpTXb2RMe76vt6wNjxkJIBP5x0rga18qR+Zih7e3y8fIb7Erux2+DfzgxU3kZVUh2BWff0na4ERDYhNis1enlm6PdVWxfbypTKi/D7VysHohwLMy0kByg9VUTyokPUHg+4jioFKpHxJDPbdopb3/2zCs9QJpKIz8vwC1QcEpSl5YeyFlNB1yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkhFzy347CReKh8Y/3De5x5m9e7u839I/9k6SdaIf8U=;
 b=N8sKeHH/M8AdyTjnZdNWgq8fFGuqKr4AnJOyzoD4ZT0Wwr/e8Vn4tyWHHpBfrYVA3skKMN4D5CofyZaFUuMdSFZLKZfM2/6L6y3Volx6LmuIoeNJr3/rlX7QDogUtv6B+Ot9eIuhjlnuQfF89EcXwgC6DRgEWEWHd+XSgtqQaII=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI0PR04MB10163.eurprd04.prod.outlook.com (2603:10a6:800:245::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 02:14:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Tue, 2 Apr 2024
 02:14:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 02 Apr 2024 10:22:21 +0800
Subject: [PATCH v7 1/4] firmware: arm_scmi: introduce helper
 get_max_msg_size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-pinctrl-scmi-v7-1-3ea519d12cf7@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712024557; l=2653;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=dKDsMHnM+cuvfvX6K6tAU3ADCasBJe+OHaz6qBQ1Tuc=;
 b=BXEvqDrMweYTrQWmeCX90oHZaEQ8sAgyCC+pFmkKF6QbH71xD0VSg0R59q76yjlcUJqjT+YPX
 8bCHxaQc6NRDkbLO8e8F07O4pdjxaJT1bPKITT7N7CGrM0ypjjIEWXi
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
	XeY4g3fFyAd3tOJanD9V5prcD+bNXO2c53OXcLUOnQh7TH3ElRBmgMedEtiLLJHOk5bgjRx3oG6ryobMN4TnTrJfsKihDeG1PEbsb59xXtAOk5PEiFxmB7JD/bFOLs2pZ1Vd74pPYRUKFGiqYNsDXQWzEVXWXIrwR9HEcrNeyw+W7VuFe6wixkWdbA7M0VbJ7LDAOrJr7nQ62UufVdOWnUmXWftHPGIzMeAUEpav0Y5ePuCcqABUA/oLcUp3mxDMSVBTUiPayjjb3lET5GvL6StP6vZaCIpZSUyZw85sl4HpgvKAje1Xu6jyy6vFRF2bcbKhgXc9eGNPH4r8ZAR6OR79Q95buGc62qS1n6dvdTZgPfSUdzEyOTHWV3nyV3EcXoPoOF1UctRH3XalHLEXm25/9e+i5Qe4lHfGaRP6rtCmk2MHL9oohPBRjDYtXCkEphGpeRNOt9n2Bj4LGdfQslb2ZRFrwvS8A86oQVLW9arMlOoPtQwRqmE83aA3vDdcr5EqBpK2TjOV7VF7m/wATwiMiQ5Q/v0V9R7rg4pGFdBkNJjMZTBTwR8Q9LLq56bKqsJ0Ka4WG3qJj0tZfweA7pVgO0em+z7ip4Pe5rfW0DKWp1SZzF+dJT9SkihReIrmJ8TIh84EeYz8ICj05KfM1HlCoeYf7ueGIi0ZoszKqTs77xM2h1spotnLiD2KPNKmuBGG81ReQq9FrBMYNKSDb621DHqXbXMYPiv5f7P1hdM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlJRbytXbXNSNkJvdDVnR1oxa3Y5M1RYeG1LUVltSi9FYmdoK3Z5ZWlRNkk0?=
 =?utf-8?B?SWtSNHF0SjZSaVRud1JEcUxDT2pFUjBnQXJUV2VUa2FucXRENTVxR2Z2N2VV?=
 =?utf-8?B?OTlKSFVINjRVRGdVT1VQOWZ4ZTlVVTdnUkU0U09Lb05WT3N4RXNaRUdkbC9P?=
 =?utf-8?B?VFVWcU5XSU5rNXg1Q1VjdDZBY0JWQmg5YnEyRExUYnBZNTZDbWZyMVRVR0Vu?=
 =?utf-8?B?ZHV3YURkZlhhOG9OQWdMUnpEWHIvVWlwbFlpT0dFNzNjRmR1cXM4aXF0YS84?=
 =?utf-8?B?R3FqQ2tJbEFwbjlyNnpiQjBHNDNheEo3c2dSdEsrZ3hFeUtMb1VSRkF2SVQ1?=
 =?utf-8?B?ZkxOQm1SU0lYc3VvZ0FmcXUwMlVuTWU1dm1sUGFwdk1qaDhKeHliUXRWUlZm?=
 =?utf-8?B?RGVJZXdBZlJ2ZmdBZUZJaUxvem1iYm5WN0xQTEN6RU5hNks1YW9vQ29YVmxj?=
 =?utf-8?B?eUNFYjBkR1FQQ0lYZlBNMmYyTHdKSjFOTFNGeG5kcHhzbnJyeEVSYWZmdE5M?=
 =?utf-8?B?UU5UYXFQRVA3SUlOYjlTelNUSlY1UHZFTjNmRHlWUXZQb3RTQnhSamhFd003?=
 =?utf-8?B?QytyajEzd1JaUjU1TnBaWlFiZUNxUHA2NTl0b01nelBOUGhFZzdhY09sUGRE?=
 =?utf-8?B?MWJBUnJTbU4vM2FteTRZSThyOEM4QlE5dHdtNnpKa2tZbWZTUzZtWHFxWkRR?=
 =?utf-8?B?bU9JQ2ZnQ0pXT1ozV2tMa0VQQU9GSndnSnJFNWgrRGpTbkZieHlhQ20vRkVn?=
 =?utf-8?B?K2VOT2toOFpJdUJRcHZrdGYxME5OWXp0ZjZKUWlodk50dlR2SzRzZHl6TGU2?=
 =?utf-8?B?WEJUWmNzWFZmbVlmelEydUYvVDUrWW5HRUQwdHVXUHV3TW9xVUJEdjZXZHVJ?=
 =?utf-8?B?aEwzVHhEeGFEamJPR20xMWJ4TTN5UkcxWml6cWFMVmNxakhhdW5JS0R1Q2RW?=
 =?utf-8?B?TXpZazk4UHJmSlVUd0wyTVcySW9Cdnhta2l4ZzZUdmhTNk9TSG50THNjaXUv?=
 =?utf-8?B?V0JhUXBtVE13bi9PRGRjZG9BQ0F4dmpUcDZGWE9RRnhLb0dQVVQwZnZEQ2Qy?=
 =?utf-8?B?SkhHKzd3MTF6Nzd5aVdlWE9wOEFTM2FTRFBURHprdm1Galo0TVZzYmtRRWU2?=
 =?utf-8?B?N0JYT1hJQzVlQ3FhMzBpeit4dUdId2V1SUtmY296bkc3VmNzRnF0cjhmVmI4?=
 =?utf-8?B?VCsxM09TdXZjZG56d0ZZWmlGZEdXUE4yR1orZDcxdUZsMjFPalBXSEJ0d1l5?=
 =?utf-8?B?aHFnYmZWc1ZFZWpSOVFvejRSSjJwZjNaOTZMbmhCOGZPdG1XZnN5R2lQUkQx?=
 =?utf-8?B?Zk85dmdqMnBRTWFmTHREeXpaQTM1ZVRQUFgwU2NDYWM4UHo0b0h1K1pCT3Fu?=
 =?utf-8?B?OG5HUzN4VFdkNTMwYmFlV2RCbFFXWjZBVTRrdEJibTE2U1NDbWk5eWxudGYz?=
 =?utf-8?B?cnp6RjJCL3NaSnBVdnAweDIxWTQ0SzB3UHZpV2ErMkpmOWtRV0FBTndTakpm?=
 =?utf-8?B?dUQvTTdaamVqODFQTmlhajkvTmxsYVRMZnovY3A0dkVJb2MySkVwenlyRS95?=
 =?utf-8?B?RXhkSmE5RkcyNFcxTGpzNkE1UmVQVU9EOEs5eTZDVUMwK1FLeXpwYnUrQWRy?=
 =?utf-8?B?Unpjb0VjNXJSYTRrTUJGejdQcDhkY3h0LzF2a0lycWRIT2c3TlRzd1JHdVRP?=
 =?utf-8?B?NEJOU1FnRWpsRE9aOUhXK1QxMHhwekM2SCtieXpVTVM4NDlMYWNhV1pEK1pH?=
 =?utf-8?B?RkNUSWlNdmNqUW5qNlBGeDFwak5YdUN6UVljL2tTQVFlZU9naFJpMEtTLzNm?=
 =?utf-8?B?czZTMEc5eU5XMjlJTEw1TDdIVlRpczR5UERtM09oVU1HN1ExdHIrMWNnRXFs?=
 =?utf-8?B?VVhwMUNEQlF0QkZRQnJGdXJlbE1WelJFSUVTMnZzVnhINHF5d1ZrOWhydGFM?=
 =?utf-8?B?alFuRHBDZXVnRTNVTS9ZUy9qZmhVZEowNWQ2NEVuUE91WVFGTjBOdkZ0ZzA3?=
 =?utf-8?B?Qk1aWjBOTGtiRXc5dmpkRlFzMWZDRklmSzdYSERTRnpHVWdtZ0tFNXI5eEo3?=
 =?utf-8?B?L0Rja3RleGQ1OFkzUnFnZGU1NDNXTUg0Q0JjVDdKakFMODVPNm54TEd0Rzl0?=
 =?utf-8?Q?/HGrwldQGqMhp85R3d2wHAukO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca47d151-f66f-4488-c4e8-08dc52ba9ee5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 02:14:26.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFjV9CCWTLKjFXjK9O4Dr2rsjUMpnD7xDxq10isFrOYqUY+b8iUJ2ovRd+C6opasq7hgNOdVtZLoCQgfaAK3vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10163

From: Peng Fan <peng.fan@nxp.com>

When Agent sending data to SCMI server, the Agent driver could check
the size to avoid protocol buffer overflow. So introduce the helper
get_max_msg_size.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/driver.c    | 15 +++++++++++++++
 drivers/firmware/arm_scmi/protocols.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 2709598f3008..415e6f510057 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1488,6 +1488,20 @@ static int scmi_common_extended_name_get(const struct scmi_protocol_handle *ph,
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
@@ -1799,6 +1813,7 @@ static int scmi_protocol_msg_check(const struct scmi_protocol_handle *ph,
 
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


