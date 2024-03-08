Return-Path: <linux-kernel+bounces-97239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D25B87676B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303871C2163B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708C8249F5;
	Fri,  8 Mar 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L3FKXNfy"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2089.outbound.protection.outlook.com [40.107.13.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841881EEF8;
	Fri,  8 Mar 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911878; cv=fail; b=ncV0WMQfGhX3pLaKLTdOPsWpY9LPVuegdtKghdE3uZQ2UG6ViJWkfdssDIj8PW3qfFYxTfyEv4880iA+dSrK2MjMHAplsranbnIyCzHqPrAFwujj4LUbsLN14BJ9s5HFSEa49nGbIZs+263pZHJvRwG76541JmjaqCahhs2d6YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911878; c=relaxed/simple;
	bh=1syz/aUeJNCMRuMdqZfLAmwttcSh8oLFScKSrTznruE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZUPey3RzgEM2PWV3yWwwd4+4HhB4XeOXj4A8vIWmpm5h9YEre3koNyJ/HJ8367z8BLMF36UGxTmGiKhm+08LYFQoX0q+k5WYqKd3bI0/dFE/d2d8JlWsgJCOJ9c1P2HWVplrVMtodX5vybaWH8w4Hke2LgAa3O+2e++xmADlR5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=L3FKXNfy; arc=fail smtp.client-ip=40.107.13.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neNRnHjg/4a4TLZbdyOd7LrZl5bO2CxwJLtSqUSnQCuo0999kkxQ1FGmXLbfuCCoixsur79pbr34U37auIksQpk9F9TF45w492lFoDe/5xNYkNTDRelknlyRTwX2voN1crnM4/IVkOhnFlzvEg0+On7byrhnA3otxZXcTNRh/Ep9gff/UJ0YCIhn+KMHqomBNRR306BxTw2LOPNcl/aRfphJmjaStcKeTp0zkAqqgJNv6CXqM5QCeAdJ0qJlsJYw+RDxk0/pe6kgHCizdziCq8Xds9jBHu+WiFgU0TmZqPaEhyJsPkVDzQkTitIStxbL2TJ6+m+3IMyyX+Sgc4n4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+87M1nJCCt3nFThf9vTFK1j4y9JjuhQ/XCHl3Fycsc=;
 b=fjFw6dOSWQ250O7p2F/FbDCVD7qupQGbTbmBMdpCBhh7p6JlBQh4z2xHEJJ/F/TJlxhiV5AK//uu41W8fK8XYpRJmQeSZVZRMeDLYpRl1aY938W+5iDy7bgKBwLM/2/oARcdlkdV6kVyiN+cYxeAQpUAq2XF/XHwAwdBjlavQ7omErWqCRe0M8Oo2l8i4Vb9D/Jd8LEkf7pinuApSisu9WmWGgi0orOp1S+6n8521TcAq4PU41khQ/jHY3/NUiveHj7Cbe9I/HnumcJQhrqVwLUcoluoRoAgQ1Qa3Sk1szkkqnv7kAvDIYU/v3cD8L4sjNCxnXAAMFMbV8UjDPN0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+87M1nJCCt3nFThf9vTFK1j4y9JjuhQ/XCHl3Fycsc=;
 b=L3FKXNfyc3blx+orlCyKRhQ1vOykZRyUoTLE6F0jek8E3C7+vnZ/M8qCtjR2w6GMj8xCkO8oF1Vug9QKc1keOofnFizD7z/9xvACQsnA3wMSJVSJ1UPPqhi9xmyUfRXvzJttjwgDIrPqQ0xQJCASIujeAo+ai0rU7KhNZ9Ny5CU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8116.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 15:31:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 15:31:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 08 Mar 2024 10:30:50 -0500
