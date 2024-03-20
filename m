Return-Path: <linux-kernel+bounces-108518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4093880B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4E81C22766
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217671EA90;
	Wed, 20 Mar 2024 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fOymCCUT"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1BE2232A;
	Wed, 20 Mar 2024 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918028; cv=fail; b=r8ZiXPKxw5wIzucO4zp/miVliZELqA2B2qqJGkIkKJS6G7HLRjNEX8K+FIZ8UPQh+F86Lubrw2k17E9UzM9C2IaFzBBb9ZOjFBvkyOg3Bovi421/JhGkEysPOsCTVaPKgMf92e4g9ve9srrlKaXjJypBhz5pFJlMQuhx9rl70p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918028; c=relaxed/simple;
	bh=hln/P38/D+so1UIuTUWjxkKUs4+l+r/aRANx4aZY4AU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pp+7Lqf9RX5/78cgRSzQTsFiiC/jMK5eanGNanSkf+BROOH9eolPuUlf6PXehRCOE3yv66Vn1D949s/jiEyQ0ysDFKzvquUZH/XbnTLwZm61gboxiipQMBVmF4fU2lsyoucrJS9XCj6KUx0fnd7DcWv8Ynv1ctgVMiFaElbndLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fOymCCUT; arc=fail smtp.client-ip=40.107.20.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iq+nQxc/ISanlKeL/SShCIFTFG7xi2NYB0Yq7AG1JJHW2+snc5z9dQjon3clReHqvKjxUVKM40qCf6xZOzZ2iHbL2FK7ETtuAEdbVl3rGG421xu7mkUTK6Hme0TZxfXPRrMQKz3LSkd9q0OMfJH3xytfapyTRrT9wladad5Lgv5hfybEnh+AAmANz1xqlFAdq3E3UYmjcr/wJuvE7OdDvNWe1JHescb2O4g2d4jDLOZvgbU6GvG9iDIWtUouwrjcA7hwsb3m942hJp1jJ4YeF4EJPm3aslmbGEe5RIkBMtBi6ROH7hH1havjnW5lsTOPSifI0OKwxSnL+LR6K4Ibhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnRzeD6iYe3qJVMPdpHB316+oeLgOIoFRviFwEJHcUM=;
 b=LbJeCKRi5uPDpDtWyl1Zdes0uZb71uVwDLjlyjpofdLftqW+qYJWUvPQoBqV731nqVFtACVP8Ut3UTPGZ2DUluvfQqCF/M7LXHcEsxiAcglot1EjnBqvfyiD8FR6jYevCB9iWmL79IA6Z7IV/qUGVvdv340Czs1dIRx4587X7929QnyegDic03QEwQIJGCuBeidEtdTFKyi2Ke8owVuFyo8qskWWRO8QIwlLytYbf9ZlO+p54rDe399OpV+BZiBVMTLFHIkbo/nWsSMHud6CP8JJZTRaEJCkcIegtAWczHqmhELVv4CbjI3KJsvTlq+ZG5H/C1SJCHdFRtDt5DBXpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnRzeD6iYe3qJVMPdpHB316+oeLgOIoFRviFwEJHcUM=;
 b=fOymCCUT6S+YHw5xluECktKJDdDaMl+8zDAYJweAse2kGcJwBGRhxRfowX10rV4TSAIchGPtKhluNqKCQ0EuzmS+4akMWI2jQIov5ZI0PO82koWa82boRtAHhcXQuEwN3OB7l54VvJmb5K2DmAH2lsuhmZQB1X3uKi3rIionRxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by GV1PR04MB10242.eurprd04.prod.outlook.com (2603:10a6:150:1a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 07:00:22 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed%4]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 07:00:22 +0000
Message-ID: <a5268bcc-144b-4e86-a13a-33d976368f06@oss.nxp.com>
Date: Wed, 20 Mar 2024 09:00:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: S32G3: Introduce device tree for
 S32G-VNP-RDB3
