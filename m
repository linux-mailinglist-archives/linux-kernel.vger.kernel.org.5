Return-Path: <linux-kernel+bounces-145927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F708A5CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 508FAB2162B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E18156969;
	Mon, 15 Apr 2024 21:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh2NWqXU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59F156960;
	Mon, 15 Apr 2024 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713216084; cv=none; b=HIB0NwvX0bauJjVVT9CeZtjgA5fIHmRQ+LJAMYDFucq3S25Wlx2zaYucsFlwn/XPLiHMKQ53tgzXSEqk6NsP/E7Q+l+DEGJgramFmFLZnkjRJ69iaN+rnBrQjWkTIqfdE+8R/TwwzUNWfMJa4vJcX1yRUZV2b0Pxc+sGxaV9OsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713216084; c=relaxed/simple;
	bh=GmW+UECxL2DLLcfHpk00erlt7Iyqya2qrKbwvHIfovM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOjLOl5zK/sGSAS0whNAPmi9tkgN5+DQg1DkXxwSJilRIpg4wo8ADKhmxPiyF85u1lA4HWwBvQ5t5BeHsfp/72j5hKT2pnBXl2nv0YxMdCv9GIIRHzZy8byUvd1YcNW5t1k9bCQSJLaH3cOND3P3fFjqWzwunip6wvYVX5ziQr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh2NWqXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C1AC113CC;
	Mon, 15 Apr 2024 21:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713216083;
	bh=GmW+UECxL2DLLcfHpk00erlt7Iyqya2qrKbwvHIfovM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eh2NWqXUfgiLT8ToWxvKvazqN+oC6EEHDHc7/A9+pvspFqXiKnMdgzRETs3avKJZx
	 I3u7f+rW+uKpGkDSe0M9ZkEKEjJ9TQe8RaxbeoIkEWXiRKxXOJQg6pY5Ss+L4uqhur
	 NVKmo8v1IAh3QgJPfCPgnip6XRfNVv86CnuCnRZgFh9CWHMsEE9TomysMMhhWBBdUX
	 nFgTy8qR51vA5z+GyN6rABN/Lc7leJ7bXmEtNqNmfKcBiQXOdVRmvPWw56r5Drj918
	 5xh8BTvCXGPr+qFYFXX50WCmtjdTDaxhnKOFOE5qodnPN0bXyV1PGRqQVr0zbw/1vR
	 OL4qRxfyi0tRQ==
Date: Mon, 15 Apr 2024 14:21:21 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Stefan Kanthak <stefan.kanthak@nexgo.de>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] crypto: x86/sha256-ni - simplify do_4rounds
Message-ID: <20240415212121.GA5206@sol.localdomain>
References: <20240411162359.39073-1-ebiggers@kernel.org>
 <20240411162359.39073-5-ebiggers@kernel.org>
 <2ECD48ACEA9540C083E6B797CFD18027@H270>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ECD48ACEA9540C083E6B797CFD18027@H270>

On Mon, Apr 15, 2024 at 10:41:07PM +0200, Stefan Kanthak wrote:
> "Eric Biggers" <ebiggers@kernel.org> wrote:
> 
> > Instead of loading the message words into both MSG and \m0 and then
> > adding the round constants to MSG, load the message words into \m0 and
> > the round constants into MSG and then add \m0 to MSG.  This shortens the
> > source code slightly.  It changes the instructions slightly, but it
> > doesn't affect binary code size and doesn't seem to affect performance.
> 
> At last the final change: write the macro straightforward and SIMPLE,
> closely matching NIST.FIPS.180-4.pdf and their order of operations.
> 
> @@ ...
> +.macro  sha256  m0 :req, m1 :req, m2 :req, m3 :req
> +.if \@ < 4
> +        movdqu  \@*16(DATA_PTR), \m0
> +        pshufb  SHUF_MASK, \m0          # \m0 = {w(\@*16), w(\@*16+1), w(\@*16+2), w(\@*16+3)}
> +.else
> +                                        # \m0 = {w(\@*16-16), w(\@*16-15), w(\@*16-14), w(\@*16-13)}
> +                                        # \m1 = {w(\@*16-12), w(\@*16-11), w(\@*16-10), w(\@*16-9)}
> +                                        # \m2 = {w(\@*16-8),  w(\@*16-7),  w(\@*16-6),  w(\@*16-5)}
> +                                        # \m3 = {w(\@*16-4),  w(\@*16-3),  w(\@*16-2),  w(\@*16-1)}
> +        sha256msg1 \m1, \m0
> +        movdqa     \m3, TMP
> +        palignr    $4, \m2, TMP
> +        paddd      TMP, \m0
> +        sha256msg2 \m3, \m0             # \m0 = {w(\@*16), w(\@*16+1), w(\@*16+2), w(\@*16+3)}
> +.endif
> +        movdqa      (\@-8)*16(SHA256CONSTANTS), MSG
> +        paddd       \m0, MSG
> +        sha256rnds2 STATE0, STATE1      # STATE1 = {f', e', b', a'}
> +        punpckhqdq  MSG, MSG
> +        sha256rnds2 STATE1, STATE0      # STATE0 = {f", e", b", a"},
> +                                        # STATE1 = {h", g", d", c"}
> +.endm
> 
> JFTR: you may simplify this further using .altmacro and generate \m0 to \m3
>       as MSG%(4-\@&3), MSG%(5-\@&3), MSG%(6-\@&3) and MSG%(7-\@&3) within
>       the macro, thus getting rid of its 4 arguments.
> 
> @@ ...
> +.rept 4                                 # 4*4*4 rounds
> +        sha256  MSG0, MSG1, MSG2, MSG3
> +        sha256  MSG1, MSG2, MSG3, MSG0
> +        sha256  MSG2, MSG3, MSG0, MSG1
> +        sha256  MSG3, MSG0, MSG1, MSG2
> +.endr

Could you please send a real patch, following
Documentation/process/submitting-patches.rst?  It's hard to understand what
you're proposing here.

> Now that all code written by Tim Chen and Sean Gulley is gone,
> remove their copyright notice and insert your and my name instead.

Well, their code has been cleaned up.  We have to keep copyright notices around
unless we're certain they can go.

> 
> regards
> Stefan
> 
> PS: see <https://skanthak.homepage.t-online.de/fips-180.html>
>     (which I still polish) not just for this implementation.
> 
> PPS: if MASM had a counter like \@, I'd used it there.

Thanks,

- Eric

