Return-Path: <linux-kernel+bounces-96249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1EA875937
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351021C20D33
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9371913B78F;
	Thu,  7 Mar 2024 21:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JTjPXuB1"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD67C12BE9A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846936; cv=none; b=RvVqgnzDpe/pYYB9R9tbaRSibHwc+NQ0x/aNRxr31Roa3u4O89xtzsEuoNJdmtJhsdCg/xkgDzbhGmdvsg0dqoQ/azxNaJLmul8joQCrSgtRyQ7BfnXJ60TSotkKLbdb8FK4ty9AwMVA6fJ3h0NHYNYPMjgO7K7BasxOT9fOxMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846936; c=relaxed/simple;
	bh=JrZ4qBggn9l/KbkNMfSISioGRb1d2bcRv/mXltu6FQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AVYpG7KjDi1kvKvX2H+Eo01upAg4fGBJLqLaPEaBeu0zRX0kWDjC842aTS4Y0Aal5ML/x9PIKlssDHUcqc+v7AlyF0L4XxpI53Do25l0TnZ14HEIGfPjSHuCsVGjMMbrUtpxBYBvCS2MI3s2WcVs47xF7EH+ton7Flkr69LgY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JTjPXuB1; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d9a541b720aso2516184276.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 13:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709846933; x=1710451733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9T1FgRduCmc2Zd5OXiyEx7qrbkEtYrIn9LbhrPaySvA=;
        b=JTjPXuB1OYEfkAhSuguAc82fXTwYHSsG5ECQeKO1C18R2oX+3gEwI5axvoGVOSLHA/
         zdExvDV59MSGievCbQ5k45lhMBUNGqTJjrN95rn7DdAgPwAoA3W9zFgk9qokX2ytXmYH
         LFbukeb+Jfk2AvmiOLSTp42Qk5RvuC12PePe2i4vBvdSSX58UOxRVQ4mS3CikuCEWDNF
         L3+GFoUAr4t/lXI5TNlK+T/p958ILhAQHP/0cNNdRMHBgLVeLtlv1Vw4InKj23nnNlgy
         xHRtab1CT+8zRKTzAOvopGT+fGM43m0y1LD6KNcWD6CVRL04dUS7EOxA29LRYD/K+bQZ
         Z4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709846933; x=1710451733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9T1FgRduCmc2Zd5OXiyEx7qrbkEtYrIn9LbhrPaySvA=;
        b=xSzjjOAz3PZCwAU/uspLKHN+R9vPTJK66YJJ+RsUMLmzyutJxX9gXmyyuATUAOLIC7
         fFjfmrLHwQPAfE5biAoT9nbRfgCGA2xg9LOVE3x8B+UQ1MzRf1570kMxCSdm0h1xgyUI
         4v2ji9DKKaLaT1DWViNLI0alA3xOGgHlZDgEFBH/mjvTL2lAGTflU/nlqXq0bkARtu1C
         yTlu7W48eeJhIbAAmsI2wF9mPbcskvIT+sB9p7DhTiSXDo6JSvWf2sX2mka0HSRgDxfm
         cIb8lM6doKtxMZOk/LXIR7WX5DYjyBNHd7lsXtdZTWl7JkFkhujt/LQBdeAKieHWQo9l
         60oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAJQ+pftPLutIc80XhAyFSdCJe/m3VzWw1g6CLxmB3W+xSA0zEFBTaBIcAYBdGT4HdY6OAuQ/0IDkCm+Y4nUJvQ3oRvOrn9RXVgMO8
X-Gm-Message-State: AOJu0YwtpvcwTNqBoh1D07+MiOnc9HD+HxKU7vq0lGr3YIE1xTpbXGGO
	hBslAvXhhfuiRC4U/7zWsUGh/SSr9teXnz1A8tEBJpljy4Y3Y6XVOJQYnfGsiiOY78FtPtgpXG5
	IO0qFE3x6TTnc6I5/NQ==
X-Google-Smtp-Source: AGHT+IGGYeOFCJCLMH1R5I7Em8wKQqSb/HOrzd80jxXBvlObm3cr9yWEdlIijeplJYkLvie73G5JpRbubvRmBMx9
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:2688:0:b0:dc6:eea0:1578 with SMTP
 id m130-20020a252688000000b00dc6eea01578mr4759543ybm.13.1709846933705; Thu,
 07 Mar 2024 13:28:53 -0800 (PST)
Date: Thu, 7 Mar 2024 21:28:51 +0000
In-Reply-To: <CANeU7QkFMo0WbFkXV6yKGKAUOYywye3ZVc0VT+fiXnzOfHJP2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304-zswap-xarray-v4-1-c4b45670cc30@kernel.org>
 <ZeaotMlpMl88lSlc@google.com> <CAF8kJuPcPi22hWhJFGAf0RW2Q8PS_WHKXfUYrcwnpHY2VDVhYg@mail.gmail.com>
 <ZemDuW25YxjqAjm-@google.com> <CANeU7QkFMo0WbFkXV6yKGKAUOYywye3ZVc0VT+fiXnzOfHJP2A@mail.gmail.com>
