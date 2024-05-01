Return-Path: <linux-kernel+bounces-165333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E19E8B8B62
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B211F21468
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9513912EBE1;
	Wed,  1 May 2024 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="etdGhovP"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD551C49;
	Wed,  1 May 2024 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570798; cv=fail; b=t243qnJgwKMhPGxjdwbtl+ZC24TIj6iXJOGky9RzrbV1j3MKC0BrYRvUl70AstMSxXO3DJDsuv/qaq8y5QARvDg9UScdFNmXnsayjZuPgJjRW3gwH4hMF3wBueOKMPGSLKfllsG7UtgeidM+aYOSaqbLkWLrMC8PkuW1MVJyt28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570798; c=relaxed/simple;
	bh=cvUwfHNtXgJ+bdLpLpnvMuJVvCPWgzCDtgPWOkX/jac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u8EG5OOd0cONDbC0tOdheLpq54Z0yPDyNWrZGWHSY5KOr6L4CCDet52JOuaW4NZbd/w1Pw4RD7HgJ7gpdJ/aWpvjVTPAtU1hSDrESJpPY6GeHR1GBcv3wVZRZJjVm3crxF3lR5AvEkUTfo8YTpXhqGITwLbQW7F/GTKATA/6yzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=etdGhovP; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdtloNd8sXY6CGxbdNcfoZzuUhm9xZPS/Mfizpk1TRhI49yYOODijy7/09U+i9Q1CRJovY7qus4heDUIUmxNDV8HVzJcCCIN5KNOjC/PpZXuiNV8gxbFXlLR922x1+HI5DqxHc+TM4D2FvevXR0+FO7oob4jCeYpKq980+yzP+NFILA1LeBLFdtrfZwn4PaKFkDNjsZjINw4YPGn6xdBF4w7haiDyTgN+3JXZQ6rK9+BGV0mUVrTFxrCkopEX+JhF+3AtMymlGlEZVwp1RJQoNEXSrNrZnFrKFhk0bnC4rrMmm3WYjm/VAA4qCSSFq0JSYwfEURq6xI/CQlVP9jzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WGaOeAUBHTerUUQuQrI0c+rCKP/KLlXGvE4U6FbrIM=;
 b=EUISyoGEEFn1Qk+DkwtAJTd+bkR8yjRm7tthCWr5dWSC+ePE4RlGIgv2leLoxnDJVY1oqidoLcSc/EDgoi6pODu0dFr80KgHd/2SwXt0O5S2eWeTA9HoomkbOsV61O6+kJYf0O66xgRTalHjVGUc4n2Oarh9+1TXVEZ05FdBhHZ8Z9L1zMRK9iJ1eOSxfihDP5Ps4fpBT7xWE5RNW3l+aXZvThbo+Jy/qtJ+Yl+JTLj3d7XXt9H9BV+X8prUj6ZwPYdfCyKkrXPB0eY/x8ZThAuUVBHe3b1F4CHLUKSwU28tayYnm4cVPKlH6QTC3ltUyPWV4lmotdYvIQjcftbDoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WGaOeAUBHTerUUQuQrI0c+rCKP/KLlXGvE4U6FbrIM=;
 b=etdGhovPlV5r/HnQUcv1WwLEaDMLOFFvNfAM4JPOcfbDXEJROK5lMHJZetpBN/QFJH8zEVNXFf+fYEzfLD8EAbKToZs7pTFOgRgeNx2lQ47QwOWCM8BcanBfEsxcnsigu5Bp1iLNATKVZLsdLaYKb+MBoLKRyNue9tvc9mSniEuoCKGCEHlS7F4bM+DPa+/acMLs7ZtwpzWXeiglaOeCnyEP3mfNIJRd6tNR8KBAzJ0YBmi22hnGMjJsJJ1CAS9PMcfvdONdp1wkQmDXe9FYiTQbDQaSa7p/JIpGAATn5VWIcLu/z8zZhczuiPwiOpR1pYput5PIYsB5nUmkzLgNAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.36; Wed, 1 May 2024 13:39:51 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%5]) with mapi id 15.20.7519.035; Wed, 1 May 2024
 13:39:50 +0000
