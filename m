Return-Path: <linux-kernel+bounces-104860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9407E87D4AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B75C1F23310
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E341D5336D;
	Fri, 15 Mar 2024 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JufaOikB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC51F19A;
	Fri, 15 Mar 2024 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532438; cv=none; b=bKpil2xKIvvfm/aMudXERvs62ALVhslZBKR5dDDLxyUxxV65+S1NVDpTd7lBnmXQ0jXa7NHx3qd7mP0PLKjwEm7j7Pw4ozs8ere99EoAvr5b4U6AklhB0Q2j3w4gpVa3oHm0/VkM761J0u0AnRIImwDJnjxfyPuvnzqJzoC3aaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532438; c=relaxed/simple;
	bh=4PT/OHwSdOfJ2L+egmu9PpH8a/jXfjVHm5TKyLyhmGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvLyqvtQiDZPGSznJHsqf9PWQMTteGmK9e1iyS59GTR8e2KFow4odmwic5rWDJ/STN0km/IDDAgY8LYRSFvJSKEWxgAP8drIzmQEj64JQppVtRFurNHSsRvG/35g0xBgFxwWvSpGacF9Sbx4ZTOsQ3rv8saK2xNEvYLuNO8A9pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JufaOikB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710532435; x=1742068435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4PT/OHwSdOfJ2L+egmu9PpH8a/jXfjVHm5TKyLyhmGo=;
  b=JufaOikBCm95igBsIhyHvehbCSFTvy41e6CffxWig66VOd3dFnJHO7nB
   GltEhJuHCnjmf9h/S+U9QPzGzhjMHpqM9B2SJUpFONlwCZG9pQKVfR08L
   wU2Ld9kUgVLxBArxIvDOd3uO6I/NpkR7JJNa/nY1CVtdn55+bvZdi5Qzb
   PjgdKDyRR2gksIAGQhOFaHCKDVsj4MD/xhRoNdnnO7affU5HTt8HFf9m8
   Pg72CcfYRKUG1ffL+1eVP+WsonWJllAPY7Ry56JdAYpeHpzMsA3uybkR1
   6BE0pkMYTGAmu7A2xDqzYhX3Q4FwUbzCmx9lguzXXZEziz65eMrTsAOqJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="5355577"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="5355577"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 12:53:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="12699312"
Received: from dmurray-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.29.31])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 12:53:54 -0700
Date: Fri, 15 Mar 2024 12:53:52 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Add __string_src() helper to help compilers not
 to get confused
Message-ID: <ZfSnUHp3PEqRTZMq@aschofie-mobl2>
References: <20240314232754.345cea82@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314232754.345cea82@rorschach.local.home>

On Thu, Mar 14, 2024 at 11:27:54PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The __string() helper macro of the TRACE_EVENT() macro is used to
> determine how much of the ring buffer needs to be allocated to fit the
> given source string. Some trace events have a string that is dependent on
> another variable that could be NULL, and in those cases the string is
> passed in to be NULL.
> 
> The __string() macro can handle being passed in a NULL pointer for which
> it will turn it into "(null)". It does that with:
> 
>   strlen((src) ? (const char *)(src) : "(null)") + 1
> 
> But if src itself has the same conditional type it can confuse the
> compiler. That is:
> 
>   __string(r ? dev(r)->name : NULL)
> 
> Would turn into:
> 
>  strlen((r ? dev(r)->name : NULL) ? (r ? dev(r)->name : NULL) : "(null)" + 1
> 
> For which the compiler thinks that NULL is being passed to strlen() and
> gives this kind of warning:
> 
> ./include/trace/stages/stage5_get_offsets.h:50:21: warning: argument 1 null where non-null expected [-Wnonnull]
>    50 |                     strlen((src) ? (const char *)(src) : "(null)") + 1)
> 
> Instead, create a static inline function that takes the src string and
> will return the string if it is not NULL and will return "(null)" if it
> is. This will then make the strlen() line:
> 
>  strlen(__string_src(src)) + 1
> 
> Where the compiler can see that strlen() will not end up with NULL and
> does not warn about it.
> 
> Note that this depends on commit 51270d573a8d ("tracing/net_sched: Fix
> tracepoints that save qdisc_dev() as a string") being applied, as passing
> the qdisc_dev() into __string_src() will give an error.
> 
> Link: https://lore.kernel.org/all/ZfNmfCmgCs4Nc+EH@aschofie-mobl2/


Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Reported-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/trace/stages/stage5_get_offsets.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
> index e6b96608f452..c6a62dfb18ef 100644
> --- a/include/trace/stages/stage5_get_offsets.h
> +++ b/include/trace/stages/stage5_get_offsets.h
> @@ -9,6 +9,16 @@
>  #undef __entry
>  #define __entry entry
>  
> +#ifndef __STAGE5_STRING_SRC_H
> +#define __STAGE5_STRING_SRC_H
> +static inline const char *__string_src(const char *str)
> +{
> +       if (!str)
> +	       return EVENT_NULL_STR;
> +       return str;
> +}
> +#endif /* __STAGE5_STRING_SRC_H */
> +
>  /*
>   * Fields should never declare an array: i.e. __field(int, arr[5])
>   * If they do, it will cause issues in parsing and possibly corrupt the
> @@ -47,7 +57,7 @@
>  
>  #undef __string
>  #define __string(item, src) __dynamic_array(char, item,			\
> -		    strlen((const char *)(src) ? : EVENT_NULL_STR) + 1)	\
> +		    strlen(__string_src(src)) + 1)			\
>  	__data_offsets->item##_ptr_ = src;
>  
>  #undef __string_len
> @@ -70,7 +80,7 @@
>  
>  #undef __rel_string
>  #define __rel_string(item, src) __rel_dynamic_array(char, item,		\
> -		    strlen((const char *)(src) ? : EVENT_NULL_STR) + 1)	\
> +		    strlen(__string_src(src)) + 1)			\
>  	__data_offsets->item##_ptr_ = src;
>  
>  #undef __rel_string_len
> -- 
> 2.43.0
> 

