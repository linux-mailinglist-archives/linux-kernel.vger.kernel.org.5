Return-Path: <linux-kernel+bounces-161632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C08598B4ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771BA280F8D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0048B225D9;
	Sun, 28 Apr 2024 23:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GdqVO1z/"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2065.outbound.protection.outlook.com [40.92.103.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0D510958;
	Sun, 28 Apr 2024 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714348083; cv=fail; b=H11poCNahzJ42jWlmIwGurna8mUUvst5hmBvgzrez2mS8BrbOeMbBSIb5Wj9reuQK/0wdhNzfz4BwyieJfI56AFtg44m4dYmkgy5y4orWYErGirS8qYzWn4xLG8YvmPUKOrF35skZNirZTjYKe9Di2123fEbO6wnWarD6lEIZqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714348083; c=relaxed/simple;
	bh=6hwWd8evcW1OWdlm25y8OyoYjYjbD0YU+scHRb1ERls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U+X0ZQvqm5NLXEQr4jX8UXhtXe2ZbMKoG29xM5n3uFVZQOdyCCmlyySL+1U7gGgb/GebsD9e25Re9Y3ne4Ll5r3JOGA7rVH0CUDn0oxAHzWW9XusxqEyJbODk0SWsRffefirD1MZ1wZOzQDbm1aDkAhXtr4BxUw7VLLzo1DopLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GdqVO1z/; arc=fail smtp.client-ip=40.92.103.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncHmiPUYFqeauHD2JaS94y64wBS21Xd217anizEoAqI6qoWHqBBb1TqvSAW9OX1PDyf2fEBgUxJ0V6EiJVvqym8pPi5sHE3mDvOPXaSjAYD0I/PWRdnWljrjKnzziLmXCG5b8pmtj42RaXH1OC9jFC3qe7rEH79vEOrikgMI5BZpis32QsLIKn7c3p/Ope9rxFOJK+nGojNlBRtK7I84fw5uFwBSiwxebjCZsv8Ms7tAwx7eo6GWDSWIo2tAB/anjxg/Gc2WgMkiZjKllxRwSm145eX8agYbBvzSF4g2EzNMHm1GZdGLJ7oacwGxKd8DeWEBDUX7e1PLjl2mnVtmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hwWd8evcW1OWdlm25y8OyoYjYjbD0YU+scHRb1ERls=;
 b=WAaFNh79gNOqMbqqi9AQArwTx/Z/Np7p1f2zzI+lp5lKOmO6xoeWmdOX3j1uo8T4gShkggYpK+tvte4L0kRqLHUCFK1TVkpSornd8f4y1V9Aic2bKymH9ircJhAjuSVIB7QXghWmsYAhRbbj6WfCqMMp2MwspUF5J+RGmSiVkogRf4ZuMVLWuDclSCW908MBXF7a223UUtCoqrSqJb+su91F6xOtkHNtyDvcdq4tbMhyi4ZmRjamMJhB/T1UPZn2EbUD4VtJOCOLetSRPNBnwBXIUBiLbCgMEJiaK3DGt6rlw8Rs3NLwg6eQKzgFfF0kxKUS4czrWn7QHI90FlBzNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hwWd8evcW1OWdlm25y8OyoYjYjbD0YU+scHRb1ERls=;
 b=GdqVO1z/+edJDff/JVBkm2ZHBmwOvNvMEoeXJQ7Pew5ZOhThZZ29XLpn7TLW44Y/GtrNZLrofv7t7riedap52623ECRVBDo2OfsRK+C6I3MW9R3SOYe10ogoeimrrRGe3QuStUpDzH/wnJYd4EFLx2Syh5y8sqM8FrJ0Ysal5jrlz7KmfgsTOA3RYQhPX9ULuTUcjuUmeMQuemv3WDCSOg+BUykWTogq9iXtDPiYZoh7so/s1t96GpFJuWCGw1hUS1iVB3YE9/z6U48i2TDIEIm6AeUG3bo+lsovF3K8UhjvUZI72UNoFTSEAOXDSS55tEmDC+u5ZQP0Gt0wefsH9A==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB1849.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 23:47:53 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c%3]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 23:47:53 +0000
