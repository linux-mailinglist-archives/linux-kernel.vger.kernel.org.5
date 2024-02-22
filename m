Return-Path: <linux-kernel+bounces-77055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB60860092
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09D41C25276
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4F5157E99;
	Thu, 22 Feb 2024 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="T5MTSX79"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2019.outbound.protection.outlook.com [40.92.53.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EF62BB01;
	Thu, 22 Feb 2024 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625597; cv=fail; b=LPMX/GIe2ZvLib2AAQIB84NTcckCbykY4vG3x5JapaN7rF8bB41oeNGNEAFQZpUDT5PSKaENw32hBmFKeP5aiXZiT8omN0wUlR16uR8EsTM0siABvSnh/YHmYmjSiAL/dwYRpd9nL7KIeMdT8Sp/zkkHp/Y9x1wL9sPkcUT3DLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625597; c=relaxed/simple;
	bh=fcGqX4Jbf11oniWlnVaEswwZqffOTlGajS/NT29IekQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DN4W+yF5GREMlq49UYHzcJ4nVD5ZoDFy+D2QPykMLQwaaEDpCmNHaoHOL5ryI5E37v9QRncXOKjo55rPkkb/OZudhqOHAn1awtpMwqQdvA5MZA5yk1AsbqtfPRskygwe8WQbYk340xWhuQnGimLT1eBzwhQ3SVBvwGgyPKHzYcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=T5MTSX79; arc=fail smtp.client-ip=40.92.53.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAJwOSU731uOkzi9z6VwiTMNSvAQrt0WohiI4XecT6Ez42hZ9webnOIdm7i/PO+HU5p0KsAyjqfy3XHedciHj6o8pV6MJwgRm74/ZZiODvC0viEfNDUhAHuUYbTecdtpzrZWd7S8niohlLwC8ciy0IcpPK4sQMzH7txsBCz+dLdgrKrGYUaxWy1qyLTnQp9/RokEr06GlPKRXjGZqMtZmO4cTDMumr7Ie8hvSfXzFWZ1vDVgLAmL/3CITevvjhXkCrlJ5xw043WmQPAjjMMnGmf5+S0XaT4ZNKJLV/SHNeRud7OdtM0OVPqZJrpTrtZ3t8+7VLDlnn/kdQqO455rBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oCTLsCGjOCeh15fwg47l/IQp3fKwmj950GliVWFJ4I=;
 b=lK0Ahpyf5OTVbl+H3p/Pd6IYN/VqA3z163whFQwQa30vG9peOopr5IV0G58vxCqgKUM9lsQ50kp3ugOx0seIPfDtgSsvddYxmuVWPMuNZsI8sowKC7IlW5oJOIQ/ZDLRQ0rY8o29BK+vifiLxNi/zASFUYprLFl8nqHC6qm8l2TqSXz0q30wpuNvWjeGEg6HOEG7CatpIhI8NRds1Gu1p7iyQD73uMx6sWM/9XVtUE2UIC/ASqe6N2IzuAP2dMkNwpzc0BeBgcyt+8lzA6ad5plxGeKhUGieoBBq2IMHmFXKbjkUDd64bkHFZRJuA8z0QQyNHww6jX334gOX6J44Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oCTLsCGjOCeh15fwg47l/IQp3fKwmj950GliVWFJ4I=;
 b=T5MTSX79IDU4fV5Upghms/wI0+X84KHwPtaE7x1+q41F3QiGsjYOt76O3VrEARocNC35aV5cnT+rjoi3qPK60m58MD+1wV05Jm1PtG1M1IqlPwIIHdke5X0q5hgKYvBiez4CtYA3Ol3lLWbpQtr8fF/j1A52ISHfP000BVi4g0ffsYGckBH9W12an+eKClV4mx1IffJclERD8Kw7ez0XywCfl9M5/roF6aYw0rz7ZwwK0Cdm3NwiG3K2zGZtrTjZDFCA0KWuDdOb62ufQvA6bDu0LS9C2X2j0whlEWI6L5iWkiqprWNpT09j260c41wSn8IX1jM1d1VCFj8cWXiaiA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEZPR06MB5522.apcprd06.prod.outlook.com (2603:1096:101:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Thu, 22 Feb
 2024 18:13:11 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 18:13:10 +0000
Message-ID:
 <SEZPR06MB6959274FCF19F70B45589F4196562@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 23 Feb 2024 02:13:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] ARM: dts: hisilicon: add missing compatibles to
 CRG node
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240222-clk-mv200-v3-0-f30795b50318@outlook.com>
 <20240222-clk-mv200-v3-2-f30795b50318@outlook.com>
 <2085057c-0000-4e0d-a633-c84e939313d6@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <2085057c-0000-4e0d-a633-c84e939313d6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [oa1urRsIqkKn5yTD+cBO9bfA6lS7LfTELJNhfQv0716b760DEVytd8qFvXY8U3QvpWgfhY4QYxs=]
X-ClientProxiedBy: TYCP286CA0240.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::16) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <febc4acf-d3a3-43ac-bbf7-1e9e3a3d0556@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEZPR06MB5522:EE_
X-MS-Office365-Filtering-Correlation-Id: bccdb437-fa7f-4926-5780-08dc33d1ed59
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ErXUK3137rczeUQKvT3RS84YOWgjc/uEaBiFrkRPvs+kjpYJRpHbDRfxDDSIZy+P1RBDbbTqSxjmX4xRZwozmfK9lXWmgi/OlgGjFkpf65Pd//8I81pPFK7ZaetAiGgWQWq8dja0K9pE1upXhreAvuFM7NBd5taScIfC4qoll5/UKRHnn6hyKVJzaU7rqUCdMwwaDyfOSIh7FPrYYl/8dB+Zosn6qTgoKBqkAhjW/Ab+SKhlcGEeCbiLo7ki35AX+BkwKHsudOSEASOuyToUPIRHm88+hTn7XY0v7IvPZHYjDBU67ACz0ZxACVgIdY5S3s02CmaLouEHeIsltGgT4Ud/HvOxGcDEbimKScP402TR5WXNbDhBiUQ/lJAQlpVWDuG7qEimKUxxwp23B/52aSPaDU7HBSnA45j//2o9gmxdUq96ShM7Q2jM7q75iUChrRfZDmYWbEpjG4kKgraCdbuedHRB0mRkwgjDqF4t7HX8sG+ULDKnN5TuHrKb3Yg59ydihyUPkbCiPDCBOAa6c9wG2UI5nmjDHv9IW7FjydpnjwIvX5Lv4DzG3xlqnSrp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmRTd3R4Nkt2Ujd0eHdyOEc5bEwyV3RBeWF0RXN3alhGaDRBSE55Q3NMcHM2?=
 =?utf-8?B?bmJQUkVLR3dRRXlXRUN4c0E0YzVKMnFSSXV3UTZ4dzdjRmdpbk5Ma3U3eGJV?=
 =?utf-8?B?OVE4dVBjNjRlSHhDME5OMWdoYzRURFUwbzdYckxtb0pWZDltOXlOQS9idFcr?=
 =?utf-8?B?djNzY1lISW03TG5NYVo1UUF6SjF6dFJmNnZvNHArU1VibGFBZHg0S3J3MDZx?=
 =?utf-8?B?NnJKeFlML3lPZXg2VjIvL2gzeVp1czJzRkdmZWIzOElRQjZpVzZMcVZRQWZM?=
 =?utf-8?B?amdHekprM2JwbDhmUGZVSms3VkNNZ2NqSVB4ZmxjNDJZaDd0aHRwLy9oMFla?=
 =?utf-8?B?elV6OW9ZWmxac3h0eXNRSFFiNkdTSGJ3OG0xSnc5UHpySm51VXBDcE5NK1VK?=
 =?utf-8?B?R25ZdjRIT3gvVU9UVkYxS2ppQ3ZvMUlLeDQ5QVFScWJOUFVOaVp1d0dQQkhN?=
 =?utf-8?B?NzBIZjhFRVR4VnJ5RTRuaEgyeEVjbEhBS2Q0WUNpOHpFajdBU1FHUWd0MTlE?=
 =?utf-8?B?UWFXWkRhaFRuZnRLa1llcC80TzFxdnJ6RmVNNFc1eVcxdWt1eTc2QjNrS05t?=
 =?utf-8?B?bVZFUXBlY2ZQTlEwV3J0SUZERjJIQU9CMWtUZ09EOEI1Si9LeEFqSlpOdFli?=
 =?utf-8?B?b0pwS0xHaEJtZG1yVFNsU2pERVVoeXowVm16QzMyQVNNSmlUUmFQZ3RsSWQ3?=
 =?utf-8?B?Zm9BZnVNUzVsdVZlbjVjUi96bE5kOEkvSXFHMEtHOTJmTkMraTNHNkV0ZTJJ?=
 =?utf-8?B?TmVaYk16MTVzTmVvTHN0emxULzRJZUFmU0I4RXNEUGZmaHo2cXhYS21IMHFz?=
 =?utf-8?B?SnMrVDM3L2tXY1g4MGNNdjM1bzd1aUJDeU5LVWJNYXlINS9CZFFSbVpzMVhy?=
 =?utf-8?B?ZDNIN3J6VlJtVmh1ZmR3dFBOdURpQUs0cUVpWkNWOUErNHIvd096QTY3WFZw?=
 =?utf-8?B?ai9ZZXlKbUpSNzFqVDhpOVEwYnExYWlhUUJwVEJEVWZzblRRQ0lnbk5MeUww?=
 =?utf-8?B?aVNpSExyMHNnb0dJR2hIZ0ZPaUdUaWlYRVpxNnVyMHJGV0xvU0VFTWRhMDBW?=
 =?utf-8?B?RU9ORjJqajU0eG5CNkR2TjNiWkNMQmkwc2dHVEUxY29MeGsyT0pOeEdSdFBt?=
 =?utf-8?B?Wk14QzNOS0p3MUJRZE9kcSsrVmI1REJQSDEydDZQZXJmanFwZWpLSzdrU0JF?=
 =?utf-8?B?Smh2RlVGa0hVVElvR3M0Y3FHUW0yZ1BKbzFaSWk0N1lmRXhJSzV3QmtJMmRS?=
 =?utf-8?B?aFZBMVIvbWVna0lJTFRqbnAzTXBvVldYcDd2azFHcDZNL0xhaHBvclYrMHor?=
 =?utf-8?B?TU1zRFd2djZqMW95ZDhFOVo3K2duem5yOEk0QXJlYnkwdXI1bnBWYVJ2UXhm?=
 =?utf-8?B?SmhPMkJwcjQyajRURHVsR25kdHdXOG93cFdoWTVmWnlnRzRqc3hmblFoRXVT?=
 =?utf-8?B?UzBhRTQwdzRjZUxub0Z2OVBycTNmb1hFc1FQMXRudkY3c0tqUXRacis1QkpN?=
 =?utf-8?B?SCswYjJnL3dyYkVXR3ZYYjEvaENaVGpKdGt5TFo5bFBZUWxEeldiL1NOY0Zr?=
 =?utf-8?B?Z3RoZzUzbmlLaGptTnpzcmVmZG1rQkhaQXhNSkp6aFk5VStHMUZzWTBiV1J4?=
 =?utf-8?B?cEZic1Y0cHNESUlTZysxZkxJQmZJZHRFMXVpRVRrM3pnSVlHc3NIaG11OVQx?=
 =?utf-8?B?bUVrNldYVWc3Z0FHa3NUOXRyMkpOU0lqa2EvOWxaRTIvNWdCYWNQakpISW8w?=
 =?utf-8?Q?Np0S2vOIf5RKShclDYqn1wXeK9VKmmLKwYvUjkv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bccdb437-fa7f-4926-5780-08dc33d1ed59
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 18:13:10.4883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5522

