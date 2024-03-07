Return-Path: <linux-kernel+bounces-96090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A508756F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4EF283B41
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70C8136657;
	Thu,  7 Mar 2024 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bDENe2OB"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03DA135A5A;
	Thu,  7 Mar 2024 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839185; cv=fail; b=QkIs9aWAgJQpn48dYgynz4XWrnu5hFtT8XHfeH7L/uSRGEx+qDw0HeE1/yZiuA5pvqJ3VbaZi3wA+UduEMOSLAw0T7VfbRwTvD7s0dhcsr4eFKyHO6QyAp8JeNU5WJ+ZU/xGxYvJdKd+ToW+hGtbnukrc8aeAtKCqZXD1F3BC10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839185; c=relaxed/simple;
	bh=ty5f4I1ceJv/bmgzC4ekvcaYJmsOaQVPeFLA9ZTjxrI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TLFLaZUBgYDWY2j2HVFwZLffLY8JcPTBHSR6Ne1BLBT6jLdLmzKWP2AxPPprOSGvqLZZEyK59LeHOILR06bDKUOYyh7p2odX4g/3YO+9QpaDQ7FRsT6V3mZwi/ovcvZMp96LseIdSgJwqtTqSma/599mTc7LL+lDT1EDJom1Z/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bDENe2OB; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9b+5e8X9DtdNLEBzQ1o8Tcu/sttJLZ9B8jLzKAu4VWBHrPlqPC8S57fOIV2u9vME6jg2WAE3YyXgEvHePETOheRnxQ6tWb+0Kbb6K3jVnJRKdoh7s1+se5rkhOo6IpUDXTPNUMkEtyggCDtHBEXDcheCOPq9xsxPA4KKeIlNEvbBZ/Xg163+s0bLgj1NvUNHXcK1OSFjP8lY8U6GJFi496xuGhNQIveYlScSnNH0SV7TJwc7RdndOzynrb/07sMDDenDc5ySbwJwtjfdcH2hhBeFz1OQB43+VDtBjyk2/pwC2irBa39/Pp/HLd8FIUHIV1WkOXEB7WukMb3g0/CFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ry9d1O8ri36OnOsr//vKZPxLW9rq4AUGvF6G/VAl8Ic=;
 b=WGE4A2xmsbuviWOKTvkSjD+lns571UFwgWKSD3UwXfszKi3Oh84m3YliEDl65athb1AVUb1tdwcJYNDBQpPRc10K3fKSO1a5Bs97UpEGIz9sl4x9Qy38tSa49Y2MQ29fCQMCrp8ou5yVFhfzHlMYhhoWOrWyrqqUGggtIIC2mQO/Ac0IHX2SE5ViC1JLNLilRW9bX3vyyr5SBeeykfoeidkP1H3ydz0r9DK13Zl4r6/AB1VDXa9rdFm4tLv5B8qbSBKNQbchY5yTsMFx4puNlmSrzo7KMmfO9+ZBAhNzeE23UPRCDOdTHKdfEd1TCCSSI6dtLYvYq35ts0vRhxXaPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ry9d1O8ri36OnOsr//vKZPxLW9rq4AUGvF6G/VAl8Ic=;
 b=bDENe2OBLp0Ad+KH1OGBbmycr/nXU5yO5pzE+Y0gtcmAr2JR1S3fNum1/JVdrz55qe59tT1ogP12ZaEN2V7RabSiQU0XyqSp7GvdThwW+NAVcrTa46yreYOP8z6YJdfP3GeY7J574r78w2VF76ZF0ubXjCPalxhbE7qdDKrdr/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6992.eurprd04.prod.outlook.com (2603:10a6:803:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 19:19:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 19:19:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 07 Mar 2024 14:19:10 -0500
Subject: [PATCH v5 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-asrc_8qxp-v5-3-db363740368d@nxp.com>
References: <20240307-asrc_8qxp-v5-0-db363740368d@nxp.com>
In-Reply-To: <20240307-asrc_8qxp-v5-0-db363740368d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709839165; l=1255;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ty5f4I1ceJv/bmgzC4ekvcaYJmsOaQVPeFLA9ZTjxrI=;
 b=MeNd/bLGApQZX6DTf1g62Y/JLcakYhK67/Efo4R9Kf4mBRFH3PnDe5JZjXI/yxKI8aCbbcCp1
 cgtsD/60BYbAtVM96AegNJlTzRxJECBZzW636uZ6ZD5uL8O2849iVbu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: ff60cf2d-7097-45c0-cda1-08dc3edb89e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KGKnkdsx8uID31tD8sE33nHCH6qSgaF6NGJGb3r5T9DZm1zB+IyCl7+kGAgTJ1KDms6oaeDYgmdZlpBAZU6oPbJ6a83JDjc1mlNqinYubv4FZ7HZkePyJ2yA2E/k9ROfhkXIVvjSIuWVwqtNfEsRCpXZinegKaB5JJQkal8kvaTdsUOHIDZQTzhyjJfj2NmAn9409iYrl+SH7fGSIB1+7VOfpBa/Wg6N6PQRpz8lhtFDmHgtM+Y8jLXfivUW0CHfx3UKfcYe5n5STCufFdj+5M942R4urE0msH6xgkdJ5nQVCyJJFjPMQO4xvsYa3eaX9I2JSturNkDX6lj6s4y6vBFd9oPOHhw7zgLrcFcvvApts8CWL836sen3ofA9URY3h8sioAU3O6hc3fQVUMq6Bp6o+J4fLN1ugtBpxvR4b11F+n6JYe2R5e7OiIjNlqlrRx/DPtiXqPUZ/r2zLf3bKANs0fRMUsdmGtHwHp2W296TsaNGI4rk8NVjrCeck+1UOOuTeJ+9dW6SHjw/1VjN9gpDZLT2vhRbyi3w2pkttTz33HZdThpaO3zgNhrYfcps3+hZI0miITVwXLX84D5+eUEil0UTP80WpGMoREaItnghh+a+ALYhnXNuOeZFhsQaMWErr0FSD/T1pLC8+TXD8GUJRo7IZT4NMKa8kIwI3kn0odkiCrgzAbttYoIjzqYYiGDB0cyqdC5YXkhwyP2qVhybQyFzBj/p8hk/79tuRN0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVZLeVFpVGdpVURUdVd4Uk1ZYmJjVi95OHFvR281WjNPejNLM0lzUytuNEVL?=
 =?utf-8?B?NnY4SzFyZ1d0ZGw2bTBESmFMK1F2WGFYNzcxdlNLc2NCQ0daSjFBZFY0OGov?=
 =?utf-8?B?OFY5Z1hzS2tNc2hWcmR5K1M5S2M0cVZHUmNVamhoTnc4Vi95S1FLOWxIRnRR?=
 =?utf-8?B?QVJpNHFLeHF5Ukp1QWpldWRrUHZmbmlCQmxFR3gvcjRPUXRXbnFjUnRpQlB4?=
 =?utf-8?B?UWNFbDNXcmFTTUVQVmxpOHFNOTgwL0RXa2FxQjBlSTd1NFJMU3RYbjJXSnhY?=
 =?utf-8?B?NmtVWUthRGV4Q1ZKMklIRE9EaHMrMjFCYkpYZ0x1TjhFbnFPNHVsazhGYWl5?=
 =?utf-8?B?aGxuRTdCZzdCdjZsYmVzWE94NFIvWVNwTWxQZzVQSWt2RExuaDZIUzR3eGhm?=
 =?utf-8?B?TytocWZhcVEvRk9TVElRUUJ2dlBWM3ZIWTlGUW0wYlZZZFpmMnBueHpNZXph?=
 =?utf-8?B?TGVvTHU1WWVkcXR0WmRGSmh1OXp0YTVuZkJIZzY0a1BkS05rR3RPZ1RPNTFF?=
 =?utf-8?B?UCtwajFieHB6clArZm55OUk3NUhFanpkUnZpUFJ6dmgzQ2srWFU2NFAxdXdN?=
 =?utf-8?B?UjBmRFdHaHY4Q3VxY1ZlNk01d3JjQkZqaFFod1NwZjV4d2lBRmV0MnI3bEQ3?=
 =?utf-8?B?ZkNmUUFwd2FwL2tlOUNORmwvQzNvWCs0MzZOU3NNTWJDdmQ3RU5aRWhJTHRU?=
 =?utf-8?B?L2pTVVkzc1ljbGtDbWdqRGY2ekR2TWd3VGJYR0VTSGtja1AzaWFSZUZwVlE3?=
 =?utf-8?B?dUlFbnF5YzZwL0krd01ReEJxdXlZV1V6cnd4SjlaV3FUclhENXY2cHdZNGRL?=
 =?utf-8?B?SWJadTVDUEx2NVNoVXNWM0JuU0JDQkN5VE9xaTVkRXZCczJXNGlLMmE1UnFC?=
 =?utf-8?B?WWJScDJUSDNCcXlTZDBZb21lSGRrb0JienBjWXBUV3dNRG5mTlI5ZGh0dlIr?=
 =?utf-8?B?djZPZnJaQ2Rtb3V3ZzJmZTJFRzdGQXJVVFdWV0hoYzRnU1p1TEk2TjVpbkRh?=
 =?utf-8?B?RW5EZXMzNTlqdTlnUUt5L3BkNFo2ZjhJZ25idmRrK3FFMzl6SG9Lc2NpeDF4?=
 =?utf-8?B?bmRuNWd6eThnUHZjcHFxaDBVb2NnamVJKzQ0K0xYek9HQ1dGNTNoYWtNdUhy?=
 =?utf-8?B?cDZ4UEp2cythUFB3NERiTlNTeXN3MEhiVjdhR0JWc1NmaDc0Q21mVjdOWHNn?=
 =?utf-8?B?d25YemJZOGsvN2crMG10d2lMbEJXbWlpU3NnSS9tSVdYTUUyVDhDUlZnYnBU?=
 =?utf-8?B?aE0zRVBPcUUxcWZOUC9JZ3NSeXFKbjNpQUpJazl6UHJHVnVaaWZRYmN6VjNM?=
 =?utf-8?B?eW9ZMU41MndocWFRQWZnandXdEgvRUlxaStkZWxIbUVKUE5MSExhcHNJSnJr?=
 =?utf-8?B?c0VCR1EwWUpONmFXVzg5NEptZ1g5Y2JzQjhyeUI4bFRvWUw0OEx2bUxUYU94?=
 =?utf-8?B?WCs2VXcwaVRxbmtsQi96WkhmNU1YNWJrR0xyZ0tKemVmcDZuWmhoQXRSWXFl?=
 =?utf-8?B?Wkc5eGdOR2lKaDAwRGlISmVKQUx1WEdPRlpNUXN6ZmlUbzVQK0tVZ2RtbUds?=
 =?utf-8?B?UVJiLzB0VnNuZGhHSzZ4aUFsMFZJYXZsMmRiSlh0c0VYcVlQeDNCblNQZUd2?=
 =?utf-8?B?N3p1VEs5MjV0MEpQSGV5UGdpdzRzSk1pSlhYb25EMU9weUU2cU9sS04xdFpy?=
 =?utf-8?B?eDBocnZ5V1FEV1l3R0xXbjhFcU1sb1N6THRvOXQ0cStlZGVrNllob2J2N0ps?=
 =?utf-8?B?R3VKRW5zbElmZVVZM2NFMVgreGRGdDQ1T2ZCdU5LaG45Wkl6SXNpVmw2SkEy?=
 =?utf-8?B?MjVXejAvRE45bTBuQytiZDBzVVp5eGVYSHhXeEQrdWMxK1NUY3ZHZGwwdXdq?=
 =?utf-8?B?ZEljbDdSVnUzWEo3aWxEdUtLZjVPTHR1UXJNS0l1UnBEaXdsZjR3S1BESThJ?=
 =?utf-8?B?SkdpZFllTVdHVnRkTEp5ZVhYM3hwQnIwM1lqRW04aEwvOHJxUGVQMkFHZ1VZ?=
 =?utf-8?B?a3F6Z2w1TUc0c20vd2NBckxSVzhTWFo1NVJCQTN1V2NrNEFONzA1U1NqSjFh?=
 =?utf-8?B?UmxrZm1uUXpnQW8yODYwQXhHano3aitZTWFKMFJqdDIrVG52V25keUdhb0tR?=
 =?utf-8?Q?/I8qDxsaYYuWU/LcR002iGsy0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff60cf2d-7097-45c0-cda1-08dc3edb89e9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 19:19:41.3346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgQxTJit+VdqzfTvT+hMRCU/T2zLCr6Doar72w3lqpO9Nbp8V/CPFSaN2Bfj8eFFsTKzEnW2KeQCj5jNhjkfig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6992

Some sai only connect one direction dma (rx/tx) in SOC. For example:
imx8qxp sai5 only connect tx dma channel. So allow only one "rx" or "tx"
for dma-names.

Remove description under dmas because no user use index to get dma channel.
All user use 'dma-names' to get correct dma channel. dma-names already in
'required' list.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,sai.yaml | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
index 2456d958adeef..93e7737a49a7b 100644
--- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
@@ -81,15 +81,13 @@ properties:
 
   dmas:
     minItems: 1
-    items:
-      - description: DMA controller phandle and request line for RX
-      - description: DMA controller phandle and request line for TX
+    maxItems: 2
 
   dma-names:
     minItems: 1
+    maxItems: 2
     items:
-      - const: rx
-      - const: tx
+      enum: [ rx, tx ]
 
   interrupts:
     items:

-- 
2.34.1


