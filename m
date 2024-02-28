Return-Path: <linux-kernel+bounces-85661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D16486B8D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63771F2AE14
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5FB34CDE;
	Wed, 28 Feb 2024 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p62TuRDJ"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AC35E078
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150772; cv=none; b=lW5EO1y93+Ei6ir5Rq84Nlnmhz6+zPs/UqFCZv5wxUzyK7gl+9cQqWx5I5Ja4zdGpXqmDoEbQwrQebsla5secrcouyiZV13wc982r2Lmf4RNbm4YLa7ZIQLYweVUNuWpFhMNghI6GDrESLl3G/QrbqyuYK2E/UMeiUHaIL36hqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150772; c=relaxed/simple;
	bh=k/m4YheVfQs4VHgcocYJE6LjLMExMpl/5ZaI3/fMn8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRtAYMBxasQJtDgE6KkNYPAdpLwGRgsTzkWtanN3oWeUJX7QxezzrIn6JdQU3gcduiOM+g5+scLqSnLneKMILsRRVaiIIsMrRLY3z4wZEH/47FbbWAL8odl4TG2ONaGmqZbgiQ3PDvomotM2L0M9IZXNVZm0euYOhacA1RNYnAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p62TuRDJ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Feb 2024 15:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709150768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Od6nSrqP2/hZbAtGU3cLKbPlzuM3mAeGtdvOMo4Vn/I=;
	b=p62TuRDJRe5Gi6VYpKsvcCPUoOCqt4c/PugiE8eqtxJDAYA/o/AtmO0Kn5f4tg3ilLMAT/
	SJChWy1VQj/nxbPhnPtFW1q2hysyTIyyY2iGuHaQ9OJMXbO8v5GIZUBKgvx11+FyVizGnR
	Mjq6NfDXp8LBql/eO5BLQY+UH1PtS8I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	djwong@kernel.org
Subject: Re: [PATCH 02/21] bcachefs: Accumulate accounting keys in journal
 replay
Message-ID: <zy6htbwdtvq2wikbgflfisbpu7lsluejch67wlbdmrin5d3awa@elqulgzc3bn5>
References: <20240225023826.2413565-1-kent.overstreet@linux.dev>
 <20240225023826.2413565-3-kent.overstreet@linux.dev>
 <Zd4EmpK0zJp0mbml@bfoster>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd4EmpK0zJp0mbml@bfoster>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 27, 2024 at 10:49:46AM -0500, Brian Foster wrote:
> On Sat, Feb 24, 2024 at 09:38:04PM -0500, Kent Overstreet wrote:
> > Until accounting keys hit the btree, they are deltas, not new versions
> > of the existing key; this means we have to teach journal replay to
> > accumulate them.
> > 
> > Additionally, the journal doesn't track precisely which entries have
> > been flushed to the btree; it only tracks a range of entries that may
> > possibly still need to be flushed.
> > 
> > That means we need to compare accounting keys against the version in the
> > btree and only flush updates that are newer.
> > 
> > There's another wrinkle with the write buffer: if the write buffer
> > starts flushing accounting keys before journal replay has finished
> > flushing accounting keys, journal replay will see the version number
> > from the new updates and updates from the journal will be lost.
> > 
> > To avoid this, journal replay has to flush accounting keys first, and
> > we'll be adding a flag so that write buffer flush knows to hold
> > accounting keys until then.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > ---
> >  fs/bcachefs/btree_journal_iter.c | 23 +++-------
> >  fs/bcachefs/btree_journal_iter.h | 15 +++++++
> >  fs/bcachefs/btree_trans_commit.c |  9 +++-
> >  fs/bcachefs/btree_update.h       | 14 +++++-
> >  fs/bcachefs/recovery.c           | 76 +++++++++++++++++++++++++++++++-
> >  5 files changed, 117 insertions(+), 20 deletions(-)
> > 
> ...
> > diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
> > index 96e7a1ec7091..6829d80bd181 100644
> > --- a/fs/bcachefs/recovery.c
> > +++ b/fs/bcachefs/recovery.c
> > @@ -11,6 +11,7 @@
> >  #include "btree_io.h"
> >  #include "buckets.h"
> >  #include "dirent.h"
> > +#include "disk_accounting.h"
> >  #include "ec.h"
> >  #include "errcode.h"
> >  #include "error.h"
> > @@ -87,6 +88,56 @@ static void replay_now_at(struct journal *j, u64 seq)
> >  		bch2_journal_pin_put(j, j->replay_journal_seq++);
> >  }
> >  
> > +static int bch2_journal_replay_accounting_key(struct btree_trans *trans,
> > +					      struct journal_key *k)
> > +{
> > +	struct journal_keys *keys = &trans->c->journal_keys;
> > +
> > +	struct btree_iter iter;
> > +	bch2_trans_node_iter_init(trans, &iter, k->btree_id, k->k->k.p,
> > +				  BTREE_MAX_DEPTH, k->level,
> > +				  BTREE_ITER_INTENT);
> > +	int ret = bch2_btree_iter_traverse(&iter);
> > +	if (ret)
> > +		goto out;
> > +
> > +	struct bkey u;
> > +	struct bkey_s_c old = bch2_btree_path_peek_slot(btree_iter_path(trans, &iter), &u);
> > +
> > +	if (bversion_cmp(old.k->version, k->k->k.version) >= 0) {
> > +		ret = 0;
> > +		goto out;
> > +	}
> 
> So I assume this is what correlates back to the need to not flush the
> write buffer until replay completes, otherwise we could unintentionally
> skip subsequent key updates. Is that the case?

No, this is the "has this delta been applie to the btree key" check -
adding that as a comment.

Write buffer exclusion comes with a new filesytem bit that gets set once
accounting keys have all been replayed, that's in the next patch