Content-Language: en-US
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Chester Lin <chester62515@gmail.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Matthias Brugger <mbrugger@suse.com>,
 NXP S32 Linux Team <s32@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Marek Vasut <marex@denx.de>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Matthias Schiffer <matthias.schiffer@tq-group.com>,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Josua Mayer <josua@solid-run.com>,
 Yannic Moog <y.moog@phytec.de>, Li Yang <leoyang.li@nxp.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240319221614.56652-1-wafgo01@gmail.com>
 <20240319221614.56652-2-wafgo01@gmail.com>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20240319221614.56652-2-wafgo01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0055.eurprd04.prod.outlook.com
 (2603:10a6:802:2::26) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|GV1PR04MB10242:EE_
X-MS-Office365-Filtering-Correlation-Id: b4615ed9-32ce-4990-bf53-08dc48ab68ef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 /wVcBLvPUPxOubSE4NIPBSSCae9AJyl12DuF9t03//0MGcC3eOBxDMeS+MiSemZUxlBIWnC6+RE+eZaDBjYxtBPuKMVOJ2+AQwZ12UKrcDP7G6Q2Mu+DVmEvqTZBCFWlptya1Wr5bc0jDx4Ou4/YIE72ibUi+3cvH6WSbVyoyoeam8diWonGG5iTfDhv34Al56ce/N6EeMP/J0t3r9eOiBAvfba8GRxaKBKePL+Pgdu79+JmoPKI9atlXJcdpZ3LsIsUOr0m8oqXJBuw1FsKWsZzTL5LnrAl8SdkrEaSTwI+IQVj5QIE66f9W2rRCWThNqReVvweCHn0TNxLl3qIqZXTH7anL7LcVAkREa668tpvbV247tKV82LNSiILLHGeEoJtkv30LKrCZO2I4PueW1sxDTTvr9FIPg3zZH4/7DRradMihddbeNtH9NLJZPDheLklc/nvLXeH6o2gCt1Gdu+7hdnKyBaCGmMv/+b2e8Sc0MToWLvIxohGkmuSk6+1Hn/RGtmOMUbg+9125H/oTNK0kaW4KWGlX53XkGH0Ltw1OlVzP4a3lFIqJZkdlt3Vokm2EE6Hihqrm4YQxa241duzpGvi5iOUfgUUQHC2dsk=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?b2dPUm5wM0Z4T3FkcjR6UEhKdVpBU1d3bDVGN2hCUkNmZmNIS3FXZGtYbmxF?=
 =?utf-8?B?d29NWEFFTm5PQ0Fsb1h3eFlqQVVCSUhHNS8vTHVxZXY3V1BsOENWMGlEaTBr?=
 =?utf-8?B?OWZJTEVFaDVhUnJkL2lha3FiSFNmOU96anM4NHJ6TUJVb0c4NlM5Uk9ZdEFZ?=
 =?utf-8?B?R281VVY0R2tYRFNjdElBcnpxZVNrODZIM2FZWFJHNjdVcUpUdDQzV0hrMnBO?=
 =?utf-8?B?Sk51RVFYd2xiWmlyVzRzU3Zlb1IwQU54dnlqdVI3cUpIOWZENVFPbFVSeWov?=
 =?utf-8?B?SEUweHZ3aGgyWlhUZVY5Q3JKV1hGbGFKblp3MWExWmhCSG51cksxMFF0VVk1?=
 =?utf-8?B?cGwrNFplUC9uS1MzR2I2WGgvTCt3bGx5L0JKaUhrQjk1Y0NCeHRYcVkxZ3Va?=
 =?utf-8?B?YlRTTXZ6OTIvbUZGYzlkU3JqSHQ0UFVJS3NDTmNWRHRMSUh3UzNlaTNsUXRj?=
 =?utf-8?B?clJpSzBMYU44bGZTNEliODM5Smk1T2oyS0VEWEttbkZIa3pGeXFxb0l0aFRq?=
 =?utf-8?B?VWRHeGhGdW5NL2tMV3p6b1BYWWo1NU5zeVNIc2JSTktsNjlnUTc2SmVKVzRa?=
 =?utf-8?B?OTEwRTRNN2x5bEVLSy9Bd05GeDIyWWZkVFcwS3EzUmx4QTMrOFE1QlZ6cUIr?=
 =?utf-8?B?a0g2djRCT2luR3AyeWNGd29aRUtmTGI5aGRwWEIzeWp1T0c2c0JQZys5WFNz?=
 =?utf-8?B?VnprbjYwTE1vTy8zWCt2bGdvNlRmSE1hYU1CM2ZvVkhlQ1RJbjVwcktGN01k?=
 =?utf-8?B?b3cwZ000dzRydEppUkhqUjFDRXp0aGMxRXorOWlnOHd1SE82VElHeXFzaU5K?=
 =?utf-8?B?N3NzS3YxajA5Mi9hekhkdURDUDVSRVo3NVpnbDRxUHArYXZiLy9wVGpwcGwz?=
 =?utf-8?B?bXdBbXg3ekwzMzlUTlhHQlNyOE9uMytRM0EzKzVOZkIwSzZsTWpITlJKeG45?=
 =?utf-8?B?M29LWUxjS0FrTnZUWkhxeXZZQSt0b1VlemVyNzAxQUxnV3dFMjZnd0VOZ2tX?=
 =?utf-8?B?aCtFRnZrbWhpeE1jL3BEd0lvbzM0WDE5eTBJRGpDMERHZnBJck04QjZhb21Q?=
 =?utf-8?B?VEhpaGVMMjdyMi9tOHc3MzBTL2FiZk1hVGZQRkRrN2RKOFNUN1NhSHZlRDgz?=
 =?utf-8?B?RFVKNHBqTTNDak1yVVZjZjdjUXBnTUhjQ1lwZHlqUWlKU1ZTTXRoVm5PQ3VZ?=
 =?utf-8?B?ZHNHWWl6UVE0YS9tMmpUNWl2UzhicTV1SkUxbHY3eUltWUNoSmpFTlNFTW1N?=
 =?utf-8?B?QytKOXdxV05Tdy8yTUx0VE9nUjRPVG01TytBS2RybE1rd3hVd0d2Y1B3cHll?=
 =?utf-8?B?ZmQ5cFBJMEN2dDhOcjNvdzhVbEt6Ui90dTlhVWxQNUwyMlQrNGp4RFBtdEZI?=
 =?utf-8?B?cmFxRWVKcWdoM0poQkRhYTVJd0hpRGhlKzF4RXlJQktCcEpoTTB2VS9sUUp1?=
 =?utf-8?B?Z2wrMlpqNXptZlZ1MC81VVZYbVlxOUpCMHhFeDNJNVphLzRlNUpienR1ZjIv?=
 =?utf-8?B?akVQTHl5cmIvbGdUR2VZdjNqbkUrVXNQVWQvS2dpTzd6NHdxZ2VMWXVhNWNq?=
 =?utf-8?B?MWduL0J6aXVXMWRkRDVHVkFCbVRLbHluVWo2bkhla1pkZG03Um14dHdGblpj?=
 =?utf-8?B?NTRBT3pMSTIwTEppSUpWdlFncEJCV3dhM0xIY0EvcytGdlA5UmM0T2Qwbzgv?=
 =?utf-8?B?LzRHT0hocUNXQnFvU2h4YXo2TU9pZytOalIzaWJhenJQSG5xS1oxWHRuYVAz?=
 =?utf-8?B?M1d1VlVkTXRnU2hlRXhaTGMvTGJQWjErMHlOOTJhcWxwTGtsbWFPOE00ZzVF?=
 =?utf-8?B?Z0d5SFhkbFdMbzFCVmQ4QlJld2lydHoxRCtUV21wVzZkL2dJTG9MbHk0SGcx?=
 =?utf-8?B?OVNuQVdHN01xS3VqbUowbTFwSzUreTdLY0JNMmxIRTNDNnVEbytrMitta003?=
 =?utf-8?B?cStxaGRNbGl0T1hheEpDRy82QXJhOXBsbXdSYlJ2eUZmTVNxbWVMSFI1T3Zu?=
 =?utf-8?B?M1FTYUZSWnZNbk5CclVBbmNsU2o4NkhVcExTWisySFA0K2xhVzZIUTc4b2dI?=
 =?utf-8?B?ZXUzWGIydWVTM3kyZy83WTVwbGg0SkJkZExzTHJJMHNsZ2tlK05KV0swVnI5?=
 =?utf-8?B?TXBoRWFVSTdqSTlZdCtBbG4zbVZ6anVCaXVjRm1jRmtPVjY3VUl0elM4dnk3?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4615ed9-32ce-4990-bf53-08dc48ab68ef
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 07:00:21.9704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4bhyLcAxfkHKKPsqG7+fPf1nuAW6boRYoiquH19POuHStcrbsflHMCYFc+e3WtIzyQMDmvOXBAFNYNbYj8QWaOoDrJR1Y8zW1+yl0PseXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10242

