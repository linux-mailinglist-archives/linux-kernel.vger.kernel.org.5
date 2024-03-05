Return-Path: <linux-kernel+bounces-92772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EE38725C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA2E2861B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20D918628;
	Tue,  5 Mar 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JndEjCoX"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89D617BAF;
	Tue,  5 Mar 2024 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660017; cv=fail; b=ifoDAKbOcCT04qhglZCPaxD2IzbMKRMyvFot3KaKsMycQBDw5iAn96nRUKMa2c8iKZXOI6eijNd+1IYlUBovNmdv9+imRspORIapPEIsgbYXC+iVOQXCI8uA1zmiCivEjU7aD1oxHXiykcCg66SbdNk/gv/AFTeJI6VlvJ7mSZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660017; c=relaxed/simple;
	bh=yjXouEe9GejMOBTUStSt91sQSE1J9SrHWPb4cvvLO90=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NlHvJeLqOCh7L+omTa38gY9QVX+Hq2ntF8V7CTHavDEHBl6zdZ+uGeUF0l2VekpuDVjGcF0mw2B9Dnbd8igpbM0UvQFplNLgwNsIoC9NprtEUIzoxhF4KxZR9BJNUSem8zh1rrG+0C1Oq3dt8Du6+Ii247zBNzG3w8gp95VvsoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JndEjCoX; arc=fail smtp.client-ip=40.107.20.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NO3laGbCQ+vOckce1quAUqBAWi4oOXeE7g1V4VEHD/OkwTn1J+Gnwn7fNYlfF8HmBOsv5unFkY2if+YXIO+Bw5Q3C6KBQ7NXQOKz0D2KRZPugptm2K5ya63TszOn2lSs4QnBulgFB6DFprMTp1IeGepdnyrBE6q9JxYiwuHO+VZ2u0qAlmD2qkyjBp5AZ5M0tBDhCIULqvVNt9Psdd6lGG7AldX1cqVhKd4zH11o9mLBDG59vhkEvw2Qu1oheIXOXuhKfh690yl+Cv+vQPGjQNIHr/i/SpJPSvDbn1fCN7VXpFvjHkTCYB4/z3FMQUHqoHnKjy6bLQHEYT66YD+yIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52cZjio8ouiskuvTgFyXFyDw5dtyl3FaSq1t3asy42Y=;
 b=dMYi3RVbaMHPeZGU1z3m6hgrq3gUI2+Mv9ZvbdltQioQhBEbNpaglmjB0oDR5jmjtL+xY7JqX8I7GIGmhdlyt9MeMetN6mv2BKf2ogIjxIUg9W3gdt81PgJJxp0BDKOVrmHARh2NAR3cc8+q3weo78FBDTlQmlgbX8FwUy+p57LfgV35ENh1M+vJkjNN9CoJWewWjy7zO8D3hgYJzyGs/wnx8kw1n3xR2LmAOWo8zuImyBxzsioKQw/Njw3owaKhB7XlGJS/H6LsnjtcKD1mDkU08Gcv/0ltVGojjR3AKw5Vv6c2rjIfIdWhEM4t4mrtYdsgEL+9MsOsVREbdVF1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52cZjio8ouiskuvTgFyXFyDw5dtyl3FaSq1t3asy42Y=;
 b=JndEjCoXd4va68rnUIh6zbv2eJy5wVlWPrCXjgbf6VI7msgN+HsCq37pHmsp1K+8ABxnINsPRULBXrhZRJiqxJbLF4CV+uaS/Gi+Zkd05A6D4QDvH1kjqdd2oo16qsoEfWIvi8/qfGkuyrZ3Gx9czNwYKI1048+CpA6aSDgARTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9280.eurprd04.prod.outlook.com (2603:10a6:102:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Tue, 5 Mar
 2024 17:33:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 17:33:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 05 Mar 2024 12:33:04 -0500
Subject: [PATCH v4 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-asrc_8qxp-v4-3-c61b98046591@nxp.com>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
In-Reply-To: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709659997; l=1270;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=yjXouEe9GejMOBTUStSt91sQSE1J9SrHWPb4cvvLO90=;
 b=wOKUgAlbFL2QcLra8v27pLVY4QAf+HvqWu3QLW18Y/nitXAMlPj00qZOhzR6L11Fo96JJ5WTO
 cGCbPQurMi0DlzxsshJpmwD8uuWL2x3ushos0O5mZswDzxkHgmi+7+6
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0159.namprd05.prod.outlook.com
 (2603:10b6:a03:339::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: d41ec39f-7fd9-44fa-71c2-08dc3d3a6166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gis6bWmbwpLkvo6W8ztFARWMyDoWsINBQ3MdHg+22N2hn2YXl4mcmuuYY8TdzNvYtSrn2ZQ/fIRgZU50S/zWsna8E4wALD/KlebLku8PlAo85AcsMg2ZtfMPmTSVy+qpcETyJUGpeHbzx213/bGfpBrbOjpZtUJ71wyIRkh9H7KnoauZVlqRTNRg9jBP9g3KogLzvw5jff3zC1HTf2DBQ7k+z3gVZqpcDWRcae3qrZgQUUeh3b3ysndSMQ7+Mr8a1PeDUelZuYvOQXTssU28UCV7sN8K+75HIMjOxarKuJf9yvqUD1wITr+RNA9y7l66R+LSkcBDAY8jah+DvGX5e23QS3s5vngWMBPl4Uo0FSsVsCk2kqhzCBRuesFVVzpBqRiAqiA5IVvLaPReZSgMeiDEefZa71Nhu/nMXHlcTHpEOE4jtMXofNfDTEKO9qFiaBsqIZUJCCmLWBFPQta2czeETypEuk6PAMfO2AEl03AmLcQr2kP0vmkFpo4s8+qrU5/SAq6cS/CFxp8Z63tX3AD52gmiIOZWo3sxDi/EZQobxKTmf+4ja7KZPjrWJ/6aUjWqsHFWmPYiYiy/gsITt/hR7HGrgu5+cc9ypbTH3LlM534Ozhj3ZW2Du3Zue+14D7jnIQjF4u6DMpxX5xgxY6jMzlqGdDe7GWpjpwdXJW9BT6fEhogEbAZ03wXYTBxGx/sxHRgNtXjztWSuwmZecBAltYS9GTym6LVyTLsB/Zs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2M1UmZDVmxjeXlvc1ZKTC8xM0ZUeXdRNXZjZDE0NEk5UVdXQjMxMHhjM1FQ?=
 =?utf-8?B?eG9rbUhlNkFNQVlQZVVqVkRxRGJuSmkyQXFRRmNXSW4xN0R6cnN3UWhIZG5R?=
 =?utf-8?B?N2lidmttUnRMMTBwMkkzTUVvbmRNbEJGdmlEUVltN0w1OGpvd0xZUmIxWUJ2?=
 =?utf-8?B?NDZaNTU5Vm51RC9IK041N1BCbGFWVFRYdjhNaTVHaGVaSzl0L29kYkV2M2RF?=
 =?utf-8?B?dmt6S2oyMDRxUFZ0TkNTVEVqbCtrQ1JzRy9yaWZPN01BcnlCMjhaR205dURQ?=
 =?utf-8?B?YWVGZUVsZ1lnK0RVMFBZV3NLR1FLWmJrVDg0dmNoNkxDZlcvTlhldXJLbVV4?=
 =?utf-8?B?enAxQWIzRGhzZ3ljNU4vRTZqNW1ScFc1UGQwSGNzZTdLeXZzK0EwWC9meEtV?=
 =?utf-8?B?eHRDQkVodnBTZlB6RE4vTm00UUpvOXVtcWptUDlhWnArZm9zZks3cmVMVHY0?=
 =?utf-8?B?TkZwRnNmSzVieUJHQ1NHYi96QWtNcXdBVzdmSjdGcHVJcTNVZkNDNXJEb0lG?=
 =?utf-8?B?VnArejNrWHF1TlJ5WE03TXUvS2gwRzdmSnZVVDQ3bS9TWm4zNy9HVGdwcFZJ?=
 =?utf-8?B?ZDdDZFdYd3dQRU1LZmhmSWVEVFFDWnlkbEViWDJBVGR5YXpEVlhSeUp6YWMy?=
 =?utf-8?B?VXRheERYZGx6c2lVVzR4VUJWOFEwUEI3WUU3Qkw1ZmNJY2VjZnZJNnhKcTF1?=
 =?utf-8?B?eUJFNkI4cWZKNnBBcVRxYkJWd0lCS1picG9UTVFHRjc0bEhWY1hKV3o5WWFj?=
 =?utf-8?B?cFNuUm9IRHp0MUYyTlRqK1RHZVBQMkFHMTZyNG8xRE5WMlp4dU1QZnBmc0p4?=
 =?utf-8?B?U3hmWW5YU29XL0tkS2pJVVJWVFc3WEhoemVPQTN2L2RaYWhmV2ZyVk5ISyth?=
 =?utf-8?B?ZWFBSGlzWFloSmYwSHN1OVBRSWNYVWJlamtJUVpKb2VmaFJFNzNqUnEySUdn?=
 =?utf-8?B?VkhTMFFyWmp2OU5ZNHJSU2ZhTVZYeXNqMDFCei8wVmlRYjJ3L1BOZlI2eFRB?=
 =?utf-8?B?RHQ5YWIyMlBQMGdJU3paWFJkbUs4eEVEYXo4NEovaXppaGxIaDU3TFFuVEtM?=
 =?utf-8?B?MVBSM09zU2hOSUhlanRMQkZQd0RDMk42UUs5bEFCYUIzUU14eHhnamk1ZXhV?=
 =?utf-8?B?SmhjbDEySHhxVE9PZGpkMXhFQWt0TFNja2podmVxUmZDNTRrWFFYSVk4VGRt?=
 =?utf-8?B?TGlnMVVuMFNNNXhRVjN3NEczTGIwNm9JVjRxZzUrakFHVzZ0bnAvdnRCSmpk?=
 =?utf-8?B?QmQybEZ0UThZajJoMlBjRG1lcnE5dm1ING9TRHQwV3JXTnFMaDMzaDNDbDF5?=
 =?utf-8?B?S080YkVUZ2pYeHp4aGMyR3FYU0F1ZXRFNEhFSUFad3NYaXlnYVRmTXkyaUNK?=
 =?utf-8?B?ck1vbHNXaWxWZVRxT1lGc3c3Z0Z2aDF0S0FpZ2ZQMzhCdllvNXJyYkxtRG42?=
 =?utf-8?B?cTFKV3BmR1VPQXozTTRxWit3YzNTZ3ZIQ1cyMVM4WVBqSlNlMnYrK2pKVFVh?=
 =?utf-8?B?L0xQZ2p4aW9WK29UZXE0QUlxNEF0dHhXdFVtV3JXaGhpRW5JTkh3dDdGRVNU?=
 =?utf-8?B?NWZzcUM5ZDA2RzFsd2xRaThMd0dNWnV3MjVFdG5rbEdaTmxmWWRxaVR2SGor?=
 =?utf-8?B?Z012cmp4dkRYSEhWSWg4NUdyTStBU3orWmczb0JlUXVlQUdOQXpUUVEzcXU0?=
 =?utf-8?B?RTNkMnRwbldKN1RPQ1oyRzgyang1c1A3RHYrVzJIb09FVjQ1WHF0bUt2eXJz?=
 =?utf-8?B?ZHlXdTlEc1VzQW5ob0hnOHUxcGNWbW9HdHkvK2JvNWdvazVjK2YycFVPL3ZV?=
 =?utf-8?B?RlRSQzIvVWFhaHdSdUJ2YWpxcUlsOFVadjNuVU1NL2dSdE9Db0ZJcFBWK2NM?=
 =?utf-8?B?S1dtZXM0Q3YxZ2hDUFQyWFYyOXorc2t6dkFKWHhaaTNTY1J0cFZkN2pZVkU5?=
 =?utf-8?B?RHZkek1BY1VWcmlKaDZoSXRwV2VaS2VmRVV1M1Rqc3NZRGY4TmdIMTE4SmVP?=
 =?utf-8?B?c0xUU3RwTnlrQ3RtbXR5a0lqVS9jVjlCb2VaMnZBUlR5S2UwaFdSeGR4aUxq?=
 =?utf-8?B?cUowK1A2eTBHZnNsSHBGNDBVcVNLQ0ord0VFVnpLMmV5SEtZZmY0YzFKbDJ4?=
 =?utf-8?Q?1hC7mb1AOQrcI+ljSWP8VCRuu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41ec39f-7fd9-44fa-71c2-08dc3d3a6166
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 17:33:33.2114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LS5F1LpA7EPwNGWM0A7Ty/CpGfl+ZclW8NBk239Z8Sf2/yMHIK6MsFtKSVoKBpZUE/zJxCIoYRyjSkKHlssL+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9280

Some sai only connect one direction dma (rx/tx) in SOC. For example:
imx8qxp sai5 only connect tx dma channel. So allow only one "rx" or "tx"
for dma-names.

Remove description under dmas because no user use index to get dma channel.
All user use 'dma-names' to get correct dma channel. dma-names already in
'required' list.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,sai.yaml | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
index 2456d958adeef..6f551c68d33db 100644
--- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
@@ -81,15 +81,14 @@ properties:
 
   dmas:
     minItems: 1
-    items:
-      - description: DMA controller phandle and request line for RX
-      - description: DMA controller phandle and request line for TX
+    maxItems: 2
 
   dma-names:
-    minItems: 1
-    items:
-      - const: rx
-      - const: tx
+    oneOf:
+      - items:
+          - const: rx
+          - const: tx
+      - enum: [ rx, tx ]
 
   interrupts:
     items:

-- 
2.34.1


