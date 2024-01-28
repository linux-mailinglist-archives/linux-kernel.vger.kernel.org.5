Return-Path: <linux-kernel+bounces-41555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956F383F478
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 07:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482802820B5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 06:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9696CC129;
	Sun, 28 Jan 2024 06:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Irg0zpC+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8535B647
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706425045; cv=none; b=uM4hq5DJG40eXqANjc1bvLICASPhDHJoBkiAZleuw2/LePHu0VkqE13R80gd/Nn1hbiNH8PaY7hTeYy6LyFTZyv+nQXRHzebmrisaRK5ey0/rwFfIHVka1V3PD0h4V6dfBBRv4R/M9stt/0ONY0h7AFOorSaTLWEKN93HAnBb1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706425045; c=relaxed/simple;
	bh=jlspB79IvwxTucUZBcNzO6WFxpeixd1p/ZveQ6ovbdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0Av8ptgTxvLYZSbxmu9uy3VJPf9WH3zDQnolDhODi3WwZSv7XslDSwrEarNWXzfbAWE04BnX7QrNYD6dhdRYenBNfg5Y679T0+alUcXtH7Z5UXYFopN9avMScMpCrDdnbGmmdPy5sv3IZqarzIKlmqiREy/ZkTf1Qiey6SE4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Irg0zpC+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=NUnz1RMN/0D0LFDxgrSiED0Vho/TqpFn9Fpqyv+1XrU=; b=Irg0zpC+YpxRLe0gWjljAgl3wQ
	UiqYDmGyFeTAAIq1XcLQ4W9GjJ08UbUGUqUDqETWgrhvvEtFrtHxLfGsQsNNuFYWQhiAFN1GyhzD3
	8XbbzRqZLqD6YNYqW3wfeq5jYt0tPfHp+RMgq6d5Nf33saLXCjjL1oxhqp9PcYdS3fevfHo+/Lbp/
	4RZI1BQ/IOqv0Lq1zZrcOz8+LXLy0cVC7T4DGamwC/U4fERd6f5h25AdTod3ak/mamiQZ0hk4zrVR
	tybEHAz0YtTZtsqXBxcKLzFZshgoSKaWF3h3O3JTCGMyotQyHFhujZquictNbxvnRg60EsQX+UkHp
	6diIo4Jg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTylU-00000002HtH-3YLR;
	Sun, 28 Jan 2024 06:35:36 +0000
Date: Sun, 28 Jan 2024 06:35:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: zhiguojiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] mm:vmscan: shrink skip folios in the exiting task
Message-ID: <ZbX1uEbrN-lwnnaW@casper.infradead.org>
References: <20240124124308.461-1-justinjiang@vivo.com>
 <ZbEOrim8tjMXB5os@casper.infradead.org>
 <726d018c-01d0-48b3-870b-c63fb06eb0d0@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <726d018c-01d0-48b3-870b-c63fb06eb0d0@vivo.com>

On Thu, Jan 25, 2024 at 09:34:53AM +0800, zhiguojiang wrote:
> > > In the scenarios of the low memory system and mutil backed-applications,
> > > the time-consuming problem caused by shrinking the exiting task's folios
> > > will be more severe.
> > What testing have you done of this patch?  How often does it happen?
> > Are there particular workloads that benefit from this?  (I'm not sure
> > what "mutil backed-applications" are?)
> 1 Yes, this patch has been tested.
> 
> 2 When the exiting tasks and shrink_inactive_list occur at the same time,
>    the folios which shrink_inactive_list reclaims may be the exiting tasks's
> folios
>    in lruvecs. And when system is low memory, it more likely to occur,
> because
>    more backend applidatuions will be killed.
>    The shrink_inactive_list reclaims the exiting tasks's folios in lruvecs
> and
>    transforms the exiting tasks's anon folios into swap memory, which leads
>    to the increasing load of the current exiting tasks.

Ah, we're talking about an OOM scenario.  OK, that makes some sense.
You should have mentioned that in the patch description.

> 3 This patch can alleviate the load of the tasks exiting process. This patch
>    can make that the exiting tasks release its anon folios faster instead of
>    releasing its swap memory from its anon folios swap-in in
> shrink_inactive_list.
> 
> 4 "mutil backed-applications" means that there are a large number of
>     the backend applications in the system.
> 
> Thanks
> > 
> > And I do mean specifically of this patch, because to my eyes it
> > shouldn't even compile.
> Has been tested.

That's odd.  I thought GCC used to complain about

	long x = 0x100000000;

but it does the right thing.  Except on 32-bit where it'll say
"warning: integer constant out of range".

In any case, the number you chose is not going to work on 32-bit systems
or on ARM or x86.  It conflicts with protection keys on x86 and MTE on
ARM.

We can do it without any new magic numbers.  I'm not sure this is a
great approach, but this should work:

+++ b/mm/rmap.c
@@ -840,6 +840,12 @@ static bool folio_referenced_one(struct folio *folio,
        int referenced = 0;
        unsigned long start = address, ptes = 0;

+       /* Skip this folio if it's mapped by an exiting task */
+       if (test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags)) {
+               pra->referenced = -1;
+               return false;
+       }
+
        while (page_vma_mapped_walk(&pvmw)) {
                address = pvmw.address;