On 2/23/2024 2:08 AM, Krzysztof Kozlowski wrote:
> On 21/02/2024 17:41, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Add "syscon" and "simple-mfd" compatibles to CRG node due to recent
>> binding changes.
> Why? You claimed you added them in the bindings because DTS has them. In
> DTS you claim reason is: binding has them.
>
> That's confusing.


Because the old txt based binding claimed there should not be a "syscon" 
and "simple-mfd".


But it exists in hi3798cv200.dtsi. And i think it does no harm to be 
there. So should i do it in two commits?


>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   arch/arm/boot/dts/hisilicon/hi3519.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/hisilicon/hi3519.dtsi b/arch/arm/boot/dts/hisilicon/hi3519.dtsi
>> index a42b71cdc5d7..da46e01b8fdc 100644
>> --- a/arch/arm/boot/dts/hisilicon/hi3519.dtsi
>> +++ b/arch/arm/boot/dts/hisilicon/hi3519.dtsi
>> @@ -35,7 +35,7 @@ clk_3m: clk_3m {
>>   	};
>>   
>>   	crg: clock-reset-controller@12010000 {
>> -		compatible = "hisilicon,hi3519-crg";
>> +		compatible = "hisilicon,hi3519-crg", "syscon", "simple-mfd";
> Why? This does not make much sense. No children here, no usage as syscon.
>
>
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


