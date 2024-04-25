Return-Path: <linux-kernel+bounces-158231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEEE8B1D48
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB55D1F24164
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F8D84D3C;
	Thu, 25 Apr 2024 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rL6szw3G"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5E9224CC;
	Thu, 25 Apr 2024 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035748; cv=fail; b=iu3rHppFebYD+cbw6kDTEeY73BylAMf3c1SrnHBVf3/IFUlklaE9NAV5/97nJbfw2toLsBUu7r3a4s2KDiJfbyQpVOeh5NxN4wjQNm6xczqIC4nbPDJVwgjttBkYCaWRn91afJWjw/M+AhUS538XIFIWdm1bEhK0PV1z43RaalE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035748; c=relaxed/simple;
	bh=AUMXH1+9iSQ/eDDQtg5amuei+bfyNLdphrOsWJ/y204=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ym8m8PjCV5UJzHDmUNLVgZ/A98nGgFA3O1ciLTADUWqFPWRK3DMrgnlIfEiA5PtMz110b+BidBcLkzrFUjcCruNV9B3WqtoMbSzw2p36j2T1j47LC4kCqcKn4mzwKfSMe7hVPWmoJIRvd0b+SPgPsUvdBcPs/1IxBdTkuGoYLZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rL6szw3G; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nl6vg5KV0HuL6v43V7RVWNRUXs67A/hfUdUQY/cYONs4zWWzVqTjrlybnzM1ZwRjP3t7nIBIJlct8C/UkK+bjtolul2qUS3Q/biCFncEbU5/NGROiXf0Z8fS36Z/32kAGRlrI8Vqn8fwB617rmjioJrmv7ESQQicHcrtT5k75G6fB3Hh3Iy1vKBUoaZ646NXWTku/IWAmxY+ocQAEmxNZl5mvEzVVxfa/WKoRNCjjXCXc5dG8p50/aNUNeVkwsWG27CiouMPnl+gZxT8/G6FUjYQeGN5uI6pUU2PoQCD5IuXBGAZWB1j3P+r0Y8rfeG3JBxcHwLSAHD+wa6fJO4oxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tmKq6jRJkEJTDa2RNqXStqRPMSZQFW4YmQWnyo7d4E=;
 b=BlmOi1aL9h9LajN52SmvVWHd/TAcj3waxeS+wggUksm995dY0COYq+7ol2s7bTRYQuVQpyI/0TSEwYJOcTEUaK92CBu68pVg6Un2ghPWKfjxLOZ6VZkC2ZFFgNHp7FQ0QruL43iVcI/eBton6oMRbiwwh5Bz+yTH34J/+EydoMSuTdrhf3IPPsSPleDG8jLL0W/CYqvI6qwZ8d4ChILCvqLXs12T78F5AbcrvIkuoQQVOTqqnVVZcrTx8mpEf9kUw9R61MwoWoHbLuhlW1TL/N4oOiMk+mjkILcNOfNWnjzeO49+71WD6El33GR4VH3tmGA2hkJbBHQ15+w5kwSdSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tmKq6jRJkEJTDa2RNqXStqRPMSZQFW4YmQWnyo7d4E=;
 b=rL6szw3GNT7o8Xc2EoZ6g01emIoEBHBhPurCwcwTVUrZNdL9tlxgcc/euX1RHsozhwTs0mh8dC8uZ9MQjdBLjv5vvHEk2BsVimLJXJhpOv1L3gl1rDX5/L+gRQH8rkwGytAyNMFirRxwLRe71PXWUMHpeQ/J1jpasIJPirtYa2rLHU8J5hR1qI/GhW0/9qXAgB8dlgDf0MGJH6kvheXctGv2geOfoUSnQLWzSv/tjB2K4ALkwPAoMkz8xwG+LVpFekzpA5bybMP5ih7o6fyx2ZVM3PdQjqK9WPbPRPCeL7eOW5mdUNRGKH35T5VRfMC1P01KP6wP/xiBe21f3DNdiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Thu, 25 Apr 2024 09:02:23 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%5]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 09:02:23 +0000
