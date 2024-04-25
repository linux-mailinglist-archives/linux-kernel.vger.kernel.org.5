Return-Path: <linux-kernel+bounces-157985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE348B19CE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5741C22F08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABD42BAE8;
	Thu, 25 Apr 2024 04:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="drfMRwZH"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C62C1AACB;
	Thu, 25 Apr 2024 04:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714017678; cv=fail; b=W3tLatGVvWuxo/+q6yuAocNKy9XFqeoRA/K0+ucdxlwe1KmYXqjgw1LErZuXaLsvJizx/afrQ7p/H16VOmwcm88WUdKNBF+olp/Nut/t90jOZLaymbwo6LOPpa1XCs0vYJtPYXAYeO90YonYJTtLngDq0ewMabZB7i8VvbwxnWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714017678; c=relaxed/simple;
	bh=fK1hrGdYsRFx1aqkdMvXieQC6G86S42RvdAQACk6jxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gvJ2TwoVm5soFE1TdbLrDD3XpVMrkTnNb/UU6t/znaWbwAP3gtMVx0y6D5Wv5MMCtGIeECq5twcT7WFXsUiO6qeWC5XwUe2p9Ysako3GkrDdFf4zVJ+FdoAT89Dd7M0wPMX/ne7mJKK3f+mUYrrF1ClX93zIx46zuVWi6d9mLIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=drfMRwZH; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdvq482rlxzv1OKgSCNkoz3OmaYHEyDZkdDXaiUkpcnKlouCZRGoh4O6XYVQhRH/XttYyBPM+aHh991Z824xkAiNDiZHPH9kh2jhhDLfjmMKwMUdCbOhAg70NcE3pZx1rg80hXxp9urNsZn6er8vmbEAnQAMMhRnhInkEIzbeITlGRImGESkcPlxPSJ9aLi9CMpuCb/q4RLdfx1ool9OWeKk7eevOJPP4d6MG2zLbX9uXLxQxFdG7w+4lT1aqjvSVOsHBduHu0Of3YuL21ZJN2v4XBnhO7PaAPe+VINppWehg2MEcO1P8I2UKyFYAVXncuQG8twiFrYLyBrfNFvdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UMiZ2bSCorAISNz0azH9BZPDLYrtlHBKr3FDAOzCBo=;
 b=ZHZId1EmYBT6XXyi5ASbE8xwlKd7wO8nE9cSwwl0Ql2VJS86nelJLxwv3XDq/GdqFvKln/ajv83bGJEICGFBhEMhKCCDcmcokuyz9D0OPlvwYMBwRU9yBWIA7l7GuPwtS5+qIunYTwzdaX8CNkSqzuFEh7BgqMpwNP+4L+o8n2VAekDzxGEbJDjp+FrvHmVbtq4xyKz0CQKKXCqTt2jXkh1fb93eSw5oBWV0XeDMaWk8ZTuLCx9jcCuOYid7bWloyQ+qUtb3oIFG2kau3VqHkiMe5j3dh2RqrxEU9aztsHfkRWdnBQ/hFjdt0uAwrD2HV9IFCfn/NdcdRcsuCQB31A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UMiZ2bSCorAISNz0azH9BZPDLYrtlHBKr3FDAOzCBo=;
 b=drfMRwZHUYaQL9wDKOulLKdeR5gDjykFNPtcMGCtk4zWJ1cdV6dFSssY9mUTmtHm+NWL5YoY9zn+GGHv2vdtjBQ8xhlKp5a9EY3c+tT65kSr9L7JP49fpEG+mCkDMQ/9yIkpgExOPFEKCiUT+taxmHdWtW4e4DTTj/5vufUzQ4Yly/jJN2BNMMOvEc2fMuwMxIByCPSuPb28i4m2Ov29F+dfnZIgw/ocPOt03bfDnhFqDIvFbavFLR8bPbdaFEl3dgM98kNj+c0y1wYjI1zJdkSlNJyHY3NuupFvc3SE9TpHgUNgjO8X9VVnrFPOtai/oXy/FpLIgHyywfwYxiLdxQ==
