Return-Path: <linux-kernel+bounces-100686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D26879BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54C91F216AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CC01419B4;
	Tue, 12 Mar 2024 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M7gGuWaW"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14B553BE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710269177; cv=none; b=uu4BWixvmBaLi53eaJcdtMRQdi9diUSDsPqUcWDK0SNJ3VwE/xm31jthwIwmyzYSkFt9KsJ7SA9wjIKjRiy+myQCzEMjzYGE9cakQgX65njy/3/fJIvXNlIzT7jU5eB4pU9cy1YBy1sAYVE9ihq3TPWr9FMN+53cN3TDodYY/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710269177; c=relaxed/simple;
	bh=BaC+hP+eDwsbCiHbIZSVk/4IOMDfn/sK6J6FN9c2fsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDCHtpvKiwUU8xzh36+KOOHUVdYDo7BxtMeUINiqts4e+XJvqIIEg/Hi0LqGvMHC7TsDgf4ZK7h6GqlrdNb2sx6XLct/PDhWHWqAtAsDe0klDE3cxbeNIcgHDYhH5E3HZmOGX2Hs5k+mBhELz4yhGc70S6urgWdjaEUBUx9KOKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M7gGuWaW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9dPWFQZKFxOBV609wPw0UwjsnfeIQucQ3utIsVTuRT8=; b=M7gGuWaW6XSjQCrIYc/NbhvapB
	m/szHalFmpcEHx5ulycUwsIOMQgD+J/mqOiu7A9DsHnUITwR7vYeReWjkCYww0r3twXiG6lUZcieg
	s9DV6CG7Qj6kud+VvLszN8mqiS1jUw1+kmhtJugkGsQJQgIrui6zjYa+JrU3yh5kUrWr+4Gt/x4eT
	Fk1mtGqYg37/Bqn+Q2y1B7rsIDF8IudiiZoWpJVKDTGUoVOaugicAJwbd6XXm8kwhPAp6YRyuLA7u
	3LpmxpP15QmXmS5InXlkmzuDxzuDi+wg3zzhaXFg8e8lsOL4uPmaZj+I5iUyJipfdrUFtKPJwXAYV
	PQ/OD/bg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk78Y-00000003fIK-2FZy;
	Tue, 12 Mar 2024 18:46:06 +0000
Date: Tue, 12 Mar 2024 18:46:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
	"\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate: put dest folio on deferred split list if
 source was there.
Message-ID: <ZfCi7kvLoBvUnARz@casper.infradead.org>
References: <20240311195848.135067-1-zi.yan@sent.com>
 <Ze_P6xagdTbcu1Kz@casper.infradead.org>
 <74AF044A-A14A-4C66-A019-70F8F138A9AB@nvidia.com>
 <ZfBkjf4z-jpaNk6c@casper.infradead.org>
 <DFA2B8B7-C690-422A-BE95-82F7E112BB95@nvidia.com>
 <ZfCFCGkrLVpySa6X@casper.infradead.org>
 <76BBDB5D-9D40-44EB-A996-767404B85BE0@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76BBDB5D-9D40-44EB-A996-767404B85BE0@nvidia.com>

On Tue, Mar 12, 2024 at 02:32:43PM -0400, Zi Yan wrote:
> On 12 Mar 2024, at 12:38, Matthew Wilcox wrote:
> > Folios with a positive refcount are
> > removed from the per-node or per-cgroup list _at which point there is
> > an undocumented assumption_ that they will not be removed from the
> > local list because they have a positive refcount.
> 
> But that sounds very subtle if not broken. As an outsider of

I merely deduced this requirement; I didn't come up with it ...

> deferred_split_scan(), only !list_empty(folio->_deferred_list) is checked.
> The condition can be true if the folio is on split_queue or
> local list of deferred_split_scan() with elevated refcount. In that case,
> the folio cannot be removed from the list (either split_queue or local list)
> even if split_queue_lock is held, since local list manipulation is not under
> split_queue_lock. This makes _deferred_list a one-way train to anyone
> except deferred_split_scan(), namely folios can only be added into
> _deferred_list until they are freed or split by deferred_split_scan().
> 
> Is that intended? If yes, maybe we should document it. If not, using
> split_queue_lock to protect local list, or more explicitly folio->_deferred_list
> might be better?

To be fair, the folio can be split by anybody as
split_huge_page_to_list_to_order() is careful to only manipulate the
deferred list while the refcount is frozen at 0.  I'm still trying to
figure out where to document this behaviour of the deferred list that
someone (for example, your good self) would actually see it.



