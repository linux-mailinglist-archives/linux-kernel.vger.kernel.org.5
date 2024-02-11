Return-Path: <linux-kernel+bounces-60817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BE38509DC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F8D282403
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41C95C903;
	Sun, 11 Feb 2024 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="mFVkwFmA"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2109.outbound.protection.outlook.com [40.107.247.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D165B67B;
	Sun, 11 Feb 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664085; cv=fail; b=H8i2cxXCSrUEh7RtbvhBbvCo++vue5UY1i2nUXQADobGL84kGW2BM7w3SVX+jGj4ZveOM2wIynbXwBko6iSL4I2qOz2x+9xET94QUkqdFbUvt2velKbcdB6OKw6mT58p1VflZ1q6beDPyJhpF6UXeK19vf3X56+ocV4k2mrvsDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664085; c=relaxed/simple;
	bh=YgLNcpGlBmrpgyqTR+9s7uwmVehM84XVDhU2XJPiGgw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=fVk/H3zujljfbaBFOBKQgt2uMnnVuZ0XoMKrulQ1vFcwvID+860l7e6KYw8rJPLpFQWCNn0u3+i37cYUnE64cU2pP7A/4GypZWvn+YsDOBicPHJ/e0UKgnXHxVhKJQs9no0jMKVbo1WXGEJsj15pkmrJWC7L5+Zg2XHofGnna3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=mFVkwFmA; arc=fail smtp.client-ip=40.107.247.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lut6LOhFASHyx+wqSZCDGDaAiUKeXGA9ZUte5rDuxiyb4HtotL+QI1JZtdSiBzQKnVqaVqkVhoBUcN9eeFcTTrjSQGmZ5t2csnA7uPOp9IUe6K6hW2evGQxSb8qkFlzvl4qDnbZAcAUAq43k0ylX+vGNPEDw0P+60Q1e62eELnce0O7M2l6gzxjKlsxO+n6Ak0++/xEP5ONFxaWdcF/tWfQ+ED24m+VisysGPigVI3up3m0I7ug7UexL+dEiyP+NTtpzOXz4prlUrDWtd3jihRPyyPtCNPYmlwyd6ig0pGf3r8sQYP5MMP83VODyNx5qQqZWWepPjY+vg+gnCms1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BS9rv3uzhhFRsT44a1y2/97KbSsJTCT9L9lA4NzVbRU=;
 b=mv395PH0SnDBWIkuDSa6JRNX+Bj6OXzl3ihV9+RJBHzjacSHltOue5okL2zAdTwH50i/sVV/PmzdI8/qkcErvKEDpGjHtFkLTaLYwfVa7WkbX9hbT7cxfkJjvBDXfYMiaJrF7QUoC03jggUFn0CcEG7vxeSlFnFPtu2JmEc39y4EaP1xia+7eWZlMY3uAEp3KekgUj7WVTmjqKHDT2MTsg09qN0uNwPn5IWZ8K7XwNM91FChkFxUMG9sLP35TKJcoqMfGwmFudQOWeCGeXtmvYX4VlTkM3QbO9H6pZiQZLiZdsebYRcDu8VESX7eBw84K1IAkj9pE9ZtSlmhBiv5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BS9rv3uzhhFRsT44a1y2/97KbSsJTCT9L9lA4NzVbRU=;
 b=mFVkwFmAahveD6FY155j/jxxIpuUZ3mMPy15BEHcvShfVZY35dbfjAq8y02RJf5E5iCpUC/taSwfGREkhLE5eylr3+yxv5VNUbdbt9ulxPUG/h8yb2IkH9X56WZI2FgHLiRESvCOTth5letKUuhZniEJJlcJ5NN+vPJXOXKf3pI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB8725.eurprd04.prod.outlook.com (2603:10a6:10:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Sun, 11 Feb
 2024 15:07:58 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.039; Sun, 11 Feb 2024
 15:07:58 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v5 0/5] arm64: dts: add description for solidrun am642 som
 and hummingboard evb
Date: Sun, 11 Feb 2024 16:07:55 +0100
Message-Id: <20240211-add-am64-som-v5-0-790ed7121249@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMviyGUC/33MwWrDMAyA4VcpPtfDku0m7WnvMXbwbLkxNHGxN
 7NR8u5TC2NtCL0Ifgl9F1GpJKrisLmIQi3VlCcOu90IP7jpSDIFboEKjQIF0oUg3bgzsuZRWnD
 gnekoRC345Vwopu8b9/bOPaT6mcvPTW9w3f5B+hFqIJUMwUHcI3aO4mvNpxRk+ZpefB7FFWt4B
 wAuAGQAdG/R7LzB3q8B+h/gsQA0AxgNn3SwivZrgHkGGAZs7D8AXbTUwRKY5/kX1xvEF28BAAA
 =
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Suman Anna <s-anna@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, 
 MD Danish Anwar <danishanwar@ti.com>, Andrew Davis <afd@ti.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::19) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DU2PR04MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: c4162f87-3fb8-47ac-46fc-08dc2b133b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QYm3gbFt/IsURa2fdcljJLcbqfOWaOf3d0584zLBQH/4D5BKkf1p5hsyxETsEjlt2/Pss2gtQ2jZkld4cfZ3m4ajyahyrv/1wRBrXMNmV0c1/ZwDvncyoziYS8dUEYnerSCN9k3ZGdexG5yydbykzQ91QPjS2StycyuIDwT/UMMchxAuS2kHvCcnkRkZKqZaClrqltlkGadwBe3Jjz7hEF6cfJLM6YK8aGWoR78vica9AY1eE3VUEKG7ShRM0v7hdNYV9wz/cD9v1t8h5fOwENdGI/RXfrCsSRPQj7REnxPtDZz0tLvDz4twovz4MAp/iNTkEupLKQzhd9gEzebxB4VrqbjAEcF+iOP/7lMvS69sEY0Ll5g9vA3pAU/4gWY6yC8ahzHaJOX2NbDEvErJ5suogYPN8YLzedwRYQgpuY141S948QiN+0TAgEMPPXc4CxC4MsbMK1MlmrsReE57YyZ95V7RHjxTL/DqeRDxP5gKApcapT2ktNzj/fkXpNV44K7bzBwkHEyi5bN61f/qiDVhsIcAztoVsDOjZmt3kJfqEbP33yg/2bon8RIo+G4rrQIQx+mZw1LYhG0KO1ZN41PSuqWr0fXVbqDe5nZARQc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(136003)(396003)(376002)(346002)(230922051799003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(41300700001)(2616005)(316002)(6666004)(966005)(36756003)(6512007)(6486002)(66476007)(66946007)(8676002)(54906003)(478600001)(52116002)(6506007)(66556008)(38350700005)(4326008)(8936002)(86362001)(38100700002)(110136005)(26005)(5660300002)(2906002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzBMYTEwYUdrMElobUVmaXRRb0FFamJTYWZwRVJobklRVk1EMzNpWXg3c1BW?=
 =?utf-8?B?WXhmbUdpN1U5c1VnaC9uU3JJWXBRRUZHTkJOeEJraGNYS0NNYklkMUdMS21N?=
 =?utf-8?B?cm9CaEFYMS9Pa3dlOWduK05HVTAxMGZ4MUxHM21QdTlUbWFtdDFUWmtoT0hO?=
 =?utf-8?B?SFFNUm9SUHBGUkt0eEJKa3V0cklqOGRhc05XRllvbHN0NUljS2llYVR5RHlL?=
 =?utf-8?B?OHVOcUxCczhEclRSbXduQVgzdkN6eXhDZjdLN2ZBbnhVNC96YXA2dUlNSk8r?=
 =?utf-8?B?MG5Zb3E1cytEY1FQSFNmTjduMmZMVy8xcDdwMXQvVGk5Rk1XRXpWVjgyQmVB?=
 =?utf-8?B?N3NjNEg2VTE5Vkw1bVJwS01YYjQ5UGUwOHE4M2grZEpta2VNSmhYVlNNcExF?=
 =?utf-8?B?WXNnMXZReW1VbldzcjY1TG94S1JsVzlDRy90cTlreU8zZzB3VVRRSXAxcHZ5?=
 =?utf-8?B?eGhqMVNhc1M1L2NDTzZqMDNEZ0krWlFJREFPQmlTZGpEOStnMmwzdnZiL2hO?=
 =?utf-8?B?M3hMUFVsSjRJUWFjbzU2L0k2YmREbjgwd0dRdFd2WnUxSkloU2M5RVQrZ1pq?=
 =?utf-8?B?VXRLZWRDUmxqZnZtQ3FZdHRsNnRFWkNtWGNMczNuYk0xSVQ4aCtJeXRnd1hs?=
 =?utf-8?B?MEowYTMyRXBuN3lENUFvRTFFc0hVRFg1RWNnMnFkZVE0MEl4N3RmNFZoQThY?=
 =?utf-8?B?NUoyREptL1ovZ1g4SmxWYmVoczBuUGlTZWZndFMzL05VWmE1NHpuSFRBMm1G?=
 =?utf-8?B?WXZMR3RRVnNBVElKQ1hscVBEQmorR1JpSkt3a1hBOCsySDcwWm9HME53M1pi?=
 =?utf-8?B?VmdEQ2FVc3EzbUNwSDZJT1JlUlhZc3ZVMG1xODRpVmhRYjN0N2pBWm54MmFX?=
 =?utf-8?B?Q1laRGhROTJ2aWhiUU1VL3NQbkt0VXBZNDN6UWdtYlFtSlRrYk1FU09yN2M5?=
 =?utf-8?B?RmVZS0lPYjEvSkZVQ1d3eUJGRFNPYWNLbE5BVjZ3bTJIdUc0Uk01OWFON2xt?=
 =?utf-8?B?S2kwVkU1WmM1TUdhTTFIK0lVQUE1SWRXbjRhcHlyaC9kaVhhQm9pRm5ZSTh1?=
 =?utf-8?B?VmF3V0J6OThBeEZwQi8vbjVvT2VEYmdhQjhqQUovWUZCYitEd0g2UkNEUGFz?=
 =?utf-8?B?TUdOUkpxbFU5OElLRFFScnE1ZldFcUVvb3dnQ1FJUUppNndsTXdqeWE0UU5y?=
 =?utf-8?B?eHhpNFN1Qzl5YXpFTGNJa0xhYkVQMDB2c0t6cVR1N0pVdHBwci9Nbm54YkVt?=
 =?utf-8?B?dVZGMEljazcvTldUeU9SZWIxcTdrRnIxVmd4NitBZ0dvbmxDRVNzc0tmV3R6?=
 =?utf-8?B?SWtCZU44UHpsZElMbldFQWkyeW9paS9uSzJnZXFOd0JxVTRaL0lnZTExWENI?=
 =?utf-8?B?aC9EcnZud2FmRUlGT2o2N0c1N2trUGJabW82cHJDcVRHaTlLS3V5UncvUlRL?=
 =?utf-8?B?ditNdGhSOUxad3lLcWlscUhVYnlyUDBkWlM1VW9Rc21tK1A5RHFDd0dwcWJr?=
 =?utf-8?B?a0h3dnphcGpPb056SUF6dzZLdGc4UHB4WW1VQzhhRmg3UlJiYnZWOHZ4TmhW?=
 =?utf-8?B?V0xHY1BEenFhQkZDU1c0U0tpYlFraDB5MmJwd0w0bHNoMU5pdE5IRUs4SnZR?=
 =?utf-8?B?aXBsQUJZaGk3d3RzM1hieS93VUt2eVRlRjU1ZGphdEpQdW1YVXIwbEJUSTZr?=
 =?utf-8?B?SGFQWXpndXNIUEpHMHBVTXRhR2Z3Tnpjd01yRStRbzZ2L3RycGV5TnlqV1dC?=
 =?utf-8?B?TzBQVGVxbEZsZjJxV0pSZXRvSGo5RWdqZS9VdSt2ZG5oc01hS1NINXUyMTNu?=
 =?utf-8?B?SndjSzdrQlVvdnFjSnA3OUZTV21LWmZOMDdxQW4xY2lKbWlBVW1TWXBOVUdp?=
 =?utf-8?B?dFBtWXQyaGIyOWpGaWhydVpEbWhWZy8xb0RpeUZ1OWRza2FxY1FWN2J0Y0NX?=
 =?utf-8?B?dnlUVDJzS1pJNjdHMFF3ZmwvdnJ5aWJYNDdMamNGRVVHdDVubm9aaUErOERK?=
 =?utf-8?B?ZU4xSTNDdjBOdDZkcW51OHplYi9ZM2FXSkp6d0t3MXlLaCtQb2pFb0xva1c1?=
 =?utf-8?B?QVNNYmJPZ21QOVdncjN5QTRGbmRnMWVXNEY0UmFPMHhxNEp0dERvQS9mTDFX?=
 =?utf-8?Q?GbnujW2AK0sBmkJy1iw/k7YLA?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4162f87-3fb8-47ac-46fc-08dc2b133b5f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 15:07:58.1245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVWdQjHLerfLpC6syIQHj5yLRSHccAbWVJrzjwM4jnWRtEsv5gOjLRQHhdvhQLF0k2JSnUQobqmYW8Mw96Cdsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8725

This series adds DT bindings and dts descriptions for SolidRun AM642
based SoM and Hummingboard EVB.

Additionally a commit from downstream vendor kernel are included,
enhancing support for pru based ethernet.
I wasn't sure how to properly annotate it in commit description /
signed-off area ...:

1. add description for "Industrial Ethernet Peripherals" (IEP) to am64
   https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/arch/arm64/boot/dts/ti/k3-am64-main.dtsi?h=ti-linux-6.1.y-cicd&id=5afb73d82a014b59462162d960b350b8c58e5ae6
   IEP is already supported in-tree by a driver, and used in
   k3-am65-main.dtsi.

Unfortunately dtbs_check reported many problems, I put some remarks:

- 'mux-controller' does not match any of the regexes
  The expectation seems to be that a mux-controller at minimum has an
  address, something to put behind an @. However this is a gpio mux, not
  sure how to name it better.

- unevaluated properties: interrupts, interrupt-parent
  sensors and flash yaml are missing interrupt descriptions, but these
  parts definitely have an interrupt signal in this solidrun board.

- wrong names for pinctrl nodes
  Other TI DTSs consistently end with *-pins-default. Should a different
  naming convention be used?

- cdns,phy-type required property
  inherited from k3-am64-main.dtsi
  there is a PHY_NONE value in dt-bindings/phy/phy.h,
  but not allowed in phy-cadence-torrent.yaml

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v5:
- abracon,abx80x.yaml:
  - reworded 'compatible' description
  - removed $ref to interrupts.yaml
  - nested example in fake i2c
  - changed maintainer to rtc list
  (reported by Conor Dooley <conor@kernel.org>)
- patch 4/5 dts:
  - re-added status properties for sdhci nodes
    k3-am64-main.dtsi has been changed in-tree since v1
    such that sdhci nodes are explicitly status disabled now.
  - picked up reviewed-by
  (reported by Andrew Davis <afd@ti.com>)
- Link to v4: https://lore.kernel.org/r/20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com

Changes in v4:
- abracon,abx80x.yaml: fixed dtc error in example irq reference
- Link to v3: https://lore.kernel.org/r/20240202-add-am64-som-v3-0-2f44023d50e9@solid-run.com

Changes in v3:
- removed lots more status properties, double-checked against soc dtsi
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
  (reported by Andrew Davis <afd@ti.com>)
- removed intentionally-disabled pcie node from dts
- rewrote yaml bindings to use enum instead of anyof+const+description
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
- abracon yaml
  - added missing maintainer
  - added diode type property type
  - added example
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>)
  - added reference to /schemas/interrupts.yaml#
- use generic name for pru ethernet controller node
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>)
- removed unnamed dmas from pru ethernet controller node
- moved pcie/usb3 features to dtb overlays
- Link to v2: https://lore.kernel.org/r/20240112-add-am64-som-v2-0-1385246c428c@solid-run.com

