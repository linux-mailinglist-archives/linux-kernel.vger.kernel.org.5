Return-Path: <linux-kernel+bounces-103740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F9087C3D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65300B2294A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BCA75817;
	Thu, 14 Mar 2024 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vyVBxkEC"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC162A1C7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710445774; cv=none; b=C5Utkt+yQ/riH/h9T0kjwt0Vps/EJ1brwbdese6BzQtNkVv4J4uzLTu0dZ2NSc5R030x1ZIhTrcboGUKpas+Je+Q4QES9AFUHkFlU9F2y+kNhQbXYEcd0T+ClJuAG/lj71qrnI7bpWYrD7Mb68z/Fu6xwDAsQYLwzChHjVfXiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710445774; c=relaxed/simple;
	bh=ey6aZZyO2yRwiBcrrQcQ9Tn3xCXf1wH5j+sk0+rlaiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyKu0WbWipEtLXvvxwHAIKZhOIasmqwlX9MVngAIP+QC+D6QGwrViBxu9BxoYYOj+RFZtXxKB3S9rtFunuTue1OHmHvrWjhhUIONA28Se824B7crbAMiUKwWptWE7yv8KFBE/hsnoBEO+D2DH11yv7kIwWV7TfuTSopR2aZtxxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vyVBxkEC; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Mar 2024 15:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710445769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQhKBgFBwcHxMMVU5RZZVIyABjVMSjCmIgF/D8RmMd0=;
	b=vyVBxkECVqaeyjcPV4xlon4xwRuqkYRismZotCyCVT8L9bU6/2JAk/tIYs0I0psufu68LS
	juN/mOOUJVXdHan06zn33FPTtVqRAfcOxriZVnKnmyKM/q1RTUi2qyNDsw+OAhAPmYsvp1
	72SJigfNEAjBd0ZzHdWYSxTd7iQcRCs=
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
Message-ID: <mvkjn34r3t3qz5qna72gbzp6ampgshemuvgqucjbxlckimh2fc@jqp63wy3v5ag>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com>
 <CA+CK2bC+bgOfohCEEW7nwAdakVmzg=RhUjjw=+Rw3wFALnOq-Q@mail.gmail.com>
 <f949f712-eacf-49a0-91ea-8062e2d1f5e0@zytor.com>
 <fp6tyl6laseytepxpyidvwjo4dl357dtqegzumrc5ao6srm6we@afcl57kvjieb>
 <CA+CK2bA+ACXv955KXpP3ZW47n7tiZqzUMz9s09cJMUD7Cz2Log@mail.gmail.com>
 <mo2z7sfzxntlfbbr5yqyjpe5cn2nn6ecxgi3pr5kcfbzq2dnzn@vvtugr3s5hbf>
 <CA+CK2bDQu0jh55H=FQtA-5R-5Qy2=nqzcybEuN=RzVR75NBLRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDQu0jh55H=FQtA-5R-5Qy2=nqzcybEuN=RzVR75NBLRA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 14, 2024 at 03:34:03PM -0400, Pasha Tatashin wrote:
> On Thu, Mar 14, 2024 at 3:29 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Thu, Mar 14, 2024 at 03:23:08PM -0400, Pasha Tatashin wrote:
> > > > >
> > > > > My point is that what matters is total memory use, not just memory used in
> > > > > the kernel. Amdahl's law.
> > > >
> > > > If userspace is running a few processes with many threads and the
> > > > userspace stacks are small, kernel stacks could end up dominating.
> > > >
> > > > I'd like to see some numbers though.
> > >
> > > The unused kernel stack pages occupy petabytes of memory across the fleet [1].
> >
> > Raw number doesn't mean much here (I know how many machines Google has,
> > of course it's going to be petabytes ;), percentage of system memory
> > would be better.
> >
> > What I'd _really_ like to see is raw output from memory allocation
> > profiling, so we can see how much memory is going to kernel stacks vs.
> > other kernel allocations.
> 
> I've heard there is memory profiling working that can help with that...

I heard you've tried it out, too :)

> While I do not have the data you are asking for, the other kernel
> allocations might be useful, but this particular project is targeted
> to help with reducing overhead where the memory is not used, or used
> in very extreme rare cases.

Well, do you think you could gather it? We shouldn't be blindly applying
performance optimizations; we need to know where to focus our efforts.

e.g. on my laptop I've currently got 356 processes for < 6M of kernel
stack out of 32G total ram, so clearly this isn't much use to me. If the
ratio is similar on your servers - nah, don't want it. I expect the
ratio is not similar and you are burning proportially more memory on
kernel stacks, but we still need to gather the data and do the math :)

> 
> > Number of kernel threads vs. number of user threads would also be good
> > to know - I've been seeing ps output lately where we've got a lot more
> > workqueue workers than we should, perhaps that's something that could be
> > addressed.
> 
> Yes, doing other optimizations make sense, reducing the total number
> kernel threads if possible might help as well. I will look into this
> as well to see how many user threads vs kernel threads we have.

Great, that will help too.

