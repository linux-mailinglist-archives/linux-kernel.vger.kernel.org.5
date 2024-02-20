Return-Path: <linux-kernel+bounces-72804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DE685B8EC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4070AB2B79F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302976166E;
	Tue, 20 Feb 2024 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="n7Ag8Kv/"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2017.outbound.protection.outlook.com [40.92.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF2664A9A;
	Tue, 20 Feb 2024 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424230; cv=fail; b=uoJqzKwIP6nITv0AuEaozIslrE3i0IDIDdeHh7nsf31PaMT3uZHFiogI/FR9W2Pa5FCzIMwAAVAB1jJ6ChvjnEq6lfiiUXT7uexdVBc/ahzX1Q4ZGt8rX/IZ4Kcekb+6kQoaQTkW/UM6P2HEy7a7ypHTycUx/nAbseoB6L5U7lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424230; c=relaxed/simple;
	bh=0IAsb8AYPdJn3EYsjU1R8C9vf1kKgJsZorTVHpNV4Kw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XrtvevUI4Ko7GI3lVZd+BOnJ/SHILOTn5rvAmhG1kcPUOB5ha1H10/8DAfTbBsiHRno09LQ4yhG+kKKN/9xbGgefc/6/xOH1DC9ck/98LjzaSqrcUH0Jik6kWIhBXnwLCZMxlL2907HYsxQB1nYbHdwM3zNQQtSIeRV02R9pLmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=n7Ag8Kv/; arc=fail smtp.client-ip=40.92.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpRY0EBMTGeo3FkZHZIryvfA1X/TsF2YqIqlytDG1B2WoOPv0XuhBv0oKMHgivr1ZkqCRuYZEjm7o8BuqD8SQ3WqIUTkX7PAQjlRm/GF3OXtYy4pNG22CvP3GrFLRqqLxHYtzlGtwXGyMDaShvdS6jguV/GpOxOAummJWFMHh+r9ougIhL3eYqWo4obc3DTPPqft94INGdVuThidFzHiqnDEoDs284/jMcj372YORgWDBDor6TCURBEXNOVTu79vzDlwzwv7aXzUqWMrEB9Rfoqy6djzK80ufKt2haZwGPZ1EHCgf4sCsgXP0EnHc9D7iHijXlZBqggxWtTrGD3fsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXgaYrCiqVf+qB6zHAiIi7msyjYK2/XZWr1QmhEMW88=;
 b=Nm7PXtVop9Ul5247nby5WcX65GFmfU3wtF44Xv6Wdslki6srnjHZy+uXlCFZ5swweoXFoVe3GQ2HF5BTLFs5c1Gc0f/CF6bLKSwZbRgFi75qxVbpECoe2cjwXbSX9Zx5rOdOI6ffLcyPIe+3eai4XZx2D4kOBpJtv5GzqlyaxYWg03FDJGCgp/AkwhoTUoueOPVVFhyKerOa8S+/+kpnqC+MS2v8tpd44AGFCyLRRmlxm2GEX9CZVDUDJD37PbHCulzi/VnGE8767UdQoLFKL5f+TLK9T892oMlg7bCb0tjCDS4juHY5A4W+iEDnDXTDqaT7VIhWSdbJj3LCKgY1qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXgaYrCiqVf+qB6zHAiIi7msyjYK2/XZWr1QmhEMW88=;
 b=n7Ag8Kv/Q2WG5D6OUF+pwCoZuvHWpnju7VXdUqdKJHfc6YJBJgO999t3P/w7sx+3VwtDvObwCj58Rn8GQgi6rDBshFFcQkef+iliQLMDII7wNhS+SlEobQBrghXcV5jaRw5XX6XfGmXX9VmiQ4JvTiY+w3mucFz44G3hAAPWU2cekh1KwtxG/2XNdDp/vEfXsxsPbrSW0psstNPBYmGfM5g7uZqtzh4aaVHmmPuiIXMQsfkmCx0fxAqktPijyMetIrfVXSnXmSJpb/meF0LQF/p0xz0dmLo18lJRbjDYH1ZF+QRhKLqWKi1GuieTEFSKYqYPA5GTs9J9mLHDADBUsw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEZPR06MB5574.apcprd06.prod.outlook.com (2603:1096:101:cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 10:17:03 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 10:17:03 +0000
Message-ID:
 <SEZPR06MB695917EF191FE7537CCC559896502@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 18:16:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 5/5] dt-bindings: clock:
 hisilicon,clock-reset-controller: add Hi3798MV200 SoC support
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com>
 <20240217-clk-mv200-v2-5-b782e4eb66f7@outlook.com>
 <ec0f1536-098c-42da-993a-a98f68f4eff1@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <ec0f1536-098c-42da-993a-a98f68f4eff1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [sTM+VElmxJzdCOk2I4dUN+DJFGJ2JxwOzX+atQf9/sZ63vKyMr6tMIPzUa01pDKC]
X-ClientProxiedBy: TYCP286CA0009.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::11) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <f0ad7dde-8522-4345-8998-a93af540e52b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEZPR06MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: 577416f0-7609-4de8-8a49-08dc31fd1537
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zd9gEbarB1xVFEfsrTumrKzLWsL9KwdxnvkY/Mw0+XDa7jhxZpXAHH74LckOsJ45FTuLkz0t7HBnGq+EDmoe23IPR7L8XS5Eg9aiuLV+Jc/3qy2OdJxgERD3/AYOT0JFCzYOipH1xpFPemMh6+2xxwOC1IC8rzSml8HLYZWbZ3vpHUd1F+l/34YGSy4LwNY78fEZtOaKam5h7uav9+atMAIEwbgg94v23RpGQ9Wz3XPvFeeq0TkNM0l6Wh44R2N/gl7p59T4S1zA32IInIHxj3nJpUStQqZHYnqs/eR/FDU+FVTNxO90f9QiktjsdMQJdxvVMFdmB4BRl/QByRjyXvCBnj4w9Dr4tTNHgxjzyzglI/xWw4D+op5sAxxVPzyja8npcNdt6qh6w7+45VlflZbib2yiylAVBXv0F1PcribNnaJQtNZ3ciHohGe125EYKVHAalAPW7KWTLrGNK3paBb/qFN8louyArAj5KVDhIWqVBoN3ISds21x5XBZ0VOQeg7UBX7QYi+pSzZ3+FuNBH043rnrbmqUvzo5CAMDytzaNolKRvZAKYn5luxRCUsQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUUvejJpd1VRTldIUEtydHFNaXJJd0c5VWZFMXJZQjJRQzJlYkJrUGpqRUZy?=
 =?utf-8?B?SmhlQXhJNkU1UjMxYUJ2MWhueTVUTU5oSVpEUXlHNmxYSWpxQ2RlRVFhYVJm?=
 =?utf-8?B?R0x4b2g1R3VIQlE5aVhWc0paNDFwb0ZzcTlqeHFrdWhHMnlTNDNVaEFMVlBx?=
 =?utf-8?B?WFA3SnhrWkNjL1dUM2xYWEhQWE84UmNna2l0ek1KS1dUbEhTb1VnL0ZVcG5Y?=
 =?utf-8?B?OFk5OUwyTnlQYS9zOVljU0tQU2hiTDZCVHNWMFRzSExvREtFNmdwTEFlYUxK?=
 =?utf-8?B?aGNhOSt4UTFqNHBPSGdGcG4zUEovNldBSHlveEk2MjJEWE1Zc1F2TDZCMURh?=
 =?utf-8?B?c29YMzhJdm12UUFLQWZOTVVxK21jeHl4WDdZbkgvVlFZQ1VhRkI5TTRsdThV?=
 =?utf-8?B?N2t5SWZ1cWFpVkorRXNXN2dsMVB2T3RBZ1ZNb29KRnptWDU1dmJ1cGRCcmFW?=
 =?utf-8?B?VmUwKzVtLzhJSDFjaXFOMmF2cmNWZURUL2hIYktBYWtJdjFWcTBsQmlSUW9X?=
 =?utf-8?B?WFE3OTF4Z3BUTmV4Q20wblp1dzYxTGl5STRPMlBnUnM1bER3Zk52b0xBNVFa?=
 =?utf-8?B?em5SRXZtaEgrWVg2NDRGdklyb3NZZENFdG9lWTBoKzdIZ1Z1cUg5OWZJU2Z6?=
 =?utf-8?B?MHBRZHptY1dUUTRic3lZQUJtVkVvYlpNajE0Y2YxRUNIVjdYMk1hZ1JCYUVr?=
 =?utf-8?B?Tk1CckRCS1RJZUtUczdpZ1RKejIrbjBUSzEya2xxaVVVTEx3bzVpdmMwWDV2?=
 =?utf-8?B?UVNnWkRxZk5OcDJlZWNnZUFadnE5TUZpYkVQNTNkZG5maGNlZlFXcUFSL3hn?=
 =?utf-8?B?SkdYcjQwTlR3dm5oanJEZlpPaVVudzFTc3MrN0JKRGwzYmQwRGxIU0EwREVH?=
 =?utf-8?B?MUVNVGt5MFFaTjZUcytuM2k0TkhHSG4zczZ5K0RxMk4ycHUxa1FFYlBDMWVu?=
 =?utf-8?B?V2tpb0lrOTBLYkVVQkgyOWFoYkY2UmxCUXlJMHp1ME9oM3FTTXZjTXJqcFhx?=
 =?utf-8?B?VEZHWks3aGd5Sk9TMm5XNUdqTGMyYU5Ibjl3MG5mR2FyaG81bnhxL24zdVl0?=
 =?utf-8?B?c3Y0STZtUWVyR1lWMHVTanRDeUZEY2Fia2k3VWdzaC9zdmtnZThDdUViTkMz?=
 =?utf-8?B?ck9oSjhEMWw3UGVvdGlORnd0bFZwU2JLM1RyWk5UVVYzZmMxZmtpdjhaalN3?=
 =?utf-8?B?R280dzlSbktEL2F1c2tiU1RwZjVCblJRejhxQTIrSEQ4MEFyUEhXTFpyemxP?=
 =?utf-8?B?MWZkaG5MV2MrYkhrcU5EblRkNDV1SnRNelpCelhETUlTbFMvakFjSHBZQ2N6?=
 =?utf-8?B?bFVwWWl6WFN2Y004aHlQVWt0VVdUaFBkNzFsVXBoaWp2T3FxOFhFQ0RkYklH?=
 =?utf-8?B?bEJMVmswNjhXZk13anhDOEVZM0ZnK0gwTGZ3R0V5TGlBeVRnZnUzRWJYclBt?=
 =?utf-8?B?MElvbHJERiswTS8yWjk4QzE3a1NVcERWNDNFWlZkMXl0QU81cnNsQlF6UVZG?=
 =?utf-8?B?SEFucGhKeTJjOUJVa3h4RW9Ea0ZkT05LcVZGTGk2YUJ0M2ZEai9zRlA1Y3Bp?=
 =?utf-8?B?Nk5rc0lhbzRPUHQxcUZmazI2d0YveGZUODROUzI2Zk1NYUlSWjBBOG81dy9Y?=
 =?utf-8?B?UVlKa2JaSFNBc0pEcGN0ejlSNGZ4UlhDZkliUVNBeDNUQUQra1hEOGtIcmZF?=
 =?utf-8?B?R0lpMm5mcGJFR1dHa2x0YTVSaG1iSUZTcXNER3lvbW1NdTlFY1RVTjBCZWRD?=
 =?utf-8?Q?CYi//mvVoKmHQWLc1JeyroXz8HuAR006oKSvy38?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577416f0-7609-4de8-8a49-08dc31fd1537
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:17:03.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5574

