Return-Path: <linux-kernel+bounces-108262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D976088087F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168321C224A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E75A23;
	Wed, 20 Mar 2024 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RbE8lCNM"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2019.outbound.protection.outlook.com [40.92.102.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57527628;
	Wed, 20 Mar 2024 00:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894056; cv=fail; b=V1bwsHNCOYphj3gns67Fmubey6UdtHhM2OGDIlXFTy/7wQSVb02yav8vZvVSRzlQWl4nJYA13xx2t9hPSqezLosCZ/04Le3vHSMBdBNtTtigqwf1HDr+cDERUoT1upb8shWfLpuZeWweA1WfHrkwfgvIxiph83+FxyNDPgVrbZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894056; c=relaxed/simple;
	bh=PYPdCS4dxRDm50ctfF1vfoLr/2sFMv9MUnfeM01pbXc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fjg+cpUC9w3sHdCPRelC1X84JYKcIMuH19tQFwlVDZlTy8Zvdar4FeQ8w7u6fet+nxOvOYfM4fadW0ogfC4g5lx0fXo4NkXlW8uDDl7VwKjJRE4CwPNFynaPXaDqIFsfcPYfaxhcJfnIOpJeie05bOhkGnun6LQLv7FiEIx1cE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RbE8lCNM; arc=fail smtp.client-ip=40.92.102.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlxQSDoEAfArJ+eWDqCP/lxVCOWBzfSTcE1D4V9W15Dk69ayH97GwPA/VtbW6ByL4PlmVKadN661hTRoTtZ53FH6X8vLhil0+Xbq8NYSmBuD+JK1L1SMXtkZh7MCx7u6sZDW+93dddQK6TpsEShKeNtIN62xJJfb6n2CrVZEDGIUzgfOZQAiCROnh4ESN9t7edqWSrxtKGC7aOfeWGSV5tXHRJSbxCXg8mjR0Mlgl74wHSsFn8IlxQGMy3qsuN9XBmfmXTaw91rrxo2t6GZ8gxyjr+AxpjnoONuOV8MduFxCkA+2FGLjVXEuTx4Kxrf38OyGjMdb/bbE2VUEwFLEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGcEnkPudbXO1UE8KGEJRwVGIHCngp38DpNNfXHf+iQ=;
 b=dSmnc/6gJRtD2v5Pe1F3UaC06UT4My3DulLtmwvwGaLB7/gOBVPJjjjoz6/3mGHBH+kaHW88qZ3bL5prZ7kN7BkRvcfPW060c4PeQ8o2RxN0f/IEvcLJGIqQ2AQVMLDIDfr88cCaTsJT3hAer2lihJ2Bv5642Ynb7TD/XzHrz9Q7WQ4w/av+5iQQapM04rINVBTUIjjagJhKAzYfLp4fyETfsK29FvbX8G3IzVLOb+J5tB6PkRMIN96YgLnqt1Gy+I8/tVivdTKvs4urlKDUx3e+FeUJLQ4EPH7ziexU4n8eNeEzSA1zokap7SS3l1mfHbC0KTLTEFeBKVG+5xS3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGcEnkPudbXO1UE8KGEJRwVGIHCngp38DpNNfXHf+iQ=;
 b=RbE8lCNMm2Ns2ZJSOaXo9/XjE+nVeHShHZRjUBY6N4zF7jS2cn6BnqwDkJ+jAvvGZKCV6/+D6GgS4hVtb3gc0v+nil2+yb4gyjDZMopVZHXyygJe+GQ9mPmJpBMhRkkmO4sgaJ8N+oPFSuBgrXlXddz+5Jjv31sXw2+w1uH7TedeYDRbJe/qhfDRl/Noq0VpOemDoOq2y6IFODIrNshxgIt5T5TvQKl38nQx0ctPUjym6F1XutEPaGTQzt7mrBhULkv6C0P9D+V4AgWK1bUMMwhqBG49+j03epuhe9aInXuGcKve3BJD3NccAAyObT4nbjy2zK8Cp0kT/nHmNtBkmg==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB1526.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:186::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 00:20:46 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::1bd4:64d4:daf5:ae42]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::1bd4:64d4:daf5:ae42%3]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 00:20:46 +0000
