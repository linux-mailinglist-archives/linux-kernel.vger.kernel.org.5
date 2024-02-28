Return-Path: <linux-kernel+bounces-85120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8E186B0A6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D4428BA89
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ADA154C0C;
	Wed, 28 Feb 2024 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BFbf6GrS"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B0514AD28;
	Wed, 28 Feb 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127703; cv=fail; b=YOidUQ3CGkaja0hSNda5ZB/GQBXINTBoEKwtkLu0Z0wkepzFY03dGjNPr7e7L9qwKaqpCX1CxREpaVaEwx+FFPv1e6nKhRZNzW7lVeOvgnWRiuKGUUoecVDvyCbEei+3OfHeicYZdUsPdNFaoMn/ytMBkLLLaakljnZNZYy8JLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127703; c=relaxed/simple;
	bh=/RFkjlAq9Jt/kF+drcMYdEJhhWlYDwKF2XyBFNvCVgQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rM9YVsQgSx1XJtU96xXfPrJvmRlQafo9ZXrIwcml5XflCRilVkzvr23XIhh9nsQAjxqyAEyhlp2Lc8JWXelVblBRCBeYewUjH5d/njeP34O1Rz5rGfrUxNtLfVyZNl++ioSXxBZ+PWy3bb71AQA+GhsW6NNpZsCUamsqeScLRc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BFbf6GrS; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4WJj57LDTdmEiZFqPLfSnuU+LCSwVXy6HuoA8EHudh/34KAsxrI4Rf9I3pIIw+kRYml3XK2x8yxzR4QBalUeQCNLd1UaFmjQINtMAyzzAc78mE3XccTfXLy+UFnj03bwfB2LBggx2Ui1U07E0Ap6svaQjYANOxbtIP7VZ2FGsa3KTzUto5jRnqysuVRWlLly4qTCT939uVJXWF+kRmSJ8+ATat4oT4gjqb7KwseH9Zdaf0dPHfoApPT/ni/+SqDkr4nikBUojYBb9Oy/8E+UIha0U9HRzhJKdjI2333Dvz2eEExSzMun3PYetL62s7V63Qxb0Dv26dD0Vs1x+Tuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RZrnhocjWi0er2Z8JJ7GkES7AeYT7vhbZEyqG8OdRI=;
 b=drnvMeGybKb5jlL1WZLAz2sqgIuCuk1Y36loyGwOU9C7VeUzZhRAau9Z1+v127Om6mJdiT3dnRCxAs5TJ5j4x3qzTQm1igSNkK5jSO4f1pvJ5ulGuXuOtLoQQTqU5LiF2nBl0lqExJsddoPhGm/xJmHJqMp1igKV18J+zXy8YQ5JP9grhbxFTEs/RM9D/fpbPl50DS1MJpZdXYCMxF4nCdw+EFU4IkIjgz+FoyaUlIidWLALsdhYqjZJg2ZBVgWYxkE4J5UrgxsFNQQJI3SphBXwsHwAaLXNlvhH0a7GL+2plbodD9hyqnmplqmlif6HOJZkfmBvi23fFeEi6CZR5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RZrnhocjWi0er2Z8JJ7GkES7AeYT7vhbZEyqG8OdRI=;
 b=BFbf6GrSum3I+J5UvYxPvvtHmZLPzkRSSZVwKo3+jsBPufEV6vMhS1Gd04i4muMnz4CKpL61v69z5vfFZOfaKL/LkOPEN8hk38Tp1kA8Mkslps9LTPQPUJq5O1fuT4fZG3xp3h+xX1WvFRJq/wdJ9RQUZF4FE32bFuBTwIas/Ht/IdSjI0YdQhSzILW49Um0V8aYeHhfZU/ALuvLgZIDeMbbyWwjy6lDflwPJMcQpugKyXarLrU6ED2WEk9idY50d7f+5AfcbUOggefjz5Ufxf2gPJF/aLYGa3jNdwP/PvMfET3hTJZHP/k07+vFXny2VRw84+QcOZ0okYh1JH1UsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 13:41:38 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a98d:ee51:7f8:7df1]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a98d:ee51:7f8:7df1%4]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 13:41:38 +0000
