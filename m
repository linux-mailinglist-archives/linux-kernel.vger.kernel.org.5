Return-Path: <linux-kernel+bounces-87309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C10186D283
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C8A1C21F00
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1A37D099;
	Thu, 29 Feb 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LB91/niC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4D4160629
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232172; cv=none; b=BaV41UnGxNMwCdCMMFtJEY2dDjau6AvyUWTTrZwaQAF8zYuzg3GEC/VBf8l0U9s7HlkwJgJ02VPmisyl/1p+8ezmPGsxa30rqzqu8Xan+UORmcSAigdV188GndXh1wNLkLUKkrt3+jvHmw6uz5ngX9fAKq5HgTpJUMHzETMSzss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232172; c=relaxed/simple;
	bh=L040UxY5dE9/rqWyxA4atx7m1Li0FMzcDfDRE8PNo30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7asiCPDD0Vn+vsR7RoHcSoskxuw3i53MkiFbPdEtetz/v/V30w2/cEgh4hV6337pSSfffNZ+exXwlV/DpztU8oD9WR+ZGxtsorNiM1au9S47caGBI3ucXQB5osPRkgK/8qcTkbe2pX8c8vq/0rpjLENatXP2hgNj7WFgH1bH3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LB91/niC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709232169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dzo1DsYBxzppufaIi/b98XwJfgfjyOPvd7APSjWHr7E=;
	b=LB91/niCdrGQZIXD7qpQmHTeaV2NBTONq0YnV/nScxy8at0+cH2JjvhIU1y9yLApdV9kAg
	po7sVrN8pnlSmvW2xGSUQprPVcYwIkQS0Cj8rdrENWP7tE9+SZQ8xfIOtgdOu2m7UTaeJ3
	UxBNhmlkFL4N7ImjN02IcQy2xOZK5lA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-LkZjeZUNMXKUCdw7o6Fy9Q-1; Thu, 29 Feb 2024 13:42:46 -0500
X-MC-Unique: LkZjeZUNMXKUCdw7o6Fy9Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 593601066684;
	Thu, 29 Feb 2024 18:42:46 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1178C1C06532;
	Thu, 29 Feb 2024 18:42:46 +0000 (UTC)
Date: Thu, 29 Feb 2024 13:44:27 -0500
From: Brian Foster <bfoster@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH 04/21] bcachefs: Disk space accounting rewrite
Message-ID: <ZeDQi3mRwJc7wqX/@bfoster>
References: <20240225023826.2413565-1-kent.overstreet@linux.dev>
 <20240225023826.2413565-5-kent.overstreet@linux.dev>
 <Zd4F1qE1IFCz0/ML@bfoster>
 <3dug3vvjmlkhu42glwhkm5ozgkp4tzqvekxdabbgv4dv4yhxig@r5bw746uaxym>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dug3vvjmlkhu42glwhkm5ozgkp4tzqvekxdabbgv4dv4yhxig@r5bw746uaxym>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Wed, Feb 28, 2024 at 11:10:12PM -0500, Kent Overstreet wrote:
