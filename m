Return-Path: <linux-kernel+bounces-44665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2518425AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9D31C285D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC5B6A33B;
	Tue, 30 Jan 2024 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dmRaXYSY"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5504A6A32A;
	Tue, 30 Jan 2024 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619695; cv=fail; b=M0NEWjx60x9xg9cUzFjDIuKBeipCW4p4NM4lg7kbgo8DGJGTpKcHBGVqzlKPibVUch+Si89ffYjgnY4h2/d7cI5zfDNB90cX4jZgvmIeOufwBXK998sagO+Lre9FYciAzf2m+nbRv+bYte9LJB95S1R6mxOP7Y6AcLhjmG8yF5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619695; c=relaxed/simple;
	bh=rk0v7YztU2XSvrbkMsfZSM6oc7hPx+2Ji/5+t/6RGRE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=om4nP5RFc48W5sTDjCCYgd68o0HgHAfGXFroeRQW5dHdU84ox4ujwhVhDxw6oqntyKe43Mpn1ZMFxTLTfV5piRfUMq2QtwdSs31IzovFhJDLBanqa5qRaNyM4kKNXouC8isemEIqpOf2Uw0DRstxgkVQih8ZyVQR01fb64CE4dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dmRaXYSY; arc=fail smtp.client-ip=40.107.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8vYVLtNX8LAtQ/f5ORO3Q6/ZJkaZLmWReIlOlJFpw3Qv7wmZJt9AKsz9A8PXhDzv+qa7FPlUO7e4e/ItFTt0UsLv0PsfVu5RXVVdaMBhnxbjNowMo1DtIDD8xE8Xdh9FqPINaf11WVEjgZHKT6DXHNbrN663d9XfNwO7YksGuA3ziHNWzSvEEJFgDD0SSQBY/I8iFGZX+07rYp5oUPeXqm0mX/4rmlT0q/3W71Q1MkMKlM73iSi3AUN6jWN5Gq1SwUoGmjR57sHjIGmrIK6YgafnbLLq0NRfNe/obz5QrhWhhX6Kksxgs6JchvyWsUHPnJ/mEljChw9jpTRSv8X6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEpxRW2YoLDVDMCKJRx1ARxzs8L5Ii3Sf+sS0WCM0Q4=;
 b=lSsqOc7ZFeKuHUFuHLuz+bVdkB7kds5fk3kNY44chrNp0aeHNAUta8V9lmx+j8OnPHVmwdM8+VpVSoaELKIPIn/MA3o99OzN/ULiqba37O6otD/2qfrfDUaZ2fAMADqi1iNAfL/ZxTDExwwp1ltKRTTRYHJi1sNf0Bg+xfS3ffgT/jaC2pzGHL1mmy8vdw/qWspxFzBmwKSKVm4elQVHIW3ilcdUS7FepSHRkYdmJ8JpH6LI0o4Fq4tZAX9ivfhsejy3Q9hGW8ShWq5ighuVafKIo5S28/03MhQCAx2+ilroEwHN2syk6+L5KeiF0lKL1FZMxmN1MHkr6qPsSabD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEpxRW2YoLDVDMCKJRx1ARxzs8L5Ii3Sf+sS0WCM0Q4=;
 b=dmRaXYSYSyJPne4bXAUFPlUqTzk9ZHxm7icdBMffmTGj2X5tZDIE4/EmN8cEoC00Ewu9D0g47TmWukpnfsgZjZ21WkLkflWdOjh89vzPxxB+3SuGhAvX83QNTp5EHGMN7Vp36CzanlwOIt/mnB/qmUrEZ/nbP2VGkBjl3YHl4h8biAB66PiWHZP+ostq12XX3kegtql48D1mn/hmCyXBnai/O+nOABjCsO0HzXuqHYxZYGBOg74qYsYzFOvPGKNeCcevPPnUp+u1pTTLzKEyMVfJ/RDPMg9hnkZMqvb2V9vVpkLEQcyCph/wd7t6VxYoHRsSIvrtBE2v19Wl1QLJPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 13:01:31 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 13:01:31 +0000
