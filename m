Return-Path: <linux-kernel+bounces-38717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE2B83C499
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60F73B21847
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7479E6341A;
	Thu, 25 Jan 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vNgjUpj8"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD72355C3A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192565; cv=none; b=ocoJHl7x9CrV3ewEb4X+53HQH8qycJ/y6eQstK6xFwg6YgEe66B6/eBedaGRu6zqZm6x+I6qmvgU6FHkDZmvx2FT62yqgeXHhyqEpM1puhYFHAg6eJ96toOpjXZyOd4Q8YSGnf6DR6/4gJhdN+1aLEyWiPrdST8rjyK1oYScV8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192565; c=relaxed/simple;
	bh=/ORvjbuotS0+6IwLScIN7w174Ib8ZMXDhtnZpkBm9ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYuYwWja/5pVKdS7jCIp5LYcLRaJFxO635gCmjOu0wQOV8s4pLLnnj6zLDGgbQ7181qeIeZKysuM/nWn7J+EXS/a7vA7RFcZarF4VtAy4iHnl58cW1aJEMVTbaRnpSx6noL7Qzzb1YMm0S1pIVgQS7NHgFvVic+e7uD5/PiTlvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vNgjUpj8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UoCX5dqCasoSQIfaxgxhOKWLb4P3Rs8GNp2O4jjAuio=; b=vNgjUpj8NOSogxwQUUgiuOP8qB
	WYRbkEWYp/9J4ytYbhj2j2feFb/FW+wKnSoupGyd2ly5KrA9JMlcfYtikaD1kryCgWY2Lt4GByk4q
	jmbsuBwBHPP8lFlJgbmUPviaAi+D/cuZwhnNOdHi4lTsAJFO/CZ4aK4qqeCdQyjg3ibfh9Xk/YzxG
	FlXZu8JVGRIHAtBxgZC0KMmbNjL6eTeIBCPXJdN/TDIV0lj8S6N4rd5pmkiwYuzD0gUbDSgVm+2Yf
	3oa/jaQBv1wbaoXc7IKovygEYKj3w6BC57CqRKsru45EQEkgL3lNpsmOgdY5s+9n6AR6ptGtrotde
	dkZYta6g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT0co-0000000AB9T-0pRZ;
	Thu, 25 Jan 2024 14:22:38 +0000
Date: Thu, 25 Jan 2024 14:22:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: naoya.horiguchi@nec.com, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory-failure: fix crash in
 split_huge_page_to_list from soft_offline_page
Message-ID: <ZbJursWt9Hp9kXac@casper.infradead.org>
References: <20240124084014.1772906-1-linmiaohe@huawei.com>
 <ZbENgT-2dZHQQ90h@casper.infradead.org>
 <6d3f4822-8bc1-1551-b088-0a6d4c13f049@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d3f4822-8bc1-1551-b088-0a6d4c13f049@huawei.com>

On Thu, Jan 25, 2024 at 07:53:25PM +0800, Miaohe Lin wrote:
> On 2024/1/24 21:15, Matthew Wilcox wrote:
> >>   Call Trace:
> >>    <TASK>
> >>    ? die+0x32/0x90
> >>    ? do_trap+0xde/0x110
> >>    ? folio_memcg+0xaf/0xd0
> >>    ? do_error_trap+0x60/0x80
> >>    ? folio_memcg+0xaf/0xd0
> >>    ? exc_invalid_op+0x53/0x70
> >>    ? folio_memcg+0xaf/0xd0
> >>    ? asm_exc_invalid_op+0x1a/0x20
> >>    ? folio_memcg+0xaf/0xd0
> >>    ? folio_memcg+0xae/0xd0
> > 
> > I might trim these ? lines out of the backtrace ...
> 
> Do you mean make backtrace looks like something below?
> 
> Call Trace:
>  <TASK>
>  split_huge_page_to_list+0x4d/0x1380
>  ? sysvec_apic_timer_interrupt+0xf/0x80
>  try_to_split_thp_page+0x3a/0xf0
>  soft_offline_page+0x1ea/0x8a0
>  soft_offline_page_store+0x52/0x90
>  kernfs_fop_write_iter+0x118/0x1b0
>  vfs_write+0x30b/0x430
>  ksys_write+0x5e/0xe0
>  do_syscall_64+0xb0/0x1b0
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7f6c60d14697

Yes.  I'd trim the sysvec_apic_timer_interrupt+0xf/0x80 line too.
These lines aren't actually part of the call trace.  They're addresses
that the unwinder found on the stack but don't actually fit the call
trace.  It puts them in in case they're helpful, but marks them with a ?
to indicate that they're probably not part of the call trace.