Message-ID: <1223b6f7-dc7d-47b1-b655-594c9057a0a1@nvidia.com>
Date: Thu, 25 Apr 2024 10:02:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/141] 6.1.88-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240423213853.356988651@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::18) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: 863879c2-948f-4f90-0b66-08dc65066be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFpKczNtTmtVa1RHNGVPWG5jQkM0enBzcVBYdUs5U2kxZkRsNUlxZnBOODFl?=
 =?utf-8?B?cTNwcm5IWGZ0L0lic3hwWlFUTW9OOXYyUXVRZjltOTcxbWlCM3BaVXFpbDNt?=
 =?utf-8?B?MytHV1hhdm5vZVFid0RKOTNrMU1JZjhlWDkyTUxyR0YwRWoxUVlRenYwQzNy?=
 =?utf-8?B?S0dNL1F6TjdON1pwNUgxQ2NVZ1JvYW1yR2o2MDBuQlpPZE8vK1ZJdzRSSVZj?=
 =?utf-8?B?RWEvaUFzQkIyUTNVTUQ1NzUrSThoYWpTdHBVekZkbE5HVzZlc0lCY1UrYm1S?=
 =?utf-8?B?LzFmMCtVeUdjeVNHbXcwQ0xlL2VtZDdCTVlGTCtiZkJ1Zkg1ZlpacVFlQ2J0?=
 =?utf-8?B?MnFPN01yOEpiM2pIQW5HaWkxNUZHcHgvdTI5VkluYk9XSThNdisrMmlOQlAr?=
 =?utf-8?B?b0tHMlVnbHIrWjR4eVkvYVdUd21iL2h2TFlmVHd6T2EzRGJVWVcrV1llUlQz?=
 =?utf-8?B?TFNuOXFJUWh2QzBjbEJYRkcxb1FIeDNaNzg2RGQra0VTcWJ4ZXBnUXg2V3NU?=
 =?utf-8?B?WjMzSUp5TC91RTZnUWh4RHhRU0wrM3VuOUxQS2FSaWNmN0M5d251T1VWWG1n?=
 =?utf-8?B?UWMvemN2SktzNmh0TEFHTnE0TlkvbGgvanZKVUF1SFM1MHhoV2ErUGQ2bjdT?=
 =?utf-8?B?Q1RIb1lWdTcvMHBzMlA2WFJtL3B4VnZDTEEwZHhQTERyWUgzaElLWlpTVytl?=
 =?utf-8?B?bjFZbmtrMzNxWlk5K2sxU0VPN2J2YzlZUmRleE53Lzc5YXhQZzdMWDROQ0Na?=
 =?utf-8?B?d3psMHZlanNjTUVNU2VLQUZSZ0R6SVFCRlRtSUE4dGdzV3NLVVU0NE9sUUxD?=
 =?utf-8?B?Z1FKa2dEU1dHY1o0eFZQR2lFOUx2WUwxUjBFNE0xc1hVVjdmS3ZGZS8vU3Ru?=
 =?utf-8?B?ZnAyNTFaZnJ2OE5oWWtPRVk2QjRKcndmT0FidEloQzdvdXovYmxvakxzRTN3?=
 =?utf-8?B?TlpJMkhjeFdDT2h6WnRPcWhrQWt6RlFYZTllOFp1eU1qVFRLTmIwcUx0QjFT?=
 =?utf-8?B?TE9ZL21VckU3K2RLYWZTOFFIN2RPVFFOZlU2ank0VWtqNTNXcmJXSEFjMDBh?=
 =?utf-8?B?SzRkU1lDSndBbkkvbnUyNGYxa1hva3FOVVJhTUJOQUU4RE9tSkNsWnYybE5F?=
 =?utf-8?B?V1hTYWl4N2JZeXF6eDVoU2MwYWh1czl1aUpocVlDa2JTM2VvZEo5eEhFcWEv?=
 =?utf-8?B?NHVNMytZY0s1Uy8zRzhMaGJWcEpQV1hQV051NHFLN1lLU1JCYW53My9UVUhZ?=
 =?utf-8?B?bk5VaHpScHhoOUMyYjdmZ1RWQ3ZUdXBMTGxEZEphYW9wandQRWx6aTVnMXlt?=
 =?utf-8?B?VkJTZmsyUXp3dWx6SkZaNWo0OEJ6dnVuSGtXYVF2UFF3UEtoamdyZUx0UElS?=
 =?utf-8?B?cmE0N2dDTmdnSmlRQW9zdVRtQnV6V1h1bWNlWlZTZEZCdVlGZkJ4ajFmb2RE?=
 =?utf-8?B?M1IwdzF1MlQ2Z2Z4eExUcXRYcmR2WTZacThvbkFwVndldHl3aHRsSU9EaXRO?=
 =?utf-8?B?ZDJLeVNiL2RGemN0QnZKZ2JDSTR6Uld5Z1pQUUFHWG5QSlBkUzByN0RwV2Vu?=
 =?utf-8?B?U3haMitrSnB5S0xyaTVDenRUVXlSalRISXdXOFBxbmJuT1piRktZbVVjMzV3?=
 =?utf-8?B?Zzc5SmpyenBiSUMwT0pnTFRWeVYzb2VBV0xUNkZia0xudUtNb2ljSS9TZEQ4?=
 =?utf-8?B?OVh6dzdDbm9NTEFtS0c1K3dTV0RFVXhIcFlsdE9uQ0tlK1hvaDRJWGJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bllaVHZTMXRmbkI3OHZ5cXMwOVc3RHRpTDVuTm5SM20yaHl3QmFwdWpjbFh4?=
 =?utf-8?B?bkNFbUdtUlN5Mnl6d0NTUWhrS2VzUXJ2eVpWMnNJY0EyY3BQYUttaW1HQ2lr?=
 =?utf-8?B?T3k5MVRPTWNsSUMxdXRsSnR0MXZLNzk3MnVLckw3WTZVbGhpNmpYZlNVTzlK?=
 =?utf-8?B?T01pMjJOcnJqcXNSTjdkajhKRUlERzdQUURkaVBmcHVDZnp3Y3FuSndkaGpj?=
 =?utf-8?B?QmJYSTBodVBlT0dxU2xzMHUvaUVDRFRyUGs1eCtzYWtNMGJFUnRtY0JiRGNw?=
 =?utf-8?B?anREWUgrbnNwVk1tMlVhc09GeHU1NWZCMUJMSXlNSlBVckpPZU5IeEpiM08v?=
 =?utf-8?B?cHphVWxHaFVKcGNacW5wcCtmcXd2eE9qVG5hL2pGbGxKQ3E3Vmtod0tyeUs1?=
 =?utf-8?B?eGVPNHNOa0Y3aUk4ZXJkTVZWNGRqKzk4UFNveFE3dWpzMzluNzBDeExpZml0?=
 =?utf-8?B?ZjJDRERhSmhwdlpCOUc3VnAzeDM3U0pmOG5yWEx0cnZZY25LajFUOWhxWXJ0?=
 =?utf-8?B?S0V2eFZiVHNGckZrd1RoSUlXckNJbm5Cdm9NbXpRS0xiaGlQa0kwVmVPekls?=
 =?utf-8?B?QkRMNCszcGJtWGZ6RmFrcDRCSTRWSnI0bE9BNUx2cStZb0lua2dTMzh0aDJJ?=
 =?utf-8?B?S3pRWFVMUk9RcUhCb0Z6TFIyam81eXNtWFlIKzIvRHFEYmxUdVNxQ0ZZczFT?=
 =?utf-8?B?OUYycjh3K2x2YkJvSERmaC93NkhDdXc2aDNOTlhoVlJzMU5SNHI0VS9nZlVT?=
 =?utf-8?B?YzllazM4bk1aTFRyRnQvS3M5UktwTU0xSzJ0ZmhKYzltd0tIMFhaM0VjOTRY?=
 =?utf-8?B?YXdVbmE0M3hWREVGb0h0NDdIYm1JMlNwQlM1Q1NTa3hPNXVlMEpic2MyNzZO?=
 =?utf-8?B?bGdKQnF6UEZ1Mnk5bGV4TkpzTW1PM1R3Rm5oYzUzc0FEOGgydTVYWi9ydWUy?=
 =?utf-8?B?YkNPQ21sb1dsOUtoZEdBdkc3eWw1Q1VJR0R2OE9PakJyMVdPWWZDT2RhRjdT?=
 =?utf-8?B?VkNrVVBHUlhWbHFnNmNrUVBwUDA1K04yRFJCZEZmcEIyK1NZRlpXTTdzWm5C?=
 =?utf-8?B?RTNsa1FWeERCcmJ1dElOdmJ6VzlvL0hDMjhLeWhWUVA1ZHl2NGE1QlVnazlz?=
 =?utf-8?B?NExhZWpWUDA1bFN6azVuTklkQi94bStLYWJBdlNMR1FjL3g3cnhkV0dvblBl?=
 =?utf-8?B?TXhIRWRIY3JVVTUyalYzbGViZURKWFpaWEFWaDJOYXFiajkxQnF0TG10cUdO?=
 =?utf-8?B?SGhOY0tWOUNBaUFSc0FWVnp6V3dtNlFiOWJiU3lTYWdZc0dIRnFlZXcwVEJw?=
 =?utf-8?B?dWVEWkRtZ2xlVkhlQjNPcCtaZnpHaHRwVWswR3RUU3kwYjRPL3ZjUTJ0clJS?=
 =?utf-8?B?bnR6RHpMYVEraFpLL3d6ZVlqdGd6RzNwWFFySTJOVXowMDFRbDE4YWVSZXJF?=
 =?utf-8?B?OG1vWlVPakhndmRsU3NpdHBVYWlhallOUmZBU3hlQU1KUWUva0tMMG52dlNI?=
 =?utf-8?B?Z0R3MXRMMUVVZUw1Ull4VTExU3VSdHY2Tm1Lb0U1Q0w1c3YwdFFhUEVibW44?=
 =?utf-8?B?YzBXeUVBNzUvMUV3S2tycWdJendoSUUvUDlNazF3bHdnWUpxSUdSZXNRS3hK?=
 =?utf-8?B?VzVDRlNWczZmRWlHK094VnVmR05SS1cvVDEreVlVaUdaTTVMbTVhZW9MR3dS?=
 =?utf-8?B?amZLRFFZWkdtYmVGTTUwWk5hNVdpWExXRHo3bXY2VHliWDlHZmJDQVFzeG5U?=
 =?utf-8?B?dFZhQis3bWRVNkZNWGZ3VkdhTEJlYVpnWmIzMGlqL1JrbXh1MFVrMXJrUThY?=
 =?utf-8?B?Y1NtSWcyVzBybkxrL3FqWEdnS0ZRLzhja2lMcEZPOHlYNkpwS2IyZ0R4emJa?=
 =?utf-8?B?Q0tLTWtJNW1INXpvbmZwcFAyUm5aYUMvNXU5eVd3bThLRzU0b0xmMlQ1eUxW?=
 =?utf-8?B?RmZaN3NtTkMvT0l4U0ZsSS9NZi9XTGNqaUs0NnlRSFovKzBwdjMrbzIrSGQy?=
 =?utf-8?B?YkJtQWgvUTdYa3o2Z3hGaGJqV1ptV0w4NHJaZzM4eGpERGJTNkw2WEZub2tV?=
 =?utf-8?B?SDlqYkJKVjB3L0txUkdMU3FHU3FjTzJ0QURLenQ4Sk5EdCs5UDFaeXA4aGlI?=
 =?utf-8?Q?rJb26zLrfLfxRpKT4b2Lyn3Nt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863879c2-948f-4f90-0b66-08dc65066be6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 09:02:23.6803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13k1z05wlVey8tEC9tZ4jvvmB6T+6JZlnAlay47msw1wWMRatc9zlpWJUn4mjr9VvsyWY2Xg17iS6K2mAofpTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022

Hi Greg,

On 23/04/2024 22:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.88 release.
> There are 141 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.88-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


We are observing the same build errors that have already been reported 
with OMAP GPIO ...

Test results for stable-v6.1:
     10 builds:	4 pass, 6 fail
     10 boots:	10 pass, 0 fail
     38 tests:	38 pass, 0 fail

Linux version:	6.1.88-rc1-gcde450ef0f2f
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                 tegra210-p2371-2180, tegra210-p3450-0000,
                 tegra30-cardhu-a04

Builds failed:	aarch64+defconfig+jetson, arm+multi_v7

Jon

-- 
nvpublic

