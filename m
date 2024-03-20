Return-Path: <linux-kernel+bounces-109386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C22AA88186A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48B91C2355A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9172385938;
	Wed, 20 Mar 2024 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4c6X6KG9"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C288592D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965552; cv=none; b=UoN/mgguO2lvpXe8fLzlBGM47XbAT808W4C/xK1k4hUwS1IxCL4BHJqyKT+0lKNC8PN2kgEpD6GUay+WJDCGmYHHEajr9agQoXGf54CztM6ODCpzOoIme+fu/TXhn2TMTPrHAAioVPe+kPHUtigwb6TupHfp5waDwLcSFCGyFD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965552; c=relaxed/simple;
	bh=ugQPUmNl2PQK7hwQKbzDzm0duyjeZlfcpZr7yKpm2O4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ty3jK8/I3kOD2TfM7dXU6PD5xcPPou45UNS1h0iUhKLQOigkzd7GwHD6a0rpJENMTqW6W9aumevH6Y2FJqgc/UIPk8ELsM2+azDwq6v6wFHQPOAt2ki4+3dhU5yhlx9oCJm8IBz9A54VDyqWqAho7WM8JRovi4BcqZIk0qHC9p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4c6X6KG9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so239562276.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710965550; x=1711570350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MFPFliDVzkwfGu3jramLj0g3qa3jh4QdDyPnAlfKBdY=;
        b=4c6X6KG9JwUZ45QM1GpfL8uYdeOCbYcFyXuPCuXs+4/FxwiroBySsAe7mGG/1HwGXW
         4GgwhhRonW9IbQeGeqNj4cjiGTXUt3LEmI2qM+XENDri95q2FlDA/iTQ6k7X0/AvzqhM
         hlF2Qa+7uGS/RomDXq+rwUTKQe2ltDjCZ/NylyVbVXcdrSY4lqAapO9AS22p8xPbQcC3
         kwcXBpDFErt8NoXENopyn7qRce1iDJkuTPGVDH3Lq3CExio8SDQuAY5qcqCq2WS0ciSO
         CmMPHpACyYxT2C2S8B1VRjmyufyoFO6IPul3p9ei85zwArlPE0BSvf3/p7Klghu+8ULC
         17fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710965550; x=1711570350;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFPFliDVzkwfGu3jramLj0g3qa3jh4QdDyPnAlfKBdY=;
        b=akM6dVvY9lAsXPOEQeZRA27DauJ1PwQDrS9DmRK/4sJpS4ayo66QWKaKHPGzAxGFXr
         CYRAhLn2J6F408Kvn0am1aV81Q2Qri/veM9bQcIJIEW2BmB5/n2imkY17t2F6eDKCLFT
         rWmrOKUJcSWnznZnRWekfO7t7C5CDPqFhOjo1PsN40JQT/nbxSY3d8zb1fH8ZRoMzDkk
         yGWrVZrmzNDaMuNHoZ7VmhS4krL4xl8+zb9iN27hkbAjT6FBqmDX4g2nZLqG1i2nUm3C
         vjDT1cMQd2d0vtH3h7mLDDuZoKBViyDt3eiNRiFVVDrHyrhnGHyoITORw4wSoRo45Hbf
         L71g==
X-Forwarded-Encrypted: i=1; AJvYcCWIvOOFmn5X37ONmPlLrq5OuplonTfLFtbC/d2Ed8n6acJyTFoQGmbpksD6Qyk4SVPwwhxegh8GEJhWiVmprFK1oEEzIZtWz8FqqT8X
X-Gm-Message-State: AOJu0YyQJHOUkQrFmTgmt3+wd+Z5oTbVB+5sbcQ2R6OzKXTJ1/vgtDie
	qf+t7teRclXBZhirwEpdDcHkQPdLxwK6eaW98bZOhkw/x2MNxj7gvqFynwht01vyrNnrudKywJU
	G4J/Hxh/tHrTpr4LAMQ==
X-Google-Smtp-Source: AGHT+IGPF/ySlgD25U7W2vZazRdRk9ruHMep/a5Eo67dNFR2Jegj86DoTftiFq+3a4jk688Kl9QtyHFGvx26RvqG
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:200b:b0:dc8:27e6:cde1 with
 SMTP id dh11-20020a056902200b00b00dc827e6cde1mr1037009ybb.5.1710965549936;
 Wed, 20 Mar 2024 13:12:29 -0700 (PDT)
