Return-Path: <linux-kernel+bounces-104745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA69C87D308
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E8FB212AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146664C637;
	Fri, 15 Mar 2024 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GECCR7bc"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7D33BBD0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524917; cv=none; b=W/+zGb74o+TIu8YdtIvBsYijuiFSiFTzkC6Rr0V9ICs10NYxU6Ta1HE5j8LWaCrX8VEaiEYEzM0Kg5IZ7J7Gzn0lGmWsW8OnRoNAICddWvbbQ1Jy4Q69uW/L89NQNl5S9QJX3S/JEeIRhRZcd7h9QuyLsCaMeEa6ezhHi1ZRo4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524917; c=relaxed/simple;
	bh=KHrpDSUJQQs6+1i/tSJAHGRK500eSYM/hA2R396Hawg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TacixqpKObChrlxA/Qbdwrizh5k/yfFlWtB8TySPBbdZKAQ/h8BeMdJ9aU8DvJgSr8HjzLmp8ZEryU510urWkQYNG7vEEq9Oe9mYaIk79Y+zycZJ6SKRDeKQjV76Xj02+LrLlZy8caJOTqysALQUxCAqK8kmpMOKhTz7a5b/kow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GECCR7bc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HFKGGKN+f0vBo92ILwKwd4CZp/WjaO7D1JcM7ZAAhnM=; b=GECCR7bc4om9Eg+HFja4pmj6ft
	Y+qeRoneitJU+ZbzxBjUjRDt9BvQN1fgifstLw3yvuER/4FdGqyhPakC5NmIUf1Ewc13weBRsEat8
	7rwNrkmY0RWTnkWbdHf6PDOA+5xXK5K9FdPjrmZlRa4krT5OGH7q0PQbsdsOhe6EXxj+uwTIucFHQ
	iTxLsbJpZiQgtgbFENUaBamsIc6VUQ58P77aX5nabLgRnDzczmZliMsyYV8lVu35Xc5XlxT11bgvu
	I/w3U68zePJ91kgv15kbk593vziVSFgBqdx6XYyZ0SkjQTqkGE3FmgiKg+DJdXXAcfUSVEmEpdOC4
	cr7se9WQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlBfU-0000000142g-1tko;
	Fri, 15 Mar 2024 17:48:32 +0000
Date: Fri, 15 Mar 2024 10:48:32 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
	jhubbard@nvidia.com, mgorman@suse.de, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, dave@stgolabs.net,
	p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH 2/3] mm/compaction: add and use
 for_each_populated_zone_pgdat() helper
Message-ID: <ZfSJ8GPjVY54G1V4@bombadil.infradead.org>
References: <20240314005436.2962962-1-mcgrof@kernel.org>
 <20240314005436.2962962-3-mcgrof@kernel.org>
 <ea5d5bb6-32a5-4161-95cd-3dc916576bf7@linux.alibaba.com>
 <ZfPe22p9U8PiRB0W@bombadil.infradead.org>
 <532c9e93-e8cc-4f6f-bf08-b5625022dd4f@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <532c9e93-e8cc-4f6f-bf08-b5625022dd4f@suse.cz>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Mar 15, 2024 at 12:09:29PM +0100, Vlastimil Babka wrote:
> On 3/15/24 06:38, Luis Chamberlain wrote:
> > On Thu, Mar 14, 2024 at 03:19:45PM +0800, Baolin Wang wrote:
> >> 
> >> 
> >> On 2024/3/14 08:54, Luis Chamberlain wrote:
> >> > We can just wrap most of the work done on fragmentation_score_node()
> >> > into a pgdat helper for populated zones. Add the helper and use it.
> >> > 
> >> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> >> > ---
> >> >   include/linux/mmzone.h | 8 ++++++++
> >> >   mm/compaction.c        | 9 ++-------
> >> >   2 files changed, 10 insertions(+), 7 deletions(-)
> >> > 
> >> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >> > index a497f189d988..1fd74c7100ec 100644
> >> > --- a/include/linux/mmzone.h
> >> > +++ b/include/linux/mmzone.h
> >> > @@ -1597,6 +1597,14 @@ extern struct zone *next_zone(struct zone *zone);
> >> >   			; /* do nothing */		\
> >> >   		else
> >> > +#define for_each_populated_zone_pgdat(zone, pgdat)	\
> >> > +	for (zone = pgdat->node_zones;			\
> >> > +	     zone;					\
> >> > +	     zone = next_zone(zone))			\
> >> > +		if (!populated_zone(zone))		\
> >> > +			; /* do nothing */		\
> >> > +		else
> >> 
> >> I think this will break the original logics, since the next_zone() will
> >> iterate over all memory zones, instead of only the memory zones of the
> >> specified node.
> > 
> > Definitely, thanks, so we'd need something like this in addition:
> 
> IMHO that's unnecessarily complex, why not just do the iteration all inline
> without this next_zone_pgdat() helper?

Sure.

> Also maybe you could find more users if you created just a
> for_each_zone_pgdat() and left the populated_zone() in the user? Otherwise
> it's quite a specific helper with just one user.

Indeed, this was the only immediately clear user for_each_populated_zone_pgdat()
which stood out, but I'll look more closely. I added this helper because in an
RFC patch I had another use case:

https://lkml.kernel.org/r/20240314005710.2964798-1-mcgrof@kernel.org

Granted this is just an RFC. So happy to drop this if we don't have other users

  Luis

