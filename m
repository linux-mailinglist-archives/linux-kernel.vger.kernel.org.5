Return-Path: <linux-kernel+bounces-102117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBBA87AE8E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE883284B96
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF0E6A347;
	Wed, 13 Mar 2024 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLfi2zOh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702C66A33F;
	Wed, 13 Mar 2024 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349146; cv=none; b=cFmhD1mcGVlxY/sI/5zb5UDKMeR/Hqgpy6kh5ML9ChhG1MCkhdNsTeGI4V3krAqoa7i7MPro00QyFYrWyVex/J75C8OZ5/Ry00axsmsLPvkI4yDc62/3O8wF+LcddZVKbU3PI4wQo04RSgmZgr2zH9WlzDGji+b7InfqYczDDDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349146; c=relaxed/simple;
	bh=LT3kIpTgfIeJT2ndzGReEZ3LVNsm9Vy8OKpjO+wpUoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdeJsjqLpX2RdEhlSb9I/KwvWS16hDoCU0xuCatbbQyFFaYN3tREtMJ0I6Ftl6wVGPTAZz3kuQ15qNa37HV/BMcdNXs5/C58LwF+pc4w9E/yERWdsupEjB9WEM/BEgq4tbU4VFmGmYHMzerChhC5Bv95nxq9DjFnwSywcnwknQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLfi2zOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA8EC433F1;
	Wed, 13 Mar 2024 16:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349146;
	bh=LT3kIpTgfIeJT2ndzGReEZ3LVNsm9Vy8OKpjO+wpUoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nLfi2zOhyYhf8rekQqiDjcHVEKiOJiT0fNDLlF4RwWn8HgsukBlvaEf3+YrV6HO30
	 HO4JUxM4mgIJ5/gScZPZTwWrc6UliEN+XINNp2/A0UPOkS0ZZTCkDQTOhdICZm2LeD
	 FPEwoHSLF8lktqvcFZVrHHdArR8PnlugmJGt+BwoaAIY22392rK8/zPIDnoyuTKdET
	 TljdRX1zJDuCJs8e/R2WOU+LbELAZW8vtvRPpB1MPf58IE/1CRFxQWn5npgTXZHQDq
	 s3+raPiqn1eFetOWqwSz6SRYGwO9j0oz/0kJ52yS/yylSt3+gLktXdRmfLwMYxMGp5
	 P2kOD0OPg282A==
Date: Wed, 13 Mar 2024 09:59:03 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev
Subject: Re: [PATCH] tracing: Use strcmp() in __assign_str() WARN_ON() check
Message-ID: <20240313165903.GA3021536@dev-arch.thelio-3990X>
References: <20240312113002.00031668@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312113002.00031668@gandalf.local.home>

On Tue, Mar 12, 2024 at 11:30:02AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The WARN_ON() check in __assign_str() to catch where the source variable
> to the macro doesn't match the source variable to __string() gives an
> error in clang:
> 
> >> include/trace/events/sunrpc.h:703:4: warning: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Wstring-compare]
>      670 |                         __assign_str(progname, "unknown");
> 
> That's because the __assign_str() macro has:
> 
>    WARN_ON_ONCE((src) != __data_offsets.dst##_ptr_);
> 
> Where "src" is a string literal. Clang warns when comparing a string
> literal directly as it is undefined to what the value of the literal is.
> 
> Since this is still to make sure the same string that goes to __string()
> is the same as __assign_str(), for string literals do a test for that and
> then use strcmp() in those cases
> 
> Note that this depends on commit 51270d573a8d ("tracing/net_sched: Fix
> tracepoints that save qdisc_dev() as a string") being applied, as this was
> what found that bug.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402292111.KIdExylU-lkp@intel.com/
> Fixes: 433e1d88a3be ("tracing: Add warning if string in __assign_str() does not match __string()")

Is this change destined for 6.9 or 6.10? I applied it to current
trace/core (eb1533d156d3) along with 51270d573a8d but the warning is
still present. I even tried

    __builtin_choose_expr(__is_constexpr((src)),
                         strcmp((src), __data_offsets.dst##_ptr_),
                         (src) != __data_offsets.dst##_ptr_));

but not even that silenced the warning. I think we will still need a
diag directive to fully silence this warning.

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/trace/stages/stage6_event_callback.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
> index a0c15f67eabe..83da83a0c14f 100644
> --- a/include/trace/stages/stage6_event_callback.h
> +++ b/include/trace/stages/stage6_event_callback.h
> @@ -35,7 +35,9 @@
>  	do {								\
>  		char *__str__ = __get_str(dst);				\
>  		int __len__ = __get_dynamic_array_len(dst) - 1;		\
> -		WARN_ON_ONCE((src) != __data_offsets.dst##_ptr_);	\
> +		WARN_ON_ONCE(__builtin_constant_p(src) ?		\
> +			     strcmp((src), __data_offsets.dst##_ptr_) :	\
> +			     (src) != __data_offsets.dst##_ptr_);	\
>  		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
>  		       EVENT_NULL_STR, __len__);			\
>  		__str__[__len__] = '\0';				\
> -- 
> 2.43.0
> 

