Return-Path: <linux-kernel+bounces-85793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CD886BAD5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6823C1F24413
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E147004E;
	Wed, 28 Feb 2024 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hTRfQZQQ"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D731361A4
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160170; cv=none; b=B0084AzeN7OdMe0Ry20ZTCdRlO6cgXF6u7uH+XTCrmgBuT6e6hjKIEskW3X7j3P+ZUQ2YhPo12rKHfa5CFTe4WLiuey0MNn0WiN3Fx81kTKLT/qpnuGzxfN9wJrPoyXoK93beKJQL5/djXL/nPHPCQYjX4/Gs7xJX49rzWA7x6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160170; c=relaxed/simple;
	bh=9jZFoe64DNoKwYWX8i88izZaLs70/tiAPdx/QKTRLVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFbl/4K6U4YaBMhUfP3Tk9/13188uxR9CxGad6dMRc6l1PpUUmSmYabqsEtg7NgfJ2WV/ulAGLnQLFw2NvLQFstHUoYb8Cf3g0PTRWnM+/uez4bdIKPdMUR7o2pPKFgUTwPca6fFz/VRM541cG8aQ2ZWDbtAYcveALJ2AfKd1qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hTRfQZQQ; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Feb 2024 17:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709160164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4zK8BkbnEgOr6gIlrjbd4nIptjld+uOBK6dwnrdJ/7Y=;
	b=hTRfQZQQWYD3xl6wdDcR2GDCYnK3mnqg4oZiJ7O/V9d7PV7JSwAxp6s1A+9AqZygQoAM7r
	7Lv/m5r2PtQO6kGhAzxa+cLLRfwXWHzxbl7jxrY77C2IyK7aMZ/hO3ci5eJYbXPOB3ASwI
	dNU5FJ4nzr9Cn2lfunwZykCzV4Qs+bY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	djwong@kernel.org
Subject: Re: [PATCH 03/21] bcachefs: btree write buffer knows how to
 accumulate bch_accounting keys
Message-ID: <ius5flpyc3nelyhflvf3cjok7fh6a6qceq43ruweqyu3giqg2k@n2eun6iwtsyj>
References: <20240225023826.2413565-1-kent.overstreet@linux.dev>
 <20240225023826.2413565-4-kent.overstreet@linux.dev>
 <Zd4Ev8XPzn5AJ8K9@bfoster>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd4Ev8XPzn5AJ8K9@bfoster>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 27, 2024 at 10:50:23AM -0500, Brian Foster wrote:
> On Sat, Feb 24, 2024 at 09:38:05PM -0500, Kent Overstreet wrote:
> > +	if (!*accounting_accumulated && wb->k.k.type == KEY_TYPE_accounting) {
> > +		struct bkey u;
> > +		struct bkey_s_c k = bch2_btree_path_peek_slot_exact(btree_iter_path(trans, iter), &u);
> > +
> > +		if (k.k->type == KEY_TYPE_accounting)
> > +			bch2_accounting_accumulate(bkey_i_to_accounting(&wb->k),
> > +						   bkey_s_c_to_accounting(k));
> 
> So it looks like we're accumulating from the btree key into the write
> buffer key. Is this so the following code will basically insert a new
> btree key based on the value of the write buffer key?

Correct, this is where we go from "accounting keys is a delta" to
"accounting key is new version of the key".

> >  	darray_for_each(wb->sorted, i) {
> >  		struct btree_write_buffered_key *k = &wb->flushing.keys.data[i->idx];
> > +		bool accounting_accumulated = false;
> 
> Should this live within the interior flush loop?

We can't define it within the loop because then we'd be setting it to
false on every loop iteration... but it does belong _with_ the loop, so
I'll move it to right before.

> > -			bch2_journal_pin_update(j, i->journal_seq, &wb->flushing.pin,
> > -						bch2_btree_write_buffer_journal_flush);
> > +			if (!accounting_replay_done &&
> > +			    i->k.k.type == KEY_TYPE_accounting) {
> > +				could_not_insert++;
> > +				continue;
> > +			}
> > +
> > +			if (!could_not_insert)
> > +				bch2_journal_pin_update(j, i->journal_seq, &wb->flushing.pin,
> > +							bch2_btree_write_buffer_journal_flush);
> 
> Hmm.. so this is sane because the slowpath runs in journal sorted order,
> right?

yup, which means as soon as we hit a key we can't insert we can't
release any more journal pins

> 
> >  
> >  			bch2_trans_begin(trans);
> >  
> > @@ -375,13 +409,27 @@ static int bch2_btree_write_buffer_flush_locked(struct btree_trans *trans)
> >  					btree_write_buffered_insert(trans, i));
> >  			if (ret)
> >  				goto err;
> > +
> > +			i->journal_seq = 0;
> > +		}
> > +
> 
> 		/*
> 		 * Condense the remaining keys <reasons reasons>...??
> 		 */

