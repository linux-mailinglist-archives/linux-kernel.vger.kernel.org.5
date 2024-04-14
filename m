Return-Path: <linux-kernel+bounces-144141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA74B8A425A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49741C20BDF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBF43EA97;
	Sun, 14 Apr 2024 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="jtJsGR9I"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2132.outbound.protection.outlook.com [40.107.249.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAEC14292;
	Sun, 14 Apr 2024 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713099521; cv=fail; b=sPJj1SpJKYYrxGghzFdSdTeWt5zItQMLYB1J4+Mq+Rq/LJV1Uj0YeCGrL/Qm5+haXbddVHz6P/Lz313NFFOgjiDFQ1lAZiDFM0dtZATdZahBcy00SxNqfqYR5Qc4mu75QoCMgsZneZ/hvSOylqIzzUJeHOAXlRk0hLT2yzVuAWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713099521; c=relaxed/simple;
	bh=2DYXj7ZdRGTL8mbj+V03wB1Vt1uNMUaO2A6j2WsO/qc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=rw+AcvwPRbpXafFUDFdEOQGX6gHQcP7N2b7zXd8J+tpQWLcLzt/iMjWYCdoVRnWwTmkD/TlJhKxc+IGn4Yv4bosJ7C/0ogY1uZOM0AUgv523w6EzSOYSr6Pm5d6dLC6/q12Utjxxqe6LgYb3Aw4xPB5icAgOuagtYza5q2Z3IoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=jtJsGR9I; arc=fail smtp.client-ip=40.107.249.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8w1u8Yjxo9qgo8FYS+0dZPyZUtLT/GxyauJREKqOG7mnJWvEvDwRMNSIJs8ts9YtbVXJquVzI3Wv67e3lZONBsk3jchdzNhmqaX3sO0qekWCyMjIUnhj2sH3bD5+d0BCH30eO5HgG0+HB8guH8jOOQyyrvKdYvAxfIlDz+Jc9YFFkwRWp2C8GgwqeNUFLIJ0CjARhkRtF8VFhKTsG8QYdckb4ZchGzsM7XvRoWYzR/GfYVVeWtZCCjaUmXTeDIOpB7CpcQNxKD+CxcPI5WjtC1u+9jCLC/iqrYq3vTruVvtL0xoXaweaew7WmNSOjN39/R/AlRJHRNqGNHkKI9+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXkBl6fMrm3NwinWqLu3p6fa5+Mt4AogSxh7FaUOouY=;
 b=RlUymhikdxsIDBTMeW5K6w1TCgnflTu9UWEaqmL4vvbEnM6DtFYmnYJxwMeAujJNKq9LWFFsfwzY5uf3bNZmJXHCXDnBe9Yg9Y2ygOErgBallqNsdhxXhqc8zT17ylXoTRxbmJBLIAu6i8Pk/KGpjVRN4122/nMa8NDRj5YtKIVV6cuU3SJk67KFbDbePx0TWLglNgsKt03VvbqeNB8KqtH6Uh2R9iIl3nocjMm9N0ep0TnkSOebtgvblwC/gzHNyCIjvNDhS5jZsi8l+4Lv1H5iwH/2qBfGc5+9+70U5l1mhU+LLTD6uhjCnZL9ctht8M8aHlllB8c3IBnX5tz2jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXkBl6fMrm3NwinWqLu3p6fa5+Mt4AogSxh7FaUOouY=;
 b=jtJsGR9I9kYC40T4N3gsw8ztDuIDymkKdw/HAMt3Pg7cvb/YQRAcl18N6z8wm6/kpnfkba4UK44wMmJN/10lnlbQGRuZh4MMTTP0Ig0ch8/oXhLVHShM8IgP4hsO3bg5U1Mx21wjleOIfffBVioN/3j4LxkJMxa/cStU/pqmX5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB8645.eurprd04.prod.outlook.com (2603:10a6:10:2dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Sun, 14 Apr
 2024 12:58:37 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7452.046; Sun, 14 Apr 2024
 12:58:37 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v3 0/4] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Date: Sun, 14 Apr 2024 14:58:31 +0200
Message-Id: <20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPfSG2YC/12MywrCMBBFf6Vk7UhmUmzqyv8QFzFJbcAmJdGgl
 P67aRF8cFfnwjkTSzY6m9i+mli02SUXfAGxqZjulb9YcKYwI041FyhB+xYFhxQGkLW0cqf0mSv
 NijBG27nHGjueCvcu3UJ8ru2My/vOEH5nMgKHBhGpUTVvlT2kcHUG4t1vdRjYksr00ct+dCq6U
 B0RtboxZP71eZ5fyZXm1OcAAAA=
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR5P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::18) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DU2PR04MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa00b2f-8d1d-4813-0f5f-08dc5c829993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7vDoV/auP+YA3qmMWy/on97ZZ8FUJ7VuLtlPcI/OwlkYDMuNbk24iaNzBlyQLQKd2oluo/RCW5d5+NLtW+mFrYxAyHY3S0DOPl3C7tJ6ZuigYPnODnvEssmFyQ7bJZNlpVFooUPBSm3O0GmUzfsR8s3ks4J70EbEKgHXY+qxF6hWFjDKKdZwO93NcEnamj8KPaFugRZf0nKG+pmf6s9lIYJLYbQZRXwoxDBx6hUTQ+wphD9mayyIZMVliD7oOBcz+6PmGe4BdsSInFixgzvMgEjjm59K/wz9q3oRYQ2d9GYwRG3dRv0KC8Vg2QmexTIZ/1a0S9Fb9QT+IXI5Jg1YrVdaCiv9dvYS03U+1H4cGinpsC6cHHOBvlYtBNLIW/jSzJNazYKG8Y9xBafi2iKvyO4V7eCqrnVrfcqq2i1iesIpexp98IRBhJ5a+RLJ2JbCM2XuAFgApU7JE15+XiwzX731Fc/fQFzuQUqBfltsLQJeafJNCaxM28wSU2gXgNMPYMsgsZ7MFJT5oXgF9zDNHGjHRpEm/5LqEAmqX/4YsbQXFQ6qsGW067WN8Xl0kp5L8Q8MrkN9ZQJ2VrHN/5G/UyWiu1Cq4WhWyuYCVYHD9sKK9dU/G1reWWck9XFsKbKzzytjvKxUXPmDR1hpGT4JX88UwGrTlM/9HoUeFbIKIZP4Sr66ogZiJzaI3izxJb6RLocqy+3Keha3WwtSBAVyWmVwHIfXzCQZxh8S+7cnQE8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXZUM0ZmK1BPZ213TVhUWlVDbE9sWkJjd1F2dVprd1dRMmVIMjRCQUdTU2pZ?=
 =?utf-8?B?alVxemV4djZvK0JWYVN2NXlrVmpwMktRMS9tZDZ5VkIvVHkvT1I0emh1OE55?=
 =?utf-8?B?aVFhSllPa3lBOHN5L0tBWHIxRzRrajV4YVJHWHZIam9MSTl5TCtEV0NCeXIw?=
 =?utf-8?B?Y2NuL3VXNFV6OFBzTlFHSXJkejVkWlc0aUtBdUV6cTl4TDRTZ1ozVlZEMGx2?=
 =?utf-8?B?R0FoUW1zVXdzeHBoRThDMHJOc0Y0bXRHYlZJNHozRmNVRytERHA1VGpWbFlR?=
 =?utf-8?B?eUx1Z210RTFrWGVpRWRTRmJIckRPRzQxRlo4MC9heDVCY1B5UXdtbDRURXRq?=
 =?utf-8?B?RTViUXI2cS95YVFXUnBqa2dqNWgwdDZhRnc4QmdJdDExLzJnemdhUHRCODVK?=
 =?utf-8?B?T0Z1NEFEYUpnTXBGRW8zMVIzTjdBSWN2MStaNkFXVFJhdUtVa0x5NHF5U2sy?=
 =?utf-8?B?a0l6dzZWV2FpaWIzK0IweXJIMCtoNUR6WGxoZVA0Nm9kRmUrd0RRL1hhZnRF?=
 =?utf-8?B?dzgxTzkyR2RzdEpVSlQySkY3M3pLMW85aXVvQUdnREc4aGN0RmJVYWdKaWU5?=
 =?utf-8?B?SlBzNkhaRHRFNTI1ckc2TGViMmpUNm5QcWJibUlvL0d5TGloM2J6MGdZVWVW?=
 =?utf-8?B?aGJROFJ2WERWbk0yRTZUTWxQUkJjWVZoaU0zemNyNEVXL0xPZnBQUEs4Tkxw?=
 =?utf-8?B?N0g0RnJIYUxoVXNGbHVqVjNmQXBQZlErL3liYnFwQ3BTNXYrdS9DSTRTMzg2?=
 =?utf-8?B?SjZqVWpzc3I0SHR5d3pqSGIva1RZcHpuWkEyNU5XbllEa0V0aFlhZTN1YjVt?=
 =?utf-8?B?Zm1XRytPMHpCeVJ3VkxGbkpMekV4cmF3aXdJWFZIZUN1U2FMd1o5aVhWMkJH?=
 =?utf-8?B?NkxCRUs1RnljenJ5UFNhbTc5T1hOZ1R3Rkc0TitlZXJKWk1MY1FqM3hucXVv?=
 =?utf-8?B?UW1Pck9mZE52cmptaUFFcE4wMS8yVGY0UHdzSHpNQ1hDVkdKVWNjdFFHWDVo?=
 =?utf-8?B?VzdsQW5tQ01iaWxEYlBXaEI5bGo1Ymx5VmlsYlBSOUtpeDNnREcybUt2bzBO?=
 =?utf-8?B?L2dzc0ZvT3U3QUhJMUpEYWViZHMwNjBaTkhoUW9uTVlKQkZ4ZGl5QkNXNERX?=
 =?utf-8?B?dWFQZnlYVXViOGtob2d6a2xNOHRoT29aTW4vSmxYeEJnSTdwTTRSVFhDNGgy?=
 =?utf-8?B?M3hQRDV3ZjZVM2hyVFR1eGxxeFhzT2JlOSs0N29lQUdTdWZFKy9oZjlmVDI4?=
 =?utf-8?B?MGl6bE9tcGNBQ2tCMG5EcVIya2lFV05aOWpISWhpbzNzZE9UbmdnQzNtMmNQ?=
 =?utf-8?B?NjlGM2poaHZJRkFlY1lBQU0xcDJueDJaMWVLZ3ZlOW9nSEtNNDNPdDdrSi9C?=
 =?utf-8?B?MXp5ZkFveUR6VzlTVGhGSGMwcExoYUZEZEM4RVVWOU85anMySnFUSkdSMldQ?=
 =?utf-8?B?UGhONHZwcU9CK3djU1RVUjFVZXhiRWhYWWVtRGdERDc3NDhjcDI5OFBvMVdJ?=
 =?utf-8?B?SC9ma2VDSjhjb0I0enQzTCtuK3Z6VnlmMG5EUlVFU2VrY3RsZFp5djZvdDFp?=
 =?utf-8?B?ZHlMTm43ZGxJK2ljSHhaQk1zUmZuS1VOaW5lT3lZNHduTmdLd2ZuelhINTBC?=
 =?utf-8?B?aWVFa21ncGlEQ29pVThLNy9vb3M4aXIzdm9HaEdIR0NYY091Z0ZUSGNnM1I4?=
 =?utf-8?B?T0ZsVDd5UXdaQzRMZS9QMWZjSnN5YW9tTWF5TGs4Q3pFbVRvWkpHNFY5WEl4?=
 =?utf-8?B?aUlRL01tYXdaSEwxYUFYRmxMb2xzcG9ZNU5jckZOSmlvbXBML3VjOVRWSTE2?=
 =?utf-8?B?RXJOZjlLbG0waUt2eWg5S2ZrWWV1cjFhK1d2UEZ5eU82RVRWUUgzcmkwaU4y?=
 =?utf-8?B?Qk1RZ2w3eklVeXdMK2FKTWp3NDdXVVVkVVZRcDNCVWZwcFpDL2pSK1BYcTBF?=
 =?utf-8?B?SW1PcGR1YXhvbnFrbUdCaTMzd0RGUldqUjRHMERWWE15bVVVT1B3NkNNN01y?=
 =?utf-8?B?RlRMWVlzWGJzN1ZsUEU4TjIrYzZxTDVGQWkwZ013NU9INjd5YncrcXMxVStV?=
 =?utf-8?B?RXlacTg4L1VnbTdQQ1NYNzlmcU1UbGhmQ1ZCSWVVNjRPYkJCOW81OFVhY1E1?=
 =?utf-8?Q?34iNSrExuO5BdkOSFLGPQMSP1?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa00b2f-8d1d-4813-0f5f-08dc5c829993
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2024 12:58:37.3073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKgHKFXozJV7plJzPQaHKuHl8flk7s2nnH46OIlvglse9l7RAVWDBVaEV/EZMBu7jRZYEwva9c805UOqWNnc5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8645

