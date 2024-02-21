Return-Path: <linux-kernel+bounces-74679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 605A585D79E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBCD5B22523
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249A04D5A1;
	Wed, 21 Feb 2024 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QnI9rtr0"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6A54CB3D;
	Wed, 21 Feb 2024 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517083; cv=fail; b=Fv/treZWe3jlHxadWLniKaS/gy6Zv6zo9oC84FALidvcTqZedkC5cgUyEp4xa5Xq9ra9fuYikMA2+RptvrGwmjC13vh4EAaIwn0V854FnuYAs+ZxvTGYFmcLs6r/cAVp0mfINqrpxk16VLxshEvrFp4FmN73tmUoYL1eJaBkngo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517083; c=relaxed/simple;
	bh=uAjwqQB9dRFBmtBRFCU5ONvOtIbLDfA12/ZOG8FqHjE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cMt9bsTCf0VpgcABhWBIa4yHAhLqK728swiR7T5Z6p3SKMdYrvrtofGyUmTMYPdnpKczaUDCeUd/Y5WYAIwPc9QZGhDebB7Xt4vegJoqU/HHPYaIfAanHHbloj8AZSxSB3zxIShjFQ80+muFTHpjekuOHqDFx6xXRidOt9bELBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QnI9rtr0; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YR4XvVO9JOKj9/xKGPrSDU8+TuMzcgT7pYKXe3FhFJ+ObVmdGgZrSAj8DP1ZbJEohT68SoVzxx9PyrSIVnayn/WXzf/lQLFpq7AUEiMSGNcBWsouBMtM39yk/EA5trsBXfD8jZwRHtNZ77epBwMerFgis/sbHBuwlJ79mqoA6vRj81/1lBlSThsmMkqgm9t+2lQ57kvkXgzfS63h8HfTao+lT+a7GgWI/Un3RcyHrdi03cp1ZyztXCTeShzkfdnk1rTg+q6zB9F8fbpxOLXfvHNQSwX6wg2ip8W+0RwQJUsXezkQFJDE/YDVx9EtZusTpdqtvC3l4vbWie6r8Jjbgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iN+NgKHg879H5qf0XbYuoP7yZrHppnJQ9w7kEztJaik=;
 b=dQliH/HadJWC4sgTAcgAx41eDGm4FAWJSVyOpaj0bPbIUDt5370kEgJvelxJ50PM4o/I0/LqKwtXkGn1OG1ONTbCpxqra8tWPyrwnlWBPQRZ/EJ7xiUXpFByffBixgxcC72WpKIJ00Ug9XceT4ggX1yW5gOChgqSxc3zmviSE8Cql8wUkNdv0YVP6byL8HtqY+rfVbdp+KKfWuRJbvU+yW1FAuxvkyGp7CN6bSsj0glpCP2XEMFNJ6lJiBhEDq2p0B98dCI8J7du/O5UMMK4qBqPpG3SfkDK6hN2FSarl0V/45fXCBhbk4rmFKu1cWEZKFki4HcqCAsOj8NDIiN+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iN+NgKHg879H5qf0XbYuoP7yZrHppnJQ9w7kEztJaik=;
 b=QnI9rtr0PHCzhgHc9eBQNl7qI4/92NR1BvKq8e8SmOsLI3on8uYLY+2SlPtNkIGsnaUpZm0lQ9hblXKhS0EysuhzcNmdb2/I/3RWdPXS7yYz3RrfPG85DYJX3dbO5W5HT992q1AfRgELve/fxHuW2qjPBKQwLcqdGa/q+hBLtiMzYBjSDcJlTqFCjNakX29OrLSwQKlX+48zbvjjum6q+30pvu/AvY4ftMsUi003ZDeUh80kfPhCQni+DqPsF55zQliCtT+usXhugq8Gw1JcSoT3eaH59NkgReBZp/WkGbLRbAranx96ubbTSnNVX9fNmKGJpmVCT85K9+l9s1UJHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.22; Wed, 21 Feb 2024 12:04:37 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a98d:ee51:7f8:7df1]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a98d:ee51:7f8:7df1%4]) with mapi id 15.20.7316.016; Wed, 21 Feb 2024
 12:04:36 +0000
