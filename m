Return-Path: <linux-kernel+bounces-119297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A01488C6C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B431C60339
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E8E13C831;
	Tue, 26 Mar 2024 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM51zYNl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9786E757FD;
	Tue, 26 Mar 2024 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466650; cv=none; b=jqwWqlabetayMt6p3r3JKJIkIaLTg6Y/grJCE6vVzyWhI/9UfMytw420b+H9pN+/f6wBlkVaUDtGgLaTwyKGYvtMRP4aNfV4nK+71Wrc2JsKPoDa94vpaCTewhYEi23FAr5s8I5YuRYJ3Ym99lFTBnRyMp3wneBuomHFavv+sIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466650; c=relaxed/simple;
	bh=ujR0rPXLZBsE/QY8uXI1pDCWebcjJRNm9iHPbJUo0Ss=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rEgZXA734K8l8IhsRNEZCG5ZCqXddexOEw8vGFjmZmvevHCGnGcRH0d8O+EubYWx5H2s54+ioOMvCwKu5+9veh4hYNLORrorxJzFuIVUv4zZh2V6QdiBWKueNWh0AOOs7f2ZyrFru3t92ZFjBKxnEdJeV5nGqd9QNzur+0J7W9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM51zYNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F539C433C7;
	Tue, 26 Mar 2024 15:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711466649;
	bh=ujR0rPXLZBsE/QY8uXI1pDCWebcjJRNm9iHPbJUo0Ss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZM51zYNl1VjBdBbarCQPT4o8P7JTUjymm1ldrFKsskdIQUDl75XGY0h3MFLabpNf2
	 9zL2Bu9qLsM8u54povk/MhiUucL53tjN5IS7Fq82hnjo7gJxZHI8EDJleWKsf60eNn
	 qGlxpvC1VxhVsR2dgvcNLy1NNI77sjwxejRMFx2J6Y0g39I+Ng9ZkV0j38Zq3cEmlr
	 RfN9BDIAOTeD7Yy3Jxn4aVxkCw8WdesRqiLw9nsypvJLPkVzgEggqnlwGugr8n3ZWV
	 XUxSbVBtahoDBvjZASK0h5m/5ZIwZHI6FHIPEFqFXvbgRLpJGDi2JrmX80Dtl6rZr+
	 7/0qXV7dIPJaA==
Date: Wed, 27 Mar 2024 00:24:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-riscv@lists.infradead.org,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-kernel@vger.kernel.org, "Naveen N . Rao"
 <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 linux-trace-kernel@vger.kernel.org, Calvin Owens <jcalvinowens@gmail.com>
Subject: Re: [PATCH v2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
Message-Id: <20240327002403.62649aee45508b7a16caedba@kernel.org>
In-Reply-To: <ZgLfsvbCZj2S6fRE@FVFF77S0Q05N.cambridge.arm.com>
References: <20240323232908.13261-1-jarkko@kernel.org>
	<20240325115632.04e37297491cadfbbf382767@kernel.org>
	<ZgLfsvbCZj2S6fRE@FVFF77S0Q05N.cambridge.arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 14:46:10 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> Hi Masami,
> 
> On Mon, Mar 25, 2024 at 11:56:32AM +0900, Masami Hiramatsu wrote:
> > Hi Jarkko,
> > 
> > On Sun, 24 Mar 2024 01:29:08 +0200
> > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > 
> > > Tracing with kprobes while running a monolithic kernel is currently
> > > impossible due the kernel module allocator dependency.
> > > 
> > > Address the issue by allowing architectures to implement module_alloc()
> > > and module_memfree() independent of the module subsystem. An arch tree
> > > can signal this by setting HAVE_KPROBES_ALLOC in its Kconfig file.
> > > 
> > > Realize the feature on RISC-V by separating allocator to module_alloc.c
> > > and implementing module_memfree().
> > 
> > Even though, this involves changes in arch-independent part. So it should
> > be solved by generic way. Did you checked Calvin's thread?
> > 
> > https://lore.kernel.org/all/cover.1709676663.git.jcalvinowens@gmail.com/
> > 
> > I think, we'd better to introduce `alloc_execmem()`,
> > CONFIG_HAVE_ALLOC_EXECMEM and CONFIG_ALLOC_EXECMEM at first
> > 
> >   config HAVE_ALLOC_EXECMEM
> > 	bool
> > 
> >   config ALLOC_EXECMEM
> > 	bool "Executable trampline memory allocation"
> > 	depends on MODULES || HAVE_ALLOC_EXECMEM
> > 
> > And define fallback macro to module_alloc() like this.
> > 
> > #ifndef CONFIG_HAVE_ALLOC_EXECMEM
> > #define alloc_execmem(size, gfp)	module_alloc(size)
> > #endif
> 
> Please can we *not* do this? I think this is abstracting at the wrong level (as
> I mentioned on the prior execmem proposals).
> 
> Different exectuable allocations can have different requirements. For example,
> on arm64 modules need to be within 2G of the kernel image, but the kprobes XOL
> areas can be anywhere in the kernel VA space.
> 
> Forcing those behind the same interface makes things *harder* for architectures
> and/or makes the common code more complicated (if that ends up having to track
> all those different requirements). From my PoV it'd be much better to have
> separate kprobes_alloc_*() functions for kprobes which an architecture can then
> choose to implement using a common library if it wants to.
> 
> I took a look at doing that using the core ifdeffery fixups from Jarkko's v6,
> and it looks pretty clean to me (and works in testing on arm64):
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=kprobes/without-modules
> 
> Could we please start with that approach, with kprobe-specific alloc/free code
> provided by the architecture?

OK, as far as I can read the code, this method also works and neat! 
(and minimum intrusion). I actually found that exposing CONFIG_ALLOC_EXECMEM
to user does not help, it should be an internal change. So hiding this change
from user is better choice. Then there is no reason to introduce the new
alloc_execmem, but just expand kprobe_alloc_insn_page() is reasonable.

Mark, can you send this series here, so that others can review/test it?

Thank you!


> 
> Thanks,
> Mark.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

