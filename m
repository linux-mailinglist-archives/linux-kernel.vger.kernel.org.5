Return-Path: <linux-kernel+bounces-59537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9C384F88D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6524BB24BE0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D59762C9;
	Fri,  9 Feb 2024 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tNmI780s"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D0C74E09;
	Fri,  9 Feb 2024 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492547; cv=fail; b=ZR07pwJwKWEr2SQiJBMbh34IgF8fqmh/4bz5p7t/w8Cld0i3GW3LaRDLWdDeRaLWkkZ8jZmGKijDPAhxrX3n5lwjy0cC1g/y4yEC1cDgCFmQdA0v3qxMkTHnuHd0rsB+1/0QqXv2DQmh8PWISWt+np0qgmgtucgNOjjyZ5deWXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492547; c=relaxed/simple;
	bh=d49U25vPSnUCH31mc1TZJ6uye+iGUQZhqif7qX03xXE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a9iXJTvoTSHZS7RmePujU/hBOzdgm+5I162tDKRubwujUdkKjoMyif8sMgPRaybE5sldZVOD28Ol+dHsHZAjNokc6Mr2TTNFNQCp0AbgZXctMaiqWSjBzFQ8wUY0X/x7hcYbFnfxRXK/cL5HPX9HhI5ZPhsSGm8ZggmRhvIev9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tNmI780s; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOhhgWmx/UC1RJudtmi2iSZ5j28JLkjqmsgG5U5MCdSOgOWJD6A5KQffGnV0e9nC0p4jzNB+AZSl31l8AkGosTu31ztSG07VmkdM3GA53uT9Och+IRtu5JpZcKsRQ+UaFpGwdNW/UoDIAwTtxBg/AZrVf6YHxUyyvV+DEqqnPqU+Ox5sa81eW7IOzHtJwrieTv5i7Dfz+T3m7ROVS0py2tO+gJHgKLm0ytU27q9dpp8pu8MRt2XvurXEuI8wq7xptWOwKJIhEZ/QLwVSWUOtMiUKTnzIPcYcd7rrpHhJKedFxCtRYFpTlEzUcQhwpU0/+MntuKplJfhPGVP9WNzZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6u89fmYJdfAGnH/CLtCtE2Q1rO3R8Korz9HWipID59U=;
 b=X/lLUho4oVLDhziBLg3eLjXKdJvwg3VJ1eJyWTqYvQFP3PMyMrXD0CUE27jd4NKwESuM4GokDsdnCEVRzc9W00sCqB2/y4Hq5iWdIBdHiWVhkZxdHAufRK+YHnpel8ZO7qCJYX+chqIi8PGgPW27hK3uV0eoa99AdnwyATE+aFE5Rm8vApz+VDaal7IeYFYyZOapKSJEPFUBYgPXDkyAfn6ZLtxylITxXdNsSNvzutgGXYda7AVUMkeckivQF6LOIFv1qntrFox/HZifafGjbtVmX6GCfiPUvSAd2ag9sSmvGFpNxbTjzdcjj0g4iLilYPjEG5O3GRkMpByZgc/Fcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6u89fmYJdfAGnH/CLtCtE2Q1rO3R8Korz9HWipID59U=;
 b=tNmI780shwxUlwfCvcWWMQAnRqWeYq0vaOL5daXUI+XZIVgXsoAfH3BSVC9DAqDV7luJS7QXHlR0Wddqlm8g9w9uAug7KhTqmAaW2EPMNpbazznUiKEyGt7WMdm+s7m0DpkO2OGEs8kY4K/ZZjRceE5ORMIBn/37SjzmumVlJ7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Fri, 9 Feb
 2024 15:29:05 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%7]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 15:29:04 +0000
Message-ID: <6628954f-c7e9-4040-9f03-7b5b6a6d082d@amd.com>
Date: Fri, 9 Feb 2024 09:29:03 -0600
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v15-RFC 5/8] x86/resctrl: Add "NODE" as an option for
 resource scope
