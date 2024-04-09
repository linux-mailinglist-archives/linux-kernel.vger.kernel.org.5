Return-Path: <linux-kernel+bounces-136327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65CB89D2B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7642839D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7F8763F1;
	Tue,  9 Apr 2024 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rTbsJq/W"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2127.outbound.protection.outlook.com [40.107.223.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0706E5EF;
	Tue,  9 Apr 2024 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712645608; cv=fail; b=im32DQDAqZue4/0Iw4w3d5T8WNiHGvCMl/0ZOfoxr7UOIvC2CV1YQonSyUK83hd7QXJ/LqebPffDXLmsX5lU44NdTuKgjEeyVjkF0GE9KtVam5oqQvuFicSvDJpxyKqzGLrdSn4Hf4MqOcKl3ebuTY5J2mmQBcgoGAkFeTnKyKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712645608; c=relaxed/simple;
	bh=X1p9Baj6NTX5sidZwGVJnuxGaSPbU5ijSEskn7W5HQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hXe/VR6fcqo24FypK/t5UG3bayh2SNwJ8toAi+Nb7vd0QPlDDvw+Kk3c1PTZbfHwIg+qs5prlXFiNPMHLMYTshxjwvyVzboqMjnGU50zK+uzMeNM85T/4MvN8PDWH2l6C96zVQJAP2XowcOmBAuDIqjuoNbpA1i6jD7e2ZviKeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rTbsJq/W; arc=fail smtp.client-ip=40.107.223.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuwDol7s0jrWVF3dlcIbs5zFrRhj+y5Tiy/8MvRe7DOCixg5oqsliUJ/Lb+VvQ3tEpuHOcbPZW7FrSxVIoMuL+Se5zETlmSjit7vDuOsQu6QrRJXNHJ9+cZyWqN7txBmrQgyURibBzrBFP6bHyCy1umiUmD3jlk5vZJsVymD0yIbXDYMEBcc+9leNGS1lrcuNLketw933nZZAubg6JCjia3Rzza5r185JfMQAdeGjkEj55+UvY7urUWP1kxCdsb5Xbk8qLsLhOR31Ei9dAT+mRu1CK3yFpi2GUdefrK4zHS8Sna0N+zVqdCzQ/rnCCZUJ3ZPmht9DIo2vityUBDDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdxMMm929M6Fg5A5NEjpCrLWrk7+s0Fb29+00XzHuiU=;
 b=M20/QjbMgKSsU8Gmv9ZeN11hKf+3DUXGTTxrUibfFTRl4F91U3VaJ6/bhvRH5Oi4EzxlsDQucXz58BTMew2U8TZplWISnmBX3UWW9Mt51ESOZn77Wlj26OGsF6j0YuY37r3vHXhafwX9OWRJLFIx4fyvCzaiwT0qQW7Jfo/zFtFS2x6Re5FvjzzqHui6rIpPEGs8Ro7UjF9P4BYIj/0Jf+8wkejQWrH0MRMiL13H9svv6Pdku12H0kmts6ZQilljvvakorvVP0WveFqRY/Fko5ScnQanQxAjzC2xtC/iEN+LnFJtl9SGpgPtz5S/FlO2AZtA91oSutb70OmZMz3nxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdxMMm929M6Fg5A5NEjpCrLWrk7+s0Fb29+00XzHuiU=;
 b=rTbsJq/WPjeaLuBP0yfYoQ+yqGZeN1JLjybApk9LD2IhNMdxRfgt/59tegluLRxe4XQjDgXvQZNNeHfnCiv5qBAB14wWDwd22OEm1PENdlGasYWqKL4FgoCZGdszbDKISkpAvmoK1LEws+GHoQlibM9mMLGtzRQGw+ERKhZ0t6IYhW4BzdGh4dbYKPCPMbrXOyajxMn8i1tI5TxeBttHtepIqpONwR+ku9eySg1I43Gk4EwaohJxnqsZCTYNL544wB2pWcS8AvtOEzMy2rbmVMiDldy8KujAMi3PxLEHzahyfYXFi6Q8ZYdVUGwCogx244lyOoZYnIi0vpCJT+gsVg==
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Tue, 9 Apr 2024 06:53:22 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%4]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 06:53:22 +0000
Message-ID: <04151fac-3bf6-4199-a822-2fbaaef8b77b@nvidia.com>
Date: Tue, 9 Apr 2024 07:53:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/690] 5.15.154-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240408125359.506372836@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0095.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::10) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM6PR12MB4482:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7t8U6NKO/VyxjMbY9xBBoS5XGORZUZEdy4hsfE9m+M07iLYCpanzi/313xvxC/VJAP6GlSXe3Nw9WXCCpPhyr9U00yz4ksy6sVFbL8D8HzVygL5bZEeguOKM/MuAPgBKFDPc+o57BB5dEm7pUIb8xs5dcVUaTRkcv2jW3mFSowM8nukVnDLps+wPfpcIS52oYyv/O9ErDWhnyPFkMgZNoV5XgIA96LY6TEnLOSdPouweiX/4xDvbUQB7GTz1BExyFQPzj0RP0qRn/C0Jornm4eOL6yL33F8E0Ft6RdYlhnJfLFdpiV52f0fEgWk+yt4Tl67vJQS+JFdiKXD93dO1hZn9/TW4p7YJL134LAznyW1YSDEoIXOZzvhPhv+Fm5o6GQzeqdYPLxMoaCwXLbSo6MvOjN8NSiiBnohpLFxdzoZDW1v3G8RSiM2EazzZ1wm50fxbJHUitEraHj932kZ+xVvwClKXWHhQMtxQeeKqOK3Ob1UySJ4u/jomf7QkK1IRyHCnJ8IZNsS+dS8p/GgbmXX3QYIiiUM6jpHbuYInzSOUpFZ0YwUr2nNlok7rO59jggs1yqHLFf36mHJS8oEFpsgM4WAxflpDv+/k13d5a4zQqXuFb+n5w2NYLyHFKxeEI55vJqxhCT+ilpdhQCEvkXSeX2OkOztdUgHZ5dSDFMM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekdnQjlxTWRJeDhJenNHY2xpWThNd1dBcWh4SHZvME12d1hOYTNTR1ZVVGV3?=
 =?utf-8?B?VDhnVE9zUHVBb1IrWnpESk9qakFDTzU2dzZEZ1NkTmFrR1BjM3h3U08vSDZH?=
 =?utf-8?B?UnZ0d0pwVGRGUEdOd3lsakQzVitaWkxIRzkvbkIzK0c3bTZURkZkYnoxRk9m?=
 =?utf-8?B?dC9TTUR6N3ZtVS9QV3VFMXJpNlpTbjF3V2VJQ3huZjRVNFFHYXFWWWFHNWFQ?=
 =?utf-8?B?cVI5clRZTUJoWFdnYSt2c0Nab1I1U0Z1Y0hVRUFRZWlWRkcycmEremhvVmFu?=
 =?utf-8?B?OW9OVU9EUkxmazZ4WEp6eVJ1QngzY3lON29nZExSb1pmL0dsL2ZlRmozK0Vu?=
 =?utf-8?B?aWlLMzVJQnN0d0pKMGJ6K0RnZXhQQ3VGYzZSTHZuZ1VTSmlxNjM2M3J5bGox?=
 =?utf-8?B?a3g4ZzRRemFrWXJSR2NYZDBZeUZ2SytPQ0RtZ0F6a2cwL1FaWWZZc3BoM1p1?=
 =?utf-8?B?aXNWenExZVp3VysrRFNIRWhWMDFqYVllS3dUS0pyYm5zems0UVNSSUpFa1l2?=
 =?utf-8?B?K0dvd0pZekFsVTMvWkZ5MllvOUhFYldDblFLaUpEVlZ6enVBYTRjODR5cFdZ?=
 =?utf-8?B?eGx5elRLSmR0S1lVdk45NS92ZEtKTUVMS0FOeGdodmdOa1dlYkZsa0NubVNM?=
 =?utf-8?B?ZWtsMlU1VVN2U3FCWVRmTnZCdlVvbWhhV0QxNWlVZHpkODhMdjYvb2taTUZC?=
 =?utf-8?B?WWhKNmlrNWw0eUdlRTNuWUpwQmJqNUZWSEtvZWl4R2hsOVFSQW5LeW5DYmdk?=
 =?utf-8?B?ODF2WTQyNEVpSXpqTk9xaVFRMUIvME01bVcyNnRYWDI1cVR2S1RNb0M5Z2VT?=
 =?utf-8?B?ZFlaQlF1MWZlS1NDNTY2QWpIU2ZKRnZRbTUxN1hjK1hnUTZIWEk5bU9hSjVl?=
 =?utf-8?B?THAySnZ3RDFsaUN3VkFzTXpkWVIvcmcyZ2FYTlpqNE9kNFZTa2tXaTljN2dE?=
 =?utf-8?B?SzA1Q1FkNVNlTWtSRzJIdk83Um15RzVNZUZuV1BGKzBmY2Q3RlNQcjBqYm1t?=
 =?utf-8?B?bzdCMUdZMGdsNDZFcGFCdGpacWNuM0wrTFA3U1dreVNQdEtyZnJCUFpEUmxJ?=
 =?utf-8?B?VmVmcEVPa3VMNnR0S280RXZXMUxMcVZGWmJVbnJTaDdHQnRxTXRCQVY3U3Jn?=
 =?utf-8?B?b2xTT243a0NoMWtSQTVxUlkyeUlOYXQwYUJ1WC9PdWh5Njk5b1ZlZlJVeitR?=
 =?utf-8?B?aUh0S0ZEdk5lM0JBNzZjcWhjUVlKWlNJbDFLRHR1SldXeUFURy9BTWVXWVRG?=
 =?utf-8?B?SVg5OE9NWUs2TE1NOTFYVlJlaWtaUTJZWnN2OFRMZGRtNzdYeTJIS1ZseDJL?=
 =?utf-8?B?TmpSbC9kZE5ZY0RIclZ3bU1KZnF3b2pTYWcxaDY1MGppanFpSzdZeGw4RGVj?=
 =?utf-8?B?K01GOWsrM1hzRE9qcG4wTmZCSDNReFhiQzZ2dldLZ0Iyc1F0bis2RXZjc0dX?=
 =?utf-8?B?U3pTQnpkakxiZXhldmsvUHVWdG1BSE9rcGRwbU54SEdFaGZYSXZ4dEJmalI1?=
 =?utf-8?B?bGN0OWVyN0pEUmVJTDlKbktwWDhPek1rNmxGYzVyM0FwbUhHMldRMldLck1z?=
 =?utf-8?B?Y3k5cnhWOENIQ3pxeGVRWk1XRWE5Y0ttMFpvenl6Z2wzcyt3SnlkbDFndHF6?=
 =?utf-8?B?MkYwcVNKZUs4SVUyRTdUaURyNjlkbXFvb2ZCMVJ6U0NOTzgvQ0xhSitNRTBY?=
 =?utf-8?B?VWRla3JEcE5aTDlmKy9rWXd3Y2FJSkJ5eDArd2UzKzh0VnpwVjVnSDVvZC9z?=
 =?utf-8?B?ODBZcWNDOVgycHBJVkNMa3dqK09aUWxsR2tXNys1RDU3OEZERUhpMXJGQjl6?=
 =?utf-8?B?dng0aHVGd1JTZ05GNDBDUmdrTkROaHFoNkdsZXoxUDE1c2RMaVczTWpSS2s3?=
 =?utf-8?B?b21BR00yeS9rays0OHZQRGlZc0VCYmVXVVpvelc4ZmNPSDNFN2RHQTk5Wk4y?=
 =?utf-8?B?TDRJdEpYUnY5TTBhWk1uMTBYejUrKzd4U2ZBQW01SDByY1RJcndsc1NLdHdz?=
 =?utf-8?B?ZG5TQ0JJZURvb09iUisrQVh5SzBpbTRHSTUvb1k3NTZUaHNhd2RxOTJyUnBU?=
 =?utf-8?B?TFdDZ3BIQ2haaEVONGF1b1ZLdVBJY1EzNjF4ZVFNbEtnQnc3MjlxempDblRi?=
 =?utf-8?B?dW0vTWhGLzlZa0tOVndleWZtMVNlOFpTM3BQYTBzNmN1STNXMFZGc2w4QXlu?=
 =?utf-8?Q?mg/jVWlVUWkk+l/dv/E07aQXygx4viXw3tUkYEoVYoWo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6b18f6-5831-4354-8ee5-08dc5861bee3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 06:53:21.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nNs3e9bHLMTyKGpHLJu4sumMnce6Mv6Mop66PO/nLUBheUaETbb4zcfs9l7qKzoLHIxk9qsfc1wVlwYtVwD0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482

Hi Greg,

On 08/04/2024 13:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.154 release.
> There are 690 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.154-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


I am seeing a suspend regression on Tegra186 and Tegra194 ...

Test results for stable-v5.15:
     10 builds:	10 pass, 0 fail
     26 boots:	26 pass, 0 fail
     102 tests:	100 pass, 2 fail

Linux version:	5.15.154-rc1-gbfeab055fa43
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra186-p2771-0000: pm-system-suspend.sh
                 tegra194-p2972-0000: pm-system-suspend.sh


Bisect is pointing to the following commit and reverting this fixes it ...

 > NeilBrown <neilb@suse.de>
 >      nfsd: don't allow nfsd threads to be signalled.


When suspend fails, I see the following error message ...

  Freezing of tasks failed after 20.006 seconds (1 tasks refusing to
  freeze, wq_busy=0):

Jon

-- 
nvpublic