Message-ID: <6a40e90d-79c8-404b-9aee-894327a1f95b@nvidia.com>
Date: Wed, 1 May 2024 14:39:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/228] 6.8.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240430103103.806426847@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0124.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::21) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: fdffd183-573f-4217-4c18-08dc69e42cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTRURm9CQ3RiSmpUTE51blFna3FOMHBkSm1COXFBY1gzdFNVa0lNTklSOGc1?=
 =?utf-8?B?UDAvdndiaXhZbGhqWGVSNG9DVEFrdWpYUjVtNzJxMDgxM1FEN0p6R1F3Ylk2?=
 =?utf-8?B?eVFyUnNWSkFaRWdJV1g2NWwyQnQ1RXREdTBBdFVML3NQSEtLazdwQlArQ2VS?=
 =?utf-8?B?bEtvazZJK2N0b09kNmYvK2xlcnZ3bGFpd1g5eWQ4WitPQXdmNVNwOGQ5YjI1?=
 =?utf-8?B?UkYrN3pBL1RVOWZuOStScUs3N3VMYk1pK3NvL0IrMXgxdWQ1NXpZc3A2bndP?=
 =?utf-8?B?OXA5dUJYUnM3U1puOVZ1a1dWL0U5dXc1Qkt6TDI5QUVmeDIyZlFuTUNTc1NK?=
 =?utf-8?B?NWNTNyt4dVFEdmUybzlYNk9kd3J6ekhCdjhIWVZEemszZnplMXJ2azJoejNS?=
 =?utf-8?B?ekh2cFZyNTdJcHp6YVlTVXhIY3dPM0NRWGJmeVkwbEpQOFkwU0daYklHd0VW?=
 =?utf-8?B?ekVkdzVtK1VaTEQ1dUUyYlBiOWRJUE8xK2JmYnVnSWlYTUVDcmhDWnZlYk5E?=
 =?utf-8?B?aThpN3FxNDBUVGJMRHdPWmlvRW1YUGRFd2wzTklib2FwOHphWEQ0bXZwYm9V?=
 =?utf-8?B?MFJ2bmZyUVhZMXpLMkJRMFhrTWFPZjY1UnZFNTBKOThSK0FEZ2xuQUlZd1Ni?=
 =?utf-8?B?N29BbG1NUFU4c0NIcUFHQXVqWWM3eW1wbFJXZU5nclJ2RURQOHJEQ3JDbVF1?=
 =?utf-8?B?WGcvclNzTmdlZGNNcUs2K25zZHdDR0JpNytCaUdCRVNIcVNaZjdUUDFCa1NF?=
 =?utf-8?B?a1NlUkQrSEdhV2dDa0V4d3F3aDlONy9URDNOc2d3QmFXSmFnMmJaK3ZCQ3JG?=
 =?utf-8?B?c3pybmROT0pLeUZWdlVPKzhoUmorK0FjM012T0xyY2k0WGZiakowaUVTZmpG?=
 =?utf-8?B?Z1lqejhWU01DSEJrQmk0NU1QSVpPS0tZK0lvUVRId2lwMTdSYlN6VHVrYnl4?=
 =?utf-8?B?ZnZuZCtka2RkQ2gyb0FmUnc4NHVXN1B2N0ZZN3l5Z2Q0S215WFdLK0ZCc1VK?=
 =?utf-8?B?MVRQMGt2VkFydXBLeTQrYXJuZDhPVWZCdUlJcEhmVVdLdFZlMS9DNHVKTXVE?=
 =?utf-8?B?RmhVK3pJWjY5TUhxczRtbVNtSGtNcDlGUnJpV0s0c0VtbmQxZHI5cTZZdlZ4?=
 =?utf-8?B?N2VMRWFBMzdxdDkrZmJqMndBa3RVSFFJTmF2QWd5Ym9sOVRIRThJWEsxQnFn?=
 =?utf-8?B?UDJEd0kvVWtqdHVJczBaMGFLclpSUmpwRW15dEg1YnQ5YlhkN0YyQ3hyNVR4?=
 =?utf-8?B?bHRpWXVDV1VBYitGM2RVd1B2cERnOE5IR3I3L2J4THIxOUxMVjJlZ1NMUU5m?=
 =?utf-8?B?NzJBYWQ5U1MvcGlaT29iTHN4Nm91ODBmSXFNNlZzTUJ3aVlWVnBDbHZ3cE13?=
 =?utf-8?B?STlYazBFSHlVVytsVEhOdE81cGk5Nk1MS2Vnd0dISmNOMVBBMlRWUlM2Vy85?=
 =?utf-8?B?d0VEZFI1K3R0T0d3NWpzRWIwQUk4c1dFdnRzc2V4aEU3dmowcmJJZTVLYnhZ?=
 =?utf-8?B?UTl5dDQ0b3ZzUnZkMHNxVXlzOWVvVTJiaGpiSlpZajRBYmtTSDZIcVZBVnJI?=
 =?utf-8?B?TU9LZzFQcTl2UnBESXNRVGJ6eTNtSGd0bCtsN2czeVdVMWVlQURFRm1sQ0x5?=
 =?utf-8?B?N0ljWWhhT3VWZXZKSHZRSEFOS2Q3WHBOZ0k2cGVuSGtBNjcrbTR6QmhlL3Iw?=
 =?utf-8?B?bWdaSmYzU0VQR3pYZkpIOWdpNWkvV3ptSkt2dTFhckUxUERpcldmdHdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2ZwUk52dTJ4RmR2QW1sNm5EdHhtVzR6U1ZBUmdOek1WVm1YSUFWVEFyeVha?=
 =?utf-8?B?ZUJNU2tnWCtsY3ZWaFVJd2hBVzhFNHRGSGJBVDBBc1VpbndHdkltZVUzM08y?=
 =?utf-8?B?cFFFdnlJUUVIZ00xUDMxWXhnMGRmR2pia1lvbnVhZit6TG9ia0dZaCtDQXlU?=
 =?utf-8?B?S0RKdjE1bkIvNXR2NGQzbG9FUTg2SFcrOWZFTW5yZEFzOEdEdzYwOUVrSFJx?=
 =?utf-8?B?MHhHQUFkUHlwMUtNMnllUENoQTNUYWNSdjNlQmFZV0FCUHFTc2FSQmVBNkU2?=
 =?utf-8?B?c3llRERBa2J4T2xycHVqU3IyeEdsV1NFSm1xengyTkhrYis1K2FkbWllanlz?=
 =?utf-8?B?bkpVWVJJMG1wUC9nSVNKN3R3TUxHQ2JxZEcxMjZNL3V0QjJKdjVQZXdqK0Yx?=
 =?utf-8?B?MkJ2MkZFWjZSc092aHE0QzJ2RzNaNUlwRjlXcEVYTldveUdLZTg0ZnVRcks1?=
 =?utf-8?B?aHBoaUJvT2tHMHdXTWVBVTVYNEhoL2dYOWs5b0x0RGZCQ2RKMzluQktpb0sv?=
 =?utf-8?B?S1IvYVJoV0s5N0ZEYkoxMzZCQXJ1YWtwemlhV2JiLzkzTWVCU2k4ZmQxUTdV?=
 =?utf-8?B?OHZXU2orNFRIQkJEVm5OanlsQkkyU1dIckpqZ1o4anQ2S3NjOEVCMjExMENJ?=
 =?utf-8?B?RzhXa1Z6bEVlMW5uU3cyYzk3S085VTJmazNDWFhlUzFyajFsUGRxWk5idTBj?=
 =?utf-8?B?TldrRStjUWFNSTlOdWR2L2dpWlUzNk5yZXlkbHR4S3FPU3huZXowWTIvNUZH?=
 =?utf-8?B?L2p1R1dRQzdVcWFDN0YwU1QxODJkTG52RkppMHdIdzdyZkR5bzg3S3BPY3J0?=
 =?utf-8?B?T3lLS0VITVNhNTA1MklaSkQzY2VqRUozWkZ3a3NGYm01b0xYOVMyMHVPcTB2?=
 =?utf-8?B?SlAxZ2tSRStIdktNN3NBVGRPRzNhRHFta2xPeXV6c3cvM29LeVlFSzF2NjBU?=
 =?utf-8?B?RHJ2WU5KVXhLQTZQM0s5SlBCUUpmVzU4M1hXNzhrZVUxZm43MVp2TCtvL1pP?=
 =?utf-8?B?R2hyK1FlNWNMRkZrSkxxL0NnOXBvc2JQODA5d2lVTUJCY1ZRWkZTeWxucGxV?=
 =?utf-8?B?THJCNys1cmpuWTU1WVJPby9YWnNhRkxTOTZNczRKaTRTQWwvNko4L0RuZ2dv?=
 =?utf-8?B?VzlLMkVyVm9EOFE1Nm5NQzVsVnlNdXh0b0F0U044eFpSa0tMSFVlZlAwb1lF?=
 =?utf-8?B?UTZXTDVRK3pTaVZqYlA2RStTeC9zSklaak1EZFNiamhjYWRYYnliZXJIajBl?=
 =?utf-8?B?aHkvOGY3aXkvTG5DRGtsNzE4c3RmcEFRZDRSMGgrTUVMc09yV0JxTWxGdVA2?=
 =?utf-8?B?WmNaREhEMkdWU3RPbUZiVFFYTVhLNTYzQlBaQUdxMWxHeXQxTVdKT2hST0Z2?=
 =?utf-8?B?aHNkN2xUSVpFSEROeDNyRWpCZElpdG5UZU1WMkcrcEgvUFlHdjZTQVYybVlB?=
 =?utf-8?B?djRGRFdLVjVaNWtqejYrWXBsZzNGUE5keHE0NEd3RnFRSURHZnpXY1pvb3J4?=
 =?utf-8?B?UTkwWDQ4RXNWNC9ERy9QeTJOSEtRSHFUeGVUV3QvNGVobEhqdEl4S0lQd1Zm?=
 =?utf-8?B?RU03eitmL3MyZHBXYjhZUnIwNUZ4K1BobTRJeW1FUXdHYVp5d0hpeGpXbC9V?=
 =?utf-8?B?SFdOUElpWDBnOVlQa1ZDUURpRmRXbnRBeTc4ZHN3OGtTOGdRbnZDb0pOd2Rs?=
 =?utf-8?B?eEdFT0RNaE1XVWxIQkhhRzk0bExockJ0Rmlkdk4xK2ZLYjg0Z0t6Mk5VbFNY?=
 =?utf-8?B?WDh2dmdRdTVURTV6c2hqWnlIOUp6Z3JnclNnUnNHMnBqV1BjaXd1cnJSQjh0?=
 =?utf-8?B?eEVEaU9kdzk2dlU5cG9nbVdVdjdBTFpTY1JPWVBDdk82MXVZWG9rWFJnN1lX?=
 =?utf-8?B?cUk3UEtRWFBLK05WYk16SFJuK21PTEVrc0VsL3ZKQUEyRUtiYmRYYXJWQmcr?=
 =?utf-8?B?bm82VVJLWmJuMU44WjRURy9SellYN1Z6cXVjZnZGOG94SUlMaS9PVDVacVUv?=
 =?utf-8?B?dnZRR0szTU8xeEI1WDZrNlpiczFscFd3RHM3ejk3VmNSL25EQVFFbWNHTkhv?=
 =?utf-8?B?N2VlenhwQm8ya25NVjBJa05Jam1wNmp6cmJmckxHRVlmc1l2SFFBbUZNZExB?=
 =?utf-8?B?aE9pd0w1UkwzcXdjU2pMbnpIRkkvclRXR2lqVDlTTmR2R2g2MUlMOXZiQVpy?=
 =?utf-8?Q?/uheyC/eUdJgB3mbYGT7CTgCH9qYaHpTI4DoNn0efbsT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdffd183-573f-4217-4c18-08dc69e42cb5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 13:39:50.5590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbP7xvEdvYoYdafUKbt0Lp4XoKqDuHdBV8OhhxURENvmGCe3pCZGQEGkqDqNgwDgKS5zJxcoxLVbO/peB7A7RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610


On 30/04/2024 11:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.9 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


No new regressions for Tegra ...

Test results for stable-v6.8:
     10 builds:	10 pass, 0 fail
     26 boots:	26 pass, 0 fail
     116 tests:	115 pass, 1 fail

Linux version:	6.8.9-rc1-gf9518a4bb35a
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra194-p2972-0000: boot.py

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

