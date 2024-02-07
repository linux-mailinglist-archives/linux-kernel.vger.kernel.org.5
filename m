Return-Path: <linux-kernel+bounces-56364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9580E84C946
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 324B3B22616
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1AF1AACF;
	Wed,  7 Feb 2024 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR7gVvcB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0145C19BA5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304379; cv=none; b=ta2pBt3YRo5aT4e6Uc05KxpU2XBQXx82VN3MUL9lGHjUmoY/3Q015idf98PZ722qlef9A2VNoPIsr7t5vnvRWUmUw0COrHl3uAvWZB1wFQh+JsX1tn4Hh1AkOvKvDwJ88ctqsatAtpfu26itR2FpB3qn/JJnWqsxhrHgRSw8M8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304379; c=relaxed/simple;
	bh=Wdwlj8End667TasRIp745gWvCi1r+Z+ho/QV9RjE1iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlWy7tQW+yUV05WcXm4gOG5EBLYT3OxE0Ql+Mwx2wCE6/NPq27k51nA3pun85KXV00xbySP7q8/93WM/sbzC2xFiMbSmbzRR+iAOGc14cc8b4WCfcG7gbqiiBz3WyGg4oX/gmLy1A/e/qyqVvvkLuXKVjO4WTaF8XVii36g4Oy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BR7gVvcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D42EC433F1;
	Wed,  7 Feb 2024 11:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707304378;
	bh=Wdwlj8End667TasRIp745gWvCi1r+Z+ho/QV9RjE1iM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BR7gVvcBwGGbvbZfh7xizzOqoGFPTI0JQWsV7ndm9o6m3Ea8vwZVbv/9ygor6Vx4W
	 qZU5i/hgHxS9F7vgiKb3m/YM9C/JQbILhIG58u0xr8GwjEynXC2o3FUpkX47vTzBi8
	 RT9oYPYnBzc0lcB6QUQLHD0HHuF3CLlRn8+0pMlp4pHpTrSzJvCK8c833CQRRJocLl
	 GFhSagN7yVuG0QqORcjvg+FhmUtwd9Sj+LddWIN4v+MloroBcWy7FADQHVWahafU0g
	 G3+NbfE6o/szBGOVSMw+nHdIA2eEeqzrlm5STgTFp38hcoaDdLcmo9CWKbu4rEa89X
	 xaS/xIlnSDqzg==
Date: Wed, 7 Feb 2024 11:12:52 +0000
From: Will Deacon <will@kernel.org>
To: Nanyong Sun <sunnanyong@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, mike.kravetz@oracle.com,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, willy@infradead.org,
	wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Message-ID: <20240207111252.GA22167@willie-the-truck>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com>
 <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Jan 27, 2024 at 01:04:15PM +0800, Nanyong Sun wrote:
> 
> On 2024/1/26 2:06, Catalin Marinas wrote:
> > On Sat, Jan 13, 2024 at 05:44:33PM +0800, Nanyong Sun wrote:
> > > HVO was previously disabled on arm64 [1] due to the lack of necessary
> > > BBM(break-before-make) logic when changing page tables.
> > > This set of patches fix this by adding necessary BBM sequence when
> > > changing page table, and supporting vmemmap page fault handling to
> > > fixup kernel address translation fault if vmemmap is concurrently accessed.
> > I'm not keen on this approach. I'm not even sure it's safe. In the
> > second patch, you take the init_mm.page_table_lock on the fault path but
> > are we sure this is unlocked when the fault was taken?
> I think this situation is impossible. In the implementation of the second
> patch, when the page table is being corrupted
> (the time window when a page fault may occur), vmemmap_update_pte() already
> holds the init_mm.page_table_lock,
> and unlock it until page table update is done.Another thread could not hold
> the init_mm.page_table_lock and
> also trigger a page fault at the same time.
> If I have missed any points in my thinking, please correct me. Thank you.

It still strikes me as incredibly fragile to handle the fault and trying
to reason about all the users of 'struct page' is impossible. For example,
can the fault happen from irq context?

If we want to optimise the vmemmap mapping for arm64, I think we need to
consider approaches which avoid the possibility of the fault altogether.
It's more complicated to implement, but I think it would be a lot more
robust.

Andrew -- please can you drop these from -next?

Thanks,

Will

