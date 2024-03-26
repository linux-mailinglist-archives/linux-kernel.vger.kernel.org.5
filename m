Return-Path: <linux-kernel+bounces-118330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 737B888B857
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F722C7C87
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0FC1292D9;
	Tue, 26 Mar 2024 03:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a+WcccQg"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0B657314
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711423312; cv=fail; b=dmS28d82zy6LacjmtxuXO2TNOE0WnR6ltTq7LyVpwYDtUEfNDM2Ey8tfZkM5NVa+fkuEtt3MgMsFjer1qmZSkhbwflJMGJxN/B9t9FBLE3gdrPs5C3zA5PpN1NEQH2v2Y9UVq6MakJnuMQFTiGhoCVYpmNY71NuhUKgr3/UWe+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711423312; c=relaxed/simple;
	bh=aTvFEY4CFAiWn2vZxAkUSSxZY20aBO0u9pf9oT195XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qOPYVV2+CKrqJWrrt+OYvIHcGLb0wb8xujQME6qrnX6Tm69w67pghHwNoBcCoR503I1V5AZIQkz/BJAqv72/XumI+aEeqspH+jnjDQx+YIZ+y/TTUu7GdSkg1BEOpT/wPMTP2KieGH0G7vn6ge7aV210hcQ+a1Rbtsvs/Xbhy5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a+WcccQg; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXXEkn3lemGfRZ3K2vJ32ODuPTjciO7L6gqQv76oGTPHH3xk6OM1yUHcbcXQVmQovGoKrP0MdUCmRdZrEA06QzcD6mbs9eqKJhrbQLPL5JYZf5A+2yXp5iC90k+NERohicUYpOykIbwZN5GURkRALtsPxJDBf4y7H8QWo8/0Fj/yWrLtY9RYmT4pOmtdmPyawB8PpVFnCkjpTkJtZXFUUaGH3edr1Qajb60PvwlbpcONn0npwFhiPhA3YUFZP0urF8Qq4qyLJgsCTXyrzAtB3qubFn2tgqvGLXY/ztJmftY+ym2SEkoLv3ivkikgOew0yTalvZZstuafZJMXPG2r1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NV7aG2a83iw/0FpRqbJ3CNrZoSTOlaRaiNBxpPPXh8=;
 b=JbNVY0Qd2JMrCRj1RFxFFOBuVWSqJWSRfaEUvpM2jr9CRqgCIH+QWVGWW3vDUODHK0c4aTwdhpl26Z35QtfJJxdhgfsXdQ0pWoRSECbMF4kRajGRCEEdPxs+FgY085nWdERyqXHn0Q22GvpgEDdIc3b/q/JrUFde3rd4vT7M9o46KG6NDfB4nzAQN6zPoEuZVp2JCESx9YW8igl4gDC0DSn8EOhDt40nNuQ8965ExOAOF2gvSKsjttIxEUunxL/MMCn0wy+oEGCMaxuljNZ1F6dEtwEtRFtIMIialsOinXuYRtjhNWPe3FrItXC70Yrfp4ccXMfCCQvfA7nUqctmdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NV7aG2a83iw/0FpRqbJ3CNrZoSTOlaRaiNBxpPPXh8=;
 b=a+WcccQgiAFXj2/yJYn15uEyW9yyoef99PG8CjnmgLAx+atgcf0lZRt8OFsBvRgQMDyKWfotMQloxNlyUSZrzdZjT9OHbwqh+pSVZ8zpEuBcJpcRNPo8svlZ0MrZ7wqEtWSQAI71WLhBoQkJDBRTk7kUhGScKbzaAk/WhQFE377FBWxf3oQ+nkQgmg/ncxNviXuBuJal/nubjJI2FU+/Dy7UPauwulR1CczpOOf90asew3Ei54h6SwQY4CLXb7oauRgKbOVv9CAYASGiXEnJmFXKjxen5YOZIOEf68WVnMyxRWaH0l0k2xY/Z0nkCzUdMCOsKrIdqBcIwJylx3tgOQ==
