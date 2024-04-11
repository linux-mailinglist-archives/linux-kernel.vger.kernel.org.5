Return-Path: <linux-kernel+bounces-141305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF2E8A1C98
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13D3AB309FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638A215FA87;
	Thu, 11 Apr 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1Ydj4WO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D915FA69;
	Thu, 11 Apr 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852217; cv=none; b=LLTN1L9C9NpvDpplczY9SzHKUfFEX9YuXUlo8H5VeaLhmELDZWhg4rwpua/fcLW3AhUnxkkr4tdhf7qfYpX0kgrc08CZjbAO1VR3HbiDAjB8zg4KKmvQxWPv0w7qwEPA7gxMTgV6wqrtwZroRqmMhfPI75iox4NZMdmlZ0yrvmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852217; c=relaxed/simple;
	bh=oxB2IinreaN+GlXA7UgrWU6a+FGBjajYG4vubHueojQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZklVwRB6VETAcBlkKMqDR6EKh5Oyz73V87oeJofSAbrMsJcsJfTmRLF6ftUcxxKVSX0Axr6H2AmwUTB0roLhnZDDQl+Ti6mychhV6H6ihW/7cj45D+hbD014xWrEXIPAw4O21mdelBkkXwQ+wJKE2aEYKnhWKDCeEQ7wm0Mcb7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1Ydj4WO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8B4C072AA;
	Thu, 11 Apr 2024 16:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852217;
	bh=oxB2IinreaN+GlXA7UgrWU6a+FGBjajYG4vubHueojQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s1Ydj4WOYaJ5p5COnprJBHKI3qO0ZBy8B05ZBo4YiZOiXke0h6NZXRe1hYep8EMUO
	 7IjZGcAb0oxZSi1KvHIEsppYJHW+rnhKdtzit7WinR63u+yMlu0vg/iVOluLI1Gvo7
	 dvcQJaihtIuZ8kPwuHumRftjhm5YDhVpf6JnVGapfSUXyACvOP2RwKIaPGU+JsBlOG
	 2uFNDr+L/1jrIz9Y8ev42ZYPmiF5JUYxtNaJErUtXSIHaItezqGDlf1nk7TEmbUxQJ
	 1JJ3JXl1ePNmbjKhieT4Wu062CehbJz1MdUhImtJM6WiKYI2oWGqeCE0rA1D52p8VK
	 yOItmbxK8vxsA==
Date: Thu, 11 Apr 2024 09:16:55 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Stefan Kanthak <stefan.kanthak@nexgo.de>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	ardb@kernel.org
Subject: Re: [PATCH 1/2] crypto: x86/sha256-ni - convert to use rounds macros
Message-ID: <20240411161655.GA9356@sol.localdomain>
References: <20240409124216.9261-1-ebiggers@kernel.org>
 <20240409124216.9261-2-ebiggers@kernel.org>
 <C0FA88ECA90F43B1BF9E7849C53440D7@H270>
 <20240409233650.GA1609@quark.localdomain>
 <450F5ED9B5834B2EA883786C32E1A30E@H270>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450F5ED9B5834B2EA883786C32E1A30E@H270>

Hi Stefan,

On Thu, Apr 11, 2024 at 09:42:00AM +0200, Stefan Kanthak wrote:
> "Eric Biggers" <ebiggers@kernel.org> wrote:
> 
> > On Tue, Apr 09, 2024 at 06:52:02PM +0200, Stefan Kanthak wrote:
> >> "Eric Biggers" <ebiggers@kernel.org> wrote:
> >> 
> >> > +.macro do_4rounds i, m0, m1, m2, m3
> >> > +.if \i < 16
> >> > +        movdqu  \i*4(DATA_PTR), MSG
> >> > +        pshufb  SHUF_MASK, MSG
> >> > +        movdqa  MSG, \m0
> >> > +.else
> >> > +        movdqa  \m0, MSG
> >> > +.endif
> >> > +        paddd   \i*4(SHA256CONSTANTS), MSG
> >> 
> >> To load the round constant independent from and parallel to the previous
> >> instructions which use \m0 I recommend to change the first lines of the
> >> do_4rounds macro as follows (this might save 1+ cycle per macro invocation,
> >> and most obviously 2 lines):
> >> 
> >> .macro do_4rounds i, m0, m1, m2, m3
> >> .if \i < 16
> >>         movdqu  \i*4(DATA_PTR), \m0
> >>         pshufb  SHUF_MASK, \m0
> >> .endif
> >>         movdqa  \i*4(SHA256CONSTANTS), MSG
> >>         paddd   \m0, MSG
> >> ...
> > 
> > Yes, your suggestion looks good.  I don't see any performance difference on
> > Ice Lake, but it does shorten the source code.  It belongs in a separate patch
> > though, since this patch isn't meant to change the output.
> 
> Hmmm... the output was already changed: 2 palignr/pblendw and 16 pshufd
> have been replaced with punpck?qdq, and 17 displacements changed.

