Return-Path: <linux-kernel+bounces-111653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD03F886F18
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6386E285E68
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C604AEFA;
	Fri, 22 Mar 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VOpoZ8Sr"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2084.outbound.protection.outlook.com [40.107.104.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA6B4D5AA;
	Fri, 22 Mar 2024 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119186; cv=fail; b=MtYkPw8c/sQBZRy5VxpeUa8ZgBw8O5B1W3DWwKlO7grKN6q+MSiwmEVR5A7N1CydqJZVNlpARh9STRjyAdjyL61Olp7GuGzCDBJxjuh+kLxrLJZ1Iltf52er7d9LUxfCMIapHlN/4tSdiE6oQsP8YR/Z8n3aLMLqUdyA3Vx7eaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119186; c=relaxed/simple;
	bh=rq2iBemUr3M9RU3hjXisPK+jeILsO2RdvU+zpybADbg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pVBPQ3UdM6RZQE4p2fTWJOv41sjg6M3QNJ8ZDK/dVD7Kl3qUaGJP6IGsVqI8iSlEAYjsg99c13EJvnGv4dDbGkQu4OerjccLgeCG1Hl2f3755B7ZUuZbNjP4azMKx3ga5IbA0E6sekkJxqpmuKh4JrEuQeZsXlhXuasuEloDv+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VOpoZ8Sr; arc=fail smtp.client-ip=40.107.104.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxkZvaB3+HSUfkD6JFNvodgeLdDrqplWUTKxlXrq73P161f8ZWOaWvEIxhWopQr673+hBSoE/agiwc53EsK5q6geo+hwETmKxCiEx3thbwvrjMVDie/yZkJDK+ZZ3pqxMl8VGr+Jx4Dq2xaqeLNzIkc701o1j5X5zSFtd5D92uzRZ+RWSPoeaq/Fs5K8odNGw9olRXsSJ3DAtBrTTkiXIMLnmftxlI7/5jwgO5vng5J7rB6fKYSADr7XAD/QjMLXGB4CN7/derF5YC1r9vovqO+pwaBbf/2shxP8u61RM3+L6czeJOfFTx6k8mQUaJGTBfghs7Z3N+aJly8cXvOsyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rq2iBemUr3M9RU3hjXisPK+jeILsO2RdvU+zpybADbg=;
 b=cLNu4ehJgHduxS3QsFEk2RH3uhqy2WjP6Xh0xkqgWYeypMFfZxr5TRwxS4isZeT1ADwZhmpwQnu5ku4Zp9xMSSdV1aa4ycZY0Sj+IkD36DEuu2ri0wtEEuZjTiuI0JyPHCktO1Kh5Zse7C5dwLLBWXhBqmu6qEb7OX6DoBRzBlhuuyIf5F4bAWXFAdXqK0hkQh3c9tx8rQDVvadRAlgg1eoPrcWGtXDClxzXX1yTim4FeRrfmhAJlktamavidms6Gqgm/r1e9tWljpnR8uEJuvgkXAtjefvDHkCHHYSdo6/j6N9dlWqUE5oqTqEnR5PAg8RVHBmYtjIqda4oYC2Y/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rq2iBemUr3M9RU3hjXisPK+jeILsO2RdvU+zpybADbg=;
 b=VOpoZ8SrCel1ARqIt/4+v09Gy0OAANN/H782vb2jRDJkHQeQKMKqP7Q7L2BmRM7tdJOqrFJ+7KdzXGTGzBgyFs0uaAqXaUA2alfo/8jDElYQz0wIFR2+kRCWIlz6av63WDhsE5I/IEfrVcmdpDOkK8Uwdp1e3I8MOUBFZmAb8WI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by AM9PR04MB8937.eurprd04.prod.outlook.com (2603:10a6:20b:408::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Fri, 22 Mar
 2024 14:53:01 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed%4]) with mapi id 15.20.7386.030; Fri, 22 Mar 2024
 14:53:01 +0000
Message-ID: <52b6976d-2903-4480-b171-fa16b99bc88e@oss.nxp.com>
Date: Fri, 22 Mar 2024 16:52:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: S32G3: Introduce device tree for
 S32G-VNP-RDB3
