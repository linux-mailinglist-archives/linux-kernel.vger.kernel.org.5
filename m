Return-Path: <linux-kernel+bounces-59538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29F384F890
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937391C23CBC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9C973174;
	Fri,  9 Feb 2024 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4zM1G0ml"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F5C74E09;
	Fri,  9 Feb 2024 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492561; cv=fail; b=HnOICDXtHgtkes+c/C11JZWJLiJv3xVOHET0r8NZdorSbXyuUzlNFQFSiwVvjyUNyWckzDDYwLl4fmQSpleNuLPuT4Jc6F0wKYTqxq2HuFeJixyvcyj7XCpq9J4uC7yZzjapfk4xwleWUCM8SN/0+IUQVZfqi5UkLzYM2n6x2lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492561; c=relaxed/simple;
	bh=GO4G8mPB5gfOjGj8XDAue+lE8mmiWoJ9HBgy5tUEF9Q=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jA2/asFGN5Woj5OSoa5WsABHqKGgP9h5YGx5HYGNLh+eydRYMLcA25/mlPL54xFSMlRfaWjLtFxG2l2ua+hZuGm2HX6F0QSrhd49aQC9Zm0Uiw5x+mHrbIjUKLWDULv1Dne2sqiwuJYQRJp18+MvBJgBcR8eJ6ekgRTX4p7Sn7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4zM1G0ml; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvMerYcklxpXmPJM9BGYjXPI8WL9AgAbpzDLPbDSMlcfaWG/p3X0nsQUyK4OwuSPSVMVRXlagE1X8n98ekvDW2fiY5KRbTcg1Te/IongRqxDP+nWmMHQfFnoAh49vAOF932ZDKkf2D38F9OWncR0J1CZq1xTmkngsRR0Ai0XRMX8s8zaGcbQCzfDk5xqah5xWJygI4HizKrIDrK8bVvmkRMKG4xYPr6q2B+RpFfKNQX5/yBmwP4k1mtcd/kXQX1OEFJUiBFol5wznbqZoV6H33jdDHmV6O5C8O6Qgo870X1asO3YjeGbFBBwlnNhMAtb06xp3YSCgykzBIFabgFHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJX0TxZFcuD0ecbw34YdJRk0VLuC9PlXz3tGRMFt3vQ=;
 b=jdrXpypUI3hQVYkJmjkj4MBwANZF65VDRaTFBGolOEvTJo4p3TPJodB9BT+/I8SBr31W9XtKfUHS+uJBFdrMXGEhrccu4Va3qbIb6BSh+A52K+H3ItdSVU62s6fRxWzqRFDEVJU1+9XrCOr3FJUFQQup5Qde6NQB/iPy/JILX2b400/J6HB5GNiRo7pItflORO4MPKT2/O9B+6t1IHURLiNkVfePIV6jrjA0kSO/UF0YF8qXgTrhbUt3PudqJGfcKn8jy8WDtT+bu1RJ2GhrCwRRa4DWA4lKEf17faHYnf5pe+YRxbupVgBshLls4gg5nB4HTo8D+815+bwn3EoK7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJX0TxZFcuD0ecbw34YdJRk0VLuC9PlXz3tGRMFt3vQ=;
 b=4zM1G0mlYgGB0pqq6oxZTgUPpydEmaamqfIfBpBhtOSC+2ZT+E6YxZpFs91klL7V9Daz743hGCaYIdXtTYzompqt5K5cqzD8tkvEgUo6W5nyr2rWcCHKjvS6q3wcz+IZI0rrUkgjPY1wir5T4HfoLO6rB4Ek+9a2LRDR/yfAKxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Fri, 9 Feb
 2024 15:29:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%7]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 15:29:17 +0000
Message-ID: <89dc9022-c9a4-42dc-8710-be2d6d9a4e7c@amd.com>
Date: Fri, 9 Feb 2024 09:29:16 -0600
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v15-RFC 6/8] x86/resctrl: Introduce snc_nodes_per_l3_cache
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
 <20240130222034.37181-7-tony.luck@intel.com>
