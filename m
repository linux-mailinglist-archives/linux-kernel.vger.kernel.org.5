Return-Path: <linux-kernel+bounces-88594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B5D86E3DF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1711C21F75
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340D33A8E3;
	Fri,  1 Mar 2024 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYZO2k/3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D420E3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305320; cv=none; b=bJP0q+7FfGw/v2Igx3nuC31WCzZH6PJAgxV/8RNldzgZ0suGn5n7lXxpWsDcmwDD2JTez2k4Rotyp3GeHkXkXJmwCvE1b7jClUbpW+5FZBq22yfD9NM1vjh2tcNdVtwqZ9vf6HW8JC1I9V6OpYmost3vcaXSF2lG+v3gEpwrJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305320; c=relaxed/simple;
	bh=WcFb6UJyrAj6vMVXS9jpaavIcTkGQ6WkUCPf39EjXH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvH7zw2dTTFzzmXm83BqcV086e1mbg28ZS18cZK6qK0hdo2vVb+Lx3WUAHSGO6TMsVzb5qQh5OgUWwKNk7Sh8bR2OXHPvS/O8HrWJL5GNvb8pm4Kt+k9VJaUIdP6jwNKdJEY0J/0nHF4v1Ss8Gp14Wg5xz0VzCFnLETUBcZYgRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYZO2k/3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709305317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LxpqDIonN0/AQ1Q5Zx4aN7Ac1V+lU2NoYWrXBhd0Etg=;
	b=HYZO2k/3AZ8rab5l0RfJcWYyc15vbYzy4r0b6U/ciZV/oYWjoPI1+Ze5nVQ2gJA6qzxMqK
	Gkv8UfzdFU99zS3v78wFnYXtHbUeZ3pfO36cUshMOCSYISAAnCcU0bgLwwmLqpmLeNuotv
	fJxgj7PS6wGAeP3nYvc6d54BQOcFwzI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-gdLcepOFNM2CPVAuVBP41Q-1; Fri,
 01 Mar 2024 10:01:55 -0500
X-MC-Unique: gdLcepOFNM2CPVAuVBP41Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CCE42815E29;
	Fri,  1 Mar 2024 15:01:53 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 25F21111D3E6;
	Fri,  1 Mar 2024 15:01:53 +0000 (UTC)
Date: Fri, 1 Mar 2024 10:03:35 -0500
From: Brian Foster <bfoster@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH 04/21] bcachefs: Disk space accounting rewrite
Message-ID: <ZeHuRyZLlVD5vc7v@bfoster>
References: <20240225023826.2413565-1-kent.overstreet@linux.dev>
 <20240225023826.2413565-5-kent.overstreet@linux.dev>
 <Zd4F1qE1IFCz0/ML@bfoster>
 <3dug3vvjmlkhu42glwhkm5ozgkp4tzqvekxdabbgv4dv4yhxig@r5bw746uaxym>
 <ZeDQi3mRwJc7wqX/@bfoster>
 <nywd7rix6qapogaqg5kxny3k272ptpzi4qv5q2dqts42bqbxrw@te5enoxvdhti>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nywd7rix6qapogaqg5kxny3k272ptpzi4qv5q2dqts42bqbxrw@te5enoxvdhti>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Thu, Feb 29, 2024 at 04:16:00PM -0500, Kent Overstreet wrote:
> On Thu, Feb 29, 2024 at 01:44:27PM -0500, Brian Foster wrote:
> > On Wed, Feb 28, 2024 at 11:10:12PM -0500, Kent Overstreet wrote:
> > > I think it ended up not needing to be moved, and I just forgot to drop
> > > it - originally I disallowed accounting entries that referenced
> > > nonexistent devices, but that wasn't workable so now it's only nonzero
> > > accounting keys that aren't allowed to reference nonexistent devices.
> > > 
> > > I'll see if I can delete it.
> > > 
> > 
> > Do you mean to delete the change that moves the call, or the flush call
> > entirely?
> 
> Delte the change, I think there's further cleanup (& probably bugs to
> fix) possible with that flush call but I'm not going to get into it
> right now.
> 

Ok, just trying to determine whether I need to look back and make sure
this doesn't regress the problem this originally fixed.

