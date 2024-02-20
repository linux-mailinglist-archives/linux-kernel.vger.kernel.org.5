Return-Path: <linux-kernel+bounces-72711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2D385B7C4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95501F28ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6686168F;
	Tue, 20 Feb 2024 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="J+4vWEGn"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2128.outbound.protection.outlook.com [40.107.21.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B260EDE;
	Tue, 20 Feb 2024 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422007; cv=fail; b=lvuUSQFPYgMlmbEi7+DM3TB6NTfZBmyordxAgUlKMi0XjWd4mk57tSMjP+1Q3ks+5/TLXE9fr4cTrY3Vx97aC4J5uTXURBxo8Cg14TqduK3UmiwpGyoCPTKTHFradadz1KU2mUL+0hodeYAQGZZ15C8U/9gGg6MhA4DOjR5yuBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422007; c=relaxed/simple;
	bh=OvFcZ+e7uc9ytn4TAsS9ijPJDXhvc++fatigeroww1U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Gy9VXPMRbb24tWFgzeFf8eAIWNwhdVYhgJGXTgtN0SpJGdEyT0xN6n9QD/mqWdqwq8MRVhReyTnuDU9kx+sgW1FGn1YxVzA/z7iVJ5y3ILK+C0FynDbfGe4ofK/9FDmB6tzkBK01kn9nOKT1w5y3z5ZKYHdCcJzpd/qxQAJcVr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=J+4vWEGn; arc=fail smtp.client-ip=40.107.21.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUuMCJOwU0PVKlDaYqpdilXTA2xR235HbGilQWxoZ3PW53ja66V48PQ39AHdyIyMpoldD9PaLVICRD8A//vTym/w2UGKtx20LYHK2JDRVHWom92ElZtp7qVGyLnWntyJ4hJQUuJC/DTbWVsur3EW14wMPC3ZW1SLzhGTq70GpE2AcWMitnSm1gkTF0RoZUrtdWwjkcHz/Ct1t636y2N6KJJvfodwhi7dfsYq3YF184nRfVKFIbPmjSBewdpOru+fmAEHL6TKTkv95QwRZOM58YNSnGmGfMawnCOG6Zibv8ItQSWWte6DiGLKIcQwe0NYOsjTPf2leyG/DPAFMUZNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/nX/bILT83PVtLIh0xWHWAz7HJh+/AX9snArEmeyvo=;
 b=huIziKs9yswCTuqlWA4EngmLuGCFeWQwoGEPklb5jUX7KKMcuN6UYokEULStxws4nP/n5S+/tGRESVdnEoiFCvFD2nmBHPYpQGJSXXMB797c8tOJSTNJahFTqTCUV4RAjU4l1PjMslE77lPwMOYgwW+0I13BXaTJ4D8FNfP27c597XBL6Dahp/lZnb2vHUAgl8CwisKZ6m/rpvSct1QZwldLtiPa0CsJcwc0p+z1j4JboSyV5CaLIkuoHCjEx934UP2u6JzH7Q5qMcA7Omz5H1gGSHrmvvgqsY0OkO/f3UpBhw6c8gwrVCCVKM1oM77Mkb6E1Dgb85KNsyzNTbn4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/nX/bILT83PVtLIh0xWHWAz7HJh+/AX9snArEmeyvo=;
 b=J+4vWEGnLEvJnGJ9VDiOlZ80O4GapjD9r1/csTESpzTRq5AojPCpWymMqdN2mNfg77tdJcaTb+8HHMjCNA50djBG2VbticmIoAcKBJX2RrfMUXK3W8GNrBv4GMjLOeYS0VGubGs8/DeYIp21ZkviJp2+aN9ab2K7pIuCarc/VGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB9PR08MB6763.eurprd08.prod.outlook.com (2603:10a6:10:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 09:40:02 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::7409:db60:8209:c9f4]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::7409:db60:8209:c9f4%6]) with mapi id 15.20.7270.043; Tue, 20 Feb 2024
 09:40:02 +0000
