Return-Path: <linux-kernel+bounces-136348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8710689D2F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171281F237E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155BC7BB1A;
	Tue,  9 Apr 2024 07:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lobQ3hmN"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2097.outbound.protection.outlook.com [40.107.94.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DBA537E6;
	Tue,  9 Apr 2024 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647497; cv=fail; b=AwLrz73NP6FCgxsqQRcgVnwmlBk6vrvqH0xoqMnkTu8Es/U3Ad7iZWocVWpqvMlZDcqQkfV/I/y50Y1OGnjQlA8Uu1+7gDd5KHWG36pJxI+eecG2pmc9qkCjR7icwY+2vpVoMi84XkJZel+9mb+hmqxmSEECbjIkQtDmUDLgzo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647497; c=relaxed/simple;
	bh=Vm2PHzdUlWsOlePqbZm1vvqIsCgjF3sU2o3Nr1Nr7E0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qnxnwAlCCave49gVFo6ri9x89AlDl5YOetOGc0T8VTLTJ/Yiy0+HR82N4EOf4fzV3tiERYsftDQ6lPt2rVE4otR/l4hIAJ9kI668Rdnzbgvg1evRDj+PQ4Udu6u3OPh9+sqIoYkfSWmRB8qjzjVy1HNdEKaFhAnRMGcn1WnUHtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lobQ3hmN; arc=fail smtp.client-ip=40.107.94.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nC9rAFNyP42aEavzh7ZQLFUCFJ/1lLec7tsDXzasd3SqcMEItmjwq8VddMCWjfxuxOTzutGiSeeLBxeCPnek4WtcTuDWQ+GLc75c8+EgV0KgG00E5JUUoPGGZV73yZiURFJW88W0UiMiGcjlv6LpgPehCOtoXdfqmfGvNhb1CLrXqPVSV7C+DqQ4G9zKGGi+R/eTc/PRGAj0ep2xFVXAFrSD7Rdom8TnPinq+v5BTQiGGK+YFC98WRgC3DPNbJEWm5Zmha3dGKmf1zkXH7VsMWs3atSGv0I3ifaNPEDY6rBKxwVKGVT8P2U9kfL5uG6XU9ERs8v5B6NbGcO3Kwr7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raNpU5z+gZULZNUgqZYY78dno3CXT0MSgsuw+Jfst0I=;
 b=glLuQ5t46XYCURfe7GT+4+rC9aM4h/XswHvWzEjAnUih7IdtbyIkZ+b31rmQHRgj5ldIIG92u13IIz/dIoM7MHJpPA8RyEDZE3D/24ccxv1V7dMc8/i/yOnl2SxS/9bm1VHZfwCjsoTSkWd6TZYaq+fYAMN4ptongWUSn0tXCaesXMSrUvmN7eXI8XbjHoKOmJc3aprgz2GqcdQCCGMCnG6PF/BRin8Ux2Th9cuJibHiuMi9tNPBWxU54YknpSXz7hgHR8PPihed0AsCcBkDOwhNi1WZwgBq2FQyCqh3BhdMc7kkYTl9R61GEJ8SvuK9zrxSMP4gMru7MVpAZMYKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raNpU5z+gZULZNUgqZYY78dno3CXT0MSgsuw+Jfst0I=;
 b=lobQ3hmNUAMQ4ES0c6KGrVGcSLEowQ2E7f5qJn4xlEsK1Zdfgmizvqhl3uqKMrDGMnQtfgy8b3jWi9EJX1Mm6l5TjmG3/0cRNr3VSpXsWmh+RfORARN8uxoS3k8jjKK5cS8WPPVzAxQ37Z6mrUw69n1v7T5f/qnHm0vuv3z/Q+NuBUubY04IIHSZTa2rN8h6Mi8MYKfvf+kLcI32CSoAng1V2cjN54sI9vBxzxAZA2rykzUh2bQ6NinLcjqRPdE3NEY0UbD1n3MEM2t5dOzj5MZMvuYKXobEfP6WxK6JACj4UVF7AQBcQuQ2Y0ZaqiQFqTaGGLJjCWRdxqY1MS9OIg==
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS7PR12MB8273.namprd12.prod.outlook.com (2603:10b6:8:ed::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Tue, 9 Apr 2024 07:24:52 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%4]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 07:24:52 +0000
Message-ID: <6a82ae98-b932-4028-a21e-5c08d1643a77@nvidia.com>
Date: Tue, 9 Apr 2024 08:24:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/273] 6.8.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240408125309.280181634@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0458.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::13) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS7PR12MB8273:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1uWLGmtIgFtf1YaCZrVR0CJ560ZeCIYX27DEdHqMMTh1M9++s0OG6dDz21RxT6cIfWqrqYAO86CnbiTZcXAKSZR25gwT3WeSIsjxai4WmSnHQgE3XdPIZCn3i1E1/k0tvP19ZEHg6ggQMHFf5vUqmy58U768IIh7ucq9+6CJXwrmR9bGkEgwafE0Pqe7tWZrp6It45faAYnUUUT+fxtfoQQYmaCnwbJ3vkbDsMQNzaDWiNyCgNn6d0wwSvkrwEVInw6Ea3d4+FOBk3XR3ARmgGIy1jf+3nUTCnq3iK62ehIKOuU2BTJEaXL7ZRHzYhkKHryPG1/pv3J57CMkSyqGhzY/dRZtIUr/LfkF7aSuiksQ6OC2kmbJ1aXEryyiGJQH/UIhnZXZdIi5jk5cuazNDa60DCTlKlAEKVwD/CA94NB21jrSKFZabe7/ihrYt1MHpaAls7q53kNvFxP7GcyIBy/4QQDffLxEpwi27rd1hUEND4X0b3e1w83qrUAM7im0x2nVCtGefyGvfYnGia3wZlBP+K+nW9o7IVF3YQbkGRcfWPzABw02sy5qMEDe+DXLvoGTrjWLl0BNt5xku+e6G01/CKx4qQy+ax+TzrQDY2YrQCUuLKY+G4bkcmVwwYyaMsYe3tuhWb2FSl90K2U6rC9AbiGpyGjUyHstxUfUzQE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVZYOXk5dnlXRWdDSE56dVdGK2d5V1FFU2c0M1A1Z3RBcU5adm9oa3MxRDdV?=
 =?utf-8?B?M3RwdlVzeHYwOW5JWUY2RmRYUThYVE5mQW9tZzNJQXFmYi91VkhtSm9WcHJN?=
 =?utf-8?B?a1BlWGM5ekxUdXBDMGY1bEorMUxuNy9kRFBvTFM4NFhBOE5QY1lxamN6TjRZ?=
 =?utf-8?B?aVR4UkFZdEtVTnVldHphdXJlSXBuVXRiKzBqVnVFaTIwVkFhbmQ0QTVKdUJt?=
 =?utf-8?B?T29FWXlaQkltYk1uOTZnUXhoRjkwZTFiVzNFUytWdko2N3l6Q0tmNlNhczkr?=
 =?utf-8?B?Tll3czRsNmxyemt3aTdyd2Z2MmFlbXhLckp5YjYybXlpV2JBcVNtOXdDdXFY?=
 =?utf-8?B?TThlWFVhL3FxTTR6UW9ZRjk0b1BSL3BUbThybEMreWhJWU5RUW82WTJzR2Nt?=
 =?utf-8?B?MlErTHloRzFLaDRoSjdNYUNOWnM2R2x0SFBRUFZneWhyUFRqMXhkZFRqSjVR?=
 =?utf-8?B?a0xGSDhvalZ4VGtZOWpaQ0RFNVRVbUt3bVVkdUVzVjVmN0lpSVVHRzR2Vm5E?=
 =?utf-8?B?ZTIweFUybitwZk9hVW5UZDF2R1dEOG0zOWVNU1V4enBXMEdFRDJqSExyT1lC?=
 =?utf-8?B?enROdjhGMXIwaGtxOExMV3VaNHo5R2F5VFQ0NHYzdWtxbVlWL2crY2tmNENl?=
 =?utf-8?B?c1A0Y2RUVThUcEovOFR2Qnc2OW91NUxhUDZJdzYvcFQ4MDFHazJrMlJWREdI?=
 =?utf-8?B?SU9xSUplQzdqdG5zQmRFZEN0NmU0c285RXErOC9uc0htYUljVlR4RE5GT25H?=
 =?utf-8?B?U2QwdjRTL2l0R3dYbjdKc3pSelBwcnNtYzQ5WU9oQ3d5MHByV2xlaWNMSXBD?=
 =?utf-8?B?MU50MzlpZ0lqbDAvZnVKU3JsZ3poUEkySm4wVHBadWU0bGQ5dG0rTEFtaXhC?=
 =?utf-8?B?WUdCMlAxWmtqVU9WajV6UGdnbHMxRHNvbE5aMXhFVjVRQUJqaE1SS0pHMzBi?=
 =?utf-8?B?NUhtZW5vcjdKTzREVTZVNDBvbjM0SWt3WEhpeEdlM0JOT1JzMWhmWGdVSlhq?=
 =?utf-8?B?dUdxRkJoTVVrakh5dndBdzMxMUw3TWw5aUpDVDZhYnYzWDVJVzBRcEpzaE82?=
 =?utf-8?B?d2tQaFdoaTdpaE14T09zQ1V6VStWNTd1R1BuVU1IUG1KenZEVHF3K0Z6dWt3?=
 =?utf-8?B?RDhzSmtHakhzOUVpU0pWb2VJOVk5dzM4aXJSNFdnakZoT2lLSWtsblJvVUh5?=
 =?utf-8?B?d1NyVGpDTEpKUGw0WHcrRkYyZDNOaWY2blQzN3p2V2xOS3dUb3l2K0VsL01m?=
 =?utf-8?B?QithTmxEWTNXUmNjS2c3NUZ6MTVGV2hseEd6bUxyRHNmdlFCN044WHFMUWNt?=
 =?utf-8?B?bVlQUXhXd0FvRXY1MUNhaFc5cEhkbXpTbi9KZm04K25XWjR2OHQ2c2VWOGlY?=
 =?utf-8?B?dXlwM09tTUtlMlptMUEwZTZodGgvZGt6NzM1aEk3YlYvTlgxR2phNDd2WWhQ?=
 =?utf-8?B?RE5SODdJMjdJVUQ4RU9IN2Y4b2krWUZsR1JDcXQ2cUpIL2h6STk3S0VKZW1Y?=
 =?utf-8?B?N2tBZzdGcmJWTTNoeVJwY3dSQnV6VTdmU3duYlkzK3ZpeGhpZGY1c3F1QTdx?=
 =?utf-8?B?R016b3BCa1RMNDF0a3ZpL21aN0o1VmpzZ1FMNlNKYzEvbThIZnk4bFMwc2Fl?=
 =?utf-8?B?WUJ5RWFFRDF3SWNyUTJHV3krV1BFYjM1SCs1ZVY4U0tvRkw3RU5TQ0hZOTZo?=
 =?utf-8?B?VW91dE82a29mV3hvckFGSy9BM0dSTGkwT09IQUdEL2ZZVGYwTWsyNUdPTHBh?=
 =?utf-8?B?aHRQQkZoZWZZOExQUkpmdnpFZkppQXRvenNxZXdlZzBXVkhCVUlZbWNvSGNJ?=
 =?utf-8?B?N3A1M2YvV2RKY1VlUDY2Q3BCZkRjN3I1NFpreFRWSVlEY1RzejlNYVFYL0xt?=
 =?utf-8?B?ZkRuaWxBQ3RWbkZOUHJ5QlNiWXhpd0Z5N2xhdlJDN2FQZC9YYlZqSjFIUEtu?=
 =?utf-8?B?N1BOczRxbHY3VHVkTUZrYlNPRDRCQmQ1aC9kd29KVVR0U1lWRzFRWXZSTmlz?=
 =?utf-8?B?R3RYVXo1dnZUdElxd2pOaXh4UFJ5U3NVZG9MSEJXbUN2VVcyVUV4d2x2ZFR1?=
 =?utf-8?B?VERDM0gvM2tFT1RSRXZXRFBhSXVZOUgxOE9od2xMbDVpU0tJaU5PenlwSmQz?=
 =?utf-8?B?Vjg1cEQ2cDBrMHB3TnpWenBiYVVDczRNV1QwcTZtdXhGK1JoTzVqYktzOTIv?=
 =?utf-8?B?STJoZ3VqVXYvMmpHejRGT3Z5aG9KZjRSTnRJOVlpMHVKTmhUZG4wL3NraXk3?=
 =?utf-8?B?eXJ4VmRaMnl0RFdtNVNtc0VvcDVRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96fa8e8-1f1b-4928-9760-08dc586625d2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 07:24:52.6430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nR4mS2jckhaGmEJQLhIfjB/Itg6kU088EWRuFe4V4/VSLFYoQSZZ/51InhRsngeXRVm9kFkbgKNN5AIYeK6eaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8273


On 08/04/2024 13:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.5 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.5-rc1.gz
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

Linux version:	6.8.5-rc1-g51d60edf2813
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra194-p2972-0000: boot.py

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

