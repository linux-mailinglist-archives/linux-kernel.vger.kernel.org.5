Return-Path: <linux-kernel+bounces-96638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3742875F44
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7B71F21D15
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E578651C5B;
	Fri,  8 Mar 2024 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BWXVmgb7"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2093.outbound.protection.outlook.com [40.92.53.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D7B2C1A2;
	Fri,  8 Mar 2024 08:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709885917; cv=fail; b=UMqSD39NgqG6x7q4oZkXWfT1yZaWofBbOX1ZqLalOgVj0oVh/+Bmvo+lAkWFS2tTskuDEyMXC6F7xpbPzD4N5mXr6DVcDYv5Feyt9B3X6MVyvzm0skkSQiKpzy5XnqHCyX12/dXnnA//Ie8x2DNOl7VepZnwEwe195knaCPb0yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709885917; c=relaxed/simple;
	bh=UCymEKAKLymnJJvn4LtVgJ3omJPBRCKXEZ9zY4Avzzo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qGjVCwuwnLZk4NXzmjgMfhzAbWNC17KWAe2bM8p0Htu0lU12LfjENyMxl3Igp1WoNVmWVD+leFNnuvqWvuWOnWhh7uWq2dHgNf0bfStCI0QC2to4shSNw8KGID6vwgz9KCIUTNwWwke7RHUbiBC5S7LQdiTtj50gxQtQ64Ww0hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BWXVmgb7; arc=fail smtp.client-ip=40.92.53.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwAFRihP2x2istgHs4rxnLh1pdDSfz4lc4N+5QF1yDwCb8ErDReSi3cnxBM8FxN2QwF3ZnVIvMAPihGUknv62r1GN0GPKJmkEwhX8Kw/A8rf84l5wM82BF4+zxvH7fPdv/ImqAIkTcBiWktTJT6a0SX5CwZdU34Tv1TfFzT2JupLZkk6qtg/EKGc236uKxq70EIjddszdyBfQ/wDF+mgrzt06cVC99CZG81R3UGcqwzA3uAIWFX0LU+EkOb/pQ5TWv1FnGP9QIoaF75NesIPjFM3XDE2SE7L3qMHO3lY6Kt34OWX321Tgyh8pTMu/LF6zfazCVPg4hlC6kXsem9fWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IO75ohAAgvN1iWHg73mbUjjzuC9OLYyERIKFy5R6/U=;
 b=d4ZmnQ30ZM/yG8FDozhUPb9aJnaw2nql2q0EPKaAdQs1xvWmmZPNUrtYcae/IWKDd44teLtjvW0hjKVHsz/evJ1IaqYIwD9k0mpg9gMenUPWIQxxuzyjxxQ7oRQ8APBRponO3ZWuPEuQgtHdBoEEjt49px5PqkUMcFVJlckIElZR0e+JNktuNxHP10nZeKtqeMRwy6UTO5xUu1xIVP2aXjTVhPldD9KdThZoOkcrReKze/jBtBHpHl0ZxtqyW65MoQ6GwuoxUw6+j3pIVoDhf4q5dk6M3VZq5fPOHPtQ1pBQw7Y4NblV8I+M/fQ+UsYt+pT6Vhs8KXtcXcmMQ9Bb2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IO75ohAAgvN1iWHg73mbUjjzuC9OLYyERIKFy5R6/U=;
 b=BWXVmgb78UKjN6KvkwwFiV5o5K+Nu0NAJKqFQzcRjPsgCCt7fOGoeLo38aSS1TzKVJ6D070Z3ZIIdjAtwIEPT0Bum5fO52cATUmF7y9rtWRBMr53Tns+dmd8HCWLlmD1Bep0ko5fqdMyKbKL7D+0vQSh1OwqlKCUsPuDSbthzcSLpKa4tT6I7R68JBUD3UsF3ACJrLybWBYSbOIgYy+zrtT3fmOJPCuHmCEwrTXXIBSBjTV8k15K1NWHKyp1PSqe456/jfHOzB5InNhPhHUQQjO8rnfFSI5VNpQU0ccmZFCt1jl83vZ6DmdaIbU6HfTI3Zy/xEuK93qPHrWB9pALlg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEYPR06MB6456.apcprd06.prod.outlook.com (2603:1096:101:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 08:18:29 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7339.035; Fri, 8 Mar 2024
 08:18:29 +0000
Message-ID:
 <SEZPR06MB69598718CCABAA52ADB34F0496272@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 8 Mar 2024 16:18:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 8/9] net: hisi_femac: add support for
 hisi_femac core on Hi3798MV200
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
 <20240307-net-v9-8-6e0cf3e6584d@outlook.com>
 <37ebeeca-e53b-445b-9fa7-53a1b7a4dcd3@linaro.org>
 <SEZPR06MB695921BD3235F62E5D37E61F96272@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <1cdbe5b8-ed3a-46a6-bc73-6bf35e3305f2@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <1cdbe5b8-ed3a-46a6-bc73-6bf35e3305f2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [oj3Az/jHRyLO58e3/NP5dP8h4sk0D3PQPHv2uvfRZoAn5lPNZ/lQnC2Let6pDxWP]
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <cbf80b07-d6ba-42da-9f9b-5d124d161833@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEYPR06MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad23ca9-351f-45de-5c13-08dc3f4855c4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XG3hYTsBxGaDF6H58v2SV4nH4fadBSw6q9v8J2ZMfi2OxpDrE4d2xHugPeXcmZDiKOTtGbbLnARvOXihZeChDghsMht9WhBbXE+6p+ZtsdLLaJ+rYUqAgLMZNFkFkI+EvEqU02S9rxMy+nwG0YUxLyFiXjGOG40efpyg53rt7Pfe9lEJDtMPGshNjW22xDNragB5fZWZy+SOFlE6gSDV9iIGU/3C7hmvJeaeSVYbCijOfKE9qn2fZpycFTUgnsB2UguV0cwQtcrrpWhQoyikCfgFeuArroQTTxF6C0W0qUs+Fy4b3SKs88g/vnnL6N/LKwqekVFqgsmEXEdujYKIDzMkr9itaVq4VQnJ+wfNfFDC++NOffRNeadwN/yDzMtmvS8+0gTIxOtxwh+ulyt+esgcnHlNh13rTZaKuHGw8KPyhN323SnRA7DcNxgBJiHJrlgRi6DJ8VF5orZLBONqdsBt3ZoiYuuQrYaNC8oG20fPeyeH3R1XlYdTJFzLyNzIMD2ZKRUjEpoXWpaJ0nb3ApieAUwUcl/jkYkvJAwZJleh973Zum575/mNFoG3toRk
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmFvQ3FWNkpobEhRVzAyVk4xWFR1UmE3UGZHSGlIb01aUGp1ejh4QmRTWmRl?=
 =?utf-8?B?OVcwWHFUMjUycGVnNkhGUktkRWpoTWpuazNXUkFpNzBLTjdTaFJ0UFYraWFv?=
 =?utf-8?B?TFo3eDlqK0Nub01nNUIvMERHUGZ6U2pRSGxPMkh4RnA1MnFwMlFCYVplQTNR?=
 =?utf-8?B?ZlBSc3lUb1E2WkEwWVluS1N4YmRDbWVOWTRCZHV6aklpTW56ZE8vSFhGWGVB?=
 =?utf-8?B?cUlOSGphSEs4MUdWVThkNmxFR2F4Q1ZxVzRnWE9SYWZSN3hUVDFLc3dSYkFl?=
 =?utf-8?B?bTVGT09NcWYreWJSY24xRlo0SXRUWkRGb2VaVHdBZC9XZUJIY2JtWnZydFo4?=
 =?utf-8?B?RVpZOEZSZFBscUEvUExtSG9YYUE3cTRWYkZUSDFNRkxTL1g5SUN6YlRuOHhu?=
 =?utf-8?B?aElFcUxLSk1HWG9jT0tSa254SzVtMDJxRVNEdVFTdUtqQ1p4L0Fubnd3Q0p2?=
 =?utf-8?B?ZXhYaFZ4TzE5eHY4cFc3bkN6ZzQxQmVZVWJIMkJhQXJlVkhuZEZDSkgwK0U2?=
 =?utf-8?B?cElSUEJqeEJBU2VNdGhGZzE2anFqSk5KeVhrUjRPM2FIRmdYU05BNFhXcGht?=
 =?utf-8?B?ZktIYVd4bHgvdncxSzlucEc1MzlnU3FkYlFuVjBIV0xjc2pKYjNTVDFxK0g1?=
 =?utf-8?B?NTFwYWtpZFh5L1dLTm9VSitCMUp2UlBqc1hrcDNaNmoxaDQxZ3VwNGltYkpI?=
 =?utf-8?B?MlBxckxGb3QyKzdQSFJucnJmWisrVm1nMFJiVnduenp4dU5JL1RjM0RuN3hp?=
 =?utf-8?B?MFpieC9SN21sMjlPUmNuZWZ4ZDEvQXNYcENuWUFtN1RiekRTNU1FV3crQnp1?=
 =?utf-8?B?Ykt5SFBQUWhFTFJDTmlUNW9kaVp4NEEwNDA3MTcwbXNUOSt4S01sQ1VyRHNZ?=
 =?utf-8?B?UlFOYmZBVFN2d2d0SXdUYmRxdEFjeWdSNlUzMXBmbnhPb25TOW5lVDE4b3Nu?=
 =?utf-8?B?cUZmcEdwRXNvcVlQTUFrbjZMTHBRdVRuNStYMTlZNzRSeDZqM2V1akRtcWN4?=
 =?utf-8?B?NldKZ3llZEYvVE1kRHpQUGU3bXBTYVhZOURMUmJaaU9NL29CUzM1bC9qTm9D?=
 =?utf-8?B?QjFEMTNvcFNQQ05XZnJObmx1ZUxzQzdEcis4NWtzcERRcGhqLzBVRlhoZU1D?=
 =?utf-8?B?K0lwNkt1U04rV25lQUNBUzk4YUx3MUl1bmYxc0dhSE1wNjQ3bUVyUS9Qa2ZT?=
 =?utf-8?B?YjhVcFdZODlxZUV0SFlQYXprU1QyMXBBblVBbi9LRTh1WCt2TlpUOTlkMEdj?=
 =?utf-8?B?ZHhTMkwvdnhqVDRxcVVCNUFDVFVIQm5ycTZLUVVibDJObjNLQ0NzSVhLVDM5?=
 =?utf-8?B?VWpXTzUwbjVnbUh5OGFBcW56YVE4ZUd2eFhmSFRGc3ZDZ2taWkNTZEZIN09U?=
 =?utf-8?B?YzFoYlY1Ukh0T2sxNmpTVkNFR1pDWjdqblVrUmNaZTB5WGJ1UERzcVdJVG9j?=
 =?utf-8?B?QVZPa3E3K2syK0JDVHVrRDhZYUVjMDNYUGhVdENZa1c5V0VsaGJtUmdjOVNP?=
 =?utf-8?B?aG9LRVA5eVN4QkZ0QTlGcmoxNGVJdHR6R2YzOUxpaVVuTXViSFRTVmkvNCt1?=
 =?utf-8?B?ZmxES2VUMldYN2VLbVlHRGU4RHMwWmwrcnZpVVVqQ0tQdDZIYnRaZkZNeExQ?=
 =?utf-8?B?N1dkMmlRK0lNVWpCd3BtQk5OSTJXNmluMExaanhJa1g0VVMzNUkxY3BzbkhH?=
 =?utf-8?B?K05rNWoxRk02aFgzRlAwTHZkSitGNlVXdEN1eXJOSVE5T0FlV1VsTWlwNVZ0?=
 =?utf-8?Q?8eHVojkbaH2QFq/iGQ=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad23ca9-351f-45de-5c13-08dc3f4855c4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:18:29.0719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6456