Date: Wed, 20 Mar 2024 20:12:27 +0000
In-Reply-To: <20240320200322.GG294822@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240319-zswap-xarray-v7-1-e9a03a049e86@kernel.org>
 <Zfp-iWaDfqeCOElt@google.com> <CANeU7Q=yxf0dnerTOZfe_ioeCbjnZd2Fpb-szvW7-Q1BzCUpOw@mail.gmail.com>
 <ZfqPK7AVunq2SC1l@google.com> <20240320100803.GB294822@cmpxchg.org>
 <Zfs06maKhjH_gXqL@google.com> <20240320192558.GF294822@cmpxchg.org>
 <Zfs6TP8pdmNHcDfA@google.com> <20240320200322.GG294822@cmpxchg.org>
Message-ID: <ZftDKwhNOSl5obU7@google.com>
Subject: Re: [PATCH v7] zswap: replace RB tree with xarray
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Nhat Pham <nphamcs@gmail.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 20, 2024 at 04:03:22PM -0400, Johannes Weiner wrote:
> On Wed, Mar 20, 2024 at 07:34:36PM +0000, Yosry Ahmed wrote:
> > On Wed, Mar 20, 2024 at 03:25:58PM -0400, Johannes Weiner wrote:
> > > On Wed, Mar 20, 2024 at 07:11:38PM +0000, Yosry Ahmed wrote:
> > > > On Wed, Mar 20, 2024 at 06:08:03AM -0400, Johannes Weiner wrote:
> > > > > On Wed, Mar 20, 2024 at 07:24:27AM +0000, Yosry Ahmed wrote:
> > > > > > [..]
> > > > > > > > > -     /* map */
> > > > > > > > > -     spin_lock(&tree->lock);
> > > > > > > > >       /*
> > > > > > > > > -      * The folio may have been dirtied again, invalidate the
> > > > > > > > > -      * possibly stale entry before inserting the new entry.
> > > > > > > > > +      * We finish initializing the entry while it's already in xarray.
> > > > > > > > > +      * This is safe because:
> > > > > > > > > +      *
> > > > > > > > > +      * 1. Concurrent stores and invalidations are excluded by folio lock.
> > > > > > > > > +      *
> > > > > > > > > +      * 2. Writeback is excluded by the entry not being on the LRU yet.
> > > > > > > > > +      *    The publishing order matters to prevent writeback from seeing
> > > > > > > > > +      *    an incoherent entry.
> > > > > > > >
> > > > > > > > As I mentioned before, writeback is also protected by the folio lock.
> > > > > > > > Concurrent writeback will find the folio in the swapcache and abort. The
> > > > > > > > fact that the entry is not on the LRU yet is just additional protection,
> > > > > > > > so I don't think the publishing order actually matters here. Right?
> > > > > > > 
> > > > > > > Right. This comment is explaining why this publishing order does not
> > > > > > > matter. I think we are talking about the same thing here?
> > > > > > 
> > > > > > The comment literally says "the publishing order matters.." :)
> > > > > > 
> > > > > > I believe Johannes meant that we should only publish the entry to the
> > > > > > LRU once it is fully initialized, to prevent writeback from using a
> > > > > > partially initialized entry.
> > > > > > 
> > > > > > What I am saying is that, even if we add a partially initialized entry
> > > > > > to the zswap LRU, writeback will skip it anyway because the folio is
> > > > > > locked in the swapcache.
> > > > > > 
> > > > > > So basically I think the comment should say:
> > > > > > 
> > > > > > 	/*
> > > > > > 	 * We finish initializing the entry while it's already in the
> > > > > > 	 * xarray. This is safe because the folio is locked in the swap
> > > > > > 	 * cache, which should protect against concurrent stores,
> > > > > > 	 * invalidations, and writeback.
> > > > > > 	 */
> > > > > > 
> > > > > > Johannes, what do you think?
> > > > > 
> > > > > I don't think that's quite right.
> > > > > 
> > > > > Writeback will bail on swapcache insert, yes, but it will access the
> > > > > entry before attempting it. If LRU publishing happened before setting
> > > > > entry->swpentry e.g., we'd have a problem, while your comment suggets
> > > > > it would be safe to rearrange the code like this.
> > > > > 
> > > > > So LRU publishing order does matter.
> > > > 
> > > > Ah yes, you are right. entry->swpentry should be set to make sure we
> > > > lookup the correct entry in the swapcache and the tree.
> > > > 
> > > > Perhaps we should spell this out in the comment and make the
> > > > initialization ordering more explicit? Maybe something like:
> > > > 
> > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > index d8a14b27adcd7..70924b437743a 100644
> > > > --- a/mm/zswap.c
> > > > +++ b/mm/zswap.c
> > > > @@ -1472,9 +1472,6 @@ bool zswap_store(struct folio *folio)
> > > >  		goto put_pool;
> > > >  
> > > >  insert_entry:
> > > > -	entry->swpentry = swp;
> > > > -	entry->objcg = objcg;
> > > > -
> > > >  	old = xa_store(tree, offset, entry, GFP_KERNEL);
> > > >  	if (xa_is_err(old)) {
> > > >  		int err = xa_err(old);
> > > > @@ -1491,6 +1488,7 @@ bool zswap_store(struct folio *folio)
> > > >  	if (old)
> > > >  		zswap_entry_free(old);
> > > >  
> > > > +	entry->objcg = objcg;
> > > >  	if (objcg) {
> > > >  		obj_cgroup_charge_zswap(objcg, entry->length);
> > > >  		count_objcg_event(objcg, ZSWPOUT);
> > > > @@ -1498,15 +1496,16 @@ bool zswap_store(struct folio *folio)
> > > >  
> > > >  	/*
> > > >  	 * We finish initializing the entry while it's already in xarray.
> > > > -	 * This is safe because:
> > > > -	 *
> > > > -	 * 1. Concurrent stores and invalidations are excluded by folio lock.
> > > > +	 * This is safe because the folio is locked in the swapcache, which
> > > > +	 * protects against concurrent stores and invalidations.
> > > >  	 *
> > > > -	 * 2. Writeback is excluded by the entry not being on the LRU yet.
> > > > -	 *    The publishing order matters to prevent writeback from seeing
> > > > -	 *    an incoherent entry.
> > > > +	 * Concurrent writeback is not possible until we add the entry to the
> > > > +	 * LRU. We need to at least initialize entry->swpentry *before* adding
> > > > +	 * the entry to the LRU to make sure writeback looks up the correct
> > > > +	 * entry in the swapcache.
> > > >  	 */
> > > >  	if (entry->length) {
> > > > +		entry->swpentry = swp;
> > > >  		INIT_LIST_HEAD(&entry->lru);
> > > >  		zswap_lru_add(&zswap_list_lru, entry);
> > > >  		atomic_inc(&zswap_nr_stored);
> > > > 
> > > > 
> > > > This also got me wondering, do we need a write barrier between
> > > > initializing entry->swpentry and zswap_lru_add()?
> > > > 
> > > > I guess if we read the wrong swpentry in zswap_writeback_entry() we will
> > > > eventually fail the xa_cmpxchg() and drop it anyway, but it seems
> > > > bug-prone.
> > > 
> > > I think it's more robust the way Chris has it now. Writeback only
> > > derefs ->swpentry today, but who knows if somebody wants to make a
> > > changes that relies on a different member. Having submembers follow
> > > different validity rules and timelines is error prone and makes the
> > > code less hackable without buying all that much. The concept of
> > > "publishing" an object like this is more common: if you can see it,
> > > you can expect it to be coherent.
> > 
> > Fair enough, but don't we still need a barrier there? Couldn't some
> > initializations still be reorder after zswap_lru_add()?
> 
> Only if it were lockless. The LRU unlocking in zswap_store() implies
> RELEASE, the LRU locking in writeback implies ACQUIRE. Those force the
> desired ordering - nothing can bleed after RELEASE, nothing can bleed
> before ACQUIRE.

Ah yes, I found smp_store_release() deep in the spin_unlock() code.
Thanks for pointing this out, all is good in the world.

