Return-Path: <linux-kernel+bounces-137299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C06089E023
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C971D28890E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A036C13DDA5;
	Tue,  9 Apr 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk3e+T5w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC76F13D8A0;
	Tue,  9 Apr 2024 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679321; cv=none; b=g3k1qFm2kFNlA2pzpEB3RiFr+Lhwej5VykU5AoJC/eaR/gZ7PsoH9zNyYGRUKZ/Ysa1PMLj4McuThBtIrlsKhdOD9XanvyAKvPVW+XHTpre08ZaMZOs+vavb7JTj3/ra3jLkSCcTXZDMowzQyP6Nz1HXGvLmv+2bQe2+0FpyQ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679321; c=relaxed/simple;
	bh=aQnXMHVSse19+ZZ5n5B1a+ECbXRCEMx+99YFJTJvLZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mceUZbe7EsObDX7LtXrBy+kAWo2ZLRA1VVWOgsXkUQXBgciE5NeLIH5nABbJ3V/dlKdvII7RC8/LkGROJrzJ/Ljr0vcpDRegUIPfamfImta0nBDcCQGkG4VA7RHI1jW61MDVqCISpfdxgeGTdhbn9NTQTYmYB4UKI/ZBE1k4LkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk3e+T5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A2AC433F1;
	Tue,  9 Apr 2024 16:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712679320;
	bh=aQnXMHVSse19+ZZ5n5B1a+ECbXRCEMx+99YFJTJvLZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hk3e+T5wh0K9Kad+FZuar56N0ZsAlmRAJwkkOgstUx5MMjyakXAd3tuT1BItcL+w1
	 bWWSW5ioBrtKbw8Qt5gCwr915JRo0jesU2hD4Q26gIJ3yYa0AV4hQAr+EV7vTFFI+H
	 GqmhWn8Pli4YMOBs5+19b+MyGAM+ppmX9cqkZWFdkL4/Di4EGtYtzYR1OO+fUJkcER
	 0zUCzflp3O2liOCbbuG8iz2p2sCXVzMYGUtv2DckZLOGZedO2cSaqGoCfPdOCv1GiV
	 Ea2hz+dGJvBPzTXvJjlzunxRnZEY6622if4iEHFFvcFGIcDSHJCEe57X8vR2da+OUn
	 /okM8DtsW6K0Q==
Date: Tue, 9 Apr 2024 09:15:17 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Lin Ma <linma@zju.edu.cn>,
	Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>,
	Tobias Brunner <tobias@strongswan.org>,
	Raed Salem <raeds@nvidia.com>, Netdev <netdev@vger.kernel.org>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] [RFC] xfrm: work around a clang-19 fortifiy-string
 false-positive
Message-ID: <20240409161517.GA3219862@dev-arch.thelio-3990X>
References: <20240216202657.2493685-1-arnd@kernel.org>
 <202402161301.BBFA14EE@keescook>
 <763214eb-20eb-4627-8d4b-2e7f29db829a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <763214eb-20eb-4627-8d4b-2e7f29db829a@app.fastmail.com>

On Mon, Apr 08, 2024 at 09:06:21AM +0200, Arnd Bergmann wrote:
> On Fri, Feb 16, 2024, at 22:19, Kees Cook wrote:
> > On Fri, Feb 16, 2024 at 09:26:40PM +0100, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> clang-19 recently got branched from clang-18 and is not yet released.
> >> The current version introduces exactly one new warning that I came
> >> across in randconfig testing, in the copy_to_user_tmpl() function:
> >> 
> >> include/linux/fortify-string.h:420:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
> >>   420 |                         __write_overflow_field(p_size_field, size);
> >> 
> >> I have not yet produced a minimized test case for it, but I have a
> >> local workaround, which avoids the memset() here by replacing it with
> >> an initializer.
> >> 
> >> The memset is required to avoid leaking stack data to user space
> >> and was added in commit 1f86840f8977 ("xfrm_user: fix info leak in
> >> copy_to_user_tmpl()"). Simply changing the initializer to set all fields
> >> still risks leaking data in the padding between them, which the compiler
> >> is free to do here. To work around that problem, explicit padding fields
> >> have to get added as well.
> >
> > Per C11, padding bits are zero initialized if there is an initializer,
> > so "= { }" here should be sufficient -- no need to add the struct
> > members.
> >
> >> Since this is a false positive, a better fix would likely be to
> >> fix the compiler.
> >
> > As Nathan has found, this appears to be a loop unrolling bug in Clang.
> > https://github.com/ClangBuiltLinux/linux/issues/1985
> >
> > The shorter fix (in the issue) is to explicitly range-check before
> > the loop:
> >
> >        if (xp->xfrm_nr > XFRM_MAX_DEPTH)
> >                return -ENOBUFS;
> 
> I ran into this issue again and I see that Nathan's fix has
> made it into mainline and backports, but it's apparently
> not sufficient.
> 
> I don't see the warning with my patch from this thread, but
> there may still be a better fix.

Is it the exact same warning? clang-19 or older? What
architecture/configuration? If my change is not sufficient then maybe
there are two separate issues here? I have not seen this warning appear
in our CI since my change was applied.

Cheers,
Nathan

