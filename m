Return-Path: <linux-kernel+bounces-106380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3447B87ED98
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94B61F22E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC0D548EE;
	Mon, 18 Mar 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgL2hDA0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26B91367
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779684; cv=none; b=l62fmJIv3CeEJlxlFAaek0nSxzbkDxDOxzJaICZXdlKZkXl9snsmtnE6Zqh2pvmgcUW4gdz6cBMn3ZAOtEnIpMWPl0i1mCb6sOptNO6iA2o+qEBI4t6eloAiBuOS4pJsiK1nMGLnGxf4UdAbQM26N06fLhv/VA9QfIz2Udn+3SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779684; c=relaxed/simple;
	bh=pfup/NakHv1HwT2uog2GSapR/ei7OeBW0M1tkoJiqcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz5h59gJejKMlNRULyiCLWOjC9IY3yhqJ2jvWzV3o+B6h0/ZIQh5I52JD995xVe226UIjH40fUIwHt+Wi74/UYbP3/o+NyAQVa/nXK2Yr7t3ErgYkxXAFc147bSKAZkp3s3w7taHlVg1J/wQ63ptfdvYmmIMH9cXCMO9H+IryWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgL2hDA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FD1C433F1;
	Mon, 18 Mar 2024 16:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710779684;
	bh=pfup/NakHv1HwT2uog2GSapR/ei7OeBW0M1tkoJiqcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fgL2hDA0li5ZXDa1DMsldGmc5AlnJ3BWXC2dx6VCAzNwl7DLQ4pn8rf4kbS8w96p0
	 U+QRx/AbywGHVF6Pp+8RNEcH4esvRAKoKsy51W1vJ05fU9ESsqRMI9N0Dp/o5JQMEP
	 ehm0G5AypWn7sEmGdy60kvLTqiFltfPrBSIjbWNL+uaMKts0rjeuJXsmOWFWoo/d4A
	 UEEuC9A5FETOylt4Qf0zqT5cVpxXz36j1FuFbVw2T361q0aNYBlEwOoHi6aW0F2T3O
	 WlS3+69AbhUljGv8Pfnka9xO83p2/UcWbjbjWS6g4HPubhvqgV0M7NL3j3SSboEGPJ
	 KpOcvbBVF9HjA==
Date: Mon, 18 Mar 2024 18:33:40 +0200
From: Mike Rapoport <rppt@kernel.org>
To: thunder.leizhen@huaweicloud.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/mm_init.c: eliminate a local variable in
 mem_debugging_and_hardening_init()
Message-ID: <Zfhs5LD-1RQt3aw4@kernel.org>
References: <20240318135715.312-1-thunder.leizhen@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318135715.312-1-thunder.leizhen@huaweicloud.com>

On Mon, Mar 18, 2024 at 09:57:14PM +0800, thunder.leizhen@huaweicloud.com wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> The local variable 'page_poisoning_requested' is assigned true at only
> one point. It can be eliminated by moving the code that depends on it
> to the location where it is assigned true. This also make the moved
> code to be compiled only if CONFIG_PAGE_POISONING is set.

I don't see it as much of an improvement and code readability becomes worse
IMO.
 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  mm/mm_init.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 549e76af8f82a8e..3eb217130bcb2b5 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2614,7 +2614,6 @@ DEFINE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
>   */
>  static void __init mem_debugging_and_hardening_init(void)
>  {
> -	bool page_poisoning_requested = false;
>  	bool want_check_pages = false;
>  
>  #ifdef CONFIG_PAGE_POISONING
> @@ -2626,18 +2625,16 @@ static void __init mem_debugging_and_hardening_init(void)
>  	     (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
>  	      debug_pagealloc_enabled())) {
>  		static_branch_enable(&_page_poisoning_enabled);
> -		page_poisoning_requested = true;
>  		want_check_pages = true;
> -	}
> -#endif
>  
> -	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
> -	    page_poisoning_requested) {
> -		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> -			"will take precedence over init_on_alloc and init_on_free\n");
> -		_init_on_alloc_enabled_early = false;
> -		_init_on_free_enabled_early = false;
> +		if (_init_on_alloc_enabled_early || _init_on_free_enabled_early) {
> +			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> +				"will take precedence over init_on_alloc and init_on_free\n");
> +			_init_on_alloc_enabled_early = false;
> +			_init_on_free_enabled_early = false;
> +		}
>  	}
> +#endif
>  
>  	if (_init_on_alloc_enabled_early) {
>  		want_check_pages = true;
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.

