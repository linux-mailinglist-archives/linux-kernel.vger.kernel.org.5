Return-Path: <linux-kernel+bounces-162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0468813CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF441C21D21
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C08F67213;
	Thu, 14 Dec 2023 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oAZ/Pakb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19085671FA;
	Thu, 14 Dec 2023 21:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E681BC433C8;
	Thu, 14 Dec 2023 21:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702590618;
	bh=On3GH+H5OWqs4RSfoU5sLErw51EY3L9vRvQWeh0ze6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oAZ/PakbstrORQJCz0NFk8psHpQ6Ymb8y74hf8k/nwZIG8BMfmZTodR39KIKAPTVN
	 3wi6r6WhGHGktYGMqS5SS8rhV7NMH7A7CdAmX4lF8JkV9/uU2cNA/UKMxHnyJfioal
	 hADKG1FiqDptFxi07RPSL3NlqBePTLk9NCk42NL0=
Date: Thu, 14 Dec 2023 13:50:16 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "kernelci . org bot" <bot@kernelci.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Zi Yan <ziy@nvidia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: fix r3k_cache_init build regression
Message-Id: <20231214135016.85cfc8580a26677ab13c9e2c@linux-foundation.org>
In-Reply-To: <20231214205506.310402-1-arnd@kernel.org>
References: <20231214205506.310402-1-arnd@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 20:54:47 +0000 Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> My earlier patch removed __weak function declarations that used to
> be turned into wild branches by the linker, instead causing
> a link failure when the called functions are unavailable:
> 
> mips-linux-ld: arch/mips/mm/cache.o: in function `cpu_cache_init':
> cache.c:(.text+0x670): undefined reference to `r3k_cache_init'
> 
> The __weak method seems suboptimal, so rather than putting that
> back, make the function calls conditional on the Kconfig symbol
> that controls the compilation.

Cool, thanks.

> Reported-by: kernelci.org bot <bot@kernelci.org>

Please don't forget the Closes: - they're sometimes handy.

> Fixes: 66445677f01e ("mips: move cache declarations into header")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> My broken patch is currently in linux-mm, so the fix should
> be applied on top.

The mm-nonmm-stable branch of mm.git.  So I'll queue this separately
and we'll have a minor bisection hole.  <git rant elided>

> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -205,14 +205,14 @@ static inline void setup_protection_map(void)
>  
>  void cpu_cache_init(void)
>  {
> -	if (cpu_has_3k_cache) {
> +	if (IS_ENABLED(CONFIG_CPU_R3000) && cpu_has_3k_cache) {
>  		r3k_cache_init();
>  	}
> -	if (cpu_has_4k_cache) {
> +	if (IS_ENABLED(CONFIG_CPU_R4K_CACHE_TLB) && cpu_has_4k_cache) {
>  		r4k_cache_init();
>  	}
>  
> -	if (cpu_has_octeon_cache) {
> +	if (IS_ENABLED(CONFIG_CPU_CAVIUM_OCTEON) && cpu_has_octeon_cache) {
>  		octeon_cache_init();
>  	}

I just can't help myself.

--- a/arch/mips/mm/cache.c~mips-fix-r3k_cache_init-build-regression-fix
+++ a/arch/mips/mm/cache.c
@@ -205,16 +205,13 @@ static inline void setup_protection_map(
 
 void cpu_cache_init(void)
 {
-	if (IS_ENABLED(CONFIG_CPU_R3000) && cpu_has_3k_cache) {
+	if (IS_ENABLED(CONFIG_CPU_R3000) && cpu_has_3k_cache)
 		r3k_cache_init();
-	}
-	if (IS_ENABLED(CONFIG_CPU_R4K_CACHE_TLB) && cpu_has_4k_cache) {
+	if (IS_ENABLED(CONFIG_CPU_R4K_CACHE_TLB) && cpu_has_4k_cache)
 		r4k_cache_init();
-	}
 
-	if (IS_ENABLED(CONFIG_CPU_CAVIUM_OCTEON) && cpu_has_octeon_cache) {
+	if (IS_ENABLED(CONFIG_CPU_CAVIUM_OCTEON) && cpu_has_octeon_cache)
 		octeon_cache_init();
-	}
 
 	setup_protection_map();
 }

The rest of the file doesn't do the over-bracing, so there.

