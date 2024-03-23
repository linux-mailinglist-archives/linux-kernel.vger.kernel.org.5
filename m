Return-Path: <linux-kernel+bounces-112319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D22288784B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04397281751
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA01B1BC36;
	Sat, 23 Mar 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EpaWgE1a"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5687B1798E;
	Sat, 23 Mar 2024 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711195655; cv=fail; b=PES6qoJfnATOA3GObWzpfWiWFtnyyjdtNxk3ANleXPk3IvjhCgUwyEYLYFqrcg7d6bmSXiZKtLqIvSJSjjVEarvJwRZ9wr2rtY0lR978LO04wAZFb5td7FNsvpux9OXlOYqFLmbUbqWERohNTQhJ6cU6sw+XdYcfktTr78FdmUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711195655; c=relaxed/simple;
	bh=t5HLy5gFexuRUd/gcXkLur0tNUBqrWNFLScENOV0ZWY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=C0xIIiWQHs/JflWX8VdA4OeBSCSVbTpwgG30kJPd72E+L21CujjD/VQHUp1PvUAYELdOOHjgx08TdcKpRlF/4r2OjQBa5M7w8Qrh2gnH7VcH2X/5FTDjsd2XRyI6zIYESdaINYBfuytXGjUgtVcO5sZlvMkjbR7QQxyRe+W/a3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EpaWgE1a; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWC8998d4/pI5kq4SLBi89Fowcqov7SDx290PK1xRJ+ubxWFoB/yWbH9QLZWRorGtqlHyLJYABqD5FXD/XkDKsQgUDYKimfXBAXlalPvZAIJrYvPNkCFsKXUdWEVWoDBKM3wNAukmLUfm9oTiU//Kl4flp/DqtwYr/5arhR3xf66KX4Y1KkFGf9DibP9ri2T7fikKVlOWZUJkGH9AHSh5DpCPwxGgje4ejTcw4BOhyGxvjXY2iFwAFSSw9TQ/RKxmtGJTP0vTSDvxapNhqC4fxf2YZ+DZh6tGkEnmqmxciRPzBTQ7wK/71kj2Cj1U6dqbwdU/8biTynWwJOA3vNDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkhFzy347CReKh8Y/3De5x5m9e7u839I/9k6SdaIf8U=;
 b=fysKkYRANQSw3cjTQ08aC23Horpog23LBV8n7PGmAFCHsl3uSn/8s40/VpzWQBPqPzXVOiX4aE6T13oTPZq5XO3PmQd614qdkyjGJO2G5Y9yPH6pDLxbAUupXI2uTYIVJFmGRQ2E939Ow1AzPQl5i1AlQOtEOkxi9XCu6k5d2Fp72E/NOEPLxM3CcRy8xl3JDTavP+1DNCzbEQio8UQU2ShMgY7cEeTlL5+qfm5Hpp2cOpZMcN34S23bbPOgCD8v3jFyzpGMq3gnAUwI6E5QrUkvBW9rJlsszR9lUdeedizlob9OhfNLhBIph9sgf9NRtotNisX4S+Iv/T+J9VvhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkhFzy347CReKh8Y/3De5x5m9e7u839I/9k6SdaIf8U=;
 b=EpaWgE1ax3yjyWdWeWjxGXD+Z1A8d+a06yy7Up25D72VYNqFBnx28vsqvkAiM4WYT2kEEuNq+E+mcGtUfuphf5B4z2/0p8j+bNPACrDV4/fMVxD9PjvYe40pohCdJikqZqrk68889as2DOMqeF2JuBKn23SPGGlYJyyDDADDLSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9585.eurprd04.prod.outlook.com (2603:10a6:10:316::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Sat, 23 Mar
 2024 12:07:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Sat, 23 Mar 2024
 12:07:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 23 Mar 2024 20:15:14 +0800
Subject: [PATCH v6 1/4] firmware: arm_scmi: introduce helper
 get_max_msg_size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-pinctrl-scmi-v6-1-a895243257c0@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711196144; l=2653;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=dKDsMHnM+cuvfvX6K6tAU3ADCasBJe+OHaz6qBQ1Tuc=;
 b=YCMLoesvvEksAchrZiSgtAE6+ph9Er9HhKtwRJucNf2NYbKuXTtNL5fw03vZ1EUKko+Dj5oF9
 68c+d636v0yB4NTZRKEkdkYAxtLIs/XfPY6xpneKjzqpHkKhh/k4oh2
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
X-MS-Office365-Filtering-Correlation-Id: 8a1593e5-55f2-44ae-9d65-08dc4b31d0a2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gy8CVQWIGLPp+K5HqbgaT9+ZowM1+AiyJWp18+tQBA1SClBtvHab2OknIQ+IzYNupCzj6riOq+C4ktWfHNicbeHsU+G/b5v4Bp8Afn+Ra7dqvSYCBkrxfPxZwVg0sYy4O/WySCIxHtfmmVLKDhSZcE7JrSDswDSJZ6NtwUHzHOW540JS+baZgSvnCBF4yxOsgkM3mQw9qsLgU7peynatI2GbwJJBKIXfo5u3DKoEzLmqwm87AoP7drT/yPa7BXb0ny+hFCXRkFqVa1eMXSzoYVyrpzCUc3ishRVbNo8SPTUQXhRrlcDmXr66usDvCtjuA2ycgUZmIPQneoyOxY1R2z2jvNI+89JINcZJu2hKTA7GKuSQoKDzeAoT2Oi/Rp6h45GN2/W7e98l78OBdANC20R9yUW/N+Kyj6W7v21+pW5unvJ0y9DW1lE+l97VPOmk+hRc/Y6nhEGQ4vg1HjClBkXlEv50XHtvIxYyQaw2Kcr7m4vJgOo6azUjqjIXgtZjeHb8669aT6KNN6Im9tDj1+KDMFzQxIrQ17WQqLKKGvpfTLbl8gtRclfGYjCPQiDtHBbupbFRm0bsn5EbqytBssWo3OXHLRTfHJLoqc3m366I3GBOLKZUWhuHfCLrUAe8OE3WTS14FELYmRJIClD86sS6qt9lZ6cYjk1NlkvcbPuZeOxWfQ4TNVprVXjqCl2jEgVMLDNaqtS2I9thg+GfI6nrwPo9eRfCobQHb7WHxVk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(7416005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkFKV01sYjlLMmRnUnFXTjRHS0xVRTlsTE9FYWJsbTB4SDJBbDhEU09rZXdk?=
 =?utf-8?B?cDVIK0pwM0tLemtJMURNWlhTdzZlOGQ5dXpGUVZNZXN0M0s5NVZ1cStCaXMy?=
 =?utf-8?B?UWI4WjBwMEZZdGRKd2dzN2RtYTYyVlJBcmxVZDY5Y0twMFIvOXdWdU14RElB?=
 =?utf-8?B?Zk1WVkJ1RlZIQ2Nad0V1ZTlycEtiN01XODJsM2pYVjRiMmh2R0owVW5LMU14?=
 =?utf-8?B?NHdUbEZXZCtWSUdsa04vaUo3S0l1bzVpclhjU3praWxoRzhKSURSTTlJa2kx?=
 =?utf-8?B?U3ZUZ0RJWUQyaFRRdEZFMDVBVlREK1cwbmFEeElvZFFpTGlaYUtUTzFIRVlZ?=
 =?utf-8?B?OHdiUXBDMHUrcUYrOHpKSW0rZlkzUllFWExDb2c2cG9DKzVydkV1STZKZnBj?=
 =?utf-8?B?bGNnWFFML2NMWjF4RlViUVJwQlhsQy9lUHhQNUhvYnVvdkU3Z2pmVERDSmc5?=
 =?utf-8?B?L0IvQzNGVHh6K3pVaXdwQUVyYy8wZjkycStCb20yRkVKS1RaZUNkdWhIdldw?=
 =?utf-8?B?S01pN0NEK091Kzk4eTlRbFVzMCsvd1BpcHVEckYvN2pwc3JESkhmSm5PQUNx?=
 =?utf-8?B?RjZuOTFHQ25ncWNRTnF3MXoxcU1Wb2pCd09tSXNJQ2hHbHZKaE9yTzdrMUp6?=
 =?utf-8?B?V2pvTkN0VDJhUGdxZWNJRUNTaW92NGxRbWFjWlVwYjFrOWRpejJNQWl0S3Fp?=
 =?utf-8?B?YXBxa0R5SVBpcTF0MjBhR0tQcmplampISFViRzhaNi9idGJEbDhyeVRkKytD?=
 =?utf-8?B?eCtvWlpUVnBCNkI5cUhQc2Z3bDNGSFd6bUdMVi9GZkc3VENxVmwvWklzTHN2?=
 =?utf-8?B?Z2N0d3piL0RQSjVUbzR6RHhmQUFsd0JJYWtGOEpoRVBhWlJoL25SdFFvMThn?=
 =?utf-8?B?ei83a1VlR0ZoMktKYjRFNEJhSmQybzJGTWwvT3BnaWcvRW5PN2V1TktnYk4z?=
 =?utf-8?B?eUI2RFhUTG9SNjRyS2tNSktLU1Vqb0dzN2VlanBkeXFjRE9vSjh5YkczOElI?=
 =?utf-8?B?cjlOMHRKanBsalpHNG0wbTNEdzN5VmVUdSsxM0t1R2ducm9NRCtnOFRnbTZ3?=
 =?utf-8?B?RVJMaUVld2ErdWh6VjFUL0RPajRTdHFqdWNHQlk2NnVHQlhpR1ZqOHo1ME01?=
 =?utf-8?B?Z1czNUVYK2VxOHljdEZqQU5kaGpMM3M2NE1mdFNUZmFpRjhXSkx3Z3lKcW9Q?=
 =?utf-8?B?NGpVZkl3TkwzMkU2RVM4Z1NYS1hRQ0FEcmg4L3RDS0lwZ2dETkxUVnlxZG40?=
 =?utf-8?B?MWFzaVlqc3JJYmE1WFZzSWxtU0dVR3ExN21nRW9WVnpWTUJlcDQyV09wTGNC?=
 =?utf-8?B?Sk1CaHZScFB1cUJPQnEwekpWanV6YlkxNWRZVWxMSFVNL2YzOSszeUtrMGZK?=
 =?utf-8?B?R1pzYzFwRUdUSGYra2E4OWZhUmlwRkMwQ0g3N0E1SVZ1TG5NbkNQMXY2TmpI?=
 =?utf-8?B?Vm1KR2JpdjdXQThtQnMyRUpSbE5WVmVZK3dqSmx1ZWZHc2FER0VjSkxhVyt3?=
 =?utf-8?B?TGF0S2dlNWdCMGljbCtpZzEvTHdHOWUzV0wrZFEvdm1QeWNCN0lFNE1pOVV2?=
 =?utf-8?B?VTJBeisrek8zZ1Y2cENFMm9uR0FPd21CRVhFMGdmVkx5dFN4UStIZERxdU5K?=
 =?utf-8?B?cC9Gelg5ZjZQVjRoUlE1eFhyT1NGenRrNExJaWx0bnFQZHBJV3BqaTlNV0pU?=
 =?utf-8?B?eko2VVRpOUwyZFh2SGt0L3JJOVFJdTN4eUhkeGpkaXNOcXcwNHcwNnMvNVMy?=
 =?utf-8?B?MnpSYzZ5dnJqOTArdDdiNU90a0tpSE85Y3dTQTZYbTBFcjJKVDRudGtYN1RN?=
 =?utf-8?B?SFpPTjNmSy9kWGdPekdZclhoZDAwbGUvMUtVNjJhSGk0SFpIWVExRnhSNU5m?=
 =?utf-8?B?cklqeFhsMk5JTmVuRDFXa2htaGFSaHFXMkZ0RVptVTUxUmxIY09PY3ZVZDZW?=
 =?utf-8?B?SjMvSlFPaDREYUF3d0V1Qi9qamJ3NDdQS25zdURIdzQxanFKWFJrK3BRbXNR?=
 =?utf-8?B?UVdwMldYeWZuVkxyUHZDNHMxNnFHOU10dmtFSW8zN2xKK2FNZW1JU2o4dTNt?=
 =?utf-8?B?VTUrKzFOd044OVNPa3lNSDFEOUVDUnRaeXBRdzFMbWZCTkNyMGpzYzFnWmNz?=
 =?utf-8?Q?iLpNK45N6cXsu2KQ6W+wFGVKW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1593e5-55f2-44ae-9d65-08dc4b31d0a2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2024 12:07:30.6439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZuPV+Bz+eYK+f54PpwXR8xbVhMFaNBJ4YRpv5U84XZFM6RgtYYiz4nHvyGhQsy+oyo28PqPX+zqumoiHWiH3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9585

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


