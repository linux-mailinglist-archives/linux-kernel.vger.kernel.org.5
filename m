Return-Path: <linux-kernel+bounces-41317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711A783EEBA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2913D2846D1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5582E5A79D;
	Sat, 27 Jan 2024 16:34:17 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE305A78A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706373256; cv=none; b=uqRQZ4ZAmXQKQ1bmga8T/7ioBYuv6ZbARZD6n57durMyfpEUNjEh6+bpcxfM7AOMOy4mMP/Z0e2TT260Ax6w6opXtBxhMsCRf8VMKX95582AQZ9BysCgO+Kw3cJxU17NdDoMgy4uDLypcq6o6B8f3cJMvAimYcO4QVBOAPZu7Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706373256; c=relaxed/simple;
	bh=wJADJvLZue8yr22f+aPkZezJA08hOu6ptWGYj6x7LUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wie9eHFgNt2cN9zDbhQsDHUe2o11kQzKP2NB3PUKZlTr/BVGk6M7y7Ls50Yam5305tuyks85ETIIx2hw27ZNBC6dxGAKUY5sY+A7X981GtCgcNmwLiYVlM2jgOxr5SL1sOAkcRndd7iHPIfuleKxGx0rWyBIUXDRuApCX53kcoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 40RGO0KR014271;
	Sat, 27 Jan 2024 17:24:00 +0100
Date: Sat, 27 Jan 2024 17:24:00 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Rodrigo Campos <rodrigo@sdfg.com.ar>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] tools/nolibc/string: export strlen()
Message-ID: <20240127162400.GA14079@1wt.eu>
References: <20240126142411.22972-1-rodrigo@sdfg.com.ar>
 <9abed5e3-cd61-474e-bb16-13243709f5c5@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9abed5e3-cd61-474e-bb16-13243709f5c5@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi!

On Sat, Jan 27, 2024 at 03:53:32PM +0100, Thomas Weißschuh wrote:
> Hi!
> 
> On 2024-01-26 15:24:10+0100, Rodrigo Campos wrote:
> > Hi, while using nolibc on debian testing, I found that compilation fails when using strlcat().
> > 
> > The compilation fails with:
> > 
> >             cc -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib -lgcc  -static -o test test.c
> >             /usr/bin/ld: /tmp/cccIasKL.o: in function `main':
> >             test.c:(.text.startup+0x1e): undefined reference to `strlen'
> >             collect2: error: ld returned 1 exit status
> > 
> > This is using debian testing, with gcc 13.2.0.
> 
> I can reproduce the issue with gcc 13.2.1 on Arch.
> 
> > A small repro case that fails with this error on debian is:
> > 
> > 	int main(void) {
> > 		char dst[6] = "12";
> > 		char *src = "abc";
> > 		strlcat(dst, src, 6);
> > 	
> > 		printf("dst is: %s\n", dst);
> > 	
> > 		return 0;
> > 	}
> > 
> > Please note that this code is not using strlen() and strlcat() doesn't seems to use it either.
> 
> I think the comment in strlen() explains it:
> 
>     Note that gcc12 recognizes an strlen() pattern and replaces it with a
>     jump to strlen().
> 
> strlcat() indeed contains this pattern.
> 
> I was able to fix the issue by replacing the open-coded strlen() in
> strlcat() with a call to the function and that also fixed the issue.
> 
> It seems nicer to me as a fix, on the other hand the change to a weak
> definition will also catch other instances of the issue.
> Maybe we do both.

Yes, once we have the proof that the compiler may produce such a call, it
can also happen in whatever user code so we need to export the function,
there's no other solution.

> > First I noted that removing the attribute unused in strlen(), the compilation worked fine. And then
> > I noticied that other functions had the attribute weak, a custom section and export the function.
> > 
> > In particular, what happens here seems to be the same as in commit "tools/nolibc/string: export memset() and
> > memmove()" (8d304a374023), as removing the -Os or adding the -ffreestanding seem to fix the issue.
> > So, I did the same as that commit, for strlen().
> > 
> > However, I'm not 100% confident on how to check that this is done by the compiler to later replace
> > it and provide a builtin. I'm not sure how that was verified for commit 8d304a374023, but if you let
> > me know, I can verify it too.
> > 
> > What do you think?
> 
> Personally I don't know how it was verified, we'll have to wait for
> Willy on that.

Oh it's very simple, just build a small code that doesn't contain any
such explicit nor implicit call and check that it doesn't contain the
function.

E.g.:

  $ printf "int main(void) { }\n" | gcc -nostdlib -static -Isysroot/x86/include -include nolibc.h -Os -Wl,--gc-sections -xc -
  $ nm --size a.out 
  0000000000000003 T main
  0000000000000004 V errno
  0000000000000008 V _auxv
  0000000000000008 V environ
  000000000000000f W _start
  0000000000000042 W _start_c

and:

  $ printf "int main(void) { return (long)&strlen;}\n" | gcc -nostdlib -static -Isysroot/x86/include -include nolibc.h -Os -Wl,--gc-sections -xc -
  $ nm --size a.out 
  0000000000000004 V errno
  0000000000000006 T main
  0000000000000008 V _auxv
  0000000000000008 V environ
  000000000000000e t strlen
  000000000000000f W _start
  0000000000000042 W _start_c

> > As a side note, it seems strlcat()/strlcpy() fail to set the terminating null byte on some cases,

Indeed I've just checked and you're right, that defeats their purpose!

> > and the return code is not always the same as when using libbsd. It seems to be only on "error"
> > cases, and not sure if it's worth fixing all/some of those cases.

OK.

> > Let me know if you think it is worth adding some _simple_ patches (I don't think it is worth fixing
> > all the cases, the code is to fix all of the cases is probably not nice and not worth it).
> 
> Souns reasonable to me to fix the return values.
> And get some tests for it.

Seconded!

Thanks!
Willy

