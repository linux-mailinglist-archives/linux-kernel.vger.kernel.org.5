Return-Path: <linux-kernel+bounces-119259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D50A88C641
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D8F1C63349
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D7D13C69A;
	Tue, 26 Mar 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9yMVpI+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4871E12D76F;
	Tue, 26 Mar 2024 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465526; cv=none; b=OTqYbL11O7KZqkIb6BT3EM5zvqN4L4Co6PSuClIgxljQQwFOn4PUs4G5Z8imNE+dFi93Rgh9xnaxOH82aUQ2gogiejGAzopYRXmHQH1XNoPDrLY275Gi5LbRuD+uhvirFmMHg8+SyVnCzhBhDBc6JM2HNX6xd/igWd/WEx+6DJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465526; c=relaxed/simple;
	bh=/qmndJDlWupnnpJi65R442kaOqvhHDX628LndcyMGs8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SjOYj3ENWOo/WBb3Q+bMl41WOTGPB7AToKfhrJEVSrbzZNnRCJghrsTIC4outKzP6be03WRFZP8QanVAOr0IZkiWUa7huzzTkOYNFwc2pS+9zdro6t2ywvjLZCHj491n1MtfoJyMCmW+itDtEwzoj8cgVNELjQYGh3DvvNeUQi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9yMVpI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E1CC433F1;
	Tue, 26 Mar 2024 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711465525;
	bh=/qmndJDlWupnnpJi65R442kaOqvhHDX628LndcyMGs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c9yMVpI+L1invWuAwwgd4+iMcVeBkKccwiZLj5q45v6lHB4Yo+LFvKNJfp6wGJqGS
	 T5NU0KIKcXNJTidqaVE1V4KsGz+s8Vk9t4M5UPrDzgFqe2DHM1I2MyiTV4ZTcV4jQ1
	 qwh8O/bchWcGVDQgex+cdEi25PRJ9YqfgTNoA1EXYqVcilAUKBYxsEmpO2qll0uLhs
	 au9zOblYVYw0CZAPdfj7/5hR6WyRKTdvUYZgsTWgCQRDTzNt9BeNb6W3tRbiJ8G17M
	 MaEfUW86u/t1oTYAva+0z3ktZeVheXh5CO68B+Z5/KHwFyH9L1YSB8mrhLMNaE7zl2
	 UPm9/VvaazOtA==
Date: Wed, 27 Mar 2024 00:05:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: <linux-riscv@lists.infradead.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>,
 "Luis Chamberlain" <mcgrof@kernel.org>, <linux-modules@vger.kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 1/2] kprobes: textmem API
Message-Id: <20240327000520.ec13b2646ed1cd621e5b1d9d@kernel.org>
In-Reply-To: <D03PM9A6IS79.3D6BW7KBLH9C3@kernel.org>
References: <20240325215502.660-1-jarkko@kernel.org>
	<20240326095836.f43d259b7747269a7c0b9d23@kernel.org>
	<D03AL7A5G3M2.3UK4ASWILGBJS@kernel.org>
	<D03B7XJYRFC1.2L3I2TO5HNQD3@kernel.org>
	<D03PM9A6IS79.3D6BW7KBLH9C3@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 15:18:21 +0200
"Jarkko Sakkinen" <jarkko@kernel.org> wrote:

> On Tue Mar 26, 2024 at 4:01 AM EET, Jarkko Sakkinen wrote:
> > On Tue Mar 26, 2024 at 3:31 AM EET, Jarkko Sakkinen wrote:
> > > > > +#endif /* _LINUX_EXECMEM_H */
> > > > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > > > index 9d9095e81792..87fd8c14a938 100644
> > > > > --- a/kernel/kprobes.c
> > > > > +++ b/kernel/kprobes.c
> > > > > @@ -44,6 +44,7 @@
> > > > >  #include <asm/cacheflush.h>
> > > > >  #include <asm/errno.h>
> > > > >  #include <linux/uaccess.h>
> > > > > +#include <linux/execmem.h>
> > > > >  
> > > > >  #define KPROBE_HASH_BITS 6
> > > > >  #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
> > > > > @@ -113,17 +114,17 @@ enum kprobe_slot_state {
> > > > >  void __weak *alloc_insn_page(void)
> > > > >  {
> > > > >  	/*
> > > > > -	 * Use module_alloc() so this page is within +/- 2GB of where the
> > > > > +	 * Use alloc_execmem() so this page is within +/- 2GB of where the
> > > > >  	 * kernel image and loaded module images reside. This is required
> > > > >  	 * for most of the architectures.
> > > > >  	 * (e.g. x86-64 needs this to handle the %rip-relative fixups.)
> > > > >  	 */
> > > > > -	return module_alloc(PAGE_SIZE);
> > > > > +	return alloc_execmem(PAGE_SIZE, GFP_KERNEL);
> > > > >  }
> > > > >  
> > > > >  static void free_insn_page(void *page)
> > > > >  {
> > > > > -	module_memfree(page);
> > > > > +	free_execmem(page);
> > > > >  }
> > > > >  
> > > > >  struct kprobe_insn_cache kprobe_insn_slots = {
> > > > > @@ -1580,6 +1581,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
> > > > >  		goto out;
> > > > >  	}
> > > > >  
> > > > > +#ifdef CONFIG_MODULES
> > > >
> > > > You don't need this block, because these APIs have dummy functions.
> > >
> > > Hmm... I'll verify this tomorrow.
> >
> > It depends on having struct module available given "(*probed_mod)->state".

Ah, indeed. We need module_state() function to avoid it.

> >
> > It is non-existent unless CONFIG_MODULES is set given how things are
> > flagged in include/linux/module.h.
> 
> Hey, noticed kconfig issue.
> 
> According to kconfig-language.txt:
> 
> "select should be used with care. select will force a symbol to a value
> without visiting the dependencies."
> 
> So the problem here lies in KPROBES config entry using select statement
> to pick ALLOC_EXECMEM. It will not take the depends on statement into
> account and thus will allow to select kprobes without any allocator in
> place.

OK, in that case "depend on" is good.

> 
> So to address this I'd suggest to use depends on statement also for
> describing relation between KPROBES and ALLOC_EXECMEM. It does not make
> life worse than before for anyone because even with the current kernel
> you have to select MODULES before you can move forward with kprobes.

Yeah, since ALLOC_EXECMEM is enabled by default.

Thank you!

> 
> BR, Jarkko


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

