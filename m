Return-Path: <linux-kernel+bounces-144781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FBF8A4AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB221C21678
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D07940853;
	Mon, 15 Apr 2024 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EP/al6OQ"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2069.outbound.protection.outlook.com [40.107.247.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5460D3A8F9;
	Mon, 15 Apr 2024 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170579; cv=fail; b=EEbMI7YMLXvzSAKfKzp5ElcSVy0DvVbcMwBXDF6tC6928Xe9yhKMgh5TycVAHBhNQJR8tY6jftkceAk/mcVxSynVEh+LAlMyH/aJuKRrZShPsdEUcTFwuiTAzcb3UJvCPXwlGb2BSvVyf4ev/itHME/2taHlutDyFvDvPrHBUOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170579; c=relaxed/simple;
	bh=RhCldLpWFoBisg6JxF8FQ42efMI/x7hxyuGNT8KbSHI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TwEllkVMXmkx292T/g3icFifvuqRuSvtKyURcSQhPyQsjiK9BsqW0FdFUGyIzNKrR/ZqoyLFn3NXc25UCm2z4VGiJ0ohsz396Uo18WM3S51z5IaypdIw6PTuyDEJOFsPba0PT1T+OvZRsNF8LJx/d9tQW0WmExEToFPvnSaiMXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EP/al6OQ; arc=fail smtp.client-ip=40.107.247.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNk7i+YE7bKCjOzWQM6/OFAeBS9JyrKZ4pbVhkM4DIqwxNbEXnaPBqG9a8pSxR/cfdt0FzIipquEmYXbmkaS+IgfKLRV+r/okZgAmC7vwnmPb8mESz59TpyFLffUZLc5oqPMevzSmsj9XUA6X0XB/pRVP+QWe68EWaX3D797FMqJHO9U5smHZZqwssZgdxBfuNg+NwMVRqznV36UApymPBRndhZQ5/2SjO2UOgnXsMexwY1qSUJrC8F6TGwrn+/BqcE7dUfU8uuIf6zTtEGi6+byMk7Zm8nwhrwteCIRyLQLIPCjAOp/AfOv149O43yr869Zer0qrNhCfHt1duXODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y32EPUygoezOrwpSdGDK5Cezq+RoDLA6Ci/XuseYkwM=;
 b=eKj13Kwd94Qhfr58iaVlkeiEQPISRtLXhjRee5cbqsBEafmKf09CQVbtlYL3J9GUY1jvWqjiQNtXr7UpRIL5IT9jc7DuvRP+BHEZYFHxGJhd8ey2LT4H0ChB9i/KMW1kwLHyiWZwE78h/rUdttpvgrTHL8sLzTD164x3s5c4xGDA+wDbUzJ17rvZ8F8pBlqwQEhbDq/FcZoolDet1NLqHGuIMaIuNKk8Nr+5ImXa0ano88s8kJ1u6HAh8HaTMReHlWF2wQ4N1epmjomrodwAXVSNtmM3VdxIi7d8U5IBdbHCQZ9kotRJsJczt4UbI5jPrM1g8xSJ1pQeEcJnm8mdpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y32EPUygoezOrwpSdGDK5Cezq+RoDLA6Ci/XuseYkwM=;
 b=EP/al6OQL8mP4oJZFsDGz1o0lgiGMtvKeusDxti31LVKQ89MirqywjwAQrHNPZtTbknJyQFFNcoCB50qC33m62JfKUS4vQvyo2VQ6vVLK1mtwrPRA6NxQPkBxO7RWo0sOOHgcWzjvubjRy6155BWoiVp74eXDQwInuL+v1bG9tQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7506.eurprd04.prod.outlook.com (2603:10a6:20b:281::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 08:42:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 08:42:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 15 Apr 2024 16:50:49 +0800
Subject: [PATCH v10 1/4] firmware: arm_scmi: introduce helper
 get_max_msg_size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-pinctrl-scmi-v10-1-59c6e7a586ee@nxp.com>
References: <20240415-pinctrl-scmi-v10-0-59c6e7a586ee@nxp.com>
In-Reply-To: <20240415-pinctrl-scmi-v10-0-59c6e7a586ee@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713171061; l=2695;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=fC1f9Mz+AZ7lC+TNU94i2E/beyKrQPUiXgoBP0YzZ74=;
 b=q5GWIty/C0+zNWWjGsIah4qVnecIS9Ayc3PFWTIfTzo9dwsUsAQQo+LAgNGgyPjWdAe4NVBgZ
 lPug89jxOmvBEdjNO9GSpJkQX/WE9Vg3PT2WG31FWj4ndQrDSUsPE/8
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 455b1994-0774-4da6-138f-08dc5d280ab0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1oW3xd2QTJQvQNf2tfx9vtAqhCKPvTYaU/DOrwApDn3fq3PBxKvrEAEoN9zfxBJeRO3N5JxISBED1OI75rxCGpO5o/QYG1wRwc4NqcAn2hjxAE9zNNrO7KDkHccf0Yp855V3Q2qoWCDpF1qH1+lEjYabbKD89wTQEObwMq339JZYTlMxK/gKXpdvcsi7k+QnY5oduNtAvBxPZmeWkdbgPm7S/8JSb2ahPxO+adhb4LHRTtetrHXCs+ZOAFOXMaV6YQoAmX+TghZo6LDCT0w6SiVcPGzsgzdYNZwMg7CypNgIYjdQuIg6rlgwwq4XQIE37R9Ckg8EZW4QUs1ECJN+b6beRP8KqbWfyye0gB2n8nflTHihtOuGPmT9RcIOUlatN3enKLJ7l0drGFWM2zrRmycAg6mOjTxq7R/PAttyhgko/LuGHCLt63r4QC+ZHVN6TlxcUUmXsEMRnOKPVmqYVth7xqbJb9mXqiDAdwwze+roBPE+qi0oualjv4EGpHkQ2LFQuSrXKliiiRGqwkToGOqep2Eh840lbIlb0oICfis2O1Avb1wIYH1wpYzDWJUmbi4lcIZSQtpPvC3KNIPNul9pFdETXQNVpvJUc7ZPCdjqvWpcc5luQ/XdvwMcdF2iGTXuv2u3grsVYAolGHeFDd0Pq+pGdZwjQnC6d9VZ2SairDx41nxUpax08MUf+CDTBefvkkZZLJJQJRJJrW7Ap2F/286YFiDdkyOPXHFke0Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkdRTFBwSlFmWUxZMi9RcDlnWFFyQTRyUTVCN0p6UFl1cGlPYnlobHBBSlZY?=
 =?utf-8?B?ZzZVSi9MMVh2cjVWemZtMEF4MEx6c1B0QlFhRHpqZ3FaMWM3cmttbG1MMnFo?=
 =?utf-8?B?a1lIUXZQb3hHd044Z3pocUluNHNMb1FwRE05VHUrVi9Ga0JWN1ZDYmxCd1N0?=
 =?utf-8?B?Q04yUVpCRzZTVzNGYm5RV1d3blMvaUdDdHI1U0kyV282MjE1ZTJodkx3aCtT?=
 =?utf-8?B?U2dPanRJNDVyT0tZQm5UczNrZGNNc0pLcUdnQ3ZwWm40Y3BpOEdrYy9GaWwy?=
 =?utf-8?B?b0twTGtlUjBrZ3NUalo5ejN3RllRQmJoT3lYbkYwNDVxcml4ajRtSHFWMHR6?=
 =?utf-8?B?dCtIcFFoRlNqMm15c3gvd3JSQWhlSTJUekdrOVRYWnNZd3diVkR5aWdvWHlI?=
 =?utf-8?B?b2dHUVU2M0pLM212Z213YmJRak12ZWlDdjdPNEFFaFVxNndhMlQrRDZGWW1X?=
 =?utf-8?B?ZmNWV3dhdXpEbFh2SU44ck41cXhpYXBnNFlRQUxvRmpWVFhxUld5cjNpeGN2?=
 =?utf-8?B?eEJVeU4vTm9xUDVuOHRLMzFUM2twck9ObWpxWEpYQUtyZHZpNnFYYk4yZWpW?=
 =?utf-8?B?MCttaUp3UnRBT09rNWRVbUNBZDdrYTUwejNZSVhLMFBadWF5Z2pyS21sL1Ux?=
 =?utf-8?B?ZXV0a3VVQWFnMkp3NEl4WFdacUN2UVJxc2FIM2xlaFh4NzlaZGhaWXZnckNX?=
 =?utf-8?B?NjVtZWM1bmNVZ2VlYnEvV2VnS2l3ajVGaGw4YSs5NGpHMXFEUVpCcGVnRzB2?=
 =?utf-8?B?d2s4NVN4aFJXaUN2OFR4S3VhTEx0ZkhTMy95MysvZml6TmdpbitGS2Y2b3Jl?=
 =?utf-8?B?RDNzZUxYQnZmenc2a2YrUEU5YTkzTUo3S1RLZk5md1p2ZGNyZkpXUVJDQ3VX?=
 =?utf-8?B?SjFPOGkyNDhjdHMvSHRCWGRKSUwyNCtOR2dmZ2xCNS96RXp0RS9FTFoxTGZ4?=
 =?utf-8?B?VkxVMmtRS1grZTZZa1l4QUVJUVBDVUo1MlpZR2VqdHgyM0Uya2lEVUYreTFX?=
 =?utf-8?B?a2dmN0hzcHo5bUdXQVpSRjF4Y2dOSmc2SEFYS1hRelF0NFFuQjBHS2ZENWx3?=
 =?utf-8?B?UGZiRzdoRGxvV2Q3YVFwWVl5b2QvQ2JkSnFSK0N6TjhwUXNPc0FvM3hoOFY5?=
 =?utf-8?B?QXRZREtGQklTbCtIV0QyWmpZaUpUOEZQaXNyTzFOQUNiRlBKYjJEbXJ6WnVo?=
 =?utf-8?B?OVk4cVhuWC85dEdsL3I2LysrNnI3VDkzZ28ydFV1RVdZT2Z2WmJkRWJqVndv?=
 =?utf-8?B?UXNXYzdtWDhQUG9peWhhcHZGbXJwNDJFM1hSNHI3MTJneWxyemVMUTEzZnhM?=
 =?utf-8?B?czhCTzN5RUtWaXFqQmxNa2VHbDNtYXpKaFc1djJqbUF2aEhFSFlreHZOWlZD?=
 =?utf-8?B?WkFDS25TZmljY0d0dXBvSVRxdHpNQ1FDN3NQYlFwb05FRWQ1YyttV0V5QVNh?=
 =?utf-8?B?SlJXSmM5ZkRpZlM3K1NEQ2tuTG9sd2hsamhYRXBhRC9IaWNzdjhCbzRyV1ZR?=
 =?utf-8?B?d1Y1d3dRaTU4YmtqNFRZKzZWd2dZb3k0L1A5RUs1WUZlNEJYUVA5VXh4OVJ4?=
 =?utf-8?B?NEVkTzhxb2RmWUtVbktzQjBpVG14Q2xPdDR1dEJLbUg5eUZxejBlSmtrWWpr?=
 =?utf-8?B?M3d5OGNsZnpEZ3NFTEF3MFpidXdvS2h1YXdmTkMwbHkzbG9abUJjS2JmVnVI?=
 =?utf-8?B?bVU3SFNOc0h0bEFrdU1VL1JTWXBOd2pBSW13VEZLN21WNnpDcGs4VzhsZmM5?=
 =?utf-8?B?bTZjOUVta3ljSFlOUXlJVVFvMWpoMm1rM25BT0lzSk83b05HSUY1OVVwQUk4?=
 =?utf-8?B?dXpudXkxcDEzcjJDRUp2OXZPUnY4RE5PVDBhTzU0dVpCUDVRb0ZzUVo4amEy?=
 =?utf-8?B?STBYVEw1akNJUEcxajU1TnovYU1lNmhOck5YVytWeHFaTXZxa2xtbWdiVjU0?=
 =?utf-8?B?TXMwd3ZiSGtadUZVNllEbE1Tc2k0OUhvRFJUaTBCVWFYZlJVSXdTL2owaEdy?=
 =?utf-8?B?YmVMRVlRVUdCeHJyVis2ajI3ckNnT01Sa1JZN25kTjhMazMreTcwTGZFamtw?=
 =?utf-8?B?QXlJbUNuenAxREhFZEZPcG5mZjBBRFV5dndZQmRxdi9WZlVjaFF1YW50TVMr?=
 =?utf-8?Q?SrezFqf7Xfiqz/D26flwyhDKK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455b1994-0774-4da6-138f-08dc5d280ab0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 08:42:54.0925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGEMAkTUl2yEsZDfjGx72mVJlCiixm2WKAPwbx3uiZOC/A1MOwI2cw0J1rPzTMbmRsFKofGdrZw/cdJ/9laWqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7506

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