Message-ID: <23a727d7-aba4-4c90-8052-4523a8a21e79@nvidia.com>
Date: Tue, 30 Jan 2024 13:01:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/185] 6.1.76-rc1 review
Content-Language: en-US
To: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com,
 SW-Mobile-Linux-Upstreaming <SW-Mobile-Linux-Upstreaming@exchange.nvidia.com>
References: <20240129165958.589924174@linuxfoundation.org>
 <4a2b55da-ee57-4fca-bb7b-240792b25460@linaro.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <4a2b55da-ee57-4fca-bb7b-240792b25460@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0041.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::10) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SA3PR12MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 31547e22-cd61-4735-7923-08dc2193940a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aO1m9V8kXlAhxHOZWYPE3ndjXLwfz20KX4SYMPHsThQ9bpGyKcI/Tu/GA69l7nneVLcN3J2vIDd+xsLwBWEofhVHsat+cRYpFdEykll4YWMc43TB0ObLetFYI7WMAMee09gifAeQKCFZeygbRd24Lwjwlrq95l3GbjM/aQClSaVfasyXyiRBMyekzwud+jVxW7T6MvRsmOXVWHm6AEc0GKBZr6xUjZOECJD97WRS+kLM8yaTPe5hbusMdH2Mo/8mXIw/tMnJrHBrbj6Q6aoe29Oevp1+ljFO3XUD3QjqqOYJ3aSxN8bg8K7c7sOv3OF4q06cupwZuqHQEePjx8GdneH15Cn52lXmBUfyATTv0cH5uLoK0cVh3XBjeG02Vgw+CLEWksq442bB1N5lCFqfh42vEz0rOzUn1f9aMsac3rQQ0vHsZ6CcK9vqpujppHoFZ/dZllG6TDD2c0tNNN3vOgrC+M30Deea2szy2YnxVhaPiCIJa9aRtVJb5lmqkkCfJIc8N2NcmOTcUVLnSafbbE9sAlEQTCfzRpxF0XUlQNea+K9KQMTJ3A3F037b6aV1XCNuZqvB02Pcxs59YcGsNh2cOIVLVXCmCXtwiS9AU9VIlJNvg8tPsA6Sr8g8WiUX8S8rFeCvu0xbtH62X95j4ayu3z9eZreRY2hz30/USZW99EaTPS3NIUCWWpNPV4nk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(478600001)(966005)(6486002)(5660300002)(86362001)(31696002)(2906002)(66946007)(7416002)(66476007)(66556008)(316002)(110136005)(4326008)(41300700001)(8936002)(8676002)(38100700002)(36756003)(55236004)(53546011)(6506007)(31686004)(6512007)(66574015)(107886003)(2616005)(26005)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEFmRm5ocnRZbDZjaWtLczc5cTNlSms2RVluS21vdWdjZlVURnlvSytqOHdp?=
 =?utf-8?B?cWNFME9PNGJWY0gzM1ROY2pBWmFQc3BSS21OQkxPMmVWckRCQ3BXaUhXNml3?=
 =?utf-8?B?Sjh5MDhsN2YvMERMOE5CNTNubjBldGFoNVE1TXFvMWJvMFJuRGJBQnZmbGZD?=
 =?utf-8?B?eTNCZ0gzR2NrV0hPSE1DNkwraWhudjJ6dFdSS083ZlVUOWdhOWhxN2RGVGsw?=
 =?utf-8?B?Q2lVbGV5M1QxdDNjMGUxK0RpMzhOcWM5L3FNaDJyN0NmS2ZJVitkZHY5T2Iv?=
 =?utf-8?B?MXJFYTRUU3JmMENHc2xhdWRJMzBDZ0k3Q2w1RG5LVjk4cElPRGdxekgrU0JR?=
 =?utf-8?B?UjI2b3JGVDBOTU5WaWx0WEFjNUFMZ3pLT3kwSjFhSFdJVTQrT0dQc3F3dGJj?=
 =?utf-8?B?aXVKeVdmVzJNTmdnQVhGMDVVOU1BMXJzQWNkNHB0UzRvUnJLMWdyS1lHZHhD?=
 =?utf-8?B?MnY3b0U4dXdETjlnSmZWbmk1WlVTRmZEWFRQTVJ6YXdRbS95TjZNdWR0YWRI?=
 =?utf-8?B?TVJGVDd6YjMrSFdlMy85cnBRQXhnQTdNWmpWVEJiTE5yNEErNkxETVJ1cm8z?=
 =?utf-8?B?QWdKWkdpcjFocEVwZnpSUXZsTnZHU0MwSDFnU2dFQmpwbEY5WU9KNUdTUUpW?=
 =?utf-8?B?bFN3ZXROUDd4Yi9VR1JjYXdsd3B3OWhSRnRlWnVQb1E5cTNEc1pINmZHeThT?=
 =?utf-8?B?Qk5wZWc5OHNYdVFEM1VCL3VwWHFBSkFqWnZZSWUydEprMytRSEppWHlxU1k3?=
 =?utf-8?B?dFRwZk0ycndVamJyaEdJNGFNeXpHeFhSNjFJSWYxVnlMTWZrRGRoYWd1RVpa?=
 =?utf-8?B?TmhJbkU1bWxOSWdMQXJ2SWxXQUZxcjNIaE1BWVNGT3ZqbWZqUEJYNW03a3RG?=
 =?utf-8?B?aDVvb0pHdmVvUmREa0l5SjdpdGpSU3ZER0VZM2RZb0lkcnBvOUVNbVN0Y2wr?=
 =?utf-8?B?RHFEcVBjYjVsc0g5RE1BSituQmxBQWc0bnVTR3ZLMnVoelhMekJsZTU0blNN?=
 =?utf-8?B?b0hJY3FKZmdvemgzWTljMHpBK1N5b0QxTy9QU3AyekIzZm5lSmxCRWlYYnRT?=
 =?utf-8?B?QXJKVnFtUUNJRFU2WTI2T0NFaTh5Y1NmWWRlVHFvaWZaR08yZVd0OXFKcGkr?=
 =?utf-8?B?UEtYUXdxbmdjcVdoazFkQlhnYjdvdHNtSUFOOVBmU08xVWFpN29vRzArT0Ri?=
 =?utf-8?B?Ky9QTVZKN3h5UDBJSE1SOXR0NVJOYmI4Uy92aXcrdElVOTE0YThTa2hFbWdL?=
 =?utf-8?B?RWpXRXU1MGxIOXo3S25zSWNuS2RpcUNQR0tRN3V2aCt2NWpQZytQU0lkYW1M?=
 =?utf-8?B?RVdDOHBWclFabjB1UXBiYy9leHJpQWJGMXFPNG4vbGZGSlQ0SWZGNlBFR21l?=
 =?utf-8?B?dlB0VUgwUE5jVklpZEFwNEFja21DcGRPbUFBYm5ZakF1ZktFQWV5NGlZZzNW?=
 =?utf-8?B?MDFoRXVFWlJ1UGNadGtyS3ZQZEJ4RGZHWmt6VDg3U2pnZ21OVHhVZm1Ld01F?=
 =?utf-8?B?MFNIcHZnRzZqZi8wWlhMNUJiN1hjOTlvSE00bm92ZmpNdnhhbTdhL3A3cEtz?=
 =?utf-8?B?RGd5ZmlkU2d1TWV3ZncyU0wxZWFqdFc5eW5TNUswSzhFMXlVMm9YaXdSQUtP?=
 =?utf-8?B?VFM1NVgzUXhTbjRGSWt2NTg5eE1iNzAxVUI3NHovLysvUHVzY1NPSGdFNWFx?=
 =?utf-8?B?ZTJHTW5CQndGZDNMclc2T1JSMWFVUWlkUElQZEdrRmlHSDdTQnpZMWo0OHNr?=
 =?utf-8?B?VzBGWi96OHYxbjNWdGt1UWJteXA4Zzc5b2F5M3Y0UzBadVZCVzBwRzdXME0r?=
 =?utf-8?B?VWRqWXBRY1dFbUxpVys4MU42MExYYU43WFlSNFFXTmhSUXZFVnp0bXY2VFkr?=
 =?utf-8?B?MHVIcno2WGU1VVVUTmpHbWxZWGtOc3I5Z1BIaEJCOFZ2QUtEbStyQkVHUVl5?=
 =?utf-8?B?TDU0TFFkYmhBVTRIZk9lUkQ4SzNwMW9LQXRiWlhZQmdEWlUvaHVVZ0N5ZjVX?=
 =?utf-8?B?eEc4WkdtVTUzazFqNkZEWWd1U3B0YitBZk1zbmdUTXVaK0svMFNvS3JwMWlo?=
 =?utf-8?B?T0ZWTEFVcGFOYXVCZzByQmE0aExGZTF3RW9BdGUyTFhOTmI3WHdGVE42alhT?=
 =?utf-8?B?R0lka01rQWhDQU8vWlgwc1FSc0JYbmJ5OERRZEFIbU9TNEVkRm02RjJNbHF4?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31547e22-cd61-4735-7923-08dc2193940a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 13:01:31.0035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BStPM7FqlUlylAKxgSDGmDQeGZowu+FEXa8xhmvtGNO5aMIr2tLO5Zjof2B/wkRkPVW9Gp0UquEaGB4YJdBgaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129