Received: from DS7PR06CA0038.namprd06.prod.outlook.com (2603:10b6:8:54::19) by
 PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 03:21:47 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::d7) by DS7PR06CA0038.outlook.office365.com
 (2603:10b6:8:54::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 03:21:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 03:21:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 20:21:29 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 25 Mar
 2024 20:21:28 -0700
Message-ID: <0cba949e-6c77-491a-bc4e-7f52738e0f36@nvidia.com>
Date: Mon, 25 Mar 2024 20:21:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mm: page-flags.h: remove the bias against tail pages
To: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, LKML
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, David Hildenbrand
	<david@redhat.com>, Mike Rapoport <rppt@kernel.org>, Theodore Ts'o
	<tytso@mit.edu>, Vishal Moola <vishal.moola@gmail.com>, Peter Collingbourne
	<pcc@google.com>
References: <20240325045519.222458-1-jhubbard@nvidia.com>
 <ZgEKkd9nc9rdfzCK@casper.infradead.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZgEKkd9nc9rdfzCK@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|PH7PR12MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: d14ec72d-2731-4dca-5f04-08dc4d43dea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sljG1gtMTt4CoRiULjAS6QBCF2lB+AcW+FRu4bh4VFJGrbYWmgKGT+jiTrXf8yL48KxWpmFPlqUiaO0gDM6QSNPuaWvmbcv4mM3AsEomHQ3xE6tWIrPhyQDZKYj3dknbhNNynqpzgBiCp/1tJFVbRHE6RbIzCNUUvqyXDdGWJwVpvx7LL0G83geBQJ1Jzl5Tk4hRp3EDf3KrbGYug+FyRKX+sQjD0G3CpzyJM5KFY0reoLsNqueXIkVaO2ASzzHu/td+6EOBGO/b56A8csbNDwDywP5BqyXqgna2X3nIp46IKeTfDFfcAXFqvjVgVR79VPA5n4nbYziPFveqjm+HT8bIZOCVMxnGSDsWkwgg9f2AMpH8dB+SgF0R6OOgK0AmvBJ+AKnNO9cQ0wx5mBNXtV4tQQ+6fHCFDUiRxWdFAXRYayX1mNspthILKM0boiYu0r+ZxBfGjfhuJeCXrvEGB652ZLQghFaPs8jo1JK0QXIiychdO/cC307Npm0tNwB0dwslJKh1bwR4YXC318iFe9Bg31tbu1OTqPYMe5TjahnLZG5TzIH2kCPN/Pre/IOT/bMxqXl5q9dtwt/0u3jS6JgsqB1/gIbDXsoxpwUF3or0392aqi9V8SiI6rdV/G+FGb6dXykB63qf6RmvmsrAfG9c+SP5wZvbs9LxHeg3trAyJRUSUTmy4tKE12N6yUJqvn9oK0455nW7Kjo43zALb7NYDiO3oWTSpvLPB3KnKSi41AtaH0k41Clv5R459jRW
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 03:21:47.2085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d14ec72d-2731-4dca-5f04-08dc4d43dea8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710

On 3/24/24 10:24 PM, Matthew Wilcox wrote:
..
> It's complicated.  On the one hand, it's "more likely" because there are
> more tail pages than there are head pages or order-0 pages.  On the
> other hand, a _lot_ of the time we call compound_head(), it's done with
> a non-tail page because we tend to pass around head pages (eg,

ah yes, that's true.

> pmd_page() on hugetlbfs, or looking up a folio in the page cache and
> passing &folio->page to some function that's not yet converted.
> 
> On the third hand, does the compiler really do much with the annotation?
> 
> Before your patch:
> 
>      27d6:       a8 01                   test   $0x1,%al
>      27d8:       75 02                   jne    27dc <clear_refs_pte_range+0x9c>

I should have thought to check this. Usually I'll see a change between je/jne
if __builtin_expect is doing its job. Here it is, oddly, missing in action.

Maybe I'll look a little closer into why that is...

>      27da:       eb 59                   jmp    2835 <clear_refs_pte_range+0xf5>
>      27dc:       49 8b 44 24 08          mov    0x8(%r12),%rax
>      27e1:       a8 01                   test   $0x1,%al
>      27e3:       75 6f                   jne    2854 <clear_refs_pte_range+0x114>
>      27e5:       eb 73                   jmp    285a <clear_refs_pte_range+0x11a>
> 
> With your patch:
> 
>      1ee6:       a8 01                   test   $0x1,%al
>      1ee8:       75 02                   jne    1eec <clear_refs_pte_range+0x9c>
>      1eea:       eb 5f                   jmp    1f4b <clear_refs_pte_range+0xfb>
>      1eec:       49 8b 44 24 08          mov    0x8(%r12),%rax
>      1ef1:       a8 01                   test   $0x1,%al
>      1ef3:       75 50                   jne    1f45 <clear_refs_pte_range+0xf5>
>      1ef5:       eb 6c                   jmp    1f63 <clear_refs_pte_range+0x113>
> 
> Looks pretty much the same.  bloat-o-meter says:
> 
> $ ./scripts/bloat-o-meter before.o after.o
> add/remove: 0/0 grow/shrink: 2/4 up/down: 32/-48 (-16)
> Function                                     old     new   delta
> gather_stats.constprop                       730     753     +23
> smaps_hugetlb_range                          635     644      +9
> smaps_page_accumulate                        342     338      -4
> clear_refs_pte_range                         339     328     -11
> pagemap_hugetlb_range                        422     407     -15
> smaps_pte_range                             1406    1388     -18
> Total: Before=20066, After=20050, chg -0.08%
> 
> (I was looking at clear_refs_pte_range above).  This seems marginal.
> The benefits of removing a call to compound_head are much less
> ambiguous:
> 
> $ ./scripts/bloat-o-meter before.o .build/fs/proc/task_mmu.o
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-101 (-101)
> Function                                     old     new   delta
> clear_refs_pte_range                         339     238    -101
> Total: Before=20066, After=19965, chg -0.50%
> 
> I'd describe that as replacing four calls to compound_head() with two:
> 
> -               page = pmd_page(*pmd);
> +               folio = page_folio(pmd_page(*pmd));
> 
>                  /* Clear accessed and referenced bits. */
>                  pmdp_test_and_clear_young(vma, addr, pmd);
> -               test_and_clear_page_young(page);
> -               ClearPageReferenced(page);
> +               folio_test_clear_young(folio);
> +               folio_clear_referenced(folio);
> ...
> -               page = vm_normal_page(vma, addr, ptent);
> -               if (!page)
> +               folio = vm_normal_folio(vma, addr, ptent);
> +               if (!folio)
>                          continue;
> 
>                  /* Clear accessed and referenced bits. */
>                  ptep_test_and_clear_young(vma, addr, pte);
> -               test_and_clear_page_young(page);
> -               ClearPageReferenced(page);
> +               folio_test_clear_young(folio);
> +               folio_clear_referenced(folio);
> 
> I'm not saying this patch is necessarily wrong, I just think it's
> "not proven".

I appreciate your looking at this and explaining the analysis steps
you used!


thanks,
-- 
John Hubbard
NVIDIA


