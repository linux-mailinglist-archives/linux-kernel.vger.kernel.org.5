Return-Path: <linux-kernel+bounces-96461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3876B875C79
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95A1284573
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07432C1AE;
	Fri,  8 Mar 2024 02:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeXDmiTN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0693F2C19A;
	Fri,  8 Mar 2024 02:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709865986; cv=none; b=UND+VVqdM39ysxc1uiUEvNPgeMqQRoWoYB5Bw9TTsdMzc0LqLrQTBYWfhyaf+LnVBBMbaqo4RP8AaTu5g99KYUyu4UgTOCGd927BD63gMonVHu4VDbhKDdepX6m7kT5h7Zk6MaIxzFdU/TgyuncYD9VQf/jigqjZs2MsEbfDsvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709865986; c=relaxed/simple;
	bh=ZyIIwHk/Fa+Tvq3dKeZlWILjZhBQ1SZqnN4D3Bpq/fw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p49RL9SyHIYMS5kdsoF6sWPasjbyC0kjGGC5tW5lpkN8WVWr7CaeRN8KgzOjf3cABAEPCRrwA2yceYpJ60+nYVtpG7v/Y/PnxLT4nBf31n1HrpudCv8JDyOXwgFX1GYlIgZ8FBDyuZBo9HvwSie/CxKha4fOwAXc/KlmJVkyTr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeXDmiTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34175C433C7;
	Fri,  8 Mar 2024 02:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709865985;
	bh=ZyIIwHk/Fa+Tvq3dKeZlWILjZhBQ1SZqnN4D3Bpq/fw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eeXDmiTNQZGyDVnVh7ckDGGNz5WWaXWqzOFAdlo+B+3ADK7i7Y1dt2qe1Cu4KH/zb
	 9OGO40QjRBwnzlqxcM/ntQ2dFEf1p9J08tz3ZEQu8fZ/qQxgwkag7MtZJcb2RUTvX+
	 cwCrjF7XTMk/8YEW5o2xb4usLrKmiR6GZBrIuJFszLyj4K9qvwSY2BUizW92gKKFlQ
	 ZvAU0QdAdA9mrKxtY91ganK2r22bj1Bbprw1cIburPeVbYAU7p4SG/53zOIpTqS2af
	 uwy3EgD+24dAQHCml/zt1UHLElXSQkXzzVgxQpwUCSYhzwuZiYXgQCfbNETt5BbprW
	 QfxEtY6wQepSg==
Date: Fri, 8 Mar 2024 11:46:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Calvin Owens <jcalvinowens@gmail.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexei
 Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Naveen N Rao
 <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, David S Miller <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 3/4] kprobes: Allow kprobes with CONFIG_MODULES=n
Message-Id: <20240308114618.3e44c760a1f5b503e26d2979@kernel.org>
In-Reply-To: <ZelrH2hiUmaomDv2@kernel.org>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
	<2af01251ca21d79fa29092505d192f1f1b746cff.1709676663.git.jcalvinowens@gmail.com>
	<ZelrH2hiUmaomDv2@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Mar 2024 09:22:07 +0200
Mike Rapoport <rppt@kernel.org> wrote:

> On Wed, Mar 06, 2024 at 12:05:10PM -0800, Calvin Owens wrote:
> > If something like this is merged down the road, it can go in at leisure
> > once the module_alloc change is in: it's a one-way dependency.
> > 
> > Signed-off-by: Calvin Owens <jcalvinowens@gmail.com>
> > ---
> >  arch/Kconfig                |  2 +-
> >  kernel/kprobes.c            | 22 ++++++++++++++++++++++
> >  kernel/trace/trace_kprobe.c | 11 +++++++++++
> >  3 files changed, 34 insertions(+), 1 deletion(-)
> 
> When I did this in my last execmem posting, I think I've got slightly less
> ugly ifdery, you may want to take a look at that:
> 
> https://lore.kernel.org/all/20230918072955.2507221-13-rppt@kernel.org

Good catch, and sorry I missed that series last year.
But it seems your patch seems less ugly.

Calvin, can you follow his patch?

Thank you,

>  
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index cfc24ced16dd..e60ce984d095 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -52,8 +52,8 @@ config GENERIC_ENTRY
> >  
> >  config KPROBES
> >  	bool "Kprobes"
> > -	depends on MODULES
> >  	depends on HAVE_KPROBES
> > +	select MODULE_ALLOC
> >  	select KALLSYMS
> >  	select TASKS_RCU if PREEMPTION
> >  	help
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 9d9095e81792..194270e17d57 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1556,8 +1556,12 @@ static bool is_cfi_preamble_symbol(unsigned long addr)
> >  		str_has_prefix("__pfx_", symbuf);
> >  }
> >  
> > +#if IS_ENABLED(CONFIG_MODULES)
> >  static int check_kprobe_address_safe(struct kprobe *p,
> >  				     struct module **probed_mod)
> > +#else
> > +static int check_kprobe_address_safe(struct kprobe *p)
> > +#endif
> >  {
> >  	int ret;
> >  
> > @@ -1580,6 +1584,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
> >  		goto out;
> >  	}
> >  
> > +#if IS_ENABLED(CONFIG_MODULES)
> 
> Plain #ifdef will do here and below. IS_ENABLED is for usage withing the
> code, like
> 
> 	if (IS_ENABLED(CONFIG_MODULES))
> 		;
> 
> >  	/* Check if 'p' is probing a module. */
> >  	*probed_mod = __module_text_address((unsigned long) p->addr);
> >  	if (*probed_mod) {
> 
> -- 
> Sincerely yours,
> Mike.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

