Return-Path: <linux-kernel+bounces-62116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFD1851BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68BA91F22A01
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5073FE20;
	Mon, 12 Feb 2024 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="fUkviDPQ"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2122.outbound.protection.outlook.com [40.107.14.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582313F9DC;
	Mon, 12 Feb 2024 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759506; cv=fail; b=Cg28Gbsh2Zy8GNs/Rch06MiZwqFsXh/nUSex9B0uH6xascQw8kaZWdyIxCrQYGe0UM5CkcXnU6s1FrrYOm/ZGWR6DMMB41olALowh81TmfOQ6IDCmE8n8CfRCaR9smSXlMzJGh6F1bxplTGOU1D/IU0dj6XgAHzDtUrun5qblPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759506; c=relaxed/simple;
	bh=2bl0qYTONqwDfhtFEslbYUA39JS0IJW59CSiou/PNiw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mfZO3Od8Ka2h/sYq0FvXgVlIP7ZNZEEedMyWM5QQP+/UJmEr092byI8nLPk4eX76qqfjrHmYSnNp24lXY0aAyWNGjy79BO55+rv4eExkDfYq5nLcCmerqtHw2e71U+wp6LmIBr18CUEe5mmFtH6h2f/NdZiXK3V3KiS8MtASMrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=fUkviDPQ; arc=fail smtp.client-ip=40.107.14.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DywiRzYqj+ObkYH9Xqy/iRoPmgESlpUvU0UYVV9SCAYalJmpjUv4jOPiCOG0uJPMRBNYvl9k8850ivcAs8AYU4Xk457p2mmEmZXDPj5tC6B1nHaYKOzyeG21U6qTfS/9EViwO+7NCuROpy7hiKfY0yPs8jBhP7YW+Pvw/341j3odNmINRoyjXmkJlkFWZUAvx2+8ZpXGSIkHwu7X7KZimISInPDdtOn+R9h/htPVrGqcoSaTTe0gfPhLAgFTk4Flm1DVeqPuwAtMIo/5t6EI9UvmDcATVbni5cOz2eStIXP6fCR9p8wNRDHddXKmV6MKY0OMXa6CJ69LQjh0/A+oBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0XoBzrV9zt+MatjMdVkn4QnoLKpYCLDHZz8+OlQ+a8=;
 b=nhzlt9iw1ZJqM+Kbs7rTGtfNSpwiS2z7muUX9C39UjsFXATK2A6B0iEKesCze2w7bmDOLXEKdSXzlltVlgphTH+I/+nimrC7DINtv86w3xg3n6Ty3Q67W0SnK2Pmul/j9TgQG09TT+ZbuAnke2U8xrgBnrf9/Z49NiYuiUW9sgSfH9x05Lj3cMC1ws0iXQM0gDgwDV6j3LCemgqRv3HrTIldvTFWYZcxN3Wr8Ym8mHBfb28/NuVe+S2cFAyx/QvJS+crR1KA5KhRJJwL6UMlvhCeYrE2/p8AMDzmh37pBDjIStlBErdbemS6XuBckU+gKqtzAvjPxdOoKZRWgsxktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0XoBzrV9zt+MatjMdVkn4QnoLKpYCLDHZz8+OlQ+a8=;
 b=fUkviDPQy4NLbxwGLHdiKqzlrOPdqpcvvNEIgCr8BE0hoHC1Eq44YyQAI9aHsIvFVvJODO5/Rp4j1u4C1JlDJUS7JDFLDcfrhSyHERnvE7GhxIi3WNwAmS7gAY3KfDQJyyxO98Awjj+2hOz6gJ96poNiexg2dnThNWhTG8qKfD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7909.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Mon, 12 Feb
 2024 17:38:18 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.039; Mon, 12 Feb 2024
 17:38:18 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 12 Feb 2024 18:38:09 +0100
Subject: [PATCH v6 2/7] dt-bindings: rtc: abx80x: convert to yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-add-am64-som-v6-2-b59edb2bc8c3@solid-run.com>
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
 linux-mtd@lists.infradead.org, Josua Mayer <josua@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: 93756232-5b37-47da-1d82-08dc2bf16660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fIQkMdKo+qbovxF593Om5yJo+RLNYSCzlJoCg4PsW/kT51FJYbY73zGKyByy3HaqUZgGhc5suba70R+BFFUzKYiwkhoJdx+sAF04qrpQHe/sEYrhaIDgt5BOJYp21bcoBOiLvVzl5/9NKaRQEVr/awYTrx8tMHtr2eYx3X7AlpU5nrEUGkowdl5ChWTcF86owpoZtR6hjdJ+jOEhRE8W+QxmVp3P8Ul3zV8A4+04kDxK7B5xQWeyLb5xmDa6KGZk2Ml8AkkwrDnq5UiDXTvzGVfvN554FrEPntAbNsMrnNfNV0CvlEPFFtdiGRdcSeTlArWCEN9x/ZOB7ApvTa+CDRctCcvFdz2QARh49vVFGEZ9dPRVWamWBKvIkP/VM2jJTx5HPBmmH68G1+vZU/De7fbmxjJVHE/eJLZPqenyAZCdArh7uw5tya9EE1ahYRSunhTDvbnzu7hrQKJzre72fzE/OX+lghWhKkqKzk4m4+iHnPQLNxr8/T73cKQ8lEkhiQN8CpqhvbqmkYJyWjsjRMCQakjw4hZHtUWBTFDTPsnv/Md+3AOd4IQxDgpy//F48XHslPzdgZYjLuo7/xI1PTrAZLfEKmG25bK8n+fUv2560VDZrP0x2LD/Am8Xbx5S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39840400004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(8936002)(7416002)(66946007)(4326008)(66476007)(8676002)(66556008)(5660300002)(2906002)(41300700001)(26005)(2616005)(38350700005)(36756003)(107886003)(38100700002)(86362001)(83380400001)(110136005)(54906003)(52116002)(966005)(6512007)(6666004)(6506007)(316002)(921011)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmhsU2hWM3R3U0E5bjRDWnE1Nmdacm5pd2Z6dU1KTExDL3FMTkJ3MG4vK1dq?=
 =?utf-8?B?V1lZSWRDeUVlcjhLcTVIMXM3Z3JNQzFiWXE1NHI1RlVWd3E1M3N1cGswOXBT?=
 =?utf-8?B?YkJSS0tIL3lDV29hUjNNa1R2Vm95TXRkS1RodU13ZkhGWStPZEZaa0FGeGJr?=
 =?utf-8?B?L0FRZXBvdnczakx5RVhBVW1jb3BlYjJCZUdnMnZOcDRKRDJrL3BVOXRrVXl3?=
 =?utf-8?B?WnVHdERCdnNHdkRZNTRWdytPa1pFekF0cjJ3SmQ5Z05oUzR2Z0VaemZ4UDdh?=
 =?utf-8?B?VERTMkQrbjRnL09lcjNiVUZwdDZTN2VCaEtGSCtWT09UakJ3YkRqM1RQS000?=
 =?utf-8?B?cmdqTUlkS1FnV3Y3SStPRFRIbk9NQS9CYVB6eXFJRU9DTHcwZmEyN29mWjJr?=
 =?utf-8?B?QTJ6Uk9vZE1qMEU1L3dUb1F1MmdvK3ZSUkkvMmVMYjZseiticWU1eFZNdmhz?=
 =?utf-8?B?R1dCNXVnWkduYm92dHBOR0NwenkrMTh6eVpZVDhvcW1oSFl6V0ptN2xWWnhX?=
 =?utf-8?B?MFhBY0U5ano3SnBNNFdOMlh2aHc2TCtXSklyc1AxaXJsTFV6cEcxanBFYTRR?=
 =?utf-8?B?T1FXREhPZkY0VFMyQTErWndrdnpzZFNBWXpmbTQ5NDFoOVNXRFhaZkFVZU55?=
 =?utf-8?B?K3pxV0s3WFFMVGFxZ1BUNEk3Z3FEcm9raVBUSDdMRGhHVTBQNDVLNU8yeWQ0?=
 =?utf-8?B?U3B3ZlNnTk1zVmlCYU1XRDkyTWdKWUpMcTVNak9wNXBoa3drbFFDZFM5bkNo?=
 =?utf-8?B?ejkvdTR3Z3czbGJnVGdnRnFUMk5xVUdQRnBURXYrbmZaVmJTamRaVWcza21m?=
 =?utf-8?B?ZTRnM2UrYjU3bmJqQUVWYjJBOUE2cm5VRkx4NmxUWGJ5VnJmdm41bUdhMm1m?=
 =?utf-8?B?SUc2bUdNYTdjVkNLTzZpTTdUZlBwZDE0bnBEYkJTbitWNnl4Q0lKMXVJSm5D?=
 =?utf-8?B?aDVFb3EySjkyMTRqWDZwanNHOUFjNUdqMXBFMmRkcXV4bkVVTmM2bjZYOUVt?=
 =?utf-8?B?T2hyY1pwTU5kWnYyUHo5UlMvZVlNajNQYjR3bFkvb0gvSFZBRnIrRnJoaFRH?=
 =?utf-8?B?RkE2NVhCN1A3QkJjMCtXcDMreHFzQk40TFY4RkZNbklmQmpPNHd4UTVVTDVv?=
 =?utf-8?B?MXZ1L0hUcXpyTGJFTnpGMmhXR0JzbWVralE1NitVWGgvZThLcUZvem5hYzVx?=
 =?utf-8?B?MldDNWdsdW1iM0Y2c0dBR2ZCNEw1QkZrLzhIMHhwMVFZUEhLdVNzSnBsYm9o?=
 =?utf-8?B?ZW5iQWRGNTN0bllFbUJOVmhoWndpVUlxcHJQL0NpOXN1ZVBCT201TEExWTAx?=
 =?utf-8?B?SndOOStQRFZMZWpHekQyK2UwZ0h2OXMvUU96blRmWHYyVG5uaUptQ1p0bXlj?=
 =?utf-8?B?dEkva1JqUDJxNnkwL041VkJ6azRPYjhydG1UVVhmai9SY3cvOWRJVWMrOFV6?=
 =?utf-8?B?NjMzWnhsVWNyRUg2RlRYdUVHcHN3SGZ5TVM4RmNoZUtLMk5oZ1FNTkprRzBY?=
 =?utf-8?B?V0t0ckNheEZST2hyUm5VL216MFZ1MjlrVGNJRkJwR3JPQkJrVDBINXNoRXcr?=
 =?utf-8?B?WVJPMHE1WEhnRGtrdGVNVnNkMG5xNXppWjhWKzQ3WEtzYUNoZHUrR0UvTU9O?=
 =?utf-8?B?VmF2RUhGcVMweHQ1ZjZQTGt4SUZ0LzlpSXo2LzBoMzJuZDlwSmlYVDhuRnBv?=
 =?utf-8?B?Z01iVUd5dnhoa2s5RlpQSitUcHo5VFhENnlsSGIzMlA0VlAxMkxzRlJXQUNV?=
 =?utf-8?B?TnFrSkY4c3lQV0Jvc2RFS2p0SGdTK2x3QU95Yy94QmFJVXE1SVIxeXNLd0h1?=
 =?utf-8?B?U1RTYTk5b2g2cExWb1ZWRnlZSjNGR1g1RE9Ec1kxWnk3U2ZXVUR5ZEZKSExM?=
 =?utf-8?B?WllQdDB2UTk1QkJaazRncFJpaEUwdEtmM2syZFVlOUJuUWhSU2lGc3dJQUFy?=
 =?utf-8?B?cmhUTFBnQ0t3ajBQU3QxRXJNdElXOExVZTBOZWFlUGpPcEc3MEErOVhaUStX?=
 =?utf-8?B?RnR1cU9yRldGdVlhYkxueFBqV1RyaEM0Sit3dkZ2THg5QlhSWmd2U0NRY1Zw?=
 =?utf-8?B?WlhXam1VMzJmemU0ZHRoQUNFY3FEbTlQNDZTYXBmQnp0Y3JhTHQyeGhmWmF3?=
 =?utf-8?Q?oM1OR/VYYg8jYfIkY0i+khMPm?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93756232-5b37-47da-1d82-08dc2bf16660
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:38:18.5420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZImlCPxW21CH2dc7HtIc3wexXot8NHPcXwsls8ZdkvDjYLCOSJteJAl3SfsuyPwmtgebj77MtJgx1e1KjUA7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7909

Convert the abracon abx80x rtc text bindings to dt-schema format.

In addition to the text description reference generic interrupts
properties and add an example.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../devicetree/bindings/rtc/abracon,abx80x.txt     | 31 ---------
 .../devicetree/bindings/rtc/abracon,abx80x.yaml    | 79 ++++++++++++++++++++++
 2 files changed, 79 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt b/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
deleted file mode 100644
index 2405e35a1bc0..000000000000
--- a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Abracon ABX80X I2C ultra low power RTC/Alarm chip
-
-The Abracon ABX80X family consist of the ab0801, ab0803, ab0804, ab0805, ab1801,
-ab1803, ab1804 and ab1805. The ab0805 is the superset of ab080x and the ab1805
-is the superset of ab180x.
-
-Required properties:
-
- - "compatible": should one of:
-        "abracon,abx80x"
-        "abracon,ab0801"
-        "abracon,ab0803"
-        "abracon,ab0804"
-        "abracon,ab0805"
-        "abracon,ab1801"
-        "abracon,ab1803"
-        "abracon,ab1804"
-        "abracon,ab1805"
-        "microcrystal,rv1805"
-	Using "abracon,abx80x" will enable chip autodetection.
- - "reg": I2C bus address of the device
-
-Optional properties:
-
-The abx804 and abx805 have a trickle charger that is able to charge the
-connected battery or supercap. Both the following properties have to be defined
-and valid to enable charging:
-
- - "abracon,tc-diode": should be "standard" (0.6V) or "schottky" (0.3V)
- - "abracon,tc-resistor": should be <0>, <3>, <6> or <11>. 0 disables the output
-                          resistor, the other values are in kOhm.
diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
new file mode 100644
index 000000000000..58dbbca27deb
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/abracon,abx80x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Abracon ABX80X I2C ultra low power RTC/Alarm chip
+
+maintainers:
+  - linux-rtc@vger.kernel.org
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    description:
+      The wildcard 'abracon,abx80x' may be used to support a mix
+      of different abracon rtc`s. In this case the driver
+      must perform auto-detection from ID register.
+    enum:
+      - abracon,abx80x
+      - abracon,ab0801
+      - abracon,ab0803
+      - abracon,ab0804
+      - abracon,ab0805
+      - abracon,ab1801
+      - abracon,ab1803
+      - abracon,ab1804
+      - abracon,ab1805
+      - microcrystal,rv1805
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  abracon,tc-diode:
+    description:
+      Trickle-charge diode type.
+      Required to enable charging backup battery.
+
+      Supported are 'standard' diodes with a 0.6V drop
+      and 'schottky' diodes with a 0.3V drop.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - standard
+      - schottky
+
+  abracon,tc-resistor:
+    description:
+      Trickle-charge resistor value in kOhm.
+      Required to enable charging backup battery.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 3, 6, 11]
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@69 {
+            compatible = "abracon,abx80x";
+            reg = <0x69>;
+            abracon,tc-diode = "schottky";
+            abracon,tc-resistor = <3>;
+            interrupts = <44 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };

-- 
2.35.3


