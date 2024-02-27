Return-Path: <linux-kernel+bounces-83535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756CF869B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6688B293EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028CA14601E;
	Tue, 27 Feb 2024 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzHc/JKb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33738136659
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048865; cv=none; b=lnHGWlN19CE9prDMLEtwJRxJY5cItIrcAEPDY/0CEqrYZy1hvpLtaEe66DkENRrTq4a7rLP5CNqq4LgMKKXm/ZFWZZllq8D1aeVxQMz2yav4zGHZVMlvGobUOtenfDh7IYjoK5gVtg+ivMl5b1OZ6V2hRS7hMnppK/RurK3g1BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048865; c=relaxed/simple;
	bh=BE2F/vJm7npHgcZSkvVdV4JKIJCe0hqUCkF0daAOUIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emHzZYdSJGCqorMK/Rn2iicwcQNYaW9TQc+yQKPkH5/18n39Xpgs/DGbtFQ1ANp6G3xBW9D/t0Z0cvVsVz+WrrsJL8Opo5ok45JrDBvRAAw6NkR3zq8a8PIr5nmU2YMYKLYb8vagPtt1p/Lhmp4ZQVuCI0plv7su1yUIilNHZQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DzHc/JKb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709048862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ll57wroKwtPE/6JXM1AzKcZ0wkNzo7bP7d1PR49cpkY=;
	b=DzHc/JKbenKvjxD1tA+E4WMFUpZeJ/RRdfBpEeiEXpHPcFxUvaduxk+mG83UTotU06FzNR
	EzQvZKtZzz+7fjIHKl+EL6CmQt0d48x8+sR3iJiUgs9GAQpfo6r6/4Z8cYX5apqlbdrq3y
	mm9wH0PCcFLaduwLO+GxVoXAQ4coul8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-gYruJO8oMziySlCdbjFLnA-1; Tue,
 27 Feb 2024 10:47:37 -0500
X-MC-Unique: gYruJO8oMziySlCdbjFLnA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 794DE3C100B1;
	Tue, 27 Feb 2024 15:47:37 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 399032166B5D;
	Tue, 27 Feb 2024 15:47:37 +0000 (UTC)
Date: Tue, 27 Feb 2024 10:49:19 -0500
From: Brian Foster <bfoster@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH 01/21] bcachefs: KEY_TYPE_accounting
Message-ID: <Zd4Ef49kHX3g69VT@bfoster>
References: <20240225023826.2413565-1-kent.overstreet@linux.dev>
 <20240225023826.2413565-2-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225023826.2413565-2-kent.overstreet@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Sat, Feb 24, 2024 at 09:38:03PM -0500, Kent Overstreet wrote:
> New key type for the disk space accounting rewrite.
> 
>  - Holds a variable sized array of u64s (may be more than one for
>    accounting e.g. compressed and uncompressed size, or buckets and
>    sectors for a given data type)
> 
>  - Updates are deltas, not new versions of the key: this means updates
>    to accounting can happen via the btree write buffer, which we'll be
>    teaching to accumulate deltas.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  fs/bcachefs/Makefile                 |   3 +-
>  fs/bcachefs/bcachefs.h               |   1 +
>  fs/bcachefs/bcachefs_format.h        |  80 +++------------
>  fs/bcachefs/bkey_methods.c           |   1 +
>  fs/bcachefs/disk_accounting.c        |  70 ++++++++++++++
>  fs/bcachefs/disk_accounting.h        |  52 ++++++++++
>  fs/bcachefs/disk_accounting_format.h | 139 +++++++++++++++++++++++++++
>  fs/bcachefs/replicas_format.h        |  21 ++++
>  fs/bcachefs/sb-downgrade.c           |  12 ++-
>  fs/bcachefs/sb-errors_types.h        |   3 +-
>  10 files changed, 311 insertions(+), 71 deletions(-)
>  create mode 100644 fs/bcachefs/disk_accounting.c
>  create mode 100644 fs/bcachefs/disk_accounting.h
>  create mode 100644 fs/bcachefs/disk_accounting_format.h
>  create mode 100644 fs/bcachefs/replicas_format.h
> 
..
> diff --git a/fs/bcachefs/disk_accounting_format.h b/fs/bcachefs/disk_accounting_format.h
> new file mode 100644
> index 000000000000..e06a42f0d578
> --- /dev/null
> +++ b/fs/bcachefs/disk_accounting_format.h
> @@ -0,0 +1,139 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _BCACHEFS_DISK_ACCOUNTING_FORMAT_H
> +#define _BCACHEFS_DISK_ACCOUNTING_FORMAT_H
> +
> +#include "replicas_format.h"
> +
> +/*
> + * Disk accounting - KEY_TYPE_accounting - on disk format:
> + *
> + * Here, the key has considerably more structure than a typical key (bpos); an
> + * accounting key is 'struct disk_accounting_key', which is a union of bpos.
> + *

First impression.. I'm a little confused why the key type is a union of
bpos. I'm possibly missing something fundamental/obvious, but could you
elaborate more on why that is here?

Brian

> + * This is a type-tagged union of all our various subtypes; a disk accounting
> + * key can be device counters, replicas counters, et cetera - it's extensible.
> + *
> + * The value is a list of u64s or s64s; the number of counters is specific to a
> + * given accounting type.
> + *
> + * Unlike with other key types, updates are _deltas_, and the deltas are not
> + * resolved until the update to the underlying btree, done by btree write buffer
> + * flush or journal replay.
> + *
> + * Journal replay in particular requires special handling. The journal tracks a
> + * range of entries which may possibly have not yet been applied to the btree
> + * yet - it does not know definitively whether individual entries are dirty and
> + * still need to be applied.
> + *
> + * To handle this, we use the version field of struct bkey, and give every
> + * accounting update a unique version number - a total ordering in time; the
> + * version number is derived from the key's position in the journal. Then
> + * journal replay can compare the version number of the key from the journal
> + * with the version number of the key in the btree to determine if a key needs
> + * to be replayed.
> + *
> + * For this to work, we must maintain this strict time ordering of updates as
> + * they are flushed to the btree, both via write buffer flush and via journal
> + * replay. This has complications for the write buffer code while journal replay
> + * is still in progress; the write buffer cannot flush any accounting keys to
> + * the btree until journal replay has finished replaying its accounting keys, or
> + * the (newer) version number of the keys from the write buffer will cause
> + * updates from journal replay to be lost.
> + */
> +
> +struct bch_accounting {
> +	struct bch_val		v;
> +	__u64			d[];
> +};
> +
> +#define BCH_ACCOUNTING_MAX_COUNTERS		3
> +
> +#define BCH_DATA_TYPES()		\
> +	x(free,		0)		\
> +	x(sb,		1)		\
> +	x(journal,	2)		\
> +	x(btree,	3)		\
> +	x(user,		4)		\
> +	x(cached,	5)		\
> +	x(parity,	6)		\
> +	x(stripe,	7)		\
> +	x(need_gc_gens,	8)		\
> +	x(need_discard,	9)
> +
> +enum bch_data_type {
> +#define x(t, n) BCH_DATA_##t,
> +	BCH_DATA_TYPES()
> +#undef x
> +	BCH_DATA_NR
> +};
> +
> +static inline bool data_type_is_empty(enum bch_data_type type)
> +{
> +	switch (type) {
> +	case BCH_DATA_free:
> +	case BCH_DATA_need_gc_gens:
> +	case BCH_DATA_need_discard:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static inline bool data_type_is_hidden(enum bch_data_type type)
> +{
> +	switch (type) {
> +	case BCH_DATA_sb:
> +	case BCH_DATA_journal:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +#define BCH_DISK_ACCOUNTING_TYPES()		\
> +	x(nr_inodes,		0)		\
> +	x(persistent_reserved,	1)		\
> +	x(replicas,		2)		\
> +	x(dev_data_type,	3)		\
> +	x(dev_stripe_buckets,	4)
> +
> +enum disk_accounting_type {
> +#define x(f, nr)	BCH_DISK_ACCOUNTING_##f	= nr,
> +	BCH_DISK_ACCOUNTING_TYPES()
> +#undef x
> +	BCH_DISK_ACCOUNTING_TYPE_NR,
> +};
> +
> +struct bch_nr_inodes {
> +};
> +
> +struct bch_persistent_reserved {
> +	__u8			nr_replicas;
> +};
> +
> +struct bch_dev_data_type {
> +	__u8			dev;
> +	__u8			data_type;
> +};
> +
> +struct bch_dev_stripe_buckets {
> +	__u8			dev;
> +};
> +
> +struct disk_accounting_key {
> +	union {
> +	struct {
> +		__u8				type;
> +		union {
> +		struct bch_nr_inodes		nr_inodes;
> +		struct bch_persistent_reserved	persistent_reserved;
> +		struct bch_replicas_entry_v1	replicas;
> +		struct bch_dev_data_type	dev_data_type;
> +		struct bch_dev_stripe_buckets	dev_stripe_buckets;
> +		};
> +	};
> +		struct bpos			_pad;
> +	};
> +};
> +
> +#endif /* _BCACHEFS_DISK_ACCOUNTING_FORMAT_H */
> diff --git a/fs/bcachefs/replicas_format.h b/fs/bcachefs/replicas_format.h
> new file mode 100644
> index 000000000000..ed94f8c636b3
> --- /dev/null
> +++ b/fs/bcachefs/replicas_format.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _BCACHEFS_REPLICAS_FORMAT_H
> +#define _BCACHEFS_REPLICAS_FORMAT_H
> +
> +struct bch_replicas_entry_v0 {
> +	__u8			data_type;
> +	__u8			nr_devs;
> +	__u8			devs[];
> +} __packed;
> +
> +struct bch_replicas_entry_v1 {
> +	__u8			data_type;
> +	__u8			nr_devs;
> +	__u8			nr_required;
> +	__u8			devs[];
> +} __packed;
> +
> +#define replicas_entry_bytes(_i)					\
> +	(offsetof(typeof(*(_i)), devs) + (_i)->nr_devs)
> +
> +#endif /* _BCACHEFS_REPLICAS_FORMAT_H */
> diff --git a/fs/bcachefs/sb-downgrade.c b/fs/bcachefs/sb-downgrade.c
> index 3337419faeff..33db8d7ca8c4 100644
> --- a/fs/bcachefs/sb-downgrade.c
> +++ b/fs/bcachefs/sb-downgrade.c
> @@ -52,9 +52,15 @@
>  	  BCH_FSCK_ERR_subvol_fs_path_parent_wrong)		\
>  	x(btree_subvolume_children,				\
>  	  BIT_ULL(BCH_RECOVERY_PASS_check_subvols),		\
> -	  BCH_FSCK_ERR_subvol_children_not_set)
> +	  BCH_FSCK_ERR_subvol_children_not_set)			\
> +	x(disk_accounting_v2,					\
> +	  BIT_ULL(BCH_RECOVERY_PASS_check_allocations),		\
> +	  BCH_FSCK_ERR_accounting_mismatch)
>  
> -#define DOWNGRADE_TABLE()
> +#define DOWNGRADE_TABLE()					\
> +	x(disk_accounting_v2,					\
> +	  BIT_ULL(BCH_RECOVERY_PASS_check_alloc_info),		\
> +	  BCH_FSCK_ERR_dev_usage_buckets_wrong)
>  
>  struct upgrade_downgrade_entry {
>  	u64		recovery_passes;
> @@ -108,7 +114,7 @@ void bch2_sb_set_upgrade(struct bch_fs *c,
>  		}
>  }
>  
> -#define x(ver, passes, ...) static const u16 downgrade_ver_##errors[] = { __VA_ARGS__ };
> +#define x(ver, passes, ...) static const u16 downgrade_##ver##_errors[] = { __VA_ARGS__ };
>  DOWNGRADE_TABLE()
>  #undef x
>  
> diff --git a/fs/bcachefs/sb-errors_types.h b/fs/bcachefs/sb-errors_types.h
> index 0df4b0e7071a..383e13711001 100644
> --- a/fs/bcachefs/sb-errors_types.h
> +++ b/fs/bcachefs/sb-errors_types.h
> @@ -264,7 +264,8 @@
>  	x(subvol_children_not_set,				256)	\
>  	x(subvol_children_bad,					257)	\
>  	x(subvol_loop,						258)	\
> -	x(subvol_unreachable,					259)
> +	x(subvol_unreachable,					259)	\
> +	x(accounting_mismatch,					260)
>  
>  enum bch_sb_error_id {
>  #define x(t, n) BCH_FSCK_ERR_##t = n,
> -- 
> 2.43.0
> 