> On Tue, Feb 27, 2024 at 10:55:02AM -0500, Brian Foster wrote:
> > On Sat, Feb 24, 2024 at 09:38:06PM -0500, Kent Overstreet wrote:
> > > Main part of the disk accounting rewrite.
> > > 
> > > This is a wholesale rewrite of the existing disk space accounting, which
> > > relies on percepu counters that are sharded by journal buffer, and
> > > rolled up and added to each journal write.
> > > 
> > > With the new scheme, every set of counters is a distinct key in the
> > > accounting btree; this fixes scaling limitations of the old scheme,
> > > where counters took up space in each journal entry and required multiple
> > > percpu counters.
> > > 
> > > Now, in memory accounting requires a single set of percpu counters - not
> > > multiple for each in flight journal buffer - and in the future we'll
> > > probably also have counters that don't use in memory percpu counters,
> > > they're not strictly required.
> > > 
> > > An accounting update is now a normal btree update, using the btree write
> > > buffer path. At transaction commit time, we apply accounting updates to
> > > the in memory counters, which are percpu counters indexed in an
> > > eytzinger tree by the accounting key.
> > > 
> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > ---
> > >  fs/bcachefs/alloc_background.c      |  68 +++++-
> > >  fs/bcachefs/bcachefs.h              |   6 +-
> > >  fs/bcachefs/bcachefs_format.h       |   1 -
> > >  fs/bcachefs/bcachefs_ioctl.h        |   7 +-
> > >  fs/bcachefs/btree_gc.c              |   3 +-
> > >  fs/bcachefs/btree_iter.c            |   9 -
> > >  fs/bcachefs/btree_trans_commit.c    |  62 ++++--
> > >  fs/bcachefs/btree_types.h           |   1 -
> > >  fs/bcachefs/btree_update.h          |   8 -
> > >  fs/bcachefs/buckets.c               | 289 +++++---------------------
> > >  fs/bcachefs/buckets.h               |  33 +--
> > >  fs/bcachefs/disk_accounting.c       | 308 ++++++++++++++++++++++++++++
> > >  fs/bcachefs/disk_accounting.h       | 126 ++++++++++++
> > >  fs/bcachefs/disk_accounting_types.h |  20 ++
> > >  fs/bcachefs/ec.c                    |  24 ++-
> > >  fs/bcachefs/inode.c                 |   9 +-
> > >  fs/bcachefs/recovery.c              |  12 +-
> > >  fs/bcachefs/recovery_types.h        |   1 +
> > >  fs/bcachefs/replicas.c              |  42 ++--
> > >  fs/bcachefs/replicas.h              |  11 +-
> > >  fs/bcachefs/replicas_types.h        |  16 --
> > >  fs/bcachefs/sb-errors_types.h       |   3 +-
> > >  fs/bcachefs/super.c                 |  49 +++--
> > >  23 files changed, 704 insertions(+), 404 deletions(-)
> > >  create mode 100644 fs/bcachefs/disk_accounting_types.h
> > > 
> > ...
> > > diff --git a/fs/bcachefs/disk_accounting.c b/fs/bcachefs/disk_accounting.c
> > > index 209f59e87b34..327c586ac661 100644
> > > --- a/fs/bcachefs/disk_accounting.c
> > > +++ b/fs/bcachefs/disk_accounting.c
> > ...
> > > @@ -13,6 +17,44 @@ static const char * const disk_accounting_type_strs[] = {
> > >  	NULL
> > >  };
> > >  
> > 
..
> > > +int bch2_disk_accounting_mod(struct btree_trans *trans,
> > > +			     struct disk_accounting_key *k,
> > > +			     s64 *d, unsigned nr)
> > > +{
> > > +	/* Normalize: */
> > > +	switch (k->type) {
> > > +	case BCH_DISK_ACCOUNTING_replicas:
> > > +		bubble_sort(k->replicas.devs, k->replicas.nr_devs, u8_cmp);
> > > +		break;
> > > +	}
> > > +
> > > +	BUG_ON(nr > BCH_ACCOUNTING_MAX_COUNTERS);
> > > +
> > > +	struct {
> > > +		__BKEY_PADDED(k, BCH_ACCOUNTING_MAX_COUNTERS);
> > > +	} k_i;
> > > +	struct bkey_i_accounting *acc = bkey_accounting_init(&k_i.k);
> > > +
> > > +	acc->k.p = disk_accounting_key_to_bpos(k);
> > > +	set_bkey_val_u64s(&acc->k, sizeof(struct bch_accounting) / sizeof(u64) + nr);
> > > +
> > > +	memcpy_u64s_small(acc->v.d, d, nr);
> > > +
> > > +	return bch2_trans_update_buffered(trans, BTREE_ID_accounting, &acc->k_i);
> > > +}
> > > +
> > ...
> > > diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
> > > index a7f9de220d90..685d54d0ddbb 100644
> > > --- a/fs/bcachefs/super.c
> > > +++ b/fs/bcachefs/super.c
> > ...
> > > @@ -1618,6 +1621,16 @@ int bch2_dev_remove(struct bch_fs *c, struct bch_dev *ca, int flags)
> > >  	if (ret)
> > >  		goto err;
> > >  
> > > +	/*
> > > +	 * We need to flush the entire journal to get rid of keys that reference
> > > +	 * the device being removed before removing the superblock entry
> > > +	 */
> > > +	bch2_journal_flush_all_pins(&c->journal);
> > 
> > I thought this needed to occur between the device removal and superblock
> > update (according to the comment below). Is that not the case? Either
> > way, is it moved for reasons related to accounting?
> 
> I think it ended up not needing to be moved, and I just forgot to drop
> it - originally I disallowed accounting entries that referenced
> nonexistent devices, but that wasn't workable so now it's only nonzero
> accounting keys that aren't allowed to reference nonexistent devices.
> 
> I'll see if I can delete it.
> 

