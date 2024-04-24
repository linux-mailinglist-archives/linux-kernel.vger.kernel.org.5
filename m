Return-Path: <linux-kernel+bounces-156134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E3A8AFE5C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E98A284499
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDD715EA2;
	Wed, 24 Apr 2024 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YrVylzxd"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2077.outbound.protection.outlook.com [40.107.15.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52FD168B8;
	Wed, 24 Apr 2024 02:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925694; cv=fail; b=j/8+gaXqqjwvi1QWc79TO100QIw7XwS0xnPVoYXGpR6BNwLrnP9Ccw8X7OJm/XK/5Z4zNrR9OvCnAeYaU6y8al6sfRcnPqbn5arqrOcuXEJEFLvOqDelB7Hz9H7pDsJ//zLEUhW8P4bEOOeUmId6ONEpIuteRtBpIcpMY7UFvUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925694; c=relaxed/simple;
	bh=d7h8Qwp5509819np1FR1XDXalTxGWCYG8Nu+wJw2f18=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DP041vpdUKx+eFOliJtcvZfgfDwyVtowSk75SnTNSxABPyHeT+0hm0dPe3F+hHUhmvHLqlEyKHi0soHJEaAyxt4wHoPyVXm1WI5x4FL862Echvpj2YgWw9G7RUAhHWQX4VFH3ZtlK9mu/EtSNthnjafZUGu1HHnKZNBU/eQ3Hgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YrVylzxd; arc=fail smtp.client-ip=40.107.15.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbaFBv0qP8zYkc8WnDS+xObH/KPvkodq7yjQ2of1ST7jFO3zvNkhdwpw2eDyVmOaC5N++C1vwCqiKEqs5At1pjCWWyAAlYvLOuLWUSLyQY86pb8F27ucZvxL9sKQwSTXdXsz4ZOJuM44k9Z71upwiuPFWO0YEIlGxI91jKi3Iu1JwVfJ9dq2NBrK8ILqIW5j/yeR2oLGjbskrs+lBPaf/LHwMW5f79qvYXVbvYQGtAfIZ78Lirl5IBKAB9pxdrzivLEwOeETlbxxUvrMKTnbSXnwaSDUOrOSKCO+Nh+MxI6KC3kzojEkocUm5fqxt2GYic2KXsCAxFldt9mEQtkifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7h8Qwp5509819np1FR1XDXalTxGWCYG8Nu+wJw2f18=;
 b=bKdCOeBqqEeRPN5YKiSl7/y655geBSR6CK4l42FN3qtFXLSXSSVxCOJLtYZev7wVTVDHJbP6L3c4BuoM4R0XBYCNAre7oHCgQD8ws/Noh5WGTUAn5BPUVdAEUT/RvVFw3idbS9Jz9uRibOyg9TLnxhSdVwbrzTzU4KkvzzgeNH9yHFwWHlK8M0SbLE+9CvvhAgR7BS2FPQ2iUlyPXV46sBfAWmgHqqp1rC/qGJ/ok8IDA1Dxjg1mvXtwvCM9vTV54dk3NYX55uAsCM6ylXShAw83Wp2gNUTiiL/5W7IG31O0vq/Kwxgd//Ml4NlmfuekIGAaxpKgkvh0gC0lb1MuVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7h8Qwp5509819np1FR1XDXalTxGWCYG8Nu+wJw2f18=;
 b=YrVylzxdwW7u6/Hklf+cJKxNpWbVz7jQHSf+MEZP7ANmaih3PUFpvy7loh7/gnVP5pjA8v0plLEY3fE2/l+jUKArCf7j/E7G8YMR1YSHTXJ0B5VDo0gum56wUCd/TIjnknL2V6g2E4TZpvRpr5W1ytZ+rx0APL92T0Sao0/aqz4=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AM0PR04MB6835.eurprd04.prod.outlook.com (2603:10a6:208:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 02:28:09 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 02:28:09 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
CC: Frank Li <frank.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v4 1/1] arm64: dts: imx93-11x11-evk: add rtc
 PCF2131 support
