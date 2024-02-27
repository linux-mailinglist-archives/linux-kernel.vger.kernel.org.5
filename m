Return-Path: <linux-kernel+bounces-83539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA25869B04
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92624285BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73F61482E0;
	Tue, 27 Feb 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IERhslfA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155B41474B1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048928; cv=none; b=BLLvpOjgxe+1EywTuoSDsI6bsNwCKlAyW/nDsMJ7JygvHIan205ZSD9LkKvYG7ls+gozSZhHg2MPDc9UhQe/5ZT1Uq6Y+knkvRdTxNwqUUQ24ZY4nlWfs0HGKfyhmHlcWTK+gw/SQIYs8mUY4f000B82k9rSa3VqEqQt2ouy3X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048928; c=relaxed/simple;
	bh=i9u+dH97zSEs1MAnJLs4Et4BvaFS2eYMv/edXCLeuA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5rmkF34dx3xT6IINqH3dFA4JkOARAax9T8ueYAD7cINbyU8C2ZmJItbdSIBN9nJKaPkt/BhngoqH00BIFR2Bk8i+YO+OJ7ZYn6+kjTVTdj7P2UNgQzsPaIMg+dyEloRXg6NAlVMSbPgPDw2yjNELvo3ykwGptbJMTUHOgos9S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IERhslfA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709048924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wlhecyX4wcvqsYqsTlIlSWKDqo0GLSZ3uSP1tPTi8UA=;
	b=IERhslfAZ7cihYEZWSmK1KfWiPHVK3pYqxG/142ScPwsZn+abzj2D63xpnEap6mv8ef8No
	RCh/ONJDfWdPm8krztYRKERpLaGhIAzANuACTX3AsBvyUluQaD0a00FkltqyxAgfjjRGK/
	evWchOAZ0SvLtMCu2k6ShJrzOhy/DSY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-ymtI2wXdMNyMZSVJv2jKPg-1; Tue, 27 Feb 2024 10:48:43 -0500
X-MC-Unique: ymtI2wXdMNyMZSVJv2jKPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5102F84ACA3;
	Tue, 27 Feb 2024 15:48:42 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 12BA52166B33;
	Tue, 27 Feb 2024 15:48:42 +0000 (UTC)
Date: Tue, 27 Feb 2024 10:50:23 -0500
From: Brian Foster <bfoster@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH 03/21] bcachefs: btree write buffer knows how to
 accumulate bch_accounting keys
Message-ID: <Zd4Ev8XPzn5AJ8K9@bfoster>
References: <20240225023826.2413565-1-kent.overstreet@linux.dev>
 <20240225023826.2413565-4-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225023826.2413565-4-kent.overstreet@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Sat, Feb 24, 2024 at 09:38:05PM -0500, Kent Overstreet wrote:
> Teach the btree write buffer how to accumulate accounting keys - instead
> of having the newer key overwrite the older key as we do with other
> updates, we need to add them together.
> 
> Also, add a flag so that write buffer flush knows when journal replay is
> finished flushing accounting, and teach it to hold accounting keys until
> that flag is set.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  fs/bcachefs/bcachefs.h           |  1 +
>  fs/bcachefs/btree_write_buffer.c | 66 +++++++++++++++++++++++++++-----
>  fs/bcachefs/recovery.c           |  3 ++
>  3 files changed, 61 insertions(+), 9 deletions(-)
> 
..
> diff --git a/fs/bcachefs/btree_write_buffer.c b/fs/bcachefs/btree_write_buffer.c
> index b77e7b382b66..002a0762fc85 100644
> --- a/fs/bcachefs/btree_write_buffer.c
> +++ b/fs/bcachefs/btree_write_buffer.c
> @@ -5,6 +5,7 @@
>  #include "btree_update.h"
>  #include "btree_update_interior.h"
>  #include "btree_write_buffer.h"
> +#include "disk_accounting.h"
>  #include "error.h"
>  #include "journal.h"
>  #include "journal_io.h"
> @@ -123,7 +124,9 @@ static noinline int wb_flush_one_slowpath(struct btree_trans *trans,
>  
>  static inline int wb_flush_one(struct btree_trans *trans, struct btree_iter *iter,
>  			       struct btree_write_buffered_key *wb,
> -			       bool *write_locked, size_t *fast)
> +			       bool *write_locked,
> +			       bool *accounting_accumulated,
> +			       size_t *fast)
>  {
>  	struct btree_path *path;
>  	int ret;
> @@ -136,6 +139,16 @@ static inline int wb_flush_one(struct btree_trans *trans, struct btree_iter *ite
>  	if (ret)
>  		return ret;
>  
> +	if (!*accounting_accumulated && wb->k.k.type == KEY_TYPE_accounting) {
> +		struct bkey u;
> +		struct bkey_s_c k = bch2_btree_path_peek_slot_exact(btree_iter_path(trans, iter), &u);
> +
> +		if (k.k->type == KEY_TYPE_accounting)
> +			bch2_accounting_accumulate(bkey_i_to_accounting(&wb->k),
> +						   bkey_s_c_to_accounting(k));

So it looks like we're accumulating from the btree key into the write
buffer key. Is this so the following code will basically insert a new
btree key based on the value of the write buffer key?

> +	}
> +	*accounting_accumulated = true;
> +
>  	/*
>  	 * We can't clone a path that has write locks: unshare it now, before
>  	 * set_pos and traverse():
> @@ -248,8 +261,9 @@ static int bch2_btree_write_buffer_flush_locked(struct btree_trans *trans)
>  	struct journal *j = &c->journal;
>  	struct btree_write_buffer *wb = &c->btree_write_buffer;
>  	struct btree_iter iter = { NULL };
> -	size_t skipped = 0, fast = 0, slowpath = 0;
> +	size_t overwritten = 0, fast = 0, slowpath = 0, could_not_insert = 0;
>  	bool write_locked = false;
> +	bool accounting_replay_done = test_bit(BCH_FS_accounting_replay_done, &c->flags);
>  	int ret = 0;
>  
>  	bch2_trans_unlock(trans);
> @@ -284,17 +298,29 @@ static int bch2_btree_write_buffer_flush_locked(struct btree_trans *trans)
>  
>  	darray_for_each(wb->sorted, i) {
>  		struct btree_write_buffered_key *k = &wb->flushing.keys.data[i->idx];
> +		bool accounting_accumulated = false;

Should this live within the interior flush loop?

>  
>  		for (struct wb_key_ref *n = i + 1; n < min(i + 4, &darray_top(wb->sorted)); n++)
>  			prefetch(&wb->flushing.keys.data[n->idx]);
>  
>  		BUG_ON(!k->journal_seq);
>  
> +		if (!accounting_replay_done &&
> +		    k->k.k.type == KEY_TYPE_accounting) {
> +			slowpath++;
> +			continue;
> +		}
> +
>  		if (i + 1 < &darray_top(wb->sorted) &&
>  		    wb_key_eq(i, i + 1)) {
>  			struct btree_write_buffered_key *n = &wb->flushing.keys.data[i[1].idx];
>  
> -			skipped++;
> +			if (k->k.k.type == KEY_TYPE_accounting &&
> +			    n->k.k.type == KEY_TYPE_accounting)
> +				bch2_accounting_accumulate(bkey_i_to_accounting(&n->k),
> +							   bkey_i_to_s_c_accounting(&k->k));
> +
> +			overwritten++;
>  			n->journal_seq = min_t(u64, n->journal_seq, k->journal_seq);
>  			k->journal_seq = 0;
>  			continue;
> @@ -325,7 +351,8 @@ static int bch2_btree_write_buffer_flush_locked(struct btree_trans *trans)
>  				break;
>  			}
>  
> -			ret = wb_flush_one(trans, &iter, k, &write_locked, &fast);
> +			ret = wb_flush_one(trans, &iter, k, &write_locked,
> +					   &accounting_accumulated, &fast);
>  			if (!write_locked)
>  				bch2_trans_begin(trans);
>  		} while (bch2_err_matches(ret, BCH_ERR_transaction_restart));
> @@ -361,8 +388,15 @@ static int bch2_btree_write_buffer_flush_locked(struct btree_trans *trans)
>  			if (!i->journal_seq)
>  				continue;
>  
> -			bch2_journal_pin_update(j, i->journal_seq, &wb->flushing.pin,
> -						bch2_btree_write_buffer_journal_flush);
> +			if (!accounting_replay_done &&
> +			    i->k.k.type == KEY_TYPE_accounting) {
> +				could_not_insert++;
> +				continue;
> +			}
> +
> +			if (!could_not_insert)
> +				bch2_journal_pin_update(j, i->journal_seq, &wb->flushing.pin,
> +							bch2_btree_write_buffer_journal_flush);

Hmm.. so this is sane because the slowpath runs in journal sorted order,
right?

>  
>  			bch2_trans_begin(trans);
>  
> @@ -375,13 +409,27 @@ static int bch2_btree_write_buffer_flush_locked(struct btree_trans *trans)
>  					btree_write_buffered_insert(trans, i));
>  			if (ret)
>  				goto err;
> +
> +			i->journal_seq = 0;
> +		}
> +

		/*
		 * Condense the remaining keys <reasons reasons>...??
		 */

> +		if (could_not_insert) {
> +			struct btree_write_buffered_key *dst = wb->flushing.keys.data;
> +
> +			darray_for_each(wb->flushing.keys, i)
> +				if (i->journal_seq)
> +					*dst++ = *i;
> +			wb->flushing.keys.nr = dst - wb->flushing.keys.data;
>  		}
>  	}
>  err:
> +	if (ret || !could_not_insert) {
> +		bch2_journal_pin_drop(j, &wb->flushing.pin);
> +		wb->flushing.keys.nr = 0;
> +	}
> +
>  	bch2_fs_fatal_err_on(ret, c, "%s: insert error %s", __func__, bch2_err_str(ret));
> -	trace_write_buffer_flush(trans, wb->flushing.keys.nr, skipped, fast, 0);
> -	bch2_journal_pin_drop(j, &wb->flushing.pin);
> -	wb->flushing.keys.nr = 0;
> +	trace_write_buffer_flush(trans, wb->flushing.keys.nr, overwritten, fast, 0);

I feel like the last time I looked at the write buffer stuff the flush
wasn't reentrant in this way. I.e., the flush switched out the active
buffer and so had to process all entries in the current buffer (or
something like that). Has something changed or do I misunderstand?

>  	return ret;
>  }
>  
> diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
> index 6829d80bd181..b8289af66c8e 100644
> --- a/fs/bcachefs/recovery.c
> +++ b/fs/bcachefs/recovery.c
> @@ -228,6 +228,8 @@ static int bch2_journal_replay(struct bch_fs *c)
>  			goto err;
>  	}
>  
> +	set_bit(BCH_FS_accounting_replay_done, &c->flags);
> +

I assume this ties into the question on the previous patch..

Related question.. if the write buffer can't flush during journal
replay, is there concern/risk of overflowing it?

Brian

>  	/*
>  	 * First, attempt to replay keys in sorted order. This is more
>  	 * efficient - better locality of btree access -  but some might fail if
> @@ -1204,6 +1206,7 @@ int bch2_fs_initialize(struct bch_fs *c)
>  	 * set up the journal.pin FIFO and journal.cur pointer:
>  	 */
>  	bch2_fs_journal_start(&c->journal, 1);
> +	set_bit(BCH_FS_accounting_replay_done, &c->flags);
>  	bch2_journal_set_replay_done(&c->journal);
>  
>  	ret = bch2_fs_read_write_early(c);
> -- 
> 2.43.0
> 


