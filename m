Return-Path: <linux-kernel+bounces-95181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0B5874A54
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A34C1C23501
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C4B82D7F;
	Thu,  7 Mar 2024 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzWns5+9"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A31C2A3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802430; cv=none; b=G+TF1hmfDGzfl8x4FVnh9I/lDJju32VvtusY7SzMNPHFAZ0QnStmlwhyWoHTySyg27Vaf/PdtHZOJhuWnKbqekl3iy6BWU7EROBxMcJk+JVPxnCjlS8f3KYRRd5k8PqV37307+ChbC58GscM77ZTG+b97XBfYZg0WjotfyVdH7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802430; c=relaxed/simple;
	bh=q52zNzL1mAXAfmwOkxg1qg6uW/TWTheJqG5qGnMx4V8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jt8ZZdayc2Ryrz5ksaU9aMncBHXcJE/w3XRnsQWv5L6u6zitggkl84/6ZVBEn/xQGnrGQuo06m4ecu2p9NGedHC8gFd1Rl+WZHanTTlZig1aj/6TjTygqpHIJr2uESmjhz5N4a+dZ9U6ZSZx5sHbia/9zwS1I1rio3S8ziZOFww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tzWns5+9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so1125792276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 01:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709802427; x=1710407227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5FgHm9Oc8Gd3shZgIpG9kICRlrcXx7ez5dC2yHi6nc=;
        b=tzWns5+9R6+qa2HxlV8t1nuOxhbXMie2eUyJAcWtfUF7R02BlMs1B3+zxyFmBUZLox
         8ozPlGJWuwHL3sf3YQ/8rt053ZS1iKdrrvGNTtdsFBuBbxGcra5Wa4ELVWOKU7+ymjkH
         WxzY9Ei7sJSy80POzVjKLxXJ5STOpscTAkhMx94ADYXyocWQpC565kQZLwPv66mxZtMh
         oVwcPbLjJNpdHTVJlC857b9RaejGJgY8jN9jHXGhzSf6dwfHqB+h3tgjInKJkwUULx5E
         jnqlOm5w6GXw1wIaInxXNYlErcxDCyOxO2vWcxjLGo/S6An/dvgqMp2tFCAob8bamIGy
         DkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709802427; x=1710407227;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5FgHm9Oc8Gd3shZgIpG9kICRlrcXx7ez5dC2yHi6nc=;
        b=vmF5/m4T3GzNE3YpbWmMbgche2bP32QQRKC9MlIy26JgM1C9w2zhX/p7WefGEFtesh
         lGEGG755P/2KeJnLNnbVerKK7ABVb0aGtI9Ncf+ktog+36MhLKmKeNTQX4VpFb/dsWF0
         GG5LHzqil6MDqU977iXF9+mjUalAyM1Kfnu5rMreuaAsJ37foP8JT+vOJMeQgpCZVANE
         emcMsQggVM0ysAVF/bmK0dASy/klik2ldnzfC8InSgw4jPnKeA4b9xsJTw/BAbWXW+2S
         qvvdD/pQmWNH4iL99b7OdFBGKiZjQhgsOzjSwMDRaOOX7SIBLbhQS8/wov/NKzxBa552
         cngg==
X-Forwarded-Encrypted: i=1; AJvYcCUXTM480lqU7TNH/zQIIHRPBStywc4L8DKImELJPL0xIJabT6DqLCTAeic8bw33Vd6houA/eNteoFU4AzJ7GbD/2dwONr3r2P2PrrtR
X-Gm-Message-State: AOJu0Yzqkq7f1GuLRujtrqmLF2Oxou53eazGZ668qdSvPXpzpxGOq6Rz
	vzoZwwYz6gyDZMu8Fnz3nsvhwFbFAME3+I0uLpvBUrZgLu7bedXDKH+7nRueEW1d88Tqm2BulUr
	2QayahaoFxkspCW/uOw==
X-Google-Smtp-Source: AGHT+IFcz0HP6cZW+8P1RxO1yEIgqxG2w9ZrRof4nVCSuaftylofDsLtSMdC19mKHJqgmhePAvPMBBsXgCERBo8E
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:aacb:0:b0:dc7:7ce9:fb4d with SMTP
 id t69-20020a25aacb000000b00dc77ce9fb4dmr4415114ybi.12.1709802427445; Thu, 07
 Mar 2024 01:07:07 -0800 (PST)
