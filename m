Return-Path: <linux-kernel+bounces-52704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D766C849B9F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D519EB223CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B4E1CD0B;
	Mon,  5 Feb 2024 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dm49UxBT"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354B21CAA4;
	Mon,  5 Feb 2024 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139199; cv=fail; b=OH6jcQSjSHYmuC5yNbGe/EejxdoA0VyXzzykvctWmEnjhRAGKt2SFLbucoFxerB0kfa5RQchtkK1XPZo5VPyAMfnTmFHVsu26oTRp+cNn9A/Cg5s3xT3sHV+gfaQZeg6bb0lu5Q5rgkiPWExmI7ZxErFZYIDwY/u5GZJ5lNL2+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139199; c=relaxed/simple;
	bh=4UCTnmxqHb9ZTS0ydtBLgju+iOfYCDkvKXLSZ52ZGP0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HtaUC7uYtdZN4USJ3yV/jmgr49JyBPGkwpM8GccrwKUZR0VXlX+2LfY4ybv/dne7wAWKaxQhWgyo7O5ra9s8RoZaeZ6OkaGcVITR89xfexjHc/A7Qn1wj3Cl4kEppbZavzdquVTZi2qOzBZNXT6LxqH4olAp+4HpCUW/yin4QQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dm49UxBT; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHctqg+Fo/Z/mzZpnZ9Z91oAINiDXEGiXbLF5AI+etDlSs1/uVuv6+Vfy3PywC+5i8NLV9JgtA0lfJAAFNGhq73pKkcDyn0u08HfKFK8xtqj7e6+YkWHvPlgZQ/kgIF/GQ3I+aa1E5pX9253KnRnbiDdwNCe1IBE9T8SQzPTrToh75jXWw8w91UAHsQN5VK0b96Lk4WNEQ3jhHVMAtjzOIlyzeLkebGg+FNfzsfaWm5yVZsNxVZYuMKtjkML4jJWGA+Z87kLxVCIjQS9aDz25EskfI2Lrq9R0j6MctdEmMa+VcxkGXPVckii7oEBPdKwv7AyBpP9A+mIa9OcGbSy4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64yGsRHIFi5Suz5k0K4nR4P3UJyH8zwe61DKuRrTS64=;
 b=YqK0ihoGk0Gr5Iqh1Ur5E4QsA+Ma+e9E+VDR0aC7lgec+L7rnGR8KnyqSxkVKPozyblXPwX47QDkrsurakAPmThlp5i4bVazOifupOHXA1iXNoMLu/plLyh+6VkCdSSEx2l9tGLlErkjG5SUQCp3y479hlEK8bbgcCY03nNkaeNAVOUPvhj/+9GcE/A2R3RUPaWpdpFT+GUU4ltb5EZgaPl+19+7aE44olu3Lg9QBnnL/hOMxbJFT7l+vZM5dp/tjqnoqvkyNNXVrn8wHuI+RAU0jKm5Nl+/MR8MsQObIDxdlJV8WQ4hzI1JRaz1e9IHsy7ey53k3c2jT5PNHUUrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64yGsRHIFi5Suz5k0K4nR4P3UJyH8zwe61DKuRrTS64=;
 b=Dm49UxBTTWxQKzt1OxpRCofO6wST5/ohPgC0aLxYMbKVQdz1/oaEwfTLa+Q2guNDtu0aD405L7lvWyF6dtRylF8cUG44K/fCymTmG87hhHID7nzmXv2AXm3DwyA0mamAaSEEbeMU+JJ7UmmK0HuhclJoLOLDSQdQe71enRIZBl/WmCFDEIy0tkEoiZBfJ2ouGBW3cfNC3SZAGpUmwQKqRiPnx0zQ3dN5kQEJCyLpCiGC1VMS4BQKWoPrwHQRciucPgXLPQv1m9YQuNUV4J0hgd8O3VoemmykkMIoO6mfTN97JyVx2IdDuW0/ZEBbL0B8EYoUUEdlA58KyaU4unCj2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH3PR12MB9169.namprd12.prod.outlook.com (2603:10b6:610:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Mon, 5 Feb
 2024 13:19:53 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe%3]) with mapi id 15.20.7270.016; Mon, 5 Feb 2024
 13:19:52 +0000
