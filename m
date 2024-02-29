Return-Path: <linux-kernel+bounces-87568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7400C86D5FC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A4F1C22034
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C23C16FF46;
	Thu, 29 Feb 2024 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CQrBuw1y"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91516FF3D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241369; cv=none; b=OH1VqSRCFwez5Z8iHrkXla2D5XP6jHrXFKvQqeeG/5KVCwCiGJ75uvaNQzPvF7BxynXQ/EaUUvQgNarEV/mrr3H+yWfE9CyOgFUMJpH4WVLjNrgd7jArK0pY8lJuO2RYVHjCWRnuhNEvAO1ii4UO/PxxNnN9UW0pB5+siqcz86w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241369; c=relaxed/simple;
	bh=GbSiUCEsK5WKIrBs1f7wwnYnNZ8OBJjeOhbGTnZjLGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGqtx8nIKluwpcxaOd4zYL06xcP1lUimJv5UDCdb/UmL9nMqNacDFBwfhcwugaS57uKY82WdWZkKorkJMB3a+25ttVR7YMM2l0b2VJ7NIX+KOa80NZ3gcd04W4mOfN0w9DtDpCT3zCXtxHs/+ukmFkoahOLjIUiT2AQndVp6NnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CQrBuw1y; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Feb 2024 16:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709241364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mcv3ho/sqU8JudPS9XpPlyVW0HXTQfq0tXs90e5OpOk=;
	b=CQrBuw1yxGM5VUD2OZqSKSeN/o204capQxWlH7pwhMhtHpNTFbO9UGoKcjN2OWMXizWOFw
	+K7SAtG+yaELwKzps+BfaM39nYIsMQfN7sJucS1W2TStgYU9ztNt9B9QH3/PVA9JLIvmB2
	dQr6l8mZvIWSBdEZspG0Y//hfThfXAE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	djwong@kernel.org
Subject: Re: [PATCH 04/21] bcachefs: Disk space accounting rewrite
Message-ID: <nywd7rix6qapogaqg5kxny3k272ptpzi4qv5q2dqts42bqbxrw@te5enoxvdhti>
References: <20240225023826.2413565-1-kent.overstreet@linux.dev>
 <20240225023826.2413565-5-kent.overstreet@linux.dev>
 <Zd4F1qE1IFCz0/ML@bfoster>
 <3dug3vvjmlkhu42glwhkm5ozgkp4tzqvekxdabbgv4dv4yhxig@r5bw746uaxym>
 <ZeDQi3mRwJc7wqX/@bfoster>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeDQi3mRwJc7wqX/@bfoster>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 29, 2024 at 01:44:27PM -0500, Brian Foster wrote:
> On Wed, Feb 28, 2024 at 11:10:12PM -0500, Kent Overstreet wrote:
> > I think it ended up not needing to be moved, and I just forgot to drop
> > it - originally I disallowed accounting entries that referenced
> > nonexistent devices, but that wasn't workable so now it's only nonzero
> > accounting keys that aren't allowed to reference nonexistent devices.
> > 
> > I'll see if I can delete it.
> > 
> 
> Do you mean to delete the change that moves the call, or the flush call
> entirely?

Delte the change, I think there's further cleanup (& probably bugs to
fix) possible with that flush call but I'm not going to get into it
right now.

> > +/*
> > + * Notes on disk accounting:
> > + *
> > + * We have two parallel sets of counters to be concerned with, and both must be
> > + * kept in sync.
> > + *
> > + *  - Persistent/on disk accounting, stored in the accounting btree and updated
> > + *    via btree write buffer updates that treat new accounting keys as deltas to
> > + *    apply to existing values. But reading from a write buffer btree is
> > + *    expensive, so we also have
> > + *
> 
> I find the wording a little odd here, and I also think it would be
> helpful to explain how/from where the deltas originate. For example,
> something along the lines of:
> 
> "Persistent/on disk accounting, stored in the accounting btree and
> updated via btree write buffer updates. Accounting updates are
> represented as deltas that originate from <somewhere? trans triggers?>.
> Accounting keys represent these deltas through commit into the write
> buffer. The accounting/delta keys in the write buffer are then
> accumulated into the appropriate accounting btree key at write buffer
> flush time."

yeah, that's worth including.

There's an interesting point that you're touching on; btree write buffer
are always dependent state changes from some other (non write buffer)
btree; we never look at a write buffer btree and generate an update
there - we can't, reading from a write buffer btree doesn't get you
anything consistent or up to date.

So in normal operation it really only makes sense to do write buffer
updates from a transactional trigger - that's the only way to use them
and have them be consistent with the resst of the filesystem.

And since triggers work by comparing old and new, they naturally
generate updates that are deltas.

> > + *  - In memory accounting, where accounting is stored as an array of percpu
> > + *    counters, indexed by an eytzinger array of disk acounting keys/bpos (which
> > + *    are the same thing, excepting byte swabbing on big endian).
> > + *
> 
> Not really sure about the keys vs. bpos thing, kind of related to my
> comments on the earlier patch. It might be more clear to just elide the
> implementation details here, i.e.:
> 
> "In memory accounting, where accounting is stored as an array of percpu
> counters that are cheap to read, but not persistent. Updates to in
> memory accounting are propagated from the transaction commit path."
> 
> ... but NBD, and feel free to reword, drop and/or correct any of that
> text.

It's there because bch2_accounting_mem_read() takes a bpos when it
should be a disk_accounting_key. I'll fix that if I can...

> > + *    Cheap to read, but non persistent.
> > + *
> > + * To do a disk accounting update:
> > + * - initialize a disk_accounting_key, to specify which counter is being update
> > + * - initialize counter deltas, as an array of 1-3 s64s
> > + * - call bch2_disk_accounting_mod()
> > + *
> > + * This queues up the accounting update to be done at transaction commit time.
> > + * Underneath, it's a normal btree write buffer update.
> > + *
> > + * The transaction commit path is responsible for propagating updates to the in
> > + * memory counters, with bch2_accounting_mem_mod().
> > + *
> > + * The commit path also assigns every disk accounting update a unique version
> > + * number, based on the journal sequence number and offset within that journal
> > + * buffer; this is used by journal replay to determine which updates have been
> > + * done.
> > + *
> > + * The transaction commit path also ensures that replicas entry accounting
> > + * updates are properly marked in the superblock (so that we know whether we can
> > + * mount without data being unavailable); it will update the superblock if
> > + * bch2_accounting_mem_mod() tells it to.
> 
> I'm not really sure what this last paragraph is telling me, but granted
> I've not got that far into the code yet either.

yeah that's for a whole different subsystem that happens to be slaved to
the accounting - replicas.c, which also used to help out quite a bit
with the accounting but now it's pretty much just for managing the
superblock replicas section.

The superblock replicas section is just a list of entries, where each
entry is a list of devices - "there is replicated data present on this
set of devices". We also have full counters of how much data is present
replicated across each set of devices, so the superblock section is just
a truncated version of the accounting - "data exists on these devices",
instead of saying how much.