On 30/01/2024 01:31, Daniel Díaz wrote:
> Hello!
> 
> On 29/01/24 11:03 a. m., Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 6.1.76 release.
>> There are 185 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.76-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> We see build regressions on Arm64, as reported by Naresh earlier, and 
> System/390:
> 
> -----8<-----
>    /builds/linux/drivers/net/ethernet/mellanox/mlx5/core/en/params.c: In 
> function 'mlx5e_build_sq_param':
>    
> /builds/linux/drivers/net/ethernet/mellanox/mlx5/core/en/params.c:994:53: error: 'MLX5_IPSEC_CAP_CRYPTO' undeclared (first use in this function)
>      994 |                     (mlx5_ipsec_device_caps(mdev) & 
> MLX5_IPSEC_CAP_CRYPTO);
>          |                                                     
> ^~~~~~~~~~~~~~~~~~~~~
>    
> /builds/linux/drivers/net/ethernet/mellanox/mlx5/core/en/params.c:994:53: note: each undeclared identifier is reported only once for each function it appears in
>    make[7]: *** [/builds/linux/scripts/Makefile.build:250: 
> drivers/net/ethernet/mellanox/mlx5/core/en/params.o] Error 1
> ----->8-----
> 
> Bisection points to:
> 
>    commit 1288b23c9c528796ab656d2796705f52c5ffad8a
>    Author: Leon Romanovsky <leonro@nvidia.com>
>    Date:   Tue Dec 12 13:52:55 2023 +0200
> 
>        net/mlx5e: Allow software parsing when IPsec crypto is enabled
>        [ Upstream commit 20f5468a7988dedd94a57ba8acd65ebda6a59723 ]
> 
> 
> Reverting that commit made the build pass again.
> 
> Reproducers:
> 
>    tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13 
> --kconfig defconfig
>    tuxmake --runtime podman --target-arch s390  --toolchain gcc-13 
> --kconfig defconfig
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

FWIW, I am observing the same build issue.

Jon

-- 
nvpublic