Reply-To: babu.moger@amd.com
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
 <james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>,
 Randy Dunlap <rdunlap@infradead.org>, Drew Fustini <dfustini@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 patches@lists.linux.dev
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <20240130222034.37181-6-tony.luck@intel.com>
Content-Language: en-US
In-Reply-To: <20240130222034.37181-6-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:8:54::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec475d3-da0d-412f-1232-08dc2983d99c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n/uK5iKOT4TTOHi2vu2GFiOJLeUXiTWn3+YHUAIymJTiopIdKIXP84b7EVjLxqIjzB0FvBiT0njVv8HyFuqRMmdOR/C6fg4C/44AgkA2xQ+wzhThfu2TiMx7rHya6hYafWXR1j9wutgseJM+HV7LZw+E6lvEw9hojL6iG7+VjmuPt4L+2pCPRvRwrFR8g4wqEbJcVVFMhSnaXTUgKGpE1D570QUACCupnyMjkVAD0ZHtFe2elxL0KyHpRhUEyQKEqCL1CSH5qraUwxxw3mper3rG3lnncRbEDYNkWrIty9/NPfvasNY8+XeMqamu3Bk0Ls5js6+GN55pKeg98K6OLpP0eksxeGW8n9T/d3TbOfp3ux17DXQY+bUxbNgMVsRRFuSK762A1eRSp3TatUPB6XS+tPTQp5Yq9MyD4uFUVHsVVRlkM1vIq2p+p3OTlMZDM+mUHYxZqmIl+pWA3+Uwbuqw82T/IvrgIWawxFCu1yQYRP5ln1P3NKDvVZsnfbB/PuL4HM9giEF+4F+0hh3kMTQuZhIm/uNPmHsuR/DRkW/R1VEf93m6w8DxVIxF688A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(8936002)(3450700001)(4326008)(31686004)(8676002)(2906002)(41300700001)(7416002)(5660300002)(83380400001)(31696002)(86362001)(36756003)(2616005)(54906003)(316002)(6506007)(26005)(6512007)(66946007)(66556008)(66476007)(6486002)(478600001)(110136005)(38100700002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHczaDNvZTVVblhqVkFNZGZQdXc4b2ZlNEd0c2psRml6bTJPWm53RzNqK1BT?=
 =?utf-8?B?Z29YbEhuZ1lWZzhSaGFaaG5RTkhzaGx4R29aL1ZsQkxrcEUwRkplaHBlL1hG?=
 =?utf-8?B?a2V1YmVMNzVFaGViQUE2eHIyY29Cc3ZHUmk3THdBVEQ5Q1VGSlZ5ZnYvSElv?=
 =?utf-8?B?cXZVTHI1a0lkOXZFTzVLZGIxUVhoSWdXMllPVm1YNmcxT0lpWnlsUmEzZ2Js?=
 =?utf-8?B?L2d2czJPS2UrVUhTQ2hPZXNSc3JrK0t3a3FWSHk1K1RwdVZBVTh5aUU2WGg1?=
 =?utf-8?B?Njltd2UzV3Z3VmEyQTZKTUVGTEJkeGVraDdLdDVMNmY1QzlNSUxkR2Q4L0FH?=
 =?utf-8?B?RERsVVhXWW1ISXFkcmp1dVB0NVc1T1VKOU16dDNQS0dTSnU5QWFScWhYRnRW?=
 =?utf-8?B?UDVPb3RqTzR5dnJ6YlZTZnFRMnMxcDFCUG8wU09YK3hSRkNhMXNkOHZhcFdO?=
 =?utf-8?B?cnJ5QWowVVptcnN5aVpRSzlOVGFGNklSQ25GbE9NQlFxK2cwWU9mcjdPZzBa?=
 =?utf-8?B?UWVTbXZJcWxiZDQ5ZWg1WnVDeHl6Q051bVNFUmVmRFlhaDYzazZ4RGlIbjBq?=
 =?utf-8?B?aXcwakxuZXNRcnkwWXEwOUNNUWF0VmxuYlVZS1dCby9rVHpidGxoNzhjTWFE?=
 =?utf-8?B?NkEydXUzWkRVSi9obStBNm8xdElUMkQrOWNkMk1VcEJDWWZ4V3BrTTI0SmdN?=
 =?utf-8?B?MUxUUGNUUDVQZmVhc05pTTl1Y2x3RkRYa3hzK3pHQkM5REZsbHJoeENxZHhJ?=
 =?utf-8?B?QitUdi9YUGkyeGtvMDFzNVV0ZEtYTXRJSFJQMm0zVURiV01GRUtoaVhCMEFH?=
 =?utf-8?B?UVlEM25wVm1sQ241Ky9XaENKWWczYzhTSWtWMHNZZVVJZ0pUeisxUjZJSFVK?=
 =?utf-8?B?YWtrckpiZUdFbHpUbjhSUk0vajNuVkM5SUNyRURmSG1ZTCtUOSttOVh0MHhG?=
 =?utf-8?B?UG5jcEQ4cnB5bXRocmluUUZzYkJQM3hyMXd3NzZGclp3elhnTmp2M2dnZ0ZI?=
 =?utf-8?B?ellMMjEzMGk4KzU3ZVUyWUQ0SE52NG5YVG5NTTZnVGE1dnpHRlRPR2Q0cVB0?=
 =?utf-8?B?RjBCTmp0WVVFMXNuS1FGc3pidGRlQThQbEJTSGZybXpVME1HdGRQSGcycTQw?=
 =?utf-8?B?QVZlbXlJaXR3Y01mUGJ2NFZOM0NscGJFeWVRYUJyeE9DejJPS29YV1NmLzlZ?=
 =?utf-8?B?WFRXRUtSV2VRSkVOR25BbkFsaG9LaVFkU1U1aXI1K0w4elJ4T29Oajl1KzJT?=
 =?utf-8?B?elg3T05YWGhVbmVVNEFsT0ZkdEdtYW4wWGZRem14b3AyRHphUDNjU3psa09D?=
 =?utf-8?B?aEN3YUlRbG1PdEZUcCt1RkZqQ2xTL1NWY3hrdXNybDBsL0k3S3phNGw4Si8z?=
 =?utf-8?B?bzl3VU4wcTFKdHdZcDR4SkRDMXIwWnFVR1luTWxrc1YvenA1dEFDcWZ5VDBR?=
 =?utf-8?B?VmIwVklTWjFuZ21CWUhzLy9iNy9YaG9QUXF4N2RiejB0YUZOZXhucjNPbjVj?=
 =?utf-8?B?M3NWMUJubU9LeFQvNGhWVlJRQjQra043Sjh4MVQ1aVZuMURMSklKMTVSVk8v?=
 =?utf-8?B?L0dZdHJVR2h0TmNmNElqYWJJNjR1bDF0K01IUHloZVpaaTR3M21zNWpibUN6?=
 =?utf-8?B?SDd4UGdRSkh6Ly85UkVQT0MrcmNSY1JXNkhqOWdZUmhuR3hneUo1Qks1N3du?=
 =?utf-8?B?S3AzTXczYlc2VVZHbk5reHhQSk83d2E0c0RaZXhDTzhmd2lLN3IxVTdXbU1F?=
 =?utf-8?B?MUhLeE9UZlZobXlWSHFWZkVGdFdoZGhpSGl3SloxcEF1SkdObmg1TVRqdjFu?=
 =?utf-8?B?ZjlFVzhlWmxVbFB3dWhiNWVSdEZYUlZwYmt3NFJpYVlsakpHMldIUk9NdnZU?=
 =?utf-8?B?WG5kMU9iOTgzMy94RzMwb0tWS0tpNk5DQjJtUmJFMytZYjZDTXM2OExLTU8r?=
 =?utf-8?B?aWU0azVVKzAwU0RSODNYQlEzUFFYM2RsSlA0RHhLQ2dxa2NhODYxM2R4ZE92?=
 =?utf-8?B?TXMwNVNKSHU1S3VtNnZXOHpJRkdQRkN6OW50b2w0SXV0VWVtSmJrWksxM090?=
 =?utf-8?B?L0RrWDZlSEQvVy8zeTRGVlVSMDczWlEvTVh0R1VqTFdYT1dnV3dQZXJ1WkM4?=
 =?utf-8?Q?3XGo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec475d3-da0d-412f-1232-08dc2983d99c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 15:29:04.9053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUhyRc66ygOxpNRB3b3iOPVgW92fpx13JaizKwQ4TWg1AihI4LZiE28ZatlZhsOs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503

Hi Tony,

This patch probably needs to be merged with with patch 7.

Thanks

On 1/30/24 16:20, Tony Luck wrote:
> Add RESCTRL_NODE to the enum, and to the helper function that looks
> up a domain id from a scope.
> 
> There are a couple of places where the scope must be a cache scope.
> Add some defensive WARN_ON checks to those.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  include/linux/resctrl.h                   | 1 +
>  arch/x86/kernel/cpu/resctrl/core.c        | 3 +++
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 4 ++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 3 +++
>  4 files changed, 11 insertions(+)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 2155dc15e636..e3cddf3f07f8 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -147,6 +147,7 @@ struct resctrl_schema;
>  enum resctrl_scope {
>  	RESCTRL_L2_CACHE = 2,
>  	RESCTRL_L3_CACHE = 3,
> +	RESCTRL_NODE,
>  };
>  
>  /**
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 59e6aa7abef5..b741cbf61843 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -505,6 +505,9 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
>  	case RESCTRL_L2_CACHE:
>  	case RESCTRL_L3_CACHE:
>  		return get_cpu_cacheinfo_id(cpu, scope);
> +	case RESCTRL_NODE:
> +		return cpu_to_node(cpu);
> +
>  	default:
>  		break;
>  	}
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 6a72fb627aa5..2bafc73b51e2 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -292,10 +292,14 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
>   */
>  static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>  {
> +	enum resctrl_scope scope = plr->s->res->scope;
>  	struct cpu_cacheinfo *ci;
>  	int ret;
>  	int i;
>  
> +	if (WARN_ON_ONCE(scope != RESCTRL_L2_CACHE && scope != RESCTRL_L3_CACHE))
> +		return -ENODEV;
> +
>  	/* Pick the first cpu we find that is associated with the cache. */
>  	plr->cpu = cpumask_first(&plr->d->cpu_mask);
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index eff9d87547c9..770f2bf98462 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1413,6 +1413,9 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>  	unsigned int size = 0;
>  	int num_b, i;
>  
> +	if (WARN_ON_ONCE(r->scope != RESCTRL_L2_CACHE && r->scope != RESCTRL_L3_CACHE))
> +		return size;
> +
>  	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
>  	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
>  	for (i = 0; i < ci->num_leaves; i++) {

-- 
Thanks
Babu Moger