On 3/20/24 00:16, Wadim Mueller wrote:
[...]
> +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2021-2023 NXP
> + *
> + * Authors: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> + *          Ciprian Costea <ciprianmarian.costea@nxp.com>
> + *          Andra-Teodora Ilie <andra.ilie@nxp.com>

This pollutes the content of the file. Please make them part of the
commit description using 'Signed-off-by' tags.

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +#include <dt-bindings/interrupt-controller/arm-gic.h>

Missing empty line ?

> +/ {
> +	compatible = "nxp,s32g3";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <0x02>;
> +	#size-cells = <0x02>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpu4>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu5>;
> +				};
> +
> +				core2 {
> +					cpu = <&cpu6>;
> +				};
> +
> +				core3 {
> +					cpu = <&cpu7>;
> +				};
> +			};
> +		};
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			clocks = <&dfs 0>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x1>;
> +			enable-method = "psci";
> +			clocks = <&dfs 0>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x2>;
> +			enable-method = "psci";
> +			clocks = <&dfs 0>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x3>;
> +			enable-method = "psci";
> +			clocks = <&dfs 0>;
> +		};
> +
> +		cpu4: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			clocks = <&dfs 0>;
> +		};
> +
> +		cpu5: cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x101>;
> +			enable-method = "psci";
> +			clocks = <&dfs 0>;
> +		};
> +
> +		cpu6: cpu@102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x102>;
> +			enable-method = "psci";
> +			clocks = <&dfs 0>;
> +		};
> +
> +		cpu7: cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x103>;
> +			enable-method = "psci";
> +			clocks = <&dfs 0>;
> +		};
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* sec-phys */
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* virt */
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* hyp-virt */
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>, /* sec-phys */
> +			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>; /* phys */

