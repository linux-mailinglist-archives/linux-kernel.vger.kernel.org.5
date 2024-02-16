Return-Path: <linux-kernel+bounces-69328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06DD858772
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59AEB28F68A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F48145FE7;
	Fri, 16 Feb 2024 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxl3kh0d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74DA135A41;
	Fri, 16 Feb 2024 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708116152; cv=none; b=KzblqxW4YGlob207Sw/wF/VKuZp9D0mnMFxOkdAUzII0GojGnpeli4Ga0BNVEAwlqismxIwuQ/MkFK28v5Hw7NBaWzUTMqDXmmg+lRkEig44qJjkKULl3fnkCjB/bHfsy85ATMOb4DMf9EN+rFay5XPdfb10y0l89srEp4vOP6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708116152; c=relaxed/simple;
	bh=F81shhblktltp1h8t42uFEnG2IFNx0MPP8DE2AnUpg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcqA5/fJbNvVwSOWuVG4IURRWyJ2BQyffYGgW6mtgSmhdV8+XcrAdWveVSPZGN8pkuS6bxo4+k4y+UGsbVAynmJN4GcAw9DG6PTuDGxsnLzoADr0x1ZmJakrG+F3fd9qSWc68AGaEGiDM5xaXjGf3II52F0ghveAx22rTK9Hlyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxl3kh0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579DAC43390;
	Fri, 16 Feb 2024 20:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708116151;
	bh=F81shhblktltp1h8t42uFEnG2IFNx0MPP8DE2AnUpg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jxl3kh0dTB9X6BR2LZOsRknePjNVjA03E9VBHUmVLm65j0oppYDjEIzuYrlqZ3xwC
	 t1zjpPPoQ+7tT9zU9DuIWFTVFEQ2Sfu/fn3xPMpm7tYPUBmfKy1tSwlVGT/q4inBlQ
	 CPuG3CKzSfLzypfDbPo8GgppslyblHytmHhQpuFaupFosLpu9v25BIWf3/ibbdzhau
	 lJQ8+v4MsbT+loeClwwM6pA+dZpsZzirDa09Z1er2tfhrmIu1WVXs9ALx4I77Lm0/s
	 7G/fuLylB/xtcxZ2JIdnYxqCzNaoaseLeisxeSr8HAOIRdku+/OaDVnN80QHb8yZ98
	 bHM3Xv5ygml7g==
Date: Fri, 16 Feb 2024 13:42:28 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Leon Romanovsky <leon@kernel.org>, Lin Ma <linma@zju.edu.cn>,
	Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>,
	Tobias Brunner <tobias@strongswan.org>,
	Raed Salem <raeds@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] [RFC] xfrm: work around a clang-19 fortifiy-string
 false-positive
Message-ID: <20240216204228.GA3733086@dev-arch.thelio-3990X>
References: <20240216202657.2493685-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216202657.2493685-1-arnd@kernel.org>

Hi Arnd,

On Fri, Feb 16, 2024 at 09:26:40PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-19 recently got branched from clang-18 and is not yet released.
> The current version introduces exactly one new warning that I came
> across in randconfig testing, in the copy_to_user_tmpl() function:
> 
> include/linux/fortify-string.h:420:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>   420 |                         __write_overflow_field(p_size_field, size);
> 
> I have not yet produced a minimized test case for it, but I have a
> local workaround, which avoids the memset() here by replacing it with
> an initializer.
> 
> The memset is required to avoid leaking stack data to user space
> and was added in commit 1f86840f8977 ("xfrm_user: fix info leak in
> copy_to_user_tmpl()"). Simply changing the initializer to set all fields
> still risks leaking data in the padding between them, which the compiler
> is free to do here. To work around that problem, explicit padding fields
> have to get added as well.
> 
> My first idea was that just adding the padding would avoid the warning
> as well, as the padding tends to confused the fortified string helpers,
> but it turns out that both changes are required here.
> 
> Since this is a false positive, a better fix would likely be to
> fix the compiler.

I have some observations and notes from my initial investigation into
this issue on our GitHub issue tracker but I have not produced a
minimized test case either.

https://github.com/ClangBuiltLinux/linux/issues/1985

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/uapi/linux/xfrm.h | 3 +++
>  net/xfrm/xfrm_user.c      | 3 +--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> index 6a77328be114..99adac4fa648 100644
> --- a/include/uapi/linux/xfrm.h
> +++ b/include/uapi/linux/xfrm.h
> @@ -27,6 +27,7 @@ struct xfrm_id {
>  	xfrm_address_t	daddr;
>  	__be32		spi;
>  	__u8		proto;
> +	__u8		__pad[3];
>  };
>  
>  struct xfrm_sec_ctx {
> @@ -242,11 +243,13 @@ struct xfrm_user_sec_ctx {
>  struct xfrm_user_tmpl {
>  	struct xfrm_id		id;
>  	__u16			family;
> +	__u16			__pad1;
>  	xfrm_address_t		saddr;
>  	__u32			reqid;
>  	__u8			mode;
>  	__u8			share;
>  	__u8			optional;
> +	__u8			__pad2;
>  	__u32			aalgos;
>  	__u32			ealgos;
>  	__u32			calgos;
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index a5232dcfea46..e81f977e183c 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -2011,7 +2011,7 @@ static int xfrm_add_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
>  
>  static int copy_to_user_tmpl(struct xfrm_policy *xp, struct sk_buff *skb)
>  {
> -	struct xfrm_user_tmpl vec[XFRM_MAX_DEPTH];
> +	struct xfrm_user_tmpl vec[XFRM_MAX_DEPTH] = {};
>  	int i;
>  
>  	if (xp->xfrm_nr == 0)
> @@ -2021,7 +2021,6 @@ static int copy_to_user_tmpl(struct xfrm_policy *xp, struct sk_buff *skb)
>  		struct xfrm_user_tmpl *up = &vec[i];
>  		struct xfrm_tmpl *kp = &xp->xfrm_vec[i];
>  
> -		memset(up, 0, sizeof(*up));
>  		memcpy(&up->id, &kp->id, sizeof(up->id));
>  		up->family = kp->encap_family;
>  		memcpy(&up->saddr, &kp->saddr, sizeof(up->saddr));
> -- 
> 2.39.2
> 

