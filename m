Return-Path: <linux-kernel+bounces-145977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCAB8A5DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CF81C21121
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB151581FE;
	Mon, 15 Apr 2024 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FniSMvHY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC00B156225;
	Mon, 15 Apr 2024 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713221193; cv=none; b=DSGZX4mSw+4oYQev62zB/q8P/Vx8+KzAkaVQAj+KkfvR9Dp6w+WmFDypYXKCzji5nysKJven8Are2JNwOTA2IArAVdIJYDVILG9/0IOwZbTjPnju1qXKu+ptfp0Dc9/ROqrz1LSRRDc7LeNfEy9aR7Wm7JB+mfHGDya004MtOYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713221193; c=relaxed/simple;
	bh=CUDoHqW/SodLI3NlqkpBmXp7dZ2wMZ3arGRmHuXeJ98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kchFqsU98sgVjYmo39cIgFJANycJ7GEB0mjpil5nLexAy4tgQr0vrLoq/4DTin4rtr1TPA4Yl9N1reKkRvfDqjcvPTE/qKJf5j3HzpKRYOAzKfG+b6Tg1US7vvsGl72qPBZB/Vpd53L07mnzxPVASGedj+V58nxIgiIiNRaKK54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FniSMvHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C48C2BD11;
	Mon, 15 Apr 2024 22:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713221192;
	bh=CUDoHqW/SodLI3NlqkpBmXp7dZ2wMZ3arGRmHuXeJ98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FniSMvHYQvG1sKJwHy9qHb23jRSntAZPZaX1Yv3VSxhVv8C8P66Fb8CmctAZ5dJs1
	 +bkWbl6zrh9hZ8HrQJe0C400qGZJxkW5uJCcyST3vpCPr9V3YD5e5TSmvJDMLhDzkg
	 qg+c1pw2TWSGVOBUdNxoeWbuD6Z8ZhD+ZeE0urholQNWZ+c7bmI0qaQqO59ksGp/Mt
	 1uA4Y/9PKc1WISZt/FSpV/HVI/opkuBfhGhyX4ypZ4ZYm202ivKO1DWt3nVDCi7DIN
	 5aCGfVVg/XUr3DoXD/M+7RW33ycsf3v6np/MlIbpn8svRMA69T0gmE2ruzj+H6wgd0
	 eo9DFM7l6urgg==
Date: Mon, 15 Apr 2024 15:46:29 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Stefan Kanthak <stefan.kanthak@nexgo.de>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] crypto: x86/sha256-ni - simplify do_4rounds
Message-ID: <20240415224629.GB5206@sol.localdomain>
References: <20240411162359.39073-1-ebiggers@kernel.org>
 <20240411162359.39073-5-ebiggers@kernel.org>
 <2ECD48ACEA9540C083E6B797CFD18027@H270>
 <20240415212121.GA5206@sol.localdomain>
 <65E53E4DD09F41CDA7EBCBD970E23C23@H270>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65E53E4DD09F41CDA7EBCBD970E23C23@H270>

On Tue, Apr 16, 2024 at 12:04:56AM +0200, Stefan Kanthak wrote:
> "Eric Biggers" <ebiggers@kernel.org> wrote:
> 
> > On Mon, Apr 15, 2024 at 10:41:07PM +0200, Stefan Kanthak wrote:
> [...]
> >> At last the final change: write the macro straightforward and SIMPLE,
> >> closely matching NIST.FIPS.180-4.pdf and their order of operations.
> >> 
> >> @@ ...
> >> +.macro  sha256  m0 :req, m1 :req, m2 :req, m3 :req
> >> +.if \@ < 4
> >> +        movdqu  \@*16(DATA_PTR), \m0
> >> +        pshufb  SHUF_MASK, \m0          # \m0 = {w(\@*16), w(\@*16+1), w(\@*16+2), w(\@*16+3)}
> >> +.else
> >> +                                        # \m0 = {w(\@*16-16), w(\@*16-15), w(\@*16-14), w(\@*16-13)}
> >> +                                        # \m1 = {w(\@*16-12), w(\@*16-11), w(\@*16-10), w(\@*16-9)}
> >> +                                        # \m2 = {w(\@*16-8),  w(\@*16-7),  w(\@*16-6),  w(\@*16-5)}
> >> +                                        # \m3 = {w(\@*16-4),  w(\@*16-3),  w(\@*16-2),  w(\@*16-1)}
> >> +        sha256msg1 \m1, \m0
> >> +        movdqa     \m3, TMP
> >> +        palignr    $4, \m2, TMP
> >> +        paddd      TMP, \m0
> >> +        sha256msg2 \m3, \m0             # \m0 = {w(\@*16), w(\@*16+1), w(\@*16+2), w(\@*16+3)}
> >> +.endif
> >> +        movdqa      (\@-8)*16(SHA256CONSTANTS), MSG
> >> +        paddd       \m0, MSG
> >> +        sha256rnds2 STATE0, STATE1      # STATE1 = {f', e', b', a'}
> >> +        punpckhqdq  MSG, MSG
> >> +        sha256rnds2 STATE1, STATE0      # STATE0 = {f", e", b", a"},
> >> +                                        # STATE1 = {h", g", d", c"}
> >> +.endm
> >> 
> >> JFTR: you may simplify this further using .altmacro and generate \m0 to \m3
> >>       as MSG%(4-\@&3), MSG%(5-\@&3), MSG%(6-\@&3) and MSG%(7-\@&3) within
> >>       the macro, thus getting rid of its 4 arguments.
> >> 
> >> @@ ...
> >> +.rept 4                                 # 4*4*4 rounds
> >> +        sha256  MSG0, MSG1, MSG2, MSG3
> >> +        sha256  MSG1, MSG2, MSG3, MSG0
> >> +        sha256  MSG2, MSG3, MSG0, MSG1
> >> +        sha256  MSG3, MSG0, MSG1, MSG2
> >> +.endr
> > 
> > Could you please send a real patch, following
> > Documentation/process/submitting-patches.rst?  It's hard to understand what
> > you're proposing here.
> 
> 1) I replace your macro (which unfortunately follows Tim Chens twisted code)
>    COMPLETELY with a clean and simple implementation: message schedule first,
>    update of state variables last.
>    You don't need ".if \i >= 12 && \i < 60"/".if \i >= 4 && \i < 52" at all!

It's probably intentional that the code does the message schedule computations a
bit ahead of time.  This might improve performance by reducing the time spent
waiting for the message schedule.

It would be worth trying a few different variants on different CPUs and seeing
how they actually perform in practice, though.

> 
> 2) I replace the .irp which invokes your macro with a .rept: my macro uses \@
>    instead of an argument for the round number.
> 
> <https://sourceware.org/binutils/docs/as.html#Macro>

The \@ feature is a bit obscure and maybe is best avoided.

- Eric

