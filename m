Return-Path: <linux-kernel+bounces-149394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4A18A9092
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23BC91F225D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C3E6138;
	Thu, 18 Apr 2024 01:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PMDumWxw"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316A01DA4C;
	Thu, 18 Apr 2024 01:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713403483; cv=fail; b=TQWx35W99tZ1h9roNZz9U85/9PtQ1REEbBSuf93xDowup6gVb4zfDWCbza4j67oWQevRhY2PYPBoTL+yU1gjXKZm9r15KizMHYb6AD9VynjgWjcl6Xr8DcJ5KzkAs4XYtUn2uCr8Do1c0WzIHqZodf7KzdGcYfcZ00mCoe1DM2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713403483; c=relaxed/simple;
	bh=RhCldLpWFoBisg6JxF8FQ42efMI/x7hxyuGNT8KbSHI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mCl+ZRxDIPLNQ6MK4FgjgeZdgJavQqMDZSiPbAtQXsVWav6YhIaIok0mWEoi6Ue6ESgfojh/3fhg/lYUptPHvviGflEGyNeFDBTNoSD6tZ24snzg35ieRuaUEhxJmM0wZPKMrQV5aWH+Dg3gTD/7Hhrhz4AzWEVbUN2vlBpVJp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PMDumWxw; arc=fail smtp.client-ip=40.107.104.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PP8eVU9tQSmdQY27I6kCokUWWv+MeneGiwBzxV/y4KS0yAW8EoyzJQHENjEBys7cF1gK0CHDt46U9NIlNCgHpGZhnghjky0x3uIjcHGcwDpC/aYF1v6R2kGb0AlUlusELgPUzpARieiTxqv85Cjrrj7nkEA9kmwLwurg0oipAPrrmF/KGYpq82mN+fV5i4Dss+r+NdbP1fgcH5jXa22vbkgPa3RI9Vo92tLtLrpmSEnxDET3Ou3K4A96stUAhCtntr9d93f4TqPiZn1mk5gyBmGGt/qVlamuOMqVWrCSMbiHUxSu8JBBX54swr+bx3qBIGGc2JXA/JMEGmKOsp69+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y32EPUygoezOrwpSdGDK5Cezq+RoDLA6Ci/XuseYkwM=;
 b=gu6W/oy+Clkvt9+gj6WHbJHe1ZZrefbjXJ2Gs6iBsWnL/OhZi0VRxTTmSViUeEVlmhMTu2832Jfae1E38X5UMuCHKTbLvMZE0qJTn+Ysn/8vI+QLyBuNiGwqfGRVYSLPOiyEg4MDAgy4lM9otldHmb4FSEwDGpkT71GnC4H4Qgi7X7hesAQop6QHzHTrt6n9gFBrL5ny+LF6G6E8fEtG5GdMLDAsL+DB3Vpzx21+ZxHcheRf2H7Pq2ZqETOt2UqFKll/XSDJ6uN4khdaOI4pczs9x8DLGdoUiaIYtUgG1dL2aGpn3wFXxNhRvI5k8qW5wIYn7fnWu9Y9vbf5sz2/DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y32EPUygoezOrwpSdGDK5Cezq+RoDLA6Ci/XuseYkwM=;
 b=PMDumWxwNmd5rq/S0BvKVcAWRrbbN1ME3ujEixkcX2GaTGeW5MNMURK8ja1IpVQNNOxzYGrCVz/mo3htpSwisWnzz/c9zySCy9TXJeo6SpNmGnlDdGGacTbquXGj0THq1ISlOYJznBmGgw24uF6vFfmoDVQQ5xa4F1//CR2Ajp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9264.eurprd04.prod.outlook.com (2603:10a6:20b:4c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 01:24:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 01:24:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 18 Apr 2024 09:32:28 +0800
Subject: [PATCH v11 1/4] firmware: arm_scmi: introduce helper
 get_max_msg_size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pinctrl-scmi-v11-1-499dca9864a7@nxp.com>
