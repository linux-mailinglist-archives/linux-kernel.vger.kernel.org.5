Return-Path: <linux-kernel+bounces-97240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E650B87676E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124441C21846
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5461F932;
	Fri,  8 Mar 2024 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KMPVhICy"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2072.outbound.protection.outlook.com [40.107.13.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97182C69D;
	Fri,  8 Mar 2024 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911883; cv=fail; b=MvrKC4u7O0IjYEnAcP5gavpjWmNcpu6Vf4TMiNII+mU70vZmnJgrhKM78EQGCHN/e0C5Ajjafy6sSHAtIAq8aTTm5Pc27JMQfVfjIuPjS/bG17dYHduEzeDyf2PEWr3evDmjG+gILEPXhavDMlnl7J8FHjnisdJXBwc0TRqM2ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911883; c=relaxed/simple;
	bh=vhxVnX5MWE/YYazAEq2DWjswf9ZVqHa5Xm9QHs88IVk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TWba0cVyYeZljCrUEp3h1dq5yACofZhd1FqbcFPbfWTcpppyLxcXPbszqT0P2cZsPU1SmPX+tEqHAjKr1+eD+UEFtSLw06zGSrbWDikQfaYQLmVs+8lASAnAYSAD9ReERgJtnXX/MQV8HUAjr1dEKZCzeaq6g9afzsQ8W43UX5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KMPVhICy; arc=fail smtp.client-ip=40.107.13.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVMZzVa0GgXhooiXBarhQiewOaEHSdFZTqAPPSBpNXwWdw22RFRNCPGttlblPafV6fCx/oPn4/j+eSKysTB8MBPx3LIbcJzkZJWqfLY69KftjM2RUEy8lxx3h7T+Lysqkr8ookp9mCG0fSbwcM1QkL5N7PeMicYbuVHiYtFfP16MX0iYIDUzxuBgbhTz3XxCAkBfKXqTC8vlhvMqvTElIvmbUZQZmpXcrgfFkSFieUtnc1N3MJCZwAWDrbPhEcuaiA5LwAbiEFjN5bXHNs21PVBdVJ0uUmIPew3+tCsL3yq3BDseuhMrectparMCQt+OWNPqjWbSP0Sx9CoLYpgs0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0mcUIHdQoXpcrCDeMb93Qo9Kvs+iHjA9EaUDycGjYs=;
 b=BcOn1/WSfEcXWNsflTVBtEbCHA8IZXig2MHvp2litDE4ucOD6WYrcwCxO29XFHqLfynrgHJbvNhk/j9UUQJsxZGK4mJfsFmS86pTixBTRRHpQAYIGEf+Si9nuVlvnV/Nm9eJLZrnhv0WDHZGe1sNWChOu+nYF6Uvs/EpQVzj78ZWgaycVpRWWMst/Ng1g84WMghrriDgehVX07deu5ytMgrXPA4PD6AzmQDAwxeHzzqvMVE1LJSjpriraH09WaiUZGr7OdqngduNg7/nKVrdY69pmXjRpUrngDoZFHpRtHxXw+trwdQsiWJolwwQNyKznaNvZgqzbpFCV0SAmya+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0mcUIHdQoXpcrCDeMb93Qo9Kvs+iHjA9EaUDycGjYs=;
 b=KMPVhICyVlqBGKEPqo3XjndFVUxRxygfPqmUtVz109L/84ESiE+VXzhtqKFoNVHfaD6vRIeG/R1q802aHcmGnDMNcooZn2qML2TbG4eBdkXQ5NsBD6M9ePKH0eNVY21DKcNN6vBLyi7O9AUdSRw1oAPFWER58xTq+9r1vXWGvaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8116.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 15:31:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 15:31:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 08 Mar 2024 10:30:51 -0500
