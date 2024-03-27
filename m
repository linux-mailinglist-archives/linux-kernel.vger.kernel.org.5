Return-Path: <linux-kernel+bounces-122012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C453388F0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F85C294F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF17153575;
	Wed, 27 Mar 2024 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQtccIVw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDA7152E07;
	Wed, 27 Mar 2024 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711573883; cv=none; b=qKrGMOPHukVMIJ78FqQ1j4UNMTbcRTt/ulRhDPQIJ/gLiVSJ+TuHEbnuuhdW06GZtlwaXtSz9nO7GBtfADm1iYhF4FMYtqQc1xX3K0DIr1lB/8KEuYAhjmRUyK6CYF5e6ym0YgjUKGJBLxHJiVYzBR7CwE0fTwtvVipik5mEB08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711573883; c=relaxed/simple;
	bh=oTnKlubl3uH5wFO9lV+FBwfsUlprxdrKnXH/rfzlnLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFtLEbz+WH7n5NyaH2RdrWcRqzZ+6f86Itah+sUg/02X+mgtloxFZ/EQU0JdHtRc7/jhf+6t9qFTjnG7VBaVXlQ+/N+mN7AsuQNc4sc3hIvXqq0H7e/edgl8RuTeWLXW2TaooajKDL9B5D12JyTt2hV2qb5cx24cIDYpRG1b7OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQtccIVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D8CC433F1;
	Wed, 27 Mar 2024 21:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711573883;
	bh=oTnKlubl3uH5wFO9lV+FBwfsUlprxdrKnXH/rfzlnLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQtccIVw6KLhkY+o8OPOmg33CFVXRvxtmB5iGdfkvI6x5TLhcqnXobL87VcKGWCoo
	 hEEA7hQlDV+PoOK9UDjQGbf9PAcUE2drNEg1YzxLOhGt/QZavwWBLEkrTL8TxdrzwA
	 +RJFIymXP24phYo/Rf/tHf+0LzfLng+MsLaecKnG7PmHFH+3lS0t4px3K8lJeRw8Ps
	 HdDur5qq4oZrAh+Jyrc6GEwcE5piRdb5yyPAScMBtrvkxLVbGZGpk8ULYPOSH0j7Gf
	 5lDPdySI/picQyOuLaVcE3TNNAu+2AMyoMIswnmGuMnwXXXBElSlWi4AKt6ejrPEap
	 rWSWUF8K0gBWg==
Date: Wed, 27 Mar 2024 21:11:19 +0000
From: Simon Horman <horms@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [RFC PATCH v2 1/4] tracing: add __print_sym() to replace
 __print_symbolic()
Message-ID: <20240327211119.GW403975@kernel.org>
References: <20240326192131.438648-6-johannes@sipsolutions.net>
 <20240326202131.9d261d5bb667.I9bd2617499f0d170df58471bc51379742190f92d@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326202131.9d261d5bb667.I9bd2617499f0d170df58471bc51379742190f92d@changeid>

On Tue, Mar 26, 2024 at 08:15:56PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The way __print_symbolic() works is limited and inefficient
> in multiple ways:
>  - you can only use it with a static list of symbols, but
>    e.g. the SKB dropreasons are now a dynamic list
> 
>  - it builds the list in memory _three_ times, so it takes
>    a lot of memory:
>    - The print_fmt contains the list (since it's passed to
>      the macro there). This actually contains the names
>      _twice_, which is fixed up at runtime.
>    - TRACE_DEFINE_ENUM() puts a 24-byte struct trace_eval_map
>      for every entry, plus the string pointed to by it, which
>      cannot be deduplicated with the strings in the print_fmt
>    - The in-kernel symbolic printing creates yet another list
>      of struct trace_print_flags for trace_print_symbols_seq()
> 
>  - it also requires runtime fixup during init, which is a lot
>    of string parsing due to the print_fmt fixup
> 
> Introduce __print_sym() to - over time - replace the old one.
> We can easily extend this also to __print_flags later, but I
> cared only about the SKB dropreasons for now, which has only
> __print_symbolic().
> 
> This new __print_sym() requires only a single list of items,
> created by TRACE_DEFINE_SYM_LIST(), or can even use another
> already existing list by using TRACE_DEFINE_SYM_FNS() with
> lookup and show methods.
> 
> Then, instead of doing an init-time fixup, just do this at the
> time when userspace reads the print_fmt. This way, dynamically
> updated lists are possible.
> 
> For userspace, nothing actually changes, because the print_fmt
> is shown exactly the same way the old __print_symbolic() was.
> 
> This adds about 4k .text in my test builds, but that'll be
> more than paid for by the actual conversions.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Hi Johannes,

I'm seeing some allmodconfig build problems with this applied on top of
net-next.

In file included from ./include/trace/trace_events.h:27,
                 from ./include/trace/define_trace.h:102,
                 from ./include/trace/events/module.h:134,
                 from kernel/module/main.c:64:
/include/trace/stages/init.h:30: warning: "TRACE_DEFINE_SYM_FNS" redefined
   30 | #define TRACE_DEFINE_SYM_FNS(_symbol_id, _lookup, _show)                \
      |
In file included from ./include/linux/trace_events.h:11,
                 from kernel/module/main.c:14:
/include/linux/tracepoint.h:130: note: this is the location of the previous definition
  130 | #define TRACE_DEFINE_SYM_FNS(...)
      |
/include/trace/stages/init.h:54: warning: "TRACE_DEFINE_SYM_LIST" redefined
   54 | #define TRACE_DEFINE_SYM_LIST(_symbol_id, ...)                          \
      |
/include/linux/tracepoint.h:131: note: this is the location of the previous definition
  131 | #define TRACE_DEFINE_SYM_LIST(...)
      |