Yes, the second patch does that.  Your comment is on the first patch, so I
thought you were suggesting changing the first patch.  I'll handle your
suggestion in another patch.  I'm just trying to keep changes to the actual
output separate from source code only cleanups.

> Next simplification, and 5 more lines gone: replace the macro do_16rounds
> with a repetition
> 
> @@ ...
> -.macro do_16rounds i
> -        do_4rounds (\i + 0),  MSGTMP0, MSGTMP1, MSGTMP2, MSGTMP3
> -        do_4rounds (\i + 4),  MSGTMP1, MSGTMP2, MSGTMP3, MSGTMP0
> -        do_4rounds (\i + 8),  MSGTMP2, MSGTMP3, MSGTMP0, MSGTMP1
> -        do_4rounds (\i + 12), MSGTMP3, MSGTMP0, MSGTMP1, MSGTMP2
> -.endm
> -
> @@ ...
> -        do_16rounds 0
> -        do_16rounds 16
> -        do_16rounds 32
> -        do_16rounds 48
> +.irp i, 0, 16, 32, 48
> +        do_4rounds (\i + 0),  MSGTMP0, MSGTMP1, MSGTMP2, MSGTMP3
> +        do_4rounds (\i + 4),  MSGTMP1, MSGTMP2, MSGTMP3, MSGTMP0
> +        do_4rounds (\i + 8),  MSGTMP2, MSGTMP3, MSGTMP0, MSGTMP1
> +        do_4rounds (\i + 12), MSGTMP3, MSGTMP0, MSGTMP1, MSGTMP2
> +.endr
> 
> This doesn't change the instructions generated, so it belongs to this patch.

Yes, that makes sense.

> The following suggestion changes instructions: AFAIK all processors which
> support the SHA extensions support AVX too

No (unfortunately).  Several generations of Intel's low-power CPUs support SHA
but not AVX.  Namely Goldmont, Goldmont Plus, and Tremont.

We could provide two SHA-256 implementations, one with AVX and one without.  I
think it's not worthwhile, though.

We ran into this issue with AES-NI too; I was hoping that we could just provide
the new AES-NI + AVX implementation of AES-XTS, and remove the older
implementation that uses AES-NI alone.  However, apparently the above-mentioned
low-power CPUs do need the implementation that uses AES-NI alone.

> And last: are the "#define ... %xmm?" really necessary?
> 
> - MSG can't be anything but %xmm0;
> - MSGTMP4 is despite its prefix MSG also used to shuffle STATE0 and STATE1,
>   so it should be named TMP instead (if kept);
> - MSGTMP0 to MSGTMP3 are the circular message schedule, they should be named
>   MSG0 to MSG3 instead (if kept).
> 
> I suggest to remove at least those which are now encapsulated in the macro
> and the repetition.

Yes, I noticed the weird naming too.  I'll rename MSGTMP[0-3] to MSG[0-3], and
MSGTMP4 to TMP.

You're correct that MSG has to be xmm0 because of how sha256rnds2 uses xmm0 as
an implicit operand.  I think I'll leave the '#define' for MSG anyway because
the list of aliases helps make it clear what each register is used for.

Thanks,

- Eric