On 3/8/2024 4:09 PM, Krzysztof Kozlowski wrote:
> On 08/03/2024 09:07, Yang Xiwen wrote:
>> On 3/8/2024 4:02 PM, Krzysztof Kozlowski wrote:
>>> On 07/03/2024 12:34, Yang Xiwen via B4 Relay wrote:
>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>
>>>> Register the sub MDIO bus if it is found. Also implement the internal
>>>> PHY reset procedure as needed.
>>> ...
>>>
>>>>    
>>>> @@ -946,6 +991,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
>>>>    
>>>>    static const struct of_device_id hisi_femac_match[] = {
>>>>    	{.compatible = "hisilicon,hi3516cv300-femac",},
>>>> +	{.compatible = "hisilicon,hi3798mv200-femac",},
>>> Why do you keep growing this table?
>>
>> I'm completely confused. Don't I need to keep binding and driver
>> compatible ids sync?
>>
>>
>> The FEMAC cores on 2 SoCs are compatible afaik. That's why i want to add
>> a generic "hisilicon,hisi-femac" compatible. Though i know nothing about
>> the mysterious version numbers (v1, v2 etc..) documented in the old
>> binding, so i want them to be removed. Instead only keep one generic
>> fallback compatible.
>>
>>
>> Do you mean that i broke the backward compatibility for
>> "hisilicon,hi3516cv300-femac"?
> No. I meant, use one as fallback and only fallback needs to be in the
> device ID table. There are dozens if not hundreds of such examples in
> the tree.


I don't think an arbitrary SoC compatible is a good name for a fallback 
compatible. Why can't we have "hisilicon,hisi-femac" instead of the odd 
"hisilicon,hi3516cv300-femac", If we are not going to keep backward 
compatibility? Hi3516CV300 is just an old and outdated ordinary SoC 
after all, but the FEMAC core is still being used in latest SoCs afaik. 
I can't see the reason to relate this core to some old SoC and keep the 
compatible forever.


>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