> > > +/*
> > > + * Notes on disk accounting:
> > > + *
> > > + * We have two parallel sets of counters to be concerned with, and both must be
> > > + * kept in sync.
> > > + *
> > > + *  - Persistent/on disk accounting, stored in the accounting btree and updated
> > > + *    via btree write buffer updates that treat new accounting keys as deltas to
> > > + *    apply to existing values. But reading from a write buffer btree is
> > > + *    expensive, so we also have
> > > + *
> > 
> > I find the wording a little odd here, and I also think it would be
> > helpful to explain how/from where the deltas originate. For example,
> > something along the lines of:
> > 
> > "Persistent/on disk accounting, stored in the accounting btree and
> > updated via btree write buffer updates. Accounting updates are
> > represented as deltas that originate from <somewhere? trans triggers?>.
> > Accounting keys represent these deltas through commit into the write
> > buffer. The accounting/delta keys in the write buffer are then
> > accumulated into the appropriate accounting btree key at write buffer
> > flush time."
> 
> yeah, that's worth including.
> 
> There's an interesting point that you're touching on; btree write buffer
> are always dependent state changes from some other (non write buffer)
> btree; we never look at a write buffer btree and generate an update
> there - we can't, reading from a write buffer btree doesn't get you
> anything consistent or up to date.
> 
> So in normal operation it really only makes sense to do write buffer
> updates from a transactional trigger - that's the only way to use them
> and have them be consistent with the resst of the filesystem.
> 
> And since triggers work by comparing old and new, they naturally
> generate updates that are deltas.
> 

Hm that is interesting, I hadn't made that connection. Thanks.

Brian

> > > + *  - In memory accounting, where accounting is stored as an array of percpu
> > > + *    counters, indexed by an eytzinger array of disk acounting keys/bpos (which
> > > + *    are the same thing, excepting byte swabbing on big endian).
> > > + *
> > 
> > Not really sure about the keys vs. bpos thing, kind of related to my
> > comments on the earlier patch. It might be more clear to just elide the
> > implementation details here, i.e.:
> > 
> > "In memory accounting, where accounting is stored as an array of percpu
> > counters that are cheap to read, but not persistent. Updates to in
> > memory accounting are propagated from the transaction commit path."
> > 
> > ... but NBD, and feel free to reword, drop and/or correct any of that
> > text.
> 
> It's there because bch2_accounting_mem_read() takes a bpos when it
> should be a disk_accounting_key. I'll fix that if I can...
> 
> > > + *    Cheap to read, but non persistent.
> > > + *
> > > + * To do a disk accounting update:
> > > + * - initialize a disk_accounting_key, to specify which counter is being update
> > > + * - initialize counter deltas, as an array of 1-3 s64s
> > > + * - call bch2_disk_accounting_mod()
> > > + *
> > > + * This queues up the accounting update to be done at transaction commit time.
> > > + * Underneath, it's a normal btree write buffer update.
> > > + *
> > > + * The transaction commit path is responsible for propagating updates to the in
> > > + * memory counters, with bch2_accounting_mem_mod().
> > > + *
> > > + * The commit path also assigns every disk accounting update a unique version
> > > + * number, based on the journal sequence number and offset within that journal
> > > + * buffer; this is used by journal replay to determine which updates have been
> > > + * done.
> > > + *
> > > + * The transaction commit path also ensures that replicas entry accounting
> > > + * updates are properly marked in the superblock (so that we know whether we can
> > > + * mount without data being unavailable); it will update the superblock if
> > > + * bch2_accounting_mem_mod() tells it to.
> > 
> > I'm not really sure what this last paragraph is telling me, but granted
> > I've not got that far into the code yet either.
> 
> yeah that's for a whole different subsystem that happens to be slaved to
> the accounting - replicas.c, which also used to help out quite a bit
> with the accounting but now it's pretty much just for managing the
> superblock replicas section.
> 
> The superblock replicas section is just a list of entries, where each
> entry is a list of devices - "there is replicated data present on this
> set of devices". We also have full counters of how much data is present
> replicated across each set of devices, so the superblock section is just
> a truncated version of the accounting - "data exists on these devices",
> instead of saying how much.
> 


