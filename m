Return-Path: <linux-kernel+bounces-71946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A264785ACE6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C371C22BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF6535BB;
	Mon, 19 Feb 2024 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="revfb3z5"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2043.outbound.protection.outlook.com [40.92.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA7B524C0;
	Mon, 19 Feb 2024 20:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373695; cv=fail; b=owpCWd9pbpg8PjI4p1DSBPGPA1FSGtK465H8/Mp3TRYBjGN7ukl+5ER4ZRIcOsM3qPVoVVUw9qlByOrnvLQq1qfpsEi7ld2Ke75Ta/prNpxOgRCB96YHdu86KG5zfxm5O0eAa03CdAQXJLhNpliSg744xojth3eTGSFsNu+2+Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373695; c=relaxed/simple;
	bh=Ii/uElq++1l20Zs+vtHDVPN8ID8xPuNdGfEy1jPWgQA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ut7oeYtD8jTTP2UtKKJR6I22zA4Kr1e9xOD9r/AwbPeOKTfIpeB58jgMTGjOI2E1fRn9JNl+Gm4NQn0JyldtY0n6YNv/D+ozILRIa841BG8Z/tynTIvcVKAcdp8CbiqhDtTVfybyhEB4drmD4tHb9UuRDynjiXAoET92vTXZbYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=revfb3z5; arc=fail smtp.client-ip=40.92.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGKKj8Ks3HOW0riEbd/qv477DIcDt5l0HOHCUYYexDrR7omgehPSX23E7zZ5WmHuxEoKeksMCR5aIT4NUZg7Ucx/nQKPsDwGusW+U86XlblsOx1LTEtyU67VVTNchG+YytyeB3qc2nTfCokM8HldHTFff2dLvjHbFPWdp0A+RhZQHZY+M3OD3zJaW7mDNe7/HBSBa91256+6ETcYT//2TLikw1PeYK3KWRL4mCwm/7/sNVySgEF8Ee5V5usOiPM8qcRsKyyHP8q5h7lbYEVyTzW2Y7zsn+hMTS8T13mtil1bi+ab/M1mfCWodvOFT3Jba1XwNt0N8Y3TFi/GnxX2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jqf054I8NDFp650Vm0yCKqwF8EdiUoWxStggJGnXltU=;
 b=U3f79ZL1Fo/0Rbm+O/p9diNv64WVnYrT6lXhEfoji59FVqRSAYYIPIBjEn3slwiovvbs7XGD0ogfpSdCJgzNcjvqK4g1qQ12CC4lU0vvj5jIeEVdOG9CFZ4XxZao7y2a55AXYPKVd3Ewkoq+nWfIdQUdiGOl9ZL9tY2VhVX41Nyw3RuyEcu3VoRvT11L7K350cfkHu8tmPiWS9nhw6K4F3K9dhRDaVhh4DZE0ai1idpJhZccPddlkXUI2MoQ++V0kLOQWutDlCPw4CiZgC3x0FdNUW5lVzW99SyYRLRFnMyP/L7+tPwVOWAoOHXw2AsfwHQv0gdpbhm6tuEKQ5UKgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jqf054I8NDFp650Vm0yCKqwF8EdiUoWxStggJGnXltU=;
 b=revfb3z52MGnd5fsKi5owNOddWqM0faRBfXCySG7Dx0WFOJ4WYuIaqNkWVXYLE7FhIJM+hBVuWtjgGWPd4NL2s13xSg/ZUmyQJXjml5B3PrjMdZ+U66NL3BKajyoO3Jc94TeHdCgy1Bv1MEKVTnrWVZnU8OXOJP5fj/mPGKFJ7p9i9h7AFgIEx6wR51q5oyxREfrJNkl2ZsSLivYVMiYOIG63z1KAO0767xEKSE7foaFV5OewPuvs9t1KshgljZOwClSd9YW0f98MNgux6u5Pf+meN3GS5i/bKM+/aZ+q8vGovpOc/ti5/JjqFPZAu17rDcJ4g4hnUBrXX4+n8ojow==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEZPR06MB5761.apcprd06.prod.outlook.com (2603:1096:101:ad::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 20:14:41 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 20:14:41 +0000
Message-ID:
 <SEZPR06MB695901E7D4BEABE1B6F319D096512@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 04:14:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/6] net: hisilicon: add support for
 hisi_femac core on Hi3798MV200
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240220-net-v3-0-b68e5b75e765@outlook.com>
 <20240220-net-v3-3-b68e5b75e765@outlook.com>
 <29fc21f0-0e46-4d0f-8d4b-c4dbd1689c55@lunn.ch>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <29fc21f0-0e46-4d0f-8d4b-c4dbd1689c55@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [q95owkX9adtiriSmXbCKArF60re7INXc7ujYAR7UTkBcOPNY4lsIJYmXIIfTBdioBmYWaP2YLDk=]
X-ClientProxiedBy: TYCP301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::10) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <7590ea00-54a2-4e41-a25c-c15b3b180f72@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEZPR06MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: f50fb0d7-7ed0-4bf5-dc80-08dc31876730
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kHcuP3IwTPWhKuATPRAILlwXnAX3WnG+VQOk01GdfCoazP2HKYX5GahRiupqqoREoLYDnRuq7BwG795FYfzPOll+hzPnwoU/1zIBCDQwc7Zuhtm8Y/1a78BAhdO0nQN+CnxV7MZjAoLX5StRNvcwC+x+NmFJfDNyAnMm7yxAhV3+vMul81WN0UMmRo653v987cXYHIKl2cO7ts6CaCPHWvrmibbgNA0PmupoxdRHhWYI9fsUCMRRg8dkhwbhmJYRIKMk3IphzgDiNBmSTWqQ2sNfAC4H3qOjoyCcWT+lmAOdTK8zOTv/vcOamSStlEL5drILvnv7WCYL4Eby3l0t5+gsX0Jzc3t4qPG9sYHgkSXnlWRWdnJzKl9dsH7L1mS1zWbWpj3GWaGiBgyP8cvjs7PWx9jZPt57En12pXRgHsR64FzETXVn9DWeEM2CWrlrpT613q6BVjnW5/AAUZaE6Z6ZrjzenhOO6Ig7OwEp0aUUjqqfdulRGIx6pu7/0Iv8c/3X5QjL53SpzhtJLaqf82r0vf+s+uSrJbuMxpggedRtn0e6sSZCWMUecOgbXkNg
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVhDbzlSdFJMczZLaVBBbFlUOXhvS3VraU1ERzJFYzhFTzFvdXhvQmJ4bWF6?=
 =?utf-8?B?alZxdE0xN3NYWXRreHBtRWpyUGVtczYwYTZLak5rbG04emxWVW1LUnVUcXov?=
 =?utf-8?B?YTk5eFVvcHhvTFlLVFIwMVJLVWROTnB3NXhQOEU3K2VhRTFDUmZGZXgxK211?=
 =?utf-8?B?VFZUZXlBSW41WEVsNkpYTnQzMG5FcDJmYjRBOFhtcEhQY2xhTm9wTHZwUVFl?=
 =?utf-8?B?anJLdE02VTNYaHc0TGMveXJLaEtMR0Y3UGF0eDdsN212Zmp5NmJVQXFvdllW?=
 =?utf-8?B?dWFCcHJPVkdyQ0FRcTV2NlNkT3FiM25qUVI3N3RzYlBiVHRrNzg0dG1QN05a?=
 =?utf-8?B?cUhsU1BYVmRaMnNYN1dNNzREZnQ1WXhqYlNobUVhb2tIeVZnOUlpRnJPMkU0?=
 =?utf-8?B?a1JmSUppYzN6WnlwUVUwRFpPTkJZYkZYdExSMDBrZzR2SnI4MWxSajBqQUNQ?=
 =?utf-8?B?UkNxSEM3d2xrOCtBYTJyZmFDcHJ3aEd4Mm1zWFhqN3JIWmVWQUZYK09ldTh1?=
 =?utf-8?B?VE5BVGRuUlc1N1gwczUwdkViTGJoT1NWc3JGdm9kUzgyY2FJajVISFVIMFZM?=
 =?utf-8?B?aXBGZ2dHZE1SOXIrN29JSyt3OHg5NnVTMmZ6WXdNTHphZUVFT0ZZWTVxU2Zk?=
 =?utf-8?B?UW82TXJ3QTU3Njg4YWRVek9UV3dTQXZwT0pyaTBmZEx0VHN5MndYdnNhN2dV?=
 =?utf-8?B?anRyMWtPS3JXTEIzQThXK055dmlNaE5pa1ErYlVleGh4UWs3QkpmaE9GcUJN?=
 =?utf-8?B?ekkrVmdJWExPZ3o3Y2lCOGVzR2t4SHJhdU5nbGVKVERzN2RVc2ZGV25zS2Jw?=
 =?utf-8?B?TUZ6M09SZy9PRjdIZndZV1Zsd1lHZlhSaUJ0Umw1MHFMWHI1NzI4RTNZRnpm?=
 =?utf-8?B?c0NnYnZ4Q2N3ZURWTGJKcXBBaUNvTkhBKy9UU1VXbHp6L1F0S3gvejVhWk5D?=
 =?utf-8?B?YVRtU0dHcGY4LzFBTjk4QTBENmlFdEx3NkdQZjBZRXFERjNUMHY3RjVuTjVK?=
 =?utf-8?B?QmFhemxLV3YwTG15NlZIWkNDMmZMSE1qWkpYdk4rcGFmM0o0cjB3NFEvK2JI?=
 =?utf-8?B?L0x3bytITWNTTEpZdEVoNUJiMVhDMjk0QXNudFgzU1FOZUhHb1RMOWh2MHNF?=
 =?utf-8?B?T1M1NEw2YUNWV1Z0SzFLbzc4RUtGbHFpbFB0dWdDV0dzOVR1WWllajZHdXU5?=
 =?utf-8?B?ZmFBVGpXTVZ4NHQybmFOM09sUkZZYzYvajY4alRkbmIybFlNQVBFeHZnVEdv?=
 =?utf-8?B?bEQxY2wvdzE0L0RaSG9McWxybmZHSXpZOC85ZHZJTDhjWmpJR25GMEo2SjVD?=
 =?utf-8?B?ZGZtQldlMVFqMFptcFp3eWtweEozdnYya0Jha2dMK3NzSEZwOXlHcVVZRHBN?=
 =?utf-8?B?VnB4L0lRM01KeGNQMTIwam1XTFNZZmc0dUpLWnlPNjFzVVBtWXoyZHkwcVRa?=
 =?utf-8?B?RzFLajkwT0dqaEozVFlMelZJTUpkMUtvQWdINElOd0pwTVp3eHhqZ3p2Wk1O?=
 =?utf-8?B?U2JpMFhRVGt4WHk3TExaWGhpS0hHbVFJN3Q0OEcvZy8rQldkOXdjSUpNSGpU?=
 =?utf-8?B?cnFnazJiRmExRE82dHlLMVYvYSs3MTJuZGhlcGVaQktVQUdaWm80VjB2aXkr?=
 =?utf-8?B?QWpZYkhDeDhyZ3cyS3NVMERUZW82MHY2cUNEYlhqdW1qVEEzRlJ4NDc3Yklj?=
 =?utf-8?B?Q29yZ05BTGVjbWxyR2pGWis5SnhVZ1NPQSt3Yk5GYWZSQnZCVDZvWHhTQVFK?=
 =?utf-8?Q?vblmMdJS9GsZf7YWi6RHxIz1XFdIVwAxpqwkeij?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50fb0d7-7ed0-4bf5-dc80-08dc31876730
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 20:14:40.5708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5761

On 2/20/2024 4:03 AM, Andrew Lunn wrote:
>> Note it's unable to put the MDIO bus node outside of MAC controller
>> (i.e. at the same level in the parent bus node). Because we need to
>> control all clocks and resets in FEMAC driver due to the phy reset
>> procedure. So the clocks can't be assigned to MDIO bus device, which is
>> an essential resource for the MDIO bus to work.
> What PHY driver is being used? If there a specific PHY driver for this
> hardware? Does it implement soft reset?

I'm using generic PHY driver.

It implements IEEE C22 standard. So there is a soft reset in BMCR register.

>
> I'm wondering if you can skip hardware reset of the PHY and only do a
> software reset.

There must be someone to deassert the hardware reset control signal for 
the PHY. We can't rely on the boot loader to do that. And here even we 
choose to skip the hardware reset procedure, the sequence of deasserting 
the reset signals is also very important. (i.e. first PHY, then MAC and 
MACIF). Opposite to the normal sequence. (we normally first register MAC 
driver, and then PHY).

And it might be possible that boot loaders screw all the things up and 
we are forced to do the hardware reset procedure in kernel.

>
> 	Andrew


-- 
Regards,
Yang Xiwen


