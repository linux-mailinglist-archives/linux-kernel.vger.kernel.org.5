Return-Path: <linux-kernel+bounces-86279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB13686C341
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F626288411
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8E44D9E3;
	Thu, 29 Feb 2024 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eiH9/h2z"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2035.outbound.protection.outlook.com [40.92.53.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174D245941;
	Thu, 29 Feb 2024 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194506; cv=fail; b=fXm7Yjtc+Xbt0ehOD1sUA+by1QZfO+8h3MSYXk0L725crqsT+PuFmrvPMkKwUq1MEsaQl9LHIiker720PoM2erb6fIrKnaKwdM2PCDnE73W35KJzMDUoBC0d7HrpvOrJjZNbdgMO5G2sqvSDwugKCd+qy3UB2O+gmdECow6D5fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194506; c=relaxed/simple;
	bh=XsopYNnvsIeKc7cVR/gv/ZBoxAKHig2UsJixac9kNw8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B1h+sFlI3NpdOTKoDKcLAtJhWtGJ1LYRsQ8iuerd0QEXRVDhbtBnEpfmDd0icZI/r71c/GhDVjTGv2prZ38D5Dgf8JGY5dxJXF7wvXjdJgEILo1yM/mt/RCClBY9xsCfJzi8T3jNKsEtbeBjZfU8B/tpqw+VYJHeonmQmXNBFhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eiH9/h2z; arc=fail smtp.client-ip=40.92.53.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgFp7KDuqhuKPHR3F4zgWMp+yp7seewkssgP2NelbQybK5aYnun3wb9ex+yjnRzaMQm8FvtaiN7GqTW9VfRC/8qFpWEdrBXccknPfUXKdlABoUk+I8qiluETO1rt7O6P6X7hMLW862QCCJg3DQPrn5cuDFDOsI00nH7qK0DrPEyggcyht/jkXaS2bujpw3RgK+wRu/lFyXn75cVHbDn4a6CMXFENxBq6VFmf8b53OinIU2djstCrE2t50QTqhpX9/Ml8e261s3GfQwiwnh5yfQ2V/uaSojavRBtuIs1AKxZDKkpCIbtR7lslultgE3V0yYL9U6dswC37xhjp5vDEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32+pgeBc/5zAt+7DN1XE5dsSbvUBiD8pgQKBmM4fp9Y=;
 b=C8cc4kdd3wG4Yji1Y9I1Uez+1wiQDw1FEIU5a1kTGJmBEM9bVRAMT2zm8DXM0gZE1qSD0tsfZbJ4FqftTlQEgJ8ANi2RL8y7XEJNE/WamV54YTuyXUsGaeByEUIddh4E0byRraagX0xRK1xsU1+UXF3Gzn3hdc1rDF+hIwGhzhNlPElYp+7gdhP4DOAQVmTTmHbFghE3Xe1txiBTbuyqUIR8WghJIvc7ehb5Zg5334/TJRnVev/ISYkZDdBdolHh85GDJUa5leRtYdXIaNtWiDkOGGGOFsKzoXN18TaSzvzxI9xq3FxyITvQADkW5WCbYkMRQg+TZniFPt02ZbJ3eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32+pgeBc/5zAt+7DN1XE5dsSbvUBiD8pgQKBmM4fp9Y=;
 b=eiH9/h2z5vPUKxoSKKUVV+d64H6uPNUW4uKPwEm06fg05jiv2DqT+wIXfNhMzXGmwqh+vx2PaXiKfJhVYudxuUKx/padx0ffGkSf6kFPXEglG27pcfYiMaWbVuh47e9rmsnogD27J/cF/diTI6PZVi6ZgDsPkV8UhiAFX1VI6TXEH5tAP1ipShuJUEf8hVxN9utaT7WNckLGDarX3rsHdOqdOu0nAbJ0rv3uyRrS6iynaIuk+Hy3OaWwdAbsBSMwrliEo8pqm+iGijQ4knyldqqlxWC3uQUJakOetkDjD1sepANJqy6Jq2pzChIUTEOeV5PD0zWc0Yj3cy/mJTvBXQ==
