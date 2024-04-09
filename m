Return-Path: <linux-kernel+bounces-137700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E31A89E628
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C380B22DA2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE98C1591E9;
	Tue,  9 Apr 2024 23:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWVzFkgl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D101158D6E;
	Tue,  9 Apr 2024 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705813; cv=none; b=s2XeuX3xIpEWXkSIicR4RpfXFdMdUMKZXGYTzB5U4ZkmeKIu5DVzWo5QuU8fOijVNG2RhMQ/dYBwByQekgJPKm7OMEm4GuZWyzFIftZvpAyLoUL+2Y0WvObKo8c4CJ/ztuz2Q8SMCabsSa4xqiI3ORan+pDaouNKtz+QtMDvz0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705813; c=relaxed/simple;
	bh=hA2wWyk7zfJrrACYbKi2zhdNeTSkqeqGy0UHG741Q8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dzv28hh1HsYtE/iQqxrEvsWJIajdeMx2HXfd5Km3ERokayGMj+BI74sR5RdyjwuBVAtNQjQRo/c7WAdLCgHkqn2aUJZe+mwNCMov++kGB/dvyEzeB7TP4HyPp+W9xlUTKfQCyoFh4JBtumAhBxaWJgzaeNKTmJv4tYKipKqB/qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWVzFkgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300F3C433F1;
	Tue,  9 Apr 2024 23:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712705812;
	bh=hA2wWyk7zfJrrACYbKi2zhdNeTSkqeqGy0UHG741Q8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JWVzFkglFzfP/c3ERcovhr2V/wFFIoIoa+/1Z6mrmGLq3ovzRgxZ+IeKClflbpjvi
	 iL6/PWfzgk14UMJoQ2MTsGBKLsRU2DLVln84moNtcMTeBootGQKt89DaJYmjo8BrJ8
	 lqSqFj1LIIfJANq6SiD9q8c81w7ZBqftFZ1o8yC2JVDZaD75FTwUwrWnfveN7SF0I1
	 yq7xkjarHWjCwO0+46qZuzmgghsx9tbXdqPJH2+xxv/Po+uN75wXu6aA5D8cuVMtdu
	 DAbkOX1FA0u4y5hhg3BmZoXXKYNhwsTQdbnfJ5+/gasZPaBaa3eABg6Q6GNl62uEg4
	 M+87GOqG2nDKA==
Date: Tue, 9 Apr 2024 19:36:50 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Stefan Kanthak <stefan.kanthak@nexgo.de>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	ardb@kernel.org
Subject: Re: [PATCH 1/2] crypto: x86/sha256-ni - convert to use rounds macros
Message-ID: <20240409233650.GA1609@quark.localdomain>
References: <20240409124216.9261-1-ebiggers@kernel.org>
 <20240409124216.9261-2-ebiggers@kernel.org>
 <C0FA88ECA90F43B1BF9E7849C53440D7@H270>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C0FA88ECA90F43B1BF9E7849C53440D7@H270>

On Tue, Apr 09, 2024 at 06:52:02PM +0200, Stefan Kanthak wrote:
> "Eric Biggers" <ebiggers@kernel.org> wrote:
> 
> > +.macro do_4rounds i, m0, m1, m2, m3
> > +.if \i < 16
> > +        movdqu  \i*4(DATA_PTR), MSG
> > +        pshufb  SHUF_MASK, MSG
> > +        movdqa  MSG, \m0
> > +.else
> > +        movdqa  \m0, MSG
> > +.endif
> > +        paddd   \i*4(SHA256CONSTANTS), MSG
> 
> To load the round constant independent from and parallel to the previous
> instructions which use \m0 I recommend to change the first lines of the
> do_4rounds macro as follows (this might save 1+ cycle per macro invocation,
> and most obviously 2 lines):
> 
> .macro do_4rounds i, m0, m1, m2, m3
> .if \i < 16
>         movdqu  \i*4(DATA_PTR), \m0
>         pshufb  SHUF_MASK, \m0
> .endif
>         movdqa  \i*4(SHA256CONSTANTS), MSG
>         paddd   \m0, MSG
> ...

Yes, your suggestion looks good.  I don't see any performance difference on
Ice Lake, but it does shorten the source code.  It belongs in a separate patch
though, since this patch isn't meant to change the output.

- Eric

