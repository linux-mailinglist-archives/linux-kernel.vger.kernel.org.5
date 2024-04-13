Return-Path: <linux-kernel+bounces-143916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EA48A3F83
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 00:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC44B1C20DD8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 22:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73D343AB9;
	Sat, 13 Apr 2024 22:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xq2NZvHi"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE231DFF4
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713048757; cv=none; b=pCSTpW4eVLrt0X0COfq35SqTu4GvWiNj0gG+I9OFsMyCuG73B9WTpec6uxRk/CqZKFRtDxw2xbedyl9fXf7VCTSkerUrulhQ1T9vmDm1I0vyIsHnClxBmQme2spq49qZKpQ4kXZMleyBPaUXg2egHGnTlqg+2UfQbIg/IdoOC1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713048757; c=relaxed/simple;
	bh=p4WHYuDdZkUXSCcnAPSW9ZbfL3B4IrFnKvFtJtQajVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksYNBXLGm1ED4x9NDzzp8kTM/dx0ORxFCWhzRhYljGAX5SFSpl7gAbkq2Afh/Naxyp93IFJCzQv63iXEU/dxWf0/441Y0vl/usmDKiLzZo+pNsxwlfLQnAVnQJKLemCveI1uJvb/KZham+9tJhob3GKTYpHS39pZ2fsuz5/wBmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xq2NZvHi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3rndp98eVT8xk43ZfC1mcEoaahpfqsSRQRLuTarqD34=; b=Xq2NZvHiWK9tjBYRQAZJxyRRi+
	XyySPdv6NufSpFK+nOdWpEYlL41F6j07+Gf560tiAAVzD7RS/lbDwutTumugALM9c9iN0HI5OHydC
	NiGme//C0/s97Ad6sKUHV1aqkSO44dAhkfcnaPO/tkEJWhWa2CKrnK8XBtXXU2aw9r/c4JQy17qKu
	u3692y4qAmPM6eKloyeGUBU43zpj/wN/x5woWyWlcGQ4Zj8oTmzTXW2efCeSFGlWJYlHkELVqa/JO
	ARqkSm0zW07fBxFnvXBe3aliqA8JQTpGdSQ/4sOgjpML8hJvByNqfYGtWnCDByFNgQX21hOpsHQpj
	GlUVt7ew==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvmEZ-0000000CHv1-0H9R;
	Sat, 13 Apr 2024 22:52:31 +0000
Date: Sat, 13 Apr 2024 23:52:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Xu <peterx@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZhsMru7gcqR6gL9q@casper.infradead.org>
References: <ZhhaRXHKk7w_hKgi@x1n>
 <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org>
 <ZhkrY5tkxgAsL1GF@x1n>
 <CAJuCfpG7YkQ2giKiv07TetTn=QHK9x723vnLaTjDCaQjUvAavw@mail.gmail.com>
 <ZhlCVOz7qaDtldfL@casper.infradead.org>
 <CAJuCfpGGUD6ev-KFhON2D2RqQRZSgjxFXvkNqeux-LrJw4L+iw@mail.gmail.com>
 <ZhlQ_4Ve0vYNbWbl@casper.infradead.org>
 <ZhlT4eG05mUcOQQJ@casper.infradead.org>
 <CAJuCfpENhnjnrDPfJPyYaNNLT9VT414VbT45WBoN-EkqTjGMtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpENhnjnrDPfJPyYaNNLT9VT414VbT45WBoN-EkqTjGMtA@mail.gmail.com>

On Sat, Apr 13, 2024 at 02:46:56PM -0700, Suren Baghdasaryan wrote:
> On Fri, Apr 12, 2024 at 8:31 AM Matthew Wilcox <willy@infradead.org> wrote:
> >  - Rename lock_vma() to uffd_lock_vma() because it really is uffd
> >    specific.
> 
> I'm planning to expand the scope of lock_vma() and reuse it for
> /proc/pid/maps reading under per-VMA locks. No objection to renaming
> it for now but I'll likely rename it back later once it's used in more
> places.

That would seem like a mistake.  The uffd lock_vma() will create an
anon_vma for VMAs that don't have one, and you wouldn't want that.
It seems to me that lock_vma_under_rcu() does everything you want except
the fallback to mmap_read_lock().  And I'm not sure there's a good way
to package that up ... indeed, I don't see why you'd want the "take
the mmap_lock, look up the VMA, drop the mmap read lock" part at all --
once you've got the mmap_lock, just hold it until you're done.


