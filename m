Return-Path: <linux-kernel+bounces-95050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3005D87489A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE45282794
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ECA1D558;
	Thu,  7 Mar 2024 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLlingeY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE573D6B;
	Thu,  7 Mar 2024 07:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709796184; cv=none; b=SXHEWzmJC9T5f+uOYTAZfs1fmIk3emuFy2POLb27dFJU+fgM0mCXMLEwg0pSyIHHGKkLafbZ7lKQFtPZd5c2Al79UCGjnV4ju9hnuv3VdeUPYRlHCyiV0EF2qCQXCWuNqE6BeONMCvtVzOdll7M8OPIjsbe1FutTV7WpuHG3jj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709796184; c=relaxed/simple;
	bh=zDK4jwPUVS3K65SBI2uDrKWUgERbKeIXVQOlOCTCKjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taw+RBDkfKV9pmV1qb5L8FVERylU2rLwD2E3H5eR6/1zKwGMll2Reu3Ef5iLZIIR1rg1BTnRXwIAOyUasLIXZkJ0rvOzLus0NL2P+iptuv3ht+nUIldOESeLZrnsSLlcMcG8vYZrfKjjFTXg1XSNfwTjKNRJokrlzGTfVi4HuVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLlingeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43E0C433F1;
	Thu,  7 Mar 2024 07:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709796183;
	bh=zDK4jwPUVS3K65SBI2uDrKWUgERbKeIXVQOlOCTCKjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nLlingeY5dSoTNCuzLFH4Pi+5vHniY8+2eVCyy/3AXVHLinu0QNWXfJS5FNb8vNKn
	 5/P4NtytF4nBIIKX7G3JJHKiZZFzmz+s1J+sYGsXaeJz6c2sxKG+YchPOd3b7/knxs
	 5qZdGm5zOiWC8+UxQ6uAUmBKSGJHivUSylJ/HhVerxvZuQqVqaqTWECsLE7UFaQ4YQ
	 3Bow3DPCmAmGcRiSJP8WY7Y4zGgpqdMXGR/piKgXvLCQNJiaPV1rnnwJf25scWOEIW
	 4tRIjgUAB1zi09L7A/UAwNYxKUoEnHugdhWrxakDk8BUZCo/cuy5MbJxj0cxXK/+U1
	 FCB3QMm0vmmpQ==
Date: Thu, 7 Mar 2024 09:22:07 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Calvin Owens <jcalvinowens@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	David S Miller <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 3/4] kprobes: Allow kprobes with CONFIG_MODULES=n
Message-ID: <ZelrH2hiUmaomDv2@kernel.org>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
 <2af01251ca21d79fa29092505d192f1f1b746cff.1709676663.git.jcalvinowens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2af01251ca21d79fa29092505d192f1f1b746cff.1709676663.git.jcalvinowens@gmail.com>

On Wed, Mar 06, 2024 at 12:05:10PM -0800, Calvin Owens wrote:
> If something like this is merged down the road, it can go in at leisure
> once the module_alloc change is in: it's a one-way dependency.
> 
> Signed-off-by: Calvin Owens <jcalvinowens@gmail.com>
> ---
>  arch/Kconfig                |  2 +-
>  kernel/kprobes.c            | 22 ++++++++++++++++++++++
>  kernel/trace/trace_kprobe.c | 11 +++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)

When I did this in my last execmem posting, I think I've got slightly less
ugly ifdery, you may want to take a look at that:

https://lore.kernel.org/all/20230918072955.2507221-13-rppt@kernel.org
 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index cfc24ced16dd..e60ce984d095 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -52,8 +52,8 @@ config GENERIC_ENTRY
>  
>  config KPROBES
>  	bool "Kprobes"
> -	depends on MODULES
>  	depends on HAVE_KPROBES
> +	select MODULE_ALLOC
>  	select KALLSYMS
>  	select TASKS_RCU if PREEMPTION
>  	help
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 9d9095e81792..194270e17d57 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1556,8 +1556,12 @@ static bool is_cfi_preamble_symbol(unsigned long addr)
>  		str_has_prefix("__pfx_", symbuf);
>  }
>  
> +#if IS_ENABLED(CONFIG_MODULES)
>  static int check_kprobe_address_safe(struct kprobe *p,
>  				     struct module **probed_mod)
> +#else
> +static int check_kprobe_address_safe(struct kprobe *p)
> +#endif
>  {
>  	int ret;
>  
> @@ -1580,6 +1584,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  		goto out;
>  	}
>  
> +#if IS_ENABLED(CONFIG_MODULES)

Plain #ifdef will do here and below. IS_ENABLED is for usage withing the
code, like

	if (IS_ENABLED(CONFIG_MODULES))
		;

>  	/* Check if 'p' is probing a module. */
>  	*probed_mod = __module_text_address((unsigned long) p->addr);
>  	if (*probed_mod) {

-- 
Sincerely yours,
Mike.

