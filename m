Return-Path: <linux-kernel+bounces-37600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2AC83B260
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B031C2234A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CBD132C36;
	Wed, 24 Jan 2024 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tMmKTfU0"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3FC132C28;
	Wed, 24 Jan 2024 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125150; cv=fail; b=P3Qe5ca9LJcbmuW4TJVaiY+SajtGGTywC//z5tmPo3oZzmUSOpoVPz4LaV/f8QqO5d3nKLYxZQKAdi3fQilGJ1267P8doYDt2cAi9tQG35xUtz8oLQkOAG6ekYFLDRdCuXe1FMMTBQSIbUA4g4/RpFX4mOrR+6Uf/dcTMyahSCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125150; c=relaxed/simple;
	bh=m90fzYhGMJvgBO9cilCKFSC5SXAb6mjZWB6mRI+MO8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SzngcB4plIOUpo3vTZxCPXmtotHIRNvachxT4WMaxmU5o6150BBOLK1nGD/S/F7Mvsrouwyj+NHJuaKlgRLO6A062b6tD4gTXg/GIQxckCaq6G9/U6VyzfrTWbY1ERep3JPQuFy3g/0OFSG0volCKOaqgqvdJCAqmh2tvTPaLHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tMmKTfU0; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c14lR/H+FygyPMnGHo/Gyd+pIhV+mfyyJCF9orrS44nxBPVwmU4B4RZHJxsjIyIHtBMONWi3qyMz4gT2MButsTqzexMWyuzrhNL0n/AqAXp46Xo05SCAdv+a7L/dja8TMrJqenAMpbXQpJWw2dtuawY6k/KIwc4Ae9iTesCxce7gAyNZgiVOVkJdeZYwnC/E4si4dsTa59ZqDMb7DJFbI1BKjm5K7yQ5P4Vjt9HqzeM8Py2gFDhgfqR1RtI16zPzXeRmPJGIIR8TKhCsBYBMIo345Sqv864v8fODT19ACaSWUBUf82zoepTiPe0jwDwuVXLK8NP84xpdkQoghc83nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEoMSKKbjlxkWAEueEJDHtBF3mfu9+iiuOxx8vtr/4o=;
 b=OKqCH8huYE7w3Stu3HTt76Y8NKGwx7nllkZRHCn00JY1EondX3OBrqkEE8VKEmpEos+SWeQgt/AKFbPAXabJ/adE/+YF5aujyk0W18qvbl+TvqWxj+Hzj4c/SRg4Vmk65AQI7hCguFZH38W1wzkf60QejCubjo1XfLTw4ZNlOUHqTnzaESpEoK95vvauH0M5f20yGDm/bIRIE0vZWuUzyFhZFDPVMMqklq95h3Bw/toKPa8bMFUmgb5cuX39UZTRLHHqv2vKA8KNkNpKjrJ9kYymuD/qtTJX3IrK9yTVD6iTdv0peiAQHOYi3apI5Twt1V5jAc2taifw+6vRTP2JCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEoMSKKbjlxkWAEueEJDHtBF3mfu9+iiuOxx8vtr/4o=;
 b=tMmKTfU0D//CcuHOh7oO6mNN+xfkKuIstcdN1FWe4qYSiBv4pinuWar4lvrURQt1ORJmRDyh6TtvqGax31K+CYaVdQqyqg1C9WJxa0aa9ubwp7/+doV6qgJOOG70f8safJQefSD4Y/AsCM0w8OleTzMncW+JsoYc09CcKANfmoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 19:39:05 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 19:39:05 +0000
