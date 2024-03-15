Return-Path: <linux-kernel+bounces-104410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E244987CD67
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1241F21682
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D067288D8;
	Fri, 15 Mar 2024 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sc4ciJQL"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19952562F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710506801; cv=none; b=kcycNTOOm1UUO1KRDaw6sSN73J5hHbvpzpB77ukcYrV7IRZQ5n6ZNWvGAKTxRcZ93+zsG3bw/UjBM6wSUZLH03AvMHnQjxokjX/VIYXYGNTixDs6vbxSH7WLOoxY6OnyAYFKzuT3hKuiJe1kMagWEeGA+RY+byDbUec/C6l6aZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710506801; c=relaxed/simple;
	bh=21ZuhUve5Z4tGe6WEXY6VmACIOFxRQiwQNAdgkxV90Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOAln7/vqMC1+jQcT2HRflHtthk6At06kaAaqhGNsRlHcmIanqkdmvoJReRF9ItC4acTUfu+Ue0V1wcxqAF2ZqvoIGcxTvKWcsiGsvYdzjtYBw5v4/dJ7TPklDElsgVVlC4nQEc97gCKrgqqCIlq0RD/bYLgzHsdME9S92Jt2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sc4ciJQL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RULc5TDvvvk2Sa4i0hS8r0sd1mzoDamLndZ42uiOt24=; b=sc4ciJQLAJePL0o5DufJ89yc7j
	OOAdDOqyD/9x0si3c5ZBTDMPmvyMqSQrWGNl9DuK20mBE46P8EdI6u8OH9ZSeAorYxJYPkS2vFM/Z
	ymuLP9jLkMQg+ess5joFMU8O6VS1tgukLNdt84Vlgc0aQv/W+rqUMYhAM7g5oB6UAK9fG3lYqS1Mq
	p9cd/XE6FEHh0WLhb7aZcrgCRXDtHSkFgnFv5LiKuqw3snfQ2um4QWbMhkIv9BOyGuc5lbe+glarl
	HRwCwaX+wbMu4rfb7eBk8QiRZPTHKUlhbHdB9GjYMQFoJZ7oJJ4fNHEsmwRv1VgsSVD79Pq7zogQo
	WMHa81KQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rl6xB-0000000AGY7-3YBZ;
	Fri, 15 Mar 2024 12:46:29 +0000
Date: Fri, 15 Mar 2024 12:46:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCH] mm: fix a race scenario in folio_isolate_lru
Message-ID: <ZfRDJTrFJq3KSbIB@casper.infradead.org>
References: <20240314083921.1146937-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314083921.1146937-1-zhaoyang.huang@unisoc.com>

On Thu, Mar 14, 2024 at 04:39:21PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Panic[1] reported which is caused by lruvec->list break. Fix the race
> between folio_isolate_lru and release_pages.
> 
> race condition:
> release_pages could meet a non-refered folio which escaped from being
> deleted from LRU but add to another list_head

I don't think the bug is in folio_isolate_lru() but rather in its
caller.

 * Context:
 *
 * (1) Must be called with an elevated refcount on the folio. This is a
 *     fundamental difference from isolate_lru_folios() (which is called
 *     without a stable reference).

So when release_pages() runs, it must not see a refcount decremented to
zero, because the caller of folio_isolate_lru() is supposed to hold one.

Your stack trace is for the thread which is calling release_pages(), not
the one calling folio_isolate_lru(), so I can't help you debug further.

