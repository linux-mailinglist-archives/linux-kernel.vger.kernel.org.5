Return-Path: <linux-kernel+bounces-160890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4F98B441A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B1F1C215D4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 04:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A103DBB3;
	Sat, 27 Apr 2024 04:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="njE7WV8g"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA402AF1B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 04:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714192903; cv=fail; b=j+0ID6L4YeijVU7bu7TYPDea1kpJDR0d3yaUqFWYpw0C1oVtY7qYk13VrGeZx4C0F5vpNdKVPNXcycT+laWc4S7awINz6Pm3oT/XwCFeUUeo6qW2mfSCMkdQb6qOAC5c1TYT5azyXqrfPMTg6XaUv+PogU49lDwA+zjcRc0pofQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714192903; c=relaxed/simple;
	bh=PAHWUv+KlbhVWtC6zaEbXIcGPWnDNs7ridA/54/USZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P91OPeV7JyoJMWqs7uO6IYNdkWtpDVsx9RvEbktjFmUrunhL7gHTEOseZucZ3B9TOMKnNSsU+d9LURZaUEbia4bKs8JOYstud3oXzwcybHrjIT1FmSYyObl9Y3oPmqZADTvzcMZtEjP3z/d2ekHB4eQ3ybJuoU+MIvguORAb8II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=njE7WV8g; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sak1ViFEZlsMAKH4iCW1vjVZ7hz2F/eD3mK2qKzeDDxn3YoOqAwJzvKXjfLRtHYey4/TFmna079aBd1lHbA6TAwk3s8VZvhgbkD9lQ7H2cUjHXW8fe522mhOH/M53gz3qJ4eePRkZMx/YWexZlw0OfUByxDbfs4pXhnbkznoSRHjnPwlp72VP2gTFmHIm74+GnN/eksqgys1DeRUJqCK56s74ZzKLAa1eut+hSKKfFrIFKd5D6vK4qwxCfg8wwReLjPv8/VzM82Wpp5U8qbVUn0nddA1b5b2nmMpGzDdENlUv4st/Tkka+aGalo5vrOV4P2mxc/NoseUhnbftPfQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElTx/LKfP28sQfI7FAMFlutDLNBwSAo3aJVgBepTgtg=;
 b=IN3LORnhIsIm97kL2bx5qZPJ2jfQ9om6Q5FPdzNWKrmwMzs54oZG7X/J9+IHhpIxbP4sA9k33xVMJ/+U/TU7pD/W/WFGon0nlBMx4YR7VvU2/ednqCoLupEXHr0H2VbVTJaVnbU0/p84mCy0X542Y1MzCPcFkqWfl0jy4OIq1u8Qps1nv2ZnVNOm/ZXuNd/k053RZBUL9V8rZ8LnrTGQzr/SPTzmqwq0TH82gqyAqizhtP8kdYsA6hXXHKJGeEJT4z8gUuQt98vUMcmS+vFOsBjuV2AQnkHEQHyeOBQZDra9p3OPa7DEEmJHTziJ7ipHtjHlLyhxkT15QwrDao96PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElTx/LKfP28sQfI7FAMFlutDLNBwSAo3aJVgBepTgtg=;
 b=njE7WV8g33hTK5nQJwJ39/3zmxr/EiLeBr7Q1LY8cDRdVklHYdYzRirgt19IlfjtMH+raHd0zFlteH6zTkegPySIOPTko5pP0ylCeKChM8JUTzAC0HmmywQ29XQyBrMFbxwEwEfN21TxW1I0aeo8kLAhpCs3/i8GSuC4kIL+i0N+4SWkjeimx26Z93YvmmRqqsUHkfkhMLRbTYrMW+xdRBAL3AvLUlyuIQ+EgbxmjoS5XbJSHrGVQipFJYRnDL1UvSfTTUgg1QhYfzS/zJq35fsidXgVbCOtGtrR8Tyl9B5Fy6f4JzfiFSmWm4lrR6DxcSLAv9NlcjG2BkXNLh2XnA==
