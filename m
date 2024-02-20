Return-Path: <linux-kernel+bounces-73361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A343385C176
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3EDEB248E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6168E1C2E;
	Tue, 20 Feb 2024 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BHawSkBn"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2028.outbound.protection.outlook.com [40.92.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBC876411;
	Tue, 20 Feb 2024 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446710; cv=fail; b=eZwCGc9P0aTTN6D9ABiA1AIOUVNBqjOIVdaeXD9teyMZrsUd+PfAqPbrO6hv3ACGRYX60uL3qYZMY/RPmGbT11ECtCs2U1lgrYRchZIK6ASJjRqXwhZTbKG+TEA3TjEKTBTgEVzWGiyIDoARJay8OU4ynRIXoX8xR1LO/+g8JKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446710; c=relaxed/simple;
	bh=7YOck/NxMQxrlBI9q20jI1pvhINZ4xkLyYgO+q/uleE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tNuiPaAuTZ7skXu8yk94E6URHAeE7OpZ4FaXFo8jop3WQGJoCuJvWF06M06ZizkBqd+c2GfzUK+YeuRdxWzdPphe6ppHmo/EDtWHgM4s1S8hhN3hpLU/Lj5br+0Po00e4ztsEsw85uWIDql0Uf4Ova6JDUvSEHwl47ZIwOk2hy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BHawSkBn; arc=fail smtp.client-ip=40.92.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9bS/oQf93oa+5otTKIu4V32knFfRdv2VBNebTinFo848434QlYXOXzsrFKrtAvvTcyWpEUhTMIbySr4BcAju05rY+fdebznNugf8OpIm/1Plxu9+YvUmBbgGEluWmON310xiwbegIL9TLIBg0YKJmMuIQH3ITWqxDhuPcPdQIIq02O3zBNMQcBzrpsqc1hlIGIg+srzQpg1c9t6h/mZ/sNHUUQCYUS29BU5iNScaZrMhwT5zIkQoBgd/dCel4r+KCApMHekYWZQTSB0sgZzPGugj0SkU7LlzAZcOBFcUQ8hoeXdK0vpIgyY3Wa1fYe/DE70dddrekfJk8SXO1v8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqOGDqe4Ez+6BjBGQOarR2sOHE4vtvljEThoQeXdcJQ=;
 b=C37HQeOyZZXdNXuya1cS7Gq7SX7ZXsgN0pOcxZnoW423RPOmefF/KSvARBjiceHP2Z8n7B0stJsNMYy2XofIlnjXFLmIlxcE8qY+No8y57Avve9jTlG/QLhjqk0Q/TU/a7VkURFz4sW3rG93VJ5+y/hJQvAAOd4N6aqsAdlI8yaSJ4pA4TQ/+BtpYLTktHRVFkVZk2mmPHiJTykCp91saVLtLpmAweq0js7dLGjF1Q05I/0XMmqSUtM9g7nmlogxGKbAKnCXd/te/fgRP9LcXabQpsAkqb7RRKVlSXBxkCrVFK07q0HbV6VzezMT3kZwQKb+eTy5bJSazLJLOQNTDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqOGDqe4Ez+6BjBGQOarR2sOHE4vtvljEThoQeXdcJQ=;
 b=BHawSkBnkbJSeulrzqz9kUas5gBR4D1xcEz9oclxwowTnB9Hi1dhGVz0SRvHbwHRhzHmBePPDhhQ2f3BdYm31H3vHs5Qsq3LOzvdP3VU0FSXY+JZxbrbjox25rq1Iy1jdzme+PTTTjfP/TTTKmekA/hm8u97a8SxfdbtdNvEJxHAzh+ca9k1esp4tt7pIMdcyLLsPj2RijH8BqPtatUJjgGzK9BbuqTKsYVWSjeh2wo6yKgfBahY+hYIZLW2YYIxOmEsJqeY+Cl5eml7xDt47NwSifTSsJaZR3bPKU+gynvChgREjdM1r1Ihl2vBaTOrLu5WNsKWRezehM4PtdXn5Q==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB6047.apcprd06.prod.outlook.com (2603:1096:400:33e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Tue, 20 Feb
 2024 16:31:44 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:31:44 +0000
Message-ID:
 <SEZPR06MB695996DD12D23D13D3579A8996502@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Wed, 21 Feb 2024 00:31:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/5] dt-bindings: clock: histb-clock: Add missing
 common clock and Hi3798MV200 specific clock definition
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com>
 <20240217-clk-mv200-v2-1-b782e4eb66f7@outlook.com>
 <875b706f-801a-4a4c-8806-411a67c5a5e7@linaro.org>
 <SEZPR06MB6959456E59D84C15F0C1B88396502@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <90e0dc10-8514-4827-998f-15b4d45d874e@linaro.org>
 <SEZPR06MB69594CBF0625989A5C54DC9096502@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <3b6ab055-360b-4f73-8d11-8f52b272b7a8@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <3b6ab055-360b-4f73-8d11-8f52b272b7a8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [RU54GzIbO8XQmYdk8o5OyrWX3GVod0cxss6FTpO9WqXACNOpwEnNt2a2klcuR/0e]
