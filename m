Return-Path: <linux-kernel+bounces-83545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BC0869B76
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEF42B2B12D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255D61468E7;
	Tue, 27 Feb 2024 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1jw7/1m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D1C13DBA4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049205; cv=none; b=s27oNfz1uarDfXkZUgOcGoxWARlwSC+NEu8soMpaXDZQ8+4efegm6nxdSgkgBTi1n30IlejLbRUY0RCyLSnsR4Y4zHkL0HvFFvD/CDzdMN7eMy0Ce8ZU465+zEcrE9y/nkjHQutoSoqsjWglfgKrFnUuc9Cxq0W4DVSh7MLRR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049205; c=relaxed/simple;
	bh=qAYbUEykLybZkWOWLXuxNNVYBNTmgHV08VDB/qzGKmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiYkhDi58my8Hq6wVfaU3niQXopYhFXlDWXLMEVjb2F4SBVfAlaq7zH11fTMmFfRQ7fqjn4FEKenLFDGhYs48XkkMW2+yAQfGHUGHUjT7sgvHxnxbMnlZo2MB4csdETxdTa02TcbTlZF8uW6v6G07nAikSuGxlMhTewWBUu1XVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1jw7/1m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709049202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sf5CPNtpK2zwwIWABk/x9riAsdh8wnzIv512T46x4qY=;
	b=J1jw7/1mndA/dgoBi5dEcACljl8BwumSPFwu5+H3MlPO7PadN0rcMPPSScZvttcl9zwLuR
	PclvidQrAryRlAv9x7tn/q/J2p/YXgA0Y7dl1xMDDiytEQE7eheR1Cqi43ZEcSL/ewQLkj
	VR2RV7sXMwKXnHuqn5Q1xirRSdDjKms=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-MykAFV9hN1iT8Wh_vOftIQ-1; Tue, 27 Feb 2024 10:53:20 -0500
X-MC-Unique: MykAFV9hN1iT8Wh_vOftIQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74D448489E7;
	Tue, 27 Feb 2024 15:53:20 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 34C412166B33;
	Tue, 27 Feb 2024 15:53:20 +0000 (UTC)
Date: Tue, 27 Feb 2024 10:55:02 -0500
From: Brian Foster <bfoster@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH 04/21] bcachefs: Disk space accounting rewrite
Message-ID: <Zd4F1qE1IFCz0/ML@bfoster>
References: <20240225023826.2413565-1-kent.overstreet@linux.dev>
 <20240225023826.2413565-5-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225023826.2413565-5-kent.overstreet@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Sat, Feb 24, 2024 at 09:38:06PM -0500, Kent Overstreet wrote:
> Main part of the disk accounting rewrite.
> 
> This is a wholesale rewrite of the existing disk space accounting, which
> relies on percepu counters that are sharded by journal buffer, and
> rolled up and added to each journal write.
> 
> With the new scheme, every set of counters is a distinct key in the
> accounting btree; this fixes scaling limitations of the old scheme,
> where counters took up space in each journal entry and required multiple
> percpu counters.
> 
> Now, in memory accounting requires a single set of percpu counters - not
> multiple for each in flight journal buffer - and in the future we'll
> probably also have counters that don't use in memory percpu counters,
> they're not strictly required.
> 
> An accounting update is now a normal btree update, using the btree write
> buffer path. At transaction commit time, we apply accounting updates to
> the in memory counters, which are percpu counters indexed in an
> eytzinger tree by the accounting key.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  fs/bcachefs/alloc_background.c      |  68 +++++-
>  fs/bcachefs/bcachefs.h              |   6 +-
>  fs/bcachefs/bcachefs_format.h       |   1 -
>  fs/bcachefs/bcachefs_ioctl.h        |   7 +-
>  fs/bcachefs/btree_gc.c              |   3 +-
>  fs/bcachefs/btree_iter.c            |   9 -
>  fs/bcachefs/btree_trans_commit.c    |  62 ++++--
>  fs/bcachefs/btree_types.h           |   1 -
>  fs/bcachefs/btree_update.h          |   8 -
>  fs/bcachefs/buckets.c               | 289 +++++---------------------
>  fs/bcachefs/buckets.h               |  33 +--
>  fs/bcachefs/disk_accounting.c       | 308 ++++++++++++++++++++++++++++
>  fs/bcachefs/disk_accounting.h       | 126 ++++++++++++
>  fs/bcachefs/disk_accounting_types.h |  20 ++
>  fs/bcachefs/ec.c                    |  24 ++-
>  fs/bcachefs/inode.c                 |   9 +-
>  fs/bcachefs/recovery.c              |  12 +-
>  fs/bcachefs/recovery_types.h        |   1 +
>  fs/bcachefs/replicas.c              |  42 ++--
>  fs/bcachefs/replicas.h              |  11 +-
>  fs/bcachefs/replicas_types.h        |  16 --
>  fs/bcachefs/sb-errors_types.h       |   3 +-
>  fs/bcachefs/super.c                 |  49 +++--
>  23 files changed, 704 insertions(+), 404 deletions(-)
>  create mode 100644 fs/bcachefs/disk_accounting_types.h
> 
..
> diff --git a/fs/bcachefs/disk_accounting.c b/fs/bcachefs/disk_accounting.c
> index 209f59e87b34..327c586ac661 100644
> --- a/fs/bcachefs/disk_accounting.c
> +++ b/fs/bcachefs/disk_accounting.c
..
> @@ -13,6 +17,44 @@ static const char * const disk_accounting_type_strs[] = {
>  	NULL
>  };
>  

So I'm gonna need to stare at all this much more than I have so far, but
one initial thing that stands out to me is the lack of high level
function comments. IMO, something that helps tremendously in
reading/reviewing these sorts of systemic changes is having a a couple
sentence or so comment at the top of the main/external interfaces just
to briefly explain what they do in plain english.

So here, something like "modify an accounting key in the btree based on
<whatever> ..." helps explain what it does and why it's used where it
is. The same goes for some of the other interface level functions, like
reading in accounting from disk, updating in-memory accounting (from
journal entries in committing transactions?), updating the superblock,
etc. I think I've started to put some of those pieces together, but
having to jump all through the implementation to piece together high
level behaviors is significantly more time consuming than having the
author guide one through the high level interactions.

IOW, I think if you minimally document the functions that are sufficient
to help understand how accounting works as a black box (somewhere
beneath the [nice] higher level big comment descriptions of the whole
thing and above the low level implementation details), that helps the
reviewer establish an understanding of the mechanism before having to
dig through the implementation details and also serves as a reference
going forward for the next person who is in a similar position and wants
to read/debug/tweak/whatever this code.

> +int bch2_disk_accounting_mod(struct btree_trans *trans,
> +			     struct disk_accounting_key *k,
> +			     s64 *d, unsigned nr)
> +{
> +	/* Normalize: */
> +	switch (k->type) {
> +	case BCH_DISK_ACCOUNTING_replicas:
> +		bubble_sort(k->replicas.devs, k->replicas.nr_devs, u8_cmp);
> +		break;
> +	}
> +
> +	BUG_ON(nr > BCH_ACCOUNTING_MAX_COUNTERS);
> +
> +	struct {
> +		__BKEY_PADDED(k, BCH_ACCOUNTING_MAX_COUNTERS);
> +	} k_i;
> +	struct bkey_i_accounting *acc = bkey_accounting_init(&k_i.k);
> +
> +	acc->k.p = disk_accounting_key_to_bpos(k);
> +	set_bkey_val_u64s(&acc->k, sizeof(struct bch_accounting) / sizeof(u64) + nr);
> +
> +	memcpy_u64s_small(acc->v.d, d, nr);
> +
> +	return bch2_trans_update_buffered(trans, BTREE_ID_accounting, &acc->k_i);
> +}
> +
..
> diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
> index a7f9de220d90..685d54d0ddbb 100644
> --- a/fs/bcachefs/super.c
> +++ b/fs/bcachefs/super.c
..
> @@ -1618,6 +1621,16 @@ int bch2_dev_remove(struct bch_fs *c, struct bch_dev *ca, int flags)
>  	if (ret)
>  		goto err;
>  
> +	/*
> +	 * We need to flush the entire journal to get rid of keys that reference
> +	 * the device being removed before removing the superblock entry
> +	 */
> +	bch2_journal_flush_all_pins(&c->journal);

