Return-Path: <linux-kernel+bounces-103729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE52887C3B2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 471EBB214BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737CC75807;
	Thu, 14 Mar 2024 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fbZs474P"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C0971750
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710444549; cv=none; b=l8zF8cdpjoauFvW+imCV60rH1M2vGAhatNmSokB2vb8ignc2RXkE5wRJFZSLm7H7Ia5q+d+sP/EVUuxDIaRScYwWM82JaIWGhCFsFPFunftXbEaIrMSSigzLso6qbJ0ivARO/ZeUTElKwA4Sk/wxAZU3q0mEim4ofW98RwdB5P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710444549; c=relaxed/simple;
	bh=G/i5H2FtY2qCt+ahAUkXmXRmIbnow9JIaG1fuDzJhH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gT5i2LHYEVIq7aOtdsUBhSJh4AC3hUwp0FPah4t+EfANIKnxSL/LgsTFcn1FdrS5E657dRtSiu4H8XiNOVjh2CPsbBCqtdimW+cDVTu+ETbZ4zgVHsTRwn/Nef0kOyqRO9hatIABmvpSRHToSIH84LxTyFDnnfESCqKEdHNxrDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fbZs474P; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Mar 2024 15:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710444545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L5mYCuAgW9WLpcKyE4vY0uyy9Nn7D3uKkSmdVzmlRCI=;
	b=fbZs474PeXyIJsZK5v+BHUEn0x3cCbqr1L1c7WYw9Hu+WKErM/0yY5IIXojQMN2YnQp1Zd
	6H1hkW7SqyHqpXtHe+KmDPq11pUwICXj5kIueCxQFkY/JD5ZYSGZQBxvpGiVhAf9SKK7lk
	hlEXwUWHcyBFdVZOz9JTxpG6u8Btf6w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, 
	brauner@kernel.org, bristot@redhat.com, bsegall@google.com, 
	dave.hansen@linux.intel.com, dianders@chromium.org, dietmar.eggemann@arm.com, 
	eric.devolder@oracle.com, hca@linux.ibm.com, hch@infradead.org, 
	jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, jpoimboe@kernel.org, jroedel@suse.de, 
	juri.lelli@redhat.com, kinseyho@google.com, kirill.shutemov@linux.intel.com, 
	lstoakes@gmail.com, luto@kernel.org, mgorman@suse.de, mic@digikod.net, 
	michael.christie@oracle.com, mingo@redhat.com, mjguzik@gmail.com, mst@redhat.com, 
	npiggin@gmail.com, peterz@infradead.org, pmladek@suse.com, 
	rick.p.edgecombe@intel.com, rostedt@goodmis.org, surenb@google.com, tglx@linutronix.de, 
	urezki@gmail.com, vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
Message-ID: <mo2z7sfzxntlfbbr5yqyjpe5cn2nn6ecxgi3pr5kcfbzq2dnzn@vvtugr3s5hbf>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com>
 <CA+CK2bC+bgOfohCEEW7nwAdakVmzg=RhUjjw=+Rw3wFALnOq-Q@mail.gmail.com>
 <f949f712-eacf-49a0-91ea-8062e2d1f5e0@zytor.com>
 <fp6tyl6laseytepxpyidvwjo4dl357dtqegzumrc5ao6srm6we@afcl57kvjieb>
 <CA+CK2bA+ACXv955KXpP3ZW47n7tiZqzUMz9s09cJMUD7Cz2Log@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bA+ACXv955KXpP3ZW47n7tiZqzUMz9s09cJMUD7Cz2Log@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 14, 2024 at 03:23:08PM -0400, Pasha Tatashin wrote:
> > >
> > > My point is that what matters is total memory use, not just memory used in
> > > the kernel. Amdahl's law.
> >
> > If userspace is running a few processes with many threads and the
> > userspace stacks are small, kernel stacks could end up dominating.
> >
> > I'd like to see some numbers though.
> 
> The unused kernel stack pages occupy petabytes of memory across the fleet [1].

Raw number doesn't mean much here (I know how many machines Google has,
of course it's going to be petabytes ;), percentage of system memory
would be better.

What I'd _really_ like to see is raw output from memory allocation
profiling, so we can see how much memory is going to kernel stacks vs.
other kernel allocations.

Number of kernel threads vs. number of user threads would also be good
to know - I've been seeing ps output lately where we've got a lot more
workqueue workers than we should, perhaps that's something that could be
addressed.