Message-ID:
 <MA0P287MB2822900F42A1CFDC0813186AFE142@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 29 Apr 2024 07:47:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drivers: soc: sophgo: Add SG2042 external hardware
 monitor support
To: Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Samuel Holland <samuel.holland@sifive.com>, Wei Xu <xuwei5@hisilicon.com>,
 Huisong Li <lihuisong@huawei.com>, Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-hwmon@vger.kernel.org
References: <IA1PR20MB49532A8A0C52FE5C599B6D13BB142@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953A6EF6ED0CD082B60DD80BB142@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953A6EF6ED0CD082B60DD80BB142@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [9AySyeBEOWHPBfWvsiAnsM8kx8kwDTKC]
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <447073dc-6231-4c3e-b2aa-d019b9b533d3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB1849:EE_
X-MS-Office365-Filtering-Correlation-Id: 2452c49b-d2db-4fee-fb64-08dc67dd9dc4
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	fuJ1vRXzdLg3QyXHYP//BKlaMpFBrnCyJ7Mw+LlVUxL6DXu05VO2XlQVuLjnFjbgH//fPboohUGJLBxQb1NB7UaW2ZxgRTHvCCsyxMgLw3F03VH+I4MrbdYVAyYicIqKx4Xh+ZfounB2rXYHVWbUSHoAW8lYmVLG0bJ+g8/zyG7QQ+ax4xC7AZUXdrXVxifd8+zCgqv+6R0wjDnngM/Tj2TTVjQuVCj3STY17aOYO7oOjwqJegkbo9DT4kvRq63Rz04k3nf5oDAKRCyCsQqyn25EE5jvYdYEP/qs53diULnoV4RpFaD4JX03wX0cHjJQGtqS/Gztcvp6ONRjPdAJNHsLU9XvmLQdi6cxDsYWNP0DKi14SQNnJSYhKEZOClsfD2QEdkuKCmkLd+FTK4AllrvBlem118dAL7AHUbGFIMZB87avkYAbqaVlC603LN0G8iVVer5yjWtlMj+MJVPL7cigoejmyBQ/E7jkzz4omEAgJbfi2Yti5KyAvPWVYw5YelG09HoLd6nNplBEtyr6yZ0AfOakUQKAC7MQONPF+6anHtkfgqMT7VZXl5U27wcL
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkttNG1VN3huR3Q4eGxHcEU0MkNFWlVveTJGVm9aUHQ3UWVDUkJERGI1aDNW?=
 =?utf-8?B?eFNJWXF6UmQxR3F2SVlCYU4zTisxWUJTZk9zM1p5T1hQNVM1aytTd3JCcEpu?=
 =?utf-8?B?NUJPNGVTWEIyM2xwUmgyMUtqUHhEZ1ZIQWdiQUhMaHBhMXVDQ0RPUjl3ekhn?=
 =?utf-8?B?Q2dveGJ6aXIzVFJmZGl6Wk5UZDRoV2twb1NUc1AvNEYzL0NveVdHZlE0NlVy?=
 =?utf-8?B?OS9YL0JUc0FoVkJYU2k2RVpmMmoyckFEb1U0WUI2RDB2aDlyOUlJc0x6bVM2?=
 =?utf-8?B?dWlPbkxsSnhuUkZTVUhKcUdZM0doc294WlQwaVRFWHhOOTF2dGlLeVNMZlJq?=
 =?utf-8?B?b2EwTTdHRmtNcmVnWDJhQStST1VUUWJDZUZsMm9hK3pOcXZDb3dJMVZRaG5p?=
 =?utf-8?B?UVlnYnVaTXQrYUh1aUFvZGlwdjkvcHZVL01rbUxEMmoyend2SXc2cnRNOWN5?=
 =?utf-8?B?TEcxckhNTlo3ZDZTVkRaRFdmWmVNMml1Q01pWUtJWkVJTkZtb0tvM1p3T2JC?=
 =?utf-8?B?WTJIVXI2NVA1ai9oZ3loWFlpSHh6MjlYOUdzMk5HWGMvUzI0SVVLM3Y1NHpK?=
 =?utf-8?B?VzBPUHNhT01wTnpiVFhKQ25CSTZmNE4vVGlsL0N3Z0FyQVVqWENPZFVoaXFU?=
 =?utf-8?B?YU5rdVNwUnVIY00zOUhqWjhFUDBQT0ZJanltTlFNaHZsQkFHMDhYS0RDeHRk?=
 =?utf-8?B?R0xjdmN0TzczTEdldUlaamhITi80TytwT0tKTk1YUTB5bXZPUHk4aFd0K1l5?=
 =?utf-8?B?NzRuZFVIK0NQbkVQTzJqNEQ3aFVyajlocksyNWF5TDk2cXR2eldVdW43OGVG?=
 =?utf-8?B?MWd1SFovakhsdVk4NEtwMUpLRXl1Tk4yQ2RDNmtUR3BNWEVTZDBKdVZ3SFk3?=
 =?utf-8?B?dXdVS3p0SnhoTXlVbGJYVWs2M2YyNUMyU3Z1blBvRVI3TjJUVHR3eGdhZTkv?=
 =?utf-8?B?eTFZYmxjNXEweTJqVWEwa2EzaG96bWRCSFZldHNqdVlRK3Z5SklhV3lhMXJJ?=
 =?utf-8?B?MG54TWRmY1BkcktPR2h3YlJETStJRU9BVTk1STdKNXdyU094MVM1blNQOFVI?=
 =?utf-8?B?Z1VXMEh5SHVXRDJJUWFQN21weTN6NHNraHJoSjVnM1lWVWVFa29QQUlrRDE4?=
 =?utf-8?B?ZHQxMldEY3VBUXR5dDRZL1R6WHh3d1RvS3g2eW1aaHhqRDVNMHV2eDVQOEs5?=
 =?utf-8?B?Umk5dTZ1MzFLS3JlV210TkZwSWc4VjdBeEhXWUh4UC9vZVA0SWtZV3FnY0tl?=
 =?utf-8?B?aGFHaldDTDJsU1lNSloyRXlyeVZNTEVCaUZyWXJ6L24wS2RkT2dIN3BJajE0?=
 =?utf-8?B?QU1QenAvc3pSMTh3eXhYNTFMRTY1R3VJTnF3QnBCbGtCNzFwbmlIV3Jkbmp2?=
 =?utf-8?B?THlNVVkvUEM5OGZwcm90VUM2TzJrUnJKMzVPS3FET1pMb1RnQlVISlBtM2FY?=
 =?utf-8?B?Y1Q4cVM4VHVrRnhFQStQTjFNSWxudUNXSm9DeS9PNU9JUDJwenU5czNudDNh?=
 =?utf-8?B?RE9VOWhRZ3R1R1RxdFVVK0hSelVvNEN2TklhaTBjVDVVNjhwV3ZkbTRwcGEr?=
 =?utf-8?B?dzkvaFJyYnh2V1prN3B0MkVUUjV3ZXg0S1FKVDBSV0tOT1NFZDdvWlJwTWpM?=
 =?utf-8?B?R05RamVqbG1kdVpMV1RsZG9Xb2JzZC9seFRsOW1KTHBESjI5L0RFVzI3MEpI?=
 =?utf-8?Q?DQqP0t25vd/AtD82rMNw?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2452c49b-d2db-4fee-fb64-08dc67dd9dc4
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 23:47:53.0403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1849


On 2024/4/28 9:30, Inochi Amaoto wrote:
> SG2042 use an external MCU to provide basic hardware information
> and thermal sensors.
>
> Add driver support for the onboard MCU of SG2042.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
[......]
> +module_i2c_driver(sg2042_mcu_driver);
> +
> +MODULE_DESCRIPTION("MCU I2C driver for bm16xx soc platform");
not bm16xx， should be sg2042
> +MODULE_LICENSE("GPL");
> --
> 2.44.0
>

