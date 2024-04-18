Return-Path: <linux-kernel+bounces-150500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67388AA034
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065EA1C21B88
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDCE16F91E;
	Thu, 18 Apr 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qiwCk3jZ"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2072.outbound.protection.outlook.com [40.107.104.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB7316C846;
	Thu, 18 Apr 2024 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458218; cv=fail; b=o2pBGMuH3DOz1uhwfBF9Th7jw+yXSD9xIZRwyo7hcdlDh17Zc2/TSF5K8USIB2D3v46YtYRIsmuqqn14I1vs4rk/wOCpZydZG8Xy3GTaki/HPe4eVwWXYyJuK4RF5r93jQUKkht3sqToIOABaAFCLuWmI0H3z2bM+oQOlq+f9XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458218; c=relaxed/simple;
	bh=S+C+Gr6Cw9jG56egAoCCX9DeL8a7SLxaztMFWnlRG/Y=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=FnsN8nlv0DuDsuVCC/wyGOpG0sh9lSPVpTKOo9MWnoagpey+SmvCb6rKGKxz+IBTdJDFt6Pn1oYsjPlrmAUNnmmmVSc2mRua0ecjYMp+FQE3IWnCfMmAKIGok1vnMJ68JcT/lGbWQMOHwagZQPEP8ZD3ikvW5HojiunWLtaJYjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qiwCk3jZ; arc=fail smtp.client-ip=40.107.104.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awp8EuOz3oY9Cy/7Z5ll7Uw1roIbuTos7hI5InFuwJenGBSZdXv4qZqRyRJ2BIOeGxPvEe6vXP5QUqDErzQl+1fke1n8hOc19MqMbum/teOtcnTngoAuc43Nw/rabvxiWdI203+UR+dYK9a4sJ0fOusSeJoK1RowsN1l2wPzrXglcCztnvmkcZ2V7xxsO6LeeBYzPcIN4aRQe5cAvEaEKWaiRa53hOrM91tXDto8z5kdPTHBgDj7EdPE4wp5nNNP3UjF57jgERs0/ck2wG1Y262EQIQ+0o2mkUtZtIBRKqMXhbqKiZFe4WMq8yvZmUrro4CWD672yvvmL7FWilS5VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oERV9gSqAuzRKiPK3VdBeFxNugJfX7y7RH6H4wtErqc=;
 b=Yzo0CpiQgBpBCG/rGdmWE6Su9dYDK/7i3lUNuyOxShvsW5+HjqbZxPCr1iUiyZRtLQ9vlNBaQ0Etf7zUZgwqvOuWYXZwLpG7/NzH03ZUSf+4YCWKPW6QMsdF/A1aUY3fgrbBKq7Uqk1bQtSQl/n3utfogL3HEXponoR/PTD4NG+zxLzsG0FsOo7gPYlLcgI14Im4Kif41L0OUU2ghADpXHqIJA3eNt4JCDjL1wLNsfOCQpBxV3opz9Y4r+x1z5sHQmqWtOd6XB5CVMA3JcbuUr/P+qk+AFyZWB97Dmp9dbBFcJLgBCmE8o0AOw2AnD7+dykdktLn0S0ivTB4S0XNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oERV9gSqAuzRKiPK3VdBeFxNugJfX7y7RH6H4wtErqc=;
 b=qiwCk3jZsb2NCCRJJNC5V590DqNzzwwtW4KuF5JROmSAIabNw4nYX/M0PY/JgDs0uMcDByC7RZRsKalPBolX5/BR+BEZYiXViiNZlKFusHPb8Hn53Ay82fBJfb4InH6BHP3EAdiuxo1Gp7G6qZi/FvSIJxt9P58JSfPMMK+7owo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7079.eurprd04.prod.outlook.com (2603:10a6:20b:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 16:36:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:36:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 00/10] arm64: dts: imx8qm Add audio\flexcan\i2c\fec1
 nodes for imx8qm-mek board
