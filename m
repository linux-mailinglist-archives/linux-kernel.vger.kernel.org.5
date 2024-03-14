Return-Path: <linux-kernel+bounces-103714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCDD87C350
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1F3282E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9016B757E8;
	Thu, 14 Mar 2024 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lHtoAmqU"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7A274E23
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710443157; cv=none; b=ZDz7UqCFjkNwXGjqEcWAFdnVT2wZDMTAVqGLq/M2Epn73jcSQkZzawA5svsNGwXO4ncF/HTMmy2Td11pMFYxRmeZf1SsAi0OQJgpbaN2sn53c++OevSI+U0v9RptEHdXwCdqLV2o6/EXPfiVxGU0XTzxHkMCHkFP89e+ix4e2tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710443157; c=relaxed/simple;
	bh=IT9eLdbpe91FhfBPJR5qulj0qHeEACU6NqDEvgqyDW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZBhYLxYL+U9ZyjYMSBl6CzJI0kbY1cEibjyCAuc8gnh9Pha6fXdwYrv5RrJCYkM+J5QC8Je4ew1uwuvEb1cNOQNXCOSuF7aB2mSB52umWzN9NXLNFUBBO9UB8aoxvpfOxK5sxG370cpav+Pbn7IHAEOi1VSpRUjILbAo/hzOYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lHtoAmqU; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Mar 2024 15:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710443152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=troX3X8HuvTilW6NgLCfSK9nrQd3wvTH0v9DPQHyR8M=;
	b=lHtoAmqUIojCK2jPtn9uqGtrJW+6IvhqHqUKqyQDf7NHJmuqJjy/W+x2a7AAXH+7hkUNzH
	Br5u6MBOqEW3aFoO2R+YLGVNy6A+mUgZ+78EHK5t21DNKyfXdAXuYn02RoQqPJi6KcAeeJ
	jn15DnwPDOe9CHsRu4tkcVsZdEBBQdg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org, 
	bp@alien8.de, brauner@kernel.org, bristot@redhat.com, bsegall@google.com, 
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
Message-ID: <fp6tyl6laseytepxpyidvwjo4dl357dtqegzumrc5ao6srm6we@afcl57kvjieb>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com>
 <CA+CK2bC+bgOfohCEEW7nwAdakVmzg=RhUjjw=+Rw3wFALnOq-Q@mail.gmail.com>
 <f949f712-eacf-49a0-91ea-8062e2d1f5e0@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f949f712-eacf-49a0-91ea-8062e2d1f5e0@zytor.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 12, 2024 at 02:36:27PM -0700, H. Peter Anvin wrote:
> On 3/12/24 12:45, Pasha Tatashin wrote:
> > > 
> > > Ok, first of all, talking about "kernel memory" here is misleading.
> > 
> > Hi Peter,
> > 
> > I re-read my cover letter, and I do not see where "kernel memory" is
> > mentioned. We are talking about kernel stacks overhead that is
> > proportional to the user workload, as every active thread has an
> > associated kernel stack. The idea is to save memory by not
> > pre-allocating all pages of kernel-stacks, but instead use it as a
> > safeguard when a stack actually becomes deep. Come-up with a solution
> > that can handle rare deeper stacks only when needed. This could be
> > done through faulting on the supported hardware (as proposed in this
> > series), or via pre-map on every schedule event, and checking the
> > access when thread goes off cpu (as proposed by Andy Lutomirski to
> > avoid double faults on x86) .
> > 
> > In other words, this feature is only about one very specific type of
> > kernel memory that is not even directly mapped (the feature required
> > vmapped stacks).
> > 
> > > Unless your threads are spending nearly all their time sleeping, the
> > > threads will occupy stack and TLS memory in user space as well.
> > 
> > Can you please elaborate, what data is contained in the kernel stack
> > when thread is in user space? My series requires thread_info not to be
> > in the stack by depending on THREAD_INFO_IN_TASK.
> > 
> 
> My point is that what matters is total memory use, not just memory used in
> the kernel. Amdahl's law.

If userspace is running a few processes with many threads and the
userspace stacks are small, kernel stacks could end up dominating.

I'd like to see some numbers though.