Received: from KL1PR06MB6964.apcprd06.prod.outlook.com (2603:1096:820:121::11)
 by JH0PR06MB7351.apcprd06.prod.outlook.com (2603:1096:990:a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 08:14:59 +0000
Received: from KL1PR06MB6964.apcprd06.prod.outlook.com
 ([fe80::bdb1:3c40:b3e8:1f15]) by KL1PR06MB6964.apcprd06.prod.outlook.com
 ([fe80::bdb1:3c40:b3e8:1f15%7]) with mapi id 15.20.7316.034; Thu, 29 Feb 2024
 08:14:59 +0000
Message-ID:
 <KL1PR06MB69645ED79CED22F5BB1DE45C965F2@KL1PR06MB6964.apcprd06.prod.outlook.com>
Date: Thu, 29 Feb 2024 16:14:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 11/11] net: hisi_femac: add support for
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
References: <20240228-net-v6-0-6d78d3d598c1@outlook.com>
 <20240228-net-v6-11-6d78d3d598c1@outlook.com>
 <7c171041-30cd-41a1-8b8a-00168d112cc5@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <7c171041-30cd-41a1-8b8a-00168d112cc5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [4O0ddLx7Ij6eyrwPId9oOhyiJhpWG8TGvlVj50oNd3xlZEGiHmIHNyqbqCHyLg0n]
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To KL1PR06MB6964.apcprd06.prod.outlook.com
 (2603:1096:820:121::11)
