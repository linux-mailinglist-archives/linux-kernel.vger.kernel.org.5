Return-Path: <linux-kernel+bounces-150882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183CD8AA62E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496F91C2157E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B7B383;
	Fri, 19 Apr 2024 00:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xry8L2Qk"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A377F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713485761; cv=fail; b=gihT3I4Sl0Eo56L6KfgTGnrTVI8wnrWAEbLj3CnYM0GgCGJ26jGpadK/1eKjRZ81LUjNCzCVLKioH+EVLDGaAUhGtlm7unrCR6TaOMJozsz4KMxB4PDEXgTd6mN65B5vC+anUjMj/SJgSBx8cQS+0YbJT3XSyfr7VnpWLIEFINs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713485761; c=relaxed/simple;
	bh=9xmk5ugA4WJw4+9e9LaRE/2RwOiywQUPSe8D5BqnpP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e5nY3e8n1KqrbqBXr5sG8upQcVpvKcG+4oaXBI6EZOoHZO/dS9ZJz+IwCUcZpHDbNlv74R30j6XWqvUU2zWscc/Ug6LVHy1jXj+y+gs9vQ7yLc6xDv0XcDA5tJH5/a4URa/Z2aTmRPm0BAAqPYzEUk5XCMwNPH2Fy4QU5cnywqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xry8L2Qk; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDnSCX9j0T9CqYAFwswcWYMZJgfjvd1chkwZ0rSGUzPD1SqdMfb2jzZrU1eV8JYX2O/3KkuWglPdoqfJhR4n4N9Cl08hzSOFFoFBf+OxRRSOWfxBilSOxcjuCNK+Gva1p1noGyrw9zxReR2BqYbfb8G3Ddd/eZSmehE0PdJur3h/AgfvJUbF4wJ5lrqWNnZa6WzEbeUQibjLeBaBnC4MPruEmJC9CK+UvPZR8OTKjM7SirYx1wMZEAe2aW13MJ7aTH5YhBopG5m635itwSka2oLz4qBr3flDwRYTspm6xnwrT01R9VUplY7X7qMUvBU6lxleAvoBylOf1MhM1Eg+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKP4VwI59ScFsINIRtSMAH4h8kpgnF9fuqhaI+N6GxM=;
 b=CzheLyB1aTWokg5RToMzLUlayODgM4MsTON0H3UNArqw1NxC/XntXBAlQf6DfA1Sy+f6Czyp3wOLkl0La8TVdddfNjJIaFockGX4PHvfEGWpnFUnzGrfPB4J7Z7yL5IEzf6MJB+tTX2ciZd++a7Ni6UobIYZWezdllpp+JTEgmhDR0pORQWBK4sqL8WO9dDWu1hcPEeD4OFwTR9jPmH/FLtzTBgC14Ge+IgKGxcjqafVj3TRJKj9r3blh1KFBBhuYr3mmFxDN8wqcYg2YhDNsy1AcQMMo1vhfm2xvCxFjZUI7EOxf7N7QqjEtzLRx8BJXEJzwxN3ZVyZegtgqGmf7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKP4VwI59ScFsINIRtSMAH4h8kpgnF9fuqhaI+N6GxM=;
 b=Xry8L2QkBMFivjcQ3Vt3PdSrNRXPKql1oYWasQachaTmlhfO5E3c695VhRAeBDkt8DYOIvjwAMiFmI5qOMOKlxORkR7ABXY/fCaFFR015lI4+X+dbt1Ot7nD9JtHAuA2QgQpm6A2MZIyaMC30XpZ5APKibMgozM6rI7jzK5kqAYoBFIGtfaMbAPLY5G7kvE4bZ7J7br+OqmxAPd0EAAb21e3xgq0erdsX7JB5xkkyQ9JGTqPMZ1SF+O+EDGUwm7aaHoHzghLF+9hatISGnhNhjjkjuiholE2VaajbemlS0lkPAEjeDoCaFczCxAHutNm5dA3wiH8H9x2mGEV6oVCmQ==
