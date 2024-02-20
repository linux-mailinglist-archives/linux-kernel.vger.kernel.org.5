Return-Path: <linux-kernel+bounces-73324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A669585C0FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4391C21A28
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA86768F1;
	Tue, 20 Feb 2024 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LojPX4dP"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2055.outbound.protection.outlook.com [40.92.107.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BE07641E;
	Tue, 20 Feb 2024 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445956; cv=fail; b=Zw1RqXeaQ8taK2z0yXippf2anG2s1NgyuRgv6NFNPpAxHkekabIoIuYkqWzKP4R7+pdTHelSYMIBPTV2Nfk+RqCIbJHjclvYolEM7GLUrsL4aRAVzbCBZBU6AmZTUzer3fTdibDqSlUn0OYjoFogY+NmtJX7rk+cEbytNkx8bp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445956; c=relaxed/simple;
	bh=Mp/mMVqT9psvH1/kQD6AqCn4TAB+VHyjvzWX2uD2Psg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aiR5+wiH7i/Xa9nYXHJonp7hfzrdGiIJXSVkut2C9JG5aoxsuVWQZQyp3XP/kMNZQEWEzks2Erh+ZeZ2axb4mAAI6svIHgOYhyWFiXgCa2PpafVfZ+pkdnawJ5EiRC9egOe+IKwViDGWP6wbw14WZ9V8eL8dpHER4xdUqfUrznM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LojPX4dP; arc=fail smtp.client-ip=40.92.107.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjxK+NcUKCO9pa139qK3O8kQIH7vMatRfwMjpzXBTkR8ANBwt/VWvL22YGLgUKqkitTmNfOzknMvAL4ayL+h18ucmRXUPwNiLYJqORIhgeD/cjNUUMxrfIgNlEdvDhzM88/paVHhYHbKEwMWHTqIQH1RJihuhbMDpfjSjBFUiGaeK0tfMLsVbGYPtdbQaRvDG9nujaxsZIOkzJedJnLo3EhOuVt7sVGs1mAVgMmS167HqqbXOmTivi4TSpJl4z+9DnNMWGUIdguHyhDbQWHnlY3IQRdLmoInYKtzN8oCtkp+QjBYFHkPlrauYSsTzaL7A4G29sgwcQF4l+F2yGVFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgqmvjHFFVqzgQ/0P2WL98b5m0XeNvvYRq/CmFa9JBY=;
 b=DDNkmaVC/wnHCH6O0+E99DhexaDfkaK6WcQQydsYRpOsT0G/RbvAAlV8gYQAUjXe1fccoGuo7JWjd/sr60WClwBDJeMo093eSPwu7p8afry0utEgDSr5HiwGddhKr3n0okUIGeFxSs59TQAEVOTKtbny7ymvFFepCw7POiyyeN64m0MeQNS4oipRrhjhS8sAWvGnpK7ionLRGia7kdlIf9oYHwUCmwYejgsREhrcZw4GWj4GiX039NPTUP/HSJsQmt4BAMJPQultHEbHyiIj8W19oEp18K0UDHbf3BWv0PK2MrAq3btTJvreF+GM9uZ09zQSpi4NDKqy/B1Cm1gGdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgqmvjHFFVqzgQ/0P2WL98b5m0XeNvvYRq/CmFa9JBY=;
 b=LojPX4dPFTex9xTPq/yV5dUk2d8oU3KzMkvyiaNRsDRVWJ4xT00Jq/je5bseyczpw5V6yH3hJ7Jrr5wEsgGpFvGcPVrMQ4j94s5VMsjP1KmLy+9FjtOnu42rlL5XuQSr/Gwa5L4SYhiXsezaOOkVNliJdzm3salrKkpfX4v+638Xh5j1yAaOhtjcI1SzldyeEEV+aJ47uC49ewEcCqJ57rdsLRIZrTnJOhKllqx0tkhu/EFPKf4sx9jakiK6CH50oXmN6bIV4vBwdDb/nj+rmVDsppZqwFn0KZ3vSrzsIGrZ7dkG6GcYVcwoXdYrA2194CLdOYWXrPCL2QJ96gkhrw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by PUZPR06MB5433.apcprd06.prod.outlook.com (2603:1096:301:e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Tue, 20 Feb
 2024 16:19:10 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:19:10 +0000
Message-ID:
 <SEZPR06MB69594CBF0625989A5C54DC9096502@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Wed, 21 Feb 2024 00:19:05 +0800
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
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <90e0dc10-8514-4827-998f-15b4d45d874e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [Z+GqxmMleO2FrAugCRus55I+NUuU1alPcmeSQWzLOTRz9+ttCDqW5Isjkc7N+m2C]
X-ClientProxiedBy: TYCP286CA0347.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::7) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <d2d72dbe-504c-403d-9cf6-20bca3aa0830@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|PUZPR06MB5433:EE_
X-MS-Office365-Filtering-Correlation-Id: 188da492-4605-4da1-3b7b-08dc322faaae
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7GcMrDNw3/EquY1lTVAJo2ceALnj2qFlnp/BiYB1ONyNKGZZ+wygmK/FIe4qjndv/wrAmGpbDQ9euKlkf/9BfL1Gt5rg9CG6Jbo2irvgeC+FJUfuvobVwq1Xz3r2h3DL2sBifUlongU0c56m6DUE2UYkqH2+oUEcCCBirW1WfS7Mxb+ardm89yAY2a5xgaTKIHlhEKmNR76Mxt9wQZ+GJXiTUb5+VeotCrp4Tyfd2zXOmsh9nPiRHm86bD68nXOm8f3Q3E66fmdLY/t38pnqwqe2HACG13t+YqO2TPvvXR9WvCHY+RUie5TVJgQeUhOC6toJtxmXGzV6NgS/yRBUQ7odSKe5z3ivDykus0qrHxg0tB/hvfSwq3DCRwjzuk2vebuJgYLiY5BeK5vLspCxgL00FrhLZoqh+iJZXr208gKf5bAugtn0+WnSkWqoH9qZs9EgemdNB/hToWvYd9L4lDqljFymCznZ47cMjulJDb7W2DV5NnepxSA/J2BVCH86l1C2bC0ILFOAE7XuBS1WBUbAMkUtw6kkKYjVH/yWlImf4ixYzPa13idn8q7VwEKT
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDE0QWd5Z2xXWWpUcGRHRDVGVlVGMGF0NG5vQWRFZmZVcHUrN0pVckw1TWtm?=
 =?utf-8?B?RVZzVnlPUkpPQWpPUmhDSStFQW45NW9NUlFUKzNwckx2elk3ZjJqVWw2c2Fy?=
 =?utf-8?B?czJVSUFIUE5MZEw5ZEN5bnozSlJ0SkhIS1gyWWlqaGZMYkNIZzdxWFRsd3I0?=
 =?utf-8?B?UDVSTWwxTUJtem9WMmhnZlpmKzFZQkNlL24yblVLSzR0d2ZoeWtDdW13M2hE?=
 =?utf-8?B?T0grYk1JM3BvTC9YeGJpaWpOTUZaQ2d6aFd3M21jazcvSWtDeHh0MVhBT2x5?=
 =?utf-8?B?dkIrWnB5Z3VSd2lNRG9kbEI1azlBL2ZvSW8veXhhK0pybHJwc2d2YkU1VFc2?=
 =?utf-8?B?L1paQW9aVnRlZ2I5Y1NDVHp5bWh3K2pMUWJEM0xrdGplMjNERDRscFU0d1Z2?=
 =?utf-8?B?Mng4L0xaZ1RZeTNKc2p3bXR1OTU0REtlNTF2SzVFZjBEdlJGTzdsRGczTE1y?=
 =?utf-8?B?UWs1aTdCMlVrSnFzL3FRYmVwWjNMZHhvbmJRYzJMbElWaDVIaVNkYVh4QU1U?=
 =?utf-8?B?UHVwd2JVTlZ4V2JuWjFQOVpFUEJweTBod2ZHVFg5VEpMWStlMmVrWUk5TURQ?=
 =?utf-8?B?NXVpZFdkNlR5NHFTVTlXRXJnVWZWM3V1Q0ZIM2MzSmJDYUN2Uk51cjFxa2Zp?=
 =?utf-8?B?aDZNUDE2K2xxa1pSSEw4Q3RQcFRQSXV3cS9rTzcrOHFUUmUzMkZ6ZmFjdnc2?=
 =?utf-8?B?Y3lxcUVUdjlqRU1jQWJTeG5VN0orOXVVOXFjL3BOYm9GeGRLbGJLRFhiZlNF?=
 =?utf-8?B?NUxodnhUc0xabmt4a3VnODBCTTFFR0E2MTNuRldjNlBYUGZIMk9Ud3U4STZR?=
 =?utf-8?B?WHNrcEpNUUthQjZ6OW9yR2phbjZFM09zSkxEVFgzTTRsV1FwR1hxckx2ZDR3?=
 =?utf-8?B?S01jUGNaWVZBTFBjcEF5bUxPTnlqbDZpMkpvdmgrNzJtRHZJN3BVaVBNa2dn?=
 =?utf-8?B?dGNIaW1OOENNRWVqdFF2ajg0YXVpcGQwS0VqYmFSb0c4bENLbGxzQ21sNVMr?=
 =?utf-8?B?WVlZTlVDNWJrVHVOeVFldVMvTVV4aGcwSGJJMklVMTNTdGlsYUN3TElWZUtj?=
 =?utf-8?B?WWNNdE9JVnpIbjZjdjk3ZFd2S1RGSkJNeUJmQWwwTkJqVHBQVWZ1T1E2cm9M?=
 =?utf-8?B?bHhCL2l3K0QvVjZUNjVFWGg1RVIveE9CVkE0bGtmWWNQaFg1Sm1QSFlPL2Ro?=
 =?utf-8?B?TVc2dnZuZmR5aWszSHpUc3JhU2pTbHdMYlFMbUdFcFF0Z2l0RjZtMTI2S1Qw?=
 =?utf-8?B?RWp1ZVBvaWh1eHJiMzFmWVFRLzRxRktDK3NWY2J0RWIzZGR0TEhwN3d2S0hO?=
 =?utf-8?B?TDF6S1FhSTVmQklKbitIb1I0dnNSd3FNdHo2a2tKem14bGVLcHNzWW51bkdS?=
 =?utf-8?B?V3oxT0hublp6VEVRWmk1R2FuVElFZUU2cXBocE5LZjcrQUhpclMvNjZvdmVK?=
 =?utf-8?B?QUNIZzUzZW9la1hBNGh3WEphSDZ2bU1DZVB6Mnc1Z2k2azZ4dWk3ZFpjaWZs?=
 =?utf-8?B?cWdWeVVhWnJNdDQ4OTdVM21Yb0dJU2UrMGk3S1dYWmhKYytjSlF0c3FOblIv?=
 =?utf-8?B?QzFQK2tUd1Jvc0V1OVF4My84ZnFZVCtQMk05eGR5VHRaQ2hNUWVJQ0FEVXly?=
 =?utf-8?B?S3ZBcE5ocHByT3hOY0xmOTJzc2ttMmd6Q29GclFqYlNYdEtpZHFOUkxBQU9N?=
 =?utf-8?B?SHFrNWJyKzdMRDRpK05DcWFEdlErNFVPYWMvOHRqSElsWHZqT2VRWklUZzRW?=
 =?utf-8?Q?U5dLNU+2V0cyG1pkbVGwGxsHwjq3OI43FglRY8q?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188da492-4605-4da1-3b7b-08dc322faaae
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:19:08.9512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5433