Message-ID: <b3ecc962-a549-45d0-bcf3-c55f3a5c176a@nvidia.com>
Date: Mon, 5 Feb 2024 13:19:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/219] 6.1.77-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240203035317.354186483@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240203035317.354186483@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0323.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::23) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH3PR12MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: f4bddf56-f35b-4d63-abce-08dc264d22c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vL0GYsoB6WDjBCt7aQlXyoEPAiVKux1id6I3gcrTqtPKpgS/tb3cPLdW74JrL1F3yS9cUVatuGHUS0XH2znZRDckqHYHjEGq2RKyG6K2jOvSrAx0qS/sDWB/4H9rxqwkbpz+GEUriEnBlDnNeaI5Ivz9m6Y7rtPWGeQBqvYsHDE5WjUIaQMIPWyPzvfv+xLK4fBln0aMb92nfbV858l7EbeF8MB4suDo2S3FIggYQg/NhzRY77ymgW8KM0Gj7sKxo6kdtxXWQbDlXOdfyhh2Wu9d49raNwGwhWUAWuHPwV6OWuNATSxBGXZF4hp3W5IOhu88kaV2Cr5pv6Q9QlUNvP0AQ1CTXZd1eg9dmaPYqFApblXh3vDoFmwlxmSlGjZD6tbL02r/VQEgdnYrRJvZfWEtMUwH2mh17w6xdpMKMtA97LN4XWV/rHVsM1UjoaVUHpuOsn7uBBqAWVjcKFe1mAipIfrhAxKkHN/HfYa919Shs3LC9cU3WCt45CpcAYmrxS/aL8gHZvZr9IlAgkOuz2GMeNHJHB8GLAEFetGdLQikeWOklaIlD/+PAM6BOxJe6Im7KXv5M1W8l75EkYuI/nb4/Ny+8nBsnwoX5PcgZlD7cXu+SwRuUM+LFWXqRZLss6d12deaHExbp3ZFYUQIOAMPeGmUggU79tgiwAMCcHzXovskuLbFuzjyGQny0I+i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(136003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(2616005)(6512007)(86362001)(6506007)(31696002)(478600001)(966005)(53546011)(6486002)(66946007)(66556008)(66476007)(8676002)(4326008)(8936002)(316002)(31686004)(6666004)(38100700002)(36756003)(41300700001)(2906002)(7416002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVBPOVB1dTMvdEZ3MDdOTmF6ZFVhcFdJL0hCOGRlM1Urd3Z6MHVxTWtxdmFZ?=
 =?utf-8?B?U3ZWVTBJdjdwZS8wMi9RbDRtQkw4OWtvSjF1cHREbXhPbllIeXo2akF2MUVo?=
 =?utf-8?B?cHdrSXVTM3ltV3dybkhFTHJVSGJHTEJoQUIxZ2hkbW1Pa2IzRGl3QXR0Y1pk?=
 =?utf-8?B?Z21YVnBBc3l2MFhCTk52Y1pSNFZwNWR1TzlJOGQ1MHZVeWdyQnZrNjBtNEFj?=
 =?utf-8?B?LzNEdFM5ZUhBSGNDdzliNjBjM1Q5MEN4NjhEKyswR0IyZGlsZWxLdXVqNXlK?=
 =?utf-8?B?YUlWNDg1UTBLMXVMODUxZ3VQRGYzRE1iK3RwNkdQdlNydVUraVEyVmhJbGZz?=
 =?utf-8?B?TVNGTTJPUGhLV0EzWFlvUjFkWDNtUFJLbDYrMjQ0WnBLYmVvSXNnTVh5UXUw?=
 =?utf-8?B?WWRUM29KZ2JlU3lJZXhIQ2hEUEFnMXVSRW9GYmwvMDVvek9ueGV0aEVxa2RK?=
 =?utf-8?B?VkZBeDEzZE5DbnBsWjMwNDczTEphUStXcjI1UWFvVzh1K0RZTTBueFpGTHBK?=
 =?utf-8?B?bmJHa1NyalU5Nm11d1YyVmVWaGpxRUhEVjJhMXc0RVZZQjlxbEpnWnRyOGJq?=
 =?utf-8?B?YmF5K21hMTU1NDBtWGNMZXVQbkRsaVQxRkJabm9KMjNXL2hldXp4cWdqeGZm?=
 =?utf-8?B?VTZsQ25kRXR6cWNzOFNaamhOODBiYkZETlZXSjRkMUxJNExLV0IzQzRQVzIy?=
 =?utf-8?B?Rjh3ZjFIa2k4eXAxQSt1V3B3NVowdjB0bHpvL2w5YmFjTmhLdURmcU1HQytI?=
 =?utf-8?B?TG4zaENORitVZENLZmFnUHVPN1hUcXFsK1o3cXh2Y3NLWnZycDFLZ3prWldX?=
 =?utf-8?B?TDd6eXpJbVFzT044bEFzZkRQUVBXdVgwOW4rYUh5d1NWUlhkem9oTWhLdTJU?=
 =?utf-8?B?eFQ5ZndXV3ZoRVdmNzFBb1hOeEsxMS9QOEtYdURBUkY4Z0lJSi9oUTNQWUht?=
 =?utf-8?B?MFpaRnd5OWs1Y0NrbWVUS1FEYWczWllHT1o2R05IZHEzaHRLeDBFVk9NNS9Y?=
 =?utf-8?B?djJyVDVaeDljWVhwV1ZsM3ZOcEVXRUFFclhXdlhrOEgvVlhuRU9KWStXQkZU?=
 =?utf-8?B?K1BTQUZ5eDlxNVNoVU5pbmd6dDN1R0VobHNGaldvbnhITE1PcCsvTHppa3dV?=
 =?utf-8?B?MHNMS0FZZzFybENHSFJFMWoxUHJwY05mcDViY2lHODBJd1gwQU5BTDdPRnRj?=
 =?utf-8?B?d3AzWW9nWldKZXU5bXVibWlqbjUyQnR5eU1OQ0MzWnIvR1V3YWJNRUhhRDlF?=
 =?utf-8?B?YzcrRjY3SmdrY1NOaXUzdFh0dXBtbUwyblJWRHhkZlNpakg1RHJ2UGtuQjM1?=
 =?utf-8?B?NzRIcnViQ3JzalVkODJ4bjhNTTFXV0pTM05VOU1mcG5hcW9ET2V0UFhnTmZ0?=
 =?utf-8?B?dVh3OW1yaDkzTHR1L1lhZzdjcGwvYmVnd3VNQmlxZTVlbUltcjlFOHgxbzdS?=
 =?utf-8?B?VjdKdmtnUFpVSFRMcE1KMUJNWWNMeUJXZGRPVDN3VXN1U2RMUTRMNlJWUmdI?=
 =?utf-8?B?OFByQk1GNlFmNHB0aG52dm5VY3h4SXJYMlgyTXVZdmxvazhSZmFmMFdiOG9T?=
 =?utf-8?B?Q29iWlo0N2I1SzY3MGN3bC8wOVVMT3JuZnh0V0lrNlNGWUw3VXZlc1FwTENH?=
 =?utf-8?B?MXl2Q0I0NE1GamJWV3FBQkZGdE45MURqS2t5eGFNTzZqNGw4a01ONVhCUGRq?=
 =?utf-8?B?VnlML2kxSlVnck43WGpiZWplUmVMQXV2eHRWWXd0QXlSOGExYkxTc0hIVld6?=
 =?utf-8?B?T1BzazhQYnc5WitrUFpqUnByV3JFOERXYUQ3YituR1pSSWc0QndzeExvOC9Y?=
 =?utf-8?B?VDV5N05vN0RiaGREUEYvbmdDMFA0aStURmlHWnlRRWU5c05yQXgxaVEyb3dx?=
 =?utf-8?B?N3RHa0EwYzUwbEZML0tQbnJDU2pNZzV3RkhMRXVqWDRtNGxTUElRWVhUZFhm?=
 =?utf-8?B?TjR1TU1tajA2YkdqS3gwQml0MnBTbyt1TUp4N2ZSdlBOVk9CRkhMcWxIRGc0?=
 =?utf-8?B?OG92VWNxRE1Hc1V6N2JzRXUzWGtoSDh6ZVpqdkM4d1I3N2JYbnVMdGlSOFJD?=
 =?utf-8?B?VXBLU3FyYnBIcjJiOE1PY1NKc1RhSUN2NFlXWjAwMmdnU0JFRWNZN0ZTVnZa?=
 =?utf-8?B?NHFNVVBlRzRKWHdXZDRkMi96Z0daUy9uYjBJSmVieXZHVlZIekpteWM1dk96?=
 =?utf-8?Q?lkefBNDlka+VVSIF5pXFpTNgwoCWRKl5q1AWYu8UREgm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bddf56-f35b-4d63-abce-08dc264d22c8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 13:19:52.3115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQffoIxIaTe2cXZz3/M5e01y5b7bDDqKjMkYvjouGrfY0FUqv2kbGOnouy1bZssxEkeadJiDgwB/h5z8VVlXQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9169


On 03/02/2024 04:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.77 release.
> There are 219 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 05 Feb 2024 03:51:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.77-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

Linux version:	6.7.4-rc2-g10be46ba2b8a
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra186-p2771-0000: pm-system-suspend.sh

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

