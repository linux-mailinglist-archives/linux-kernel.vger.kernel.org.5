Return-Path: <linux-kernel+bounces-96275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D674875996
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2911A283177
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A293A13B7A4;
	Thu,  7 Mar 2024 21:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pMG9Q1qh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7C413B784
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847829; cv=none; b=pUzK9Wuzub4xSxRSrYJIdCUQ3+QKVNGb+1qx4/jm4aU9lYQqXNhsCg8q8geO4sRo138n1iey5IqlfQXf3X3SixC2e8SBkHcWA3Y/FvF2zcOOwkGg9NM5QDWE0yQLIeqUqd7qWL+4YqX4C2Bb+OrCM0epi4bTHnxZfO/kJ5U2sxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847829; c=relaxed/simple;
	bh=26qZSTqT4jxCbU1B+y5e2f4xPG4kwNJMCxmRguGA4Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMkTZMHWFPCsYW3cCcwqnPCnPBKeDA3V/fo1RRKUQLRNqFkzAe4jOR7PtEd4KmFty6qTSMLA/Ht8m164iZXOZoqwaLZgfSQOzmNAEa/G0KIu/CiJaujAeT75zO9Snt5k2bmsb35yLqLAtDSUsa98F/8RjlZJEMhZKJ5gCU7iSoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pMG9Q1qh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BDFC433C7;
	Thu,  7 Mar 2024 21:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709847829;
	bh=26qZSTqT4jxCbU1B+y5e2f4xPG4kwNJMCxmRguGA4Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pMG9Q1qhaU6U7nN18ZR1fl0F6cMIlolkxjvhvj38IM2m/ycbcptM6tDXXCWGL3tcl
	 0aIuvnfmJJAADjmTHM4v5K5rsDKe2/SL7s9WTv2SDXD4LcYjxfkBZ7z66Sm6MIZJnv
	 VWSDRmUv0lLAxHmNIZNGacBZ/HyJndvE0w1v/++U=
Date: Thu, 7 Mar 2024 21:43:46 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	Colin Ian King <colin.i.king@intel.com>,
	kernel test robot <lkp@intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v2] binder: remove redundant variable page_addr
Message-ID: <2024030733-granny-octagon-7cfc@gregkh>
References: <https://lore.kernel.org/all/ZZl_-XGd-WJ0juz9@google.com/>
 <20240116193235.184666-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116193235.184666-1-cmllamas@google.com>

On Tue, Jan 16, 2024 at 07:32:34PM +0000, Carlos Llamas wrote:
> From: Colin Ian King <colin.i.king@intel.com>
> 
> Variable page_addr is being assigned a value that is never read. The
> variable is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> warning: Value stored to 'page_addr' is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@intel.com>
> Fixes: 162c79731448 ("binder: avoid user addresses in debug logs")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312060851.cudv98wG-lkp@intel.com/
> Acked-by: Carlos Llamas <cmllamas@google.com>
> ---
> 
> Notes:
>     v2: added tags, used char-misc-next as base
> 
>  drivers/android/binder_alloc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index a4a4dc87ba53..34d7a1494bc7 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -925,7 +925,6 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
>  		int i;
>  
>  		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
> -			unsigned long page_addr;
>  			bool on_lru;
>  
>  			if (!alloc->pages[i].page_ptr)
> @@ -933,7 +932,6 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
>  
>  			on_lru = list_lru_del(&binder_freelist,
>  					      &alloc->pages[i].lru);
> -			page_addr = alloc->buffer + i * PAGE_SIZE;
>  			binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
>  				     "%s: %d: page %d %s\n",
>  				     __func__, alloc->pid, i,
> 
> base-commit: 5850edccec30325707f953bc088497b3b9041231
> -- 
> 2.43.0.275.g3460e3d667-goog
> 

This doesn't apply to my tree anymore, can you rebase?

thanks,

greg k-h