I thought this needed to occur between the device removal and superblock
update (according to the comment below). Is that not the case? Either
way, is it moved for reasons related to accounting?

Brian

> +
> +	/*
> +	 * this is really just needed for the bch2_replicas_gc_(start|end)
> +	 * calls, and could be cleaned up:
> +	 */
>  	ret = bch2_journal_flush_device_pins(&c->journal, ca->dev_idx);
>  	bch_err_msg(ca, ret, "bch2_journal_flush_device_pins()");
>  	if (ret)
> @@ -1655,17 +1668,6 @@ int bch2_dev_remove(struct bch_fs *c, struct bch_dev *ca, int flags)
>  
>  	bch2_dev_free(ca);
>  
> -	/*
> -	 * At this point the device object has been removed in-core, but the
> -	 * on-disk journal might still refer to the device index via sb device
> -	 * usage entries. Recovery fails if it sees usage information for an
> -	 * invalid device. Flush journal pins to push the back of the journal
> -	 * past now invalid device index references before we update the
> -	 * superblock, but after the device object has been removed so any
> -	 * further journal writes elide usage info for the device.
> -	 */
> -	bch2_journal_flush_all_pins(&c->journal);
> -
>  	/*
>  	 * Free this device's slot in the bch_member array - all pointers to
>  	 * this device must be gone:
> @@ -1727,8 +1729,6 @@ int bch2_dev_add(struct bch_fs *c, const char *path)
>  		goto err;
>  	}
>  
> -	bch2_dev_usage_init(ca);
> -
>  	ret = __bch2_dev_attach_bdev(ca, &sb);
>  	if (ret)
>  		goto err;
> @@ -1793,6 +1793,10 @@ int bch2_dev_add(struct bch_fs *c, const char *path)
>  
>  	bch2_dev_usage_journal_reserve(c);
>  
> +	ret = bch2_dev_usage_init(ca);
> +	if (ret)
> +		goto err_late;
> +
>  	ret = bch2_trans_mark_dev_sb(c, ca);
>  	bch_err_msg(ca, ret, "marking new superblock");
>  	if (ret)
> @@ -1956,15 +1960,18 @@ int bch2_dev_resize(struct bch_fs *c, struct bch_dev *ca, u64 nbuckets)
>  	mutex_unlock(&c->sb_lock);
>  
>  	if (ca->mi.freespace_initialized) {
> -		ret = bch2_dev_freespace_init(c, ca, old_nbuckets, nbuckets);
> +		struct disk_accounting_key acc = {
> +			.type = BCH_DISK_ACCOUNTING_dev_data_type,
> +			.dev_data_type.dev = ca->dev_idx,
> +			.dev_data_type.data_type = BCH_DATA_free,
> +		};
> +		u64 v[3] = { nbuckets - old_nbuckets, 0, 0 };
> +
> +		ret   = bch2_dev_freespace_init(c, ca, old_nbuckets, nbuckets) ?:
> +			bch2_trans_do(ca->fs, NULL, NULL, 0,
> +				bch2_disk_accounting_mod(trans, &acc, v, ARRAY_SIZE(v)));
>  		if (ret)
>  			goto err;
> -
> -		/*
> -		 * XXX: this is all wrong transactionally - we'll be able to do
> -		 * this correctly after the disk space accounting rewrite
> -		 */
> -		ca->usage_base->d[BCH_DATA_free].buckets += nbuckets - old_nbuckets;
>  	}
>  
>  	bch2_recalc_capacity(c);
> -- 
> 2.43.0
> 