Message-ID:
 <MA0P287MB28226312B98C83517CD0D7D1FE332@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 20 Mar 2024 08:20:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: reset: sophgo: support SG2042
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: unicornxw@gmail.com, inochiama@outlook.com, arnd@kernel.org,
 aou@eecs.berkeley.edu, chao.wei@sophgo.com, Conor Dooley <conor@kernel.org>,
 krzysztof.kozlowski+dt@linaro.org, Paul Walmsley <paul.walmsley@sifive.com>,
 p.zabel@pengutronix.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, krzysztof.kozlowski@linaro.org
References: <mhng-76918908-fb82-4312-9320-959318b98b5f@palmer-ri-x1c9a>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <mhng-76918908-fb82-4312-9320-959318b98b5f@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [TRwMbo3r5377wlRQVEglJ0jODw2wYNKJ]
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <e78e6cb0-6572-479f-a100-7fb676829b0a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB1526:EE_
X-MS-Office365-Filtering-Correlation-Id: a29e5305-6190-4cd3-b6dd-08dc487395ca
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iAnaMvpuoB5sq6f/OmYZpdFuoCKa9BMz3ArAZuSjiPHKhzM664gxdO3vI3Pn3EvMz//nGT4r6+Lnx+0fZtz3F/trCXZDXHaFn4RuOumiLcWkDvICoIDioWCV97A/qbVc0WQ+hSErCbBNeE8gHzmDPnK6jNLTgnghFlPxoOx68gFeyrdfAkIEaEZhDzlp1CLNxTaiqPKGsdXDiXKcKoM3ElFNenurh+jxq8qG7IrRRFOpwpPjtFTmQFDBcc9Lqn6Ep3+A5vZXhfvhAHTnIE2OUp3CINmVKV5y/Xw47Ay2B3lZYULpUd8dBFZQaNFVG1Wow1xk3ZFVffBnVTHx2cllced13iurxxxg7VH31GJstrokfzyS1+doNONPcDXxutdoXDEY/1OBqjbHWJ07hmHC94CkcSjfmerj1sYVvz6w8hwSEE3JDRXYBQVnadm3s9OisyRRX0zXR7GUMtUnESbiwK3jAe48eoe196RsM3bsihxyg8plcxutHw2uvl3FteaFqJD1gfS5cWtUZ+GN8KZKwU2Wqlljvhb7Bh3l3RGrJqeWUQxCfw6poPb5UXuMtVB7zwr/tBZy8KyAdx+YVpdg3dWjnk4WuMboepvrFDSJyKi766LiB8V5Xg8FwnjFew0EEV9CgVh5NFA/GVLqzXV369MgxwzGhI1FoTE9+un9g8E=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2VHSElwdnFBY2crVTRCeHdhblpDN0ZkczdvRlJ2TjBKdHNnRWUwWXlZNGZ0?=
 =?utf-8?B?TkhSRmJwZWRyUXZKbmxVcHJvclRtMmlITG83RCtLenJIOUVWMEY4Wjg2dFJu?=
 =?utf-8?B?KzNOcVVKcVA1RUQ5OHNDZ1l1MFNEa2xWdUtUcU1taHdFZW1pWnJLZlM4K1cr?=
 =?utf-8?B?aU9TWlk3ZXhmc3psMysvakRSUTVPZVprZVdMSWFBV0dUdnV2OERjN1B3NzBN?=
 =?utf-8?B?OUcxMTVocnZLNDVGeVErQ0czYTk0ODZHeVZ4V3FUejF6WEJmWmJoaUtFeG9B?=
 =?utf-8?B?cUZmMUJiYnFNbGtHdWkrVkRKUVhTTnhHUmVqcFlJRlZMRzgvOUNBa3QxQ1cz?=
 =?utf-8?B?eXZBeEhoOWJFOFFmM3dBbkVBQ2E1WCs0ZHZvVmdzdVdHNmVTMFhPSVkyclFo?=
 =?utf-8?B?S2w5aS93RmJIK1oxTGVibHpKT01MYU9VMTlTZ0l2OUdhOStFZmFnUUV5ZlMv?=
 =?utf-8?B?dVVrTzE1S3I4MXkxMVM5dTJkV0FpRW1idHlENVJNNEROZ0k5RVBrTnkwYTM2?=
 =?utf-8?B?alVXbDVleFJOcVh2T2l4MitmNytNVEg4dFp5K2ROQ01UTEQxZ3BtUlhDK2cz?=
 =?utf-8?B?UWFRbkVxZXB4aDM1TmxhSTBQcjNVL2RZbGFHclZNczVVWEJBQlFTZkx0VFpO?=
 =?utf-8?B?RkR3VktPZXVnYmVQOEFzQmFhcEhtUFJOWU5MZG10bTZna3dOajhQM3JkcDBY?=
 =?utf-8?B?RVFVdklrUE11S2hPR0l2Tk43ZlNGdG05ODI4cVowNmFqYTlRNVRCaDdFR3NF?=
 =?utf-8?B?N1lmNExXU1hhZE43ZVQwN0dRWGMyb3dpMGEyWStmL2ZuUm10MExYdFpxVjAv?=
 =?utf-8?B?bEFHejlDVXBCUGNZUDRTODlhUTN6MDByd2VnTGNuOFVJQ3NiTnlnbkVXMnM1?=
 =?utf-8?B?cVROWXU1UXpNZmN2WFBrbUlSQU1hTURKellOcVJtZ2daQ1BGNGloR1hLNFhD?=
 =?utf-8?B?Y0VYWVpLYWlacVRSVHo3U2liUytlZTF5cWhDVTE1eW9rcGlLODZ5S3RhQk9D?=
 =?utf-8?B?ZGN1YWErMnl5YS84SlFGOWZ2RitEaHFPMHdWUjZlUkgrcUlPODliSTkyT2E5?=
 =?utf-8?B?aGdERmIybDgxV2g4NklhY1lQeG1LTUR5N0x3cnFJamphWnIyZVRoaExmQ3ZU?=
 =?utf-8?B?ZThzYytmVGkzbWNlWHh1VG5WanV3aDlaOUhlSU1uUWVJL3cyVDRwL3lMUkd5?=
 =?utf-8?B?dUxUOGt0UjFVYm8vS3h5QWhEUTBNTUpxVk9CcWtYR2ZGdTd4ZnE5NFkrMnVa?=
 =?utf-8?B?ZVFudU1wb3EyMy8xUEVkMDdNaTQ1RU85TFpraWt5MVQxZ1UxVVlSVElLclBH?=
 =?utf-8?B?VDRBdE5nbVd5bmpXYTFGOGFXZGlrK0JJT1dNa1ZZUStnVUIvSVVoYmZkTGdz?=
 =?utf-8?B?VUNldHZSYlpPSkh2M1JBQjc1c3I4UThmK3VIdHVnd3Foeml0YzlhdnVuaFky?=
 =?utf-8?B?NG1SYlFYWGNpWllVMTZ5S1VNUXV3b3pSdUp0LzN2bXJwYkhzYUxOaHM5VEZa?=
 =?utf-8?B?aWFhUjhaOW5iMXNpV2x4Sjk1Q2hIb3lYakZUYlVDRzVqSDJVbGMyREdnVVBG?=
 =?utf-8?B?ZUVXRU1hTGRnSkhTaHRRL2VWaFNJdm85ci8yVVcwbGMyd094dEpVVitvZExh?=
 =?utf-8?B?QjhudTJvWnFlNERna3N3dzNJbGhKbUZ4N0hmVlZYdHpIc0dQZGJmMFhqcitq?=
 =?utf-8?Q?hvAgLqIVl+/S8Kf0g0/w?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29e5305-6190-4cd3-b6dd-08dc487395ca
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 00:20:46.7136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1526


