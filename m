Return-Path: <linux-kernel+bounces-132316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5FC8992E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC4A286688
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E5A125C1;
	Fri,  5 Apr 2024 01:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bUd7P619"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2095.outbound.protection.outlook.com [40.107.247.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBFBC13D;
	Fri,  5 Apr 2024 01:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712281899; cv=fail; b=BhinxiNIfHT8ndESTBSu8/MLSFlHK6WV4D9mT5hU2QmImE7QtQroZcr+HS1Uy6aMqOvZvZOGMVIhWJnpP2dFDjuaKyOavmlgEKpmjyykJw8SLlQ6BzR57uHpfK7MaafqRtjgVw7nu8kU7UCZubqjY92Ru3k7Ay+ns+3aUhWehSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712281899; c=relaxed/simple;
	bh=t5HLy5gFexuRUd/gcXkLur0tNUBqrWNFLScENOV0ZWY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NBGc727nAM7UvWfYYX5nmQU30oVAIc0D89k7K5ycfsB73XDQCTM7iq5GJeH5CS0cchkNc365akHfPXD5ByZYfyNmXrLqzPmxXx3JBD7edH4B/uvAv5I0pK2iwsj0QKWM1x3GLsnsQbgLgP3II2+yzZEVNtGP1twuetNmYRJedkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bUd7P619; arc=fail smtp.client-ip=40.107.247.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3KKLuBU/RaM3j1zf9hUhmTnMcx8+fTiOr7CJv17Aj+SbG1Cu4XmhUKCBCwi9VNDCMneLPjZZPHHoSEFBthrMncClJuPJXxoEBaYriw8yv5lj580uZYDCXPIyUOHBM6Tdg3kiybBeEFrznFsSpblqmpFSoIVSCU7U9itBsHmeBjSJCBN77E08+OcMPjFcE3bPTomjN1HIdPHN5lgVS5UIvpmmpp1joro7PnwjawdTkedGlAi47nJtXLzKf+GKmoCIdnMpfEMfPB4CzJlqro9JDiLMOcmhYxAOpnvWkQJO8zVxKQ2JWDKR+ZIOWny1FsXWl7Utk8lyyhl9BdFGBpLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkhFzy347CReKh8Y/3De5x5m9e7u839I/9k6SdaIf8U=;
 b=WmN3efy4xMIp/fUeGsA5R+g+i9NLUl3pXL3Zchy6s7WEFNc5y86I1IAxm2xWHH8VxQBvqaKNtjss+t46HSCL4w/EebHzCXds0F9j+Fmrfjl/jNR6QpmKwRqdghAISpDJ7HRFDi9+wXtAkGxXRif+4WP7TrZvw9C0WE66QHRLpVfp87G8a5Q6P8OrJQf16pNACUlD7AhRAZu0C3fAOBJi6dvSgEmaoEV9cpWW7IHiWcvvDpVGIe9bjL1UYHjF9MQ77tZG/KDrZk4hcjZcA8YTnE8WQLXxUR0BI8039oA0aUHn+LREgWFmMuvbq8b9qKpGBkjJ1qTzDgqut/7bWPE3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkhFzy347CReKh8Y/3De5x5m9e7u839I/9k6SdaIf8U=;
 b=bUd7P619XWnp3H7OB77VkVB8OjiOKtLehRwdwc7i7ObBojlmSrOn8fD4HC7nF+r7v3Li6Fo9F0JGYKulTHZOP7635PBPUu3X1fOt9sKeoc2jEPHd1uobkiZQPz0nN3ckPOicv2zJ+KWtilliMIezd33QiWN4Nn1VdajDVTZrmGA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9334.eurprd04.prod.outlook.com (2603:10a6:20b:4de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 01:51:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 5 Apr 2024
 01:51:34 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 05 Apr 2024 09:59:32 +0800
Subject: [PATCH v8 1/4] firmware: arm_scmi: introduce helper
 get_max_msg_size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-pinctrl-scmi-v8-1-5fc8e33871bf@nxp.com>
References: <20240405-pinctrl-scmi-v8-0-5fc8e33871bf@nxp.com>
In-Reply-To: <20240405-pinctrl-scmi-v8-0-5fc8e33871bf@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712282385; l=2653;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=dKDsMHnM+cuvfvX6K6tAU3ADCasBJe+OHaz6qBQ1Tuc=;
 b=OKFZQg9iNV1rPeKGiN9dUt7Lvl/bm1h4ZwOVkECy3ViF7GlUxLssVqnSRyB0Yha8FHSCNp3PX
 7aAXJzxNv0yB+24h16cq7oABrZSWw+2KTCYLGeC9R/8NXU8yEFeo0fW
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS1PR04MB9334:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g9dfYGQpdcCOKQ8McC+8G15rjDNZ4jlFM9AOLx658oZd7XHdHopuO+jT3i+32LZww+7fdPw8me6KVOAf0gHM4549P+b/YtoHg/LfQOXozSUGugidZ1+uvi5hoJSP+4oz2x8zMYDSAexJ5QnhfbrVX7CEj1WfKToV3CzG5pL51dt7xk9khbN/vJHUoH7fAF0mpmGe8nuzSZ/W3ILvY04GZKdTuVauuBFGiNPISEbENVSd7pYfAnyg12hisPlxO4UJtbrnTxgTW0jg+JF3Tqz+2/zNfgGdeknhXvG1DCaj/DHqPY7QQx13BnsjHQSuFYmh6clDv+C5FOPur6HqdrTva/Yg1WaF+27U6K6mqNkfp5OiPOFynpY9vhn8yv/hfvrHHsumKzqYw0SnryzFLMTYXmOaI1M+Fgc7IMNiqSLjAV3HNeaMbQ+5o4TgfGL0x8ZFmYM/Kgy0Eh2PpKfbsId9p0xLcQKnssiN6hXV2VE54wpuhjhrHUjCrzh34sC/6w6q9DsK6t5XKbh03jWVDIZNjxfwbStIazuxHekfYQxs6rGShZUQdqsuNbwOIiIBZxTQjYivaHJV8YvwxJJYy+5ygfaTX4XKyzTSvOUqIzT36jCWDf6X15T2vI5iWYMYtvf9eKUXKw0BWERo/eNHGE+CypqtARB1p8cgBc1eaUXdW4khSJqip9KpO/YbbuOwlFtbvmo18J0IfZ0ZAKsOadsUxWrAiQGuYG/Cc99wfC+Q1B8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUFtV01IZTRhRjJmNTBDTEhKcTJKbmFmUmp0YVg4d0JxRTNKK1B1ZHRXRlI1?=
 =?utf-8?B?VTN4RWxXVy9yR2FEZDBISFJvR1RGZWZKaFdDTGJ3QjMwalBXeDM0K1pXUmpi?=
 =?utf-8?B?N0ZKUGMwdUs3YjlCYUdiUUh5ZHhKTUEyUWdYOXRHNndSQlUyUmVBUjl2QnVI?=
 =?utf-8?B?SUJsL0NKWm5jU281czk3aTJqV3JhWHN6N3kyYW1vZG42SlFqVXEwSTFuL0tG?=
 =?utf-8?B?VXZaOGVOTTZMVTh2YkxydEJFNEVYd1hCQVRGRWtpckl4dzhaUFZXMjlBMlBw?=
 =?utf-8?B?TUNKS0pEZzF3amprUk9rTWhCM3BtSVptTktjWktuSlRyV2VHelZxVTN0ZFpU?=
 =?utf-8?B?NGxtR1JBSVlndFN5ajhicGthaTE2NmYyUDhYVStESzFNZXY2dWZqajVkVVJn?=
 =?utf-8?B?ZzlBRU0yQW1sc3Zyc3pMdjNHTkFQeW1YYmcyaFR1SGZlTTI2eFZDYkgzWUZi?=
 =?utf-8?B?Y05aN1MvcExMVXVtakVwWFdmS01xYklJd0JJMzJER2ZacUpVQmYvTTZVWnpF?=
 =?utf-8?B?RytrNU5peDlsRkl6TFFNOCtrSHdrNjJDbjBsZjRISU91NCtkeTNRbk5md0hh?=
 =?utf-8?B?N01oWUI4T3ZpelM1WklKajRMOXQrZ21uWWczSUdQV2t3Zm9nUTI4WGdVWlRv?=
 =?utf-8?B?U1ptcUx2VGY5VURYQkJIb2pOUnUzMHhEdm9kK0M2Rm4zTngzMFNCM284dHRE?=
 =?utf-8?B?aWlneUNsa1Q3SmwvMzRnVXNvU0cycHBXS29tV2wzMDNOV0pSakZkanlyd0FX?=
 =?utf-8?B?SWt0RkRrYjgzL3NXYm81cjVneGNSQU9sWVNDMUt2V1BodVNLbVJCSWJaV3Ji?=
 =?utf-8?B?Z25mcGNleDZhU2trM2w3djZtajdRNDRqN25tbVhON3d5RFZXWG96UURNOHYw?=
 =?utf-8?B?M2VkMXgrYUhHZDE1cGhQNXU3OFVwTXhKaXUybFlvWTVFTVdUT1B0YkRNZS9a?=
 =?utf-8?B?TWwzNHBUWUFFUVl0cGpLR2FrckllRlgycGpkc3AwamlXNHQzVVpKcFI1L3Bw?=
 =?utf-8?B?L0FjUHhva2N2Q3hUSVJWeUVHQUlCMVgyRDJGeTVKWkYzWlE2dTQraWNyNlpW?=
 =?utf-8?B?RGVzVytvMmFvclVmTDg3Zk13Tk9vYVpqN0hWRzFRSXRwN2h1bzVsQW9KOTFR?=
 =?utf-8?B?WHBaMm93NURTK2cwM1Y5ZVhBeDNSdlJGY1hhaTNtQXA3bjZLUnR3ZUNVS3JN?=
 =?utf-8?B?cjF5ZmpOMG5rQVgyVU0weHhXR3dGN1V2TjYybGVCeHltUFc1Q2lHQ2plQ0ZD?=
 =?utf-8?B?RlY1UElnTlBJVFFjcTR1RXRzVndyS1k0KzIxeGdJVjJHWTVaWnBBR1hyNlht?=
 =?utf-8?B?MlFlQnBSM0JGRVBmWi85b1hOWnVsc0ZzWU5HeXJ2SmwvZU0rRE52MkRkRDEw?=
 =?utf-8?B?R2h3SkNoRWtkYXVxdFR4a3VMQXVvYitOMUxJRGs2UEo3YTRlVEdOZ0E4d1M2?=
 =?utf-8?B?eGhuN0t5d0dmbzZFUWlSUFFwaElCL2hkaTlyM25ldEVZZE91b05NSHpCblIz?=
 =?utf-8?B?S2pOUm1YMHl0b1FtdUdjME50TEtURU1DZmJ0cERqZy83M2JRVlplc1JkWG1z?=
 =?utf-8?B?ZFBFUUJhbEZkM0RDZ1J6ak1ETS9oMGhBSW5NR3pQQmM1N2VBeUhhU2xnc015?=
 =?utf-8?B?MktQMlZsUVFMMm5jVkg5Ym1lYlRqV25KR2V1ekdEelhncTR6NWV3VHBTZzNo?=
 =?utf-8?B?bVRPN3pMV2g1cStTMnpaeW56a3dGekxRR0JTckNnN2Y0OWFvckVYT3dlQVJp?=
 =?utf-8?B?TGMxc2VnU1A2bmszRXNSelJzR2RNTm8zb0pwT2JDWS9zb2ZJb2xNaG01bis3?=
 =?utf-8?B?aWZiQkl1Y1FIU3M1ZGV4c3ZCTVR3aVBnNzJ0c3Byb1gwaWpLUk5tNEZOa1k0?=
 =?utf-8?B?UW1GUFhqQVVvbUV5ek5iOGN2eHJzRExwQmlCOVVHRDBYVkY0UG5SVnNwNzBt?=
 =?utf-8?B?aXlFQ0tvWm5zeGhlcjdwZUsvN3BEb2trSm85TnFPV3RiNnBldFNTbWN0R0s3?=
 =?utf-8?B?RTRvWVVkZDRDZTRFQU9PZ3NTV3ZJdXdiZ1NLTktRc3EzTjkwT2owQ200SUNk?=
 =?utf-8?B?TjJQcHZIWDRGS0Q1TWpveXBid0g1MFcvNlNpdG9aSXF2Z055Ylo5bTNDN01W?=
 =?utf-8?Q?brHAqQumnW+JOqzBhz2dIcApz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b766d00-8ad2-49cf-80e7-08dc5512ec3b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 01:51:34.2107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lANtDZAk84Tkv0d9S2t+ox0JJHJbEHIoQ3+D1/HwqKlUj+o7/1s1RKyF7O+4Cr8AJXA3gxUAWS7zDtFJ7YK9pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9334

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


