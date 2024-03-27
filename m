Return-Path: <linux-kernel+bounces-121985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B30D88F044
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849BEB262C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F234B153507;
	Wed, 27 Mar 2024 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnhVmZ9d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6F41514F2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571883; cv=none; b=IC91dC11H7tg1lXviUxY74Egk7kP4r/LtrDKoNHJMP+LmaugLcm6wlCrX233yWR6Uu1VXcrzsZNLUKoKyZqXIDnOgulkXTqGnyABDcs0atdoRvAKc1m7OlTGYtzHYvKiJbSweIYGITFGkS0/o0YMAvFeCLecCf+8vWrHZ5KbaTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571883; c=relaxed/simple;
	bh=+q1X6OO5OjLhXHnuIwVLwdI8semz6sAtm2DvDrQfzL0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=OGVvKcT/Fa6LoY9geXnAKS014waJVXutLK862oAzpeWCyJVsIn0vf/KjpXGL7WyFX8uhXvSV1iCohk8w4Z/Z/g/X1JJd2cFswdU+M6D9dXvmNwKNCDQ1kYmJBPwQMMg8MMxjrg4so6gB0oD+aZvleAgFln6ceESi1ijLbsEDSD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OnhVmZ9d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711571880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qoPQD+VTVHHhRyd75iNpboVK+lvHVLazCUjHaMH4s4=;
	b=OnhVmZ9dFDBmRY+/OpAeMEHQFmgMjPnRthAZxdLK/7RdWw2xbC8dA4OWJwgUizywLnYPfa
	DkgfS/LwcyurqRqtTAAstnjmwwL6hbniGS30MSaKj/qLNESwm7+a/sllGBltoQGKsi9wOU
	VVwcziBaj+2gnu2wrMyBnxJu46wr+f8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-9x-QYYaoNBy5Yt-5m2eKqg-1; Wed, 27 Mar 2024 16:37:55 -0400
X-MC-Unique: 9x-QYYaoNBy5Yt-5m2eKqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DAB0101A552;
	Wed, 27 Mar 2024 20:37:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9A6CBC53360;
	Wed, 27 Mar 2024 20:37:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZgRpPd1Ado-0_iYx@casper.infradead.org>
References: <ZgRpPd1Ado-0_iYx@casper.infradead.org> <2318298.1711551844@warthog.procyon.org.uk> <2506007.1711562145@warthog.procyon.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Christoph Hellwig <hch@lst.de>,
    Andrew Morton <akpm@linux-foundation.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
    linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] mm, netfs: Provide a means of invalidation without using launder_folio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2541307.1711571866.1@warthog.procyon.org.uk>
Date: Wed, 27 Mar 2024 20:37:46 +0000
Message-ID: <2541308.1711571866@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Matthew Wilcox <willy@infradead.org> wrote:

> > +	/* Prevent new folios from being added to the inode. */
> > +	filemap_invalidate_lock(mapping);
> 
> I'm kind of surprised that the callers wouldn't want to hold that lock
> over a call to this function.  I guess you're working on the callers,
> so you'd know better than I would, but I would have used lockdep to
> assert that invalidate_lock was held.

I'm not sure.  None of the places that look like they'd be calling this
currently take that lock (though possibly they should).

Also, should I provide it with explicit range, I wonder?

> > +	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
> > +		unmap_mapping_pages(mapping, 0, ULONG_MAX, false);
> 
> Is this optimisation worth it?

Perhaps not.

David