On 2/21/2024 12:13 AM, Krzysztof Kozlowski wrote:
> On 20/02/2024 15:06, Yang Xiwen wrote:
>> On 2/20/2024 6:10 PM, Krzysztof Kozlowski wrote:
>>> On 17/02/2024 13:52, Yang Xiwen via B4 Relay wrote:
>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>
>>>> According to the datasheet, some clocks are missing, add their
>>>> definitions first.
>>>>
>>>> Some aliases for hi3798mv200 are also introduced.
>>>>
>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>>> ---
>>>>    include/dt-bindings/clock/histb-clock.h | 21 +++++++++++++++++++++
>>>>    1 file changed, 21 insertions(+)
>>>>
>>>> diff --git a/include/dt-bindings/clock/histb-clock.h b/include/dt-bindings/clock/histb-clock.h
>>>> index e64e5770ada6..68a53053586a 100644
>>>> --- a/include/dt-bindings/clock/histb-clock.h
>>>> +++ b/include/dt-bindings/clock/histb-clock.h
>>>> @@ -58,6 +58,27 @@
>>>>    #define HISTB_USB3_UTMI_CLK1		48
>>>>    #define HISTB_USB3_PIPE_CLK1		49
>>>>    #define HISTB_USB3_SUSPEND_CLK1		50
>>>> +#define HISTB_SDIO1_BIU_CLK		51
>>>> +#define HISTB_SDIO1_CIU_CLK		52
>>>> +#define HISTB_SDIO1_DRV_CLK		53
>>>> +#define HISTB_SDIO1_SAMPLE_CLK		54
>>>> +#define HISTB_ETH0_PHY_CLK		55
>>>> +#define HISTB_ETH1_PHY_CLK		56
>>>> +#define HISTB_WDG0_CLK			57
>>>> +#define HISTB_USB2_UTMI0_CLK		HISTB_USB2_UTMI_CLK
>>> Why? It's anyway placed oddly, the entries are ordered by number/value.
>>
>> So this is somewhat broken at the beginning. It named after
>> histb-clock.h but actually they are all clocks for Hi3798CV200 SoC. For
>> Hi3798MV200(also a HiSTB SoC), there is one additional UTMI clock.
>>
>>
>> What solution do you prefer? rename UTMI_CLK to UTMI0_CLK, add UTMI1_CLK
>> after it and increment all the indexes after it? Then the diff would be
>> very ugly.
> I still don't understand what is the problem you are trying to solve
> here. Your commit msg says add missing ID, but that ID -
> HISTB_USB2_UTMI_CLK - is already there.
>
> I also do not get why there is a need to rename anything.


Because there are two USB2_UTMI_CLKs in total, at least for Hi3798MV200. 
UTMI1 is missing here. For other HiSTB SoCs, there could be even more.


If we add USB2_UTMI1_CLK, it looks silly to keep USB2_UTMI_CLK without 
renaming it to UTMI0. Just like all the other clocks. E.g. 
I2Cn_CLK(n=0,1,2,3,4) etc.., so the same for USB2_UTMI_CLK.


>
>
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