Received: from BY5PR16CA0015.namprd16.prod.outlook.com (2603:10b6:a03:1a0::28)
 by BL3PR12MB6379.namprd12.prod.outlook.com (2603:10b6:208:3b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Fri, 19 Apr
 2024 00:15:56 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::be) by BY5PR16CA0015.outlook.office365.com
 (2603:10b6:a03:1a0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.28 via Frontend
 Transport; Fri, 19 Apr 2024 00:15:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 00:15:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 17:15:44 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 17:15:43 -0700
Message-ID: <18faa967-4fbc-4694-a7f7-02c3887ee6f3@nvidia.com>
Date: Thu, 18 Apr 2024 17:15:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/huge_memory: improve
 split_huge_page_to_list_to_order() return value documentation
To: David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, Zi Yan <ziy@nvidia.com>, Matthew Wilcox
	<willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20240418151834.216557-1-david@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240418151834.216557-1-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|BL3PR12MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e956316-6653-446e-5a8d-08dc6005e1d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oY768hhXXP/8RdsEIfKt32LNUvS3UObEIUUoL3hq5h9vVIhRqItx/99E4K/3CXPY0iiwE5253Tgawm9qdE/7uv87MJbfO11sldTXntqA1H5hTcmfv1Ng9y5/wyGAqCYKNEkuNeq6FJJ1GOtR2QcKq2kT29x97Jj8FUA6k2xzJptTSGHYvAUygY/dR2Oi6sHNd6X7tvvOQjdUa/c2It0UAq6f4kXsQi945q19f1Al6lwT2zm3EiRbf1Mt3IJz34216apU3LNEg2UJYnFOIqjYryZia8ilj7mUYdE9B+71BSi88mrvuVLs7JoCQLjk5iYodIRHY3mByjrRiT//4RiDwB0+YZ+ZLbVcNUgGqTGBgbDpaS1FJNRGG8/9lCbRdFPTOl7LMYT/Bd5GD525YqwbfF4/+XaR7915FVADdeSHDdNPdyMiQFaD8q7ZSd0aLK4IT3O32lI1HNvvKvhcgplPmz/Iu9Rb6Sw1SVTfu281qCSjmH27TgJgBRlBB58lStHrYa8Kj+lVMew3RLmekNz8Rcv5gkbqrGJKx++RmT3xFzDUC2Ju7T6N8wx/3XvbjGPzvEUMmti2XyT2kQoAR07IElWGIbMqdx2qJh0vO9iVZbeSfxyOAu+eE0RDXm2BMajleOPrizZ/Jo3+JnFaXA8q5vtDCbDeIincFZJQd9SUfLNEOKnNPEdzQlm6TvbW9CNqxIHSUtxtQAIpQpkqTxaTCp7G26KBIpI+YtdRSmE2RaiEbtmBOzi/E+SjUKQsSiPN
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 00:15:55.9242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e956316-6653-446e-5a8d-08dc6005e1d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6379

On 4/18/24 8:18 AM, David Hildenbrand wrote:
> The documentation is wrong and relying on it almost resulted in BUGs
> in new callers: we return -EAGAIN on unexpected folio references, not
> -EBUSY.
> 
> Let's fix that and also document which other return values we can
> currently see and why they could happen.
> 
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/huge_memory.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ee12726291f1b..824eff9211db8 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2956,7 +2956,7 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
>    *
>    * 3) The folio must not be pinned. Any unexpected folio references, including
>    *    GUP pins, will result in the folio not getting split; instead, the caller
> - *    will receive an -EBUSY.
> + *    will receive an -EAGAIN.
>    *
>    * 4) @new_order > 1, usually. Splitting to order-1 anonymous folios is not
>    *    supported for non-file-backed folios, because folio->_deferred_list, which
> @@ -2975,8 +2975,15 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)

As an aside, the use of unconditional local_irq_disable() / local_irq_enable()
calls in this routine almost makes me believe that we should have:

5) Local IRQs should be enabled. Because this routine may enable them.

..but I can't imagine a way to end up calling this with interrupts
disabled, so it seems like documentation overkill. Just thought I'd mention
it, though.


>    *
>    * Returns 0 if the huge page was split successfully.
>    *
> - * Returns -EBUSY if @page's folio is pinned, or if the anon_vma disappeared
> - * from under us.
> + * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP).

..or if the folio was removed from the page cache before this routine
got a chance to lock it, right? (See the "fail:" path.)

> + *
> + * Returns -EBUSY when trying to split the huge zeropage, if the folio is
> + * under writeback, if fs-specific folio metadata cannot currently be
> + * released, or if some unexpected race happened (e.g., anon VMA disappeared,
> + * truncation).
> + *
> + * Returns -EINVAL when trying to split to an order that is incompatible
> + * with the folio. Splitting to order 0 is compatible with all folios.
>    */
>   int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   				     unsigned int new_order)

Otherwise, looks good.


thanks,
-- 
John Hubbard
NVIDIA


