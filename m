Return-Path: <linux-kernel+bounces-105316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 828C987DC2C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 02:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A8E1F219C9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 01:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ADE7F6;
	Sun, 17 Mar 2024 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fTnOSCXa"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521791852
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 01:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710639182; cv=none; b=Tnt2krFuVkMbHzu4mkQ1vPF53d7S/DiyXD57umR1QnQ3uQugsUe5OznbzGDhBd4PIRJyQOLVW/cjpCN4fvWKuSXTROiNdHGiPSzphkMFzhx+rtknUkzE/ZWVn4CJ90oZg60LCb87DAGLgPZgcNWuxafG1D9eue9AepYpCpaPv8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710639182; c=relaxed/simple;
	bh=ztvZQB2SUsNN94SIigkB3GyLNdK/4B2aC2dVRh4M3F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5vnEsa7PSy+WITPPPSPBHT/IZdJyMogtYoaWEIcl4zjjI30X+iyk0eMPG0W8/u61gIy/kRAR+IVmuUMjgEzK+Qk7oiSkR//sP9s4f/sUQ9xneYoWGQ53ATCw+k8Mefkoy1vlbqC+Rg4vf644NcSouMcm1YDGChi5ICl/ZluHz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fTnOSCXa; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 16 Mar 2024 21:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710639176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9RlAJsRV/7U7lgZ5geJYDyxKFcsxulrG2wQ1uwCXd3A=;
	b=fTnOSCXa0vNTItXRaHzGWsogIux8/TRMBoUZeZ77MCC5BxT+nJLCCwj+Kkzle0qZXb1TGN
	vUEd2QnaqB49FXQSikVQAibEBp6/pRjivXEs2ocIX8gXUM92lY0ncF0270mJ+Dq+vCZYn0
	A1lRaThqY9ve3acajFkNUVC/hDbv0es=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com, 
	hca@linux.ibm.com, hch@infradead.org, jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, 
	jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com, kinseyho@google.com, 
	kirill.shutemov@linux.intel.com, lstoakes@gmail.com, luto@kernel.org, mgorman@suse.de, 
	mic@digikod.net, michael.christie@oracle.com, mingo@redhat.com, mjguzik@gmail.com, 
	mst@redhat.com, npiggin@gmail.com, peterz@infradead.org, pmladek@suse.com, 
	rick.p.edgecombe@intel.com, rostedt@goodmis.org, surenb@google.com, tglx@linutronix.de, 
	urezki@gmail.com, vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
Message-ID: <fsergr6i66i7tagtqj3m7yz4tkjv5z75uslsqpfzmtzdpv3yiv@znauhs7rd4f3>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com>
 <ZfNTSjfE_w50Otnz@casper.infradead.org>
 <2qp4uegb4kqkryihqyo6v3fzoc2nysuhltc535kxnh6ozpo5ni@isilzw7nth42>
 <ZfNWojLB7qjjB0Zw@casper.infradead.org>
 <CA+CK2bAmOj2J10szVijNikexFZ1gmA913vvxnqW4DJKWQikwqQ@mail.gmail.com>
 <39F17EC4-7844-4111-BF7D-FFC97B05D9FA@zytor.com>
 <CA+CK2bDothmwdJ86K1LiKWDKdWdYDjg5WCwdbapL9c3Y_Sf+kg@mail.gmail.com>
 <ZfY8PSnsLtkHBBZF@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfY8PSnsLtkHBBZF@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Sun, Mar 17, 2024 at 12:41:33AM +0000, Matthew Wilcox wrote:
> On Sat, Mar 16, 2024 at 03:17:57PM -0400, Pasha Tatashin wrote:
> > Expanding on Mathew's idea of an interface for dynamic kernel stack
> > sizes, here's what I'm thinking:
> > 
> > - Kernel Threads: Create all kernel threads with a fully populated
> > THREAD_SIZE stack.  (i.e. 16K)
> > - User Threads: Create all user threads with THREAD_SIZE kernel stack
> > but only the top page mapped. (i.e. 4K)
> > - In enter_from_user_mode(): Expand the thread stack to 16K by mapping
> > three additional pages from the per-CPU stack cache. This function is
> > called early in kernel entry points.
> > - exit_to_user_mode(): Unmap the extra three pages and return them to
> > the per-CPU cache. This function is called late in the kernel exit
> > path.
> > 
> > Both of the above hooks are called with IRQ disabled on all kernel
> > entries whether through interrupts and syscalls, and they are called
> > early/late enough that 4K is enough to handle the rest of entry/exit.
> 
> At what point do we replenish the per-CPU stash of pages?  If we're
> 12kB deep in the stack and call mutex_lock(), we can be scheduled out,
> and then the new thread can make a syscall.  Do we just assume that
> get_free_page() can sleep at kernel entry (seems reasonable)?  I don't
> think this is an infeasible problem, I'd just like it to be described.

schedule() or return to userspace, I believe was mentioned

