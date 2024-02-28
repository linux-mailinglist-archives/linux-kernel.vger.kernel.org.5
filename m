Return-Path: <linux-kernel+bounces-85100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF4986B06B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC2A1C2310D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A2F14EFC8;
	Wed, 28 Feb 2024 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cfYPShaB"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DC773508
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127199; cv=none; b=dJKR6IOwscXQyDeha3X2yo+i3qxFwUBq8mFwEfwAkXdZVMDpETPbHQn4kJQ5rQXmz1tOs6pJPmpQmTEwLrNuX5gKp7/vLkkbObjWPOnWDAafnsXKkUlFxEhWqJuUJ/JoCzdidV8PIkONRzTDS0iwQLQr7G4UJDnLKCyj3Ktoa0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127199; c=relaxed/simple;
	bh=AjWhWK6kL+qa7DABredawGrpT+KD+kEFZgYt1FLpsTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVkyh1rj6lvmbUwa29TnKa4OYCaWnOu9eIEIYM30KYTQYaPTpNRNpx8QRVuGRv40TqjcvXX9CXT/T+scblvejHxujGTwyc+FvnmT/OGy/zX4ok8ZVG3W+43LZUVouqqkzhyXOnKTN49J6MUScejfAWPkSeF/NBQQCwPKmf0NwI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cfYPShaB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gE7WXCW4sHHdaSD3CrkGZl7RnEWGc2o16ILT5WmQT9k=; b=cfYPShaBCFKG5H3lJEWeK03Fwg
	NkAPCiwppnQYq1++VeE/d2gryeTJeS5Er15XTcVthZra4D1mwogZ9EKhaVOy0gjm4DjzKo53oizz8
	TWg7Uj6elftCJzM28DEj9TlYmGMHl6RvL9lfqmpdFafsaPo8QhdPY+5oa2v7BsR01xNW2mpR1YGda
	+L5T0uShwPKBKoZsmxU8RRJZOebpO1L+yol/RQeesATMQ+JyzkL9MEd5BvU0MJmIjsYhMxZZxy2XO
	osDWPCvIF27mWLZO0ccKQfXeIS07wosJv3/OTYIHmK5r4beV7ZLpSiIjeSZB/yN4ECmMDQuZTpe92
	X5O9Du4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfK3a-00000005Ino-219V;
	Wed, 28 Feb 2024 13:33:10 +0000
Date: Wed, 28 Feb 2024 13:33:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>,
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/4] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
Message-ID: <Zd82FqN7qxuBUSvl@casper.infradead.org>
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20231025144546.577640-2-ryan.roberts@arm.com>
 <d108bd79-086b-4564-838b-d41afa055137@redhat.com>
 <6541e29b-f25a-48b8-a553-fd8febe85e5a@redhat.com>
 <ee760679-7e3c-4a35-ad53-ca98b598ead5@arm.com>
 <ba9101ae-a618-4afc-9515-a61f25376390@arm.com>
 <2934125a-f2e2-417c-a9f9-3cb1e074a44f@redhat.com>
 <049818ca-e656-44e4-b336-934992c16028@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <049818ca-e656-44e4-b336-934992c16028@arm.com>

On Wed, Feb 28, 2024 at 09:37:06AM +0000, Ryan Roberts wrote:
> Fundamentally, we would like to be able to figure out the size of the swap slot
> from the swap entry. Today swap supports 2 sizes; PAGE_SIZE and PMD_SIZE. For
> PMD_SIZE, it always uses a full cluster, so can easily add a flag to the cluster
> to mark it as PMD_SIZE.
> 
> Going forwards, we want to support all sizes (power-of-2). Most of the time, a
> cluster will contain only one size of THPs, but this is not the case when a THP
> in the swapcache gets split or when an order-0 slot gets stolen. We expect these
> cases to be rare.
> 
> 1) Keep the size of the smallest swap entry in the cluster header. Most of the
> time it will be the full size of the swap entry, but sometimes it will cover
> only a portion. In the latter case you may see a false negative for
> swap_page_trans_huge_swapped() meaning we take the slow path, but that is rare.
> There is one wrinkle: currently the HUGE flag is cleared in put_swap_folio(). We
> wouldn't want to do the equivalent in the new scheme (i.e. set the whole cluster
> to order-0). I think that is safe, but haven't completely convinced myself yet.
> 
> 2) allocate 4 bits per (small) swap slot to hold the order. This will give
> precise information and is conceptually simpler to understand, but will cost
> more memory (half as much as the initial swap_map[] again).
> 
> I still prefer to avoid this at all if we can (and would like to hear Huang's
> thoughts). But if its a choice between 1 and 2, I prefer 1 - I'll do some
> prototyping.

I can't quite bring myself to look up the encoding of swap entries
but as long as we're willing to restrict ourselves to naturally aligning
the clusters, there's an encoding (which I believe I invented) that lets
us encode arbitrary power-of-two sizes with a single bit.

I describe it here:
https://kernelnewbies.org/MatthewWilcox/NaturallyAlignedOrder

Let me know if it's not clear.