Message-ID: <eadee6af-f8d3-4ede-915c-f3dc3d166068@amd.com>
Date: Wed, 24 Jan 2024 13:39:01 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH] x86/resctrl: Fix unneeded variable warning reported by
 kernel test robot
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com
References: <202401241810.jbd8Ipa1-lkp@intel.com>
 <84128a3c83654493f637b8349153af10d69e2752.1706118776.git.babu.moger@amd.com>
 <39c4501e-4937-49de-b12b-742e6201df6f@intel.com>
 <20240124183153.GFZbFXmTKTLEpwZshW@fat_crate.local>
 <e96df7ac-f0b4-4300-8546-7c1df836dea2@intel.com>
 <20240124191429.GGZbFhldYr3K85H9cg@fat_crate.local>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20240124191429.GGZbFhldYr3K85H9cg@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:806:a7::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: f223e09f-5425-474d-4042-08dc1d141ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PoT2gR3EpvrIlOpgjqXVDh6RJjXhtfIj5Yt0ooI4BMeM4TAGtyyVkAdFLzMTFWkbmAzjk6ms+82EQNJXmVNiX/W1w/Of/ITH+Rr6w8Ed48iVTEhFaNh0AD2/BEeyGG/JzNQHdWZUOx1/hAEQM10aJFqxScJtm1++f1V2vmS60hdsUMZr3eU9Ed9N2+Aj2hd7ObPOXhemImqEoOyDm+3juBaOpZ/sf/rEF/XqtH/9n3BiE7sZzgfCRaLRN0XHOXQV3+cHTZo44ohOPvW02OucJ517x3/5sRGG0Bqe3YoVJpLDA3ThFZ7xST8m3vYwqyKy3Z3iFyFZKy6RPRUyZiQ2611BFUTAXclfZtim7k+P/2CVFvwfc/48qcKzq6WWFt1RPxdjXO2EMjgDYYlfqoBekTFYYFxJxsuVQpg85BshhJ6/ilJMUoaU310dMIEYsqxdF/RkpdKnNEzF6c5yRvPnJB7elda0sHXIvZVLtYzqpQ4XjkKbt/dpA6EqfE8KoOOBtid/ncEuKxZiC7nCE1K8GNGhAQjjjHvKtjLWqpmNgUZ6WAK3mgVsbK200bpru8GNibMYl0TRSEjNRrTiMMj0nWpQduf1erDCpllMOIDsN8aY4fhvJfahF9XRQbEwh4y8kYwuTwmMwaQeOzeHgXKSIwFzGaPrjmJDAOgjyGvHW1nLj62iNJ3lyftmwXWvlfveVuDIOdxTPK/x0DAwVIo5PSRgmyq7nbvO9OCrwQQC2g4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(396003)(346002)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(31686004)(478600001)(6486002)(53546011)(966005)(36756003)(31696002)(86362001)(2616005)(26005)(83380400001)(7416002)(7406005)(2906002)(8676002)(5660300002)(316002)(6666004)(6512007)(6506007)(38100700002)(4326008)(3450700001)(110136005)(8936002)(41300700001)(66556008)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEh3N2lZOW5yQ2dKWUs3bHg0TUxvQURjYVNHYjUzNzdhT0JMbnlxUUpKSExQ?=
 =?utf-8?B?NS9JSUR3WkN4bkhaMTQvaFh1VksvYUpNMDFiSUtwV1AvK25JOEY3TGdKMS9Q?=
 =?utf-8?B?elkrS0ZVMytiaXMwbHBDbEpuWldTY1JCMm5ObXg0Z3JIR3BTcFRqcVBBb0Nx?=
 =?utf-8?B?eGFjZ25VZEd3ck95a2Qzai9uUHhnb2FIQlVjSEFnYnMrNldwdlppVGx0eTYw?=
 =?utf-8?B?ZUhtdXdqZlFHQWFrbXZNb3ZienJTZVdTZld4czdmV2N5bHUzRnJVT0pHUU41?=
 =?utf-8?B?eUhiK2lrWXAwbGNTL2krWDFUdzFTTUxBMHVDNW5TL28wb2p3Z29KR25KWnNY?=
 =?utf-8?B?RGQzaVZ0RTUrekhIdWNyc0lNc3BYR0N1Z00wMVBDNmtHQzVaYkZmeCtlNFpL?=
 =?utf-8?B?d1VKbHJqTkhaVTQrc2JxdGUwaUhQMlRsTGEwQnZXa05PWFZPdnJjNkpGRTZv?=
 =?utf-8?B?aWNWaklCWGxRMG05emZrcThBZ1JJdE91MExMeWFYQVJpaDMyWGhUWEZDbmZX?=
 =?utf-8?B?K3o1dHVjRTEwaGdab083THR4S2c1aGswRzR6YUM5YUFPSmFrSW5MU3d5TUlE?=
 =?utf-8?B?a29EdmpvSkNGWHpwa0ZJYlBabk9vd2FQUnhmL3o2TUFIZzJVTC9DdFUwNThn?=
 =?utf-8?B?cE4yK0o1bDlFd3ZaYmJablZQcU5CdHVYWDlSWWM1VVZnOHFHRDAyM3FRMXlN?=
 =?utf-8?B?RXllb2JsaXVNZEkyWW82dmNneUlZZWxzY01KRmRJcW5IcUdwbFo4TkxrODVh?=
 =?utf-8?B?RFB4Y1RxQzJ5ODRSbWxFeU83R3JGWlNRd2ppdkZiNVk2ejhpWVNHUTVrZDFp?=
 =?utf-8?B?NkFkeGpmUk5EM3p3Ky94WnU2RURjc3gvUFd3VE0yS25qY2RxMUhiMHFsWnJR?=
 =?utf-8?B?WHQrUXVRZFRrejFlM2l6QUV2WkhidW5vbEQrUHNad2pOaXg2aGduWjlPQVVH?=
 =?utf-8?B?bjVacDlMTXl5VTMyKzgwaVpXVjFmZWhmQ05kOW55bTJCSnI1a2N1ZVQ1eUds?=
 =?utf-8?B?M3hMVUt1VTVkaWdVQWV0b1l0MTlBOUdxQmtSa0FmZlI2alk0UTBGTllzRE9u?=
 =?utf-8?B?TzNWUXRNSXhLWXEvYlBGaFdGK29jQ2lnaUpiVnQvVm9XSDljZ1c5bEpFMk94?=
 =?utf-8?B?NEZ3Mmhhcm5ycGdMZVY4eVlKWUkzWm5LbitZQUFRMUVJbWNZWFFPRWtpMlMv?=
 =?utf-8?B?Qld2NCtzN3dPaE9FTTlMUXVlQmJNTTJzRGJ6SFBPOTlYZjJoVzROQXMxQUly?=
 =?utf-8?B?Qm9mYVdxMGg0T0k5dGNRcjluZEVhTGdyUlBuTG5QZDBXNnZwY2szdlkyNEVF?=
 =?utf-8?B?SzRMaTJ2bG1wR2ZONXpSdEZmMmFON1laNlZ0YTYwTGpBeWdDdm1rWjgvWFVP?=
 =?utf-8?B?NmhXaUlmejJia0l0SjdmQ0RNWGJqV1R4STZPM3hEMkV2akZHMWlKQlRJTWE0?=
 =?utf-8?B?aEplNEhPWlFYZkE2QzRiNTRnQkNnMEsxWlBrQTBTeWJvNmM0V0pBUGRHV1Uz?=
 =?utf-8?B?Y2pLd29Ha1ZFUUZIck0vS0pLYUE0M1E2ZUxCQUZrNTZHbitXcVY1T05GS0du?=
 =?utf-8?B?K2t2SWw3emdZbmVWRG1FOElad0NBcjlwWGN3UTBwYlA5WVZWeGJlcEpJaHcw?=
 =?utf-8?B?am9TY0NoaTZWcUtIUzlYWXllSzZRQ1M1c204SEZFNmkva0taczlDSkZmUnB0?=
 =?utf-8?B?bjJZMDlCN2hvUDB1c050dXVOUFdtODNPdXhTOXZySjdQRDdSMUlMbDZnZWpT?=
 =?utf-8?B?NUN2VXNLY1NoL3BhVkQwSVI1RU1CUEVoS2Ryc1F2Y0hHY1hCWU5KV3lXbDVG?=
 =?utf-8?B?UnVjbFMvYTY3VEcrMTZiY01vUlQrM2VNTm9MNGdOeG54MERmTW9rTGJHRjJS?=
 =?utf-8?B?eWV0eGJGcExTekdrUmhNb3lZUjJSNVlDdVNsVVhXSm5UdktmemhrZCs5bFd4?=
 =?utf-8?B?Y0R0WThFZS9uK0Uwdk8rL3g3ajFVR2h6MnBOZ2NrOTl6bFFTTnlIdGxFRkJk?=
 =?utf-8?B?OVB3VlhYMzQ0Sk9qa3pOY2UzZzZFV1JncXNRVW9zMzNnSXpkaVg0dzVSSWYv?=
 =?utf-8?B?WnVLZ3lYM2hzVWgvK25mN2xOY2FNSmtid2JkRlZtWllDZ25kUWN2bmZOZ20r?=
 =?utf-8?Q?0VJs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f223e09f-5425-474d-4042-08dc1d141ff7
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 19:39:05.5123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8cTC5epeNNRIH31GuU8tIhdmf2OaICVMXHC6xdQdKaNKenECuNJX5C2YnmeSJXx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272