Content-Language: en-US
In-Reply-To: <20240130222034.37181-7-tony.luck@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4bdd5030-16f1-4754-6e0f-08dc2983e15b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8BHUSUR41Fdg7D5FGDqdaPi5NWybH08b+QoysPSy+gsXSvTk54g+1Lw3BfjebZ+2eQOajD4BA1nUyFBhGi9NwRzLIeFlLa+62WtT2j8/2W727rd5HPP2+TRXsjFRTRFiNncG4K2u8U/ShtOdMx7BQQvU9guB6VSs9MppwAsbSazwFUwVUyevLCE7sXqSJ9+RAMzb4sD3vfpuUSWBe+ApFrd0knSYKhqmMMNkeqBI4dEBXZPhevVZpM2J7cU3IMMDWX76/1LfGjym/23nDH88Llmn0BOZNzNeBGKlSFvxiEa+MOpv8JbkhDOKsZSQn/Eh7mahniHTrv2cHuo52hlgYgeFDqNKS8Cl0idKEb7HFtTxQZ7sKbJmNzP6cj3vUVFu6mW96HiEnIeg9aidbHbHLaHy5/VPTaB9iT7qemBtN8gbqViHZoaCkf2f8rFP7LeH8tU3MKsiodif+Jb+G3d05ZFYAU+o2i6EYvMzB+7lv/NdAf54zxI2TiyXi4S50MaAOelhIxS/bRKPMf5pqUTBpe+Dq9R21IyC2/7D6tC+1CaACYhkeGUuQBvO3Vx4G+ke
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(8936002)(3450700001)(4326008)(31686004)(8676002)(2906002)(41300700001)(7416002)(5660300002)(83380400001)(31696002)(86362001)(36756003)(2616005)(54906003)(316002)(6506007)(26005)(6512007)(66946007)(66556008)(66476007)(6486002)(478600001)(110136005)(38100700002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFZpM0VNczhXc0hQS2tuYUtPQmRsRTVicG53eFk1TlRmOE1xWjd1d2w3Zzhl?=
 =?utf-8?B?SWNQQlFsamdjbDhxL2VSdVBYTlJ3VDdUNFJkZHZWb05ybG5KYVpUY0J6MllE?=
 =?utf-8?B?b0dBR2VDNlVzSlRLRXkxbnphZWNqWkdFSXlBekJ6bHlBT3RDZ1hORkx5NzFM?=
 =?utf-8?B?U2ZJOHBnQ293Wk5PREVCcTFlMjFvakVnaytxUFRLdXp5OC9HRkNtNGwybFFU?=
 =?utf-8?B?SUdxM0R2V1NsQ0dpSms5cDVXdzVrWUhOSFQxVGNEdlhKcm9YV2c3ckNaaTIw?=
 =?utf-8?B?dERUdW5wK1dHejhxTEcxaDVKSVFvcjVOTlRZVGIwUUszRVkzeHFYa2dFRGJI?=
 =?utf-8?B?UWthYjVnZi9CR2dlcFh4UURUWTJrMDJNQzhBUFBhY3VDNVdGbzVIMEZFT2x0?=
 =?utf-8?B?Qlc1cDFsVU1oQzEzRFVIR1VMb0V0M0draTF0SjhXNUkyaVNwbWpTdTM3U0NI?=
 =?utf-8?B?V0g1cmd0SnQvYUp5MU5wMTRXTmNONGh2N3BES1FGTnIzN2RjWDRUSE5FcjBl?=
 =?utf-8?B?N08yeVZTanppdUVqbkdNU2FucEh3VzFpY3RRQncxbGpla3VyUjVnZ1U3REkw?=
 =?utf-8?B?VHhFM1VkeE9yK095S015dFo4TTFFWVB2SWgzUytkbjdWVkN3dnJoR2lsRnpT?=
 =?utf-8?B?Y0taZ1RReDlVa0Y2THRDTlQ4TjZZZ2ZuTE1kRExsZTIxZVNsWHMzQVU1V2lM?=
 =?utf-8?B?Rlk3WDhMK0Z3dDVGRGNqK01EYzBNRUd0ZWZlUzVUVEd0UlVuMnJaZzUyWCs1?=
 =?utf-8?B?dHFDNDBaOGZnblI0UnlTMS8ySldUdjNSR0RkSGNibm9uMFdOdEdBbnQ2K3ln?=
 =?utf-8?B?VjUxb1FLWnZuVHBOWEp5b1pmWFpQbGliTGRYWVdkS1RWdTFHRnZzVGJyUm8z?=
 =?utf-8?B?UFEvcWdQMUQyck5xa01CcG0yYndnbGxxdWw1YnhZMGpLVS9pb0JkZzRvUEQy?=
 =?utf-8?B?VWorSWV5Ry8yMWVaSnBUUmZoWFkyVTk1bDJMRUNRVU54c28xQ0p2Um9NajFJ?=
 =?utf-8?B?TTd1bCtTR3o5R2gyZ1c2dlRTbXdUbXdBQ3A4STFRSjRRRjkwZFNKbk96b3VK?=
 =?utf-8?B?S09lYmF3ZFh1NWVtdXdYNUVUeVlQbU1sbE9QdUF6OFRJb2NDYnRoeER1a3J1?=
 =?utf-8?B?QXJHVEhFdU52NzdmamtrY2FrRUdvaDA0MWlxMTRQeW1teHIvSnZ2R29lRDJl?=
 =?utf-8?B?YmJ1ZHVCNS9NYUdIbVVTcHlzc1l4bFMzeTdKR0xyOVFVakk5aEZWdEMxOWNK?=
 =?utf-8?B?VHNJRkUvbC8xeFBUazBQK3cyYXpOOVRSS0dRZmlXdjdpNUNHMXdkUHljMnVn?=
 =?utf-8?B?THR4QzZwdXNlOWU5VXhrdjdEcWZNOTI4N1MwYmpnN2Q4YnJWZVIrZm95UEVq?=
 =?utf-8?B?bThQVUx3bC80dGllOXdTZnlFTHh0eHlxdk1XUFNoanUySm1keTdzbVhwR1cz?=
 =?utf-8?B?ejMzVzdoaGZrTGkvbGhnRHZEbFJXNEZyZGpPVlgxYVlGNnJ5czJBeEVNYTNY?=
 =?utf-8?B?YjZ3bjRUZTdnRGZpQkRvUGF2UWV6a3lkMDk4dHY2KzQrbGg2RTdDbjRLZVlM?=
 =?utf-8?B?L2lJTURSNXF6VHQ0OFFRVnR1UTVwUENEcnY5ZHIvZlpyMGdIN3NkVFRtcXhw?=
 =?utf-8?B?UlF2T0VoamZjWmdGVXJseXlyU0JhRng4NjN1RHBIOEVmTVhUVk5RYzdUVktO?=
 =?utf-8?B?T05qTkliR2lkVjk5Nzh3SC9uQXZ5Z0UvRlBmSVlpanU1T01OSU83WS9FSkxX?=
 =?utf-8?B?Mk9QZktFOStEVDY3ZC8rN2grb2c1NHdTcFNVUkVoY3MrR3FCbUpVZXY1MmJC?=
 =?utf-8?B?OWpSVWtTTUVwcmhMQWV2NXdQR2t0YVhJZFR5dkw4Y3VGRlBxblUvNFpIOTYw?=
 =?utf-8?B?YUt5TmdvdXU4U2dTL0FpbE96LytFbFJvdENWaWhvRjhGZWJyZUdBcjdGbnZq?=
 =?utf-8?B?dnJUTVVjbGo3ZGNjTENpRDlTYkhvemg2Mm1IcjhMZEJCR2pGVWoyNWdMNzFu?=
 =?utf-8?B?OEdCVDkvMm0xR2xQVllOK21KdVVnaU83SkFZd2hEaDRYdTVEcy9YTy9GcXc1?=
 =?utf-8?B?emVaU1k5OUozeUxKUHlaaDVvTlMzMEpzWm1qMFF1ZVQrRTdNYTcvOTlqcUIy?=
 =?utf-8?Q?r74w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdd5030-16f1-4754-6e0f-08dc2983e15b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 15:29:17.9213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCvzIwpnCg8QS9vKlc0AHn9YFQLPWxrB3AAeggK9Oyx+WcFxZhSwR/cKjZdV2CPP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503

Hi Tony,

On 1/30/24 16:20, Tony Luck wrote:
> Intel Sub-NUMA Cluster (SNC) is a feature that subdivides the CPU cores
> and memory controllers on a socket into two or more groups. These are
> presented to the operating system as NUMA nodes.
> 
> This may enable some workloads to have slightly lower latency to memory
> as the memory controller(s) in an SNC node are electrically closer to the
> CPU cores on that SNC node. This cost may be offset by lower bandwidth
> since the memory accesses for each core can only be interleaved between
> the memory controllers on the same SNC node.
> 
> Resctrl monitoring on an Intel system depends upon attaching RMIDs to tasks
> to track L3 cache occupancy and memory bandwidth. There is an MSR that
> controls how the RMIDs are shared between SNC nodes.
> 
> The default mode divides them numerically. E.g. when there are two SNC
> nodes on a socket the lower number half of the RMIDs are given to the
> first node, the remainder to the second node. This would be difficult
> to use with the Linux resctrl interface as specific RMID values assigned
> to resctrl groups are not visible to users.
> 
> The other mode divides the RMIDs and renumbers the ones on the second
> SNC node to start from zero.
> 
> Even with this renumbering SNC mode requires several changes in resctrl
> behavior for correct operation.
> 
> Add a global integer "snc_nodes_per_l3_cache" that shows how many
> SNC nodes share each L3 cache. When "snc_nodes_per_l3_cache" is "1",
> SNC mode is either not implemented, or not enabled.
> 
> Update all places to take appropriate action when SNC mode is enabled:
> 1) The number of logical RMIDs per L3 cache available for use is the
>    number of physical RMIDs divided by the number of SNC nodes.
> 2) Likewise the "mon_scale" value must be divided by the number of SNC
>    nodes.
> 3) The RMID renumbering operates when using the value from the
>    IA32_PQR_ASSOC MSR to count accesses by a task. When reading an RMID
>    counter, adjust from the logical RMID to the physical
>    RMID value for the SNC node that it wishes to read and load the
>    adjusted value into the IA32_QM_EVTSEL MSR.
> 4) Divide the L3 cache between the SNC nodes. Divide the value
>    reported in the resctrl "size" file by the number of SNC
>    nodes because the effective amount of cache that can be allocated
>    is reduced by that factor.
> 5) Disable the "-o mba_MBps" mount option in SNC mode
>    because the monitoring is being done per SNC node, while the
>    bandwidth allocation is still done at the L3 cache scope.
>    Trying to use this feedback loop might result in contradictory
>    changes to the throttling level coming from each of the SNC
>    node bandwidth measurements.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>  arch/x86/kernel/cpu/resctrl/core.c     |  6 ++++++
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 16 +++++++++++++---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  5 +++--
>  4 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c6051bc70e96..d9c6dcf30922 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -428,6 +428,8 @@ DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>  
>  extern struct dentry *debugfs_resctrl;
>  
> +extern unsigned int snc_nodes_per_l3_cache;

