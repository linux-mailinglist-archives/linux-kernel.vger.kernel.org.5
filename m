Return-Path: <linux-kernel+bounces-131732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5433898B37
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E38282F2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A1B129E7C;
	Thu,  4 Apr 2024 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="am9IRVyk"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2108.outbound.protection.outlook.com [40.107.20.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D9B6E615;
	Thu,  4 Apr 2024 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244914; cv=fail; b=pBXlB2qhmrpUkyOJZ6VviQgI21dxIyhGqDUis+e0sFuth2xEWSPQynbpeMyXUy3xvxaHqOQAWQjP7NTPGzbe9Aa0yzZ+Wc3fffoSJAyBoSDdBCYHc3X7eqghJhHy3Lzw9AuqcMaeo55y7qNnjLZIsQwtI9uC3ypldLwb1rPUVU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244914; c=relaxed/simple;
	bh=NEs3N1qMsT9syBsbLXC9DrxxuUEmeW79CJVhnL0mz+Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PBMKbxLJOQun+QT3jATPqfMiYd8p/mja2r3/IvCMHtJW93f50/buQjQH6b0t1eZpNz42dKLDNN3jkN+HronAdQK3ptLkCYnlF2tL52osbfGqOhdCOze2QwLojH1RoH4XP6r97Xl9VtccUVhNzRDpCu4wZXb5YOyxGfy2BLH2lOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=am9IRVyk; arc=fail smtp.client-ip=40.107.20.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BX4cz3zLGaZmFOL2wF/nFqQ6cNaLfwwdccmgDEiSgpdjBUVA2BIYutNm8eMysfAaw7WsCCCQkj6a/rV8VEIzpaEiXGZmkzI6WSdKyzrO0nN/9vYuVaoEz8Jy3XZY4LdfnO4y0jrWH9eXPZ9ZldBSXx+KQwFZ0Fuom1xZ60KdrXap33IhhN5F/2Rre2DHqK2NoL9uKytK4817ZFaYYoVDW6dOViFgpJmifIfeDY1uIFeg+MI/7nenI+6ryIejFPw+tyJfylL6f4oOsmc71ziT1hgxssinaByn+mUbxAS8DYl/hlRVi8mcm4F6epgOQi1K86dZlJfjr6VOZCcGLv6tIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6x6EOIUwDJ1P1ZCfZWg1ji8oxS9Yeec7E0tRwP/l7tU=;
 b=A4rpRJ1sWZmQ7ibIkYefM1umzQcav6tZBiLKm84wyady3C8E6NFteY3Rgur2yQJj1k7yVSfk8JAWhcQOKqR7arurzg/ppadS2L7FvhP4JDiMI7fF6GT0wPONueVtJ0un4mIxsxs95DGByR2PfstikCMjTMJpjXdxUXefFB5MCik38BX5XkBqf+9TqGpjHVwkuQnwXqN9RCY+X8HsCfE8M9AOcA56GPRxestl/+YVxGnUCds/UJaH4oK0VwV6zsYC9jTgDwZJ03bJ9lJCAcvW6AEgfjLZulFbY7EUlmhfU9HW8NWV4ccOJhuRi1bEgeRWQm4ZGkapNnYlwfCxqvgYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x6EOIUwDJ1P1ZCfZWg1ji8oxS9Yeec7E0tRwP/l7tU=;
 b=am9IRVykrVnSEXdVTLwDRProdxpfYjROXo8a2s0HzngYifGI5a8vRZ5Vj7OBrIsKy39r6EzMp23+0jEEYyqQKI4Apj9E8VPXOEey+5fYW2Ee7Fs61iNK+DUZ/VpM8rQnDpZWDCAeRAo6RiO/hxz3b98R/+uSUmh0W/s54uplXM0=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PA4PR04MB7871.eurprd04.prod.outlook.com (2603:10a6:102:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.27; Thu, 4 Apr
 2024 15:35:09 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 15:35:09 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 04 Apr 2024 17:35:05 +0200
Subject: [PATCH v2 1/3] dt-bindings: arm64: marvell: add solidrun cn9130
 som based boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-cn9130-som-v2-1-3af2229c7d2d@solid-run.com>
References: <20240404-cn9130-som-v2-0-3af2229c7d2d@solid-run.com>
In-Reply-To: <20240404-cn9130-som-v2-0-3af2229c7d2d@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::19) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|PA4PR04MB7871:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6PTbduBfrFV7EuHH7YjluPMJFSdEC8HvBDxXMXKtP0oFgP5vYnqgcGoQCMKfKRzQRFsSmg6PBk14+JS+aOj6/HOpuHftabCRgYUDNsF/bZdkGlq3DbQ1qE/q69663x90lUcJ/nexZURdLB9uZQVPCgPW+sGNLR0nR3z9UiQy+tnKoqSWLqLhup6UADIRfHfLe/9ZvADH3RnYl0PGx7dEZhKko8/LFsAAtMkp/KJEgWKoQTCku0Jhb/JZoxYTfYBdPd5V41KTG8+oypySVpallfgD39iKikvtaFE8g51pS8B/jZCOwSb30/LZGRPsl9AQAr3/jjnqhXD0ZhiE7XcpRl+JZiKx6uM5S9Qu2C8aHm0MsWm0vWLoYwtq8L4SjBOgRlOiqxFbD1VWQ80IhRCT9HN1UatXy/mNWLLOJK6q4qsQ/EEmfqL0L0K1QsyKxdP1SC8LcXvHPTWTyQXQgk6EziEmWorjKpjXVz+p9Ldp07CaWIFrPkt9Bty4wcv0hxorC0igU8CPUb0MQqE4EGDHD+fPN8ooMvfF9tIg5vDtP+Zk7HuTwUxCOaq9VfSt12Y+IXHi5f3+QK9ggJLlbt/OXQA4avbOzIkWlv4GiRTWsj9u3IWel441q0W8BCmG8Ou87lkCho+M+zYhb0UkGcNE27fFqnHAA7HqOEpgG7Il6Dl3qM2R68rfyeSeWqx6JIEynHa3ZB6DpygJVqDP+3YdAg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXFKMFZvN3V1TTFZS3BpYlQzdE5XSXZYd3FUaU4wM3JFUTY1WGlTUy90RUMz?=
 =?utf-8?B?S1JMVGpFSllMYUJ1Vm9kbG1RSTRqaUhnQitHZklOb2tMSm0wN1FxVDhaUER0?=
 =?utf-8?B?OHRlY01LcFdLWjVOQjQ2WGEvSm9MZWw0em14cGlJd3RDTnlqQ0tNeDVVMllw?=
 =?utf-8?B?UjVWN1AwS3VydUdmRG9BVklGODhvRFdlUFo4U2RrM211MFNmWGxxWEtBcmZh?=
 =?utf-8?B?aytQZDZtQW8xTUZpcCtHUXFNTjYza3NCbW5wT0RFbmFRVU91akxXeEIyRStG?=
 =?utf-8?B?Nk5jOXY2bW9Dd1F0dEF2SFBXb0dsTWNUaW1jNVYxN05DK1k1TE4yMHJFazZp?=
 =?utf-8?B?dDRRU3Zsb00wTmpsSll2YVViOE5pV0NqKzJ1NmpDN1BZZ1hvc28vY0hCVGJl?=
 =?utf-8?B?Uk5jRzZ5cTVCZjd0REpadW5Pb2U5N1ZqNmtsV1llYVpjTGVoT29kc0RaTUZ0?=
 =?utf-8?B?SXRwampGVnc4SytuaEZxOGpULzhwY1JHSzYraUtEelErTmF3RWJZMjNuZDJa?=
 =?utf-8?B?eTdhU2o1bUxPeGJaTTNHdXV2K2pYUVpSRU1DUG9sVDhyQzlkd0YxU2w2WCs0?=
 =?utf-8?B?ZHlXTXdyLzZVK29Oc0VCM2FNbVB3dHpNMVpGeGtkd1QvK25pK3pUYzRlMG1M?=
 =?utf-8?B?bzFaWVhJMjk1WnEvZzE3RjBwbHFvNTNNaDhLVjA0OUQySFhKSlRiUzF5RHFs?=
 =?utf-8?B?cW01ZldheUwzdGpVaXhzZG1PYjlQUkd1ZlpmRmtwMVFnK1krTnBsRytNM1Vl?=
 =?utf-8?B?L0o4L2N1S3BXR1lKMkwxWmo2a1NoMTJtbHZWdERUQktoUWMvd050TUdMM3Zv?=
 =?utf-8?B?STlkeE5obUdGUlkwU3kzTkJkZHFRcXQrYnZuZjZEQSttbFAvRjZpbS9lcGRw?=
 =?utf-8?B?MUQ3bVRyNTdHUDY3Q3UwSk9hbkRrTkc4WXVvUVJ2UzFKQWhyVEVpZXJpd2NY?=
 =?utf-8?B?eTJXUDB2NXJBNWZBNTBYbFJiOGpRaGxKcEU2a1poS3l3ZWNWUUxyVmpiZjdM?=
 =?utf-8?B?dm5rQ2hobHVBU0JyVG5NWDd2Sm11UDlqTW1GcmJERytJRFAxTy9GaHFPRHJQ?=
 =?utf-8?B?TWwzM0lZOW1BbldFdXVCL2VCZlpiOUwxRkViVTZCVGlmWW9Cb2gyYldaMnJL?=
 =?utf-8?B?Nkp0dHpvNEFmWmRreXpxcUtaS2VuM09zRHdiUFdVd3hPY3EvWHdtOWR4ZG9x?=
 =?utf-8?B?OU1mZk5BbzFmZWE3bzJIL0Vyc3ZCMUZ4amJIdzI2SkdUUHgzVGdhL3dWVm1k?=
 =?utf-8?B?VlBrcHZoOGx1VDZiTnp4ZTVUQzJzdFc5T21VY1RPYjJJUUJQbFlVVWNTd21u?=
 =?utf-8?B?VWsrdjdMSGFXNVFTeW5iQXc5UnBIekdXcWxZRVFnTUM3MzJUbXZpd3pwZUZt?=
 =?utf-8?B?bmc0anVGQ1VzMGdGZmM2Y2FBVmRXamRzSitQa0ZZN2xUdCtmR3RCeG0vSlVN?=
 =?utf-8?B?NEI1czJiVmQ3N1QvcnhZelM2RkNBbThyL2RYWXljM1JVL2Urbk9GNVA1VG9q?=
 =?utf-8?B?c3A2cHgzM3VNRjg2TUZ5MURFQlg0QXdjcVpYU0Q1MzlCSE02ZkxEL3dKZDBq?=
 =?utf-8?B?dm5RUFRLS0pHcVlNNWxJUitPM0pTWk9zLzBjM1dpMU93R2gzd2ovNUZrb2RZ?=
 =?utf-8?B?RW1LODRFVWUxT204VmFWNXhJYnRUYm9NVlRrTEJsVGpYQVVuenYzRFlYblN2?=
 =?utf-8?B?SDZuNDB5UWMxNnMrZGZyaTFTL2RSeS9wRXVKWExyTnVLc3ExZ3ppOGJoL3pp?=
 =?utf-8?B?OFcwSkQydE5CQTlkaVdHSmdZUWpxSytBRDNYS2hnU01TTythT2VBeG9pc2hK?=
 =?utf-8?B?YnpEc1NseWZGL01MQytqMWVCbG1YMTJEb2VaNnFhQW1sTllST0c4T0NLNWhJ?=
 =?utf-8?B?dDV4ZXdaUG1IbzVhZkczRmhGUzBCdnBxQnk2enlONnk3R3BRWTNYeTlXRkw3?=
 =?utf-8?B?U3hNei9uZ09rYTlyNTcxa29kWnRqNFRqeVZTcSt4MVRvWDRteEtqa1pua2Y4?=
 =?utf-8?B?RnYwNHdWc21yNGZOamFGcFM4SFp6YjRGOFlwUjRRbHlCYU9rcUMyMiszM056?=
 =?utf-8?B?NXE4MlZZaG9DcE8yYUhBa2xJMGtCTVhOcW9iNmUyVXZZQldWZTZPYXkwa1Za?=
 =?utf-8?Q?66v/uyp1obpn9NPZDuemF7miS?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee7af65-ab74-4f00-0ae1-08dc54bccfcc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:35:09.7706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uAusMK346ujP6a2wns7LCL80GqbMaMrCbp0Ip3KTsYfaGqvw2QQjjbXDlqeRarz76eWeesjOYODzcDlFf3fQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7871

Add bindings for SolidRun boards based on CN9130 SoM.

Three boards are added in total:
- Clearfog Base
- Clearfog Pro
- SolidWAN
The Clearfog boards are identical to the older Armada 388 based boards,
upgraded with a new SoM and SoC.
However the feature set and performance characteristics are different,
therefore compatible strings from armada 388 versions are not included.

SolidWAN uses the same SoM adding a southbridge on the carrier.

Since 2019 there are bindings in-tree for two boards based on cn9130 and
9131. These are extremely verbose by listing cn9132, cn9131, cn9130,
ap807-quad, ap807 for the SoC alone.
CN9130 SoC combines an application processor (ap807) and a
communication processor (cp115) in a single package.

The communication processor (short CP) is also available separately as a
southbridge. It only functions in combination with the CN9130 SoC.
Complete systems adding one or two southbridges are by convention called
CN9131 and CN9132 respectively.
Despite different naming all systems are built around the same SoC.
Therefore marvell,cn9131 and marvell,cn9132 can be omitted. The number
of CPs is part of a board's BoM and can be reflected in the board
compatible string instead.

Existing bindings also describe cn9130 as a specialisation of
ap807-quad. Usually board-level compatibles stop at the SoC without
going into silicon versions or individual dies.
There is no programming model at this layer, and in particular not for
parts of an SoC. Therefore the ap compatibles can also be omitted.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../devicetree/bindings/arm/marvell/armada-7k-8k.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
index 16d2e132d3d1..74d935ea279c 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
@@ -82,4 +82,14 @@ properties:
           - const: marvell,armada-ap807-quad
           - const: marvell,armada-ap807
 
+      - description:
+          SolidRun CN9130 SoM based single-board computers
+        items:
+          - enum:
+              - solidrun,cn9130-clearfog-base
+              - solidrun,cn9130-clearfog-pro
+              - solidrun,cn9131-solidwan
+          - const: solidrun,cn9130-sr-som
+          - const: marvell,cn9130
+
 additionalProperties: true

-- 
2.35.3


