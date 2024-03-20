Return-Path: <linux-kernel+bounces-108721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2704880F25
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7901A283E22
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D8D3BBEE;
	Wed, 20 Mar 2024 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="kCOrQ9O4"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2109.outbound.protection.outlook.com [40.107.255.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AFC3BB50;
	Wed, 20 Mar 2024 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928562; cv=fail; b=MvMyCN8twuPIRSjYk/NXFHyi5VRKITOfYaaT8dwq7qFEzqgoCvotyuAiyNLX0TpI8d+iD+xQVAmBRQzdJwkLub0GQB63ZqZyKUynZwgDpQKMbIAv4bFuaNStHoDpGMqq732ZbwSOx8oPqP5MeQyIKhwqiL4AKvw/su5H87jxqQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928562; c=relaxed/simple;
	bh=ubT5YCQMlAGiVXZ64f/pkeFPAhimtX5FVeIlo/bt3wc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xv+i+SkmXNIO01o9ghBpVyi5AJfxR8UpqULDIFvKor3li1zm9Ng78NngVmm9PWw6lNhVmvdHVX+iwYPQMncDc0FIIiq8pmC6Y8TWo9zoEjkHrjCzuAW2LS/uR1bes8YNUDfe5T9YMuEFeBP3QN7SKIq72X2Kq0OkSBVKfVb73XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=kCOrQ9O4; arc=fail smtp.client-ip=40.107.255.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDWoEoJuPUdQIrHbXrebIyK44EQyz96e2Gqtc29JML0i0x4Pv/JhyESmR6ob2HueZubR9iyhxrLc77pPTTiMs9R2sO3boN02Il/DdxsX4IT4IOXsuKAJThEZmQ2vpRPojSm2l/YGCXx4Kh+ikwRjhcz9ZeJTQRxwxuAClXDI5+gxVIWVfaxSDXnHJhBafzMpn2aT+lmcqRspoZX1IV4zACCd13KrKcD1T8B8dTuZvApSPndQU+TKtTWoeTWkYnGVbf7wrp1hL2BkV5TLbJp1vfWmRbxZGsCECb2N+HzneysHsJblVS/OnbfbXdVT6hdVNJUoHhFdykEk0HawMhooYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBs7azawWWoLtD4h7uQfiNC6pHAOsxdxRlQ6R89pL8g=;
 b=VTiya+u6ggTX/ZD20AT1tYkP3w1Rb4pQTas7iCUburCOUSiZ9TXbdteScH1lVsoydZ9ZcaX6fo2d6eiNAKxsvl8Dr0SB0ayZvNA0vHca4d0vlXXBITIwVkMw5rtixke/NqYLtF9CoghAdTcdZGpbIi5XJnA4AREbi2tC5323uidXhll8GE9+dORNjse5rjFtLNsTjOsuRksuUuxIqrdcmrt63mbNdF3JvTsg5xBrDCrRjfF3fq5CD0xfQd2evbW5vSGpoIrFi49MlO9zFa4z8K1dh1IkSv5REauxhZHFHSeUtj5AiuAGGPGfi21C68dkTPMXJAaqddVGjo1pdevNPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBs7azawWWoLtD4h7uQfiNC6pHAOsxdxRlQ6R89pL8g=;
 b=kCOrQ9O4AQX7AQuF3kgrTiUi5obGuxUMWjDVqR1ChYR+XIl/waCRWwttZtDSMdjGjCu4cYN3eH3nyRW6DbP++zhVm4tj62dth4p7AtiQk363Tzqx0d/JBBZTN7mWKJuynSa8vwVqJBnJt/uiklG8zCz2jVfYTbU+PvptakGrPy31Qqk/uSNROwXb4cpUm/Vt7n6KKP6Bunm4r5OpeVDQ3tplv282Ja38xH3G4XLU7GjBLRWOu4Zbu/IIXp6FP2wrIGXZiKkieP8KB2o2xe2weUBBVKKmHpJsNxUpcX94UGSHo+iXSvHYHOm2TFq5tkJcMS+40tPc2ph2X0YQ1QHaGw==
Received: from PUZPR03MB6888.apcprd03.prod.outlook.com (2603:1096:301:100::7)
 by TY0PR03MB6882.apcprd03.prod.outlook.com (2603:1096:400:265::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 09:55:55 +0000
Received: from PUZPR03MB6888.apcprd03.prod.outlook.com
 ([fe80::c706:407:1c6b:ab17]) by PUZPR03MB6888.apcprd03.prod.outlook.com
 ([fe80::c706:407:1c6b:ab17%3]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 09:55:53 +0000
Message-ID: <a2f64005-bb50-4d3a-afc3-a8db57f4b2b4@amlogic.com>
Date: Wed, 20 Mar 2024 17:55:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for A4
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-serial@vger.kernel.org
References: <20240320-basic_dt-v2-0-681ecfb23baf@amlogic.com>
 <20240320-basic_dt-v2-3-681ecfb23baf@amlogic.com>
 <402e56ec-7fee-40a9-995b-b737d4a53d60@linaro.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <402e56ec-7fee-40a9-995b-b737d4a53d60@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0090.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::30) To PUZPR03MB6888.apcprd03.prod.outlook.com
 (2603:1096:301:100::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB6888:EE_|TY0PR03MB6882:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+SPGOW9AZpOSUEc9X5lGlNbbrnwx2q04I9wNz33tewD+uPJEUGcf8oGRasddoA6I8nZ3nQ1lG28JJD48ZQ0BBf3lOPeoCg3B1shaKAGhsX3YphR7yUC1UtCfxaMbsBq5UE6BVJ/d0UH1e+FpvUq94iAc4bBHgQ4ZQWHW6FQLVCEJg957FDISUE6OiiozY8wwscVUCSnJRipBomsL0KU8lumjToCx5wszbTU3F+MkPt/rnfuw3sya9UsunkP875IFo8PqWy/gYxghMRXpGlV31utYiFLEF1FJDyqXs2fcNelgcx/mMP/sqA9lWP7fYxwcfbRvAveC88HEPLTp6OER6UUQOUPBcB1Gr8M4rke5pJzyGO530/p/MGck7cbRQK9EBzJFcpgrdWrdk28b2dYFK7bVzGf0uqRoasmqE1WJlHsjZcQqUDSllfaQwZuMWHmwGgFrKvmOqp1s/Euq2pyZm2MeDENAotgwEOiyqZhm2HYQVwTCad2MpWtkpavc8KPjJyBP5EkgVWlczE/CaUbOsotqJCQzcekxcLbT1pWsbF+S8bEUuUaWuuu3txf+7bdd+dyVnqOt9bcwUUefUYcobZlaQk7R4HHPTClqnr6q47gJXWi3g9vGma9hKli2rxivGQwRtqqdAziczZRvIGELn6TPiuuNs8TuG2H/ZIKn3Rb8CKNQJJuS1KqzPZVA9fsKBzJqarSEZyTHJ5voCrJLQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6888.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlB4cUprRGh3NzczQ1JKUTg5bzBVTW5ZdUFRZndTZlhyL3JJRzRCSGs2clNj?=
 =?utf-8?B?TUlmVU4wb0Mxek5vNG9NUUszai9Xd3pMSVB2ZFVpSEZVUWRMTWZjUk9wNUhx?=
 =?utf-8?B?MVB4ZUdUTFBxcXp6UzR4MHVBUU81MEFNUUlJQkJkQ0NKYUEreFBhS01aY3NO?=
 =?utf-8?B?YXB2bng5cVdTcmczMFVwYzM3dlJWU29RamZnSzJLcnljcjAvMW5kaENFZDVm?=
 =?utf-8?B?bzlrL05vMElsQk1PdCtwV3krQXFiSzJFZE82eDViMWNZTEdxdmU5Q1ZLWk5L?=
 =?utf-8?B?OHoxZ0xzR0hKa3RGUjdDaS9BS1ZhU21tZ3NFR2owcFFpUHR4OHRvZVA5NXB2?=
 =?utf-8?B?UlNiNEloR2Fyb1FZalhlVWhrWisrK3BiMHVrNlRXTmFDWEkyMHdkdmNuMjlD?=
 =?utf-8?B?U0hFMUl1WHRaT2lFUDJaQ1pVL29Ea1htdnFFTGhxM3VIQXk5RkpIK1lWS3Vh?=
 =?utf-8?B?MmtRYVZPa2VzWnBhVXZBVjV5a1VvdXAzenFvUkRVenZCQ1RKalVJbTZWL0s2?=
 =?utf-8?B?dmd4cEVVTForMDZrWmZxZU9rdEFjeThSK1hsQzVVa2t5UWJWSXZjZnUrakZo?=
 =?utf-8?B?OGxIQktxcU9OZE5wYlc3QlRpTmpzeDVMUEFkSGNRUS9QSEYwOUgzL2xySDdJ?=
 =?utf-8?B?dHdzTXhqUVhrc3U4OVFBa3I4VG42TUFlU1BPbm45NGVhVElvdnFQZExoSklS?=
 =?utf-8?B?SkNKdDJJMThlazVaaFJiTGx0SVo4TTdncld0SW5uQkxsaWZJaCswUkRqMVhq?=
 =?utf-8?B?Q1RpT0s3dlVOTUpJa1VCZXNOalp0U3puMjlUZVV6YVJmYng4N0VNT0ZQM3NQ?=
 =?utf-8?B?ckQ4Y0xjS0tVaVJJVXRWS1NzRXhFVHl2SVR0M3V4Y1VLTG1XWEhtSWVZeW9x?=
 =?utf-8?B?VnNrVWtJd05EdTVuQ09yTnVZMGxnS0EzajRwNGlTTGZhZFU1SlpoVFhoWVRh?=
 =?utf-8?B?a3hJUGxEZUV0OWUwU3Z5SFhvM2J2V3FJUEFTWTJFa3VqdzJ3bHJ1aGFqWU8x?=
 =?utf-8?B?TXBtbk9ac2FHOFUvSXZRUzlrV3ZiME45cjB5MEJpRFVjWDZuQjB2YnA3bkRJ?=
 =?utf-8?B?dE5ZSGpwZnpWUVd1aVg4VVBzeTljRDBtWVUvMlc0U0JJOS93bkpucFVQVTU4?=
 =?utf-8?B?ZmkrNlRvQ0gvSFRDREI3N1JIVEdTNExCVERTZEJiRWtMNk5ZRjZWVXJvSTZ3?=
 =?utf-8?B?SU1COVhTNVpPUGdJNmZwUG1vYjBZOG1LMGpNZ2IydnltVUR5UTFIaGJwZDN2?=
 =?utf-8?B?SEtxL3ZzNTdIaU5HOElNU0QzcUxSeHZIZHZla0xLYnVseVVPemRNeUFKeStT?=
 =?utf-8?B?ais2Y3NHcnkyMUI4RlEzczV0RStjZGVEZWZ4N2xDSkQrRlBMUUhuYm1YMTQv?=
 =?utf-8?B?T3MzQ0VEQXltZTA2bEZNNk1raTFPd1VJd1oxa3RRTUl3UUpiOVd3b0VZeGor?=
 =?utf-8?B?N280RjJVckNGd0xaK2t2RDZkY3M5VitZZEJKTzFFV0x2amlVK2Z3bFdDL2J2?=
 =?utf-8?B?S2l2Y0pxSE5VM01jd2dnRzU3WTc5TjI4R0p1UGc0dVNINy93Z2t2dlJjV29T?=
 =?utf-8?B?VFVncHBVTk1aeE1yUEx6VFFnVDBrTUgzVkFZRGI3REw5T1cydWJRYUhOUExp?=
 =?utf-8?B?eVAvSHljRktwNStUUndxMnlIMHB1VU94aW5OMjZjVUY2OU1QTWQzUGZaQUVK?=
 =?utf-8?B?NisrMFdFZ3VKbUNJSnFMTmdRN05DMkVyWHNTcUNKRmJDL3ZZOXZFUHdaZ2Va?=
 =?utf-8?B?Zi81K1FwNkJCRDdpWmpBTlJSU09Bb1FTV0hoMmNzckFQd3NxcUJQckJoQmta?=
 =?utf-8?B?eUdFOWxEOHBCc2dkNjFWSk1RTGtxMk9HSTJJQThGWTVQTjI5SkdncDJpdEl3?=
 =?utf-8?B?eVB0OHdpa1A3encxTDNHVUxLLzkwTWlXS1czVXhTeUw4Y2liK3Yxb3c1T1hw?=
 =?utf-8?B?UWNTMmtlMEFZVnpnY29vdXYyRVB6RkIrcEM2aThlSC9VeW13TkcwaWtIcm5G?=
 =?utf-8?B?N0VNU2xNUFV5Y2JsRkpFN2t3R2h0V1FPZkMzenRyNzE0VEZpd1RLRzJkcWFR?=
 =?utf-8?B?bkRuNVNWc1N2SnpQaTFJa3J3YmlGeG5zM1JIckh3VlBaenZpN0dNUERidzdM?=
 =?utf-8?B?Mm9ETjhUWk5XaDZRdktVOWtncHFhT2RMQVhJUldkUHYzRmN5MVllTnlKbXRS?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b167fe6-8b9d-43a4-ee60-08dc48c3ee1c
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6888.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 09:55:53.1270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2k4TONygbQnIETObjg1WVErH2kkd48umLdAhiJ/Dgc5GTjTFW/+MO2sdCbjAmjvpk+mKKX5H/AfacK12fEUlC3dImZkL9GpjKiKukM37Vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6882

Hi Krzysztof,
     Thanks for reply.

On 2024/3/20 17:47, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 20/03/2024 10:44, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Amlogic A4 SoCs uses the same UART controller as S4 SoCs and G12A.
>> There is no need for an extra compatible line in the driver, but
>> add A4 compatible line for documentation.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
>> index 2e189e548327..d05c45815dc2 100644
>> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
>> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
>> @@ -54,7 +54,9 @@ properties:
>>             - const: amlogic,meson-gx-uart
>>         - description: UART controller on S4 compatible SoCs
>>           items:
>> -          - const: amlogic,t7-uart
>> +          - enum:
>> +              - amlogic,t7-uart
>> +              - amlogic,a4-uart
> 
> Keep alphabetical order. Don't add stuff to the end of lists. This
> comment applies in general, for almost all your patches, so also future
> submissions.
> 
Will do. Thanks, I remembered.
> Best regards,
> Krzysztof
> 