Message-ID: <b98e9639-8e80-452d-b72b-1ff1e5f9c64b@nvidia.com>
Date: Wed, 21 Feb 2024 12:04:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/309] 6.7.6-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240220205633.096363225@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::12) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 4920b738-f333-48a3-dbb0-08dc32d5462d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YJXnBqawVSoTWCnh3pigpOst7/o83VaFrUGstvp2gpEiVqlNQjF7BNcxcuwYq4JidVPBMX0ACnRQxKQqJiLsMSg6OtKmpq0GxpAWSB4C0tKYIwV8U0tF1lcIz3PwO/w0B6gJUPZXPRqQXXOAIgCbuwpwyhkLzej3qdGfyPy33k5luznEX8bJZTfpCO74V2wn/EKZPF2eomFCpGcPmzc4xU9gQoaIMRKbIHi71S/QSOICLnHBffAg1DyMGTxeq43wR7h1/9pVwrFXMyFruYdOSd3fw1bdSJHyJzjA+SzGZhtprxUcdWEw9htyKdyYNPo+RfCcZgHw2nXuv64QIX/wjQ6RmYIvNYURwQu9Kxmf2e1exdNjM4QCGv2WAQc1gRd7Q+hUrZLD5rdG2tMmZpuKarSacH4fmowhZ+wuoZ4N/7VlMM28Cs44teP8PO59t4qMNqtBPhWMJOfQqvkaaaWQmyiM9+mt4wGdJuZfTbX37WzabK7apXqcWB4EaUWRKcqNNhqM/5/vXeT5D5ITQRaQnxb/IbKiJdMXWkcAgQ3keKaab3hxaeJO1P8gf+lEPPjFU4tnN6+g/dATfepgcdBYBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUhmTVFQMXF1SFM5YzFLWC9IQjJkcE5VaXptWStlK0hTVXk2KzFhaElMMm9S?=
 =?utf-8?B?T1BrZXptYlZFVW1PRVh1a2k4ckxFWHNOVzVsbVd0dlZ1VlpUZXdPNTNMOWtF?=
 =?utf-8?B?SHBBNmlYb0JtSmVMZStQL21kTmdKdGg1U3piWHY1dWxuRFhjOVJEaUM0YmI0?=
 =?utf-8?B?K29uV202ZlVRK1ZnNFRyVmFTNzg3N3VBWnovNHlWNUgrcU9vMzZsaDdNd2xB?=
 =?utf-8?B?YldjMkZGVHJrWWEwSnMrdjVncDFIaUQ4Z2Uwd2tpdk90RC9waExUUlVXRGV0?=
 =?utf-8?B?cFYxMkJOSDdjZnduWlY5WXhkWU1nZkhZTnNHclIwRjlRemRmWWlRYTJQNTN1?=
 =?utf-8?B?ZGg2NE13UjlmeURBcEl6Q1AyZE5Dd3oyeFY4ZFdQVWRna05sYWVzK3NGT0p4?=
 =?utf-8?B?TlkzUHpJM2xBdzVNaHZYV0o0dlB3bURXVmZtTzUzNUdXWDh2ZmNsK1QrMU5G?=
 =?utf-8?B?eXBqT2IvclJkb3ZNRW0vY3RzY3RJNHpVVGVZd1o2eHVoMG9lK3E5QW1wM29N?=
 =?utf-8?B?cWE5NjgvaDZOMTdiQllBVmtWQ0NXNit2NFlFdDRzUEhkU01sZS9VbDBBb3ZJ?=
 =?utf-8?B?dEtmbDVsVUx5YlYwdndNbTVSbmFIMm05QlhZY2JtcWtRYkhJRnp0cFRqUytR?=
 =?utf-8?B?dDdBYWNQei8ydmpmazQxU1YrdkViK0dNZmtraWQzY3hyWmpYQjVDVTU2UHds?=
 =?utf-8?B?T2dpbE0wUnFDOEhuWHVndUljWTVnTXo5OVlSSVVLUEtDaVJwc1p2bFFXZ2M4?=
 =?utf-8?B?QXk3aXhXdS9uN1pEV1gxcytXR0c1WFUxcytvOEFqVm9neHh1VWYwc29SV2Fz?=
 =?utf-8?B?YmRVb2VkV0ozQWpEMFZRTXdlWHVxKzhLbXFWMHpaWmExM1lUSFhvSitJUm5w?=
 =?utf-8?B?QVcycTVja0RydVlpc1crNXRTNmN0WmtrNDliQ3lKNVdkUXNab0tTN0h2Rklx?=
 =?utf-8?B?UGl6QzV1OTAyU1pZUUg5enNRTWo4YStNLzJFYkJNaExNVkV6MUEyRm1rRllz?=
 =?utf-8?B?Tnk2Rm5YdEExNFVETTRWbjdrMWRmQUN0NjdxRFljUnEzZVlmMG1LVUYxZUM3?=
 =?utf-8?B?bDh2Y2lDb2tLWTlwOFZMMm0zVXdNVnB6MXJHMXEvb1hmb2RhZHJvcXhuaEVm?=
 =?utf-8?B?cEQ4VUt5UTN1L2svaEJ1d0xsMTNRQ1lRZHBvVERzZEpEalo4aVE5TnNnbUVo?=
 =?utf-8?B?dzNYRWZLdm9oVTFJL0swRXFkVGJ3NWhjcitRL3ljS2VLRkdvQUlsVGpQbWdC?=
 =?utf-8?B?eXV0NkZjWW1keU1mcmJIYmVMNTRBYXBhbU1TVmpjVXpIWHRkSEN0WDRXNmU3?=
 =?utf-8?B?b1l2WDJKcDltM1ZYNzNpdldiRlBRQTVWNzlJQmFXeTdabUdsUHQ3N3gzY2pv?=
 =?utf-8?B?eDViUjZZY0FsZVNWaGRyeU5zSFZtUEtZOWZHNGdYRTFmUmdleUtoNTNPZVpj?=
 =?utf-8?B?b2UrY3lUWUdhMmp0U0ljZis3ZnZjUEZHMERsa00xVHdGVmVSeXJONlppbXRh?=
 =?utf-8?B?akxGbHhLR3dNL0xRT2YzdGRJdWZvcWpaNUZuUlhraHFVU0M2SzR5aHl6T05J?=
 =?utf-8?B?K3RJVCtlcmRDL0MxVGVOYXFBSjIrb3ZWRWE0YkM2aDdja2xNT3ZSVjk2aDFM?=
 =?utf-8?B?RDRZaVlCM1hRUzdWUkppaUMrVHl5ZG00L1ovRUdIN1B4M0lHS3loTi9mK1lL?=
 =?utf-8?B?WHljaU1PU0FyUEFYRytETFpvWkppMkpqeG11VENUc1pvTHpudEtEZjBjWEJ6?=
 =?utf-8?B?S0ZDamlrVXJZYXk5bHFjaFFYbzNqMDZ0NXd4N09WRUlLOGNCTkVoMWdZeFRn?=
 =?utf-8?B?UHN1Y2xiTFlVRlZIRDZXUXlPaE0vUkFzK3RyMVcyYkVrSTgvY21zdHRudjhH?=
 =?utf-8?B?UTJ4OWFXRElGbjdFV1JNZWZVVmEzVGNDRHpkdVcwcEluQlNBOFFxaGh1TkhU?=
 =?utf-8?B?QjJlQnFWUG51czNkVXRmQllaR1BqcUd6QzJhQWlsM3BwSDhlR2VSK0tBQ3Ur?=
 =?utf-8?B?VURldUE5VEhQV0ExcVRlKzdyTGhGbVlJTGVlemxpMkhSZy85L2xpTjJvUWt4?=
 =?utf-8?B?WVlNakdrc1laSkxwSXF5bCtlZ0k5SGpCS3l0ajhncFJsRytlM2tGWGVSdUxu?=
 =?utf-8?Q?F6ZG/RHe4LzGo3a1hF3V4Kmlk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4920b738-f333-48a3-dbb0-08dc32d5462d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 12:04:36.9031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94A/r2J/rcGPtM9io5/lfIvctRMWUofc29ZshwaV9f9CMhpk0RTQCaoYa10tOlDE2vnPDhkCp3Fdm7mZm6C/WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449


On 20/02/2024 20:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.6 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 Feb 2024 20:55:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.6-rc1.gz
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

Linux version:	6.7.6-rc1-gc40c992a3e2e
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra186-p2771-0000: pm-system-suspend.sh

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

