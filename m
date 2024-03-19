Return-Path: <linux-kernel+bounces-107006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5235287F69F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2121C21749
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9233044362;
	Tue, 19 Mar 2024 05:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIabAbsx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF1C40840;
	Tue, 19 Mar 2024 05:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710825657; cv=none; b=m9xqiCZlVi0tslIbAS06Rb1iuMS4583x4vboYXBbdFts7h/lD42mtoSQmQN1BL/Cdl8qOvOGmp/xV6axfJ8qT1lM2XWbeqg7N0U2yHwGYDaNbhG2zIlUrYb74PwgtnfY9uIfvpu8z0VYEvPwPr6CBW+BZoA/nw0K5juGZbrT8Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710825657; c=relaxed/simple;
	bh=hBlc98ZU7iS6QBgU4Jg0QOLR8hqybTayY7drOjbgZRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ruMA40WPjwb3Glq2tNlcBIypADEY4MD9m7mK4+rXhlgBpf6nj3VckZV+9SGi8aTjJzBzP2vos50F+NCsuX8MLSqH8Nq/20Pu+Zg+0IwVvaSBrKw2DkbKEkMvxjIe5os8E+ewtVjk1Kcp4Ftx94KJTtI7pa6mpiWdd3ZXGbEQyoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIabAbsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5ACC433F1;
	Tue, 19 Mar 2024 05:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710825657;
	bh=hBlc98ZU7iS6QBgU4Jg0QOLR8hqybTayY7drOjbgZRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EIabAbsxz4AlBKjBE8CPsPszrrZwRz34fuqvI0+tjTRvYX55jh52au47RmQ0+HYrZ
	 7CdIKIDBltmVySq76+tW3C0Z7b8wQUDkOVOSTYQh5mOJaRBnIqLUAdS6b51tIJf6go
	 775Gfutb/Jcl9h/ISooAC5dP/2pPnBFYVu4ncmxrlMk2NPtxn0oO2a5zmkoNmGOoKK
	 2g4IOZl0AAH5bC3YZ/iR/Lnm1NiMqS8AElUuttRrgE46/4rcjKJqKnbqw6KYlLXrfE
	 U+9WQw6tBVdOwuXnzCGOweEqu/bDkGd87YMMJMNJ9vacvx+4u60Yz6EZfi+1Dmdkdz
	 iqQPq3wjBs1nA==
From: SeongJae Park <sj@kernel.org>
To: Aravinda Prasad <aravinda.prasad@intel.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org,
	linux-kernel@vger.kernel.org,
	s2322819@ed.ac.uk,
	sandeep4.kumar@intel.com,
	ying.huang@intel.com,
	dave.hansen@intel.com,
	dan.j.williams@intel.com,
	sreenivas.subramoney@intel.com,
	antti.kervinen@intel.com,
	alexander.kanevskiy@intel.com
Subject: Re: [PATCH v2 0/3] mm/damon: Profiling enhancements for DAMON
Date: Mon, 18 Mar 2024 22:20:54 -0700
Message-Id: <20240319052054.100167-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240318132848.82686-1-aravinda.prasad@intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Aravinda,


Thank you for posting this new revision!

I remember I told you that I don't see a high level significant problems on on
the reply to the previous revision of this patch[1], but I show a concern now.
Sorry for not raising this earlier, but let me explain my humble concerns
before being even more late.

On Mon, 18 Mar 2024 18:58:45 +0530 Aravinda Prasad <aravinda.prasad@intel.com> wrote:

> DAMON randomly samples one or more pages in every region and tracks
> accesses to them using the ACCESSED bit in PTE (or PMD for 2MB pages).
> When the region size is large (e.g., several GBs), which is common
> for large footprint applications, detecting whether the region is
> accessed or not completely depends on whether the pages that are
> actively accessed in the region are picked during random sampling.
> If such pages are not picked for sampling, DAMON fails to identify
> the region as accessed. However, increasing the sampling rate or
> increasing the number of regions increases CPU overheads of kdamond.

DAMON uses sampling because it considers a region as accessed if a portion of
the region that big enough to be detected via sampling is all accessed.  If a
region is having some pages that really accessed but the proportion is too
small to be found via sampling, I think DAMON could say the overall access to
the region is only modest and could even be ignored.  In my humble opinion,
this fits with the definition of DAMON region: A memory address range that
constructed with pages having similar access frequency.

