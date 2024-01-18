Return-Path: <linux-kernel+bounces-30168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3AC831AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C641F24DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B53425760;
	Thu, 18 Jan 2024 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f9C8gWyt"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9AA25750
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705585969; cv=none; b=YYB/7Zie8uGBV9UdC6PKVQjcy77FbLEWnc5jH0oo9yKaiZLGVNjjTc1/FRteNfXnIh2gGGUJzP7z+ku9+PuqTZIeMN2dcM2U+zQ7NAz8cbq0uDUMd6XTR/xVEGHj5bLQGcKZyczDxU1cG9WRr97ojAJESWCFEyyfWim+qKb3M0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705585969; c=relaxed/simple;
	bh=IW1xp/zSK75TUUrkIaLH/h5dTGlIYGYeVzMXhC7sDp8=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=iCX6CI2WV84pqR7/8QaDvkBwJhhT8C3qlEf478UPwG24B9+l8dvQ7uXaRnGiWWu04PJrFPNKUOJ01v/GutHQYfRNB9yglrslJtjzjylAazn7H+EPgr8eK7haI8Jq2IOUc36T+gqoWdkJbxtfN83L9wvtgY8qM6Y+/tlN/Bkm3Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f9C8gWyt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W9/7D8zr0MVRfo04WFLM2Hg/uD4l3zgSP1ZQDm3F38c=; b=f9C8gWytSlHaoCzve+NEsrEN0e
	n8GeYnFhf3w7fe6Xw8td+APR8rQXPLRwAF7vCPFKWGXjIaRjskZQJ7IsNalOZHxSiZk47mk2LSHAu
	kuKrRDc1n2Qpgu26poeGELzxdXMKzUMwCyUyPlXV2zIuEPmDSbxFUUDbHvejN/lhDr5kFGBZoNGtE
	uPqdWKoRVl58HFQjNZ/83Np9JhKExqqraKnhnOEBoS5sFsc8cZveEvgYe560um2sl3qADr9tyMwXa
	KwS39DRsbH5X6UfN3pO3ONh7noHCZxZo7ImWO6a6EsYtjPTo+bMGVcX9V1fNtfSdCGpjn2FnvznND
	ftuH64Ig==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQSop-00000002JMU-2dbI;
	Thu, 18 Jan 2024 13:52:31 +0000
Date: Thu, 18 Jan 2024 13:52:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Wei =?utf-8?B?WHXvv7w=?= <weixugc@google.com>,
	Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Suren =?utf-8?B?QmFnaGRhc2FyeWFu77+8?= <surenb@google.com>,
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Huang Ying <ying.huang@intel.com>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kairui Song <kasong@tencent.com>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Barry Song <v-songbaohua@oppo.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH 1/2] mm: zswap.c: add xarray tree to zswap
Message-ID: <ZaktH7xc72x4Xr3d@casper.infradead.org>
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <20240117-zswap-xarray-v1-1-6daa86c08fae@kernel.org>
 <CAJD7tkYEx57CPBoaN9GW4M3Mx-+jEsOMWJ02nLKSKD-MLb-WPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYEx57CPBoaN9GW4M3Mx-+jEsOMWJ02nLKSKD-MLb-WPA@mail.gmail.com>

On Wed, Jan 17, 2024 at 10:20:29PM -0800, Yosry Ahmed wrote:
> >         /* walk the tree and free everything */
> >         spin_lock(&tree->lock);
> > +
> > +       xas_for_each(&xas, e, ULONG_MAX)
> 
> Why not use xa_for_each?

xas_for_each() is O(n) while xa_for_each() is O(n log n), as mentioned
in the fine documentation.  If you don't need to drop the lock while
in the body of the loop, always prefer xas_for_each().