I feel this can be part of rdt_resource instead of global.


> +
>  enum resctrl_res_level {
>  	RDT_RESOURCE_L3_MON,
>  	RDT_RESOURCE_L3,
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index b741cbf61843..dc886d2c9a33 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -48,6 +48,12 @@ int max_name_width, max_data_width;
>   */
>  bool rdt_alloc_capable;
>  
> +/*
> + * Number of SNC nodes that share each L3 cache.  Default is 1 for
> + * systems that do not support SNC, or have SNC disabled.
> + */
> +unsigned int snc_nodes_per_l3_cache = 1;
> +
>  static void
>  mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
>  		struct rdt_resource *r);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 080cad0d7288..357919bbadbe 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -148,8 +148,18 @@ static inline struct rmid_entry *__rmid_entry(u32 rmid)
>  
>  static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>  {
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;

RDT_RESOURCE_L3_MON?


> +	int cpu = smp_processor_id();
> +	int rmid_offset = 0;
>  	u64 msr_val;
>  
> +	/*
> +	 * When SNC mode is on, need to compute the offset to read the
> +	 * physical RMID counter for the node to which this CPU belongs.
> +	 */
> +	if (snc_nodes_per_l3_cache > 1)
> +		rmid_offset = (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->num_rmid;

Not sure if you have tested or not. r->num_rmid is initialized for the
resource RDT_RESOURCE_L3_MON. For other resource it is always 0.


> +
>  	/*
>  	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
>  	 * with a valid event code for supported resource type and the bits
> @@ -158,7 +168,7 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>  	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
>  	 * are error bits.
>  	 */
> -	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> +	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid + rmid_offset);
>  	rdmsrl(MSR_IA32_QM_CTR, msr_val);
>  
>  	if (msr_val & RMID_VAL_ERROR)
> @@ -757,8 +767,8 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  	int ret;
>  
>  	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
> -	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
> -	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
> +	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale / snc_nodes_per_l3_cache;
> +	r->num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_cache;
>  	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
>  
>  	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 770f2bf98462..e639069f871a 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1425,7 +1425,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>  		}
>  	}
>  
> -	return size;
> +	return size / snc_nodes_per_l3_cache;
>  }
>  
>  /*
> @@ -2293,7 +2293,8 @@ static bool supports_mba_mbps(void)
>  	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
>  
>  	return (is_mbm_local_enabled() &&
> -		r->alloc_capable && is_mba_linear());
> +		r->alloc_capable && is_mba_linear() &&
> +		snc_nodes_per_l3_cache == 1);
>  }
>  
>  /*

-- 
Thanks
Babu Moger