Changes in v2:
- reordered patchset to drop separate patch adding iep handle to som
- moved dtbs_check warnings to cover letter
- converted abracon abx80x rtc bindings to yaml
- updated dts:
  - remove unnecessary status properties
  - changed non-generic node names
  - use color property for led descriptions,
    they have no default function on evaluation board
  - drop earlycon bootargs from chosen node
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
- converted charger node to comment, part not assembled, has no bindings
- picked up acked-by on board bindings patch
- Link to v1: https://lore.kernel.org/r/20240103-add-am64-som-v1-0-dda1f9227aef@solid-run.com

---
Josua Mayer (4):
      dt-bindings: arm: ti: Add bindings for SolidRun AM642 HummingBoard-T
      dt-bindings: rtc: abx80x: convert to yaml
      arm64: dts: add description for solidrun am642 som and evaluation board
      arm64: dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3

Suman Anna (1):
      arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes

 Documentation/devicetree/bindings/arm/ti/k3.yaml   |   7 +
 .../devicetree/bindings/rtc/abracon,abx80x.txt     |  31 --
 .../devicetree/bindings/rtc/abracon,abx80x.yaml    |  79 +++
 arch/arm64/boot/dts/ti/Makefile                    |   7 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |  24 +
 .../boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso  |  45 ++
 .../boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso  |  44 ++
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts | 292 ++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi        | 594 +++++++++++++++++++++
 9 files changed, 1092 insertions(+), 31 deletions(-)
---
base-commit: 798d1ee1675be84d5c7eb639480aab33f2c8791e
change-id: 20240101-add-am64-som-51a1ca47edf3

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