Date: Thu, 18 Apr 2024 12:36:35 -0400
Message-Id: <20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABNMIWYC/13MQQ6CMBCF4auQWVvTVgrWlfcwhGA7yCxosUWCI
 b27lbhy+b/kfRtEDIQRLsUGAReK5F0OeSjADJ17ICObGySXJS+5ZHaO7fk5tt3LkmcoUFS6Nvr
 eV5A/U8Ce1t27NbkHirMP751fxHf9SUL9SYtgnEldV+akOm6UvLp1Oho/QpNS+gAVQDzHqAAAA
 A==
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713458209; l=2308;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=S+C+Gr6Cw9jG56egAoCCX9DeL8a7SLxaztMFWnlRG/Y=;
 b=p89U1Eoq37M86+O/XyYyhCHGKEN1Bl7Utx+Avv+fG9RvSF/tReLvB0LLvAN0Mg41Zl+pqDifr
 1NQZnc/FOIaB1lTx4UYiFkP5iNjEGwDXEJAeD/adbfWINInO5wV9qvi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d5241a-4e89-4271-84c8-08dc5fc5c0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TTeBIN6aoKP6xiK/HTJ/aMYPGOBr4Z4Fw29uwmF0Yjoti0NHsaOmReqq8GioRKGUKdLOWq/7CiOlAAylpTUcplv1gXLR1EtVbfXMzxXwfZHU4+L9Zuq2GtfgAD1RB6qnpbNJxWxkN9HK0nGg4YSgy6TA+GiZYGA8dqMndQwIdk/FP8fiILrfvmv5TqN/jLLmF7GzbZl4pEQgjJ9OnQq8xHbs0YKXAAofOLOJSgywMOek2+5RVhuDkI0h3bGGfztbSJmEzeE2ovvONP+JOKqT1afZ9MtjRnFFSWih8j5mR2nD86tV89YGxdGYx5k+skaT4WlaKmukk01cAiEBDNnzLA/n0Yh8o2wCXBNlwfIYmLm0E9TJVgUlvZP5ceAadXyspfAuArjtPaHJb65uHb/ZsxCtFDV8uuiguQTFqRd2Ag+Ue8rU1ZIm7JI/prlwMjhOLE6dDyQWm9xtr4f1RMXBl8FCxT8VC4wqil/ipkBBObAw3YO7rRccWrJbx19cYdMQteLjvhq49IRhT1W26MstF1lOebw7J0VKl99gJx38L4oheWGLEwtUJpP//y1LonvnBQ0qjy2IDKEmiyw0kOm/HBcLSXEfyml/rB/KWpU3dIj0iX/B3xve+QrbZekEwHR/nFlxS7BEr0jKifiQBVhy+GD3j51bHzS4QiQ/PObTwdt5OWPtJqWTqe9kFavZlY4LxLPSbq6wDHHGiDe18LSwruqLVfthYoFBgKfGtGo6VKk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzBQcmE1WU1MeG5mcTlENXBlRkRKNlJLQlB1Z2J5TVdIS1R4cldCVmJLaUx3?=
 =?utf-8?B?RWN4UndtTEFCaFJxMXNRbC9mcjNOV0dsaVNTSWpmTE9nb2dPM0h1Q3NjZHpt?=
 =?utf-8?B?NWpObUIzRTRDY3hQdkpXNWY0VkFrYmZrVEFpejVZb3JaOUxwTWpJSzJIQVVK?=
 =?utf-8?B?Ti9uYzZyQVU1OHZjMjFJQXBSdlgyd2NRZ1VwT3pTeXR4VTRTNkVHWHhtUmtT?=
 =?utf-8?B?WmdLL1VLbFoxMEpZSTJPekN2VjROL0R5Q1V4eHFvakZGWGJSWEg2Z0V3TEFJ?=
 =?utf-8?B?LzRXME9HNUdOUTFaek81SGNucm1ZWWplRWd0M2hDSTNKY2JyUFJmc013eElt?=
 =?utf-8?B?U3hMRTQyYnB1a1dxWG5EZm1XbEZ4bjVGYlQrSFBxOUhzSm1OL3padS8wMHJV?=
 =?utf-8?B?RnQ1ZDcvSTNZT0dZeSs2eStWdFY1TUFzcTNoV2pKNW1VbWJxVjBTd1ZmSWdF?=
 =?utf-8?B?Ky9WTGdKUDlBWFVMMlBPVFhUb3I3azRZRFF4emJuQ2pJbHlHcDdYeGVXYVZt?=
 =?utf-8?B?K281ZVMyM1ZRaWZSSm90QWNySTZJRUdnYUpzVm83OFp0eGxGYWVMSWp0dllk?=
 =?utf-8?B?VUs2UXk4MkZDa1pOOEpYd0srNk8xb2JqS3o5NFlWNXJ4eWlVRDR2VUdkd081?=
 =?utf-8?B?UmNnTVYrcG9BRVNaY3FwYXRIRk1YTVhVeFNkV0QrZGd1UlZKWU54R1p2M0Nu?=
 =?utf-8?B?VC9hSWZybDRNRHVsMHl3K0U5VlJDdXRYK0V3YWIwTjlHOVhPd01Cek9ncU4r?=
 =?utf-8?B?YUVpSXNGNnptdE1uTm52dXhEalJIZCtTdHhQMWVSTlBOWmhuMWxiUzFDNUR0?=
 =?utf-8?B?azJ4L1ozdmRkQ2JOQjFrOHI3MUx0eWd6REYreWxnaE5aY1N1UTd6NTZSVnpn?=
 =?utf-8?B?SDgvL1dPbktieEVQOGVPWkd0OFhKZEVtNjBWMUpzWnFwb01INko1dXJKY0Rs?=
 =?utf-8?B?MUVCcGxvQWpRdGZmS0RDcktObTlZNzBVcXFmaHpuR0RGTUtZcjZlcUFMd3hp?=
 =?utf-8?B?cE9zc0d2cFNIUVlOM0E3K0JXT21PSFNjUlFsOW5SYmhWdVlvbjVDVkQ1bkZI?=
 =?utf-8?B?YVQ5YVYybUFBSlJCcStyWlg4enRDanF5UHFYbHVKbHZ5VmdUSk1iUmt0dXJS?=
 =?utf-8?B?NWRqSjU3WVBQcUV2eFBwRE5rV2JuUXQ1bGxIcHpZbWVMelFVZURkV3FXN0JM?=
 =?utf-8?B?SU5yOWNSaHZ6Ry9MQ0FvSERLNVYvTlVSaDc4ZFo5bHdDVnFtTG9kMHZCK2w5?=
 =?utf-8?B?SGtjNDJkK0Q2QW5MTWIyME1sY2YzeXpRTEt0c1V6QmlsMUpRZmlMUFJpM1Mw?=
 =?utf-8?B?Q0w1KzJsZExCaG1kcU9kMmhoM2l2bkx5OEJJTjF2OGhBQ1JmKytZRWM1V3NR?=
 =?utf-8?B?MStuUEhJdzR0NHpmcVYvVk9VdmJTeGUwUHhDLzdIdU9xWFlMSmVobytTQ0kw?=
 =?utf-8?B?UUVON0N2R2NqRHduOWluM0NpWi93YnhlRHJ4UXphd1VYajRKVElvM1FNSDc0?=
 =?utf-8?B?NnZjbEp0VXcyWng0ZkV5RGRQZGNIRVBMWWs1amd6ZXRMVVF1TDlqeFM4S3NR?=
 =?utf-8?B?enkzMk9sQ1NOeDFreTdOTXNMbGxvUXF5NnNQZmZjdTVUWHUzeWJqLzBqVnpP?=
 =?utf-8?B?NURqTUFJZ25qdTNtYXB5bHgxNTJrcGVBSXlRb3kralJHYWFLZHRUcWpFM2sw?=
 =?utf-8?B?NVd2bFkrblBlK3NQR0VRQ1dSL2hNV2l2T3hNdkNqWG9VdU56U2wwWnMzZHVr?=
 =?utf-8?B?U2I0L0NHMWd6UkpJYnMwdDlnL0JIQWtwVWJTT1VjYjU1UUNRNExrUFRwMXo4?=
 =?utf-8?B?TUFqRGQ3VkxCekdMTE9tRkZsdGJsODBibUFmeCs4Y3RVek9SemkwY3o3YTNt?=
 =?utf-8?B?ZGY3VERrTDB3WkVGR1g0YUV4QWR4bGsza1pGcDRsNzFxVjREQnhSWHVaZC9S?=
 =?utf-8?B?Qktkd0g2eDdYVmVGREI2VmpaYmpNb3BYcGFQNVY2VVBDMy9ZNG5rK21uSHhj?=
 =?utf-8?B?NjB4M3Fmcm5yOWdXd0pVV0Fka3cza0lHWGYyaUxtUEdIekM0RHpMVlVqK1Fz?=
 =?utf-8?B?Qmo2NVMveWRvd3VSTjM1Y1YrKyt2a1FVYnd2TDl0RnhGa3ZMbGFFbStsY2pl?=
 =?utf-8?Q?Ut2M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d5241a-4e89-4271-84c8-08dc5fc5c0bd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:36:52.8558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoXIgZkRFTyLIqYHmfx5FUTSsNj8U+Kvs94mmYo22RchyLhuqnT67IF5LRl67rYDJdCeVu9VhsvZlLHlwgfVjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7079