> 
> This patch proposes profiling different levels of the application\u2019s
> page table tree to detect whether a region is accessed or not. This
> patch set is based on the observation that, when the accessed bit for a
> page is set, the accessed bits at the higher levels of the page table
> tree (PMD/PUD/PGD) corresponding to the path of the page table walk
> are also set. Hence, it is efficient to check the accessed bits at
> the higher levels of the page table tree to detect whether a region
> is accessed or not. For example, if the access bit for a PUD entry
> is set, then one or more pages in the 1GB PUD subtree is accessed as
> each PUD entry covers 1GB mapping. Hence, instead of sampling
> thousands of 4K/2M pages to detect accesses in a large region, 
> sampling at the higher level of page table tree is faster and efficient.

Due to the above reason, I concern this could result in making DAMON monitoring
results be inaccurately biased to report more than real accesses.

> 
> This patch set is based on 6.8-rc5 kernel (commit: f48159f8, mm-unstable
> tree)
> 
> Changes since v1 [1]
> ====================
> 
>  - Added support for 5-level page table tree
>  - Split the patch to mm infrastructure changes and DAMON enhancements
>  - Code changes as per comments on v1
>  - Added kerneldoc comments
> 
> [1] https://lkml.org/lkml/2023/12/15/272
>  
> Evaluation:
> 
> - MASIM benchmark with 1GB, 10GB, 100GB footprint with 10% hot data
>   and 5TB with 10GB hot data.
> - DAMON: 5ms sampling, 200ms aggregation interval. Rest all
>   parameters set to default value.
> - DAMON+PTP: Page table profiling applied to DAMON with the above
>   parameters.
> 
> Profiling efficiency in detecting hot data:
> 
> Footprint	1GB	10GB	100GB	5TB
> ---------------------------------------------
> DAMON		>90%	<50%	 ~0%	  0%
> DAMON+PTP	>90%	>90%	>90%	>90%

Sampling interval is the time interval that assumed to be large enough for the
workload to make meaningful amount of accesses within the interval.  Hence,
meaningful amount of sampling interval depends on the workload's characteristic
and system's memory bandwidth.

Here, the size of the hot memory region is about 100MB, 1GB, 10GB, and 10GB for
the four cases, respectively.  And you set the sampling interval as 5ms.  Let's
assume the system can access, say, 50 GB per second, and hence it could be able
to access only up to 250 MB per 5ms.  So, in case of 1GB and footprint, all hot
memory region would be accessed while DAMON is waiting for next sampling
interval.  Hence, DAMON would be able to see most accesses via sampling.  But
for 100GB footprint case, only 250MB / 10GB = about 2.5% of the hot memory
region would be accessed between the sampling interval.  DAMON cannot see whole
accesses, and hence the precision could be low.

I don't know exact memory bandwith of the system, but to detect the 10 GB hot
region with 5ms sampling interval, the system should be able to access 2GB
memory per millisecond, or about 2TB memory per second.  I think systems of
such memory bandwidth is not that common.

I show you also explored a configuration setting the aggregation interval
higher.  But because each sampling checks only access between the sampling
interval, that might not help in this setup.  I'm wondering if you also
explored increasing sampling interval.

Sorry again for finding this concern not early enough.  But I think we may need
to discuss about this first.

[1] https://lkml.kernel.org/r/20231215201159.73845-1-sj@kernel.org


Thanks,
SJ


> 
> CPU overheads (in billion cycles) for kdamond:
> 
> Footprint	1GB	10GB	100GB	5TB
> ---------------------------------------------
> DAMON		1.15	19.53	3.52	9.55
> DAMON+PTP	0.83	 3.20	1.27	2.55
> 
> A detailed explanation and evaluation can be found in the arXiv paper:
> https://arxiv.org/pdf/2311.10275.pdf
> 
> 
> Aravinda Prasad (3):
>   mm/damon: mm infrastructure support
>   mm/damon: profiling enhancement
>   mm/damon: documentation updates
> 
>  Documentation/mm/damon/design.rst |  42 ++++++
>  arch/x86/include/asm/pgtable.h    |  20 +++
>  arch/x86/mm/pgtable.c             |  28 +++-
>  include/linux/mmu_notifier.h      |  36 +++++
>  include/linux/pgtable.h           |  79 ++++++++++
>  mm/damon/vaddr.c                  | 233 ++++++++++++++++++++++++++++--
>  6 files changed, 424 insertions(+), 14 deletions(-)
> 
> -- 
> 2.21.3

