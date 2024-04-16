Return-Path: <linux-kernel+bounces-146271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB838A630E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6EC1C22BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F143D3B8;
	Tue, 16 Apr 2024 05:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o9t0W6gf"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2086.outbound.protection.outlook.com [40.107.105.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B26E3BBEC;
	Tue, 16 Apr 2024 05:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713245733; cv=fail; b=A9Em5e9zmBdkwwyY7HGrkTDEqtRwAyRTTLKY1ALQTcPI4ASnEqAsYlltZEAauclcxIp7uu6b9VsMxnCBSd9w37tXGJtRqz9c25+BQAjT3NGrHrjc/6FJcXiJmqGB+FiHTd6ZSk1E/WhvlQUcmatI/uJQVUqJY04463/GWHnNHvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713245733; c=relaxed/simple;
	bh=EORdH5UENeh/FPjj/33AjD4Eb5mIyNL3JZ7wsBVs2/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y9T5ZHHOUE+QvYCTAr7xy6WPBM6yE5BzVbMTKIQtFn13BTdc+Qjp7/XIVGf7FdkG8vGv6ZA/adnbELqb+xEGl6DKAr6QapRBprl32Inf/Ne6ZAEvNrrhq2HtTf5ZnRAYMd5wwUTNVPscfn6ZlIgLKGOwROPUcRoDoAbXza3pvK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=o9t0W6gf; arc=fail smtp.client-ip=40.107.105.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWl4yqf7yfKTDA3QYQmfHbgsMTU1kbVsHsDupZVE1LTwu3umIxsW8WVBYZ8ps6V60e/gzlLWB8LW7fm8K+AVMxEzxJSW1LK0Usv8yq0V0Bi0OVi+rnR3+vhnn6/mqSnTxUrW/Nh19sqOvZUOBYSGNVIapVz42QUKYYXtxP9sJcFY5aUaeIIQcyvUrr+hEaT3hHVhMmSJQafq7iSPW/eSUtiBBXRbkvSEj7HzYkyjAZIx+oZtLgsvH84baWt1cR2sH1n8uHOdp2xkmzyArBguXWjiocQZlgq4Nq+9z6KmH45falL1Q3uAAXEYHdauN9peLTnB3nYT7nuKXA3wrp974A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNZJfSlEXEnEN8HwZbzBBuXNDsBQi6bsEwBXVIVPiDk=;
 b=P69+jflB+ytUSmoLiQiGwL0hX52X90BU5juGcxfZUlgeTBAqpIYh2Mg+y6+2iUIj6KK6pECbiboT80HCfull6xd4DxWjddDgaw//DZ985lgNFsQgegSa6NFb0l6ayhzSi17oX0t4zg0paDOQ6Y3zbYbzU03j7iFCoyfhh3vL8UUS7aedt3DKbtGRS7Q8NBhwbkdOPnEmejK5WrBmn13djunh/zGVOiw/5L5rDR8SJ3Y9ajXoHo35xQ9scBbnjUrKdgGn/ji5XMDrWkhj03H0Z3FE+R1UeJ3duXZFlewz4fz5QLdQbmY+IKLNpwWGoSW6LHNotHnb3iMylLHDyOwv0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNZJfSlEXEnEN8HwZbzBBuXNDsBQi6bsEwBXVIVPiDk=;
 b=o9t0W6gfBQQg3LO+NChsvN6O6LZ/aZGTGZLuMvTOyZ3PHsk3q7UWPxcb/Pklcczwew+7bVQJ5kmCSaqGBwLwG2RE9GHwyX7zX12jgVuuVt5yMBBdHy9uF2e66FNlW5jchC4q92jY++XiQ9Imy8oOPfco2eFXDNgvSnG5gOaSz0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB9PR04MB8122.eurprd04.prod.outlook.com (2603:10a6:10:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 05:35:30 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7409.042; Tue, 16 Apr 2024
 05:35:30 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: gaurav.jain@nxp.com,
	horia.geanta@nxp.com,
	V.Sethi@nxp.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	iuliana.prodan@nxp.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v3 2/2] drivers: crypto: caam: i.MX8ULP donot have CAAM page0 access