Received: from SN6PR01CA0005.prod.exchangelabs.com (2603:10b6:805:b6::18) by
 MW4PR12MB6897.namprd12.prod.outlook.com (2603:10b6:303:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Sat, 27 Apr
 2024 04:41:39 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:805:b6:cafe::7c) by SN6PR01CA0005.outlook.office365.com
 (2603:10b6:805:b6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31 via Frontend
 Transport; Sat, 27 Apr 2024 04:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Sat, 27 Apr 2024 04:41:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Apr
 2024 21:41:31 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Apr
 2024 21:41:30 -0700
Message-ID: <17956e0f-1101-42d7-9cba-87e196312484@nvidia.com>
Date: Fri, 26 Apr 2024 21:41:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
To: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240425170704.3379492-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|MW4PR12MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c4962c-1fad-4b91-e0e9-08dc66745427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400014|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDZPcjMyWGF0UXgzNkQyaEZWR3dZKzVOR3V6a1dFTTRXQnV5NW1RTVFXTVQ5?=
 =?utf-8?B?ZkJQNUNDcVhBNGR0WFpaMGNrcmNCSWQvN282cGFQTWhidTRabnFNV01mZzFI?=
 =?utf-8?B?ZHJ5c1dEWlFhY2xUVGpvaFFrZExSbEx4Ri8xR29JZUc5d3FJS1l4WjdUN1V1?=
 =?utf-8?B?ZEkxM1RkSGJWUUVOd051WFdNT0NIWkNhdGtTT2M4aEM5aUhVYXd1M2tDSFN4?=
 =?utf-8?B?SmhnWTJrL3I4T29HVXBMZjhkTkM1blpSRDFpMTkxSEdZWjRXcXFFdDdjZmpE?=
 =?utf-8?B?WWs1aVRzZlZzUGRHSm5NWFFmQjNwV2J1YUFBT3UxUEc4OExUMlFkN29TOUtB?=
 =?utf-8?B?TEVOUVc5MWxDR0xHeDhXc1BLSFVWVWNhN0xRdWZYaEhLemc5SFRiTTNoeHJS?=
 =?utf-8?B?MWRlMGdoNGMzOGlJSHUyaDM1NmpEYTJrRmpKOS81V2xOWEtia1V0bkNZZlRx?=
 =?utf-8?B?Y01NWm1UR3NxZm1RcXlhMGgxNUFjZStMS0F1QmhqZ2U3RnNScHFjSDdNWFIv?=
 =?utf-8?B?VzVqWFduTlN5MnRqS1htS001aW82OFJRQVRmYmRDVkdKeVR0SXhYbVZIL1pN?=
 =?utf-8?B?WTRpaWNZMzdsSlJ5U01SU0E1YVQzT0orazExdTN6RUJTNjE5WnJZQ3VXeUJm?=
 =?utf-8?B?QjRQMDlqNldZT3NkN1M2ZUV2MWZaTVFIU3BHTkpZdVFZVVJ2NmZGTVRCbWVo?=
 =?utf-8?B?RnVyUFNzOXE4KzhEcWJzd1NlOWc5VVhZTHBZN2xYZFFUWXRvN0hPTjVETGxV?=
 =?utf-8?B?RTZ3U0xiWkRVQ3MxT0ZqNDN3RlNJWHBHaUZNYk5RTGxXdGh3QmVxUHNpT2E0?=
 =?utf-8?B?ODhlWHF1bThXL0VwVXdjV1VTV3dvTExLOVVUdHVUQTRKRG5JbDZLaWVPck82?=
 =?utf-8?B?VG9hQThnVzcyN1M1TC9xL2Y3V3dqSmswYkNENHhZZjJuQmdCdUlsNWlaYmdU?=
 =?utf-8?B?S3RGak1SbXBWb0JLWXE5V1F5R2g3SEZEN292ZUFzMkNHSmhoeld6VDJHVEY3?=
 =?utf-8?B?bFIwVEhVWEx5ZW04QkxpUDR5YmlvazZBOTFEcDh1cjd6QXkxU3JFdllndTJp?=
 =?utf-8?B?NmI3dm9EMnhxenVkTEEyYlU2QXBtcWpkeEdzVi90OWpjcStNcUVpbUQxZTd0?=
 =?utf-8?B?eE1GdkdyaXQzZytVcm55aW11U3BOcFc1MEZyMjIzRjdzM2s1Tk9pSWNVOTNW?=
 =?utf-8?B?c2x5RWpwaVA5YjVXTGh6ZmdlT1Q2bllFbmJqcjBCNEpWK2oxNWtLUTc2a3pL?=
 =?utf-8?B?U0h1WkhWT3E1WURGMkFDZTRDM0JBYXNHdm5NREMwRHJZN0RueldoS05sWWlh?=
 =?utf-8?B?Zk5BTXRpbDJJeFdvSFZHaE5kTXBCeEZuNTNNekxvS04wMEU5NmFxbVBMQk1P?=
 =?utf-8?B?WUZsaFh0azA0QkIxZTZOTnNYOGI3THRJeFdyVEVTNW56SXl1WDhqVXhYWXB6?=
 =?utf-8?B?c3lFMDJDa3Yrckw4ejdzTzlZMjBvbXRTeGsyUmlBb1c2N1pkSkEzWkx2Y2VN?=
 =?utf-8?B?dzRLMzJVMmtVNG9LQ1RmQ0gySkdGczNGck45Z3dUeG9sSmtsSWxzbEtrdzhl?=
 =?utf-8?B?cG9XZFdncFB1R1B3SnErUG1xdUw4QUNkRDBWaW5Eenkzcko0VmVQbE52eUV6?=
 =?utf-8?B?OFdhK0hLZEkvR0pUN29HM3BURlZBUW1vZm5LMDFQVEpta21lMkpWWkFUZ0FH?=
 =?utf-8?B?YkVGK09ZUlV1ejlkM2NxWHErMkJ2K3JxKzZlWml5WW5uZVpDVmZaUEVKQkl6?=
 =?utf-8?B?cHY5WGw1RG00T2N4MjFzeklnb3cxYXMrWlNZNzBZUU9iSUovdTBBd0FYY3I5?=
 =?utf-8?Q?OlkN/YYZF0DyKCBgxzm/+wn8tcHz38ICjao60=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 04:41:39.2500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c4962c-1fad-4b91-e0e9-08dc66745427
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6897

On 4/25/24 10:07 AM, Ryan Roberts wrote:
> __split_huge_pmd_locked() can be called for a present THP, devmap or
> (non-present) migration entry. It calls pmdp_invalidate()
> unconditionally on the pmdp and only determines if it is present or not
> based on the returned old pmd. This is a problem for the migration entry
> case because pmd_mkinvalid(), called by pmdp_invalidate() must only be
> called for a present pmd.
> 
> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
> future call to pmd_present() will return true. And therefore any
> lockless pgtable walker could see the migration entry pmd in this state
> and start interpretting the fields as if it were present, leading to
> BadThings (TM). GUP-fast appears to be one such lockless pgtable walker.
> I suspect the same is possible on other architectures.
> 
> Fix this by only calling pmdp_invalidate() for a present pmd. And for

Yes, this seems like a good design decision (after reading through the
discussion that you all had in the other threads).

> good measure let's add a warning to the generic implementation of
> pmdp_invalidate(). I've manually reviewed all other
> pmdp_invalidate[_ad]() call sites and believe all others to be
> conformant.
> 
> This is a theoretical bug found during code review. I don't have any
> test case to trigger it in practice.
> 
> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> Applies on top of v6.9-rc5. Passes all the mm selftests on arm64.
> 
> Thanks,
> Ryan
> 
> 
>   mm/huge_memory.c     | 5 +++--
>   mm/pgtable-generic.c | 2 ++
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 89f58c7603b2..80939ad00718 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2513,12 +2513,12 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>   	 * for this pmd), then we flush the SMP TLB and finally we write the
>   	 * non-huge version of the pmd entry with pmd_populate.
>   	 */
> -	old_pmd = pmdp_invalidate(vma, haddr, pmd);
> 
> -	pmd_migration = is_pmd_migration_entry(old_pmd);
> +	pmd_migration = is_pmd_migration_entry(*pmd);
>   	if (unlikely(pmd_migration)) {
>   		swp_entry_t entry;
> 
> +		old_pmd = *pmd;
>   		entry = pmd_to_swp_entry(old_pmd);
>   		page = pfn_swap_entry_to_page(entry);
>   		write = is_writable_migration_entry(entry);
> @@ -2529,6 +2529,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>   		soft_dirty = pmd_swp_soft_dirty(old_pmd);
>   		uffd_wp = pmd_swp_uffd_wp(old_pmd);
>   	} else {
> +		old_pmd = pmdp_invalidate(vma, haddr, pmd);

This looks good, except that now I am deeply confused about the pre-existing
logic. I thought that migration entries were a subset of swap entries,
but this code seems to be treating is_pmd_migration_entry() as a
synonym for "is a swap entry". Can you shed any light on this for me?


>   		page = pmd_page(old_pmd);
>   		folio = page_folio(page);
>   		if (pmd_dirty(old_pmd)) {
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index 4fcd959dcc4d..74e34ea90656 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -198,6 +198,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
>   pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>   		     pmd_t *pmdp)
>   {
> +	VM_WARN_ON(!pmd_present(*pmdp));
>   	pmd_t old = pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp));
>   	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>   	return old;
> @@ -208,6 +209,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>   pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
>   			 pmd_t *pmdp)
>   {
> +	VM_WARN_ON(!pmd_present(*pmdp));

Should these be VM_WARN_ON_ONCE(), instead?

Also, this seems like a good place to put a little comment in, to mark the
new design constraint. Something like "Only present entries are allowed
to be invalidated", perhaps.


>   	return pmdp_invalidate(vma, address, pmdp);
>   }
>   #endif
> --
> 2.25.1
> 
> 

thanks,
-- 
John Hubbard
NVIDIA


