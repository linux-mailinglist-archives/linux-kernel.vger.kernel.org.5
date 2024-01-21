Return-Path: <linux-kernel+bounces-32001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6817C835524
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEDF1C21546
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82BF36AF3;
	Sun, 21 Jan 2024 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lrg3PusX"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2085.outbound.protection.outlook.com [40.107.247.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85E2364D7;
	Sun, 21 Jan 2024 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705832282; cv=fail; b=n+wgryy9SPpYBNK6yRyylhhVL0GCFbXYi1FuH7lvb8AftBxNLN/0ZQtaaUqPgXJGjnBfTD22G6NUfhffAj27ObqZ++3Xotxds74umE0yj2s4ABlvJEkw/2vlsonBfU6LqTNDI8C6uK7klPuYbtV4lRyPgab0qRhoTm3CslC95B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705832282; c=relaxed/simple;
	bh=rftupbuukxM4bRu9poTXj2bVaFZHSw3rQwVgnjODt6w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KeSyxReR8VDzFEwbD5ta8YCf/MV6ZJjffhhK0qtummnsGrBYfw5figQXLLbQ2vV3yKDXXT9WO1kFSXuxKHQxgDbxNPDB5NF2wHkSNr3lyqqzlQTrQdS25P9tGoVxRMDwYTmNxgBaDRn9viKeFRmo9SQnnFZ+Xhpft8kesK6sv5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lrg3PusX; arc=fail smtp.client-ip=40.107.247.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtcBvy22sxntk/zTVZqMlK3kJoCE9736aTD7V1jfVVhy/tm+T87lDSN5mA1LvLeLzh5eX42W29leuWEi0OPrAwZ7484SdbXi7EueDpVHWiQeSfAKD8iRFlfU4sisP/olafJ+XsrlYVk4O15uMav2Q1BuLZY/PgmWhuOBeamhZybxNY3eMcPrik+d+oDVmjAy9B62xCfcyicMJ5NhLHZyQs5LgnQ149rYDGetX7fdOZSepzR1bc95fQtl5gdaQUXHmvKR4nEG1+SgFncDrDjfTNNulphcBMj4F8QawZG4ORF1/779eT9idGL5BTPaf1uHx8WLFs+02W/yyG+w4TI/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8Q4gYjUQC14yC5W6QW/OwqgmYc1DkZqkRCHzTcTI5o=;
 b=jS59t5NG8ju7WiQAhwmZDP3JN8VTTeHWBlOBX5Sl5ihrtFRnmFOSAKiKGHd8IMAyAd5Tkh1tC9lmFOcGxjwECNnOYA2SOZgdg6kisukZUEtuYU8aojSWG481ZdfHum4itu8Pe/b3LIYHFsnWlFUtLMAHx6fIBrsoW2C1bAaPQDQQvBNAIilhlsMBZMMmT0/I2KaNdPq8U+xijlEiz8uwiO7mebklgaXlSZ5H3o6tpDINTjlAKZmpqq275UBWKlv4EYY9OPqngiR5VL5uncPHtxrjv3/G5QVJs31hCfedvaTuHSBwlQ9y9+NjxxUagkb6dOeZxXqSOuBbwnejvlCniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8Q4gYjUQC14yC5W6QW/OwqgmYc1DkZqkRCHzTcTI5o=;
 b=lrg3PusXGuEv049XusUsclDegkC0ypjn5DGJXa6oOtUKEIvQr63DU5H7sSJdOAqJ0stt7Tb9dx62Pgjy7vUGbMrglqYEzi7H1uLiHb89auZUULfkLP5136Nqw6d3RY2jm2WDDB18QlWAQ7iHErlupIUHNjUT8fLqee1iN09YexY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9203.eurprd04.prod.outlook.com (2603:10a6:102:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Sun, 21 Jan
 2024 10:17:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.028; Sun, 21 Jan 2024
 10:17:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 21 Jan 2024 18:21:50 +0800
Subject: [PATCH v3 1/6] firmware: arm_scmi: introduce helper
 get_max_msg_size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-pinctrl-scmi-v3-1-8d94ba79dca8@nxp.com>
References: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
In-Reply-To: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705832540; l=2660;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=woqhTHJgcBsnzMOI1imkT0MV1gtJZhQATiD3eryt0aA=;
 b=44Bqa0Gh/2j2bCArW6t+6hWOq7O44sZiawis/gzEXzu9KM0r8eM84Onj1pGmGeSbKNn9O32Re
 4vIwpfWDDQBDZQROadB4ztVaXFt5gs0IYTeIrx4iFNsfuD115GKyJ2f
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 63aa5b88-5262-43ae-a432-08dc1a6a3d08
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F2o1C2G019wJByd53uekdNMfgU4LQ261IgzWolbK2IhTBZj0sSmK/CI7X1baDJjH+bhanyru0CRmXeJHAEHsGfoyq4YItfZdOEHCcCj56wt8kbXe0qnhNbMpRNx0e3NizDb7C5COFQWXWtwsXOz5cgAvMY6M4gUIabEWI4d1bncRUBwoC7i6n39UBdvQ4mGVcXCn+rHR6QdcDKnpZHhfDSxUdnlSTymNHycipnJPZlAHvk50FzuIaVKKBnsDoIxtwVLBWJYPlaqZORRTC/fQXI0PzT9vRMkEufH8hASZykWCJflv8t18SJPEfmb82jjfT/wEsvQ/BclseY4+ySWmJ3bzA9XrAjUTqSxJJP1iF6DKlNrjuhxoGPvpNng9t3Jxp8PjAzZFNwcrypH6JWeCHAtTkdn5U4yCLvkOswxf+heOL9UaSAUztGhgC+cmQAHVWuaTZQZbDSmsdhNocslCI69EgTMAnqHbzjy5MsaAnmAaA3T1mb9fdyaxcuXF9nKLfOrIrJrA7EYMUQB09gkHDEDCHmsnmTdbm5QJuxXkutR9ZOLHVSf0a8QTvdFeB2hT1LaZkbCgILr5d9ZkmKIYNuPqqssRHKKizUYrhQHZFZxwnicCiWFr8qDVqWMJpFos4K4H46dd2cQrZpUyK4GduQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(38100700002)(26005)(4326008)(8676002)(8936002)(2906002)(41300700001)(5660300002)(7416002)(478600001)(52116002)(6486002)(6512007)(6666004)(9686003)(66556008)(6506007)(54906003)(66946007)(316002)(66476007)(110136005)(921011)(38350700005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVArMGpTQjdRd3htTW5iUjh0MXk0OHlmNHJZYml4KzFvUUNBM3I3TFFLUkdh?=
 =?utf-8?B?L293ZUZPNUZwdXdWbGE0V1h1VE1ydTdNTGR1VzVtVFpsTDJ0NFJBNkF3L3Bj?=
 =?utf-8?B?T3JWSmRZcHJlWDA4dkptMDEvTmdkazg3UllCb01oT3o5Y1B6MStVUTkwaXl5?=
 =?utf-8?B?OTZFNUIvdTdxVVR6dXkxcFhzMXVtSzUzUGFzVDdjSmlhWjZzcXpWc1R6ZDlX?=
 =?utf-8?B?VmY2aTZpUFlCam44Y3R1QUZZaksxWWR1RGh2aDk3eVdLVmx2bnUvWlFZOThG?=
 =?utf-8?B?UmdDMnp1bWgwVHZDMFlxWXVDWE4yZUo4NDduT0xwNzFNNzNZUDRZTlNyRm02?=
 =?utf-8?B?L3AzaFA5bUZEQjhPZTFNTklJaENJNStHRW9QYkVkcUZ2M0VYeDZEK01BejQw?=
 =?utf-8?B?WG5CUWgwaWdaM1RwSGpqQ01hdmIvRkhNUXFNMG45TTZMbEZ4QmJVZXR5Mi9J?=
 =?utf-8?B?blRtQTE2WjBBYjdxVVNraWlHQm54SjZxeEwzSlBjbSt6Q0lYOVdBSzZYUUxv?=
 =?utf-8?B?Rm8zR3o4WDNFU01xTGxESGlLd0VLM0JkbklWbDBSOStqaUlFenlkUGJjV0gy?=
 =?utf-8?B?aFh0RnpMQ2dCcWpuemhNZ01JOHZSaXFTUmc1YkpHanJwUHFVYVJQZ0toR0Nt?=
 =?utf-8?B?L0dIWWhZMEdSdktKUmhnZDR2RUFtT2JMQTBXQzFhK1ZwZWxWSWs4dXArK0k3?=
 =?utf-8?B?ZFV5Q3NzTFdZVTl6V3VyckRVTnBsUE80Y1ZYMWczTXY5eEx1aEwxbDZBTnRF?=
 =?utf-8?B?UDJtOXB2VTc3NkVxbm9hWUJRei8yYThZTlRNUzdKRlIya3hqNG81SXZwTHJS?=
 =?utf-8?B?bUJJZ3FPVXA0cGt5VVIrN054UEZ2U3FwcEtHYVVWamFFY055MVBCaFZBV082?=
 =?utf-8?B?RGtheXM0Y1J2R0hLR2hjbUk0TXRMQ3dTcE82aU1wSlNRTmFic1p4aXVjK2tJ?=
 =?utf-8?B?QlcvVnE4dUhLYkhLWnVZcVNxZU1mdnltZDJOd0Y3VWZxbXhZb3NVZ0dBcWp2?=
 =?utf-8?B?YTFEQ0dZWis2MkZxVmFrWjY0Mm9TRG9JY1ltSElPMytUa1ZRV3hVUHVPRmJ6?=
 =?utf-8?B?MTZZWWd5anZFb3kremdhb0tGanVYN2JPMkRBQ2hOZ0huek5jY0grUjA2M0pV?=
 =?utf-8?B?bzlZY0hZdnJBYkNmVFlFWFhpRWpBYjkxMVByTGNhY3VmNjZleDNPUkVpLzJK?=
 =?utf-8?B?aVplOWxjNXNjbXl0WUtCWXF2bTA5NERKQVNkQ0hkeUxtcnY4aU93UnJhQ2hJ?=
 =?utf-8?B?MVdaWUEzc1JMbG9IcitJN1lCbit0bm1jUnU4c0lWemZ4amVUY2E2MHVXcG94?=
 =?utf-8?B?eE1sSTZ0YmpnRWNZNGJ1b00yaWplNVVBZmJjWnhmbzI2ZHk5Z2NWbEwwL0Fz?=
 =?utf-8?B?anRUMVZIa1o5djk3bm9tblJ2elJiTDBISlppU3pvZC93UnAwQW12czlTM1lv?=
 =?utf-8?B?eGVHaUR1NnZvZklqU0RPVkhSNTZpYWVSUmxZUDROMFpkYnlBMVJwWDRZcXVI?=
 =?utf-8?B?VnZWUVR3cWlqS0d4Y3VuMnhRRGprU1pRTXZiWXR3bm5ad2piZUZZVVE3SW1m?=
 =?utf-8?B?YlBWS0JRTFZGSjdHRnA3Qk8wZGpUV0lEWWswaHBCVnNVenFrcmRQQkpnZzlG?=
 =?utf-8?B?MGNDSmx6ZDBsM2Nhbk9NdWZZbldrRk45bHRuQWxHZFYrSnV2MVphWWxRZm80?=
 =?utf-8?B?VlZRN1lLVU1rTWtyaFlTQXh2MmFYRW5zTHBXTlpGODBRRHR3T2w5Y1pDRTJK?=
 =?utf-8?B?a0JJNHI5QTV6bWtSeWsrMTlJM290cXc4TU5IVHhjSGE4ZkRnd1lQV0Y3Z3dU?=
 =?utf-8?B?T3BNYTZBOU43bkEzdjl3SjNWNWl1cS9JQzVzVmpBOFpERjRaQzlvTzQrU1F4?=
 =?utf-8?B?VlFCSkxTdk9SNjVVYm0vRHhQMTJXOGR6Zy8yYnlWYjNXUGpHTmNFZWFnVEIy?=
 =?utf-8?B?QkN0ZGVJNXFzYitCdGF5K3ZKNzdtZU5FL1FEeW5BYUJjRkJvQ3RFajdkTG1C?=
 =?utf-8?B?QmFBWXFET1NCOGNEQ1hVbjNVUzJNS0F3UDRyNDlkdW1meG5nUUFYN2dSMStD?=
 =?utf-8?B?TW4vY1BjdHREWXJUNEVsM1RQRk9WaEJrbFdFTERibC83MDBHLzFUUmNGUUta?=
 =?utf-8?Q?CFPzDJ3NGJSkITlLzN056strt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63aa5b88-5262-43ae-a432-08dc1a6a3d08
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 10:17:57.3855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t95V2muBVciyrEx5M98njm5VlVlXUI62z3vTZ5uEyI26vP71P9QHLvfNS4Hfj2PFfkibPbBkazqfNAVvewS15Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9203

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
index 3ea64b22cf0d..a12afc254afa 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1481,6 +1481,20 @@ static int scmi_common_extended_name_get(const struct scmi_protocol_handle *ph,
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
@@ -1756,6 +1770,7 @@ static void scmi_common_fastchannel_db_ring(struct scmi_fc_db_info *db)
 
 static const struct scmi_proto_helpers_ops helpers_ops = {
 	.extended_name_get = scmi_common_extended_name_get,
+	.get_max_msg_size = scmi_common_get_max_msg_size,
 	.iter_response_init = scmi_iterator_init,
 	.iter_response_run = scmi_iterator_run,
 	.fastchannel_init = scmi_common_fastchannel_init,
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index e683c26f24eb..b5c65f26207b 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -254,6 +254,7 @@ struct scmi_fc_info {
  * @fastchannel_init: A common helper used to initialize FC descriptors by
  *		      gathering FC descriptions from the SCMI platform server.
  * @fastchannel_db_ring: A common helper to ring a FC doorbell.
+ * @get_max_msg_size: A common helper to get the maximum message size.
  */
 struct scmi_proto_helpers_ops {
 	int (*extended_name_get)(const struct scmi_protocol_handle *ph,
@@ -270,6 +271,7 @@ struct scmi_proto_helpers_ops {
 				 void __iomem **p_addr,
 				 struct scmi_fc_db_info **p_db);
 	void (*fastchannel_db_ring)(struct scmi_fc_db_info *db);
+	int (*get_max_msg_size)(const struct scmi_protocol_handle *ph);
 };
 
 /**

-- 
2.37.1


