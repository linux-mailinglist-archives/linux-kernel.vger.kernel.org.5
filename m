Return-Path: <linux-kernel+bounces-80592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA489866A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90204282345
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04AF1BDC3;
	Mon, 26 Feb 2024 06:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VZ99xNVI"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648C1BF20;
	Mon, 26 Feb 2024 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708928983; cv=fail; b=TihLHR+kj/jx0bbY9kDdIhx06OSD/rjhsysm/LSyZ8ZRYhVT0p1flE/xgjLABj3Ca3hrn1apSZR/ZlCVlEo2dizj/Zz9CuC6TwYjRQqqjcpsZmBoPgv7Mdqlp9rGWU3cF/1UXicOOgCTdI3Jj0Wv01G5cVlLoRNSBGUuA2tneiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708928983; c=relaxed/simple;
	bh=Q/50mLLa9jbkWZVnlO3KwOquF29i5c/qz5Cg7T5jkFE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sksAzjAXbJBtZZfbP/RMcqKJHrPEnTaNaz7phjKRGVFhTGdcUKGzceB4Q9BqnSPonTBgSzVEtLjoc7DCOc5Avp0GrwpwYsKv2PTaatUsDACGiVaE9BEUPpCXj2yxm5LHMCoe8a6Z/VrjaNeXE7WRhwIh66eVJfiwhmTMT6mbkok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VZ99xNVI; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwfkfYuwczgACCEIsWn/EdEMn/tCDZ47W+LSoPqWyu9tz0TXqu/uqHHsoMRE2yeuunZzKJ/Y43ok/M/mHLmSa921rIqdscGyWSKIwzXfppH32ctHCrH0ZXFqidU+9PtBFMWvCWLLKvX2+xi2tVyBR2ts/0xjBR7328XUGYlDqGZrPaMN/QDIaBUAjGj0DQ9jDjFYdtJlFkkARzpi/dmO5+0RYhpBvHquUhAtAgyFyx8j26j/kn01dwWb9pNKuBUvOWXr0Ig7/fNxou8ealfmftd+uKq5jAHBRHHrSrtFS2+OLJRkuBxtbgz01aX8ZQaAc9OhPYRYacJ9v789o68XRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8K2AQ8FRAAz6L5ajrpOItkUgBA9p6+P8fjYOJVAXMiI=;
 b=LV9UKaa2CeLZ/+ghA8NCsEamyzIBcXBld+Su25rzFfFWDC2iaIHLgVOgJaQmCgeXvebleTcJMVufJsHCDXQGh93ATsYGUPdwH7qm06aldw7WGqa2oeF9hM8aqzO507WAKe4FdXG+oirWQJCBTJmmybPKm8qzh2LHCumYmHH6Se/tOfUzYEy/TezMvmBfjkmx/IdHdH2r5s7fGl933otSYj80WBA+QeZRne2xVLvlUyHC3/2fJW9PLC1jpieifyK9gE80wJTScaIsPqC3o8jwn0U6b6wa4kCQihDMCLyz5HOHJspiiKaoIcZU9F/1oj4roo4EzgUy70VtSNFcjbJ1KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8K2AQ8FRAAz6L5ajrpOItkUgBA9p6+P8fjYOJVAXMiI=;
 b=VZ99xNVIAASZ05S3kMfVImj9vq1JNOaPVwwezKqVZ6duSwjXLFuil4al8yK44D1elmWN4/FodxDsp2lhKxSgjCBy1XNUvJIOP0PpXI+GHDS50RpfgZKXkjw0/lba/QgTnpQaI7EdS76y9Ugfe+E8eR6o5OosphpcHPDfCxJdz+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by AS8PR04MB7624.eurprd04.prod.outlook.com (2603:10a6:20b:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 26 Feb
 2024 06:29:37 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 06:29:37 +0000
Message-ID: <bc9bcc98-62db-420c-b30f-e4af513cbd8c@oss.nxp.com>
Date: Mon, 26 Feb 2024 08:29:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: s32g: add uSDHC node
Content-Language: en-US
To: Chester Lin <chester62515@gmail.com>
Cc: Andreas Farber <afaerber@suse.de>, Matthias Brugger <mbrugger@suse.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, NXP S32 Linux Team <s32@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Ghennadi Procopciuc
 <ghennadi.procopciuc@nxp.com>, Ciprian Costea <ciprianmarian.costea@nxp.com>
References: <20240122140602.1006813-1-ghennadi.procopciuc@oss.nxp.com>
 <20240122140602.1006813-3-ghennadi.procopciuc@oss.nxp.com>
 <ZdmnQTtUxOEUy06L@linux-8mug> <ZdnIp8PPtfbuIzwP@linux-8mug>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <ZdnIp8PPtfbuIzwP@linux-8mug>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0057.eurprd02.prod.outlook.com
 (2603:10a6:802:14::28) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|AS8PR04MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: cf43db60-8af2-4a94-aedd-08dc36944e1d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uVtH6sLYiglLVxj4Xm5q2FJLYq6OnUbmOgftzsmpJ+Urr4rEcLJX+81AJU1DCMzvmJ0ji7q9CAz0lPk8AakhdoWwLB2k9WM5myj/+ItVZS3dabx4IhpTkJHJps3MOrnKbI9XOaYsW4kxeW+CX6NP+88ZdiDpGn+pH2oNDokqTqa/Lzv0ehUmMEWDqj8fonFHU05q6uL2OemihnNzbCmBu9SLZ1CXQHdDq8dizvOiK9DG/d3BFuOOgX08PvUPF9eAAXRsiF7PHEFUhwKdP95CXcwxbtppw6ir/5WbWbHTSWJ68dnpCLnIVK0TyeBM0ZLmcitaC7ez+DS4KZTbwDuOPMJQd7e2xgNgfWXuI/Fv/vo6WPO34yryzRyp6JlOXobUQkncj0Xjt3R24rpRfRBnAMv6S7lUDVim/qFFEXw4bGWGB3AXHlDzIGpdYRb/ZydE9Qvx0PBYOG9hSLim6Tq9zdPWLvt4wJTlaEhlp4wjuhuZewnuLqVkK+rVXVgdrSFZ03QgVaKBEgNRL6ablpA2ldGVT4FJ5EDx3WCxVNLz8gvhHS4oSpWFH95WpFdE8oTup4rp165aP5BdA8O5lx5YwlFEA6Db2cvcx2BV/b4Ci+0hSk+YEA7T47pmLujtiFDW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODF0TTU2ZjZXdndRdDJNbDU4eXVaVXQxQW1yK0hkT3BLM2J3SnZLVnJ5WGFj?=
 =?utf-8?B?NDJpU1ZCY2JLWlVHNkoyTGpiVmR2RlRUU0dGTG1CbVY5TUYvWE9vUWNmV1hS?=
 =?utf-8?B?eWpsMUx1N2h4SDJ6bSt6MW8ya3FVV3FjY0RMek8xdU8rOHVLYVpvekVLZ3NZ?=
 =?utf-8?B?b0ZaZkExa3ZHYk1GWGowQlo3SitKTDRlaHFMOFY4aGNKR1M2RGRCTllneXYz?=
 =?utf-8?B?cTdHajM3Nm1Sb0ZURnJIQkRCK1NuYVNORW5iMWs5ekY1UlB0L0I3WS81Y2xL?=
 =?utf-8?B?SDlQTFlLQndLY2tNdkl5V29yZlJVZmhDK2VPbVpXNnVZYlFmaXBwc2prdlZ3?=
 =?utf-8?B?NHQ0dXFUQmYzRkJIa21FQVk0RW8wR0JkcHNSZXBLM2tPckVJbG9NVXdJUjNN?=
 =?utf-8?B?dTErNTVqTTMxVVU2TFR6bTcyYTJYOTdwZ0lDOXNDZithbFgyNUxQbWpVbm12?=
 =?utf-8?B?MlBVTDBPTjFDbThYTmFpNUxONUlieXhnMStpUzBpdVpQNkQrbHp2WUJsRUdr?=
 =?utf-8?B?aDBnTXhYWW9ocUErTEI4MTZIb3hZeW5Ca1FlSmdaL2kra0R4a1VhNHRiTlI5?=
 =?utf-8?B?SjF2YzI5eVRPNGpxNUZoZ1dEMCsxaEg1Mng0d0czcUFZT2RKUUJyR2FHYjZB?=
 =?utf-8?B?RmtnWEwrdEpyK2trT3JqbnI2UlVLdWVrZ3Jhd1Q4clhsa09LL3dnc3VhaU16?=
 =?utf-8?B?WWN3YjZDcVlNM05CSHBEb3pnK04wQUM5ZTNCQ3ZLU0dBWUJta2szMVdhVU1R?=
 =?utf-8?B?VFVQNDRZVm42alYvYWYvRWRMUjlwLzJ4elp4Vi9kMkpvTWhCNWg3SS94V2la?=
 =?utf-8?B?RWZCdCt4a3Z1YlEvVXh2TE5QMXJ2UjR2dCtYR1JEY3BsbklFeGJHUmJmcHlx?=
 =?utf-8?B?TTNJOTRjR09NL3BwU2xpQ3VvUW5ReW9NWFdSNXo1dms2c0NXUWFmbnpDNGlT?=
 =?utf-8?B?L2oveGZJUjArSmRxSk1IRHFSVXpFc056NHpqM2NQREVYR244SkZMYUVTRzVU?=
 =?utf-8?B?R0xzSk5TeDFuQXB2dWVjYVJrZlpVZWFRQlJ4Sm9sRUQvbWZUZ2ZrUUhENnpQ?=
 =?utf-8?B?R1g3bDZHazg2bjB2bTlLL2UyUTlTd1I2NEZhWnplRnl3WnQ5OGMvMmFVUTA2?=
 =?utf-8?B?Y1FROHNueHhNMDY2QWVhaEhuTU56c2hXbm5SdHdBM2xPWlpHYmtDeHQ4YU1k?=
 =?utf-8?B?SW5LV3VUZS9mOEVtU1lieU1qSGVqUk8vdXVmbDZvc3NURHo5MXAwT1ljWXBN?=
 =?utf-8?B?U3A2Ni81cUl0TkNLZUZwYTRLUy9QaEcyTkl3N05ScFFZNXZxeVc5UjVHS3Rm?=
 =?utf-8?B?clVqUSsxcHE4b1R1TUZDZ1d1aFB0SVZBNGthc0liVFpCTXgzbE1talhlZy8y?=
 =?utf-8?B?WkYxVHlTUWtZamYvQ05NNHFBMEdsYTc1Sy9LbmQyc0ZXcS93cnNXbjZOZGo2?=
 =?utf-8?B?bllXNzM0OHVaSExZSkZKWWdSSjlmQkZ3OGtHTDdzM2MxKzE2NVBocGJJN3dC?=
 =?utf-8?B?VWhiWDY3V0JZUXljMWdjLzdWUTEzMTlpa1NLRmlvWE1JQkUwclVRZGcwbXdX?=
 =?utf-8?B?UjIrWTk2c3RBb3ZqTVR3STZwTmhaMEx2NlBOMXhjV3JXNUc3VkVyM1pCWUtx?=
 =?utf-8?B?RzZDWTRDM0NqeUdSRmJiZVJvRkh6YVpxSVd5U1lMeW5pQ3ZjbHpUeUFuV05w?=
 =?utf-8?B?dXB1ellSaGJML1Q4VWNjV0dJRnJ3VXgzTUxMclZ0S0FuUDd4ZktBNElybHZ0?=
 =?utf-8?B?R0dpVSt6eGtMV1FEQ1lUaVJWbEwxeldYb0NTSC8wWHVVTEluM2tLWjB3V1Vh?=
 =?utf-8?B?bnRraGFTWnlPdUYzeWFIMC8rQlVESUVOeW1IMTRjZEhGRUV5STZxMDhabTJR?=
 =?utf-8?B?RW90K2JPSWdHRjF0Y0NoY1U3ZTNULy9YUzFVNEd0and0Yk1HMzVVWm9pbHVo?=
 =?utf-8?B?QnVmaEVhY2Y5Y1hvQkE3MzJaWThNSWNoaUNQMTRhUUttdjI0dnNIVDI4N0FF?=
 =?utf-8?B?ZE5ET3QxSkJRWmNyVWI1TW9sU2VZQzIvQmJINEhKNTJIRHBUM0tuRVQ0RElC?=
 =?utf-8?B?MHBoTDA4Ym9mdzM0WkVlZGtZZ25jQ1ZvZ01oUXlXRllreVRkQWNKRTM3VU1u?=
 =?utf-8?B?bVhTVkI5YWYrcVQxTm00WDFyWTAwY282ci8vVmVGUmdJZ2VqZnNVdUVGUE5v?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf43db60-8af2-4a94-aedd-08dc36944e1d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 06:29:37.7252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywOchhtALhD5V6ZUv3GUUV7j0c67ZYywPd1hsz47CFlLgmS3jqa0lrXeYsuOVCKndejwpz1XV1OLDVzY1sYVCJ2w8vNwuC8SuHyy10tie38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7624

On 2/24/24 12:44, Chester Lin wrote:
> Hi Ghennadi,
> 
> On Sat, Feb 24, 2024 at 04:22:30PM +0800, Chester Lin wrote:
>> Hi Ghennadi,

Hi Chester,
>>
>> On Mon, Jan 22, 2024 at 04:06:01PM +0200, Ghennadi Procopciuc wrote:
>>> From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>>>
>>> Add the uSDHC node for the boards that are based on S32G SoCs.
>>>
>>> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
>>> Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>>> ---
>>>  arch/arm64/boot/dts/freescale/s32g2.dtsi        | 10 ++++++++++
>>>  arch/arm64/boot/dts/freescale/s32g274a-evb.dts  |  6 +++++-
>>>  arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts |  6 +++++-
>>>  3 files changed, 20 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
>>> index ef1a1d61f2ba..fc19ae2e8d3b 100644
>>> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
>>> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
>>> @@ -138,6 +138,16 @@ uart2: serial@402bc000 {
>>>  			status = "disabled";
>>>  		};
>>>  
>>> +		usdhc0: mmc@402f0000 {
>>> +			compatible = "nxp,s32g2-usdhc";
>>> +			reg = <0x402f0000 0x1000>;
>>> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>>> +			clocks = <&clks 32>, <&clks 31>, <&clks 33>;
>>
>> Same as I have mentioned in [PATCH v2 1/2], could we have fixed dt-bindings to
>> replace with these raw clock id values (32, 31, 33)?
>>
> 
> Just found the previous review discussion in v1:
> https://lore.kernel.org/all/f54d947c-58dc-498f-8871-b472f97be4a8@oss.nxp.com/
> 
Indeed, I switched to raw clocks instead of placing them into a binding
header after receiving this feedback on v1.

> What I'm worried is that, could these raw clock IDs be rearranged in the
> downstream TF-A? If so it would cause ABI inconsistency and clock issues
> since the kernel is not aware of any raw ID changes in downstream TF-A.

These clock IDs will become immutable in the downstream version of TF-A
once the patches get merged. This will prevent any unfortunate events
when the Kernel and TF-A are not in sync with regard to SCMI clock IDs.

Best regards,
Ghennadi
> 
> Chester
> 
>>> +			clock-names = "ipg", "ahb", "per";
>>> +			bus-width = <8>;
>>> +			status = "disabled";
>>> +		};
>>> +
>>>  		gic: interrupt-controller@50800000 {
>>>  			compatible = "arm,gic-v3";
>>>  			reg = <0x50800000 0x10000>,
>>> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
>>> index 9118d8d2ee01..00070c949e2a 100644
>>> --- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
>>> +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
>>> @@ -1,7 +1,7 @@
>>>  // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>>>  /*
>>>   * Copyright (c) 2021 SUSE LLC
>>> - * Copyright (c) 2019-2021 NXP
>>> + * Copyright 2019-2021, 2024 NXP
>>>   */
>>>  
>>>  /dts-v1/;
>>> @@ -32,3 +32,7 @@ memory@80000000 {
>>>  &uart0 {
>>>  	status = "okay";
>>>  };
>>> +
>>> +&usdhc0 {
>>> +	status = "okay";
>>> +};
>>> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
>>> index e05ee854cdf5..b3fc12899cae 100644
>>> --- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
>>> +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
>>> @@ -1,7 +1,7 @@
>>>  // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>>>  /*
>>>   * Copyright (c) 2021 SUSE LLC
>>> - * Copyright (c) 2019-2021 NXP
>>> + * Copyright 2019-2021, 2024 NXP
>>>   */
>>>  
>>>  /dts-v1/;
>>> @@ -38,3 +38,7 @@ &uart0 {
>>>  &uart1 {
>>>  	status = "okay";
>>>  };
>>> +
>>> +&usdhc0 {
>>> +	status = "okay";
>>> +};
>>> -- 
>>> 2.43.0
>>>

-- 
Regards,
Ghennadi


