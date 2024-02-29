Return-Path: <linux-kernel+bounces-87308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32F186D282
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4894D1F236FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33077D08D;
	Thu, 29 Feb 2024 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHMGtpYD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528DC381C4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232153; cv=none; b=dxMxKHW4cgjY86ORbEh/5J1zEVTTZDJ9Jc5JpbAiS+1p5YWQ5I6faWvP/ATfirwBiHgXIOkx1GvBwS0FAjdnjoS87jT41/f90kTC2KKwwkBC3X39q4M4Hw56zn5eg6r8Cd24hsaveFaOo/Vw4e+HkYx1rIPN7wDm/l9YC61b5D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232153; c=relaxed/simple;
	bh=H3KrRIYdyvPnDKbeeJxYKtEYwLKqkVQJutQO00Vbu1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFRrwaCLStpCNPEaajak4sqoEB7Ol8+KrnOX8h3WA58rxxotB6iLbeePjfVkiiYa1yMt08pIYrcR8oPI3p9Q62zunWYKDQwm3lctnK8KMfYEQ6iKpL9iaGFASYUIpcA4fJSZ4RzCc25TRSIntc39p0txQmGgOfTfWxrvZOksgro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHMGtpYD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709232150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jci2gA3KsOy/kFeDun1e7o29XwWtdM+TPMqwUNO5Ia8=;
	b=KHMGtpYDOalkGweZoBODDv5KucoJdnAw6++KQBi3HcPXox5SSWCmtJBbYjkBEgQNgLaPPp
	glV054pdhtPFXW5MO1c43rMvdlvrDa1C5i7/xiswzNvY4zXPcTNFryHe7+N5znSWiRizem
	09lyqcwvXv202pP8Ac56MzUivT15zTM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-5O340XGJPTWQQ3fj9j9EoQ-1; Thu, 29 Feb 2024 13:42:26 -0500
X-MC-Unique: 5O340XGJPTWQQ3fj9j9EoQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BE9F848524;
	Thu, 29 Feb 2024 18:42:25 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 60C59483ECA;
	Thu, 29 Feb 2024 18:42:25 +0000 (UTC)
Date: Thu, 29 Feb 2024 13:44:07 -0500
From: Brian Foster <bfoster@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH 03/21] bcachefs: btree write buffer knows how to
 accumulate bch_accounting keys
Message-ID: <ZeDQd7l6PQF5IpBa@bfoster>
References: <20240225023826.2413565-1-kent.overstreet@linux.dev>
 <20240225023826.2413565-4-kent.overstreet@linux.dev>
 <Zd4Ev8XPzn5AJ8K9@bfoster>
 <ius5flpyc3nelyhflvf3cjok7fh6a6qceq43ruweqyu3giqg2k@n2eun6iwtsyj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ius5flpyc3nelyhflvf3cjok7fh6a6qceq43ruweqyu3giqg2k@n2eun6iwtsyj>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Wed, Feb 28, 2024 at 05:42:39PM -0500, Kent Overstreet wrote:
> On Tue, Feb 27, 2024 at 10:50:23AM -0500, Brian Foster wrote:
> > On Sat, Feb 24, 2024 at 09:38:05PM -0500, Kent Overstreet wrote:
> > > +	if (!*accounting_accumulated && wb->k.k.type == KEY_TYPE_accounting) {
> > > +		struct bkey u;
> > > +		struct bkey_s_c k = bch2_btree_path_peek_slot_exact(btree_iter_path(trans, iter), &u);
> > > +
> > > +		if (k.k->type == KEY_TYPE_accounting)
> > > +			bch2_accounting_accumulate(bkey_i_to_accounting(&wb->k),
> > > +						   bkey_s_c_to_accounting(k));
> > 
> > So it looks like we're accumulating from the btree key into the write
> > buffer key. Is this so the following code will basically insert a new
> > btree key based on the value of the write buffer key?
> 
> Correct, this is where we go from "accounting keys is a delta" to
> "accounting key is new version of the key".
> 
> > >  	darray_for_each(wb->sorted, i) {
> > >  		struct btree_write_buffered_key *k = &wb->flushing.keys.data[i->idx];
> > > +		bool accounting_accumulated = false;
> > 
> > Should this live within the interior flush loop?
> 
> We can't define it within the loop because then we'd be setting it to
> false on every loop iteration... but it does belong _with_ the loop, so
> I'll move it to right before.
> 

Ah, right.

> > > -			bch2_journal_pin_update(j, i->journal_seq, &wb->flushing.pin,
> > > -						bch2_btree_write_buffer_journal_flush);
> > > +			if (!accounting_replay_done &&
> > > +			    i->k.k.type == KEY_TYPE_accounting) {
> > > +				could_not_insert++;
> > > +				continue;
> > > +			}
> > > +
> > > +			if (!could_not_insert)
> > > +				bch2_journal_pin_update(j, i->journal_seq, &wb->flushing.pin,
> > > +							bch2_btree_write_buffer_journal_flush);
> > 
> > Hmm.. so this is sane because the slowpath runs in journal sorted order,
> > right?
> 
> yup, which means as soon as we hit a key we can't insert we can't
> release any more journal pins
> 
> > 
> > >  
> > >  			bch2_trans_begin(trans);
> > >  
> > > @@ -375,13 +409,27 @@ static int bch2_btree_write_buffer_flush_locked(struct btree_trans *trans)
> > >  					btree_write_buffered_insert(trans, i));
> > >  			if (ret)
> > >  				goto err;
> > > +
> > > +			i->journal_seq = 0;
> > > +		}
> > > +
> > 
> > 		/*
> > 		 * Condense the remaining keys <reasons reasons>...??
> > 		 */
> 
> yup, that's a good comment
> 
> > > +		if (could_not_insert) {
> > > +			struct btree_write_buffered_key *dst = wb->flushing.keys.data;
> > > +
> > > +			darray_for_each(wb->flushing.keys, i)
> > > +				if (i->journal_seq)
> > > +					*dst++ = *i;
> > > +			wb->flushing.keys.nr = dst - wb->flushing.keys.data;
> > >  		}
> > >  	}
> > >  err:
> > > +	if (ret || !could_not_insert) {
> > > +		bch2_journal_pin_drop(j, &wb->flushing.pin);
> > > +		wb->flushing.keys.nr = 0;
> > > +	}
> > > +
> > >  	bch2_fs_fatal_err_on(ret, c, "%s: insert error %s", __func__, bch2_err_str(ret));
> > > -	trace_write_buffer_flush(trans, wb->flushing.keys.nr, skipped, fast, 0);
> > > -	bch2_journal_pin_drop(j, &wb->flushing.pin);
> > > -	wb->flushing.keys.nr = 0;
> > > +	trace_write_buffer_flush(trans, wb->flushing.keys.nr, overwritten, fast, 0);
> > 
> > I feel like the last time I looked at the write buffer stuff the flush
> > wasn't reentrant in this way. I.e., the flush switched out the active
> > buffer and so had to process all entries in the current buffer (or
> > something like that). Has something changed or do I misunderstand?
> 
> Yeah, originally we were adding keys to the write buffer directly from
> the transaction commit path, so that necessitated the super fast
> lockless stuff where we'd toggle between buffers so one was always
> available.
> 
> Now keys are pulled from the journal, so we can use (somewhat) simpler
> locking and buffering; now the complication is that we can't predict in
> advance how many keys are going to come out of the journal for the write
> buffer.
> 

Ok.

> > 
> > >  	return ret;
> > >  }
> > >  
> > > diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
> > > index 6829d80bd181..b8289af66c8e 100644
> > > --- a/fs/bcachefs/recovery.c
> > > +++ b/fs/bcachefs/recovery.c
> > > @@ -228,6 +228,8 @@ static int bch2_journal_replay(struct bch_fs *c)
> > >  			goto err;
> > >  	}
> > >  
> > > +	set_bit(BCH_FS_accounting_replay_done, &c->flags);
> > > +
> > 
> > I assume this ties into the question on the previous patch..
> > 
> > Related question.. if the write buffer can't flush during journal
> > replay, is there concern/risk of overflowing it?
> 
> Shouldn't be any actual risk. It's just new accounting updates that the
> write buffer can't flush, and those are only going to be generated by
> interior btree node updates as journal replay has to split/rewrite nodes
> to make room for its updates.
> 
> And for those new acounting updates, updates to the same counters get
> accumulated as they're flushed from the journal to the write buffer -
> see the patch for eytzingcer tree accumulated. So we could only overflow
> if the number of distinct counters touched somehow was very large.
> 
> And the number of distinct counters will be growing significantly, but
> the new counters will all be for user data, not metadata.
> 
> (Except: that reminds me, we do want to add per-btree counters, so users
> can see "I have x amount of extents, x amount of dirents, etc.).
> 

Heh, Ok. This all does sound a little open ended to me. Maybe the better
question is: suppose this hypothetically does happen after adding a
bunch of new counters, what would the expected side effect be in the
recovery scenario where the write buffer can't be flushed?

If write buffer updates now basically just journal a special entry,
would that basically mean we'd deadlock during recovery due to no longer
being able to insert journal entries due to a pinned write buffer? If
so, that actually seems reasonable to me in the sense that in theory it
at least doesn't break the filesystem on-disk, but obviously it would
require some kind of enhancement in order to complete the recovery (even
if what that is is currently unknown). Hm?

Brian