On 2/20/2024 6:15 PM, Krzysztof Kozlowski wrote:
> On 17/02/2024 13:52, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> This SoC is similar to Hi3798CV200.
>>
>> Also document the specific DLL regs and add an example for it.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   .../clock/hisilicon,clock-reset-generator.yaml     | 36 ++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml b/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml
>> index d37cd892473e..8ee844574eda 100644
>> --- a/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml
>> +++ b/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml
>> @@ -44,12 +44,17 @@ properties:
>>             - hisilicon,hi3519-crg
>>             - hisilicon,hi3798cv200-crg
>>             - hisilicon,hi3798cv200-sysctrl
>> +          - hisilicon,hi3798mv200-crg
>> +          - hisilicon,hi3798mv200-sysctrl
>>         - const: syscon
>>         - const: simple-mfd
>>   
>>     reg:
>>       maxItems: 1
>>   
>> +  ranges:
>> +    maxItems: 1
>> +
>>     '#clock-cells':
>>       const: 1
>>   
>> @@ -87,6 +92,12 @@ properties:
>>       description: |
>>         Reset controller for Hi3798CV200 GMAC module
>>   
>> +patternProperties:
>> +  '.*-dll@[0-9a-f]+':
>> +    type: object
>> +    description: |
>> +      eMMC/SD delay-locked-loop (DLL) register subnode
> NAK, now all of the syscons have the DLL node?
Oops. Forgot to remove this. it should be removed since it's now not 
used anymore.
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