Subject: [PATCH v6 1/4] ASoC: dt-bindings: fsl,imx-asrc/spdif: Add
 power-domains property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-asrc_8qxp-v6-1-e08f6d030e09@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709911866; l=2330;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1syz/aUeJNCMRuMdqZfLAmwttcSh8oLFScKSrTznruE=;
 b=4Gdozk6s812gUZ7B9+kOzH7asdjjzQc15SPHqAwXofsXpYSLxyUIATldM5WvxGxKcsLh533v0
 X/iUSB8EagiD5MogbS/6oBQc2Sa+7KRImPTtLFQGB1PyvZCI8AXhVcf
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
X-MS-Office365-Filtering-Correlation-Id: 34dea3be-65a7-49fa-ee57-08dc3f84cab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	50scybt/cjZ+tCVVWuvgyOhZF4OFzjFd0kzG6XTyMBhlvmB74XFQFSvEqtqBrK45cQipx2IL8N+AA6/KbgnCYsKjM+zOTrIpSGmkVGXApnWnY/BJ3ZzK4+9O4MLwn9yym1tWara6ye3Nj0rDDvvViecolhUwGVo6I8Xm81XY6GLvxqGVO6Kh6qpzQdq3LWO9HGquTp0cR7QNd2T2aQfWDeFyQDaeInMfI2gn4FMJLNBTX5QXy2a1Rt3txzYFiyG7j6Nx5964DYedLoPMTo8LDCx7e8fWsBf4tpIlF7PtCUo6zq/pyuPlVB/++m6+1B45YwyzcLjYTJNhVSH5747eKq80ZmrqB4fDykSPsh0dXJxkEQCM62h9Xw+VgcntyhjvRXMA23fdf6y2PwxZPwUC7BEdIrLi1FoGtSGj23yiHUkWFHQ6ui8sOcmisdahNuOp7nLY8Vwx0M8Ifzd0nnKFNYAQ9ZWziAQMWMEzmLhsZDMEH/DuUijmYgC6WrfRG8Bptf6llzR5qiINqAJbysvFjgp3h+6hCV64LLw7rkJUbrkXD8napROsai1/XviQ6GTPy6JBe5I76sz/RFB5hBS2BPHwVYky8hlTlCotsDeTzqwq2z4/wdZG2xs+Gch2ffZUPIx/lz4013oqoKDQa1UHRP//4XZpYQHQhTRuvVnlpxRJXSqwUo868JewpZCOtuDk/x8bLSw6wrpVSCEXOYBK0AyFeTFDDtLQllLXJkOsmr4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjkwQnBzWTJCandSOEt4Um1pY04wVUpIeUtFRDg4WDBlcTdsbHV1b1BEcnNz?=
 =?utf-8?B?VXhENW02ZGdkSUV6NXAvcFVxMDBGbzhpQjBwaExFK1dpL2RWOGRlTldLS3dE?=
 =?utf-8?B?T040czk2ZGI5ZVdWeWEwNkxRRnZyOG9HMHFVSHptNDlxUlZTSGw1R2V0amRC?=
 =?utf-8?B?R25ldVpRTEUyL3NsWU9wV3BWWGhMb0FpWFkvWHlUdGIyOEduTkQ5SEQ0N3k4?=
 =?utf-8?B?QmRISjY0bmtFSGlaOHZyYndnbnVtQ3dCRVVnVTF2RUpnVkV1dDFNY0hBYjQv?=
 =?utf-8?B?c0I1empTWS8yMWxjWkxpb3NQdW1IMGFIS25JMnJJWkJ3ZWVxc2RJVFlEMGky?=
 =?utf-8?B?NlBlQzBCU2c4c1RBQmk5dDV1RStOM1orSm9DTE9UcWl1WjBZVUJaZFluQW0y?=
 =?utf-8?B?R2pwMzExWUp5Vkd4NEdhMFd0NlBIVnIyWThsY3hrT1NEdk1xeVVVS1NsUGJR?=
 =?utf-8?B?UlF3VDdFcCswQ1FqVHJjMHQ4a0RaM0ZrTnNHK0UybHhnNmVld1ZpTkprQ2JU?=
 =?utf-8?B?YXdOdVN0WjhCTncyUjh1WEVPR3JTY2hPU3RRWHRibVdZVHd6bis2dmlELzBP?=
 =?utf-8?B?WEE5RG4vdTQ4NXdtdlA1Um9GYTFGMXpjOGdiR2J6enc4RzVRaVdMekIvYlR5?=
 =?utf-8?B?Z3Z2TnpGUzkrcVdtNkMwZStMLy9lK2Frb1M1QUR0Zmdrb0ZuNHdGTVhVeTNk?=
 =?utf-8?B?bG9uaklBVlVkK1NFT1ljNlhiYzJ2Slc5VzVSL2dVNWp5SlZ5TjBkNUJ1NWJF?=
 =?utf-8?B?S2h5RFJxbXF4ZFpnak1zeGpMQ1paR2xzclhXWlVYOU5iT3FmejJ0a0piSXpM?=
 =?utf-8?B?U3FxZDBmT1NPTXVYZVZORWxoVVIxdCtpa0MzWWJWWEFsOEVKYnR3TmJjZldV?=
 =?utf-8?B?VkwzUVF1cWVJdzhYS3Q5QzM1VGo0YzVqSjJMclgrTlRCQVBjbjNUbzZtcTVz?=
 =?utf-8?B?M24rYkY2Tkc2Sm5JbkgyNFNYTGRXbCtET3EzS0ViRU05SHFhai9wdHlBT1Nr?=
 =?utf-8?B?a1JIUkJKUGZtK25ieFZENjVqTEJOMk4yZGFJMVMydFljU2RteU4zZENaOGRS?=
 =?utf-8?B?aHdCcTRsanBkZktYWTkrRjQ0TlZVTlNTOWlsYVRzQ2d4STJycXE5Q2hrUVMv?=
 =?utf-8?B?YnlzSFFJZDk2NVBtQjFqdG5zV1ZXdlg4M0dyanZOVmJWK0lXNHEzV1M2Y2VR?=
 =?utf-8?B?UHV4MVo4QndpMitXeE5yVVZ1T211b1p4OGp0UlZMY1VzbmNWZ0l2MDIrZGNM?=
 =?utf-8?B?TjU1NElGVENPcUxNNnJERUlxbUZoM00zcTBIYmw2YllQTitkbmdqekNxelBn?=
 =?utf-8?B?WmxYNGRsMnVMbmU1cWlrZEYwNzFKTDhXTFl3QzBVQzkrdUY5bXNvazhpUC93?=
 =?utf-8?B?MUtZMTF2NXh5SkZScXZZSk13Q0l6ZFpad1RIZnJ5V2F0WUdOQ0djdFV6WGNh?=
 =?utf-8?B?YWpCbnhTZUNmSlVscUcvTUdxdmlLbUppV0V3VldteGpXWWo5VXEvTkZ3cGtv?=
 =?utf-8?B?T2VkalNYbXg2dFpjNXQ1Ui9aNVNmNmJRbmlQNXIrMDdlU0w0RS9oVTV3SEs4?=
 =?utf-8?B?RElwYmJrbHlKYmJyRHEyem54eTBFZkdPOGdQWWRyTmpoQ0JCOUtha0toM1FT?=
 =?utf-8?B?TE5kK016bm4xbEF1OWFNZ1Jia3YrT28yVUVudjUxS0FGa2JWTDNpR05HWGFJ?=
 =?utf-8?B?R2h5UFowRkVIcGJ1bU1WNVVrcWc3VHEyYjNZSGpMcW9TNDJ5eDNNWVBIQk1W?=
 =?utf-8?B?cDRHR0RuSzJaajRlQWd1czJHcTliZlExaERKYzhBMXlUbE9FYmdaeFdldEJE?=
 =?utf-8?B?VHFrcVRtcllnNTdPekdwN1YyVnF4K2JYOGJnYnhKY0t6YnRZOCtVZ2ZRbnJ5?=
 =?utf-8?B?bWlIR1F3TVNjN0hJNDU5MGxKWXQwWXJSZjNpdlJIdlBTQXZINXVOeGhIUzZ5?=
 =?utf-8?B?eXphRUpvY3Vpb3VXdFhweTdpRHBxdG8xUVNCaSt3blFXU2xzV0wvcXRPbVl4?=
 =?utf-8?B?aEh0OHhKeGVZdmJEUy9qdnFNVHExc2psZ0xnNUxFS0h5SFgxOFRNOXdCZ0wy?=
 =?utf-8?B?QkFTd0VLZTR2elFqajQ3NUlNU01qS1htZG5XaFduQnVkT0lkWXdVS2d3YXh1?=
 =?utf-8?Q?1WQ2ivLiLLILmMlr7m4KmfHOu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dea3be-65a7-49fa-ee57-08dc3f84cab6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 15:31:15.0038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EsMPNUmzfA2gtjk0u5oxQgrD/MPKvCN1NQ8kmQS9wXrEgRgvfVS/qbKRyqtdEPWvm8Am6IWY23mq/S/R3JNLPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8116