Message-ID: <Zeoxk9YLuerLANq4@google.com>
Subject: Re: [PATCH v4] zswap: replace RB tree with xarray
From: Yosry Ahmed <yosryahmed@google.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="us-ascii"

[..]
> > > > I am also not sure what the need for zswap_reject_xarray_fail is. Are
> > > > there any reasons why the store here can fail other than -ENOMEM? The
> > > > docs say the only other option is -EINVAL, and looking at __xa_store(),
> > > > it seems like this is only possible if xa_is_internal() is true (which
> > > > means we are not passing in a properly aligned pointer IIUC).
> > >
> > > Because the xa_store document said it can return two error codes. I
> > > see zswap try to classify the error count it hit, that is why I add
> > > the zswap_reject_xarray_fail.
> >
> > Right, but I think we should not get -EINVAL in this case. I think it
> > would be more appropriate to have WARN_ON() or VM_WARN_ON() in this
> > case?
> 
> In the context of the existing zswap code, it seems the zswap keeps
> track of different failure reason counters. So that we can read the
> failure counter and have a good clue where the source code causes the
> failure.

zswap keeps track of different *valid* failure reasons. I think in this
case this would be a bug, which warrants a warning rather than a counter
(same reasoning why we removed the duplicate entry counter).

> 
> If the document said it can return -EINVAL, I wouldn't just look at
> the current implementation and assume it does not generate -EINVAL.

My assumption is that a properly-aligned pointer will always be valid to
store in the xarray, so the only valid return error is -ENOMEM, but
perhaps Matthew will correct me here.

Maybe we can have an xa_is_valid() helper to check this separately and
guarantee no -EINVAL returns, but I *think* the fact that it is
slab-allocated pointer may be enough.

> What if the zswap entry allocation has a bug that returns some strange
> alignment that makes xarray not happy? There is a lot of assumption
> that some error code can or can show up. Just to be consistent with
> the other part of the zswap code, I give it a counter to indicate it
> is the xarray causing the fail and error. That is the safe thing to
> do. It is a good thing this kind of error branch never hits. But if it
> does, it gives better information for debugging. It is just following
> the same spirit of the rest of the zswap error handling. What do you
> say?

This is exactly my point, these counters are not for bugs. We should
have a warning if there is a bug.

[..]
> > > > > +     e = xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL);
> > > > > +     if (e != entry) {
> > > >
> > > > I think we can avoid adding 'e' and 'offset' local variables here and
> > > > just do everything in the if condition. If you want to avoid the line
> > > > break, then introducing 'offset' is fine, but I don't see any value from
> > > > 'e'.
> > >
> > > As I said in my other email. I don't think having this type of local
> > > variable affects the compiler negatively. The compiler generally uses
> > > their own local variable to track the expression anyway. So I am not
> > > sure about the motivation to remove local variables alone, if it helps
> > > the reading. I feel the line  "if (xa_cmpxchg(tree, offset, entry,
> > > NULL, GFP_KERNEL) != entry)" is too long and complicated inside the if
> > > condition. That is just me. Not a big deal.
> >
> > I just think 'e' is not providing any readability improvements. If
> > anything, people need to pay closer attention to figure out 'e' is only
> > a temp variable and 'entry' is the real deal.
> 
> Well, 'e' is assigned in the previous line and used in the very next
> line (only once).
> I hardly can see this impact any one understands what it is doing. I
> can also come up with a reason (for the argument sake) that this maps
> out to the machine code better.  In the machine code it generates, you
> see xa_cmpxchg first then "if" branch. You can also ask the debugger
> what is the current value of "e", which register is currently mapped
> to if it is still in the frame context. But that is not important.
> 
> There are also C Macro symbols that define something else, just once.
> Are we following the rule to remove all symbols that only define and
> use once?
> 
> Anyway, the bottom line is that it generates the exact same machine
> code. Readability is subjective, there is some personal preference in
> it. IMHO the difference in readability is so trivial here that it does
> not justify having to flip one way or the other in this case.

My argument was solely based on readability. I agree there is no
difference in machine code, and that this is personal preference, which
is why I stated my vote below (and I believe Chengming had the same
preference). This is not a blocker either way :)

