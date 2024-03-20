Return-Path: <linux-kernel+bounces-109377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ABE88183A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 300D7B2356B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4328529E;
	Wed, 20 Mar 2024 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="0phK1S4w"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5056BFBA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965008; cv=none; b=EpRSGni07kd6WDcZwoO6noFmTHKW18Az3DWHF8zliKUomhS0IoR4jFq/kOXbrJq2Fxa2Hbz49wDVBxiQu7SFHV4AyatoUwzVxqSt1dzOxGhasgrAR4P7hcPfmInkkSN8pJUtGFd2sMZ6xEpH7ZC5t3VrQWq1gGIpJJb1qu/jMPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965008; c=relaxed/simple;
	bh=/kVCsdHpV74pFp+f/gaoyBvd7/xSi1zTL8+s2pm9LPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WevVLIFePRTj13/LxcKG9k9PdCJOMrBgEJzCXtVW0UkvBNPhvk93VbM9fcd1GPxOAKtbQT8ygPwlheNfqrtxf/sMlcoPvTVs/paGYMv4v+ks/tPGrJne7JgQQ9CSGiK8uqH4cWEI2g8DH+egZEii8CpNfx+Xgw6stMvdGKRY2cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=0phK1S4w; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-789ddcd57f4so16211985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710965004; x=1711569804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0jdcNltAU6TVN3UM3CUikRiO1j6yIq28ebD3IaLAC6s=;
        b=0phK1S4wyY77izZW5vIs4891+8gSHe6e9YXQ/IM4OAzPHa9sbCV2eZsClKe9JBbWEv
         BTKl3N4KiHrc4oflogtCYvoCIyWBRCkejO9kPfDcaOxdOR+Zv5S7MSMbJ/SNd/AXP6r5
         1zqrFGmZHKx9hTnVlMME5uG3qjw666TD50Vr314hipniUvyAM09EpdqKhHtJtcmXWAM3
         r501wgsV+3k87t5sipuEB/VAmhv8/e8xc057ZPQvhDVgjbEcJBlEtysxp4iAd/y/UnCe
         6ODuLDk2sFYpf8167n5RcxlfmAAIK6hVeqGI0L2Uo1qWlI5eTvhlngdOYWPMbyCx3qa+
         +xrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710965004; x=1711569804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jdcNltAU6TVN3UM3CUikRiO1j6yIq28ebD3IaLAC6s=;
        b=fp9c7hDPG2erc5YYWGbZYKSabEytfTE5se1mjGDap87X0ci2fcy6Q9o6L0YwesJVyu
         RmZiTTqGI2fHtwFoAmgCIP0R7h73x1ZS0RKSMqFpPlkpsOCMZjqKZoZGIiaV1WlTtjHU
         H9KIvzPCo7F/ludTMsvKjnE5PIGeHPUDAFBktSpW5HQAu8L/q9H3P6v3M8jrHfyna9J7
         xFNF7nT3crVn+cxC+Rv+S6A+7PPuDzoW1ghUb7b8+4b3HBa7+c4qbWWegWSIMiL6rNdv
         YHabLgXokHyChKIodXE6STN928Qfzh3SAn6vX2Hn7fwlHcB9vOKpyVAnwTr+Y0go13vw
         RRVg==
X-Forwarded-Encrypted: i=1; AJvYcCV1zuxk0yjCLEBWUNgPxcOFi7gvMh64hKAFhL9rfa87hMWi7ubNxfzXG56GoYIzSlnfN7OR1xAlkAxfHoUKsNGyizRDjjmisBZX5HFG
X-Gm-Message-State: AOJu0YwYX0O9CH5PDLfhLFOytHl1b6HzDVjZ562xtuPw9yKF+/CwqG2v
	lb5NJ5hKSWspqYc+nsJcyw1bJ1YEOyW3HOCYGGBHYxb7K7XUXiR9rPDl9WBTWjU=
