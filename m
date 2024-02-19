Return-Path: <linux-kernel+bounces-72008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E14D085ADC3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998F528389D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A3753E3E;
	Mon, 19 Feb 2024 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="d3egwX4c"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2066.outbound.protection.outlook.com [40.92.53.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84F050272;
	Mon, 19 Feb 2024 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378441; cv=fail; b=iWgMEsM66TMoz8t2H+gI9KFc9fVn/RZ9wDtkr2/rQCgfCxO3w3GYvyZHzWjiFCWxTCCGwXTcjI2tFDfW+qYm/xEjs1aJJLsoiTL06tSaTU5Nj4o3Onjkx8Luhnuq/6qK0MwmEyNQXP4h80GxKV9i1uBYT9gObISJHb++fSQdAYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378441; c=relaxed/simple;
	bh=cvqRdeju2e5xAinl47MMXVttU8Btbc9cdp4J/V3joZg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rXc4zcurMCbAUYHhz/oi3D29Ou3CJbKVNTT0VopdI2N9hbXwiY47Mfv1bkKvpK3tS/Fe0Q8kbHhH7UXhjJ5BtXgLcyedH4p7KpMMsfsCkMMHbhMl0QHv9Mke74C/5OeRbpukzS7r9WLhG6f4wDNdjAbKQRNgxL3cRltCxvjLMyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=d3egwX4c; arc=fail smtp.client-ip=40.92.53.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8AscxtsGn56BDGgQ7BZ/o7y6D5GGumwt+R4PIO4PimonuoDg4DmLejiv0vOd3M4RVplgWIIRdZiZSzrTmc4+fVB2Y17MfQKVm6HcV4LoGsN/JCxX55XceQn7hXzK+u1FxUjbwRkbvjliOBTkfhHAKZ9Z32kiuDrHcdSQfCbo/e5uTHQLlyNThDUrrhD3+yi3FbOOzw2TuEKw0Unt675A+4gq9sObBbVstgdCL2tYAyKQ4ZSa3zHmdAjjyPTBFRzDm1QmbqqU/OKzcibvokUFIoSq6/Wj58MGfajIVy+6EKTjix72Bkfi8Je7RbLfQBzK2epjlDE/vyGUkuLEMx23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gYjoGbu+7UCiZIqJmjtIX+dyRtYPRxrSfjO3OEpuh4=;
 b=mTgmRGkSiedJI2y5NkicsNDigmuO5QTPnA878q8hRds0m4ZxsaEOUrYjOMd4KohzcK6Va+OASL6KcmtGuXcgYfIYtBTCYznETEsC45EEQaFbJFln2eoi6EdOxZ41bhb0R8Yt9NiUhLGs0+7PQzp6ALqH3ngQE+Z2GTneCgEuCKgEzYaIPcR4KMns37oKRlzQc6XJDm9zaASc1wt879lLjsPleRq7R6kmC+5DSV6cX4K2LigO9T48NJJofj9Bad3gF0uAwt+p3GLAQ783u+QWUwrRIbPvXBqFLhiW4UB0iEziQzoET3VZIjJCfNpVEg7A3mr0fxNdtZKVejeOiWYexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gYjoGbu+7UCiZIqJmjtIX+dyRtYPRxrSfjO3OEpuh4=;
 b=d3egwX4cFtgtLXYOb6yNryJgsB5OoO+9TIxRU1DTFvHaOf8hlC3TsNy5l1hWfYRFwuvON8V+oNyw0azNZD2GUGMTyS+ywJKWbM3qBBf7UVQG5C1qdlByVQtdGd/Y9KLF+1fB/URQ+QAZsGY1d5TPTW+STkw8poTlq+ygRe6oqigrGR+PRfNTV3/oQNXt+u9z/u9QFhWckjbyLZd5sZVvUMYyAdjYodLHfsSv8OUPNxWK+BnSUmacvp/IJu5NmWf1DabHiSTKD2nV7RqbarTkcBl5KlYaEN5uIizh7TE/n+zYTceu4HCUOq3MWzXrBdQZ11nU1n2X1pDLlzouczxNhQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB7117.apcprd06.prod.outlook.com (2603:1096:405:b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Mon, 19 Feb
 2024 21:33:54 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 21:33:54 +0000
Message-ID:
 <SEZPR06MB69599A79CA066DAEC73BCEF796512@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 05:33:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 1/5] dt-bindings: phy: hisi-inno-usb2: convert to
 YAML
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Shawn Guo
 <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
 <20240220-inno-phy-v3-1-893cdf8633b4@outlook.com>
 <1ed26e53-9f92-47a8-857d-777da512ee12@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <1ed26e53-9f92-47a8-857d-777da512ee12@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [bVSUj87AMRGioo36VdpNbeAcl05Tu1dEDKAmwgPWD/0CPJkBe2Hzm2dzGXXq5xDbMx8JToI2JlA=]
X-ClientProxiedBy: TYCP286CA0327.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::20) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <e08fa17b-8440-4797-b769-530ee2e0d1b6@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5e3ba6-940a-4b33-e31d-08dc319278c1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HHwwPIpy43j/fCsOH97skocjiHe9tkdBSiSSWEIZ+Wwq3LZe/lL/jj2iXpkY7fnC2GBOb4iWNuohcgW9U5rpiD0fw9n6p8ooQCq7vjwCTdaSAahc1UL1z2tLdVP3JHPOz8U6IYFc/virvwhCcpRSsKKoyvDXBN1NCW8XB4vMBa+2RdFhfRQx1GDi2cBNBX8il6AtrI7ynZvGcVzNkhnZY+Jcj/8/OjfuKvzk7JEO1xL+NY8m6DZpDB+EvgskARgNGhXTYfQ/PW4e+l8Rov4BUDAs9IPLyPPFjlO2Ld9UqLXR8jdwPJksjutyxkjURwXp17UUVhwUEEdy6vMI55QtHc6xd7Qk4R24xj5yWRCbfuo/3ovd5oDdKcQ8ZMrD7CdAFA7ify7YncTBvCWUB+bY5Y8Tep+Jc4fMzIgzYTDfBsEIC/a3GuRKqpn6yr8BUI5oDjIOYqcf/894Yt+yf0N/sxzsy20MtNrEcobHC9kKBLTbHkyWinZ9GFNBc26a3PdRoUhtDrwL5Oq7gjrQ+IrEvIXnJpL/e+9SGEavrseG37pDUFUmdWTWByqXvNhGs5+l
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0o0Qm10YkdvWmhFdnoxdTN4Zm9UVGdyOTlPRzFvVUJHVmREc1QzdUdJNFJn?=
 =?utf-8?B?SlJMU3N5QnFieXEweWdIMDFvRURTYStNa1Y0RDJvRFFuUkgwU1Y2MkZzRHhK?=
 =?utf-8?B?aTE3QWp2VkdJSEl5RkVYcVNoUUUrZnNDblhMb1pDQ2xIVVJZK0hwNjE5UVJ3?=
 =?utf-8?B?UDNBRXZFeVpoUTdWb0wyajYxK3NEa3NzQjFsNnFnOXYrZkhBS3RuWWFCSFRG?=
 =?utf-8?B?ZGVGMnlrT21sUHNueHZKMW5PbmhaUmhVbURMd1N4d3g3K1AyVmVXK0o3U1RT?=
 =?utf-8?B?S3BhTjNHZHRlaWh0ZkcvTHNKSzNoRXRzcXVzUjRMbEo3VkJIeGdreUdoWFBw?=
 =?utf-8?B?UG5LNktCMEFPMTN2aWhCR003Z2JidHN5VkRhZGdkVW8rbGRLdUtCZm9ORmdo?=
 =?utf-8?B?dExma2hOemI3OUR2U2VCbDJBdHpGOFlzTXVJUjJwbDdSendkVnhGNGZsdWZH?=
 =?utf-8?B?UzU0YUdCSU9VZFRpeDVWNCtOZWxXd1VKVjk0Z2xpSXo0b0Y2cTF4dytzSmVj?=
 =?utf-8?B?d3RBTDBVTTdQTU84bGlaZldQOCtoTDUvYmVWd2Z4aHpOTGlldUZ5b0x5OHBK?=
 =?utf-8?B?SVk1U2wzbUlza1EwTXF4ZU9TOXpQdTZwN2VYdld2RFNPRnV6bERaS3loeFhX?=
 =?utf-8?B?dHF5R3R1Vno1VmltMFkrWXZHSHJiMTcxdGxVV0J2VCswY2ppckcwRFRzOTN1?=
 =?utf-8?B?WXVWN2hId1ZocjRTeUQzUHEyWExYc0tlSThreFRlU0hXU0dtNzVnY2o5UDBp?=
 =?utf-8?B?ODZTR00wYXg2YXlGV0EwUUN1VTBIcGtCZ0xtOUJxS1JZdGI3bnhGeE5TZ1VI?=
 =?utf-8?B?eGZlWXhNcEpydTNxam9uUnlqTFFDZ05jV3MyQXBleUJtbVBjS0I5V1Q4ZjJB?=
 =?utf-8?B?MUlJRVNrcy9pUlZEWGdVNldWMFJLWW85VXJUM1NIZEZ1by9JbFpWL0VtaWxr?=
 =?utf-8?B?Wmw0QUlmOG9FMk9jazUwamtpL0NxNFdscWJUaVltWDJwNTZrMzJqUW1pdzhB?=
 =?utf-8?B?NlBkN205blhFK3Iwajk5a21GZG10V2VXV1E0YVRsWDUzZFJiVVJSbVNJUEZD?=
 =?utf-8?B?QVBuNVQ2WFROdGZkMlBqbmlzUzFSY2ZFd1FIUmxpNFpDT0VBQ3dUa3JCUWtQ?=
 =?utf-8?B?ZkdneTVXMUVYMHl0YXFLeVVDdEtVU1hSV0Y4czlDR2ZaS0N6bWtGODlxN3RX?=
 =?utf-8?B?WHcwSVBOSWluNjNjVFpjWTNKNCtSUFVkeGJMeFBqSW9IZURMNkJmcjZvMmlH?=
 =?utf-8?B?R1JsTWdXUXJNQ0NGakpLV3RwbGhWU0RkckoxYVZWS2xZaTR1ZWtoY0txMCtI?=
 =?utf-8?B?RlZkS1pGRHFSeXMzV0dYNHFPd3VpQnJzK2tiQVliakh6Uld2SmwwMEtzS2Fw?=
 =?utf-8?B?TUdHOU5pd1hTMVZER2ZBUWk0S0hiT0F0NHI0OEN2RW1WOVpEUzI3VUU0aHV4?=
 =?utf-8?B?Yk1iOGtRVWxHWm5vOFlKSWZWUXZ2WkZhYk1VQjNoK1hOTzVuTmIzeS9jOThG?=
 =?utf-8?B?ZGU2enVEN2ZTcUlkeUtXSGg1SFh6RFV6U0NlQm4vZ2JQYTlyQzUxZkw0YjFk?=
 =?utf-8?B?blFFT2YrZmNBRTZoSEpwcjloU0xCTmVwbFo3ZXZPYUk3SVl4TzlIYk11U2hx?=
 =?utf-8?B?VEJSMFRuV3A5QWdBM1RjRmVqelZEYThDUGhLL3NCMXRYOHBmYitMT3JMclg2?=
 =?utf-8?B?MEMwaTNoWmgzbmtqTkNGOFdodlBiWVI4WXlkRHdVZVF1dlBpNTFxM1E4SGYy?=
 =?utf-8?Q?XzzuulTxbMFAz83DmPaOol05A+TqY/6WgqS8Y96?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5e3ba6-940a-4b33-e31d-08dc319278c1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 21:33:54.1868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7117

On 2/20/2024 5:30 AM, Krzysztof Kozlowski wrote:
> On 19/02/2024 22:27, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Add missing compatible "hisilicon,hi3798mv100-usb2-phy" to compatible
>> list due to prior driver change.
>>
>> Also rename to hisilicon,inno-usb2-phy.yaml and add this name to
>> compatible lists.
>>
>> Fixes: 3940ffc65492 ("phy: hisilicon: Add inno-usb2-phy driver for Hi3798MV100")
> I don't understand what is the bug being fixed here. Binding being in
> TXT is not a bug.
This commit adds the compatible "hisilicon,hi3798mv100-usb2-phy" to the 
driver, but binding change is left alone.
>
> This wasn't here before and I did not ask to add it.
>
>
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