From: Michael Riesch <michael.riesch@wolfvision.net>
Date: Tue, 20 Feb 2024 10:39:13 +0100
Subject: [PATCH 03/14] media: dt-bindings: media: rockchip,px30-vip: add
 optional property iommus
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-v6-8-topic-rk3568-vicap-v1-3-2680a1fa640b@wolfvision.net>
References: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
In-Reply-To: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
To: Mehdi Djait <mehdi.djait.k@gmail.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Michael Riesch <michael.riesch@wolfvision.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708421995; l=825;
 i=michael.riesch@wolfvision.net; s=20230803; h=from:subject:message-id;
 bh=OvFcZ+e7uc9ytn4TAsS9ijPJDXhvc++fatigeroww1U=;
 b=idrxsLsAo+9dBMSpGw/tXsFF4RmvU39ze340SH1Wzmea4yw9zbzKxRIrUzeXDyhSz/pGtUAbV
 hbeMbaXV6yWDV2BIowAkpdlv16Lq+mBbQzU3hdh5ATB6TqFFfaCXwwH
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=9ral3sulLe95bLcbaiNXTgUTRiBayRBEFZ5OVIEHp+0=
X-ClientProxiedBy: VI1PR04CA0128.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::26) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DB9PR08MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad7f312-c598-4511-d81d-08dc31f7e941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BjC0kiIUC3W5pIeXoZcRxM1vol5oLS6Kk5+iWLmPSJX8CeuFswxOBCZs73tkSgNeqcfcNHGDwKOxbfZkCF44YrUjG3muihruNEJ0dm431d78GxGG5WpFULr9g6rCaqMQEI/2oteI1rhl9zlZOkg5BnpzaJlWU+jPDx4acZDuJLMunyJE8jiXDUpvOFbA4dPjEdyFBYAU2BwLUxpvQlI1KKNCQ51kf+ZX0iiUX0SVYrgVt+QeRj6AGWNoxwH+e3NXplaso5K0bOyISLfMFCCPCdDUhnUy8xbjZsYxZ7wcIKBAVdkssfAjhYr3lOkt/otQJet5Xo4tr3mvxX/e8P6ik5hxB+z2TByAqIi3HFkgXt+D6LgVNGCQZkGh5GlfOlBHvaH4hbTDKUK/eGj8RZNxeHbEkBpPWVpAIg05Mi/DNEp4z1RVz2JerEmTQfiMw5AucM9A2e0HpKXZFhxk+b9vJ66btMVzvTR8J21j7XPTKGRsmvV58azCjjlChFTMFLm9pTbivblLKCeTd6pdSDL45CSCLS4IZZkeajzXRKTmTGcoPB+5aZSSmcJahkZnoqkhOlZiP4QjplP7ISMPm7RnJbmtzXbAu/abmMvTw+dcaNAoEQpvP4Rxe4MwM5m4nf0nREc2N1xk47JM4siFtD5osg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHBiR0pQbEZtcDJ3aitidWZiUHdnS3lKdnRET0I0SDJ1dkJodFQ0Ti9VdUd2?=
 =?utf-8?B?OENGU2F3UGI4aFlVYlZNeURYc0toR2RMd0d5bG9Kck5rbTQwSStCaUZwV3Y4?=
 =?utf-8?B?ZkZVZXNnY1ZtU3JDcm00bXhtZFZES3NmSTdyY3pvemNxRmJnMTR5TzJ4Rnln?=
 =?utf-8?B?MnMzR0ZzK29UZmxyVDd6V2FNcmQvZDk3N2phbEpIVGlQRGdLMTljUzY3ZUVq?=
 =?utf-8?B?WXNQVEt3VmNDRlI3eWtYSFc3TE40UDMzOEViQ3B6c2NUWkpYcGxHdEQwOGcz?=
 =?utf-8?B?QW04SFROL2xPUjlvNmhyOFFKUWEwRW9vd1BaV2ExOC9WNHNWVHB4Slpic1Ba?=
 =?utf-8?B?SWFtZlpVY0xQVEF0bzRWeTNxbjlndVd4TEdQVng5S2pENnRoRXRzYlRkZkhO?=
 =?utf-8?B?MXRQamZVczVLQ2YrT0dyaUJsNTc0bEJ5MFd1MW1IN21pNzBmWFRFdEpGcGFR?=
 =?utf-8?B?cWhPRmpka3lsTmpyOXovS2VFT0RDOGU1UFFISEtTanU2dG1BSTByUkI2TXpM?=
 =?utf-8?B?UG8yS3JnclJ4RWh2cHFYQU44dUkyVjFXbm1wZnpyS0N0NzNzMWlJeVFrRWdq?=
 =?utf-8?B?SEJTY3Rqd29uRDZUa1F1UW90TXpyYVRHNjFucG9ZVm5lRjZVTmRKcnB6MzVs?=
 =?utf-8?B?YjFBZGRKS3lhSXQxNlJYeUxZTG9ydHNKZHhkeGV6NHl6dmlNdEowSmFJaldr?=
 =?utf-8?B?VnAxcUtWWEhYVlM0a00xeG1RRjZGV2phb2Rtc250RUtnbHpWSDN0YmZPRWNR?=
 =?utf-8?B?dk5yV2tHcnIxdWJCZFZyUE8rZ1N2VUYxSHB6cW90UlVEU0xnOGc5NXhCYnpp?=
 =?utf-8?B?SVpzWDRXRjBHMC9vRkNDNlJxZllDYnByQ1NKSXNMYlRONENQaW5weU1qemJu?=
 =?utf-8?B?OHR4d1hSUHpDS20wendGSldPUmw4LzVFQ0tUV1NCMWhleHhBTCtPY0FVeDJ6?=
 =?utf-8?B?Qmg1bG5EYjFCOHgzOWZCZnd1Tk53WDRrM2Z1U2xmaFVFc1VrN0JjcVovSnJZ?=
 =?utf-8?B?bjVpRlFpcFd0OVZKRGUxRERtZUVaVEhqN3pRNnA2VXlsZk02aWJKR2c3L21z?=
 =?utf-8?B?WW9TaWtIMG5DTk5Eb3FZY0VMenJhcHp3STJRdzJtMXlmUmVobno0UFlibDJu?=
 =?utf-8?B?cWpwUU1BbUgrem1mamRLVEFrQ0ZiTUZsd05oL1JVZi85L0h0T2doNXJIdDBF?=
 =?utf-8?B?QWtiMjFtemgrRmRkcTlxNUhhZm5GWElUTXZoUXQ3K2ZxbkdGbGhDZVZnT3pu?=
 =?utf-8?B?Y0ZhblV4cEJQeHl0SDY4dTRLQmZSdnE4Q2ZUUTlBaGpDbzNFQlg0aTM5REh6?=
 =?utf-8?B?UUw4MDN6ek1iYWJFemIvbVFEV202VmR4S2syK3N1ZXdhWDdlNWhieVN0NUZG?=
 =?utf-8?B?NnBOU0NaWmFsSDNDNUpUczdkN1dJU1JqRHNhcnMvVG01V3FINHc1UWdsZE9z?=
 =?utf-8?B?REJHOFEzK3hWRzBGYW9ZckxNNFZySWRsS0JNWGRmVGVCRnFtd2NCWjVUckFr?=
 =?utf-8?B?VTNxRE1CQm9WaXFKYy85SU9PamdXclRPTWpqdlBXNkRSQU9jdU1sdEhkNlNk?=
 =?utf-8?B?UDZKdDI3blpUMUtXZXVNaVI3WGJ1MDVlcEFLb2xSaXBSSDIrMHc5c3ZRcjln?=
 =?utf-8?B?Q2pienJMVmtxZ1N3K1BnTXhDNnpuQTNTUTBZbldzOGVCcVBmOFFmOVJ3ZUpK?=
 =?utf-8?B?U3BSV0NnV1FHZk9WQVVZeHRIMWh6bU02Zk54QVFJNW5uUWZjM1NEK25YSGl4?=
 =?utf-8?B?Sy9sVy9OdXhwRkd4TFQrWTNTVHAybUV0dW1xQ3hoY2Z4bm50c3B5M2ltTTB4?=
 =?utf-8?B?aHdRTW10dldGaXRhM29pVk94MTZXZStuMlR4UGZxZm9PRExCRUd2YlZ5Rktt?=
 =?utf-8?B?T21lN21rcTRNV1pGeUdrU2hIQ2lGL3FMaXlCb2pvVGRnamE4ZGRHemhXY2U2?=
 =?utf-8?B?Y29BNWdLNHZVRkViV3NLZGhSUS9xeWlvR3RUTjh0MXFXZVpYVXorYjlsRmo1?=
 =?utf-8?B?NGhPRGgvUVNLenMxVDhoTzlkazhCS204cndXQnh1MWp2azgrdzdDWCs5NWxk?=
 =?utf-8?B?MnBnL1lvQ1YvVEtKclkvZkVNM0RlUEhzZTZ0eUZGa09NVDRpWndCL2VDdlRV?=
 =?utf-8?B?OGJUR3dnK2w4N3NvWTZmWWxkRWpIYkozdmM3SGs2TjVDTUd4SmttOTVuRkdS?=
 =?utf-8?B?Tnc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad7f312-c598-4511-d81d-08dc31f7e941
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:40:02.1033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mTrKUZ4e0B1bT/fVImbFeItp/NqGdnXsUIjNqDc+tlG8euCxG618ze5ftcOXC9gwh2dM2z+RJ4tW/ckNI3Xs5pdft3kQ5NuFwCm99zF3ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6763

The PX30 VIP features an IOMMU and can be operated with or without using
it. Document the property iommus in order to support the former case.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
index 6af4a9b6774a..675a1ea47210 100644
--- a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
@@ -36,6 +36,9 @@ properties:
       - const: hclk
       - const: pclk
 
+  iommus:
+    maxItems: 1
+
   resets:
     items:
       - description: AXI

-- 
2.30.2


