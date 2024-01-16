Return-Path: <linux-kernel+bounces-27482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6312482F0D9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC56F1F23D93
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7881BF39;
	Tue, 16 Jan 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TN4d9eK3"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FD11BF33
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Wo2ZeZzHWLKlJAoyYAf4I5Hw6H08g/lJvj5SWxry/6I=; b=TN4d9eK3eibLenJuYp8+drrwvC
	2Qfn400Q7FkqyxnyUf/mn2VxsLmkOHhWen4/grB9bSWT7cXHS73tbrcJlJBDJpVcJVdb+Iuo7YQkN
	yS2XiLfdCz6TTDGzaxQC0jQKpArEgjk0aJEic+GwPOfjFUiuh5KBo2+/kwyIB2D5Jp0FIj+YLj762
	nJTPM2dvMaH4xPpsItTkXPo3VqYfXsUahUIDjmIZqank7qlxTb2mmbSQj5L+9XIzQQXFkfQ48IXQu
	02S5FAs1NcrKwZVSCAbtK/kivgzfl7jSjMRYrF8/Wp53msfJL59BN1UzJn/ncA8KdHAvCdArnLNJT
	TDMH/klg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rPkmX-00DJEv-IU; Tue, 16 Jan 2024 14:51:13 +0000
Date: Tue, 16 Jan 2024 14:51:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm: memory: move mem_cgroup_charge() into
 alloc_anon_folio()
Message-ID: <ZaaX4Yi9JYBWrUEs@casper.infradead.org>
References: <20240116071302.2282230-1-wangkefeng.wang@huawei.com>
 <2c24afdf-5103-4c1b-a649-2eeed185f3fb@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c24afdf-5103-4c1b-a649-2eeed185f3fb@arm.com>

On Tue, Jan 16, 2024 at 02:35:54PM +0000, Ryan Roberts wrote:
> On 16/01/2024 07:13, Kefeng Wang wrote:
> > In order to allocate as much as possible of large folio, move
> > the mem charge into alloc_anon_folio() and try the next order
> > if mem_cgroup_charge() fails, also we change the GFP_KERNEL
> > to gfp to be consistent with PMD THP.
> 
> I agree that changing gfp gives you consistency. But it's not entirely clear to
> me why THP should use one set of flags for this case, and since pages another.
> Why does this difference exist?

I think it needs to be spelled out much better in the changelog.  Here's
my attempt at explaining why we might want this change.

mem_cgroup_charge() uses the GFP flags in a fairly sophisticated way.
In addition to checking gfpflags_allow_blocking(), it pays attention to
__GFP_NORETRY and __GFP_RETRY_MAYFAIL to ensure that processes within
this memcg do not exceed their quotas.  Using the same GFP flags ensures
that we handle large anonymous folios correctly, including falling back
to smaller orders when there is plenty of memory available in the system
but this memcg is close to its limits.

.. I remain not-an-expert in memcg and anonymous memory and welcome
improvements to that text.