Date: Thu, 7 Mar 2024 09:07:05 +0000
In-Reply-To: <CAF8kJuPcPi22hWhJFGAf0RW2Q8PS_WHKXfUYrcwnpHY2VDVhYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304-zswap-xarray-v4-1-c4b45670cc30@kernel.org>
 <ZeaotMlpMl88lSlc@google.com> <CAF8kJuPcPi22hWhJFGAf0RW2Q8PS_WHKXfUYrcwnpHY2VDVhYg@mail.gmail.com>
Message-ID: <ZemDuW25YxjqAjm-@google.com>
Subject: Re: [PATCH v4] zswap: replace RB tree with xarray
From: Yosry Ahmed <yosryahmed@google.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="us-ascii"

[..]
> > > -static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
> > > -{
> > > -     rb_erase(&entry->rbnode, root);
> > > -     RB_CLEAR_NODE(&entry->rbnode);
> > > +     e = xa_store(tree, offset, entry, GFP_KERNEL);
> > > +     err = xa_err(e);
> > > +
> > > +     if (err) {
> > > +             e = xa_erase(tree, offset);
> > > +             if (err == -ENOMEM)
> > > +                     zswap_reject_alloc_fail++;
> > > +             else
> > > +                     zswap_reject_xarray_fail++;
> >
> > I think this is too complicated, and as Chengming pointed out, I believe
> > we can use xa_store() directly in zswap_store().
> 
> Sure.
> 
> > I am also not sure what the need for zswap_reject_xarray_fail is. Are
> > there any reasons why the store here can fail other than -ENOMEM? The
> > docs say the only other option is -EINVAL, and looking at __xa_store(),
> > it seems like this is only possible if xa_is_internal() is true (which
> > means we are not passing in a properly aligned pointer IIUC).
> 
> Because the xa_store document said it can return two error codes. I
> see zswap try to classify the error count it hit, that is why I add
> the zswap_reject_xarray_fail.

Right, but I think we should not get -EINVAL in this case. I think it
would be more appropriate to have WARN_ON() or VM_WARN_ON() in this
case?

[..]
> > > @@ -1113,7 +1068,9 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
> > >  static int zswap_writeback_entry(struct zswap_entry *entry,
> > >                                swp_entry_t swpentry)
> > >  {
> > > -     struct zswap_tree *tree;
> > > +     struct xarray *tree;
> > > +     pgoff_t offset = swp_offset(swpentry);
> > > +     struct zswap_entry *e;
> > >       struct folio *folio;
> > >       struct mempolicy *mpol;
> > >       bool folio_was_allocated;
> > > @@ -1150,19 +1107,14 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
> > >        * be dereferenced.
> > >        */
> > >       tree = swap_zswap_tree(swpentry);
> > > -     spin_lock(&tree->lock);
> > > -     if (zswap_rb_search(&tree->rbroot, swp_offset(swpentry)) != entry) {
> > > -             spin_unlock(&tree->lock);
> > > +     e = xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL);
> > > +     if (e != entry) {
> >
> > I think we can avoid adding 'e' and 'offset' local variables here and
> > just do everything in the if condition. If you want to avoid the line
> > break, then introducing 'offset' is fine, but I don't see any value from
> > 'e'.
> 
> As I said in my other email. I don't think having this type of local
> variable affects the compiler negatively. The compiler generally uses
> their own local variable to track the expression anyway. So I am not
> sure about the motivation to remove local variables alone, if it helps
> the reading. I feel the line  "if (xa_cmpxchg(tree, offset, entry,
> NULL, GFP_KERNEL) != entry)" is too long and complicated inside the if
> condition. That is just me. Not a big deal.

I just think 'e' is not providing any readability improvements. If
anything, people need to pay closer attention to figure out 'e' is only
a temp variable and 'entry' is the real deal.

I vote for:
	if (entry != xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL))

[..]
> > > @@ -1471,10 +1423,12 @@ bool zswap_store(struct folio *folio)
> > >  {
> > >       swp_entry_t swp = folio->swap;
> > >       pgoff_t offset = swp_offset(swp);
> > > -     struct zswap_tree *tree = swap_zswap_tree(swp);
> > > -     struct zswap_entry *entry, *dupentry;
> > > +     struct xarray *tree = swap_zswap_tree(swp);
> > > +     struct zswap_entry *entry, *old;
> > >       struct obj_cgroup *objcg = NULL;
> > >       struct mem_cgroup *memcg = NULL;
> > > +     int err;
> > > +     bool old_erased = false;
> > >
> > >       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > >       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> > > @@ -1526,6 +1480,7 @@ bool zswap_store(struct folio *folio)
> > >                       kunmap_local(src);
> > >                       entry->length = 0;
> > >                       entry->value = value;
> > > +                     entry->pool = NULL;
> >
> > Why do we need to initialize the pool here? Is this is a bug fix for an
> > existing problem or just keeping things clean? Either way I think it
> > should be done separately, unless it is related to a change in this
> > patch.
> 
> I notice the entry->pool will leave uninitialized. I think it should
> be cleaned up. It is a clean up, it does not need to happen in this
> patch. I can do that as a separate patch.

Yes please.
 
[..]
> >
> > >       /*
> > >        * The folio may have been dirtied again, invalidate the
> > >        * possibly stale entry before inserting the new entry.
> > >        */
> > > -     if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
> > > -             zswap_invalidate_entry(tree, dupentry);
> > > -             WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
> > > +     err = zswap_xa_insert(tree, entry, &old);
> > > +     if (old)
> > > +             zswap_entry_free(old);
> > > +     if (err) {
> > > +             old_erased = true;
> >
> > I think this can be made simpler if we open code xa_store() here,
> > especially that we already have cleanup code below under 'check_old'
> > that removes the exisitng old entry. So zswap_xa_insert() replicates
> > this cleanup, then we add this 'old_erased' boolean to avoid doing the
> > cleanup below. It seems like it would much more straightforward with
> > open-coding xa_store() here and relying on the existing cleanup for the
> > old entry.  Also, if we initialize 'old' to NULL, we can use its value
> > to figure out whether any cleanup is needed under 'check_old' or not.
> 
> I think that is very similar to what Chengming was suggesting.
> 
> >
> > Taking a step back, I think we can further simplify this. What if we
> > move the tree insertion to right after we allocate the zswap entry? In
> > this case, if the tree insertion fails, we don't need to decrement the
> > same filled counter. If the tree insertion succeeds and then something
> > else fails, the existing cleanup code under 'check_old' will already
> > clean up the tree insertion for us.
> 
> That will create complications that, if the zswap compression fails
> the compression ratio, you will have to remove the entry from the tree
> as clean up. You have both xa_store() and xa_erase() where the current
> code just does one xa_erase() on compression failure.

Not really. If xa_store() fails because of -ENOMEM, then I think by
definition we do not need xa_erase() as there shouldn't be any stale
entries. I also think -ENOMEM should be the only valid errno from
xa_store() in this context. So we can avoid the check_old code if
xa_store() is called (whether it fails or succeeds) IIUC.

I prefer calling xa_store() entry and avoiding the extra 'insert_failed'
cleanup code, especially that unlike other cleanup code, it has its own
branching based on entry->length. I am also planning a cleanup for
zswap_store() to split the code better for the same_filled case and
avoid some unnecessary checks and failures, so it would be useful to
keep the common code path together.

> 
> >
> > If this works, we don't need to add extra cleanup code or move any code
> > around. Something like:
> 
> Due to the extra xa_insert() on compression failure, I think
> Chengming's or your earlier suggestion is better.
> 
> BTW, while you are here, can you confirm this race discussed in
> earlier email can't happen? Chengming convinced me this shouldn't
> happen. Like to hear your thoughts.
> 
>  CPU1                         CPU2
> 
> xa_store()
>                                    entry = xa_erase()
>                                    zswap_free_entry(entry)
> 
> if (entry->length)
>      ...
> CPU1 is using entry after free.

IIUC, CPU1 is in zswap_store(), CPU2 could either in zswap_invalidate()
or zswap_load().

For zswap_load(), I think synchronization is done in the core swap code
ensure we are not doing parallel swapin/swapout at the same entry,
right? In this specific case, I think the folio would be in the
swapcache while swapout (i.e. zswap_store()) is ongoing, so any swapins
will read the folio and not call zswap_load().

Actually, if we do not prevent parallel swapin/swapou at the same entry,
I suspect we may have problems even outside of zswap. For example, we
may read a partially written swap entry from disk, right? Or does the
block layer synchronize this somehow?

For zswap_invalidate(), the core swap code calls it when the swap entry
is no longer used and before we free it for reuse, so IIUC parallel
swapouts (i.e. zswap_store()) should not be possible here as well.

