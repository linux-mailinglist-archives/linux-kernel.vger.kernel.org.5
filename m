Return-Path: <linux-kernel+bounces-65258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34243854A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F565B21A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C3713FED;
	Wed, 14 Feb 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oxEISDMl"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F71F1A58B;
	Wed, 14 Feb 2024 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916560; cv=fail; b=Pbug4UUjZHfgC723fZg2YUWQ6Uxat/OtCcLwidbUszP6WZWybyYK3+3npMEI9P7sVnu/B1S5ssBDqLZ/CvJoIkPk7i54mSLJwveQ6VOGrKwcdBHU8G3ppRiyZ6rHHHHDyAsQmIvXCOwkw8QhkjgRCcmKR06Vu9hRWpv0AHgrOII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916560; c=relaxed/simple;
	bh=cZp7c3mysJFaHsk6rrz2gTg6p4H4Xab32Bb7arHYrG4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LU9xBMTiYrn0oHMs0AKjy/i4Bk8VYayD4JT8FoyF2TBrCIzKDuQKtSWz0aryIJ/xfzlTcPX4597LJQB13iyDuZCPG5z/q3Lx3CYnCr5w54ROtd8ONAgcfgoDJdQokr1cwuTsWgTc+ql5M2aaKZnmkuEcBhgdjn4fuPHZ1lVjf10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oxEISDMl; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj6yk+Fnng+PyzGoVkJDIF8SyK6gWlOpwPxFN0rmDutsw/WUFnzgtNyb2t9xSNyyYIboOp7UtohO6rPS2lF5FtiELDbjzEsNV3rSb7dCTDGg4+BMbg5TtIqJ4ybHUnYTVo1bOqQ78qY7twLDhdfWpPz0vIb4d4syFuJyvWgUvBB26YLvkSoCgCQLLhGjlpso9lwOQQ84E7gqj+vVTQjjTo2r9olIccF/Qo/Fgl2pjSKXqdeaGCt1kvhEr4iImmeQWcPzf3DZU9piKgUOaDtEXHbvesfgBtcVkJTPRWfsYkTUDABhoYFOYzy933XfYBzYn1AkiOmxhyJakBVZvOwCIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZ6roqwzRJjipoiX6YLBw+IIl3HGqLjn524FFheXK30=;
 b=NQiCG2EqS1Qf7AU2REdRh/bQ6JW5zL/v2dEp1W6YQiQngoGpFus5vPh36RxcAAOcWUIs1bttOsICHG5j5iBeqTlA1jGAOnnAeXGPa8lujDehw52NQD0jJwU+E4uJGzS5LwGphcKZnSIwfruMyBKQHiraEW9VtP05w1wbZ/aCNjFr/nlJznTIjK8KxW+Uk3yLJ8PaFIeNxKzFhbLmzCilvlGH1ZgRVSiiIVImt5KH5LQHflnClQ8gg4P5Dj8nK3w13ruRCI2mbPLROEv2mzOQFNaiB+8zrSmjzYcJnYMruAjxc//Q8ZRtbDfYnnFaz0OcIv46ux+xi5x6rbZzlzOReg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ6roqwzRJjipoiX6YLBw+IIl3HGqLjn524FFheXK30=;
 b=oxEISDMlzcMiYpoL8fXPQcCDdisSzPQC3nw0nFQ9fTtSNaFBad3y8756zgpcFutLN4kvwuOolMW2U9Mzcyl3gUyVADkfS3kYGfgqzO5VLO78mlquk5Id6mOZgULVy47fafSWTH9D3/OBy+O9Ll6N05ZgCmeUXtpjLMOAwxRrC3qyHk1bzWnTmpzSm/YmfHX2WqIK/QBvac1M+kNSHnSbVby5IUdSq2h+zzrfY9wgnstoGHW/xUCzWKNSvjS3OyeiuevxCqk5R/m2nBh5WflWR6Z9eA18zSbOtYP7qsd0h/Tq7Wj1lMKlUOxuE/VR4VAzy7UppUFLx55c3LNbvGmEMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25; Wed, 14 Feb 2024 13:15:53 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7%5]) with mapi id 15.20.7316.012; Wed, 14 Feb 2024
 13:15:53 +0000
Message-ID: <d74b1c1d-a0dd-43f4-ad6a-0dca69329c16@nvidia.com>
Date: Wed, 14 Feb 2024 13:15:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/64] 6.1.78-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240213171844.702064831@linuxfoundation.org>
 <83771838-c346-4a90-92c1-6ba592a620ac@nvidia.com>
 <2024021422-reckless-remark-e721@gregkh>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <2024021422-reckless-remark-e721@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::11) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM8PR12MB5399:EE_