X-Google-Smtp-Source: AGHT+IEQIaO99JJUIT0HNOJj4jV69AM8LJMl/9ZZ0APTkan3Axv1r+s/gu+wRKVFtxl3NxM8/24MLg==
X-Received: by 2002:a05:620a:c45:b0:789:f333:d0da with SMTP id u5-20020a05620a0c4500b00789f333d0damr15335940qki.20.1710965004349;
        Wed, 20 Mar 2024 13:03:24 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id t26-20020a05620a035a00b00789fb5397d4sm3587371qkm.100.2024.03.20.13.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 13:03:23 -0700 (PDT)
Date: Wed, 20 Mar 2024 16:03:22 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Nhat Pham <nphamcs@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v7] zswap: replace RB tree with xarray
Message-ID: <20240320200322.GG294822@cmpxchg.org>
References: <20240319-zswap-xarray-v7-1-e9a03a049e86@kernel.org>
 <Zfp-iWaDfqeCOElt@google.com>
 <CANeU7Q=yxf0dnerTOZfe_ioeCbjnZd2Fpb-szvW7-Q1BzCUpOw@mail.gmail.com>
 <ZfqPK7AVunq2SC1l@google.com>
 <20240320100803.GB294822@cmpxchg.org>
 <Zfs06maKhjH_gXqL@google.com>
 <20240320192558.GF294822@cmpxchg.org>
 <Zfs6TP8pdmNHcDfA@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfs6TP8pdmNHcDfA@google.com>