SolidRun CN9130 SoM is a mostly pin-comptible replacement for Armada 388
SoM used in Clearfog and Clearfog Pro boards.

1. Add new binding for compatible strings closely matching the original.

2. Add device-tree includes for SoM and carrier shared design.

3. Add device-tree for both Clearfog Base and Pro.

While dtbs_check is happy with LED descriptions behind dsa switch,
functionally they require supporting code by Andrew Lunn:
https://lore.kernel.org/r/20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch

NOTICE IN CASE ANYBODY WANTS TO SELF-UPGRADE:
CN9130 SoM has a different footprint from Armada 388 SoM.
Components on the carrier board below the SoM may collide causing
damage, such as on Clearfog Base.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v3:
- picked up acked-by for dt-bindings
- skipped acked-by for dts because additional changes were made:
  - moved legacy netdev aliases to carrier dts
  - fix status property style errors
  - add pinctrl for secondary spi chip-select on mikrobus header (& som)
  - specify spi bus frequency limits for som
- Added CN9131 SolidWAN board
- Link to v2: https://lore.kernel.org/r/20240404-cn9130-som-v2-0-3af2229c7d2d@solid-run.com

Changes in v2:
- rewrote dt bindings dropping unnecessary compatibles
  (Reported-By: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>)
- added bindings for two additional boards (cn9131/9132)
  support planned for the coming weeks, mostly serves
  illustrational purposes, to understand cn913x variants
- cf-pro: add description for LEDs behind DSA switch
- cf-base: add description for LEDs behind PHYs
  (Reported-By: Andrew Lunn <andrew@lunn.ch>)
- Link to v1: https://lore.kernel.org/r/20240321-cn9130-som-v1-0-711127a409ae@solid-run.com

---
Josua Mayer (4):
      dt-bindings: arm64: marvell: add solidrun cn9130 som based boards
      dt-bindings: arm64: marvell: add solidrun cn9132 CEX-7 evaluation board
      arm64: dts: add description for solidrun cn9130 som and clearfog boards
      arm64: dts: add description for solidrun cn9131 solidwan board

 .../bindings/arm/marvell/armada-7k-8k.yaml         |  18 +
 arch/arm64/boot/dts/marvell/Makefile               |   3 +
 arch/arm64/boot/dts/marvell/cn9130-cf-base.dts     | 178 ++++++
 arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts      | 377 ++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-cf.dtsi         | 197 +++++++
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi     | 160 +++++
 arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 653 +++++++++++++++++++++
 7 files changed, 1586 insertions(+)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240318-cn9130-som-848e86acb0ac

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