X-ClientProxiedBy: TYBP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::23) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <6b11d560-a5fd-4da4-b0b6-108e5425fe1c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a87025-9879-4be7-adda-08dc32316cb9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8lT4LZU2WBp7raKgCPz4fGGJ84/4ux668VWzzzgdkEESB8cYnujsj7Zl+YbpyFgTbaZ2Jm1xlZdiErlem2Wsv1Ze7Ok/RSgCq6oRv9A6J0d7r7h33Q7+eWOBMkqZNgvFGXh/c/+p+S6b8HbmS9V8hOOZcS/j8gNawUgqcy+FE4iLqRDRkBwIcW5JbFOXIp25HmugEkjTu8/xeenySZmgIIt1+uMQPvDqvX9F2PG2k2FxxbIdPYbLdgJ/Isk0zGvtUsJk+yRMrjVio0oEzNokOjyPUrREc7F4TTst7kQJomI3w/8Pm4pzMS94y3a97Xlfz5I7uvaTn1VhBshS5DM/wQIDpJPHuve6OMmyW8J8X8+VoDdn21/UY771br79f7Jccknw+QL8eReZiR0btIsE5ChxzPjfktsG3mPrhldxMm94BqXcUeOfculZ0fSGJs5Sed2QpblPJuJzD5T6stUqnuyFN4HALGI0q9oAUWltaHnIR5qDQ879C4G4GWeKRCkbABJwf4sCW2TRI2GpwFxhDK8i4/kFvaSNbpxBlb/z16IOSdCT1N40BNTNHg5nbkOq
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0VKcDBFS1lmZnlCS2JyeDFjUkxXUVFUVFM1TU5EOWdrQ08wYkR3clc3aktI?=
 =?utf-8?B?WUFVcEJnRUNZa2tLSnVqNFBjQ0RLa1QxYUl0NDZGZU81ekdtdHdjOGp6Z05Q?=
 =?utf-8?B?Zm0yRkh5dzlQWUZZRFRRU3NBNVNOR3hRZlMwc0YyUzN0VmRIeXUvc2twbWIx?=
 =?utf-8?B?Q1U5OTJ5ZitQZEs1Uk9pWXdyUlJLWmlySU9iNHFTZGllZHNMQVlQdm5keitG?=
 =?utf-8?B?aWcrODQ5c2hCOTRMVkEwVlJna1l6NXNFV1RCZWQ1ZkhHQ2dHZ01KYUd5bks3?=
 =?utf-8?B?S1V5S0tsbkFtY0pIREwwSFpqSEdRYkNDMy83ZDBVbnh2ay8yVTM4aFdlNmN2?=
 =?utf-8?B?R29QMFc1ZTJ0K1VRbEU0VjhCVEJ5TUtMeE5VSXRJMVBLejJtdVZVVVRueDNw?=
 =?utf-8?B?Z2JIcDgrY0pxdUY1Rm1vSElhRTZybHB5MEhOSjZrMnlOSFQxMWE1L1p1YTg5?=
 =?utf-8?B?TzRFZ3lISjE3YmJLNC9YWjdkUmRGYmZ4Q2U4ZEVGNW5MRndkazh6Nm00b0VP?=
 =?utf-8?B?Q2JkNjhTclFrVUlwTytUTlQrOTdEM3M4RnVzSzNIYzltOFBFanNLYjFRVzlG?=
 =?utf-8?B?bjNxN3ZhcThtNVdJRHdnNHZtaWxYVFIyckc4aktxNHhIUER6bEpHZXBpY081?=
 =?utf-8?B?ckl6UlR0S0RKT2ZLcTFrN3Y0Skx1bnJ6cVRxK29GbXY5U2ZnR2NUdkxLVEdY?=
 =?utf-8?B?T0lVRmlCbkZZeEt1aURpMWI0cVpRUEZHVWQ4M1dheXl3VUVpZXplY2JjSHg2?=
 =?utf-8?B?TENONk1YaTlJNTY1OWNIeDlGK0tubzNvTW1kTzFGOXhMWGgraFRGYTRaTFds?=
 =?utf-8?B?UkpyUndKSFJUTGU1aUVtRFRlMTV1Z21uSXEyL00xaWVTMThaTnJpMnNqaGti?=
 =?utf-8?B?eG1RQ0U4cXZEbFVEUG95NXhmSnBDRHh1TFJ6VXBzWTdrR3NEOUNLdS92aVQ0?=
 =?utf-8?B?VmEwQ3RCRmZxTzFwODNTWE8remRrNkdmVnlnOVBZUXFCdDE0YUprdmNrWSs2?=
 =?utf-8?B?NXNtVmRpUXZLeFgrL3BDaW1zWmhsMWpWakVPc2k3S0E5OXFabGJFdG91elly?=
 =?utf-8?B?Q3BGUUdrZG03d2EranFIM3VEcGFMdXJ1YVE0NkZCY3MrUlArZUxBTEIrcmFO?=
 =?utf-8?B?NXh5L0FBOW5qVEpQRThaRS82Ty80OE5TRzcybzZmRnVJNEd1UnA1Ty81MjFH?=
 =?utf-8?B?QUpKYUZSZG9xbmtVQzIwbnp3bG52b3VqUURQVi9BSXFMZzFNbEV3ZWY1OWxw?=
 =?utf-8?B?enk0ZXpBejZnQkg5QkUyd0lOeEx5NjdSVmh5SHREQmRzWHlvdTBYMXJWSDhR?=
 =?utf-8?B?WUhYOWNyOGI2bnV1bml5dXJiNnMxaHNyVEkxMmtZSFFIR296bHQ2QmFGWHBT?=
 =?utf-8?B?MDloYmp5clViWUFmQUhwc215L25QeHYvVFU4Nmp5ZjZZRXRLeGZKcGxhWktS?=
 =?utf-8?B?aW10Y0U0ajlYa3BZbjlCMG5URGZ1TExycXdwM1psc0dkRk84MG9iRnYveWlz?=
 =?utf-8?B?clVxeEFGZjB5enRyZkh6V0QydnhuNHdtbGMyRHJ6N0VLUjdFcDcrdlMvcWtx?=
 =?utf-8?B?T2w3aU5nWC9CV0o1RldMM2ZCWnRFck1oQ2pLU0REMlVWaEYwR2pWcGlwYUxa?=
 =?utf-8?B?Y1pGOHhEcEptcUMrSnVOWlBxeThESzdjQ01mQm5tNXVwSDVDUFMydWFxaWlu?=
 =?utf-8?B?Y0FGSVhOMXdQaVVHM3IwUk9RdDhXaVcvK2dTdUMzVXQ4N1RoQ3dlU1NTWnFl?=
 =?utf-8?Q?+LnDGGLi4msQuYBjN41BYXeeu6vaETjR28h+cXn?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a87025-9879-4be7-adda-08dc32316cb9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:31:44.0037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6047

