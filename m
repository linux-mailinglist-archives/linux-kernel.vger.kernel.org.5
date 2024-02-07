Return-Path: <linux-kernel+bounces-56495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 556D284CAD3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA441F263CA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E652076035;
	Wed,  7 Feb 2024 12:44:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800565A0FE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707309892; cv=none; b=bLIXcQnTo7DK0ybQOllli/xQsv4tMSwj4wiEWXWHB1FbS3CBatusPb94efjrDp6XADfpK34vS0S9yPKxrAzNPMbIS22porW2dq0Ie7fkGExIib4P0lElD2UlWmfLwspukBS4tXbPV90XuDlNjielTFav224Q1ZPmPO24apsECa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707309892; c=relaxed/simple;
	bh=tYbPcf5/6y9sgM4sHZP3ACfjVZvEn18ioeEU0QslSmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA0M25swm2Ty9T/QQSfyCiXfXgP3gRvP55GLOnGsGCYKDWI8Hww+wCH4shbT4B0DVgz85/evbqB3fqvbpCEYrjNiuRJduXuhv/2Euvn2NXP5fxXpz8TRvM+6/I/bzSTptmoz7VwPDe676P2tgPWQBVrqc3LBLSyaegAa5o2diG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21937C433C7;
	Wed,  7 Feb 2024 12:44:49 +0000 (UTC)
Date: Wed, 7 Feb 2024 12:44:47 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Nanyong Sun <sunnanyong@huawei.com>
Cc: will@kernel.org, mike.kravetz@oracle.com, muchun.song@linux.dev,
	akpm@linux-foundation.org, anshuman.khandual@arm.com,
	willy@infradead.org, wangkefeng.wang@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Message-ID: <ZcN7P0CGUOOgki71@arm.com>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com>
 <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>

On Sat, Jan 27, 2024 at 01:04:15PM +0800, Nanyong Sun wrote:
> On 2024/1/26 2:06, Catalin Marinas wrote:
> > On Sat, Jan 13, 2024 at 05:44:33PM +0800, Nanyong Sun wrote:
> > > HVO was previously disabled on arm64 [1] due to the lack of necessary
> > > BBM(break-before-make) logic when changing page tables.
> > > This set of patches fix this by adding necessary BBM sequence when
> > > changing page table, and supporting vmemmap page fault handling to
> > > fixup kernel address translation fault if vmemmap is concurrently accessed.
[...]
> > How often is this code path called? I wonder whether a stop_machine()
> > approach would be simpler.
> As long as allocating or releasing hugetlb is called.  We cannot limit users
> to only allocate or release hugetlb
> when booting or not running any workload on all other cpus, so if use
> stop_machine(), it will be triggered
> 8 times every 2M and 4096 times every 1G, which is probably too expensive.

I'm hoping this can be batched somehow and not do a stop_machine() (or
8) for every 2MB huge page.

Just to make sure I understand - is the goal to be able to free struct
pages corresponding to hugetlbfs pages? Can we not leave the vmemmap in
place and just release that memory to the page allocator? The physical
RAM for those struct pages isn't going anywhere, we just have a vmemmap
alias to it (cacheable).

-- 
Catalin