The interrupt order does not seem right.
From drivers/clocksource/arm_arch_timer.c:

static const char *arch_timer_ppi_names[ARCH_TIMER_MAX_TIMER_PPI] = {
	[ARCH_TIMER_PHYS_SECURE_PPI]	= "sec-phys",
	[ARCH_TIMER_PHYS_NONSECURE_PPI]	= "phys",
	[ARCH_TIMER_VIRT_PPI]		= "virt",
	[ARCH_TIMER_HYP_PPI]		= "hyp-phys",
	[ARCH_TIMER_HYP_VIRT_PPI]	= "hyp-virt",
};

[...]

static int __init arch_timer_of_init(struct device_node *np)
{
    [...]

    for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI;
i++) {
    if (has_names)
        irq = of_irq_get_byname(np, arch_timer_ppi_names[i]);
    else
        irq = of_irq_get(np, i);
    if (irq > 0)
        arch_timer_ppi[i] = irq;

    }
    [...]
}

As I understand it, if the names are not provided, then the interrupt
IDs must strictly follow the order specified in the arch_timer_ppi_names
list, which is: sec-phys, phys, virt, hyp-phys, hyp-virt. That is why I
personally prefer using interrupt names instead of the raw list of IDs.

> +		arm,no-tick-in-suspend;
> +	};
> +
> +	reserved-memory  {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		scmi_shmem: shm@d0000000 {
> +			compatible = "arm,scmi-shmem";
> +			reg = <0x0 0xd0000000 0x0 0x80>;
> +			no-map;
> +		};
> +	};
> +
> +	firmware {
> +		scmi: scmi {
> +			compatible = "arm,scmi-smc";
> +			shmem = <&scmi_shmem>;
> +			arm,smc-id = <0xc20000fe>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 300 IRQ_TYPE_EDGE_RISING>;

This interrupt is not needed if the RX is not used.

> +
> +			dfs: protocol@13 {
> +				reg = <0x13>;
> +				#clock-cells = <1>;
> +			};
> +
> +			clks: protocol@14 {
> +				reg = <0x14>;
> +				#clock-cells = <1>;
> +			};
> +		};
> +
> +		psci: psci {
> +			compatible = "arm,psci-1.0";
> +			method = "smc";
> +		};
> +	};
> +
> +	soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0x80000000>;
> +
> +		uart0: serial@401c8000 {
> +			compatible = "nxp,s32g3-linflexuart",

From 'Submitting Devicetree (DT) binding patches' [0]:
5. The Documentation/ portion of the patch should come in the series
before the code implementing the binding.

> +				     "fsl,s32v234-linflexuart";
> +			reg = <0x401c8000 0x3000>;
> +			interrupts = <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
> +			status = "disabled";
> +		};

