Return-Path: <linux-kernel+bounces-81866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6D2867B24
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB0029297F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC0712C52D;
	Mon, 26 Feb 2024 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SN5FmGYX"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAE2129A95
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963630; cv=none; b=p/oabK9a0jJWbgxCgJpqd+11BJiV/Pl6qJ0RdYIUBM2gh9qEMdMJgBwLk1qKgoqxpHR1z2UJqjmIPIL3GWUWTzWkd1dxv9bHH3czbV/j6pxndfkGPEinn92WWU4EFdlPMbry4IUy2H4Pty4TkX68XGASOM6yHizkQnvTYuzYwf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963630; c=relaxed/simple;
	bh=rZgjS7hx97FiN+TOw76foGho3vxsXG12mQSj5fGDka4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1pphwD68WEW+z+GNo8pOSrpKH2e6dPCWH8mLglL0E5crb9hCAQptpC+TNHP1XkN5P9+c/ICGoJREUaASwJsUakO+IG30ubv8w2eBptb+GrXg8js5zlRJCzjV8i/2wXCZ8HmXUhUOTBKq5M5UF1M0m9GfCItv2RrqVUL/Ym7uNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SN5FmGYX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fhdGu3trmRJDR0pxGd/fdG/MnSc6CZnEt17ipVogjy8=; b=SN5FmGYX0apBuYqIHPw4slOL0R
	koA8vDKaZtjnbcjQ83HgtRDdOTUG/ke+0awUEAjSy5DCNmrA1mlrWu8JlDMFydOPlpWTpksRJcy+L
	gES0VhCCOXtq5kfEHmDkqF/iPpeCTtiBcPuqAPQu/FmUKHx9lwwYUnoBLSoKWyWP7DjyuIf/mP4tw
	a9f1A1XAxcPz9c3BRiQKNfUJ7WvpK3aEiXStOlOPaILJ3Vy3D6cQ3VRN2G8zLL9lHjcu7iWFAchwl
	H4isc7EJAMzBC7PmRJvoGYJFIzHIVUqLyHOVpdqfFUIulARBMhP9HStr2DNybrBTHhGiZ0YKyi3oN
	JGqP2vdw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1redVS-0000000Hajc-01ec;
	Mon, 26 Feb 2024 16:07:06 +0000
Date: Mon, 26 Feb 2024 16:07:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/2] mm/memfd: refactor memfd_tag_pins() and
 memfd_wait_for_pins()
Message-ID: <Zdy3KRi3mnA2ZaDQ@casper.infradead.org>
References: <20240226141324.278526-1-david@redhat.com>
 <20240226141324.278526-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226141324.278526-2-david@redhat.com>

On Mon, Feb 26, 2024 at 03:13:23PM +0100, David Hildenbrand wrote:
> +	xas_for_each(xas, folio, ULONG_MAX) {
> +		if (!xa_is_value(folio) && memfd_folio_has_extra_refs(folio))
>  			xas_set_mark(xas, MEMFD_TAG_PINNED);

.. we decline to tag value entries here ...

> @@ -95,20 +90,15 @@ static int memfd_wait_for_pins(struct address_space *mapping)
>  
>  		xas_set(&xas, 0);
>  		xas_lock_irq(&xas);
> -		xas_for_each_marked(&xas, page, ULONG_MAX, MEMFD_TAG_PINNED) {
> +		xas_for_each_marked(&xas, folio, ULONG_MAX, MEMFD_TAG_PINNED) {
>  			bool clear = true;
>  
> -			cache_count = 1;
> -			if (!xa_is_value(page) &&
> -			    PageTransHuge(page) && !PageHuge(page))
> -				cache_count = HPAGE_PMD_NR;
> -
> -			if (!xa_is_value(page) && cache_count !=
> -			    page_count(page) - total_mapcount(page)) {
> +			if (!xa_is_value(folio) &&
> +			    memfd_folio_has_extra_refs(folio)) {

.. so we don't need to test it here because we'll never see any value
entries.  No?