Do you mean to delete the change that moves the call, or the flush call
entirely?

> Applying the following fixup patch, renaming for consistency but mostly
> adding documentation. Helpful?
> 

Yes, definitely. A few nitty suggestions below you can choose to take or
leave, but this is the sort of thing I was getting at above.

> From 2f2c088f5a4c374d6e7357398c5307425dc52140 Mon Sep 17 00:00:00 2001
> From: Kent Overstreet <kent.overstreet@linux.dev>
> Date: Wed, 28 Feb 2024 23:09:28 -0500
> Subject: [PATCH] fixup! bcachefs: Disk space accounting rewrite
> 
> 
> diff --git a/fs/bcachefs/btree_trans_commit.c b/fs/bcachefs/btree_trans_commit.c
> index b005e20039bb..3a5b815af8bc 100644
> --- a/fs/bcachefs/btree_trans_commit.c
> +++ b/fs/bcachefs/btree_trans_commit.c
> @@ -697,7 +697,7 @@ bch2_trans_commit_write_locked(struct btree_trans *trans, unsigned flags,
>  			a->k.version = journal_pos_to_bversion(&trans->journal_res,
>  							(u64 *) entry - (u64 *) trans->journal_entries);
>  			BUG_ON(bversion_zero(a->k.version));
> -			ret = bch2_accounting_mem_add(trans, accounting_i_to_s_c(a));
> +			ret = bch2_accounting_mem_mod(trans, accounting_i_to_s_c(a));
>  			if (ret)
>  				goto revert_fs_usage;
>  		}
> @@ -784,7 +784,7 @@ bch2_trans_commit_write_locked(struct btree_trans *trans, unsigned flags,
>  			struct bkey_s_accounting a = bkey_i_to_s_accounting(entry2->start);
>  
>  			bch2_accounting_neg(a);
> -			bch2_accounting_mem_add(trans, a.c);
> +			bch2_accounting_mem_mod(trans, a.c);
>  			bch2_accounting_neg(a);
>  		}
>  	percpu_up_read(&c->mark_lock);
> diff --git a/fs/bcachefs/disk_accounting.c b/fs/bcachefs/disk_accounting.c
> index df9791da1ab7..e8a6ff191acd 100644
> --- a/fs/bcachefs/disk_accounting.c
> +++ b/fs/bcachefs/disk_accounting.c
> @@ -10,6 +10,45 @@
>  #include "journal_io.h"
>  #include "replicas.h"
>  
> +/*
> + * Notes on disk accounting:
> + *
> + * We have two parallel sets of counters to be concerned with, and both must be
> + * kept in sync.
> + *
> + *  - Persistent/on disk accounting, stored in the accounting btree and updated
> + *    via btree write buffer updates that treat new accounting keys as deltas to
> + *    apply to existing values. But reading from a write buffer btree is
> + *    expensive, so we also have
> + *

I find the wording a little odd here, and I also think it would be
helpful to explain how/from where the deltas originate. For example,
something along the lines of:

"Persistent/on disk accounting, stored in the accounting btree and
updated via btree write buffer updates. Accounting updates are
represented as deltas that originate from <somewhere? trans triggers?>.
Accounting keys represent these deltas through commit into the write
buffer. The accounting/delta keys in the write buffer are then
accumulated into the appropriate accounting btree key at write buffer
flush time."

> + *  - In memory accounting, where accounting is stored as an array of percpu
> + *    counters, indexed by an eytzinger array of disk acounting keys/bpos (which
> + *    are the same thing, excepting byte swabbing on big endian).
> + *

Not really sure about the keys vs. bpos thing, kind of related to my
comments on the earlier patch. It might be more clear to just elide the
implementation details here, i.e.:

"In memory accounting, where accounting is stored as an array of percpu
counters that are cheap to read, but not persistent. Updates to in
memory accounting are propagated from the transaction commit path."

.. but NBD, and feel free to reword, drop and/or correct any of that
text.

> + *    Cheap to read, but non persistent.
> + *
> + * To do a disk accounting update:
> + * - initialize a disk_accounting_key, to specify which counter is being update
> + * - initialize counter deltas, as an array of 1-3 s64s
> + * - call bch2_disk_accounting_mod()
> + *
> + * This queues up the accounting update to be done at transaction commit time.
> + * Underneath, it's a normal btree write buffer update.
> + *
> + * The transaction commit path is responsible for propagating updates to the in
> + * memory counters, with bch2_accounting_mem_mod().
> + *
> + * The commit path also assigns every disk accounting update a unique version
> + * number, based on the journal sequence number and offset within that journal
> + * buffer; this is used by journal replay to determine which updates have been
> + * done.
> + *
> + * The transaction commit path also ensures that replicas entry accounting
> + * updates are properly marked in the superblock (so that we know whether we can
> + * mount without data being unavailable); it will update the superblock if
> + * bch2_accounting_mem_mod() tells it to.

I'm not really sure what this last paragraph is telling me, but granted
I've not got that far into the code yet either.

Brian

> + */
> +
>  static const char * const disk_accounting_type_strs[] = {
>  #define x(t, n, ...) [n] = #t,
>  	BCH_DISK_ACCOUNTING_TYPES()
> @@ -133,6 +172,10 @@ static int bch2_accounting_update_sb_one(struct bch_fs *c, struct bpos p)
>  		: 0;
>  }
>  
> +/*
> + * Ensure accounting keys being updated are present in the superblock, when
> + * applicable (i.e. replicas updates)
> + */
>  int bch2_accounting_update_sb(struct btree_trans *trans)
>  {
>  	for (struct jset_entry *i = trans->journal_entries;
> @@ -147,7 +190,7 @@ int bch2_accounting_update_sb(struct btree_trans *trans)
>  	return 0;
>  }
>  
> -static int __bch2_accounting_mem_add_slowpath(struct bch_fs *c, struct bkey_s_c_accounting a)
> +static int __bch2_accounting_mem_mod_slowpath(struct bch_fs *c, struct bkey_s_c_accounting a)
>  {
>  	struct bch_replicas_padded r;
>  
> @@ -191,16 +234,24 @@ static int __bch2_accounting_mem_add_slowpath(struct bch_fs *c, struct bkey_s_c_
>  	return 0;
>  }
>  
> -int bch2_accounting_mem_add_slowpath(struct bch_fs *c, struct bkey_s_c_accounting a)
> +int bch2_accounting_mem_mod_slowpath(struct bch_fs *c, struct bkey_s_c_accounting a)
>  {
>  	percpu_up_read(&c->mark_lock);
>  	percpu_down_write(&c->mark_lock);
> -	int ret = __bch2_accounting_mem_add_slowpath(c, a);
> +	int ret = __bch2_accounting_mem_mod_slowpath(c, a);
>  	percpu_up_write(&c->mark_lock);
>  	percpu_down_read(&c->mark_lock);
>  	return ret;
>  }
>  
> +/*
> + * Read out accounting keys for replicas entries, as an array of
> + * bch_replicas_usage entries.
> + *
> + * Note: this may be deprecated/removed at smoe point in the future and replaced
> + * with something more general, it exists to support the ioctl used by the
> + * 'bcachefs fs usage' command.
> + */
>  int bch2_fs_replicas_usage_read(struct bch_fs *c, darray_char *usage)
>  {
>  	struct bch_accounting_mem *acc = &c->accounting;
> @@ -234,15 +285,6 @@ int bch2_fs_replicas_usage_read(struct bch_fs *c, darray_char *usage)
>  	return ret;
>  }
>  
> -static bool accounting_key_is_zero(struct bkey_s_c_accounting a)
> -{
> -
> -	for (unsigned i = 0; i < bch2_accounting_counters(a.k); i++)
> -		if (a.v->d[i])
> -			return false;
> -	return true;
> -}
> -
>  static int accounting_read_key(struct bch_fs *c, struct bkey_s_c k)
>  {
>  	struct printbuf buf = PRINTBUF;
> @@ -251,10 +293,10 @@ static int accounting_read_key(struct bch_fs *c, struct bkey_s_c k)
>  		return 0;
>  
>  	percpu_down_read(&c->mark_lock);
> -	int ret = __bch2_accounting_mem_add(c, bkey_s_c_to_accounting(k));
> +	int ret = __bch2_accounting_mem_mod(c, bkey_s_c_to_accounting(k));
>  	percpu_up_read(&c->mark_lock);
>  
> -	if (accounting_key_is_zero(bkey_s_c_to_accounting(k)) &&
> +	if (bch2_accounting_key_is_zero(bkey_s_c_to_accounting(k)) &&
>  	    ret == -BCH_ERR_btree_insert_need_mark_replicas)
>  		ret = 0;
>  
> @@ -272,6 +314,10 @@ static int accounting_read_key(struct bch_fs *c, struct bkey_s_c k)
>  	return ret;
>  }
>  
> +/*
> + * At startup time, initialize the in memory accounting from the btree (and
> + * journal)
> + */
>  int bch2_accounting_read(struct bch_fs *c)
>  {
>  	struct bch_accounting_mem *acc = &c->accounting;
> diff --git a/fs/bcachefs/disk_accounting.h b/fs/bcachefs/disk_accounting.h
> index 5fd053a819df..d9f2ce327761 100644
> --- a/fs/bcachefs/disk_accounting.h
> +++ b/fs/bcachefs/disk_accounting.h
> @@ -105,15 +105,15 @@ static inline int accounting_pos_cmp(const void *_l, const void *_r)
>  	return bpos_cmp(*l, *r);
>  }
>  
> -int bch2_accounting_mem_add_slowpath(struct bch_fs *, struct bkey_s_c_accounting);
> +int bch2_accounting_mem_mod_slowpath(struct bch_fs *, struct bkey_s_c_accounting);
>  
> -static inline int __bch2_accounting_mem_add(struct bch_fs *c, struct bkey_s_c_accounting a)
> +static inline int __bch2_accounting_mem_mod(struct bch_fs *c, struct bkey_s_c_accounting a)
>  {
>  	struct bch_accounting_mem *acc = &c->accounting;
>  	unsigned idx = eytzinger0_find(acc->k.data, acc->k.nr, sizeof(acc->k.data[0]),
>  				       accounting_pos_cmp, &a.k->p);
>  	if (unlikely(idx >= acc->k.nr))
> -		return bch2_accounting_mem_add_slowpath(c, a);
> +		return bch2_accounting_mem_mod_slowpath(c, a);
>  
>  	unsigned offset = acc->k.data[idx].offset;
>  
> @@ -124,7 +124,12 @@ static inline int __bch2_accounting_mem_add(struct bch_fs *c, struct bkey_s_c_ac
>  	return 0;
>  }
>  
> -static inline int bch2_accounting_mem_add(struct btree_trans *trans, struct bkey_s_c_accounting a)
> +/*
> + * Update in memory counters so they match the btree update we're doing; called
> + * from transaction commit path
> + */
> +static inline int bch2_accounting_mem_mod(struct btree_trans *trans, struct
> +					  bkey_s_c_accounting a)
>  {
>  	struct disk_accounting_key acc_k;
>  	bpos_to_disk_accounting_key(&acc_k, a.k->p);
> @@ -137,7 +142,7 @@ static inline int bch2_accounting_mem_add(struct btree_trans *trans, struct bkey
>  		fs_usage_data_type_to_base(&trans->fs_usage_delta, acc_k.replicas.data_type, a.v->d[0]);
>  		break;
>  	}
> -	return __bch2_accounting_mem_add(trans->c, a);
> +	return __bch2_accounting_mem_mod(trans->c, a);
>  }
>  
>  static inline void bch2_accounting_mem_read_counters(struct bch_fs *c,
> 


