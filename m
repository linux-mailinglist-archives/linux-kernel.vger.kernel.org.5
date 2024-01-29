Return-Path: <linux-kernel+bounces-42111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D8B83FC6E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4A52831F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF229FC05;
	Mon, 29 Jan 2024 03:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lj3ZlaMS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669FDF9D6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706497252; cv=none; b=CKzluGxWYbQHEo0tFf8z/ei5Kl6k01G8RvcI/l94p2Py14xezJnhQ6t73eV+k837S3eZzOkmPrPb0IjHgQSGf78kje+cQoRCz7aylSEhQrsqQMTwVrHcOmqWvuba7sdzjdpbb36jW7B8WbL6+idueHSQIbjz4jkQ4DI9bjUpc1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706497252; c=relaxed/simple;
	bh=/oGa5ABPhpXed7C0cgst3BJAf0CGV7fQ9TLfp798wPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phwifk99YK560at1ePDQY/z/UHuNWjtb4T9Qdz2bAiDdFszxN3Bg6Xa2s3P811x0QhN1gBtRWUj9dQi0jffuFOIY87k25IPIggtMPf09UTUheE3ZbyJQYbAtImExNROHtIJ23DxHM4QkP5ekMH56V+wdTrLdF+aUYRmeWrF8SBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lj3ZlaMS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706497249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SH5JJA8B2/oLNz4ErgboH6AqTlVlU9RXl7tVsXTShf0=;
	b=Lj3ZlaMSkbSqhI9QPb3uvNYOPrudpdRXFCaqa3swaeO6N+N1qBkS/vNZN0irGVD/hdTi/f
	r9QkDz0M1BWZ43OjuJOXrtC9fb1gM223AXWFtIObkHbzrkcNTw0iz1yEPcB/YessPI1oCB
	oRidc4vIMCGdTtalox92HnSdStJTwDo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-GSvxAW-rMwWbug6hU-02LQ-1; Sun,
 28 Jan 2024 22:00:45 -0500
X-MC-Unique: GSvxAW-rMwWbug6hU-02LQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2077E29AC015;
	Mon, 29 Jan 2024 03:00:45 +0000 (UTC)
Received: from fedora (unknown [10.72.116.135])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C4D5B2026F95;
	Mon, 29 Jan 2024 03:00:40 +0000 (UTC)
Date: Mon, 29 Jan 2024 11:00:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Don Dutile <ddutile@redhat.com>,
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
	ming.lei@redhat.com
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops
 in willneed range
Message-ID: <ZbcU1PXACdxbtjWx@fedora>
References: <20240128142522.1524741-1-ming.lei@redhat.com>
 <ZbbPCQZdazF7s0_b@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbbPCQZdazF7s0_b@casper.infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Sun, Jan 28, 2024 at 10:02:49PM +0000, Matthew Wilcox wrote:
> On Sun, Jan 28, 2024 at 10:25:22PM +0800, Ming Lei wrote:
> > Since commit 6d2be915e589 ("mm/readahead.c: fix readahead failure for
> > memoryless NUMA nodes and limit readahead max_pages"), ADV_WILLNEED
> > only tries to readahead 512 pages, and the remained part in the advised
> > range fallback on normal readahead.
> 
> Does the MAINTAINERS file mean nothing any more?

It is just miss to Cc you, sorry.

> 
> > If bdi->ra_pages is set as small, readahead will perform not efficient
> > enough. Increasing read ahead may not be an option since workload may
> > have mixed random and sequential I/O.
> 
> I thik there needs to be a lot more explanation than this about what's
> going on before we jump to "And therefore this patch is the right
> answer".

Both 6d2be915e589 and the commit log provids background about this
issue, let me explain it more:

1) before commit 6d2be915e589, madvise/fadvise(WILLNEED)/readahead
syscalls try to readahead in the specified range if memory is allowed,
and for each readahead in this range, the ra size is set as max sectors
of the block device, see force_page_cache_ra().

2) since commit 6d2be915e589, only 2MB bytes are load in these syscalls,
and the remained bytes fallback to future normal readahead when reads
from page cache or mmap buffer

3) this patch wires the advise(WILLNEED) range info to normal readahead for
both mmap fault and buffered read code path, so each readhead can use
max sectors of block size for the ra, basically takes the similar
approach before commit 6d2be915e589

> 
> > @@ -972,6 +974,7 @@ struct file_ra_state {
> >  	unsigned int ra_pages;
> >  	unsigned int mmap_miss;
> >  	loff_t prev_pos;
> > +	struct maple_tree *need_mt;
> 
> No.  Embed the struct maple tree.  Don't allocate it.  What made you
> think this was the right approach?

Can you explain why it has to be embedded? core-api/maple_tree.rst
mentioned it is fine to call "mt_init() for dynamically allocated ones".

maple tree provides one easy way to record the advised willneed range,
so readahead code path can apply this info for speedup readahead.


Thanks,
Ming