Message-ID: <8a509f25-a672-4d5c-bd78-511768004c70@nvidia.com>
Date: Wed, 28 Feb 2024 13:41:29 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/334] 6.7.7-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240227131630.636392135@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0263.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::35) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a5d4673-fd1c-4ef8-0cda-08dc3862fd1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UfbeOqDi6Sz+21zAt4dVyVcpdEfigd00CCGyGlWWmN0T9FEmX0ma0BGb8CI3DYaKlVH4rps97AetWoi8LGhGuXMKJXM1DywHujcFkapTawVLZgoAbwtUQKPNR07brTMRytBh2Uj3OkhWE/IWupizZr632XRsApHbmZajLCZzeDyjOS7bR8p6i3d9nXjaII+iu9LLLvrLdKKFkg3TdNRu4TmlL/4W3BO27JsPqOcbRQrGnF8sZeBEukNr2/wAFGPszhbKE/p/RP6XiDPEaD2EkhKtLkIXF2CrKY9HvaNjShMovSrbys7szD8d0P5e7hTTbRq9hQ1920rA9ELwyRuVm8ueBbxivea6I0zJuTWoEVcugetZ3RWmaznlvEbXmmtp0jXvN6ExxpplaqMh22kjl55PZhM/n8wZUBV7Rr/hF8hSaXTbOj9oOk2w81NslSPzdsxl9EIg7gsQ7BBoduBvcYbJZotM1TxjbAxfavf/oWuBjf7UOt1P1ZG4TQ8KmbVtiqiINW/LWIyv/c3CdTBXblyjUYp4pwg4Lq1TswOxa8qopPnyLbOhaA7qL6JfBUamHVYcUExP+Hd4gvGswY8h6OmvjP7DbvhKU1aVvjVMy3zztZ+yhv4qlFQDi3VnRnFhq16c7FRQqjuWs0lboznEGKNF1atC0+lVVzjdWqhZFog=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVNqNzZ4WlNVVmZkdEo3RmNrcEJlSndYS0xCNmZjdEJLNnV5UWdTbldTbzhU?=
 =?utf-8?B?Q2JlSXFhY0VGdE50RHRmWDZvR29QQzBlNXAyRnFDRFlWdWwxbGp6VFM0MWVu?=
 =?utf-8?B?M1dyekh3cUJHR1NlRmNSUzdHMzZ6MjhUU3NobUllZVJ5dUNGaW5VdDV4VUt5?=
 =?utf-8?B?WEN2cEV4SEE4ZmtHc3ZxbndiNXJiTnBiZ0d4NURsSklDY3phV2xPbXd5bGZL?=
 =?utf-8?B?dFhUdVhBS0dHTkdZTEhDZWJZckJKMlJZUlIwb2Q4NVNVVDIzNFVCMFVKRGFs?=
 =?utf-8?B?dWZsTnE4a2toandXamZIdFJQbDRud2htZTJ2NGljdVNoVkUwVG5SMlUwNGtp?=
 =?utf-8?B?bTdEKzYzSmNmNjBYYkVhcHJLNEVLSlduSzRNN2cwNjZMZDBIeUdCM3Y5djc3?=
 =?utf-8?B?YW1hZWI5VWZqUCtIZW5KQTNjbzJGYS9oeDhPd0FNazdXK2NvT1JrSHVQamc1?=
 =?utf-8?B?b2szcjk3NVFVSUdGeDlVQk5TWmRHeDUvbkNEcnlxRFVvOWwzVDhiVlhMUW5I?=
 =?utf-8?B?R1d5TS9xYjRpZU43RktRcGQ4WG8vd3NGMCs5TUthWWtoUGI3U1d1dCtCbFk4?=
 =?utf-8?B?MnNHTHJTcUVjTDBRRFBqWTgrSTJyTVlJRkR3dmVXTFg3bWNZbjdZSXVkS3gz?=
 =?utf-8?B?VWZxMXRzVmM3RGI1TWNpYTh4M1FHUEVDdVROREhRWi9BUitybWZhbjVtb3pI?=
 =?utf-8?B?czAyTnVVUW9VQllZRDRBRmhzNG9Zd0RsMWVNRlBKWDcvc0VWTm1pL3RmenR4?=
 =?utf-8?B?bllwWFlibkVUVm1SK2dseHRwekRseUkzUTM2NEh4R2xRUmJQaWE1MWZiSjg0?=
 =?utf-8?B?ZHpwYnlvbldoeDRvd0xLdWpFeFJEd1p5RnRDV2tGMzRYOE9BU2JBV0ZWNkdD?=
 =?utf-8?B?V1BRNGxEU1FoaWh0Y3AvODg4a3JZVGRaMkJDZGpGajlQQmh5T2N3RHRmM0lZ?=
 =?utf-8?B?NTVQUVorcHIvdzgxMXV2M2J0UGMwcHM1MHhwWisvMEFCYW8ydlY2dDJPS1BN?=
 =?utf-8?B?Y3lwSXZETm9VdTNyUmRBNi9wTzVMUWtRR2FDTlphVExZbnZyS2VTS2JSV016?=
 =?utf-8?B?M0NRREQzTmFJZ256cklwUDF5NzNXdDVlMnRUTE95ZFR5K0oxYURobXFNTmpt?=
 =?utf-8?B?aTlHRGZrODY0aDY5d3RVNXlXRWlYL0cxamlvSE5DcWVrbE1jUkxVZExqZHFP?=
 =?utf-8?B?Tk1PUnhNdTNPdmJtSVNoTmdQRGhOSWo0UUE4Zy83SUVSTWNya3V3dW9EL2M5?=
 =?utf-8?B?ZnRBNTVkNDZYcVJnSDNtM2w2aU5JUGJmTjVUTFZkYzFSSUNkOWhCZm14Yzd2?=
 =?utf-8?B?eTk5UnpBa1ovNllxTitQcjhCY2VXeS80clM2S2lneEd4VW5DbHJNME5VMVA1?=
 =?utf-8?B?TGw3Q2c2c2w0L3pnRDZrQU5SdEZ5bFF0ZzRmU251V09PNUFqUWh3TjkxQW1H?=
 =?utf-8?B?eC9XTmJ1azJLM0xHdXBXTlU4VCtCR1FGdkExQ2pQSGI0UnpHRC9FZUswV2Ey?=
 =?utf-8?B?aDlneTJLNjZ4MlNGSCs5RGR1UVNFUEhpV0dpRG5EODJQQmlaa3JaZ3NqL3Zo?=
 =?utf-8?B?bmxUU1RTSlZsZHRIb2NMUDZQS0g3TEVzN2tJU09ZL0xNMElYZU52eGJiTmk2?=
 =?utf-8?B?VTZzVDBMWC9mTnNDRlFaN1RtNDhZUlYzdVR4ZFZORVhDY3JORi93MUpvcHJG?=
 =?utf-8?B?WFhMaHhlNGg0SlRmcEhZZURTQTl0QzUyN2VTM1JCcmJxeDlHZkk4M2oxSlhr?=
 =?utf-8?B?TVZkZ3dFVmlUYys5b3NsRlE5Q3c3dWE1elRzQXJYWEUxQUgrTG8yNGRiUWVX?=
 =?utf-8?B?b2c3U3l3NlNUWjFPekpNbmtXNlpZb1JhVkJyR05sa09Hc3JQWEVEZFdzWWdy?=
 =?utf-8?B?Ymorc3doN0VNcnJZc3dZN3doQWhkd0NnWCtvcXd3YThjWWZUMkVHRU93aEJP?=
 =?utf-8?B?b3oyWjlmYVNGYXhZa25VQytaSGZuOTF5aDIzS1dvcXc0RVdPSUs3aWYxL0dS?=
 =?utf-8?B?Z3hsbEYrbVNrd3ZhdU5iNFo4UEcyazhkZ0NXOEI5UmtsR3dWSHlwbGQ4bUZY?=
 =?utf-8?B?OTBiU3Y2MmU3OG5CdE5VQzQvRVRXWHNyMkpLNVUzQkIzYXZteEw4emxCR2J6?=
 =?utf-8?Q?qb0Rjf6uPWtFpo4OsrCI+sgAy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5d4673-fd1c-4ef8-0cda-08dc3862fd1a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 13:41:38.7317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuQAfsZmwpEEIIGDZHa5X2v/ntfrmYHCt98id5PlccJaXom5/glHMhIG1clv/CNX4IoTh7nG9Ks9TB8u2UgZ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105


On 27/02/2024 13:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.7 release.
> There are 334 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


No new regressions for Tegra ...

Test results for stable-v6.7:
     10 builds:	10 pass, 0 fail
     26 boots:	26 pass, 0 fail
     116 tests:	115 pass, 1 fail

Linux version:	6.7.7-rc1-gefce2e661579
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra186-p2771-0000: pm-system-suspend.sh

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

