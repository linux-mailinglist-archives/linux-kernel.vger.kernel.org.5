Return-Path: <linux-kernel+bounces-68229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB3F85779B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3D61F217A2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5890C1B94C;
	Fri, 16 Feb 2024 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="osf9rAj/"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2024.outbound.protection.outlook.com [40.92.52.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9946D149DEC;
	Fri, 16 Feb 2024 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071696; cv=fail; b=RkBKYb7lPw+fXWnMzt8CU6WbfTfxSu+1zp/6S5BaWu2+YksjmFd4tjkB9dVqMBflt3j0TRjrMGpjlKNkCbOeS2K+TrkpOiAE4vGqKgxssIWXoIv5ASGpOeuNODJe1nQRBxgkXPmUoiobwbHtNUFt1rqvA6Z7hCNHld1/M9X50C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071696; c=relaxed/simple;
	bh=h+EABU/BMFSIqvFLoEHKsFnLNQ/tt79BNDh7r0t+FOI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JOyTKuic+10wnq2T4+kLrDzeU56q+Yh0jva9azh1ntxi5yYKb/iqlWKSFvUImFwA1G0MA93nSyx0He0QRYcnbPEbgxL53HLjvUoT9GLInXoXs5MQfgg+qis3zZLmQyrcwWg+LYkRfwLBEA6ySgA2VoGIZDUlEQfmoR1iFCp9a3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=osf9rAj/; arc=fail smtp.client-ip=40.92.52.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6r2LYzCl+yMNjeQs5Ppz5U4PpkSjG6rLPPX5LR3YarcdjdEL/FnIlvRfQ+96T+pwtzY+y5ao5gtqqz9Rqd4gP9IwH46FLjmjCfcyGGca/IVqpvyK48Sq6ZeFgak+XZJykwXLgoT6JRlbI0G9ar1aKiVYdi5LJhxRy9TqjZCHQ6z8sQ9T71Br59ztd/Gw+2tjIVrhfojPq9wi2Tuh/m8OWDQdeMZywdst3J6qVXywpHiX8SFJtUqHvxQQZAe42GpZZK5/vmXB97PIzVYRyz1cFQkARapoQvf8qzNrdc5gWUcf97kpZK6Lqq8mzlhVcTVJ8XpXaclAntlJqc1oFgr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYB/Smi3vAzD+C03nKcWOEaIUu3S0P4OK7NSzevmbMo=;
 b=RF8Mr1v2j4q6ABgRbrGNo+eMZNnKr8mMQFVX/VwLCavQ0Xcavg0/Wgn9zbVSHc72USWrhp5OKG/phCkKVz/v9lmr9pPCx55/BWrYEaMGovLHU0/nCZE+sJRu+FfCWTWEES4dr9JdbfjjALo8rn8sUnG1gpNH8vMlyxyQ7S8WPcXzqJqjFX/xqRdD2wK/fyVnF8+Em2dj8vAmrhEcuTKYf8IpGHKpB1XQTGvdZEF3AsvRlYZ6+GdsJMXZFOfXL7UW/E+O4ZlnozBQG8sdTe5WnTJsu9f9VYgEJMDeK4KLEqrtmBwvysdQnOSW71Rs013UH0Ai3Jfzqgqo6erGSmYN0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYB/Smi3vAzD+C03nKcWOEaIUu3S0P4OK7NSzevmbMo=;
 b=osf9rAj/8HaflaWsw9HEWR0FFLrZttXOKrF1AiHpSr1iNsJ1WM5Icw2S+hQwtyFJ14NwpR7rbgU7MzPr4+kSMGwvAAP4Q0BF+sD4irBJnz24AWbgEm9YOSMCbYdUZlsynP7DOBnfzK2m2BtqSElvq0SJzXuFKCuDJshTZSkvjcvCiHVDSlf3afjFBBO6Uup9sTX4fkOhxZEQSFvO2wV+AxcDPz4hvpr5WmX3IAayF4aOM+Dc0DCNcEH0g6mJjBYMqXcVaVpmJPsrql57v8252tOyMfXBMLAPNoOf1GvPmBzRFZ5+YIgOaqobopchAkp+1Py5y5KnWcI0/v2/qkXZZA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYSPR06MB6750.apcprd06.prod.outlook.com (2603:1096:400:479::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 08:21:28 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.026; Fri, 16 Feb 2024
 08:21:28 +0000
Message-ID:
 <SEZPR06MB695938B228E762B9B53BAF2F964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 16:21:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] net: hisi_femac: remove unused compatible strings
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-2-e0ad972cda99@outlook.com>
 <68c9477a-3940-4024-8c86-aa6106e8a210@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <68c9477a-3940-4024-8c86-aa6106e8a210@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [LCLz05hA+WKZeVAFFOPAT8Vsav8usiaaHsqQkcT3oDk2VPR+W1z4JEpYDfZ/UqerbPocZZKKj1A=]
X-ClientProxiedBy: TYCP286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::6) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <1d45dfd8-7f2b-4159-a7c3-5d3b4464b825@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYSPR06MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 755bf9f6-a5e7-4b5f-05f8-08dc2ec845dd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9Sf/yegB8G8ViZbhyCvKJIRieJtXmGc82yL6DzBC7j441XcScmEJqdW/SE7LjtCVq2IcRAJwEcHxq40ay2CmKNdKuZSbITxpmecXlm9w7bd5sNaI/OujZwcJTJgBZMqsGCsR05xeQ+0CVsAMuNRaPtXxY8QNVtdf/uz/Jkeyzg2O9IQGeIrKwHtZn2fwt5Kwa222jmmzY16CBSq0CPaLT1UwN7I1D0UbEubUQkzZfJYLPdOSbg443SL4cMrtqiN2H0dZnAO79whhFH1d7pRSYJ4/tulLXTFZJlHEKPZk5ZtwPSNScC2aQce3KYybZ5wtDdrllE7sxNX6fVRiB1+X6vjzxdSFU6ugTug5dml+ihIuC8VIAYn9z9Sl4wU7yjevSFMSVBBtokqfgUpMwaJ2MyaDh4CaO1iPpVPlDu9/WjHLN7ClSoVfH0AVORFHFV+SEzJencSRDKZz3L6heLRR4FwLcDa6rz8Jt2AKX3MdI1KcHK0JutX4wZci06wTtXCQgy/6HrGfXgYO9mXonWHT6O2Trxs6yM8WyQu28VywlOgOaxzOg+A9ySPCDrVPfo/q
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0h2d1VMQzR3NElPUnkyT2JEcjBoOG04Um9JSWE0ZXZySGtMUG14K2hkS01Q?=
 =?utf-8?B?Z3NqUGIvV01FVTdwTnIzeGYxZWZSdGZTZFdhTnpSZUdqVkxIT3BvSlBIR2dI?=
 =?utf-8?B?SHE1RTBMc0drZDk5VmZObFBYbEx4VjBjNFpzMFpJdHlSZXpLalVUTHlFRC9P?=
 =?utf-8?B?V2VDMTkzeDJOOExBaVhad0lKRnlEcUsxTkY5TEU3RUZQN0ZnUDdzQ3F3cGN4?=
 =?utf-8?B?VEZiVVk3QnhxRCtwN0FDSkU2YWdFN2Nyc0t2aVpoZDNDeXp3NG1jZ1N1aFhP?=
 =?utf-8?B?R2lsMy9sSDRTTU9UQ01ZUmFCaEU2c3UwRWFKaFg3b1hQbll3MjJlMGxCaUpy?=
 =?utf-8?B?dGRzSnN6aS8wbVZjQUJPdm4vMlJqTFIrSXdwOGN0OE1NNW9JbWtwQy9CMmNF?=
 =?utf-8?B?aktJS3FpWWNEckErNHJsMysyZFd3MkFCbUVRTm96SS9tTlhHTE12TzV4OFMw?=
 =?utf-8?B?eC9OVmJBRmxuK2F0RlVIV2pYWXRPYUJEYkYvWURXRFJaRE9BUVg2YmdnNm5i?=
 =?utf-8?B?RzNLalA1RFFpZWY3M0tjYlpUUG9ON0dCUXIyQmJURmlXZ1ArUHViUFQ3YUJy?=
 =?utf-8?B?b0lqaDdrSmtvMGFhTUdCL20wSkltWVozWk1zc1NnOHhoQTRQOG05NDAyN3VF?=
 =?utf-8?B?M2NJRENUSFlCMzJCOGlFbk9Tbkp4dG91bVZwMnBsRVgxd1E0eE1xR0swUDBJ?=
 =?utf-8?B?alVvM3N4SHVtS2czeW5MSXR1OURSRUVvL2wxeEh5QkRxZHBLZkUzS1Y3andt?=
 =?utf-8?B?VXA0LzdpdXJPL0F4dTFZVmhiVWVsaDFwQ2FuMlBYUHdvaTl5ZUdsWFZFcERT?=
 =?utf-8?B?RTM1Znh4ejdXdDNJeUZFeUNEY0xkOUViUi9yQzFoOGNNZERDeXBUZEFlUDJY?=
 =?utf-8?B?NGpyZUFXTlNZODlHanhZeWFFVUZBNDNvclBtbUorQlQ4bi9VTzdyenlCNXZE?=
 =?utf-8?B?OEtDL0xtWU1JcHJ6ajVnb21ZZWNOb1U3dW1LTGc1SUJOM3VrbHZMN0Jaenpq?=
 =?utf-8?B?U0pDbWhWWVZ6aUhTWThJWHVkZVVLcDVuL1JLUGNtOHQ1RllWbDJXcTA5aEJC?=
 =?utf-8?B?UXh3QjBwVHZsUGlzU0JOaDh1SDlSdk1nelNvUDh6ZWdXcDIrQWVWMitQbThH?=
 =?utf-8?B?YWJYdWZFZ2RXaE03SE00YVdDNUd3dm91YWdTZEJOaW1qeVJxcnZaOVFpUnBP?=
 =?utf-8?B?MzZ0YitzU1FwL21CdjJVUnBtT1NmMWlvTVFXdW4rc1B3L0wrUTZQSzVLbHRH?=
 =?utf-8?B?Tm1XNDVmY0xOeloyc1ZkZzQ5ZWVUc3JmNG5UOCtyMmh2TUk3QVJmcFhzNWl3?=
 =?utf-8?B?VTdDMHR2NDBkd3Uxbll3TkE0VC9ZanZhSzVObXlPVFlNb2wzVmgzOTRIS21H?=
 =?utf-8?B?Nk85ZkYxQXlURkVseGd4dWVxWkhPREd6T1lFTFpXUUdUOEFUSHhoWEdGN3JK?=
 =?utf-8?B?N2RINVphTmx3SHdVRmlEY1hCNlNkSUUwa2daSnUvUEgvdllzK3BYYkhVSytY?=
 =?utf-8?B?TjF6MTZnd0orQ3FoQUloNkF4NkE1THh6Y2tpWlVQbksrQXNmSFMrM1M3Q3Fo?=
 =?utf-8?B?RFNrempZbDJQNnhLZXhNZGZVVTVjNGlDQjVhaFZINWFwdXhwQ1k5c1FPM3Zq?=
 =?utf-8?B?YW50VzVoVjlOSitBNDZ4bFBoMDE4T1RaMzZkUmcyMUtRb2tBNllrcjNSYUdj?=
 =?utf-8?B?RS96bnk4T3M1R3dxdnFVL0s1bXdObjFTaXBnVWdPMEdkQTIyWmlFd2dtTFNX?=
 =?utf-8?Q?RfQcQ4Ms20CmjQ4k2sj3ngiiuucaRb/CUpXDm7j?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755bf9f6-a5e7-4b5f-05f8-08dc2ec845dd
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 08:21:28.1590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6750

On 2/16/2024 3:20 PM, Krzysztof Kozlowski wrote:
> On 16/02/2024 00:48, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> These compatible strings are not found in any mainline dts, remove them.
> That's not a real reason. What about all other users?
The people who want their devices being supported should post a working 
dts first. Having found the dts missing is strongly telling me that this 
SoC(Hi3516) is orphan and EOL already. I can't even find it in git 
commit logs. I'll argue that the old binding is simply wrong, and does 
not describe the hardware properly. Who knows? Could anyone tell me if 
the driver is still working for Hi3516 or not? I'm very willing to keep 
the backward compatibility if someone can tell me the effort i paid to 
maintain the old binding really makes sense. But the only things i found 
in mainline kernel about Hi3516 is an CRG(clock) driver and this femac 
driver. And it's been 8 years since last update for this SoC.
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