yup, that's a good comment

> > +		if (could_not_insert) {
> > +			struct btree_write_buffered_key *dst = wb->flushing.keys.data;
> > +
> > +			darray_for_each(wb->flushing.keys, i)
> > +				if (i->journal_seq)
> > +					*dst++ = *i;
> > +			wb->flushing.keys.nr = dst - wb->flushing.keys.data;
> >  		}
> >  	}
> >  err:
> > +	if (ret || !could_not_insert) {
> > +		bch2_journal_pin_drop(j, &wb->flushing.pin);
> > +		wb->flushing.keys.nr = 0;
> > +	}
> > +
> >  	bch2_fs_fatal_err_on(ret, c, "%s: insert error %s", __func__, bch2_err_str(ret));
> > -	trace_write_buffer_flush(trans, wb->flushing.keys.nr, skipped, fast, 0);
> > -	bch2_journal_pin_drop(j, &wb->flushing.pin);
> > -	wb->flushing.keys.nr = 0;
> > +	trace_write_buffer_flush(trans, wb->flushing.keys.nr, overwritten, fast, 0);
> 
> I feel like the last time I looked at the write buffer stuff the flush
> wasn't reentrant in this way. I.e., the flush switched out the active
> buffer and so had to process all entries in the current buffer (or
> something like that). Has something changed or do I misunderstand?

Yeah, originally we were adding keys to the write buffer directly from
the transaction commit path, so that necessitated the super fast
lockless stuff where we'd toggle between buffers so one was always
available.

Now keys are pulled from the journal, so we can use (somewhat) simpler
locking and buffering; now the complication is that we can't predict in
advance how many keys are going to come out of the journal for the write
buffer.

> 
> >  	return ret;
> >  }
> >  
> > diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
> > index 6829d80bd181..b8289af66c8e 100644
> > --- a/fs/bcachefs/recovery.c
> > +++ b/fs/bcachefs/recovery.c
> > @@ -228,6 +228,8 @@ static int bch2_journal_replay(struct bch_fs *c)
> >  			goto err;
> >  	}
> >  
> > +	set_bit(BCH_FS_accounting_replay_done, &c->flags);
> > +
> 
> I assume this ties into the question on the previous patch..
> 
> Related question.. if the write buffer can't flush during journal
> replay, is there concern/risk of overflowing it?

Shouldn't be any actual risk. It's just new accounting updates that the
write buffer can't flush, and those are only going to be generated by
interior btree node updates as journal replay has to split/rewrite nodes
to make room for its updates.

And for those new acounting updates, updates to the same counters get
accumulated as they're flushed from the journal to the write buffer -
see the patch for eytzingcer tree accumulated. So we could only overflow
if the number of distinct counters touched somehow was very large.

And the number of distinct counters will be growing significantly, but
the new counters will all be for user data, not metadata.

(Except: that reminds me, we do want to add per-btree counters, so users
can see "I have x amount of extents, x amount of dirents, etc.).

