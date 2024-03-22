Return-Path: <linux-kernel+bounces-111857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DB88871CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34139284CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245025FBA1;
	Fri, 22 Mar 2024 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp+0MqbN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672085D752
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127700; cv=none; b=jhEnObTWA+4llOn0S440ZoqaDtNiRgo5c3CUXUQa4xsaLWq7yQAPdxz5PRDGfI6TVhWCj+Grerwab5as9ac7C5nJK7dRnyQjqV4oIbg/wt8cIW+vUaQUiKCeysJGperyQHnEQC+X5S7z/q4agkxR5xY/Hbu+hyGb812uhuDBN/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127700; c=relaxed/simple;
	bh=C8GD9fG22TLIZK0yuUnEPTKbqHoBiCuXP/x09X9W/Os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FQuA0PMoCzJAfSUH0woqBXo9xoWotiK7246VoN8y0VAKFQwAnR679xPgMFgwUvVFu8jMHqjeRJoW9Q9x9pMPcw05bjUuZWIpqaOwep15BPrTyKFjOgEakB6U+A5kSaeXYc7wPhQPNtXLLA3xKXgfgX/2TJzVa1uharnsqORzH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp+0MqbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE9BC433F1;
	Fri, 22 Mar 2024 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711127699;
	bh=C8GD9fG22TLIZK0yuUnEPTKbqHoBiCuXP/x09X9W/Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cp+0MqbN/avd7Y97uUQSY5e3e9KLVDxkhGPn+yWRI0D04F60iun6Ic766AOtiq+Md
	 hbLUwftVGSSMtsA0ZZKPudwZqFCd+lo0SsIZJB1oXC/WFV4GXZB8YLu5zC2yPiOhjr
	 5BMLpXMMG1ZsWtHf0qcbGDiiKeFIJqzhIDyOUzJVdE/6IImQGRiyzKh9HaM766Mex1
	 s+nFrDQl3Y7IMmiSt07qyqGMJr3O/WR4llweHd32XwKcWLG0J7BQM/mZ/iBnSlmSeA
	 p28TSop2p+oI1SaFWDwF3ryu/RLJndxMfx3mRvQNCX5A2N3t/GOQPwJibZJp9E2p5n
	 mg6iv/YIR0f1w==
From: SeongJae Park <sj@kernel.org>
To: peterx@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yang Shi <shy828301@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Andrew Jones <andrew.jones@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	linux-riscv@lists.infradead.org,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 03/12] mm: Make HPAGE_PXD_* macros even if !THP
Date: Fri, 22 Mar 2024 10:14:56 -0700
Message-Id: <20240322171456.118997-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240321220802.679544-4-peterx@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Peter,

On Thu, 21 Mar 2024 18:07:53 -0400 peterx@redhat.com wrote:

> From: Peter Xu <peterx@redhat.com>
> 
> These macros can be helpful when we plan to merge hugetlb code into generic
> code.  Move them out and define them even if !THP.
> 
> We actually already defined HPAGE_PMD_NR for other reasons even if !THP.
> Reorganize these macros.
> 
> Reviewed-by: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/huge_mm.h | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index de0c89105076..3bcdfc7e5d57 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -64,9 +64,6 @@ ssize_t single_hugepage_flag_show(struct kobject *kobj,
>  				  enum transparent_hugepage_flag flag);
>  extern struct kobj_attribute shmem_enabled_attr;
>  
> -#define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
> -#define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
> -
>  /*
>   * Mask of all large folio orders supported for anonymous THP; all orders up to
>   * and including PMD_ORDER, except order-0 (which is not "huge") and order-1
> @@ -87,14 +84,19 @@ extern struct kobj_attribute shmem_enabled_attr;
>  #define thp_vma_allowable_order(vma, vm_flags, smaps, in_pf, enforce_sysfs, order) \
>  	(!!thp_vma_allowable_orders(vma, vm_flags, smaps, in_pf, enforce_sysfs, BIT(order)))
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define HPAGE_PMD_SHIFT PMD_SHIFT
>  #define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
>  #define HPAGE_PMD_MASK	(~(HPAGE_PMD_SIZE - 1))
> +#define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
> +#define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>  
>  #define HPAGE_PUD_SHIFT PUD_SHIFT
>  #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
>  #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
> +#define HPAGE_PUD_ORDER (HPAGE_PUD_SHIFT-PAGE_SHIFT)
> +#define HPAGE_PUD_NR (1<<HPAGE_PUD_ORDER)

I just found latest mm-unstable fails one of my build configurations[1] with
below error.  'git bisect' says this is the first patch set started the
failure.  I haven't looked in deep, but just reporting first.

    In file included from .../include/linux/mm.h:1115,
                     from .../mm/vmstat.c:14:
    .../mm/vmstat.c: In function 'zoneinfo_show_print':
    .../include/linux/huge_mm.h:87:25: error: 'PMD_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
       87 | #define HPAGE_PMD_SHIFT PMD_SHIFT
          |                         ^~~~~~~~~

[1] https://github.com/awslabs/damon-tests/blob/next/corr/tests/build_m68k.sh


Thanks,
SJ

[...]