Subject: [PATCH v6 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-asrc_8qxp-v6-2-e08f6d030e09@nxp.com>
References: <20240308-asrc_8qxp-v6-0-e08f6d030e09@nxp.com>
In-Reply-To: <20240308-asrc_8qxp-v6-0-e08f6d030e09@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709911866; l=1420;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=vhxVnX5MWE/YYazAEq2DWjswf9ZVqHa5Xm9QHs88IVk=;
 b=j//yU7UxfSNm9hv5ECG7EGDw0xz3geIa70tzHi8ybB1hprlOCvq9gLBlEseYqscZMiMiE2mNV
 IzdKzGT4firDqItAdcfuHohiyNL0eaib1vUai8Ij6w1r1eZTavgQiBb
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0151.namprd05.prod.outlook.com
 (2603:10b6:a03:339::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 317fea58-d6cd-4142-a24e-08dc3f84cd4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PDezQB3dCtIhWt2qpSgprEDK7b1WpFvRpvR2nGQemPrC7p86TT6S3l5j9zXBlAAGQ7fHkFe6lnCWWxMRcU7m4/vGT6A8ihaqKs+2zlAho5ttVe1fYUAGCXqEtvOfe+tOS1VI5ir0l0bwFBBwzzANohRfX2ntUn9uiwGNHJevV3WkZRsol2CHne190QJEuPt//9J5P0JrvpdnxaV24j3FQmZ0zK8hv5R+MvyiI+JfI0YZqcbOfQAHv11Je+BuwDI9QqkasZkk7VsEyLi1pYbgHIvwVAN17lX7yDs0ax5cpqhEaptAUc218MxVgK2L9s5gUpUa8ohMj6pxX98WXkRP+xhXrigwc3dkbyGfmC2Su8TUsRcmREbYRGmLZ+zW/qPGPAU6nyGInM5y/WPHvai241/PqR0vIgxrMBL+gCC1EM2XEfAZVxtemKYVSITolWPQdyBY+OmVLvLlehecXcwrUycz7rB8fdnrg7hhg2eQ7MEj47jknFrCN+PPd2VE/39AZyAj6wTctmZABmnFeiM8OSDf4gzW/1hbmYI3G8EsFszmiDZkX+whSQzGOrYETEJAtPTFLUfv80VjxfKjUk3yEOwOZw0r0NX6t49lg3hugrGDfJSyoSBCF9Ji1fhs7cD3ep7DPEDNRetGfDq7t8VuVGqn7eEgjT4Fn3186UVXIhJJJeXJt90L0iqlyC8a154mah6M4tzZRUzizYHIWNJ7E1D4E41lTn2fiJHjTj9VEXk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUlaR0FTTmJ1YWFjSStMSk9zYTJyTnRMb2ZnNUIzVks0ei9DcWtGeG9VcVE0?=
 =?utf-8?B?elh6VWxtTGQvbzJiTWpZYkpDZWYxanI2bWtrbHFVaDlRM3NCeWgzQ1RLbHpM?=
 =?utf-8?B?dldjTGZicWliaXRxSDFoeFZGeHUyREIweVdHejhXKzhpeWQ2UEltZXpha244?=
 =?utf-8?B?Q2hwWmN3b1N4alFBSlpJSFJWcjlkaDNRdkF1RWNGVmY4cGZZNDdFbDJPQ2xp?=
 =?utf-8?B?OUJtYmdCR0pMT1RZMXQ1dWZ6UkJmVnkydlJZaW1pUDYxUVVycmNqNGFvc01Y?=
 =?utf-8?B?aFNWdm5VV2d3WTRDcCsvaUhINTQrOEVqREo0Y2R0NFFqakdoQzlPcmpweU0v?=
 =?utf-8?B?SXQzRjl6dnRUdGRTMUljT0Fha3AwZjBGT3lKaU1xVmptcVh2ZVpLOTh2Q2oz?=
 =?utf-8?B?dDhPK0RrYjVtSklUMmFOR1NPK3N2Q0tVSDVxdlhSQ05zOG5ZSEk1QjcxY2pE?=
 =?utf-8?B?bDY1ZEFvR0JERDhNNEpZUS9mUkZVTmRaNktQUW5qdFZLK1VhOWxZZnhwOU5z?=
 =?utf-8?B?MG1LN3RmamNHTEF0RmpBeEVWR1JrRG5KYlo2MTNiNUdFaE14ZVd1MzBocVky?=
 =?utf-8?B?TzZnM05MZHpDNEZUT3N5OGV4cTNjOENmVHZZem56U1ZXZVUvRVZQdTFFNXpJ?=
 =?utf-8?B?eHBSZE9TU0tOOEx4QUlBbmk0OGQ4a2FGNld3Tjl2SGRtcXpreWdLTmNsZmtp?=
 =?utf-8?B?SVk5WlhwSFFCMVpZRFdJYkVsL2M0UldVaGFUSHlKTkZNSFZyQm1RYlJ3TlAw?=
 =?utf-8?B?b2h0eC9VekQxdVkxclpBekV2bmx0aEVsV2ZQZTNpSEk1clhVR05VU29OK3Ux?=
 =?utf-8?B?TGJCemJrUThObXRURk5tdWdtQnF2alJNUUNXbWJWZjBVMWFBeVNFMzBYTFA2?=
 =?utf-8?B?WlJ1NXJTdzgzT0ZpVWVoRHcxR2RQT0VaTTJNQThHZmZyS3VDaTJpdEZiZEdT?=
 =?utf-8?B?NGt0Zml2ODd6blk1L0MzT1ZvcjZUYzAxMmVtNDNQcGR2ZjJSTkxBK1duWndL?=
 =?utf-8?B?Mk1tTi9yVE5pcDdhWkN1SEcyTjFlVTk0SVB5YWpMN2p0dk52dHZWOW9vd0xi?=
 =?utf-8?B?bjArUnZSNDIyK2dOZncybGJKamcxNERUSTRGSXgyamE2YzJUaG5yOTAvbEFz?=
 =?utf-8?B?YTBFMzVJNmcrblg2QnJLUFl5RlhDbU5HZUxYaTAyakxBRjUxRFpxSW13SVFI?=
 =?utf-8?B?NjJyd005clRmZWd0UnY2VzJkc0xOUkxGb0RhZW92NWh3TEJDZE51WFZudU9Q?=
 =?utf-8?B?cGZkWk9ESk15SjBJUGtkdnZoWm5mTzFyVmpRLzArNkJxTXJiUEtTdzFIRlRz?=
 =?utf-8?B?UUZXTWhLZUpQYjJDbHl5SVIvOW5UOHJrWjBQSkwvam5QemZ0Ynp5QkU1eDRG?=
 =?utf-8?B?WDg5TzVKWDlLWWVwOFlkTC9nZ01iS3FBck4yZVhsdjhKVlZubldzVm9WUmVH?=
 =?utf-8?B?QzkxV1JoQWV1WGdHQ05qb2UxOTF5amxteUM4QnV4ZW5DZmJFN1hlcXlLZjM0?=
 =?utf-8?B?N0pubHZYdDU5b1Rvd0RvQ3pTTDY0UDM1NEZRK0N0czRzQ1NEWmxKOVhPWHhE?=
 =?utf-8?B?QnA0NnhwVVV4dzlwY1NPYmVpTHAxejZYdU0wSWJpVDJLd21CSnhKY2xaM05X?=
 =?utf-8?B?c0cyWHlxdWxQNVpKSjBFQ281aW5NWk9YMEJFejMvVElUUHJ2ZmV3VnplTFlu?=
 =?utf-8?B?L1FqSWRDb29FR1liSFVlUE5oV2JiNkVrY3M5ejdpS0phc1RqRjBwc1hBZUky?=
 =?utf-8?B?REdyelVJeFg1OC9NbDVJZjBINlcvRkxtRDBhTklBV3U5bzgrbjNUT3FEWDZ3?=
 =?utf-8?B?clN1NkhxTDl6Z0MycUJadDhHQkFTdmJkc2dCeHpUWU0yV2tJQUVKMGoxYXlM?=
 =?utf-8?B?Kzk0ekRjOEhaQzlQUTNYWEhnUkErREk0eGp4K0IrQVJyd3NCMWk2STJJVnJq?=
 =?utf-8?B?cXYrK3g4c2hLZlh1Q3hmd0VZdzNYV3ZXRURueEo4bm5laVBoRm0xd250T0Ex?=
 =?utf-8?B?ak1FVXRFZEZhODROcEdxdG5CQVcvSWxqc0pJYVpyK21BZ2JWNE1jbldEdlhN?=
 =?utf-8?B?NnBTaEdYb3l2bklDWUloLzIvWS9uemFRRmdIT1BxNENqQnpTdEdPbnhXV1pr?=
 =?utf-8?Q?10mQZQUFfcyYex8MF9Nrj2jiq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317fea58-d6cd-4142-a24e-08dc3f84cd4b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 15:31:19.3954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sehKEGasz/1Vs8gw3XO1fojEMENc66GgRmxm3/ySkSO3cY6HLujz6kj5Fc+4rTw4tn8ddz+JMB2rZb7+Be7dyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8116

fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
have 1 interrupt.

Increase max interrupt number to 2 and add restriction for platforms except
i.MX8QXP and i.MX8QM.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/sound/fsl,spdif.yaml        | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
index 56f8c0c8afdea..a242f68f99f18 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
@@ -31,7 +31,11 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: Combined or receive interrupt
+      - description: Transmit interrupt
 
   dmas:
     items:
@@ -101,6 +105,21 @@ required:
 additionalProperties: false
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8qm-spdif
+            - fsl,imx8qxp-spdif
+    then:
+      properties:
+        interrupts:
+          minItems: 2
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+
   - if:
       properties:
         compatible:

-- 
2.34.1