References: <20240418-pinctrl-scmi-v11-0-499dca9864a7@nxp.com>
In-Reply-To: <20240418-pinctrl-scmi-v11-0-499dca9864a7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713403963; l=2695;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=fC1f9Mz+AZ7lC+TNU94i2E/beyKrQPUiXgoBP0YzZ74=;
 b=uvGNPiYqgihRcYCo3u01MEoYWEnTApbl6WtoFdgkeg2yPSLHnNnHKxaYow7E0JYtw3Y2Ph5oJ
 VMjur4H9GOMBVLegt5x3bUzYI4sZ0oWyo+cl7HVxPTP1d2auoz/7RJj
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:4:91::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS1PR04MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 788082d5-b6c1-4ac7-0827-08dc5f464f40
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dIbXlh/XHPprriWeHssC8P2/XQGG2ou4/k3PeLQfG/MChKG12So4vKxnfVhXsivb0jog2ilYSKbexijEFSqww0H1TDkOhzzhIPwtaDzlEpK9+w/sDUYPF9MyyBvULZG+oHgqkrgdcDKZnQ66TNEyR/jXfA9eXRSHJ3s5Enjj+GfSlCdFwg/9GFWM5lEg5D/54ypT1364fviJEi7AbDP3lu6NcGZX2hBrikBZynM/qo9eQWn3VNp50jwF9k70KuforU2flO05KA3bWxw3eUv0kFh/Nw79/UIYKXCZ2BfZQoOd5UWMbtw89Ey8Dv4Ra+Vw5q0LIx9CFxHn56BBYnCCL5v1wAZbKgBDlQfQC0x3ygA1UbXPgGW3d73kYYy11g1/aNsNNVTmf770i9KFRhYvGMNN/B+9S8kQACPIprXl4bpHaDKzVng7ToNu85it7DgNoOXjNrdoc7auyP5mcasCHge3vHQIhOB831+UMqHNdkvuBJed3ZuohO6hAOTgefKMKAsfqoSksGMGS2XekbdeMQUTNezqKQaF7Df5Ks9qD5/wXBV9MHqWUKfcKIxCMXcdYBO7P9TwumTV35ONNMPBgIyRo/YfuGlGSzvEUGYUoG17YD2dXHRVhzGbaCQ6LZqhol9EsAvuONvhyy7s+0tQgoafhw3RDTboMoUFl0IE+iuqcomDk7lnVO0lQcG8/9XaiBho1sY3CQeAysgQ7XCEBcjgbAJ4tj2+cTewpk6fjy4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1FhbjFlNkhvUkNBOU1pMWVYdW90QlZZOWVzZm9RcFlRTXpBeCtyTkd2RWVL?=
 =?utf-8?B?ZVN2UmpBbTE5WmFIZXdHcEVpbktGdjBJWkhINUJUMkNyOWZjMmlSN2Nac3lk?=
 =?utf-8?B?MVVaaDRJNmtVR1cwTitVYWc5bGhSR21FN2E4RmZNb1h1U1hSSnphNWVScnBB?=
 =?utf-8?B?Z3JQdDVuY1BVSjA4aTZGY3VTRU1QZUVQNkNoWVgrOEhOWjJBcWZlbzBkZHMy?=
 =?utf-8?B?V1A2NDNORnRiTERWdVdreGJHTTdiV1pTb0FNcFB6bnpPSlZTTnptNE5GMFZw?=
 =?utf-8?B?eUVEOHlzU0l3cHlORkZRaFRRU2paRW9hQVN3YW1RMlhyVFJmWDZhTE00eDJM?=
 =?utf-8?B?R0RBT0l6bHgyeEZEOTQwWmc3SlkrVTNqZXdsM2UzOTMvWU5ZamlPMk5FUUd4?=
 =?utf-8?B?bXIxU000dGFyRW5YazhpVXVqMEdJOUh6Z05hNTdLSmhSaE5BVlR4Y0lQMk5H?=
 =?utf-8?B?WG9zK3pUTi9TM3lwNUdxOXZabVBxUWJhT3hUOWVzRlFTcGxpNUhCT0RFcmEx?=
 =?utf-8?B?TkhldUNRNlp1aTAwQWVtZ21tWVYvNjJySkordUhlMmc3SzhkSWlwT3Z3VC9t?=
 =?utf-8?B?clJ6VnFMRjlMRDJyb2dsUUFNR0JjNEt1eXVZVjFIbmI0b2R0d3RxK0pQTDlC?=
 =?utf-8?B?cXM3WnVCSzloemZzTVMwdUJLQ3FaZHB4U1F5TVo2U1NRNjd5OVYxd00yckNp?=
 =?utf-8?B?aW8xKzdjSzlLQ1lwL0d3V1ZqdmVsRHRsTTAzbVdpWUtJSDlpOTd1YXU3a1VX?=
 =?utf-8?B?T3luUnFkc1NaZ3lOOHVoVHZ1b2hmdXY2c2VlVFVTWHBkclJTMDFHdTFQNUZx?=
 =?utf-8?B?OWVSUmJseXJLUktyOTJFSFRPNGxyNnNoQ3A1WTJDWjM0Zm5BTVZXV0MwellW?=
 =?utf-8?B?b0x1VWs4WG8xVkdUSXl4N0U1K1pEWUxtKzc3V3NKU2FDR3FxdE9mQ2xkUjJm?=
 =?utf-8?B?eTZmZHUrQVVRUzJPTW5odU1OSkxsMnNGWHlaeDVqNm5kRUpWT0dqcUl2V3NR?=
 =?utf-8?B?cjQySC9VaDU3b0w2a0V3M2RWTmQ0eDhaL1lBTlhkV010dXFkZ1dLNFdDQmls?=
 =?utf-8?B?dnRtOE1yTDJlWisrNVUxRk1LeVl1Zjhjamx6VHl0a1RaM3NNNlpQM09YSHZ0?=
 =?utf-8?B?Z2I1M0JGSG4vL0tXSisvUkNmVlhCTGdzcTl4QmpSWXo2TG9hekF6MU1oa1JZ?=
 =?utf-8?B?a2pqMHhWZkpUMnFYOTI4VEVlME5Hdmp2bTlnYTBpd3Urdi9LSXQ1UlgzU3Vk?=
 =?utf-8?B?K2dRKzJiZXJ3U3crMm1SSE1PbExJdmRrUHorRjJCNHdNK29CNHRlUzdtSDZ5?=
 =?utf-8?B?SlI5TlNmcEVpYjNxZStMQ0M4d1JLektGTXFBalVSV0ZGczZnTnM3YjFjYlZY?=
 =?utf-8?B?MWc5MzRlbEQ4OWNxZmwvajBXU2U2eU13L05MZmZRSXdYRnpEdDB5VnpVTmlG?=
 =?utf-8?B?QnNsTVIxNzFxWUVjK24vbjcydnpLVWVWQnA1N0J0VlR4UEtkMHRLVFlZYmxu?=
 =?utf-8?B?bjZpT1FnNlluM2I5VkFyK0lyQmd3Um1KQTdJVElWcWJqaCtrTDNOZHZYZG5k?=
 =?utf-8?B?OVRVTklLRXdZbXZuVHE0dmtzdVVjcVBuWVVaYW1KSnpFbkpnSWQ1V0R5YlVF?=
 =?utf-8?B?c2NBMnY2N1JKZmdsamk3WWl2dzJuUTYzM05mNFpDVUhaVi9sU0xIKzdXV0gz?=
 =?utf-8?B?cE5vbkU1SEZaZGIyZHY3Q1dUUzhkUjdLNHp0OWM0N25EbDF0OXJQYTI2QlBy?=
 =?utf-8?B?Qkl4OUhSVFpkSWRMYXo2UVFPSWh5MjlkOVlpS1RDMWlxOTYrWktvUy9Ec1Zt?=
 =?utf-8?B?b2w5cllxSzlTN1MzZGJDUHVhWW5VVHNWeFRpRkhJU2JFWC9iVGNEYmhIcGZG?=
 =?utf-8?B?NXo4N3FPZGxzRGFGU0J5ckhMQXdPNmxtcW5rTXhXcnRqU0pueFFvSWh2WTdQ?=
 =?utf-8?B?d1h1RDBnY1Z5RlZyOExaWGZabUcyMEt4NkxTaHFwUjE2OUttc05FbS9raFdT?=
 =?utf-8?B?YU5qRVBOTFBNYWIvMCttZjFxRmtmby90STY1OWQ0aUNDMVpPRktSbVFEWDBy?=
 =?utf-8?B?bWQ3Ui92c0g1aGlOenBLelMvTDlpSDFSdWlYdENXNGR0MldoSUREeGFGcGhv?=
 =?utf-8?Q?7hpw7en8oboRciWV/UMDGLGYF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788082d5-b6c1-4ac7-0827-08dc5f464f40
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 01:24:36.2573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcHroXCLo7dpV/guGAsreR2hLW1g66iXDLqF1zuHTBj1PqdFxwqONv1KX+dIQdcooNWIre+wgN4i/OD6tMW+4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9264

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


