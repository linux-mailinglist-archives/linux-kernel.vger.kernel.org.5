Return-Path: <linux-kernel+bounces-103736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 423FE87C3C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E721C22519
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E330F7580F;
	Thu, 14 Mar 2024 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PXKa+GjK"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890EE74E32
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710445398; cv=none; b=S9v6ivjX2W2cN0ijs3+3Juu3yAFuu8o+BDNFDlsRw6hhCwIP1nz2njnjWMv+uJ8fXQ9QXUVrQrfzRiZsAgtLntBx9UsFlXeSbHNZnB90QtPevgmvIu10DWwATTCiYegXJnA8h0Tz+cFf6emxyw+sm/Xg0sgyBBuFDPUQYhm3C5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710445398; c=relaxed/simple;
	bh=HjsXw8Kcu5TN+75YZGPD6eIfeiVwd7TW0FQRBrWPsH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL0rWEiJZpGWEkuw6c1p0maB3kzj9V26NgYtZh/ntFgMw01lpzZBn3V4oUn1jTXYbwM1HYF3BdwxvKEva/UOZmOrQpKLWAKVKbKrCdgQ8iGCcX5IOVv8lMrcrR9fi0zcD3hr7/hVEanMTjhRFRkRV56TyHDIKXr8uWsi/pTw5N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PXKa+GjK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E9BvhamXKJX05OcN9tCjn3On3HSbyhQhWQ81yVSQ8uI=; b=PXKa+GjKY61OcrlhWj3bB/bEYi
	nrUgJYpqUezH4DLxvWLCSas5mJX87L04tmLT268yxqtveuFFlTmcEq39npftna3flVqo+gfoyMfEw
	99fWRpJ36maVj78ZnNRl97NZb6VeF5uv/6cr278h7SvwF31ln23mPU6sk7FmirlftT76Z8ZEL5xQx
	PuLd/9hjj63f1OS+hpM6NgO84aKes86Ke0n2FCFTgrcfyxUBRZ1cvE0JkQg1cgkY/uLz0F9zFXTtK
	boLlHJr9/TQTbezQUamsFmf9gADQJJQVM4qr7mDC1ZH+RFaTdQhDCbkDRtRSx3DkBiE3ViYWDZ22y
	K48DNxHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkqyo-00000008YLq-1JWa;
	Thu, 14 Mar 2024 19:43:06 +0000
Date: Thu, 14 Mar 2024 19:43:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de,
	brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
	dave.hansen@linux.intel.com, dianders@chromium.org,
	dietmar.eggemann@arm.com, eric.devolder@oracle.com,
	hca@linux.ibm.com, hch@infradead.org, jacob.jun.pan@linux.intel.com,
	jgg@ziepe.ca, jpoimboe@kernel.org, jroedel@suse.de,
	juri.lelli@redhat.com, kent.overstreet@linux.dev,
	kinseyho@google.com, kirill.shutemov@linux.intel.com,
	lstoakes@gmail.com, luto@kernel.org, mgorman@suse.de,
	mic@digikod.net, michael.christie@oracle.com, mingo@redhat.com,
	mjguzik@gmail.com, mst@redhat.com, npiggin@gmail.com,
	peterz@infradead.org, pmladek@suse.com, rick.p.edgecombe@intel.com,
	rostedt@goodmis.org, surenb@google.com, tglx@linutronix.de,
	urezki@gmail.com, vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
Message-ID: <ZfNTSjfE_w50Otnz@casper.infradead.org>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com>

On Tue, Mar 12, 2024 at 10:18:10AM -0700, H. Peter Anvin wrote:
> Second, non-dynamic kernel memory is one of the core design decisions in
> Linux from early on. This means there are lot of deeply embedded assumptions
> which would have to be untangled.

I think there are other ways of getting the benefit that Pasha is seeking
without moving to dynamically allocated kernel memory.  One icky thing
that XFS does is punt work over to a kernel thread in order to use more
stack!  That breaks a number of things including lockdep (because the
kernel thread doesn't own the lock, the thread waiting for the kernel
thread owns the lock).

If we had segmented stacks, XFS could say "I need at least 6kB of stack",
and if less than that was available, we could allocate a temporary
stack and switch to it.  I suspect Google would also be able to use this
API for their rare cases when they need more than 8kB of kernel stack.
Who knows, we might all be able to use such a thing.

I'd been thinking about this from the point of view of allocating more
stack elsewhere in kernel space, but combining what Pasha has done here
with this idea might lead to a hybrid approach that works better; allocate
32kB of vmap space per kernel thread, put 12kB of memory at the top of it,
rely on people using this "I need more stack" API correctly, and free the
excess pages on return to userspace.  No complicated "switch stacks" API
needed, just an "ensure we have at least N bytes of stack remaining" API.