Add power-domains property for asrc and spdif since fsl,imx8qm-asrc/spdif
and fsl,imx8qxp-asrc/spdif require 'power-domains'.

Set 'power-domains' as required property for compatible string
fsl,imx8qm-asrc/spdif and fsl,imx8qxp-asrc/spdif.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml | 14 ++++++++++++++
 Documentation/devicetree/bindings/sound/fsl,spdif.yaml    | 15 +++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
index bfef2fcb75b14..76aa1f2484883 100644
--- a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
@@ -74,6 +74,9 @@ properties:
       - const: asrck_f
       - const: spba
 
+  power-domains:
+    maxItems: 1
+
   fsl,asrc-rate:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: The mutual sample rate used by DPCM Back Ends
@@ -131,6 +134,17 @@ allOf:
       properties:
         fsl,asrc-clk-map: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qm-asrc
+              - fsl,imx8qxp-asrc
+    then:
+      required:
+        - power-domains
+
 additionalProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
index 1d64e8337aa4b..56f8c0c8afdea 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
@@ -86,6 +86,9 @@ properties:
       registers. Set this flag for HCDs with big endian descriptors and big
       endian registers.
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -97,6 +100,18 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qm-spdif
+              - fsl,imx8qxp-spdif
+    then:
+      required:
+        - power-domains
+
 examples:
   - |
     spdif@2004000 {

-- 
2.34.1