Content-Language: en-US
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Chester Lin <chester62515@gmail.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Matthias Brugger <mbrugger@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Marek Vasut <marex@denx.de>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Matthias Schiffer <matthias.schiffer@tq-group.com>,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
References: <20240321154108.146223-1-wafgo01@gmail.com>
 <20240321154108.146223-5-wafgo01@gmail.com>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20240321154108.146223-5-wafgo01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0116.eurprd09.prod.outlook.com
 (2603:10a6:803:78::39) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|AM9PR04MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: d52880dd-d348-4d33-3dae-08dc4a7fc503
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 vJOGFSawORG7d5hUrBfH14zZYgF6T0Jwq+D8rgmCHZ8is5p+oc3GbIjwJoIz+keQHyl/fKVD1eu4TX1uA9km8i+XblMQO8gwVrqtVfwFAheNKjuHaicyHGO7E1iM2poijnrS8vGGWjgIcwK1E1nmIAmysBsGlXEPP0WLQbr5DxCDtzbIxSBKenZVxDlSaBnothGwnEp6aOKfpE5mN/wXosA4HWy/j+jXI5pjqESgGGv/pcEFMjDspWOaK1+1X8t2Ko9YOP+tPKINKSVtSr++Q2k0e11WbCoU/t748vWMYHV9Ycu01GW87ZvNF77ASj6wPTaUv5scsVeHnlow9r+6YxlNUSrA3PIWMDNG1ZuJoh1nSyKwR73+OeFR3G0FCBL5Lhmewc/aPqIWzNXI7s3GtzVo8914a+DyeVnPq8g30uyoTiLZ8KG3YNoBy7o1ZCriRlNrianf3EkRTZYf54RSV44QYcksGHlPgJVTeroiSAU83RmZAfTsZMQDIVODthSqPN6B9FVn2W3Qm+NX49rVO8WuLHBBiDxn1D9jKnJWVklibfWFodztSIPjRGmC+8a1Vz4fnDXJOY93WXZ03R77a2Z0Ly3X/1hdtpdHPYyjWHE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?T1JOTXptVEFta0tjM0dRZUZUYk5GcXNva3ltNkowVWlkRk0yY2J6Q1QwZ2Ny?=
 =?utf-8?B?WHJaLzYyNG5BWDlxMGxxWnRyalp1SGlHS05xazV4emtQZXczRkw1aVZCS3BM?=
 =?utf-8?B?TG1jd1A0UUllRDJ0OVdNakNxSTBVN0xyZDNqcGh5V0JjM28wb3Y5enEwclU5?=
 =?utf-8?B?aVFCcW9mTEFBdDZEcmFFdGFrVzhZVkdMVE1PTXRaL3Y5b0xsKy82b3Z4THRE?=
 =?utf-8?B?djJYMHNybWlOLzRWaGRYbXk1VkRzVVZwVnNKcG5MWWdydnkxZ0g3amUzU0Y1?=
 =?utf-8?B?bnZzSGNOaHhXTVBlSkNXRVlSSzhwWkJad0czeEtYS0JOVG13dzJUV3BpelFS?=
 =?utf-8?B?SUdIR0pVclF4alBXNWU5R0tEQnJ1WFNsNFBBL2daQ2t0dnB4YkxmbTRudm5r?=
 =?utf-8?B?TlVGckVhd1VseU1iTDlzTlo3Q2d6VXEzRFcvTjBpRnJqb3NDeHlkY0JSRTl6?=
 =?utf-8?B?Sks3MVVvYnFYdEhtK2duK0oxREdwQklRYTRLVW1zL2xPZkN1cUM0NTFVazRq?=
 =?utf-8?B?dzJYaGo2T2JtUzAzYmpBeFlBZFluSkRZaVFKbUswUVp5S05KZ2dZN2IwTjR2?=
 =?utf-8?B?QWZBNkdVUVhsSlB6Zklhekg1dVUwZnlPTDBkcmJyK21DSWhic2VLdlNCcVVy?=
 =?utf-8?B?aWZpL0k2Zk9Sb0pwN2pqQzc5b0UvSjJMNDc4SlRhSzgzeFlCZnRKbjlOejYz?=
 =?utf-8?B?QnJQOGdNSEM3L2poanovdnNYUGE0S1V2ZlFTV2dBUVNBYTJPaEpDRGs1NEY0?=
 =?utf-8?B?cHNiYjlVOGZOcUhtbTVMS1o3QWY4TnBtbjRpd09pQ0lvMWxxZmtkSDdYb2lX?=
 =?utf-8?B?RC9YelBoQ0NrQXA1WWFQNjU4MGNQMjA3K2c4cjM2cVpNUlA0TDRtYlNxR0Ix?=
 =?utf-8?B?MWNXaGRySnJrc2ptRWVSZkxrWStjUXd2cUxJU21SUW1WQVo4VVNDM21MT2hy?=
 =?utf-8?B?dWNjTnJkODV5ajVuWjFXeFlqZXVFWElsa1BsR3RsY004d01IY2hmbTlOK1Ur?=
 =?utf-8?B?YzRmMEdlQjE3ajNsTzJSRzg5VUM0R1JBR3FrNTlGWWFiMUdxdk40UEo0UjYy?=
 =?utf-8?B?Sm1mN2NwWW5Rbi93bU9WNUE0WmQ4TGZROVNjWVZNei9GSWkvS2N0SmIvNG5x?=
 =?utf-8?B?RjhWSzVta0Q3NXg2QlZid0lET1NtWlJmM2x0TkVqWStubnYvMUpjR01KSE9k?=
 =?utf-8?B?MFdBQVp0dGhZM0JkL3BzTGRYK09xYjE1VkoyU1diTWlEUVNkbGIxQ2NMZ3R5?=
 =?utf-8?B?WG4yQndVYkZQN1FBanhYdXVQeWpiMXRpN2tHY3NFUUl3d3JMaGRVWE91b3R1?=
 =?utf-8?B?Q1I4ZFlOZkh2M1E1SzJQMHkvYU81dy94RzNiWENPMk1vS2hWV1BtTU1BSXZr?=
 =?utf-8?B?K1B4OG5ac0hLb3g1WmJiMEZsV0xBOGhNMEJpbUgyZ1pSTDBlTHg5ZVFwRFlw?=
 =?utf-8?B?YlBKZ2VCVGdVcWsvaWVEVlBPaE9TaHBlbCsyekhyZDM2VEVjQnUzL2JhbTNP?=
 =?utf-8?B?MkRKTzRkbFFNOG81Y2JLNDFsYzYycDlRdkt3c2pNOGozbHFuc3ZYY3Z3NDh2?=
 =?utf-8?B?c3RtZ0ZhQ3pZNmliNSswWFRHSnd5Umx6NmFGdGtpalpEQWZiZ2Z1MGIrdHd1?=
 =?utf-8?B?R2tkaXpGMHR0ekp0dzZKRDlyd3BZR1ZTR2NYSTBvRFlrVVF0SmpWYXpuYWZl?=
 =?utf-8?B?aGZuRVJHMUhXQk1mMWpvRUtndWkwUlNVQVc5em95Yk9aazNkb1VwOXJkQVMx?=
 =?utf-8?B?cTc2ODh4dndrWFlCb0hWOXJ1WHlPOTNqd1hZMmdEOS9Xb1I3a0xzL1ZmNlgv?=
 =?utf-8?B?U0ZlRGVHeTNxSTlSWGVNcmh6OWJYNE5Xb25oY21mcWNQekpSVm5IVWdMbnNa?=
 =?utf-8?B?UHJtRTJ6Qy9IUmM0VjJGRytXZGZkYUliY1JXajFVM2pvUXZLaGttYmNkMG9l?=
 =?utf-8?B?d1JNbTVoZTJhbzlrQ3Y0TFJpcUtGRmhNUytFWWVhUWZsUkRTSGszcmpoQWd2?=
 =?utf-8?B?ZlVseUJjVGtjczQwQzhRTzNOZkxNY00xeFFvM3BUYmZQclZJUnYreTdmL3lJ?=
 =?utf-8?B?ZkxlVllzUnk0NVNnemhZcjUxcDhvRWJ4OTNhdVNhQ3BzSHkxQitrQm80UWpu?=
 =?utf-8?B?ZWwwZkJoQnB5ak92NFFvaUNvUktoQ2U3NVNFb3VCcTEySitpRFRRYXVKbUMx?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52880dd-d348-4d33-3dae-08dc4a7fc503
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 14:53:01.1510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJ6Gq9s6T38eonPKztTvpKzPi07c9fsQ017ZeVjtq3HQuYmf+1CgPsRlNhHHKgr53zkU0Tth7pR4H6RJ6WuKVeDdKw/TlQ8af3ZRN5r49DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8937

On 3/21/24 17:41, Wadim Mueller wrote:
> +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> @@ -0,0 +1,237 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Please use the dual license model (GPL-2.0+ OR BSD-3-Clause) for device
tree files, as the TF-A version of these files [0] already uses this
license. Using a consistent license is needed to keep files in sync
between upstream versions of Linux and TF-A for S32G in the future.

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

This paragraph is already implied by the SPDX tag.

> + *
> + */> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +/ {

Missing empty line here between header include and '{'?

[0]
https://github.com/nxp-auto-linux/arm-trusted-firmware/blob/release/bsp39.0-2.5/fdts/s32g3.dtsi#L1

Regards,
Ghennadi