[..]
> > > > >       /*
> > > > >        * The folio may have been dirtied again, invalidate the
> > > > >        * possibly stale entry before inserting the new entry.
> > > > >        */
> > > > > -     if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
> > > > > -             zswap_invalidate_entry(tree, dupentry);
> > > > > -             WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
> > > > > +     err = zswap_xa_insert(tree, entry, &old);
> > > > > +     if (old)
> > > > > +             zswap_entry_free(old);
> > > > > +     if (err) {
> > > > > +             old_erased = true;
> > > >
> > > > I think this can be made simpler if we open code xa_store() here,
> > > > especially that we already have cleanup code below under 'check_old'
> > > > that removes the exisitng old entry. So zswap_xa_insert() replicates
> > > > this cleanup, then we add this 'old_erased' boolean to avoid doing the
> > > > cleanup below. It seems like it would much more straightforward with
> > > > open-coding xa_store() here and relying on the existing cleanup for the
> > > > old entry.  Also, if we initialize 'old' to NULL, we can use its value
> > > > to figure out whether any cleanup is needed under 'check_old' or not.
> > >
> > > I think that is very similar to what Chengming was suggesting.
> > >
> > > >
> > > > Taking a step back, I think we can further simplify this. What if we
> > > > move the tree insertion to right after we allocate the zswap entry? In
> > > > this case, if the tree insertion fails, we don't need to decrement the
> > > > same filled counter. If the tree insertion succeeds and then something
> > > > else fails, the existing cleanup code under 'check_old' will already
> > > > clean up the tree insertion for us.
> > >
> > > That will create complications that, if the zswap compression fails
> > > the compression ratio, you will have to remove the entry from the tree
> > > as clean up. You have both xa_store() and xa_erase() where the current
> > > code just does one xa_erase() on compression failure.
> >
> > Not really. If xa_store() fails because of -ENOMEM, then I think by
> > definition we do not need xa_erase() as there shouldn't be any stale
> > entries. I also think -ENOMEM should be the only valid errno from
> > xa_store() in this context. So we can avoid the check_old code if
> > xa_store() is called (whether it fails or succeeds) IIUC.
> >
> > I prefer calling xa_store() entry and avoiding the extra 'insert_failed'
> > cleanup code, especially that unlike other cleanup code, it has its own
> > branching based on entry->length. I am also planning a cleanup for
> > zswap_store() to split the code better for the same_filled case and
> > avoid some unnecessary checks and failures, so it would be useful to
> > keep the common code path together.
> 
> I would like to point out that, in real world usage, we will likely
> see more pages fail due to compress rather than xa_store failure.
> There is a non zero percentage of pages that are not compressible.
> The -ENOMEM for xa_store are very rare, much much rarer than the non
> compressible page. So in the real work running, insert first will have
> one more "xa_store" than compression first. I would argue compression
> first will perform slightly better, because "xa_store" will need to
> take the spin lock. Avoid the extra "xa_store" and avoid taking the
> lock all together. There is simply more compression failure than
> xa_store failure.
> It also feels slightly strange when inserting the entry into xarray
> when the entry is not ready to use. I don't think that is triggeriable
> as a bug right now, but that makes me feel a little bit strange.

Good point. I don't think the perfomrnace difference will be
significant, but you are right. Let's keep the insertion here and we can
revisit this later when we cleanup the same_filled code.

nit: please rename the cleanup label from 'insert_failed' to
'store_failed' :)

[..]
> > > BTW, while you are here, can you confirm this race discussed in
> > > earlier email can't happen? Chengming convinced me this shouldn't
> > > happen. Like to hear your thoughts.
> > >
> > >  CPU1                         CPU2
> > >
> > > xa_store()
> > >                                    entry = xa_erase()
> > >                                    zswap_free_entry(entry)
> > >
> > > if (entry->length)
> > >      ...
> > > CPU1 is using entry after free.
> >
> > IIUC, CPU1 is in zswap_store(), CPU2 could either in zswap_invalidate()
> > or zswap_load().
> >
> > For zswap_load(), I think synchronization is done in the core swap code
> > ensure we are not doing parallel swapin/swapout at the same entry,
> > right? In this specific case, I think the folio would be in the
> > swapcache while swapout (i.e. zswap_store()) is ongoing, so any swapins
> > will read the folio and not call zswap_load().
> >
> > Actually, if we do not prevent parallel swapin/swapou at the same entry,
> > I suspect we may have problems even outside of zswap. For example, we
> > may read a partially written swap entry from disk, right? Or does the
> > block layer synchronize this somehow?
> 
> I don't think the block layer is doing the synchronization here. Zswap
> does not go to the block layer at all.
> I think after looking up from the swap cache, the filio will be
> locked, that is preventing others' path. I would like to hear others'
> thoughts on that. Need more audits.

I did not mean that the block layer is doing any synchronizaiton here.
It comes from the swap cache as I outlined. I think it's safe.

I was just wondering what happens with parallel swapin/swapout if there
is no swap cache synchronization for normal swapfiles. I was wondering
if the block layer will handle the synchronization, in which case zswap
may have different requirements than normal swapfiles. Just something
that seemed good to know :)

> 
> >
> > For zswap_invalidate(), the core swap code calls it when the swap entry
> > is no longer used and before we free it for reuse, so IIUC parallel
> > swapouts (i.e. zswap_store()) should not be possible here as well.
> 
> There is also the write back path, I don't think it is triggerable due
> to entry not being inserted into the LRU list yet.

Ah yes, I looked at callsites for xa_erase(), there is a xa_cmpxchg()
there. Actually I think the swap cache synchronizes here too.
zswap_writeback_entry() is like swapin, so this case is like too
parallel swapins. Both of them should call __read_swap_cache_async(),
and only one of them will actually do the swapin.

If zswap_writeback_entry() wins the race, zswap_load() will not be
called in the first place, the swap cache entry will be used. If swapin
(i.e. zswap_load()) wins the race, zswap_writeback_entry() should skip.

Right?

