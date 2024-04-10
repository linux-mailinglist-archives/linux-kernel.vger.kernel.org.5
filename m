Return-Path: <linux-kernel+bounces-139041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7173C89FDC4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E6128C4E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4C017BB10;
	Wed, 10 Apr 2024 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DTH6JILa"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2133.outbound.protection.outlook.com [40.107.236.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1E317A918;
	Wed, 10 Apr 2024 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768844; cv=fail; b=BAJk11uLM4/EC3m/8mpS6EljeTbdhJoKa+0ZwyP1tozf8J7KNQ7/OZfBK/7MklS/e9hzdkudOVW2Hikvlq7PDadvle6MFX0Mjc7dbrIq+dUArFArjA7SxcnVdPzuz4fDVati0xYTYkQAtFXOPUiZ6zsHSGD8RrRJoMRkwUm4hCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768844; c=relaxed/simple;
	bh=acHfxL+bhT04mC+Uerlu5JFnSPMh0h2SLutwrBCRfHE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QbO/jfjSH2fxUb7IlLiDuyYhdHHZ5Wf39+A1HtEDXGtFatOFQGz16fBWxdvhFj5uUmI4Shvo1tbnM4mIkzK4AB3NZfEgIC0DvdstNBJ08m5kgmZ9GwbyIw1gcNvz4zxHqhn1cRfEp3PQ2lSB4QrpwbF4rnbpDVTg8mX1CxZZqpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DTH6JILa; arc=fail smtp.client-ip=40.107.236.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvVIFXPvMilCpG/PSkr1PLs18bPwFCKGh3/4aO7df8OacSnRO9N5QIPxsel5lCKKGPYBnRD/gd49tSTCMV+Q71Qg/B7MB06Aw8N48GN0duIlIo9X3YZiDYgTOxhFBFpkT13fll0bu7W1kgle7AVVD6wJAxbMkcT9aXxbkmQN8NnVc0l3SJ/QtQEdJ4RkkbTjItKsheunBZ6Ejsq0nbHKSAAYy6DL3Ed9d+TJ4ErRDF00drN7nakpUkZIHv68AgLq9jeReW9JpC1wj9nhF2NuEkC2V96VGAu+OOiLlnuZTGGZuSBNC6w/RW8rbg5apRyztUjl8cA/8hagtDoIy0tENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKXU/ve8ypoCaJ6jfUB5cMAeMknAR09DwuYmSo+Bp9Q=;
 b=DobhzlFgOhwotTsYWaVUFIU+Zr+xeqrnQvKobUyRgyq1uGXJif5GdbO1Zt0ScBkC0YEb2STdoSZtlkXWUcr4/RD9FxD5sDJkR22wZtHVCWSDpMm+LCqhgzXzmb9EQN6wHIx5OIFH1jmkhCRlJVzQ7rxU29AoD7G5KMcN2Qx34rGK76iIuUM5GuUy2lQawMk1HPG7Zp5ncFcqsEuQ+FwivbettsCcsqzEbBfcsoAZ7DkK2yY/ItJpAovXDAKwydEpstvEkS+Fi/lSS0LMy2O19a3utDP29NjVUhk+BgWNFmxOgSDcUJrYkpbbUs54CCzecMLql0G8lFFOuOcyiagsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKXU/ve8ypoCaJ6jfUB5cMAeMknAR09DwuYmSo+Bp9Q=;
 b=DTH6JILaOeCrEr+JEl8T8XDAWr9qR6vvEcDYU2eHTlj9uItPcX9KUsojnFOKMDXiJpwiDygp2oUmCzc7ICDl26LLzU/suUxAWHXYjpXEUO2wt3IPk2WPyJwIWx2XVgUxf3etN5Pqhl3L4aWPBiQoixJsDHMofBqZa2wD+8sI/vWND2TTy63igfZ7MK+sVYVsvm0B5c0ujoc+C4T6Pno1nErCgbwoTplw7XSNEGc385Q1DE8jOT67m/IecGHrj59Ab2TvvsyeQkUzD6s+trbojF/JoRhj6jTf2yt88AAcDZYYRv0HDKgYYvphEeZwOeStys0naY3cCeKa7BohLgPcdQ==
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Wed, 10 Apr 2024 17:07:18 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%5]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 17:07:17 +0000
Message-ID: <545055c8-1b8f-4ead-982d-54f3e6d62be5@nvidia.com>
Date: Wed, 10 Apr 2024 18:07:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/280] 6.8.5-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240409173543.596615037@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240409173543.596615037@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0261.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::14) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY8PR12MB7243:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XvsXqyne62x2QfzGWJBCHH9sHssUjlny1iRXSy66sAnWaGzm/dI+1T0AaZXLIVr43IjLPE/NIys81StNovd+XiVrvz2eqsCzi5GyDsHLqGRodxsDyuvUhACRQN1mLmy4Kgirvm9UpW7BVTH6Ukjho97L7m56J52YeXLwzeVZvEr6E3s70hMC2TH+zKEyIDkdkjZ0hBS5ivXD+YhxFp5g+mZhPE5xOmHEWP+NSKaFkfZBzieYIZTgKr4mXrpranQOwnNQQ3RmH3VMiHD3MPbZInnDqx6nO+vfdRtd35P3mAd2gtCEdE0eQUDvjU6lxNyDSqq6aoEnVC9Xpt/Hvr+4GwjbgnkmfcX/UuJg2MAOdR+pckbbOwBxMNGLdtixOG7KZBJA90N2ukUrofBqsrvy2XSOa7wKjb7/nyabk0MbWt0uUMeBYvnx8pWSKAtViIaTud/WED4S668R0FZjjsy9O7i5bJ6QCBqTfnfZyr+3HKzVrB5R3J+PheBb8w7jXG7y7Fu7hB72+KaLsMv3WfwzvIHVosTZbp223wz+0vV1YK1GbzbMocjrIEd6f83No1xDq5mEbpcXMfwRd0f08k0BCLBSK37R9LzOHe3Cw+prjAomUQNXnhZPgna+eizjy2chVPs73GjeH2VQgx+BnZpr4atdyqdGh8wumCJYDiGd0Xg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alVBRitrc1JPU01NaDNwTDlYaGEvMGhEV2lmdHpWM0hER2ZyWlpmM3hNOU01?=
 =?utf-8?B?c09HczNRaWdNam1neEVJNG9BeXpBMGFqL1ZyMHkxblgxM01CVkQ2dWYzWDVs?=
 =?utf-8?B?OVVVdm54dW9kRlRTSElKZlI5RmtMNS9XRnpHNE5NMjZSMzRmMUk5WEFNZWhw?=
 =?utf-8?B?ZTBBMG5tNEtCa2hUcmtIZ2hCU1ptRGJwVlU3d0hkVm94cFRCWnU5WENCNlZy?=
 =?utf-8?B?eWtlSWEwdlhvTUlRUGJFN2RsYm40YW5NaERXRkNNeXpsdVNnRnp2YzZQT080?=
 =?utf-8?B?TSs2UzNEcWtCTi9OVUFuL3VET2NicGo3dzhsU0xRY0g4MnJKWXZhcURCTnJR?=
 =?utf-8?B?YVlFMW44QXRCYjBnUjJ2enAyZE5rWldOQkRGbU1TMTlOTksyWElQRnhKZ3dM?=
 =?utf-8?B?bWd3d2tRcS82WVh2TE1pbENKemQycWJ4WGhoSzR4K2dEcldNcW1LazJRMk5u?=
 =?utf-8?B?Wk50aFdjOWszdU8xUUZCMGtOSUpoQTJDNjA4ci9iUHNEK0VpcGN6d0hYMlgv?=
 =?utf-8?B?SG4vMjZNMklSK0ZSNU9BNmVBbUV6ZXNlRWhWU3RpUDhBZDM2aXIvZWxrOEdV?=
 =?utf-8?B?TGpzVTVWOGVDQzg1WEQzakk0TFQxZ3VURWVwMUVMVCtPRXNQQlp1cVZTNC8z?=
 =?utf-8?B?U0lpQzgwdWdGTzloellCeG9EL3pnNnp6MVYzUXpKeHZmQVR3ejlsOTNPQkYy?=
 =?utf-8?B?NjFwRlhPZGVMcGI5eVliMVkyeUxhbWhrdDF4Z3M0b0MxM1JaRHNYZFBMa2RH?=
 =?utf-8?B?NCthQ0tMVkkzWWdMUnQ0enYxd1dLbHBlUDRGTkcwWTZLSzBMOGdCS21hVERO?=
 =?utf-8?B?RXZaT2M0a3hUTWV3RTNIMk44MUV1TlVLUHVIU09QMVNrZ3VDalJIcE1yUnFQ?=
 =?utf-8?B?TUtBS3RMQ2pwaVFMdVJQYlNWb3B0T0w0ZlZLK0NoOUNlbHVzcFhUdW5zMkNX?=
 =?utf-8?B?Vkhhd0lxSFlpTDlEZGwzS1pjOGl4Zk5paTFVUkJzekV3YytQNHczaXVTQmJu?=
 =?utf-8?B?YVg4S3JkRDFtQVNUWWwvNVFGNWNPVXlLb0ViQnkvRjF3Wk1jTjc4ZE5uNWpL?=
 =?utf-8?B?T0JyYTNSa2Jrd0pPTTE2YU0zZmthTUtoUDNUY1ZkbkVFVVVMSlhyYlgxcUVT?=
 =?utf-8?B?ck5ZN3RLSWlNK0cyT2hsNU9LRDRaSjVuZ3dXVExhdkgrWEJzWi95WDVrRW04?=
 =?utf-8?B?ZE9NZjlBY2d3dHZlM3VQYkQ2VnBZVHV0RERFMjhkZ1FldXVhSDhROE5iYXVF?=
 =?utf-8?B?ZGx0elgyRnUwcDhNMGZRSnBGcTFSSVhGTU4wd2JiWlVWdTFxdzUyOTJjQ3NX?=
 =?utf-8?B?VDNJc1V5V1drZWJiTEpiYXFVcXFwSjFSTE02WVV2SDZodW9jRlRsTm45M1Bz?=
 =?utf-8?B?eG5LcVozdTNCb1NNVmZ5UnYyM0Y0bGJvSkQ0MmtiUDd5UlIwWmQrRXBtWVRj?=
 =?utf-8?B?b3dLaHJuUFo4ZmxtM1FtTC9VYXZVZGpyK2NWeGF2N0V1clFqZXdXOTJ1VU5h?=
 =?utf-8?B?ZStaTmYvTzd0Z3BTUnhIdmYzUVBqcHNlWG1lbk1YWEZCQ2QrQXVFZHFJMlpn?=
 =?utf-8?B?anUxMkx1Q3JaL1pNaUVjVjBaMnBJaExnUUtKSkxEYmVLZ2xrZWNYMHphUFdH?=
 =?utf-8?B?ZW1Md3JmbnBCTDVhTlhsQjd1dGs5bHZwckl3a3JNcXk5cW12WllsUDArdXZu?=
 =?utf-8?B?V3ZhN0g1OUFwSlFtUi9YS0pIQlE3WGswN3pXTm1BR0JSTXQrdGxUbStEMVFH?=
 =?utf-8?B?a0c1Y2hGWmUyNU84WjV0REU2VEtJRVoyNE4xTnNWSUxyZkxRTSttaUlQVlhC?=
 =?utf-8?B?N1FFL3lqQWxSbDlJbTc5WG5yS0tNZ1A5Y0piV0M1VFMrZFhUK25QbW5zNG42?=
 =?utf-8?B?SkY0b2hha0s0bzg0RHdqWm1RUUduZFhkODFPMDdIWFFrajJwOTFmeU51MDU2?=
 =?utf-8?B?ejFsRElmbEdmM2ZkMkt5VFh4NWRZRmRTUUQ5YmYwSXhFenV6M3FjZGRUOTM2?=
 =?utf-8?B?Z2VkOGtEL0dyeVVtK1RlSEUyOG1uTUZxeEYxQXRQbDg1ckdBejZJb3VxeUIr?=
 =?utf-8?B?UTZJY1ZnWWZqWDZaRllQNVg2eEkxUkw5UUJXNHhoYm9Ec1NRYjNDMExpamtY?=
 =?utf-8?B?SGZkTHg3d1hnQi9ENXZGaGhBUlRLL3BncUE1cVl6cjMzSFZtNVNKcWNuVzc5?=
 =?utf-8?Q?BZiULhpkJVY9Dl0dgSmbedXlXOrSWrw/IxhUKzhJQNAB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a0bf94-ce84-41da-d3e9-08dc5980ac83
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 17:07:16.9181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leB5Sx8XLOCt53IQnLSucj0oWjidNMeURe2jOlGobgy4EQD/Z1HtRQYSKs6YxX3baKelC7qtemqZrQ6TGqrmwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243


On 09/04/2024 18:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.5 release.
> There are 280 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Apr 2024 17:35:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.5-rc3.gz
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

Linux version:	6.8.5-rc3-g6d08df6c401e
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra194-p2972-0000: boot.py

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