X-MS-Office365-Filtering-Correlation-Id: 537cee95-17c8-4904-0580-08dc2d5f1287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BiFSmMGlMornMe4zXXhbPg6lbRgPUJg3lO99B6qR+B+kP2N6hoPzFr0+X0xa335FJGi+aRMbGE/QW/fyJv1XYw6d75B310SIY3y7XI8AQhQRDkSn6RKTteLVtHv+GSq1W18MdkwS/FS9RQVb+iFKLwvYTNFAe8YkXH7OHN91UG4NPAO60BBvIDBXFoZwKclFtjKhxJaCq09Pg3WZzltTa1xxOCi3AaTpEXTUgB+v83+DCWmhzeKTiSgLzLx4j516hELgpSiIfUS0nVmeYsdEPn3QlFT+pk6Xd+0HsEjOdBdxai7RMAMM02Hk4Q4D1Wt4E5vvAY+vi6Wf17b+zl7qfQqL4Kfrr5+zM/avrYslk2g1LThVA1paFU36wN3l7154UxEAXJa4Fzs5NlP6UH6HeQ6V4hjwz0aRGaWlzJYkFgZZbNqgFTvCRLNkVu+ZFz6Xc8Y8G2BPreSENOhoV8iPsOS0dy/hbAQRfs99oal8CWXUZB8u4lRlHn7Hj6HAEEqzaGOg9HO42TOBZqWN+WaaYgE2QELESLdoQ0d3mmCw2M6EVnNb/EuptUALCy7kQ6ivIZ69NB+KbRYsMY62P9RBpUeAmENDC6H5c55U9fHxfs4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(478600001)(6512007)(966005)(6486002)(41300700001)(66899024)(8936002)(4326008)(8676002)(5660300002)(2906002)(7416002)(6506007)(55236004)(53546011)(6666004)(6916009)(66476007)(316002)(66556008)(66946007)(2616005)(31696002)(36756003)(86362001)(26005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXkwMWpRZ1N0R0RFZUF1K0s5ZENUOG9VcU5TUzBpSm1iRGtNa3hPeWFhRDZD?=
 =?utf-8?B?djVtOFJubW82MUNyNFpmTUxETmdFMm5RR3hYODhVdHV0S2dEVjR2cHJ4ZnNW?=
 =?utf-8?B?djZwM0ZKNzRUaWMrZ2g5NjdpRGVlT2lEZFpBZXFtWUNGSFUydmN1QXlqUU1n?=
 =?utf-8?B?bG1SKzRWYVFsUWhGMWs2bWFJWGNydWMrVkZCa3BiNGU0ZURaSHBQcFZNdzk1?=
 =?utf-8?B?REFIZGtFNk5mZmFNZmJtTFc2V2I4c1NIK2xHRXI0eHU5UmYzOWFWQ1dkNi9q?=
 =?utf-8?B?elVBU1NRTXlLTFduRHhHRDUvRmlESlgzcmxCbXYrM2hGM0VBYktIdGFRaGxG?=
 =?utf-8?B?SXhScFJxQVpySkdydytjclZ5VzMrb0NPVHZlSkpmM1NzaTQ0Um1XNmdna21V?=
 =?utf-8?B?dFZWYStTcjR5U0JpdUkvRmpnR1dYNVF5NGZtNDc4RHJ6aVMweHN6VVFHcXRB?=
 =?utf-8?B?eU41cEE4bTVza3NLN1RXd0RpYURJWjdnYjNlK1pabEJLZko1NDUza2NCc3Av?=
 =?utf-8?B?OXJodE4zdEVoLzVadmxjc3lWMUw4SERuV3BzZHpyNDlQMmE3b2REbm5sMFZB?=
 =?utf-8?B?cm9ReE5wa0MwSjQvR1o5RUlHS1hhM3FORGt5T0MxdFBZWFQ4dTE1RS8xVkxJ?=
 =?utf-8?B?aHdVU1VWUzhIN1ZxMW9MVlpPbUJtSWRUTnVwTk5TVWRadmpXMFhzVVhlenl1?=
 =?utf-8?B?bjNEVkFZRkdOeGJuVkJmdTRvdjJaWmNQUUZ2WjZUai8xU2E3akU4SUpRTUsr?=
 =?utf-8?B?S1BJb2Y1NUg3NThOc1hYV1BYZFFnSjFhamhQeUtOeE1OMnlUTUt1TGdERlN4?=
 =?utf-8?B?cjRlNGpRcEhQR29INlFwMkt5YUZEZDY1cGptc3I5ZDFFWTNFNlBmRjJaZHF1?=
 =?utf-8?B?a3pacnJOZ095a0pXV0xiVlJRWjhyWXptZ0VvYkNvZFd5a1h2a3FZQ3d4Q3Bs?=
 =?utf-8?B?R0IxZi9uRVFXbDlUVmRhYnM0U2FOOU1jMFFYRnJZUXAxSXozWGVJb0FtNzMw?=
 =?utf-8?B?ZVRtSWJLWExjQWtFTnFwN2FkL09VdmIyRnA3UUdWa0s2d1d6bXJ0Y0NiUGhQ?=
 =?utf-8?B?SmE1Z1NYL2JyNlpqVk83dm1CVnp2V0h4ZjEweUdhYlgyQmc1U2pHdUpZajlt?=
 =?utf-8?B?U1JGNDFJc0tuTnJCSTJxY2h3bE9qRFVmcWJDZDJCaldUOWU3cEY1TXh6ZVpw?=
 =?utf-8?B?REJoVjhrdXcvSWpHQWVkVEhDUXgyMS9kUnl1TnU2dUdlNDZIbmJXNkpueDU3?=
 =?utf-8?B?QUtDQ3RyUTJjNXlYMEJFQjdJME1DcE9DVVlEU1RpZFNYQUM4ZVQvaFB4N2x3?=
 =?utf-8?B?NVFsRXlLcHlRc1JWUWJXNVNyaUxtY1BhcG5TQzRZUCtNYnVLaENxWC95VXJa?=
 =?utf-8?B?YVdGUnpPQzlxdU5JYi9IdTdhVkdzbmpGL0FsVmdRWllhYzBBWGdReVRPc2t2?=
 =?utf-8?B?NUQrWlEzVHhnSWpBNElZUlBQOWNTRFpNVVI4Z2hhYTZzTDFURWNMbzVZNGpP?=
 =?utf-8?B?U2hRV3VCUEpZaEp1bS9oTDZNci9ZaHZLVnZId2w1eHFYZFJYb0xjc09YZGJ0?=
 =?utf-8?B?MElBdVFJOGx2Y1JQWWpybDdZL1o4Zi9vUEp3TjVaM0oxczFXUi8zRFBha1RY?=
 =?utf-8?B?SlJMVHJwMHJ5U1ZrdDRQbHhjcnlObG1pL1BBSzVZODFDK0UxOW0xUHQ3T0lo?=
 =?utf-8?B?S1JKSUFnR1htYUZtWmQ5bjhNMGhOazZqWnFNdUVBK1dPcWw4UW5USHM2eVRl?=
 =?utf-8?B?NSttdTRmZEYvK0tIcGFjaGd2NE94MThSR2ZrekNCdXZsREw5VEo4YnUvdC9H?=
 =?utf-8?B?U01nanZDQ05hQzhJM3RTdStrZzB6R0ZKUHhXcnBJaEE3S1BIWUZqRTB3cmVU?=
 =?utf-8?B?R2p1NDE3aHl0U2psOVVScWRQR0NhSFdibDBRT3oyZ09WVk5kc0RJc3lCNUts?=
 =?utf-8?B?cW5ESDZCWko0Uk4zbkUranVCZWM1V21OdUk1VGhvNFVucUJiYXZmeXhlOXVx?=
 =?utf-8?B?eUxiRDFJT3ZveVY5SXk2TkNDeTA5b2RsL21yZWh2V2xCQlVYaitQYi85QUov?=
 =?utf-8?B?Qm1VQ2lVMGZNN0Y3VDNJczJPMWxRY1RZYmpTeldFSzlNdjF6NHZxaTZSdE5n?=
 =?utf-8?Q?vFwmBlQA3zVxLK5tqR4lgbq32?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537cee95-17c8-4904-0580-08dc2d5f1287
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 13:15:53.8117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lEszNtvi+pkgcMEUpJAvo2+lp7I410kxup4UVR8edeFING/fSjCywwy4o7fCe6B533YIitTfQFai2VMwib7+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5399


On 14/02/2024 13:08, Greg Kroah-Hartman wrote:
> On Wed, Feb 14, 2024 at 09:03:59AM +0000, Jon Hunter wrote:
>> Hi Greg,
>>
>> On 13/02/2024 17:20, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 6.1.78 release.
>>> There are 64 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc1.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>>
>> Builds are failing for Tegra ...
>>
>> Test results for stable-v6.1:
>>      10 builds:	3 pass, 7 fail
>>      6 boots:	6 pass, 0 fail
>>      18 tests:	18 pass, 0 fail
>>
>> Linux version:	6.1.78-rc1-gb29c5b14893f
>> Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
>>                  tegra30-cardhu-a04
>>
>> Builds failed:	aarch64+defconfig+jetson, arm+multi_v7
>>
>>
>>> Furong Xu <0x1207@gmail.com>
>>>       net: stmmac: xgmac: fix handling of DPP safety error for DMA channels
>>
>> The above commit is causing a build regression for older toolchains and
>> I have reported this [0]. This is also seen on the mainline and -next and
>> there is a fix in the works [1].
>>
>> Note this is breaking the build for linux-6.6.y and linux-6.7.y too.
> 
> Thanks, I've now queued up the fix.  Do you need me to push out a -rc2
> for this issue for your testing?


Ideally yes. That would be great.

Thanks
Jon

-- 
nvpublic