Hi Boris,

On 1/24/24 13:14, Borislav Petkov wrote:
> On Wed, Jan 24, 2024 at 10:51:49AM -0800, Reinette Chatre wrote:
>> Thank you very much. For what it is worth, I do agree with the actual fix
>> and you can add:
>> Acked-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> Ok, have a look at the below, pls, and lemme know if that's ok too.
> 
> mbm_config_write_domain() only returns 0 so it can be void. So the
> callsite doesn't need to check retval either.

Yes. Looks good. Compile tested also. Thanks

> 
> Thx.
> 
> ---
> From: Babu Moger <babu.moger@amd.com>
> Date: Wed, 24 Jan 2024 11:52:56 -0600
> Subject: [PATCH] x86/resctrl: Remove redundant variable in
>  mbm_config_write_domain()
> 
> The kernel test robot reported the following warning after
> 
>   54e35eb8611c ("x86/resctrl: Read supported bandwidth sources from CPUID").
> 
> even though the issue is present even in the original patch which added
> this function
> 
>   92bd5a139033 ("x86/resctrl: Add interface to write mbm_total_bytes_config")
> 
>   $ make C=1 CHECK=scripts/coccicheck arch/x86/kernel/cpu/resctrl/rdtgroup.o
>   ...
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1621:5-8: Unneeded variable: "ret". Return "0" on line 1655
> 
> Remove the local variable 'ret'.
> 
>   [ bp: Massage commit message, make mbm_config_write_domain() void. ]
> 
> Fixes: 92bd5a139033 ("x86/resctrl: Add interface to write mbm_total_bytes_config")
> Closes: https://lore.kernel.org/oe-kbuild-all/202401241810.jbd8Ipa1-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Acked-by: Reinette Chatre <reinette.chatre@intel.com>
> Link: https://lore.kernel.org/r/202401241810.jbd8Ipa1-lkp@intel.com
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 2b69e560b05f..c33eb77b6d70 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1614,11 +1614,10 @@ static void mon_event_config_write(void *info)
>  	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
>  }
>  
> -static int mbm_config_write_domain(struct rdt_resource *r,
> +static void mbm_config_write_domain(struct rdt_resource *r,
>  				   struct rdt_domain *d, u32 evtid, u32 val)
>  {
>  	struct mon_config_info mon_info = {0};
> -	int ret = 0;
>  
>  	/*
>  	 * Read the current config value first. If both are the same then
> @@ -1627,7 +1626,7 @@ static int mbm_config_write_domain(struct rdt_resource *r,
>  	mon_info.evtid = evtid;
>  	mondata_config_read(d, &mon_info);
>  	if (mon_info.mon_config == val)
> -		goto out;
> +		return;
>  
>  	mon_info.mon_config = val;
>  
> @@ -1650,9 +1649,6 @@ static int mbm_config_write_domain(struct rdt_resource *r,
>  	 * mbm_local and mbm_total counts for all the RMIDs.
>  	 */
>  	resctrl_arch_reset_rmid_all(r, d);
> -
> -out:
> -	return ret;
>  }
>  
>  static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
> @@ -1661,7 +1657,6 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
>  	char *dom_str = NULL, *id_str;
>  	unsigned long dom_id, val;
>  	struct rdt_domain *d;
> -	int ret = 0;
>  
>  next:
>  	if (!tok || tok[0] == '\0')
> @@ -1690,9 +1685,7 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
>  
>  	list_for_each_entry(d, &r->domains, list) {
>  		if (d->id == dom_id) {
> -			ret = mbm_config_write_domain(r, d, evtid, val);
> -			if (ret)
> -				return -EINVAL;
> +			mbm_config_write_domain(r, d, evtid, val);
>  			goto next;
>  		}
>  	}

-- 
Thanks
Babu Moger