On 2024/3/16 1:21, Palmer Dabbelt wrote:
> [...]
>>>
>>> This is now
>>>
>>> Fixes: 1ce7587e507e ("riscv: dts: add reset generator for Sophgo
>>> SG2042 SoC")
>>>
>>> which landed in Linus' tree.  Looks like that went up via Inochi and
>>> Arnd.  I don't have that in my for-next yet, so I'm just stashing away
>>> this patch for my tester.
>>>
>>> I'm happy to pick this up if folks want, but it'll probably be cleaner
>>> somewhere else.
>>
>> Hi, Palmer,
>>
>> I see Arnd has prepared a tag
>> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/tag/?h=soc-late-6.9 
>>
>> which contains the bindings part changes for sg2042 reset driver.
>>
>> Let's wait for Arnd to submit, although I haven't seen this in Linus's
>> tree and not sure if Arnd have submitted this.
>
> OK, sounds good.  I realized I dropped the ball on a fix, so I'm not 
> sending a PR this morning either way (I hadn't picked this up yet, 
> though, so shouldn't make much of a difference).
>
> I'll just leave this in my not-for-next until it gets sorted out.

FYI, I see soc-late-6.9 has been on the master of Linus's tree.

>
> Thanks!
>
>>
>> Thanks,
>>
>> Chen

