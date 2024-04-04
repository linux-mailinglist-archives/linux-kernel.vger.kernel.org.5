Return-Path: <linux-kernel+bounces-131733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25918898B3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C5F28262F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EB712AADF;
	Thu,  4 Apr 2024 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="QxKZba1I"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2108.outbound.protection.outlook.com [40.107.20.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A152129A75;
	Thu,  4 Apr 2024 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244915; cv=fail; b=lYAahn4pD2E1nzhkpX1EohfapA75xqW/En8v5zdnn3ZRoiLzzwd51gfXmFPyAEfqZ5wM7s5X2wOeX3/eYF22zFkpR3lMGgARBk/J3xNCX4U5bTj8v2IOcKt+1g4jdwtZOsGtzS7jLoR1VV9+gRNegiRxnQ+aLm8V5HFo7ulwRjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244915; c=relaxed/simple;
	bh=Y5XO6ZU6k+fUUaz/d0RoTJJfocj8uED2NApej9Olnv0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=EcEVEm7TV6C2cGU4X46V/YnD/+2okXU79lYp1zE8KzW8QdROTWFwoMjmBgMwNdLysoylpbzjffuLbBO+Lab9Mg87pYoqiOw2JJRzKK3pE4uD78TmJM2zXqiGcVQXb8Gw9dfifi1xDmPo9zwpF3ucYYR5NklyoBzz9jsfRMlgrg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=QxKZba1I; arc=fail smtp.client-ip=40.107.20.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfiH7Yt9c0Nm+ues2ddrZ71Kc0iJGZKBXTjQQyWPkAnPK8QlUaDJshFtqemDMwm+ySOmfxU+1I9ds0+Y2Y5DPC+N/g3EYz2T8EH0DKvfY4XAdyXwYunuaOLKw8dI0dyFwRsG/RXMtWtTPFZpIZuaW2xBtMdzIgfPZkJddaibjkY/xzeNa6FqKIDlUX9O6jMCXe8S1z9/cLEoCWmi8BLIWt6yPwiyj2JESZQi6q1AblkhHYI5pQi3VFZm9GpRM2IgrFMPBTKq/JknHRx2eoV3m/GTMhXZl1Bk2SHwYgFwvHRWPtt49Pog28Oz+mpmpdRAog51VQNOr45UK9yM/zQEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqU/zfuVo5qJXLsurm4w/uCfD13xqBgBJYN8aT9DXn0=;
 b=QO5n8ix3sDM46PzoPqEEz+i1TKZmwZxf8QhJsikRYebVQSkOQcqT01o3R6ZyjKBKavqetnvUyBjd4cdiI1UqOO5mqXl7XQ5aaIV7cQEQD/trYonEui8lwHu4eIvk04YqP7rf5b+bnZByRa4Qhcn2xsa6/hRU5LlunVC8QLCe2u9pQDWEq/5WUhEhJvSo2ZOd+9G38urOFYin+y+h/9hoooyfJcWb/pdT6RwMLf2FDRguQxTYcfxC6tDKKYQYOye86ciDhKGTWdmh4f7attGMJKXXKo/rogpXMmW3/G/90uYIv2KpVqtpv5r6vPfv/c/qB+AB2PtE2Gqd/rAz8DkdLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqU/zfuVo5qJXLsurm4w/uCfD13xqBgBJYN8aT9DXn0=;
 b=QxKZba1IOwfHt45LrBG1rEz8ZgIzvk9es31zpr1YrzHf2IgBEiR7nirNcXoKqTXVqxLALrC+GrN0AD5CTgRLiR9liSpSBAzQlEAi1EwsaNLwehZ9Jr7OF4bxdirEywg6jyXWZbqYoh84S38b3dJqM5pB4RHj6BmSwpz+Njh+9yI=
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
Subject: [PATCH v2 0/3] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Date: Thu, 04 Apr 2024 17:35:04 +0200
Message-Id: <20240404-cn9130-som-v2-0-3af2229c7d2d@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKjIDmYC/03MQQ6CMBCF4auQWTumU4gUV97DsKhllEmkJa0SD
 endrcSFy/8l71shcRROcKxWiLxIkuBL6F0FbrT+xihDadBKN6omg853VCtMYULTGDYH6y7KOii
 HOfJVXht27kuPkh4hvjd7oe/6YzT9MwuhwpaIdGsb1Vk+pXCXAePT712YoM85fwAXZ5X4qAAAA
 A==
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
	XwU9KUDTjpvpjHwA9TyDXdRZRe6CQIKdZtmDSvn1EJY8mz7+sKnNlMg9QZ9G5gq0ZBBvmeOB/R/4ao/w5WGL2PF+sM1X7Hb3IQVxnAhzMFONq+TxzB2A5wM0t89nZSbqezpI1JtkE67hmZEFpojAIQyqdB2gRAmGI3UTK15tUQrPf4EF3ccboFNiP7ZUWa/v1/nz2A392SvvT+OKP52wzJ5d8br8BSHK+1uqahVA9L64br+jqSX4+LCXlzHYAE4eOGF18aYfG4Br6IpBzWARS9D59cgF0QhtBsUuJhwS9MBOikoZMD+SJ8nS0EwC9FdXSpNOy7XTUPZ/9CsHfHo1MIhXrhUUJChdnK6lGq+QWGWiIeAxn+ge60lu6mCd2tU2/qPj69Edk5h7grM0h9V5yc/ymQdJ5vlIHbFlMsyr//V1sVlQoV/Ua/5rrQW4tnYn4NY8DNi2fU7oqEmVfsSGK7fnkaI0ROjkdc3INCcJkPCZuisfm+TEjMIK1gpFgoXUyROu5AxD+M9HaaldvDlcJb4sw+Do/ELChBd0n4TqBmOyz5RKaKOU/7epnIU0lSlU1fAUIFk9smHp2ygRAvOBqH8eMptLHICILbCB+KPJH+HZUCQ+y9/BzQJ3p1aIpgnPOwVMci0vvDYUP0fnFGbbIHOwU9gbsGy7S00Y42FU9C8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0l4TW5HUjVXWERaM2dDaFRKUWFNT3dSeC9UOE1SR3UydnNWU05TVitPYkhF?=
 =?utf-8?B?NXVjTnNHdVBqenFoSzltYnk4T3pHZ0RQOXRsZFFGcWpoK3FGZjRLMUpQNGZn?=
 =?utf-8?B?Vk1OTUlldTM2WWF3NWo2QmZLUDNvNXRQSmNpZ21DTHQ1NTFSN3J6b1MrWnFi?=
 =?utf-8?B?VjRVeXM5V2p3TlNJY1M0YkIwTWptV0RxdCs2cFNSTy9rRmZUK29KMUpJZkp1?=
 =?utf-8?B?ZXZyZE05bFNsckFGMERFVndzcDZtblJUQ05EMGpCODFxYkNIVlQ5WFJxZUlF?=
 =?utf-8?B?STZUQVp6akMrQ3lBRmd5Y2VmV0hTcW5QTDU4OVpTSC9TMFVFcENUeGJhODd0?=
 =?utf-8?B?ak5kNzJPeERPcFN2Snpicm1VcTI5ZHRlRmdzUFpkTGRZS3BXZm9lVTRwWkZ6?=
 =?utf-8?B?OGNnYTVESzQwNHpyY2FtbGFHU01EZkJxdGdpR3VWdWttTXFwNkZtakVGOTJ0?=
 =?utf-8?B?aHlXNURWTGZQVURkUWYrVHJ1UzFtQ3B6cGVBS2ZOcnhxYU5WUEtCaE5WckRB?=
 =?utf-8?B?c2VpbzdPS1V0ZFBJL3Q4U3dUaVljNWp4SVVLSkN3RExSNGVjMElLbUg2UnlT?=
 =?utf-8?B?SG1aVVVSUnBta0tmOUlLdWNwR3E5bkxzUkpFVWswc29iRlRwMnNXczVaazl5?=
 =?utf-8?B?WFVEa1gxVndvZTF5RE5ZVFgxeUVHWjNHZGlXZVVJeXhQQnN1dHFUWHJuSGxm?=
 =?utf-8?B?SzNkakxNL0g2U2svcWZtdVN6eVpTS3E4SXNUbk9qcFQyZ0RWY2hXK21mNklD?=
 =?utf-8?B?NGtJWXRxVGVqQ0F2dThpVzRvdVB4VXdwdTJlUzVNMmZab1pNaFBBVFlDVjRQ?=
 =?utf-8?B?WFVqYXYyTUJSNHVDdE1NWWIvSk5udldGYjJSQnNQVWlvWUpiRVVGV1ZmL1cx?=
 =?utf-8?B?TWI2YzRDVERZaEhwTzdrb3ZQMk9xUlUvRDN5dkNWZ0tHREhpWnlKRWZjSlZB?=
 =?utf-8?B?VkhOM0ZNYm94YTF6REVuVVQvUW1kWlVyN0tyRVFaWTcyT25SSjhrZXlJeENU?=
 =?utf-8?B?RkI2Lzl3eHM1VEswMk5iNFBldytMMzVnNVNSVjZnRHVCRGdDSXdsei9BZStE?=
 =?utf-8?B?WXBUNXBuMStHcnIvbGVKcXU3YWh3OGNsQWZZRFRlUWRGRkZLU2lYbmQxOGJ5?=
 =?utf-8?B?UGxtUGVSUnM5QkVrOEF3eHkvUS9iUVBzc1BoWjFEY1J0M21nNk5SaVdBSENX?=
 =?utf-8?B?M1h0L2lET0tnSEpteFJaLytZWjh5NmdZYm5xMkVZYUd0K2pJTzdKeGgwS3E2?=
 =?utf-8?B?eXRhaVNPdG5yME5qOG51QXdTazdvMjZTN3R4Zm5TTHV1dnBqd0pmWkt2Ym5F?=
 =?utf-8?B?d0ZPK2IzSnZPRGRYZkpGK2xmTEFRcFNFZGd1Zll4THNyMTNydSs5TGQ1UHJw?=
 =?utf-8?B?c24zQ05zM0JvLzh0WUEvUWpDYXhycVhNT0hWTVppc0NjU1k0L2VpMElnOUxB?=
 =?utf-8?B?RXoyQVRtM0RENC9oVmJENG51ZEZjcTJuSEQ1TVdXNFVkSjFvQTFlRkhEbEsr?=
 =?utf-8?B?TTVlbkwrem9Pc2ZSNkYxa1ptMWZlano2eDNPVnVHc3hORjF1WGREaCtIZlQx?=
 =?utf-8?B?bWFld2dQckpTVDVYUFBPV1VTakNzMWIxd3l3V0FYNHVZMWVCQndiTk1pWkpT?=
 =?utf-8?B?UGlSd0xUVUVkRk1NMThjQTZPWXY3dFQ0bG81ZUd5eHFEZWxaZDg3VTRPRnFm?=
 =?utf-8?B?aFBzeVByblBtRmpaWlBMYm1uMGROUXZhcUMxbkFPdThsQXBYVWxQdUhpbU1v?=
 =?utf-8?B?bXBjZ1ZvVXhJT2x6YXYvMWo4YnBicWtNN3hNMWlwK211bUxCTEFydCtGVWl5?=
 =?utf-8?B?Q1ZxNEM4ZjVWUmV2UGdIS0hXRnRUaGpIcCtwcDJiN3VnOFFkNjFNTDZwczM1?=
 =?utf-8?B?UTNPRFJiUmpBc3FRN1ZuU2NaVVE5eWswcStlR0pLdzQxWkI4YWJpdTJZTFN5?=
 =?utf-8?B?ZjA3ZEczTTZsTmQ4UG1Zd0hMS3U2b1RvbGJtZDZjT0RzMHhvaExjVjl3UnVD?=
 =?utf-8?B?Mnl1RENOd21oSE9HT3FTdG4vck1YZEdweDF2MU10NHpYYUtKK3BhTXVqTGVC?=
 =?utf-8?B?SWtSRjFBazhTb3F5Q2cxSzJhMDkveDNlL2lJdGgvWEFIVGRUbk5WZE1tM0hj?=
 =?utf-8?Q?epEPDdXCqH3hZa7DheAIDldRl?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d75cbb-e928-4597-6064-08dc54bccf83
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:35:09.2828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3LZEDhygoy0sL9XIMAxjdzK+UakZUhtkyxTa9d1dvciNjMvokB5hR/b+SybmvgdD2Ey00+G91aAdmB9XYfkdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7871

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
Josua Mayer (3):
      dt-bindings: arm64: marvell: add solidrun cn9130 som based boards
      dt-bindings: arm64: marvell: add solidrun cn9132 CEX-7 evaluation board
      arm64: dts: add description for solidrun cn9130 som and clearfog boards

 .../bindings/arm/marvell/armada-7k-8k.yaml         |  18 +
 arch/arm64/boot/dts/marvell/Makefile               |   2 +
 arch/arm64/boot/dts/marvell/cn9130-cf-base.dts     | 178 ++++++++++
 arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts      | 367 +++++++++++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-cf.dtsi         | 193 +++++++++++
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi     | 159 +++++++++
 6 files changed, 917 insertions(+)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240318-cn9130-som-848e86acb0ac

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