Krzysztof, would it make sense to factor the common part of the s32g3
and s32g2 into a new dtsi file (e.g. s32g.dtsi) since both SoCs are part
of the same family and share the memory map with some exceptions?

> +
> +		uart1: serial@401cc000 {
> +			compatible = "nxp,s32g3-linflexuart",
> +				     "fsl,s32v234-linflexuart";
> +			reg = <0x401cc000 0x3000>;
> +			interrupts = <GIC_SPI 83 IRQ_TYPE_EDGE_RISING>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@402bc000 {
> +			compatible = "nxp,s32g3-linflexuart",
> +				     "fsl,s32v234-linflexuart";
> +			reg = <0x402bc000 0x3000>;
> +			interrupts = <GIC_SPI 84 IRQ_TYPE_EDGE_RISING>;
> +			status = "disabled";
> +		};
> +
> +		gic: interrupt-controller@50800000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0x50800000 0x10000>,
> +			      <0x50900000 0x200000>,
> +			      <0x50400000 0x2000>,
> +			      <0x50410000 0x2000>,
> +			      <0x50420000 0x2000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		usdhc0: mmc@402f0000 {
> +			compatible = "nxp,s32g2-usdhc";

Is there a reason why the UART uses an S32G3 specific compatible string,
but the SD does not?

> +			reg = <0x402f0000 0x1000>;
> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 32>,
> +				 <&clks 31>,
> +				 <&clks 33>;
> +			clock-names = "ipg", "ahb", "per";
> +			status = "disabled";
> +		};

Missing bus-width = <8> ?

> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> new file mode 100644
> index 000000000000..199605b28df3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2021-2023 NXP
> + *
> + * NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)
> + */
> +
> +/dts-v1/;
> +
> +#include "s32g3.dtsi"
> +
> +/ {
> +	model = "NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)";
> +	compatible = "nxp,s32g399a-rdb3", "nxp,s32g3";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	/* 4GiB RAM */
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0 0x80000000>,
> +		      <0x8 0x80000000 0 0x80000000>;
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&usdhc0 {
> +	status = "okay";
> +}
[0]
https://docs.kernel.org/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

Regards,
Ghennadi