Date: Tue, 16 Apr 2024 11:03:03 +0530
Message-Id: <20240416053303.421259-3-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416053303.421259-1-pankaj.gupta@nxp.com>
References: <20240416053303.421259-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB9PR04MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 148d697c-25fc-4cd8-fc47-08dc5dd707a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9Hk5VQpiKnnSOlvbsWJh3g5IoTpg7krF9TrHQMnF2RDLMEut5Api5NiFuGyLcv3ZBkGrvRgBhvUzCz1obA+yhZbihHYXEI1DA2eF5DWyuSdEWnBpagY62iMI/saakYNeIolII2C0aF0EsaBkF17/yrAUbjWWdgyVTMvXc3qHYviBpNQc0H+Sh3YtdSCCLaC/rnmKa+Br+XrqbRUU8e+smC/IkbIoSFlA45XAtkrz+XqAkuiw4cITNyphP7eMqqm6brouh9VMuk+tb5ZSiLa8+eJ2pjrFR3fcdfVts8Cwa+dNuoQOoLqhK4G2b8zKsODs5/2bKR8BvTBbvHBBVy5Zpg6CZwMdKQ+NtTqj/IQBfBdyjPtu5rtvQK44SdI6yzU8u6z7k69WXJ2N0kd+REJHI1F+YlHdhipPLgb5l4oZ8/ijZE7maa5bvCwd+q46E7t3AUDwb4tNxtl9pVknom5NSGUB7YoK5qArWl6fjtfVa4fAt+Bw/knXTeB0+6ES68v09Q8aSmm7rmLLFX519myTQXm2ATUTRbWTWcjwpEknO3Y95+eFEJYGZcZYlRjEni1tBYsLiT+WVZcCyqqQAY75JnLQlJyNbruUuFPrsMWsllfsg5frwVnUOaYlBDFWuP5Fk0bhNy03F4451TL2OMWSZ7FdzJoiPNA8/xkEZPzXwBX/qia+F/yzzlEP3FBalGL4oum+7H145C+lBT4MeYm0Yw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mbhu5yyJ0EmKanm5LB4BCYhDpS6PJzptC9HJUBGtgD6O7J/1CAYukbDRWy9G?=
 =?us-ascii?Q?BQOeyJ98xQAVuiLwEeVyyVQ/Zlu4icZHXjCBrpyt30vohBJmimNqXTxsRMuc?=
 =?us-ascii?Q?1s0RLR/jbhqPfBTrlcQpsLTZSEf/GLcaQKKRg9U/l7t+alsK4rJfYA4RxvhA?=
 =?us-ascii?Q?BC1LgloDlEQckBC6dh8M6NpaQ7AR+KhrsnBLLHl8n06XVj6IVWPnGVJ0Tc+i?=
 =?us-ascii?Q?PguINxDEEtulmvdE/+f7KxRdzczBpIP3qENMVJFOmQ6gB08S7TLw1hiK0EnY?=
 =?us-ascii?Q?HAYEIIlF5HqWinoU/nCGHJmkEWk8SQpk7CU0GKh0MSn06cEQrR6UnBM7TmR0?=
 =?us-ascii?Q?K4WLUMVeNcs6QntvtsOL1c0UCnGcpXU3eMfv6LPGr6SYbuv1f6AqtzMIe5Cz?=
 =?us-ascii?Q?vET6GICuflmExhgaJp1yYSH8/Mbn4KXNl3BjPL45stvzwmoBy05Kn+WKptEe?=
 =?us-ascii?Q?gf1iZwhpd49Q9OVHSqIkqt3mW2ClkGaBQ2xWVOIAY8/SE+wkZb/Oq9XjiXX0?=
 =?us-ascii?Q?QluRQV3lCMvphHyR/t/O6ncVeQj80mVjfk1oGtphGW4ntQG2bjN6nZ9qtkWv?=
 =?us-ascii?Q?vZdr9EMv5MprdaSQ1mkRfllf7QvQUtuGnE8OPdhCwuot/x1hwGcDgkP0GV7w?=
 =?us-ascii?Q?l1qKmxzoarclQ4aT4rkQaqYE3ob3aLtEbaXG/uc++bYbZ2WKP4RF8kt/STsI?=
 =?us-ascii?Q?wGKnfdZw1hZxbXeqcxPvzcoy1qUqMXHujm/uS4YEWXWLDnh9Eog2w0kaNOuY?=
 =?us-ascii?Q?daD232i2xbNP0fllMwuX5oyv89NTvTQVsyxdG5mnAyt10ma6hb3r7jlIEcDt?=
 =?us-ascii?Q?u7BDWuRovVh94wR2RoRH8pBaslbON+/fD86cVa8PlW/F++jZDVAMOm3lo+K3?=
 =?us-ascii?Q?E+m7Fv9jrjxFQYjTy6u+Qz8WLhF0RuhvE26u3zVOHU6iVXc+w8GMCCeHEK+y?=
 =?us-ascii?Q?dduwi6CfuTDJ1LlBbgutYWmOXyzVJ7xRcBZ82xvmjptPkRv7UUsQJcqY49ZP?=
 =?us-ascii?Q?AXCLxHL8Ej/VTRsn7cYLqQX4L926lZUA+EvJ5NQZyAOwUdJ0a9Dp8PiYVvcd?=
 =?us-ascii?Q?4FUJQRMGghq9PqTan3xxOmFOy8nHIMlK5ct0S1pEwx7oOHeTAmlFozJHkVCc?=
 =?us-ascii?Q?ValNZ6ksVE0l7meDrK5iGYWMMNak+tTiUKEA9sKwnFUHh7moA/idKzhaVKMw?=
 =?us-ascii?Q?tXLk27uPJkRYWcmxQXWIPjqsJEl499xTGuzsManKjP59WC56B9TdML3wuk7r?=
 =?us-ascii?Q?veUAb5H9whJ5ninQL2LXBd5V/81qrjTuLCjTLy+3Ura3wAvE0RU2AQuJEngv?=
 =?us-ascii?Q?B8ECslyiLjL+xLbDZ1aNnehEf27Y/k2boEnJwRdFBybuHuaO8Dm5adYjdu9q?=
 =?us-ascii?Q?dT2eN47ksSJp/8mvFeYn56dHTsr8764aNirsMh8YRXx7sUMfaabSgD9+3N9W?=
 =?us-ascii?Q?axEfmAUpC5wi3ToZmn2878SinOIi2D8/TvoiyFHER8RwcOQaUWJE/DZ0xJRm?=
 =?us-ascii?Q?boYym8vN8xArHNfQdr6Guph47tEGW7+3Y7IIyWBDWfuOe5n9KDCgZ+hrhiua?=
 =?us-ascii?Q?XKqcEvcY1IqFrLMWafqWQDD8avE3s9vGIyoI/IWq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148d697c-25fc-4cd8-fc47-08dc5dd707a1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 05:35:30.8683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVNxVrh5POsGR4cMJTYraJhjQqHTqhHDSrGyABZD+3m0W6NPsGFb6yXM2CvLewAs8iGyzRQHoaR5tO9/VZIfCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8122