Thread-Topic: [EXT] Re: [PATCH v4 1/1] arm64: dts: imx93-11x11-evk: add rtc
 PCF2131 support
Thread-Index: AQHakHRamlisSS/egUua3Va84we6KrFr5osAgArUrOA=
Date: Wed, 24 Apr 2024 02:28:08 +0000
Message-ID:
 <AS4PR04MB9386FB10797C0AE8A19AA88BE1102@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240417031455.3177778-1-joy.zou@nxp.com>
 <20240417031455.3177778-2-joy.zou@nxp.com>
 <20240417045720.hk3y6m6roiqtuvfz@pengutronix.de>
In-Reply-To: <20240417045720.hk3y6m6roiqtuvfz@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|AM0PR04MB6835:EE_
x-ms-office365-filtering-correlation-id: 460c3de2-bbec-47ae-b0b0-08dc64062e57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?gb2312?B?RFk0R1kxek5Pb3pXcmNyaTNkVHA2a1hWSXYyVDg1Vm1rQUlnSXZtR09yN2Z5?=
 =?gb2312?B?bFAwVlF6WnArRStMUzVjaTR4Z3NyZy9sZlpnUURKNG5iVDZpeEVhdTBWMWJj?=
 =?gb2312?B?dEhmejdTU3d4RDNQSU1xRVc1TjAwelJxc0VXbm44UTdYblhKOG1PcDU2cXZW?=
 =?gb2312?B?aGsvenR4UkVYVTdiUnhXUnRieWxjM2N5RkJxNko5Ky9VVjRaZUhMbnZ0STlX?=
 =?gb2312?B?Rzk2UmRScWhoY01JSXJRRDlSdnFOVnNPb1VxMUdwSGN3bW1nUGpKeXBHeDN1?=
 =?gb2312?B?RHdPWVliRVhsVFlNQ0dRaDdWTTZDNHEwa0JYZUtZaGlvaDdYeGNYVlppTjB6?=
 =?gb2312?B?d2lpemNTMTBJdSt4VmxoZm5FbXJKK2Q4YnJNQ1hYcTU2bUpKZXQzVlpPNG5Z?=
 =?gb2312?B?WWkvdFRkaG9UOUxoblR0d3c1cERKb2VFRUlVL1hTRnkyRnBtcjVUaEtkWjJw?=
 =?gb2312?B?VEl5a2VDZ2FRTXprdXlpY2graHRlZkEwK2w3UE5FRVpOMklUZTlnWHA2My9x?=
 =?gb2312?B?Q005RGcwSk1GUTBiblUxTXFCZEFZaUg1Q0h1UXZlb3pKYzI4akI1SjR1SlJL?=
 =?gb2312?B?RnhRdTlOUFJuY3ZkSDZNT2tYWGtTVGtTTVB1Q1F0U2dZaWVnbE0xRWNpZm1v?=
 =?gb2312?B?cTdUNkxTSHI5dWRHWEhtTTFQazBJZFZXZy9hQWgyV3hXOWQwVnpuZklrdXZ5?=
 =?gb2312?B?dzZ1MkdYMVZKUFlsV3IraktxZXJEVGlITlk0RzRGdDQ0eXJkZzNDVzJDSEx3?=
 =?gb2312?B?clN1ZzVtdk45cGF5U2FRRW1OcWNndENEZzgwVkZ1N1AzSjM0bTgxRkxkWVZJ?=
 =?gb2312?B?aWJvZVhGNENBaVNwUG9qVVdwVTIzNytNTytkU05sR2RkTHI1bnByOVRwRlZk?=
 =?gb2312?B?UW5wQnp4Nnh4T1VBN3pZbmxxYXhxQ1l4dXVROGo3Q1dEdjBpanB2TDFHWGJM?=
 =?gb2312?B?Q1JrRFZHeW1MVzI4dC9VbmJoaGl5SWExVElmMHlOS1Noa0NOU0tUeW5PTnRM?=
 =?gb2312?B?Y21qdTVQT3AwekNFcXZuclh2OEp2SVp1bnNiY2pCekxKR0h2NkQ3Y3pTZWI1?=
 =?gb2312?B?a2JKeUxpSlg0Q3NENTI4MVdIN1VyVmRqRFUyOERCL2tGbmdRQnhTbTRGV0NJ?=
 =?gb2312?B?STdObmdFWDY1NjNPeEJpODJCUDhzOEhFeG1hWU1ncTViM254NlpuV1hyZnlu?=
 =?gb2312?B?Wm0vdEpoYk5CRUtLTmNXTU93S0ZicnRFdTB3MjFBa3Z4MVRBeVVyYkpCQTU3?=
 =?gb2312?B?WWpId3poUFJSZm1XYlFLRTZaS0tuakZlemlTSUZGTkE1aW5Pbm9EbVh2QnVi?=
 =?gb2312?B?WUtWNDEwb0Z5b3IrUGFoVytlMzk3QlVFalJ1OFlmV0N1ZUEwVmR5RjRoNk1o?=
 =?gb2312?B?eUFVamRNYVpGVytUanlnbnc3SzBrRWRMbkRVa1cyZjJ2d1VGcDdnVjJKalVG?=
 =?gb2312?B?dkRHQXhJWjl4NFlwaHVPdkVtcXp0aS9SQjNJdlNycGdwTXM0VHBnSytkTCtC?=
 =?gb2312?B?RTlCR0NiWXhuajl1MDJnMlFtVDRuaG1MRDRXZnNQeVYzOGp0YVdDQ0gxSnNU?=
 =?gb2312?B?Z3pjMzZaL2RwSkdPYTZsS3VQZXZLSEgvajBrUkpKOE9hVVBiVUtKUmZYTGcw?=
 =?gb2312?B?NVhJdCtJcE52aGoyZmIvcjYwQ3VYbUhtajZrb0l1QzJRMnZMOStoVXJlMk9D?=
 =?gb2312?B?TWNxSmpCWlR0QTlRcldVaFVBN0tJc3NLVGYxZHlzTjRmS1JKYzVJdjBNeUhm?=
 =?gb2312?B?eSswTklZbjYwdGVLUXlXY0NJL0xsMk5aTk40SCs5aGdySlk3d1RCTmU1WjZz?=
 =?gb2312?B?T2RMdnR6NjZFZEVjeTFpZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Z1dxSEttMWpUdFBxaTlwMWtVUGNWa0tYcm9SWGRGL2U4REVCVGJjTW4zelFN?=
 =?gb2312?B?YldIWE50MVBvK3krMDFLcFZraVBnUVhBbFFKN0tpbE5VMUJab0hHUmdJbXBF?=
 =?gb2312?B?YXN3M3lQaFN3M2FPZnY2LzE0YXpWVkZCZGVEYjA2dG5EUW5QUkZwbyt5S0ZI?=
 =?gb2312?B?TzlCRVMwVWxsNVMyZlEyV2ltbTQvb0o3alY5ejdyRnN4djBubndFbTJzR2Vw?=
 =?gb2312?B?M25ZMzcyUmtlVU4vV2FSRlFKOFZwUitpOVpGVnNiTG40dVR2aXErcWNBc1Bm?=
 =?gb2312?B?RnYySGs0c0ZXb3NaanFySXV3SkJNdngvaXQwZ0FsTDcyTStPckZzN1hyWU1M?=
 =?gb2312?B?bVlLV0Z1TzZPTHpybFE4b1FjalZDQ3NLUkphWlFCc3AwN0FodTQ1ZXYvV3Fs?=
 =?gb2312?B?Q3hiL3A1UDJNakRDT1dhd2pkZzFPU2o3cnk0aUVZTDhieitqeDR3ZUZIcTRU?=
 =?gb2312?B?di9KZ3FLQ0xvOHdkR0dLbHYrYkI3RUdxT0pwcGxGNTBUNUtCZ3pZd1pwMTI2?=
 =?gb2312?B?YS9HL0R4R2g2S1Q5Y2RRQ2FMaU14Wm9KbC9UMURvZWh6UVA4SGNPa3NmN091?=
 =?gb2312?B?TGlCeWhrdDdyOVN5MkZpZGwzWGNvaytGaHRKSHJaMm9VQ3kralQ3ZTh5VVlp?=
 =?gb2312?B?NVE5NUdHdVorbnlxZmU4YlAvZzJEYS9wam1VVlNLVUJSZDlOVUtTdEErVW9Q?=
 =?gb2312?B?T04rK1I3RXJYZWxldnVpQW8vRzlwQlBzQVZEcjdYc1IwdW0rRTlHb1ZCV21Z?=
 =?gb2312?B?MG1xWFNLMksxeDNzSGdYaVg0d1hEbmtJMnpuUUMyV25VdGtISFlkeDZDRzZh?=
 =?gb2312?B?UTRxZGxJTHBxK1NWRm1PbWtBMUhFUW9TYmllT1JFLzMxTTlyR28yLzd3SzZK?=
 =?gb2312?B?cXh5ODhESFlMdGhsVFh1SlZHZUhQS1FvSWp6ZGdDMXc4ZGx0TTZ1YzdCWERk?=
 =?gb2312?B?QXY3U0UrNW05SGx1bnRCWnV4bVdTNm1EVTl6S2x1MDlHcC9YNHdQTmVTRWlM?=
 =?gb2312?B?VEQ5TkNUWE5WTTA3cm5sbUlwSkN6YjhFUlRmMWo4bVNBZ1VCT0JjeHQxdWhp?=
 =?gb2312?B?bjVXTG9jaCtmblhhZVlQZjEvL00vcnpGWUVpUDRqbExvb1pXeU16TzJiQ0dn?=
 =?gb2312?B?NHpFSjdYVXdOS1RGaU82aVZMNFozLy9ZVENVM0NzZUk1azZKY25yNGV3S0ZQ?=
 =?gb2312?B?WnBuanUvKzdleHJiaUd5dXZyTWpqd29LU0QwRitWR1Z2Y0ZtNk9ER3ROMkJi?=
 =?gb2312?B?b0JBN1A4ekRjUi9HMzhYQ0psNVJtbmZTTjdYenZUSXB6ckFxRHFRdmJCMnZB?=
 =?gb2312?B?M1Jzc2lrTjBsQVNLNzE5NzJYZk92NytrNFM2SVZnUHA4eU5QRWVDUHEwc0NB?=
 =?gb2312?B?aFNxaXVKc05MVkdtYk9wbG9yT24rZzllTXJhOWZxbjRHZlRDZDhGWnNZakwz?=
 =?gb2312?B?d241dnB4QjhDTUpSQ1FDdVVTKzdabWo1YkZGbmZmdWZYSy9GTm5wbk53ZDlL?=
 =?gb2312?B?YnVab2RPM0xSdzREb1BYUUJ3dDlob29RMTh6UlpwK3VGWklPc21Kajgva1Rt?=
 =?gb2312?B?NWhqUk85WGVWanNxdTR0aG5MUW9KcDVlQXowcHcycVorcVpzRjJxS2dwVm51?=
 =?gb2312?B?OENkYzB4NkJ2REZzTGVjdHBBR0JJMVR5KzZxaTNDZjVsUWpQZ0E5SytKWEht?=
 =?gb2312?B?TDhVWEsxQ3BkejBzTy9hbjRHMmlIZXRWU0FxNXNDTmlkeW5OeW1vUUpLeWdl?=
 =?gb2312?B?RDhWOTByMEM4a0h3cVZ0MmJNUm1FT1l2bitUZHcrV0k4TGFLNjZkTjMwR2NR?=
 =?gb2312?B?TWIveE5taTFuR1Nya3VOOGZvQTlTdDR2ZkV1UjZGM0xJR1NPMitySDBjUUps?=
 =?gb2312?B?NitXRkJuZ1NSQm82bnIxZGlKdFFLR2RTS0dZbU91QTZ3VWZ1RDVoWHp4RU9U?=
 =?gb2312?B?M2ZlS2FBbU44K2RURG05MGo1aDBFTnpuUlRSaE1VOE5SOWJrdWlzNzdQTzhN?=
 =?gb2312?B?NlBMRTN0M2prSXZjaFV1dzdWVndVOGdiWlNGak9ZdDdvZkVJR01yK0o1Wkpn?=
 =?gb2312?B?Y3ZsMEpLLzcwZ21wdmV0UjNuTVFHYzQ2RVJFbE5HSENMeE5JQm5vcnZtbGZO?=
 =?gb2312?Q?ajL8=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460c3de2-bbec-47ae-b0b0-08dc64062e57
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 02:28:08.9472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3TF/VjVnzGVjgj2hPz3PRHdb+9KR+vZh85P0DdRgfvYhILDcRDLhNIlO+9B27hv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6835

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmNvIEZlbHNjaCA8bS5m
ZWxzY2hAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjTE6jTUwjE3yNUgMTI6NTcNCj4gVG86
IEpveSBab3UgPGpveS56b3VAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBueHAu
Y29tPjsgSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPjsNCj4gcm9iaCtkdEBrZXJuZWwub3Jn
OyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5v
cmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5l
bEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXgNCj4gPGxp
bnV4LWlteEBueHAuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5s
aW51eC5kZXY7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHY0IDEv
MV0gYXJtNjQ6IGR0czogaW14OTMtMTF4MTEtZXZrOiBhZGQgcnRjDQo+IFBDRjIxMzEgc3VwcG9y
dA0KPiANCj4gDQo+IEhpIEpveSwNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OTMtMTF4MTEtZXZrLmR0cw0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OTMtMTF4MTEtZXZrLmR0cw0KPiA+IGluZGV4IDA3ZTg1YTMwYTI1Zi4u
YmMzYzkyNzFkNzQ3IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDkzLTExeDExLWV2ay5kdHMNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg5My0xMXgxMS1ldmsuZHRzDQo+ID4gQEAgLTI4MSw2ICsyODEsMjMgQEAgbGRv
NTogTERPNSB7DQo+ID4gICAgICAgfTsNCj4gPiAgfTsNCj4gPg0KPiA+ICsmbHBpMmMzIHsNCj4g
PiArICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiArICAgICAjc2l6ZS1jZWxscyA9IDww
PjsNCj4gDQo+IHdoaWxlIHJlYWRpbmcgeW91ciBwYXRjaCBJIGFsc28gbm90aWNlZCB0aGF0IHlv
dSBoYWQgdG8gc3BlY2lmeSB0aGVzZSBjZWxscw0KPiBoZXJlLiBJdCBpcyB2ZXJ5IGNvbW1vbiB0
byBzcGVjaWZ5IGl0IHdpdGhpbiB0aGUgYmFzZSBkdHNpIGZpbGUgaW14OTMuZHRzaS4gQ2FuDQo+
IHlvdSBwbGVhc2UgcHJvdmRlIGFuIGV4dHJhIHBhdGNoIHdoaWNoIGFkZHMgdGhpcyB0byB0aGUg
YmFzZSBkdHNpIGZvbGxvd2VkIGJ5DQo+IHRoaXMgcGF0Y2gsIHdoaWNoIG9mIGNvdXJzZSBkbyBu
ZWVkIHRvIHNwZWNpZnkgaXQgYWdhaW4uDQo+IA0KPiBUaGFua3MgeW91LA0KPiAgIE1hcmNvDQo+
IA0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIQ0KSGF2ZSBjaGVja2VkIHRoZSBiYXNlIGR0c2kg
ZmlsZSBpbXg5My5kdHNpLiBUaGUgdGhlc2UgY2VsbHMgYWxyZWFkeSBleGlzdGVkLg0KVGhlIGN1
cnJlbnQgY2VsbHMgaXMgc2FtZSB3aXRoIHRoZSBscGkyYzMgbm9kZSBpbiBpbXg5My5kdHNpLiBT
byBzaG91bGQgcmVtb3ZlDQp0aGVzZSBjZWxscyBpbiBvcmRlciB0byBrZWVwIHRlcnNlPw0KQlIN
CkpveSBab3UNCg0K

