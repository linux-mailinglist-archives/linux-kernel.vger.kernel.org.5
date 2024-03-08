Return-Path: <linux-kernel+bounces-96464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFEE875C86
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5066C1F220A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACF829408;
	Fri,  8 Mar 2024 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooeSrgrV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBE02134A;
	Fri,  8 Mar 2024 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709866211; cv=none; b=KGGYYSsMDWMFpdw1tTI8zeHRMexRo6DDYCyI/huqdEGdUyXn6CI7mwfv/IdnExbHrkUMWke/5Zwqdj/yl7/+4NrVGfOfp8iut73hzGv3GokhJoUj10+JIc00IiIRI1F/FBKPXRgN9hcJeCV2ypFdDUmPc8BvFktvG1lFTABiG4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709866211; c=relaxed/simple;
	bh=I65PvNJjsDcvq3jMVV1tURZjjjH3z7jth6uGys/HBls=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Do6WXB5eSQn+Yy7ZF0uZoJ2MDXa9Gg0x1V1aiq/gpDqUAapooF6mxUOtCCjh/i59jq8i/quliNVgLbsaCEVrxY0hNe7vdvDGajDPUmPfR9njnwWewQ+0JUjfBQItabBih5GWpkP+KFeoRCdLcQWwNxwvMx3EKA7rOg3AZ3NuOuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooeSrgrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392B1C433F1;
	Fri,  8 Mar 2024 02:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709866211;
	bh=I65PvNJjsDcvq3jMVV1tURZjjjH3z7jth6uGys/HBls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ooeSrgrVi0adCBRlrblBc6pTuHNdpOvKbuf8+E502rLyg3GIx0Y8EdsZ6jttlDZ0s
	 ZK5RP4bYk4I2bUB+sscgoXxCH8PhAij1mCeLLxBp1dVHQ0R7hOKxi1kbaCLR+ZmsZy
	 ORLZoaY7KIn3JDd4Sbbp+q7vaPu0WusfOsXiDw1XZ7pjMLO3gS53xgPdSrLejkpXdx
	 z9A1E5ey163XDmpODtmUkCWlh86A9srj0mY1ml6fTveFMMo64DvFmYm9hly3jfgzsM
	 nFSa7SfW+Al5n4y1SScFYY3JDjVmSR1bIZKwZApgDI28D0R36FcfYZcA3dBwIeFXVR
	 jdgjI1slY7/sg==
Date: Fri, 8 Mar 2024 11:50:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Calvin Owens <jcalvinowens@gmail.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Mike
 Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Naveen N Rao
 <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, David S Miller <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/4] Make bpf_jit and kprobes work with
 CONFIG_MODULES=n
Message-Id: <20240308115004.22fe5bb7ecea4080aa2ef383@kernel.org>
In-Reply-To: <CAPhsuW4UA9uCRK7EVCJGUvmroQhZZZiVdXotri4oO7+WRQr3sg@mail.gmail.com>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
	<ZejhcP_r5QJZcS6j@bombadil.infradead.org>
	<Zej66vQInnDYgpNy@gmail.com>
	<CAPhsuW4UA9uCRK7EVCJGUvmroQhZZZiVdXotri4oO7+WRQr3sg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 6 Mar 2024 17:58:14 -0800
Song Liu <song@kernel.org> wrote:

> Hi Calvin,
> 
> It is great to hear from you! :)
> 
> On Wed, Mar 6, 2024 at 3:23 PM Calvin Owens <jcalvinowens@gmail.com> wrote:
> >
> > On Wednesday 03/06 at 13:34 -0800, Luis Chamberlain wrote:
> > > On Wed, Mar 06, 2024 at 12:05:07PM -0800, Calvin Owens wrote:
> > > > Hello all,
> > > >
> > > > This patchset makes it possible to use bpftrace with kprobes on kernels
> > > > built without loadable module support.
> > >
> > > This is a step in the right direction for another reason: clearly the
> > > module_alloc() is not about modules, and we have special reasons for it
> > > now beyond modules. The effort to share a generalize a huge page for
> > > these things is also another reason for some of this but that is more
> > > long term.
> > >
> > > I'm all for minor changes here so to avoid regressions but it seems a
> > > rename is in order -- if we're going to all this might as well do it
> > > now. And for that I'd just like to ask you paint the bikeshed with
> > > Song Liu as he's been the one slowly making way to help us get there
> > > with the "module: replace module_layout with module_memory",
> > > and Mike Rapoport as he's had some follow up attempts [0]. As I see it,
> > > the EXECMEM stuff would be what we use instead then. Mike kept the
> > > module_alloc() and the execmem was just a wrapper but your move of the
> > > arch stuff makes sense as well and I think would complement his series
> > > nicely.
> >
> > I apologize for missing that. I think these are the four most recent
> > versions of the different series referenced from that LWN link:
> >
> >   a) https://lore.kernel.org/all/20230918072955.2507221-1-rppt@kernel.org/
> >   b) https://lore.kernel.org/all/20230526051529.3387103-1-song@kernel.org/
> >   c) https://lore.kernel.org/all/20221107223921.3451913-1-song@kernel.org/
> >   d) https://lore.kernel.org/all/20201120202426.18009-1-rick.p.edgecombe@intel.com/
> >
> > Song and Mike, please correct me if I'm wrong, but I think what I've
> > done here (see [1], sorry for not adding you initially) is compatible
> > with everything both of you have recently proposed above. How do you
> > feel about this as a first step?
> 
> I agree that the work here is compatible with other efforts. I have no
> objection to making this the first step.
> 
> >
> > For naming, execmem_alloc() seems reasonable to me? I have no strong
> > feelings at all, I'll just use that going forward unless somebody else
> > expresses an opinion.
> 
> I am not good at naming things. No objection from me to "execmem_alloc".

Hm, it sounds good to me too. I think we should add a patch which just
rename the module_alloc/module_memfree with execmem_alloc/free first.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