iMX8ULP have a secure-enclave hardware IP called EdgeLock Enclave(ELE),
that control access to caam controller's register page, i.e., page0.

At all, if the ELE release access to CAAM controller's register page,
it will release to secure-world only.

Clocks are turned on automatically for iMX8ULP. There exists the caam
clock gating bit, but it is not advised to gate the clock at linux, as
optee-os or any other entity might be using it.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/crypto/caam/ctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 247d42aa32df..f0f87fe8ef92 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -563,11 +563,14 @@ static const struct caam_imx_data caam_vf610_data = {
 	.num_clks = ARRAY_SIZE(caam_vf610_clks),
 };
 
+static const struct caam_imx_data caam_imx8ulp_data;
+
 static const struct soc_device_attribute caam_imx_soc_table[] = {
 	{ .soc_id = "i.MX6UL", .data = &caam_imx6ul_data },
 	{ .soc_id = "i.MX6*",  .data = &caam_imx6_data },
 	{ .soc_id = "i.MX7*",  .data = &caam_imx7_data },
 	{ .soc_id = "i.MX8M*", .data = &caam_imx7_data },
+	{ .soc_id = "i.MX8ULP", .data = &caam_imx8ulp_data },
 	{ .soc_id = "VF*",     .data = &caam_vf610_data },
 	{ .family = "Freescale i.MX" },
 	{ /* sentinel */ }
-- 
2.34.1