X-Microsoft-Original-Message-ID:
 <348bb853-adf1-4168-a370-ed39c9b2f2e5@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6964:EE_|JH0PR06MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ebb8ec-c22e-4c19-bb3c-08dc38fe8567
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BS9QWZ6pUSC4qTzsnzeNX1qvzTqodTaSB6R1hRo1o5A6sI6IJ9mggIemHwcB2eJMT12aTfA2xFB2dSyboYpt1Gq5zQudW64NZV43xn4WnMDWDKoMLdakJ9S8MmqcqKS7I2fTXtNonccem95P7oiIUfvogvUSHDZsyWdOX47Oza2DSOeeMxmzGBzc4+o+zDtxb0Oa47G8ErVkcAq9j/hasMT0JHYIvGZiGtSCt0eyMzXZinji4+bTT06pBnsjIy0BzmCY7f+rZcFDmAw+ivyDVopwfeBPyqpbKMCm+FOmSMgIgOSeonY9xVujuEA+1R1cVlOEpJeTqjoP9YOkvfVLb95mSu1U86wl6+/NAc0C7bF39SXQZjZjQrH+cYRJ7dqKo8iZs4LHjd+s9oLBQn3yhK7kRVkeTgfFJR8A0nce16YeaBK4NeAIW5QWGi0ogeIncX9VmPSoMtXAaRBWkTPfeR9cVls2dTgKDsGXGa4AzvfpIbRq7K2DILEcjov2jTfPzIL+D1iSUcdUuJ/eMCjslsEDQIDFLgMl0BHHmac0SqQqUehnc0mRIGbZa/vKiz76
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTQrSG1ydml6N0tXZFo1a0R3am4vNjE0dnJaZHF6SitKdzhjeHpEUE52OTFT?=
 =?utf-8?B?SCtJakN3US9MTW1McGNQQ2FLcXJPVU85cnFzMFZxaXhsSDVzZkxaS0QwemM0?=
 =?utf-8?B?L3ZaanIySDZDSkYwUVdJZ0ZhNTE2dkdvbG5TL0xPemlMTkdJUmhJcUQxQWwy?=
 =?utf-8?B?dWRYR2FsYmZXZ0lXQ3NUaGpLMzFGejNPYnF4b3BEdHhQVmtnQ1lhS2h1ZGk1?=
 =?utf-8?B?SU9QZWNEdEJMUDlDSUtOdzRYWjlCT0lkMjI5QlZQY21YdVA4V0UwK2F5M2h6?=
 =?utf-8?B?UlJQWnRKdGhTTGp0TkpqWU5LNS9jbGJiWm04UjhZUlpqR2dPcVppUXNBK2Mz?=
 =?utf-8?B?T1VCY0NINjNMbzNUYVAxUElqb1Z4Y1RZVmtQcGxmdlZqdFM2MjBkSWwwd3Yw?=
 =?utf-8?B?NTMycWZIaytyck5EM2ptZnlEL1dGMUUrelV3aklOTUFYVTE2YWIyRFN4N3hP?=
 =?utf-8?B?dkVIeXpRdHp1MUxUWWRDZ1dyL3N4aEJ6d1VyY1hXTmk5Nk9KNy80TlREUUJo?=
 =?utf-8?B?M3F4TU5ZN2pVWllGTURubVZ0cStycGF1d0dLZHlnbFlCN1lOUDBTZzJwVTly?=
 =?utf-8?B?YUREYjBaSWxiZ0JpVlExUnhnajZaM21mNzZHSlBSRVl6WHpNQXV5VVFLcm0x?=
 =?utf-8?B?Y2p5TlN2TDRCM2FKZWVMdHk4NFJ6Yyt2RldMZUxmbGE3SDZyVXE0VUJiOVVT?=
 =?utf-8?B?N2xKcUs3WUEwaUs5cGZLWVpndTkweFF4R05kWkZZOGU0dHd0a25kWGd6TXJp?=
 =?utf-8?B?citySzFOZkVOYitFOHpXOGhHaml5MHVxVU5rTjJlTjlua1lwYkNnUFBFaHJD?=
 =?utf-8?B?SkdEK2RMSm8zWThra1M4dlZYc0VCWlg1a2NoQWMxZUM5QjRJVFNRS2ZHbGk5?=
 =?utf-8?B?RGtaZlR3U3VZZEZZazUweU02cFp6RW5NUGZWN2xReTROZ3RiR1hpckx1anBs?=
 =?utf-8?B?ODBUdmpvaHkwWVlwK3dIcUtnMVZMTnBFWjNQMnNPTVoxTXIzbzJKanhvQXhx?=
 =?utf-8?B?U2ltYmtFdXhkZjBWSFdEU0svcTRURUJNWHl0ZGo4UEV3SHBVRlFrZzNHTURs?=
 =?utf-8?B?L1k3dzdmWTZMaVM2eFViZjR4VEdGMUpQM0NKVzFnQjg2dktFZEVkUkNUc0h3?=
 =?utf-8?B?dVo5NE1qZXFBYURRQ3Z3TERTNzhNN0did3VhNm1WQzRUMzdNZDJlSXdkZGpw?=
 =?utf-8?B?dS9QQUtvZW0va1BXSWpIeCtGS0pCRVdDbGJDWEZOMlhrTWNHalYvenoxM3I3?=
 =?utf-8?B?WGw4amx6OWwrOGp0bjRMUFVDcXVBVzNoU21Ud0xoems1bUpRZHhFVFpkaUxw?=
 =?utf-8?B?MDRRSmRzMW1Uemk0UU1Za1lvUDRvRzRFa3piNjhWQUNFUDMwbnJlanNKUkhO?=
 =?utf-8?B?dmt4ekYvenRFa3NKalZVekxqMS9QR3l2LzErRlc1S2lma29ENzlhY0VHOUFk?=
 =?utf-8?B?Q0NvMDhkaU9zd1NCMnd4UzB4V0VkUy80THFvcG5tWE05R3l0ekJ4am9MZDZx?=
 =?utf-8?B?bzNJZTZTU1pCTTNRRGxvNUUvNEs0ZHFvN3pzTDNCUFlNWFVKODNqVnlvL05z?=
 =?utf-8?B?emRERmR3WFRGQno3VzNpbCt5T1Zza2xoY3hvK1ZjUzNML2dobHU1RHB2V3ph?=
 =?utf-8?B?d1JVMHNhZ3pFNEFYcEdVT1ArSVhGc1hDazVMa2k5VkNkVXk5djl2RUxaNnRP?=
 =?utf-8?B?K0V0NEFMU01JR21MaXQzdlluQS9mbSsrZkRhalgrdkNsZy9rN3RTR1Y2ZzB6?=
 =?utf-8?Q?4i1L4YyFv+/pB/L45HEOHFWM5fvVs6OP0a365yQ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ebb8ec-c22e-4c19-bb3c-08dc38fe8567
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6964.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 08:14:59.1968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7351

On 2/29/2024 4:10 PM, Krzysztof Kozlowski wrote:
> On 28/02/2024 10:02, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Register the sub MDIO bus if it is found. Also implement the internal
>> PHY reset procedure as needed.
>>
> 
> 
>>  
>> @@ -947,6 +992,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
>>  static const struct of_device_id hisi_femac_match[] = {
>>  	{.compatible = "hisilicon,hisi-femac",},
>>  	{.compatible = "hisilicon,hi3516cv300-femac",},
>> +	{.compatible = "hisilicon,hi3798mv200-femac",},
> 
> No, it does not make any sense. Why do you keep growing this table?

So do I only have to keep the generic compatible "hisilicon,hisi-femac"
or the two SoC compatibles?

> 
> Best regards,
> Krzysztof
> 

-- 
Best regards,
Yang Xiwen


