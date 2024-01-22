Return-Path: <linux-kernel+bounces-34278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6B5837753
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5CD1C25378
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EADB38DC6;
	Mon, 22 Jan 2024 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRX8TthZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D4A381DB;
	Mon, 22 Jan 2024 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964577; cv=none; b=ExAZudXeSDmUAwZxSia9LFTpTXrGatdvq1khddDSwzvBc9GEAX7/SlZ9oJ3pLdMAEm+4Lx6yD+1KYP88Wy/tFIT8AHwg6l/vBw31MqWJv98XpY6Gnh8xOyqRDX+vQIetRMUQ14v3FOw0l9nAzU6ar0Jz06QPw29cYrg2gvYgSXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964577; c=relaxed/simple;
	bh=5f0TvwGjdk7WXeg6BeQeByM891O4z1o6LGJ+66Aju6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfROFLOPwN9lpPibZHeaVXA/+SJnbPESyh8UA3aRNlzDFvPlbjCoGLNiJOhe2d+33Kxju3vps7IVspouq0KlGWEK4OPkiHObBQ0OtKexa35rKFKwcBPF1u2vEHntOwI67xO12fDPcjymBB4aQUeJPNjs3VahCwBq6Ael/AWG2NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRX8TthZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C745BC43390;
	Mon, 22 Jan 2024 23:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705964577;
	bh=5f0TvwGjdk7WXeg6BeQeByM891O4z1o6LGJ+66Aju6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRX8TthZlj3aDisktVHgkXiP6G7cCfwFBA9MwRx2XwHZpSqwSH5cDgLkmPz3218DI
	 Iuxx5g4m6n4iVIsdilCBQdsurC1K8fKyDxouEEzrgxUvxZ/4DHhE3TQ2dpx3pUCYXy
	 lxOl94ziInVJ6XxA9FNDjFlv11vqjPvI9XNzYzq733RlRhsxTWg58W4377ELSVP2Pt
	 Ie3CPCjYof6TabLmFLr1bTsws8VGDgYbnj8rvmxOVajc2zqcau/sjAcBrfuWLNQAIN
	 2JyK31XW53Aud8EXdJptKfrPoodlDPEXn+COFCBPLrhr+NpFxlMmfC4FVot90qTF4O
	 X/NJfKr2PhkqA==
Date: Mon, 22 Jan 2024 16:02:55 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Aiden Leong <aiden.leong@aibsd.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, ndesaulniers@google.com,
	nicolas@fjasle.eu, clang-built-linux <llvm@lists.linux.dev>,
	=?utf-8?B?Ru+/ve+/ve+/vW5nLXJ177+977+977+9IFPvv73vv73vv71uZw==?= <maskray@google.com>
Subject: Re: [PATCH v2 2/4] modpost: inform compilers that fatal() never
 returns
Message-ID: <20240122230255.GD141255@dev-fedora.aadp>
References: <d9ac2960-6644-4a87-b5e4-4bfb6e0364a8@aibsd.com>
 <CAK7LNATDD2gC53T5n7vCUH6O6mdAm801fTWyKi9fji+5Kb+0ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATDD2gC53T5n7vCUH6O6mdAm801fTWyKi9fji+5Kb+0ng@mail.gmail.com>

On Mon, Jan 22, 2024 at 10:29:32PM +0900, Masahiro Yamada wrote:
> +CC: clang-built-linux list, Fangrui
> 
> On Mon, Jan 22, 2024 at 1:04 PM Aiden Leong <aiden.leong@aibsd.com> wrote:
> >
> >
> >  > The function fatal() never returns because modpost_log() calls exit(1)
> >
> >  > when LOG_FATAL is passed.
> >  >
> >  > Inform compilers of this fact so that unreachable code flow can be
> >  > identified at compile time.
> >  >
> >  > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >  > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> >  > ---
> >  >
> >  > Changes in v2:
> >  >   - Use noreturn attribute together with alias
> >  >
> >  >  scripts/mod/modpost.c | 3 +++
> >  >  scripts/mod/modpost.h | 5 ++++-
> >  >  2 files changed, 7 insertions(+), 1 deletion(-)
> >  >
> >  > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> >  > index ca0a90158f85..c13bc9095df3 100644
> >  > --- a/scripts/mod/modpost.c
> >  > +++ b/scripts/mod/modpost.c
> >  > @@ -90,6 +90,9 @@ void modpost_log(enum loglevel loglevel, const char
> > *fmt, ...)
> >  >          error_occurred = true;
> >  >  }
> >  >
> >  > +void __attribute__((alias("modpost_log")))
> >
> > Hi Masahiro,
> > I cross-compile kernel on Apple Silicon MacBook Pro
> > and every thing works well until this patch.
> >
> > My build command:
> > make ARCH=arm CROSS_COMPILE=arm-none-eabi- \
> > HOSTCFLAGS="-I/opt/homebrew/opt/openssl/include" \
> > HOSTLDFLAGS="-L/opt/homebrew/opt/openssl/lib"
> >
> > Error message:
> > scripts/mod/modpost.c:93:21: error: aliases are not supported on darwin
> 
> 
> It is unfortunate.  Indeed, I see this message in:
> 
> clang/include/clang/Basic/DiagnosticSemaKinds.td
> 
> 
> Is this limitation due to macOS executable (PEF),
> or is it Clang-specific?

Based on my admittedly brief research, this seems related to the Mach-O
format. That message was added by [1] in response to [2] but the message
mentioned weak aliases being supported. A further clarification was made
in [3] to state that all aliases are unsupported as a result of some
internal Apple bug it seems but I do see a couple of bug reports stating
that may not be true [4][5] (although that does not seem relevant for
this report).

[1]: https://github.com/llvm/llvm-project/commit/0017c5fa92ad3b10e15fd34f3865e8e5b850a5ed
[2]: https://llvm.org/bz8720
[3]: https://github.com/llvm/llvm-project/commit/4e30b96834cea5682a8e9e024dda06319825000a
[4]: https://github.com/llvm/llvm-project/issues/11488
[5]: https://github.com/llvm/llvm-project/issues/71001

Cheers,
Nathan