Received: from CH0PR08CA0004.namprd08.prod.outlook.com (2603:10b6:610:33::9)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 04:01:13 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::76) by CH0PR08CA0004.outlook.office365.com
 (2603:10b6:610:33::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Thu, 25 Apr 2024 04:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 04:01:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Apr
 2024 21:00:56 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Apr
 2024 21:00:56 -0700
Message-ID: <73de5556-e574-4ed7-a7fb-c4648e46206b@nvidia.com>
Date: Wed, 24 Apr 2024 21:00:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/khugepaged: replace page_mapcount() check by
 folio_likely_mapped_shared()
To: David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, "Kirill A .
 Shutemov" <kirill.shutemov@linux.intel.com>, Zi Yan <ziy@nvidia.com>, "Yang
 Shi" <yang.shi@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>
References: <20240424122630.495788-1-david@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240424122630.495788-1-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: fb108324-d7b5-4f0f-d67f-08dc64dc5927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400014|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0dlajYvY1ZFMlc1RTlPQWFJOGxBUE9nOWlEUHdRSDhzdXZpS0NkMXBIMUN2?=
 =?utf-8?B?Q3JtcVpwUjhsU3FZUkZKZ3U0TEVvcEplUHQrb1VJazFselhEU3FLaWpUSkFi?=
 =?utf-8?B?ZTkySE13Wm4vOC94SkZMQVZNc2p5a0VYWGYrYWt5YnREQjVDNjVrWkN2Vmcy?=
 =?utf-8?B?cW5RcjQ4SmFYUlkwNjlFR2thRERzOXdzc3Nlb3NVSkg5S1VoWVRBM0tCRzRJ?=
 =?utf-8?B?T3dtTXh3ejkwU2lIVy9DU1czYm5kRHBRN2xLYzZzMjNwQVpYZTJsOG54Z2E3?=
 =?utf-8?B?S1VwazdsQXpkRGI4d3dZdm1sbXN6bjBQcTZlS28wNnlTVHFBQkwrSXc3T0Zl?=
 =?utf-8?B?TjJVRDVINTN0dTQwK3VnK0kxVnlTWjhjUjNydEYrcjVIOHV6dS8wd09TbHVu?=
 =?utf-8?B?Z1UrM1BiNko2MW5mbjJSUWo3b0JBNjQ2aWtaUFhQeWYra1hlM01HenFqSjRx?=
 =?utf-8?B?NHNyazdJL0Q4WmdNeVZVWlVDRTU2bGhZRWpEcDVaeHBmZVVsRWdFNFJtdEkv?=
 =?utf-8?B?RUxGMzYyQk1mc1RUUlIvQWtsZjJtMlJTUldObUo3eWZvM2Y5SlZLYmw0bUJW?=
 =?utf-8?B?NnJqVzVmd01zcE0wbnJvd3hYUGZobldXVlFSbUFUTCtzeHFqV2hEZXNxa0ZM?=
 =?utf-8?B?Z1ZhRjhtR1Y4UU9mMmxWQmhLcU9Ub0JWM1NVdmVDOU1IdytDU3ZTU0c5VlBK?=
 =?utf-8?B?S0ZEbS95OFZsc0d6UmVqV3RMd3pQZFJxTWdHYitMTFh2T0J1djM3UTVSUTEz?=
 =?utf-8?B?K2NQdmJuRmo2MjR5c0p6QVdUWXgvNFB6enp0RkthZ0VubXpTaElPV1N6bkJp?=
 =?utf-8?B?c01JQTA2a3ZJZDl0RTI3NGcwUE1WTjRoQlV1SVFtUHg1QVMvSDFELytBVi8v?=
 =?utf-8?B?ZFNJcjRWcWRkMzdPYlEyRGZsb0F4dTc1MjN3aWtQdW12cFRaNUp2S01xRENJ?=
 =?utf-8?B?bThiZ0FLaEt0QldJeHpkVWtLMlQydy9LVThGcjVmcWVobWE4SG1YM2lqd2hz?=
 =?utf-8?B?czFYMW9XdjVGamRZQjhtMHNPV1ErdzhSMGxpY3kyT05tTm1JNENMNXM1eGxu?=
 =?utf-8?B?UkRGNG8vOHV1UG5nVHFtWTR1bFhUcXRyc2EyWlJmYXczbjIwaklkQ2l0MEF1?=
 =?utf-8?B?UmJ1anRzYm5VYXV1K0pqbVE2eWQ2NUd5a09DUXRYdkRNaEU1Yzg0elR3TlBB?=
 =?utf-8?B?a2FBWGp0NlpBUHM4cE1yV09oQWExMzFwSEYwbjJXUy84TzJOVCsyWVJUVEVS?=
 =?utf-8?B?blFLdkQ1eW5SU2VOMTkrNUlyZGwzM1FoTVZKdk10OElUbWZCMlJpVnc3a2tl?=
 =?utf-8?B?Q0VZMXg1NXZOeURtWkw2YVZZVEtzTWNvWXoxY0FkTFo3UTF4K0FSRS9idy93?=
 =?utf-8?B?NHNvc1FRUCtRSGFzalpnL3Zsa25qa3JGY0MrV1U0bWFyVjVWeEtxV2FyU3hU?=
 =?utf-8?B?ZlJoVTdXT2QyL0RqOWJxRkg3eHFwNlRYY0VNektLRk4rQnVyKzNLN29PVThx?=
 =?utf-8?B?dVA3ZFdRS0hFTldkWmY0cW9Xd1ltRTRReHZqQkdsbU5GVHVHV3pyZEk0alVQ?=
 =?utf-8?B?L3RwbDJZemY5a0VWbXZTWVFjNXh4ak5QRXdJT3FCYnBkTW5jaXVlU3lYQmwx?=
 =?utf-8?B?RWZtcmovTnBBNGJrK0Y0RWNpY2NhWjRVVHQwVnUxaHBEbWJxSXhMRWVXZzJX?=
 =?utf-8?B?d0tZM0drTXU4YjVkbmh1QzFTejNNdlZseDBLZkhuMVBIL244d29rd3RLcy9p?=
 =?utf-8?B?RnNtczA4MHYvbTVteWJ5ZUR1UDhUZm5tTExMSFlJK2JZaVg0cjBQWmVXWUJv?=
 =?utf-8?Q?6pD43okSSASO2iLdaqe8kT8Ka2hq9XJrUry5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 04:01:12.9571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb108324-d7b5-4f0f-d67f-08dc64dc5927
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182

On 4/24/24 5:26 AM, David Hildenbrand wrote:

Hi David,

Overall, I think this looks good, just a few questions, and of course
some silly documentation nits.


> We want to limit the use of page_mapcount() to places where absolutely
> required, to prepare for kernel configs where we won't keep track of
> per-page mapcounts in large folios.


Just curious, can you elaborate on the motivation? I probably missed
the discussions that explained why page_mapcount() in large folios
is not desirable. Are we getting rid of a field in struct page/folio?
Some other reason?

..
> To summarize, in the common case, this change is not expected to matter
> much. The more common application of khugepaged operates on

Based on the diffs (and some quick hacks for testing that I ran), I agree.

..
> 
> This really needs the folio_likely_mapped_shared() optimization [1] that
> resides in mm-unstable, I think, to reduce "false negatives".
> 
> The khugepage MM selftests keep working as expected, including:
> 
> 	Run test: collapse_max_ptes_shared (khugepaged:anon)
> 	Allocate huge page... OK
> 	Share huge page over fork()... OK
> 	Trigger CoW on page 255 of 512... OK
> 	Maybe collapse with max_ptes_shared exceeded.... OK
> 	Trigger CoW on page 256 of 512... OK
> 	Collapse with max_ptes_shared PTEs shared.... OK
> 	Check if parent still has huge page... OK

Well, a word of caution! These tests do not (yet) cover either of
the interesting new cases that folio_likely_mapped_shared() presents:
KSM or hugetlbfs interactions. In other words, false positives.


> 
> Where we check that collapsing in the parent behaves as expected after
> COWing a lot of pages in the parent: a sane scenario that is essentially
> unchanged and which does not depend on any action in the child process
> (compared to the cases discussed in (B) above).
> 
> [1] https://lkml.kernel.org/r/20240409192301.907377-6-david@redhat.com
> 
> ---
>   Documentation/admin-guide/mm/transhuge.rst |  3 ++-
>   mm/khugepaged.c                            | 22 +++++++++++++++-------
>   2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index f82300b9193fe..076443cc10a6c 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -278,7 +278,8 @@ collapsed, resulting fewer pages being collapsed into
>   THPs, and lower memory access performance.
>   
>   ``max_ptes_shared`` specifies how many pages can be shared across multiple
> -processes. Exceeding the number would block the collapse::
> +processes. khugepaged might treat pages of THPs as shared if any page of
> +that THP is shared. Exceeding the number would block the collapse::
>   
>   	/sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_shared
>   
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2f73d2aa9ae84..cf518fc440982 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -583,7 +583,8 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   		folio = page_folio(page);
>   		VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
>   
> -		if (page_mapcount(page) > 1) {
> +		/* See hpage_collapse_scan_pmd(). */

Why? Because it has an identical code snippet?

I thought about asking if we should factor that out, just to
keep the policy the same. Thoughts?

> +		if (folio_likely_mapped_shared(folio)) {
>   			++shared;
>   			if (cc->is_khugepaged &&
>   			    shared > khugepaged_max_ptes_shared) {
> @@ -1317,8 +1318,20 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>   			result = SCAN_PAGE_NULL;
>   			goto out_unmap;
>   		}
> +		folio = page_folio(page);
>   
> -		if (page_mapcount(page) > 1) {
> +		if (!folio_test_anon(folio)) {
> +			result = SCAN_PAGE_ANON;
> +			goto out_unmap;
> +		}
> +
> +		/*
> +		 * We treat a single page as shared if any part of the THP
> +		 * is shared. "False negatives" from
> +		 * folio_likely_mapped_shared() are not expected to matter
> +		 * much in practice.

Maybe delete that second sentence? It is not really pulling its
weight here. :)


thanks,
-- 
John Hubbard
NVIDIA