On Wed, Mar 20, 2024 at 07:34:36PM +0000, Yosry Ahmed wrote:
> On Wed, Mar 20, 2024 at 03:25:58PM -0400, Johannes Weiner wrote:
> > On Wed, Mar 20, 2024 at 07:11:38PM +0000, Yosry Ahmed wrote:
> > > On Wed, Mar 20, 2024 at 06:08:03AM -0400, Johannes Weiner wrote:
> > > > On Wed, Mar 20, 2024 at 07:24:27AM +0000, Yosry Ahmed wrote:
> > > > > [..]
> > > > > > > > -     /* map */
> > > > > > > > -     spin_lock(&tree->lock);
> > > > > > > >       /*
> > > > > > > > -      * The folio may have been dirtied again, invalidate the
> > > > > > > > -      * possibly stale entry before inserting the new entry.
> > > > > > > > +      * We finish initializing the entry while it's already in xarray.
> > > > > > > > +      * This is safe because:
> > > > > > > > +      *
> > > > > > > > +      * 1. Concurrent stores and invalidations are excluded by folio lock.
> > > > > > > > +      *
> > > > > > > > +      * 2. Writeback is excluded by the entry not being on the LRU yet.
> > > > > > > > +      *    The publishing order matters to prevent writeback from seeing
> > > > > > > > +      *    an incoherent entry.
> > > > > > >
> > > > > > > As I mentioned before, writeback is also protected by the folio lock.
> > > > > > > Concurrent writeback will find the folio in the swapcache and abort. The
> > > > > > > fact that the entry is not on the LRU yet is just additional protection,
> > > > > > > so I don't think the publishing order actually matters here. Right?
> > > > > > 
> > > > > > Right. This comment is explaining why this publishing order does not
> > > > > > matter. I think we are talking about the same thing here?
> > > > > 
> > > > > The comment literally says "the publishing order matters.." :)
> > > > > 
> > > > > I believe Johannes meant that we should only publish the entry to the
> > > > > LRU once it is fully initialized, to prevent writeback from using a
> > > > > partially initialized entry.
> > > > > 
> > > > > What I am saying is that, even if we add a partially initialized entry
> > > > > to the zswap LRU, writeback will skip it anyway because the folio is
> > > > > locked in the swapcache.
> > > > > 
> > > > > So basically I think the comment should say:
> > > > > 
> > > > > 	/*
> > > > > 	 * We finish initializing the entry while it's already in the
> > > > > 	 * xarray. This is safe because the folio is locked in the swap
> > > > > 	 * cache, which should protect against concurrent stores,
> > > > > 	 * invalidations, and writeback.
> > > > > 	 */
> > > > > 
> > > > > Johannes, what do you think?
> > > > 
> > > > I don't think that's quite right.
> > > > 
> > > > Writeback will bail on swapcache insert, yes, but it will access the
> > > > entry before attempting it. If LRU publishing happened before setting
> > > > entry->swpentry e.g., we'd have a problem, while your comment suggets
> > > > it would be safe to rearrange the code like this.
> > > > 
> > > > So LRU publishing order does matter.
> > > 
> > > Ah yes, you are right. entry->swpentry should be set to make sure we
> > > lookup the correct entry in the swapcache and the tree.
> > > 
> > > Perhaps we should spell this out in the comment and make the
> > > initialization ordering more explicit? Maybe something like:
> > > 
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index d8a14b27adcd7..70924b437743a 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -1472,9 +1472,6 @@ bool zswap_store(struct folio *folio)
> > >  		goto put_pool;
> > >  
> > >  insert_entry:
> > > -	entry->swpentry = swp;
> > > -	entry->objcg = objcg;
> > > -
> > >  	old = xa_store(tree, offset, entry, GFP_KERNEL);
> > >  	if (xa_is_err(old)) {
> > >  		int err = xa_err(old);
> > > @@ -1491,6 +1488,7 @@ bool zswap_store(struct folio *folio)
> > >  	if (old)
> > >  		zswap_entry_free(old);
> > >  
> > > +	entry->objcg = objcg;
> > >  	if (objcg) {
> > >  		obj_cgroup_charge_zswap(objcg, entry->length);
> > >  		count_objcg_event(objcg, ZSWPOUT);
> > > @@ -1498,15 +1496,16 @@ bool zswap_store(struct folio *folio)
> > >  
> > >  	/*
> > >  	 * We finish initializing the entry while it's already in xarray.
> > > -	 * This is safe because:
> > > -	 *
> > > -	 * 1. Concurrent stores and invalidations are excluded by folio lock.
> > > +	 * This is safe because the folio is locked in the swapcache, which
> > > +	 * protects against concurrent stores and invalidations.
> > >  	 *
> > > -	 * 2. Writeback is excluded by the entry not being on the LRU yet.
> > > -	 *    The publishing order matters to prevent writeback from seeing
> > > -	 *    an incoherent entry.
> > > +	 * Concurrent writeback is not possible until we add the entry to the
> > > +	 * LRU. We need to at least initialize entry->swpentry *before* adding
> > > +	 * the entry to the LRU to make sure writeback looks up the correct
> > > +	 * entry in the swapcache.
> > >  	 */
> > >  	if (entry->length) {
> > > +		entry->swpentry = swp;
> > >  		INIT_LIST_HEAD(&entry->lru);
> > >  		zswap_lru_add(&zswap_list_lru, entry);
> > >  		atomic_inc(&zswap_nr_stored);
> > > 
> > > 
> > > This also got me wondering, do we need a write barrier between
> > > initializing entry->swpentry and zswap_lru_add()?
> > > 
> > > I guess if we read the wrong swpentry in zswap_writeback_entry() we will
> > > eventually fail the xa_cmpxchg() and drop it anyway, but it seems
> > > bug-prone.
> > 
> > I think it's more robust the way Chris has it now. Writeback only
> > derefs ->swpentry today, but who knows if somebody wants to make a
> > changes that relies on a different member. Having submembers follow
> > different validity rules and timelines is error prone and makes the
> > code less hackable without buying all that much. The concept of
> > "publishing" an object like this is more common: if you can see it,
> > you can expect it to be coherent.
> 
> Fair enough, but don't we still need a barrier there? Couldn't some
> initializations still be reorder after zswap_lru_add()?

Only if it were lockless. The LRU unlocking in zswap_store() implies
RELEASE, the LRU locking in writeback implies ACQUIRE. Those force the
desired ordering - nothing can bleed after RELEASE, nothing can bleed
before ACQUIRE.