On 2/21/2024 12:25 AM, Krzysztof Kozlowski wrote:
> On 20/02/2024 17:19, Yang Xiwen wrote:
>> On 2/21/2024 12:13 AM, Krzysztof Kozlowski wrote:
>>> On 20/02/2024 15:06, Yang Xiwen wrote:
>>>> On 2/20/2024 6:10 PM, Krzysztof Kozlowski wrote:
>>>>> On 17/02/2024 13:52, Yang Xiwen via B4 Relay wrote:
>>>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>>>
>>>>>> According to the datasheet, some clocks are missing, add their
>>>>>> definitions first.
>>>>>>
>>>>>> Some aliases for hi3798mv200 are also introduced.
>>>>>>
>>>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>>>>> ---
>>>>>>     include/dt-bindings/clock/histb-clock.h | 21 +++++++++++++++++++++
>>>>>>     1 file changed, 21 insertions(+)
>>>>>>
>>>>>> diff --git a/include/dt-bindings/clock/histb-clock.h b/include/dt-bindings/clock/histb-clock.h
>>>>>> index e64e5770ada6..68a53053586a 100644
>>>>>> --- a/include/dt-bindings/clock/histb-clock.h
>>>>>> +++ b/include/dt-bindings/clock/histb-clock.h
>>>>>> @@ -58,6 +58,27 @@
>>>>>>     #define HISTB_USB3_UTMI_CLK1		48
>>>>>>     #define HISTB_USB3_PIPE_CLK1		49
>>>>>>     #define HISTB_USB3_SUSPEND_CLK1		50
>>>>>> +#define HISTB_SDIO1_BIU_CLK		51
>>>>>> +#define HISTB_SDIO1_CIU_CLK		52
>>>>>> +#define HISTB_SDIO1_DRV_CLK		53
>>>>>> +#define HISTB_SDIO1_SAMPLE_CLK		54
>>>>>> +#define HISTB_ETH0_PHY_CLK		55
>>>>>> +#define HISTB_ETH1_PHY_CLK		56
>>>>>> +#define HISTB_WDG0_CLK			57
>>>>>> +#define HISTB_USB2_UTMI0_CLK		HISTB_USB2_UTMI_CLK
>>>>> Why? It's anyway placed oddly, the entries are ordered by number/value.
>>>> So this is somewhat broken at the beginning. It named after
>>>> histb-clock.h but actually they are all clocks for Hi3798CV200 SoC. For
>>>> Hi3798MV200(also a HiSTB SoC), there is one additional UTMI clock.
>>>>
>>>>
>>>> What solution do you prefer? rename UTMI_CLK to UTMI0_CLK, add UTMI1_CLK
>>>> after it and increment all the indexes after it? Then the diff would be
>>>> very ugly.
>>> I still don't understand what is the problem you are trying to solve
>>> here. Your commit msg says add missing ID, but that ID -
>>> HISTB_USB2_UTMI_CLK - is already there.
>>>
>>> I also do not get why there is a need to rename anything.
>>
>> Because there are two USB2_UTMI_CLKs in total, at least for Hi3798MV200.
>> UTMI1 is missing here. For other HiSTB SoCs, there could be even more.
> My comment was under UTMI0. We do not talk about UTMI1...
>
>>
>> If we add USB2_UTMI1_CLK, it looks silly to keep USB2_UTMI_CLK without
>> renaming it to UTMI0. Just like all the other clocks. E.g.
>> I2Cn_CLK(n=0,1,2,3,4) etc.., so the same for USB2_UTMI_CLK.
> Then place it next to old name and explain why it is deprecated with
> comment.


Do we need to keep the old name? I can fix all the users (only 
hi3798cv200.dtsi) in next version and drop this name directly. Is that 
okay? Should i insert UTMI1_CLK to the middle and re-index all the 
macros after it? Or simply add it to the tail?


>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


