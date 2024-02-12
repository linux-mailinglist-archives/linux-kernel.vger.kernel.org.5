Return-Path: <linux-kernel+bounces-62115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B7A851BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4BB1F228C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AC83F9F0;
	Mon, 12 Feb 2024 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="dWJqdG0c"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2122.outbound.protection.outlook.com [40.107.14.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDEB3EA95;
	Mon, 12 Feb 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759504; cv=fail; b=d9N3yE1Jxvs+PacfOeP6XI03z+kLj6BwKA+VZMpGjBkITBqIQVz40HztnUNmOEJ0Rr7B+1MIjb30t17OC4C5RmRgVJh9vODxlDZH8PSJfb4WeSOlTfDKwKDPVVMGBLTPLqVXv6qYSF0IvNSDnJ6u0pn7E8UxvxY+D109Zghb2rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759504; c=relaxed/simple;
	bh=mwDdSh0+y/s6cnpH6XZpgpcRvp5XZELjoubpq4eori8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hobvtAK/PFZUNrGfgGCSv4CY9HwZuzATaFbwYWHUpz1ibYsLl3zDPBLke2X/kVfvtXKsCQ1bAvvy/eMX1HCMF6IeySwsg7f4TH3kbcTi3QRht1sPfqlEPVO/gijcOVYmZ7ZhWXcb/6VgtaOdPJ7snhILL3YywscnV1/b4kC7Rh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=dWJqdG0c; arc=fail smtp.client-ip=40.107.14.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqNi1GrVeAIahdUv/tFmw9FDheR6Xv2h8w2nGIRDEdMaL6KEMfYUj4XZewMXAhNO3beWnCd52rI9zJTMwGunfitJ6FYfpGsjbbwJT9eD2YRN36h2BvqTNtcPDkC2VElRS5g4RDNj8MfOIMYrstQ9+/0NuDfj4muKCZuDPXDra9rLCVgD+ngaZOAxajWRrf80dEEzhyhCD1lF7Vb+Rr+HMe/ri2hwTyDqXCVgUH23v8al4+BJXLtq2t8K7Wk28Q1Tt2P9ha9BsfiHHYgGHLpf1wUqoyOzcam6NAx7oEJQrq6Z9bSZqQMLxl0kUDeAu/hGs2CHJmva2cEHYSsEXC/E8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVxPmi2eYokNgwgRMfWZLMrATkmf6SNKFaT5hWZTTKk=;
 b=NF5sYM1l5gR1eB1WefuOxPXyB+P1WEsh6nJIBq24F8uNKWPcOjEaR2DEi3PcIDP+fkf7cSrE9KlecgR7/D5u0Y6Ecdj7taH1n7pN31EzhEA6FGXJzSgeYFObgR4/60/IH+mXr0hLdgjRwUPpcW0P0fOU1j5C4rHfNM4pCupx0dLLPjjOMztS40aVnjQiXOhKTY+9ooLokczfoeDZ0mG5EFAJ5Hz4AMedHbtH7qhwFp470pfdtSkT7YsPAOUNRofbEgL0ZFb6VtQVJgk9T89EpHH1oYL4OwCTzykOAwCuqb+Uyg6X8f0vBriCBDm1X1e76YaJucFX9HSGBxrEFvOGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVxPmi2eYokNgwgRMfWZLMrATkmf6SNKFaT5hWZTTKk=;
 b=dWJqdG0cT05stbdof8sJky5nPzxjfhFuM00KRhUz0BDJ8bz3fYxO6VnAfq8+HhcoMrfb4UoHYPVM8zeN0mLwHAnkN1yngFSwyF4nbTS2aMEgvr/6nNf8tfzeiFtNgT1rZTmura2cKHzd+GB+Q9/D/Rry8v/DdVHsTavXqif0TCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7909.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Mon, 12 Feb
 2024 17:38:17 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.039; Mon, 12 Feb 2024
 17:38:17 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 12 Feb 2024 18:38:08 +0100
Subject: [PATCH v6 1/7] dt-bindings: arm: ti: Add bindings for SolidRun
 AM642 HummingBoard-T
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-add-am64-som-v6-1-b59edb2bc8c3@solid-run.com>
References: <20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com>
In-Reply-To: <20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Eugene Zaikonnikov <ez@norophonic.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 linux-mtd@lists.infradead.org, Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::14) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: cb066ff4-86f6-4285-7f61-08dc2bf165d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vwo8B4MdGxZ/P2zTxkTTdrKYb6hExkpwMx+ZUG5tWEN1OGBNyPYU21Hh4sW/MF1QnIMlVTYjBfogXM3OTSe4+V8loWK+JrVdoxu0332KY2rvcHgz3TIZm+1au59xM7nWjC3gbHwXQkzwi7dV47/u6Ww4XRw0tjnYopbygE5bdpXdBItiSKDXT9TXHxDvyJHPMFJw5ujtmIzr6kKHxkwCxz6HhREpdKHN3sVdPypvQ6K3ZHeUWxa7xtaen+offW5fXUUQO04mJbNkfSsccwxghU2crlHqaFbylM6hq4f3/fXGj/CL0U/8AL9MAKxuL89oz/K4iZ0CrZkXqinD5n/tlWvMS0NwufdpcGvSJJZkjf3KsbW7IhKPIUQt9lya6TLX8yxIQd8bk+imZfI41J2/lUBlFbsIE9nIHdB3Rp7yYsmRVlzPb5VycgUPnvclEnRiBhzzvMKB0SPgXlxuDyNDLFK+wyJN3oIwMZxnPAOFRXhzF0kfH6i0oRltQsvaDoKV0769aWLZxzjvfBBBsve9NY8qYfNR61xNCzC68utYS+e55oozUh22zuqvEOS42UJTwKmRAHgn8P2djvKuzoEnEwIt4NhNpU2p9XHVahNAYQTMybg6SsnBKtAwvNj3k7F5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39840400004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(8936002)(7416002)(66946007)(4326008)(66476007)(8676002)(66556008)(5660300002)(4744005)(2906002)(41300700001)(26005)(2616005)(38350700005)(36756003)(38100700002)(86362001)(110136005)(54906003)(52116002)(6512007)(6666004)(6506007)(316002)(921011)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clRqUGhqZGtRN2tISmRnR2ZjNHR1b2RQWFBjRWF3cjUwUkl3K0hSNEFCREFO?=
 =?utf-8?B?Q0JrcnRCc05hTzNvMnlPbnVPN09HelZmWENBdjdRN0xBbUZ2MzF4ZjJRQ05C?=
 =?utf-8?B?d3RTQ2JnbWFRZTBSNkJlejZnb1RCT29oY2RwcTg5KzB5NUI5N2JpZnlYYW5w?=
 =?utf-8?B?d1ExYTFwMGJCR3FMZzcwaUIvQkdzRDlLbmlud05xTXFLeVJ5OHFWdHgyL2RR?=
 =?utf-8?B?ayt5TU5oSnV1ZnZ6OFpselkwQ3JWQzRFVkNlVVQ1WVp4SXlKbVRhekVLWkxO?=
 =?utf-8?B?QlE3cFA3VWdETDNyV1U5ODRFR1MyN0wzbjRSQWpta0lBWHpJZ0p6eU9DUjNH?=
 =?utf-8?B?V1pTZUN3bXhRaUdQdjRoQ3RWek9NalhWM1YzN2h6c3UzZFp4OFhNYjEzd05s?=
 =?utf-8?B?VnczaUxHQjRRNzk2Q3BTMmxNNGFndW1uZ2IxWnBRWWdBakhGZTFOS2JGUUhi?=
 =?utf-8?B?Qk1nUlRLQWNMNDZ0ODJGczV0bVpVVDNkU3A4Z3RWT2JpdUkwaElILzUxK3o0?=
 =?utf-8?B?aHppRzR0MzBVaENvZGxmQmIzT0dnanNhS1ViaFFKZ0dOUE5SZ1VZZ2V4cHA0?=
 =?utf-8?B?eXJibnFLU1J3a3FiV1ZKM2I3TFpndHVVSUY0THdOLy9JZ0ZxSklxRHFrdFNS?=
 =?utf-8?B?U0V6cGZ6cUhkMmdORnJETXAzS2pOb1VFLzVlYStsVm9CdTlicjk0ZjVPRmUw?=
 =?utf-8?B?YmtpeXR5dDlweDRtQkZPS2hsbWJIQ1ZXcUhwWXlnK2FCRkpHVm9TNXN5b2hO?=
 =?utf-8?B?QUlmand3TVVSeWFvYmpLQkRoVzlhYVg4WWpvUDIvazJyVmV3WXlSTWN4Y1p1?=
 =?utf-8?B?Y1JIWnA3KzFNS3BBQkdDaVZWMWFFUmpQTHZkOENhQXVQOVR3ZUJ5MU1XcEFx?=
 =?utf-8?B?a0lndVJZYlBRYjdiRVRUV1NQTFVHMmZlYVhGWTJmbnErZjlsMGRhYld5SUhC?=
 =?utf-8?B?NTQ2YVdiMUhFdUQ3cjRKQ3JzeTBuMzZsenhpaEdqM1BvSWorNm1WblZpc1Mv?=
 =?utf-8?B?cjRwYWRGOGE1VTB4TlVjR09LNGRId3ZXSDdHSXRzVEtsN3pmM2Y0OWJybHo5?=
 =?utf-8?B?NlBxK0doZGhCRWlHVmRnUFdsUHhKM0xodjNJM0RRUVVrNTNnWDlidjlITG1v?=
 =?utf-8?B?THVrY0JYdytGQldFVHNLazMrTGNkZERaOThYTmt0ODUvVlREVk5ibHc3OEJl?=
 =?utf-8?B?N1BpSFQ2R1VwYWYzZXZyVGowOTM1czJMbnluK0xGSHBlREtERXFSRm9YMnBv?=
 =?utf-8?B?YklvcHhHN3RtRXdmOUJUSnpCOTBaYksrdmFpZWIyV3pNcnB6K1R2OGNkbWZS?=
 =?utf-8?B?LzhJa0FQRk1UUTdZbVIvTFc5RmNxKzVVMjk5MzZlV2h1TURuNmQrVy9kKzQr?=
 =?utf-8?B?OFNIOGJyM0krc1dYeWNxZ2ZtbmJFU050TWVvdUx0YnFVWk04MFBrQkN4VGY2?=
 =?utf-8?B?RnhyVGg1bjhFV0RzdWxxdFJJQzdYWEYzbUJrZ0JibUtmNlVWMlRZM1A4Rzhr?=
 =?utf-8?B?ZFFzUnc4Y09Qakd5U0FRM2ZCem9ZRGZDQjZrU2NuQ3pWUW01ZlcrbW94K2FL?=
 =?utf-8?B?WlhuSWI5STRqTTFVTFhLRWJvOCthcWVhS1J4VzZ0c1d2b3k5Ymh3dThaRkhn?=
 =?utf-8?B?bUtKT2prZlNBU1JscktEcjg0K3NhenhjY3JaRGc3SGYwbkZKQ0VvVlNlWkxU?=
 =?utf-8?B?enhiTG5IMDdxWis0V2ttS1JUM2dka0xCU1JDcW1DeGE2NG5ERFlXdFNDRmZT?=
 =?utf-8?B?eWF3d042dldueUp1eXYxSmRoVElScS9oSlJQRk5ZZzNnVGJpRUwwMEl6Sklr?=
 =?utf-8?B?anRITUlQa2JabGQ1RDFlVVNjcDNBUXhXZFk0eWpIUW93dnoyOEl0Tis0N284?=
 =?utf-8?B?R29iUnFPd2Y1T0k4Rk5NNHI0S0JkNHM1ZTFDNThYUU5RTG4zeU5QYlQ1K2ZM?=
 =?utf-8?B?d1BUakZPWTc4WDRlWWxPOTUwM3AwdzRoME85SXB2MkI2d081V0JDMHF2V0d2?=
 =?utf-8?B?aFVmY3BIY2hpbjNXaXQ3Unp1TVZPYkdsUWVyeFo0YzBmZUVnR2NkR0Z1b2l3?=
 =?utf-8?B?SnVQUTgrODB1U1oxVWNIeXh4d0l4VFBSckFXWUpzS01ucm9IQVF1MG1BL3dC?=
 =?utf-8?Q?fnyP4tzGwHwNA2fpArt+dwimY?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb066ff4-86f6-4285-7f61-08dc2bf165d8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:38:17.6511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdphCWSIj8p4/W69ZMut33rAVkmUu8oL5rMfb8FI2NIVcuCccsCODW53fq90I8xARLqjOwgD5hRcRxa+HNuh5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7909

Add bindings for SolidRun AM642 HummingBoard-T Board, which is the
evaluation board for SolidRun AM642 SoM.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index c6506bccfe88..0233a8b0b6fc 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -87,6 +87,13 @@ properties:
           - const: tq,am642-tqma6442l
           - const: ti,am642
 
+      - description: K3 AM642 SoC SolidRun SoM based boards
+        items:
+          - enum:
+              - solidrun,am642-hummingboard-t
+          - const: solidrun,am642-sr-som
+          - const: ti,am642
+
       - description: K3 AM654 SoC
         items:
           - enum:

-- 
2.35.3


