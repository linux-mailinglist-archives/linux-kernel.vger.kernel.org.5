Return-Path: <linux-kernel+bounces-18652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C603826092
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC751F234D6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671D9882A;
	Sat,  6 Jan 2024 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnRXAGLA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0D846F;
	Sat,  6 Jan 2024 16:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B132FC433C8;
	Sat,  6 Jan 2024 16:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704557635;
	bh=XjvIgbYcLNiCPkQTGelWcqBIIVCUpLezTCqf4WDSr7s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pnRXAGLAzveDRtfyVpbEr8/WJp7ZmsJrEOnBHSFkWr1Vd/LVFaE81vlN8AtobqrZr
	 rHfpsrasqFspuH8W5jZyx7DQNvYH0ZQ1M03WnXZWZ8A3WAWvwjvm0//S70hyFPxu0a
	 UBSfedo+7YoTBRB2E657TLu9NAp4Vid69oZPnbCD1j+NstfHUrRn0ffMEs8yoqpOpk
	 +YEGF3IROcDukWG5yfhux248hN/sBEdBglro9ArxmknECgkMq/MJ+bfhWY3egzhdIh
	 s+t/wseTVB22CEgLiQsN6U+WMBHb0R2G8pINYVo+Z2uFKQaMbNJYXWvqXPKAhkvQLG
	 3qiRzT5hw1/+Q==
Message-ID: <8ae4f9b0-1917-448d-a89b-11597549f89b@kernel.org>
Date: Sat, 6 Jan 2024 09:13:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/ipv6: resolve warning in ip6_fib.c
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: leit@meta.com, "open list:NETWORKING [IPv4/IPv6]"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>, Wei Wang <weiwan@google.com>
References: <20240105173920.1041474-1-leitao@debian.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240105173920.1041474-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/24 10:39 AM, Breno Leitao wrote:
> In some configurations, the 'iter' variable in function
> fib6_repair_tree() is unused, resulting the following warning when
> compiled with W=1.
> 
> 	net/ipv6/ip6_fib.c:1781:6: warning: variable 'iter' set but not used [-Wunused-but-set-variable]
> 	 1781 |         int iter = 0;
> 	      |             ^
> 
> Rewrite RT6_TRACE() macro to keep the variable in scope.
> 
> Clang 18 removes the trace completely from the binary when the trace is
> disabled[1], so, no overhead is expected with this change.
> 
> [1] Link: https://paste.debian.net/1303162/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/net/ip6_fib.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
> index 9ba6413fd2e3..d2ef60ebeb25 100644
> --- a/include/net/ip6_fib.h
> +++ b/include/net/ip6_fib.h
> @@ -30,11 +30,7 @@
>  
>  #define RT6_DEBUG 2
>  
> -#if RT6_DEBUG >= 3
> -#define RT6_TRACE(x...) pr_debug(x)
> -#else
> -#define RT6_TRACE(x...) do { ; } while (0)
> -#endif
> +#define RT6_TRACE(x...) do { if (RT6_DEBUG > 3) pr_debug(x); } while (0)
>  
>  struct rt6_info;
>  struct fib6_info;

I question the value of RT6_TRACE vs just using pr_debug; pr_debug has
zero cost until enabled and can be enabled by file or line. Not
requiring a kernel build is actual better.

[cc'ed Wei who added the macro]

