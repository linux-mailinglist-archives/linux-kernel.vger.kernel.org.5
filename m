Return-Path: <linux-kernel+bounces-139142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7445989FF08
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFD928AEFF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB201802C3;
	Wed, 10 Apr 2024 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4wyUNXm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04458172BBA;
	Wed, 10 Apr 2024 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771144; cv=none; b=EkDBqPFbs2vk/G7O5vdONeMapbfNJKeeNNAqPk9akzd1ZhRRpctjmYRqMbCOq1AKTa1vpCuw6k23SuOTf4DA/lAIPS/5Qph2josBCo2UHuyhMlgffYO4QJrIPOzSkwW815RAlgzkDnYTHhLYnfrzxClG1FA+Jvk640s7QdbtyL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771144; c=relaxed/simple;
	bh=4HxhIxz1qnINsE/eh0Ei4JK0lPO3IXgG3NuSYv/yN/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ht8IEE5m+TZQjXyNzjr4k0jyXlh4okyHJxjgciPuKZ5YTw3jYRcqS1Gz609W6lh2D8BBpjti1ZNGIwV4trOdLbim6uIay0vhftxckeZ638fJI1yqtuD5AEradC5xdtxoPh2mJWQySO6/zDx/Z60lcBMzCRsNNmslj9SpW0uqBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4wyUNXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B40BC43390;
	Wed, 10 Apr 2024 17:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712771143;
	bh=4HxhIxz1qnINsE/eh0Ei4JK0lPO3IXgG3NuSYv/yN/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4wyUNXmswTj1u4BA484bIuNcklHmB5TA7wajGIIF5plKdO5YRWUkPJ4Rup+ZHnqy
	 XybJK/pACKZnuE1+5WgMB0IRo2mV1yZP7zlpX+stj/1qLkyQQeUTrBL3xEzqb7cIt9
	 0yjBj0J0q+OcVE3sms6PBJWbHoQurnU52TFHjkJC5jGNOvCwRZQTre1+S4IPDd6P48
	 jludvrK3Es+chz4K4FHHx02VQWGCcKE9exDExTEm427EGo+26QbJMOOIH8mh8pAbKZ
	 a00r61yZb+4rK37PpYXWb9MkAWIBmPVzZxXSNu0fY5HBAhLK/ipy1D0tnVaZU6Vh/A
	 rXMF/ilP6JHiw==
Date: Wed, 10 Apr 2024 10:45:40 -0700
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
Message-ID: <20240410174540.GB3649628@dev-arch.thelio-3990X>
References: <20240216202657.2493685-1-arnd@kernel.org>
 <202402161301.BBFA14EE@keescook>
 <763214eb-20eb-4627-8d4b-2e7f29db829a@app.fastmail.com>
 <20240409161517.GA3219862@dev-arch.thelio-3990X>
 <f94c6943-eb93-4533-8e4d-3645ef38b990@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f94c6943-eb93-4533-8e4d-3645ef38b990@app.fastmail.com>

On Tue, Apr 09, 2024 at 09:41:09PM +0200, Arnd Bergmann wrote:
> On Tue, Apr 9, 2024, at 18:15, Nathan Chancellor wrote:
> > On Mon, Apr 08, 2024 at 09:06:21AM +0200, Arnd Bergmann wrote:
> >> >
> >> > The shorter fix (in the issue) is to explicitly range-check before
> >> > the loop:
> >> >
> >> >        if (xp->xfrm_nr > XFRM_MAX_DEPTH)
> >> >                return -ENOBUFS;
> >> 
> >> I ran into this issue again and I see that Nathan's fix has
> >> made it into mainline and backports, but it's apparently
> >> not sufficient.
> >> 
> >> I don't see the warning with my patch from this thread, but
> >> there may still be a better fix.
> >
> > Is it the exact same warning? clang-19 or older?
> > What > architecture/configuration? If my change is not sufficient then maybe
> > there are two separate issues here? I have not seen this warning appear
> > in our CI since my change was applied.
> 
> I only see it with clang-19. I've never seen it with arm32 and
> currently only see it with arm64, though I had seen it with x86-64
> as well in February before your patch.

That seems to line up with my prior experience.

> The warning is the same as before aside from the line number,
> which which is now include/linux/fortify-string.h:462:4
> where it was line 420, but I think that is just a context
> change.
> 
> I have a number of configs that reproduce this bug, see
> https://pastebin.com/tMgfD7cu for an example with current
> linux-next.

Thanks for that. I was able to reproduce this on next-20240410 as well
and I reduced the necessary configurations needed to reproduce this on
top of just defconfig:

  $ echo 'CONFIG_FORTIFY_SOURCE=y
  CONFIG_KASAN=y
  CONFIG_XFRM_USER=y' >arch/arm64/configs/repro.config

  $ make -skj"$(nproc)" ARCH=arm64 LLVM=1 {def,repro.}config net/xfrm/xfrm_user.o
  In file included from net/xfrm/xfrm_user.c:14:
  In file included from include/linux/compat.h:10:
  In file included from include/linux/time.h:60:
  In file included from include/linux/time32.h:13:
  In file included from include/linux/timex.h:67:
  In file included from arch/arm64/include/asm/timex.h:8:
  In file included from arch/arm64/include/asm/arch_timer.h:12:
  In file included from arch/arm64/include/asm/hwcap.h:9:
  In file included from arch/arm64/include/asm/cpufeature.h:27:
  In file included from include/linux/cpumask.h:13:
  In file included from include/linux/bitmap.h:13:
  In file included from include/linux/string.h:371:
  include/linux/fortify-string.h:462:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
    462 |                         __write_overflow_field(p_size_field, size);
        |                         ^
  1 warning generated.

Unfortunately, I have no idea why it is complaining nor why your patch
resolves it but the combination of FORTIFY_SOURCE and KASAN certainly
seems like a reasonable place to start looking. I will see if I can come
up with a smaller reproducer to see if it becomes more obvious why this
code triggers this warning.

Cheers,
Nathan