No new warning added by 
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  CHECK_DTBS=y freescale/imx8qm-mek.dtb

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- move vendor property to last, just before status
- use audio-codec@1a as node name
- about dual license problem, need relicense whole included tree's dts file
which out scope this patch
- About delete-node

imx8qm-ss-audio.dtsi are not supposed to be included directly. imx8qm.dtsi
is supposed to be included by other board dts file.

in imx8qm.dtsi

 	/* sorted in register address */
+	#include "imx8-ss-audio.dtsi"
 	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
@@ -473,3 +558,4 @@ drc_crit0: trip1 {
 #include "imx8qm-ss-dma.dtsi"
 #include "imx8qm-ss-conn.dtsi"
 #include "imx8qm-ss-lsio.dtsi"
+#include "imx8qm-ss-audio.dtsi"

"imx8qm-ss-audio" will overwrite some common audio node in
"imx8-ss-audio.dtsi"

acm, and sai4/5 are defined in imx8-ss-audio.dtsi for common part for all
imx8qm\imx8qxp\imx8dxl.

- Link to v1: https://lore.kernel.org/r/20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com

---
Frank Li (10):
      arm64: dts: imx8-ss-audio: remove memory-region = <&dsp_reserved>;
      arm64: dts: imx8qm-ss-audio: add audio nodes
      arm64: dts: imx8qm-mek: add sai and wm8960 support
      arm64: dts: imx8x: add cm41 subsystem dtsi
      arm64: dts: imx8qm-mek: add i2c0 and children devices
      arm64: dts: imx8qm-mek: add cm41_i2c and children devices
      arm64: dts: imx8qm-mek: add flexcan support
      arm64: dts: imx8qm-mek: add lsio mu5 and mu6
      arm64: dts: imx8qm: add ocopt and fec_mac[0,1]
      arm64: dts: imx8qm-mek: add fec2 support

 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi   |   1 -
 arch/arm64/boot/dts/freescale/imx8-ss-cm41.dtsi    |  68 +++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts       | 345 +++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi | 473 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi          | 102 +++++
 5 files changed, 988 insertions(+), 1 deletion(-)
---
base-commit: eda9714fe6d9e6e5690992ce7dd42b13a5be7803
change-id: 20240402-dts_8qm_audio-e1e1697c9bf6

Best regards,
---
Frank Li <Frank.Li@nxp.com>


