Return-Path: <linux-kernel+bounces-83537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8CB869B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47BF4B2E9D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C403B1482F1;
	Tue, 27 Feb 2024 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+xsb+3t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B106146E91
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048892; cv=none; b=TtLx42laq7XC6U26m/MqUIBq9Lgnw3dM6E8Hr1UgdHXY+o+suiL/HvFwyCM/KsbYD0G/v/CosWPSlhhOt4A8MHSN1trg8JnD6SUk9mvyTYT6Szeux7LKDONNvnLGumtRPrXwXZFNHq3+iEqVWNS65aYrKrhS/7L331NrfjKFIjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048892; c=relaxed/simple;
	bh=5IiVI93ftUJqT+CCb32p6HAxT/tP2McLx9FLAz4oqsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIIXwdTlRVar2dO4oJS78cPMFMohzWVIYl51Tl+UViw4GpAHnbWvZL81EyCuLzOdde9vjVpZc14LnCO+EqZVqYfeyqnIM8rrA/LHSm8FvAmOuE40uox13uL/wkOuVFuhZGeW12/j0fcYoyjqMmOtSLOAPIrgE4X0kdf8yn3CgZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+xsb+3t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709048888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4b1Tyl4aPcg7pGwu6b92y+s1c1JJGt4qQ6bGVrOMVjU=;
	b=Y+xsb+3t6Uh9g1ymuynl4cix0s5gJ6UnSqsCJSbn6WZgcgWCI5uvhPbvGQnFdG5YhNXxcC
	FmDZSyTqRtcTGBV/UA911SCopSD7629fFohtntFFy2JUNsqkucrJtmdjSrEHgSZJYWRfnO
	WHj4r2CHpPI/hDcOjMHXQE47yuy0oT4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-G4XhUFHgOo2fE-7yfpzdPg-1; Tue,
 27 Feb 2024 10:48:04 -0500
X-MC-Unique: G4XhUFHgOo2fE-7yfpzdPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 768291C0BA54;
	Tue, 27 Feb 2024 15:48:04 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EB921CBC8;
	Tue, 27 Feb 2024 15:48:04 +0000 (UTC)
Date: Tue, 27 Feb 2024 10:49:46 -0500
From: Brian Foster <bfoster@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH 02/21] bcachefs: Accumulate accounting keys in journal
 replay
Message-ID: <Zd4EmpK0zJp0mbml@bfoster>
References: <20240225023826.2413565-1-kent.overstreet@linux.dev>
 <20240225023826.2413565-3-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225023826.2413565-3-kent.overstreet@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Sat, Feb 24, 2024 at 09:38:04PM -0500, Kent Overstreet wrote:
> Until accounting keys hit the btree, they are deltas, not new versions
> of the existing key; this means we have to teach journal replay to
> accumulate them.
> 
> Additionally, the journal doesn't track precisely which entries have
> been flushed to the btree; it only tracks a range of entries that may
> possibly still need to be flushed.
> 
> That means we need to compare accounting keys against the version in the
> btree and only flush updates that are newer.
> 
> There's another wrinkle with the write buffer: if the write buffer
> starts flushing accounting keys before journal replay has finished
> flushing accounting keys, journal replay will see the version number
> from the new updates and updates from the journal will be lost.
> 
> To avoid this, journal replay has to flush accounting keys first, and
> we'll be adding a flag so that write buffer flush knows to hold
> accounting keys until then.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  fs/bcachefs/btree_journal_iter.c | 23 +++-------
>  fs/bcachefs/btree_journal_iter.h | 15 +++++++
>  fs/bcachefs/btree_trans_commit.c |  9 +++-
>  fs/bcachefs/btree_update.h       | 14 +++++-
>  fs/bcachefs/recovery.c           | 76 +++++++++++++++++++++++++++++++-
>  5 files changed, 117 insertions(+), 20 deletions(-)
> 
..
> diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
> index 96e7a1ec7091..6829d80bd181 100644
> --- a/fs/bcachefs/recovery.c
> +++ b/fs/bcachefs/recovery.c
> @@ -11,6 +11,7 @@
>  #include "btree_io.h"
>  #include "buckets.h"
>  #include "dirent.h"
> +#include "disk_accounting.h"
>  #include "ec.h"
>  #include "errcode.h"
>  #include "error.h"
> @@ -87,6 +88,56 @@ static void replay_now_at(struct journal *j, u64 seq)
>  		bch2_journal_pin_put(j, j->replay_journal_seq++);
>  }
>  
> +static int bch2_journal_replay_accounting_key(struct btree_trans *trans,
> +					      struct journal_key *k)
> +{
> +	struct journal_keys *keys = &trans->c->journal_keys;
> +
> +	struct btree_iter iter;
> +	bch2_trans_node_iter_init(trans, &iter, k->btree_id, k->k->k.p,
> +				  BTREE_MAX_DEPTH, k->level,
> +				  BTREE_ITER_INTENT);
> +	int ret = bch2_btree_iter_traverse(&iter);
> +	if (ret)
> +		goto out;
> +
> +	struct bkey u;
> +	struct bkey_s_c old = bch2_btree_path_peek_slot(btree_iter_path(trans, &iter), &u);
> +
> +	if (bversion_cmp(old.k->version, k->k->k.version) >= 0) {
> +		ret = 0;
> +		goto out;
> +	}

So I assume this is what correlates back to the need to not flush the
write buffer until replay completes, otherwise we could unintentionally
skip subsequent key updates. Is that the case?

If so, it would be nice to have some comments here that explain this.
I.e., I don't quite have a big enough picture to know where or how this
is prevented to ensure that the version updates down the key
accumulation helpers don't conflict with this particular check, so
something that helps connect the dots enough to somebody who doesn't
already know how this is all supposed to work would be useful.

Brian

> +
> +	if (k + 1 < &darray_top(*keys) &&
> +	    !journal_key_cmp(k, k + 1)) {
> +		BUG_ON(bversion_cmp(k[0].k->k.version, k[1].k->k.version) > 0);
> +
> +		bch2_accounting_accumulate(bkey_i_to_accounting(k[1].k),
> +					   bkey_i_to_s_c_accounting(k[0].k));
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	struct bkey_i *new = k->k;
> +	if (old.k->type == KEY_TYPE_accounting) {
> +		new = bch2_bkey_make_mut_noupdate(trans, bkey_i_to_s_c(k->k));
> +		ret = PTR_ERR_OR_ZERO(new);
> +		if (ret)
> +			goto out;
> +
> +		bch2_accounting_accumulate(bkey_i_to_accounting(new),
> +					   bkey_s_c_to_accounting(old));
> +	}
> +
> +	trans->journal_res.seq = k->journal_seq;
> +
> +	ret = bch2_trans_update(trans, &iter, new, BTREE_TRIGGER_NORUN);
> +out:
> +	bch2_trans_iter_exit(trans, &iter);
> +	return ret;
> +}
> +
>  static int bch2_journal_replay_key(struct btree_trans *trans,
>  				   struct journal_key *k)
>  {
> @@ -159,12 +210,33 @@ static int bch2_journal_replay(struct bch_fs *c)
>  
>  	BUG_ON(!atomic_read(&keys->ref));
>  
> +	/*
> +	 * Replay accounting keys first: we can't allow the write buffer to
> +	 * flush accounting keys until we're done
> +	 */
> +	darray_for_each(*keys, k) {
> +		if (!(k->k->k.type == KEY_TYPE_accounting && !k->allocated))
> +			continue;
> +
> +		cond_resched();
> +
> +		ret = commit_do(trans, NULL, NULL,
> +				BCH_TRANS_COMMIT_no_enospc|
> +				BCH_TRANS_COMMIT_no_journal_res,
> +			     bch2_journal_replay_accounting_key(trans, k));
> +		if (bch2_fs_fatal_err_on(ret, c, "error replaying accounting; %s", bch2_err_str(ret)))
> +			goto err;
> +	}
> +
>  	/*
>  	 * First, attempt to replay keys in sorted order. This is more
>  	 * efficient - better locality of btree access -  but some might fail if
>  	 * that would cause a journal deadlock.
>  	 */
>  	darray_for_each(*keys, k) {
> +		if (k->k->k.type == KEY_TYPE_accounting && !k->allocated)
> +			continue;
> +
>  		cond_resched();
>  
>  		/* Skip fastpath if we're low on space in the journal */
> @@ -174,7 +246,7 @@ static int bch2_journal_replay(struct bch_fs *c)
>  				  BCH_TRANS_COMMIT_journal_reclaim|
>  				  (!k->allocated ? BCH_TRANS_COMMIT_no_journal_res : 0),
>  			     bch2_journal_replay_key(trans, k));
> -		BUG_ON(!ret && !k->overwritten);
> +		BUG_ON(!ret && !k->overwritten && k->k->k.type != KEY_TYPE_accounting);
>  		if (ret) {
>  			ret = darray_push(&keys_sorted, k);
>  			if (ret)
> @@ -208,7 +280,7 @@ static int bch2_journal_replay(struct bch_fs *c)
>  		if (ret)
>  			goto err;
>  
> -		BUG_ON(!k->overwritten);
> +		BUG_ON(k->btree_id != BTREE_ID_accounting && !k->overwritten);
>  	}
>  
>  	/*
> -- 
> 2.43.0
> 


