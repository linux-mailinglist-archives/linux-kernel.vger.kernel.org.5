Return-Path: <linux-kernel+bounces-63032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D36385298A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FF81F23555
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE1F1755C;
	Tue, 13 Feb 2024 07:03:00 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADDE1754E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707807779; cv=none; b=GJUhU62fL6fXnWWVehFLR8XMG9enoEEUPPOLDmbbDfg66PcArTNobGbgbVbpcIXioumQ43LaAiiF2F4La3X36bZG5gvJ7PcDi5iNuC1skApfysmkWhjluP2NqRW8Wm1cRigtKzqFJfC0g1DMh4GQwPN9xfm+TFpTql7z64eu3aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707807779; c=relaxed/simple;
	bh=/a3P/GhqLx0rDmCoRZFonH8ikP/rBut5hIB1oTEVRSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkltcbvFvdAMlhbRwwkJMq0OlSwjJ+QJWuo8l5or1GceRibJtELjMObbj9I71FqlTZPMxiUf9nK0TGljFqiHYunRwBjUwGU9EuWxzyf9T8ApnIrl6z4w/O/+RVlggswdAYNuoFeNhO26ie4UeteFbLwLeCsGXsD1aiSYen0l7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 41D72h3G009724;
	Tue, 13 Feb 2024 08:02:43 +0100
Date: Tue, 13 Feb 2024 08:02:43 +0100
From: Willy Tarreau <w@1wt.eu>
To: Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] tools/nolibc: Fix strlcat() return code and size
 usage
Message-ID: <20240213070243.GB9530@1wt.eu>
References: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
 <20240129141516.198636-3-rodrigo@sdfg.com.ar>
 <20240211104817.GA19364@1wt.eu>
 <52c52665-35f5-4111-a9d4-f8669c79bf70@sdfg.com.ar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52c52665-35f5-4111-a9d4-f8669c79bf70@sdfg.com.ar>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Rodrigo,

On Tue, Feb 13, 2024 at 12:16:06AM +0100, Rodrigo Campos wrote:
> On 2/11/24 11:48, Willy Tarreau wrote:
> > Hi Rodrigo,
> > 
> > first, thanks for the series!
> 
> Thank you, for your time and review! :)

You're welcome. I'm sorry I couldn't respond earlier.

> > On Mon, Jan 29, 2024 at 03:15:14PM +0100, Rodrigo Campos wrote:
> > > The return code should always be strlen(src) + strlen(dst), but dst is
> > > considered shorter if size is less than strlen(dst).
> > > 
> > > While we are there, make sure to copy at most size-1 bytes and
> > > null-terminate the dst buffer.
> > > 
> > > Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> > > ---
> > >   tools/include/nolibc/string.h | 14 +++++++-------
> > >   1 file changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
> > > index ed15c22b1b2a..b2149e1342a8 100644
> > > --- a/tools/include/nolibc/string.h
> > > +++ b/tools/include/nolibc/string.h
> > > @@ -187,23 +187,23 @@ char *strndup(const char *str, size_t maxlen)
> > >   static __attribute__((unused))
> > >   size_t strlcat(char *dst, const char *src, size_t size)
> > >   {
> > > -	size_t len;
> > >   	char c;
> > > +	size_t len = strlen(dst);
> > > +	size_t ret = strlen(src) + (size < len? size: len);
> > 
> >  From what I'm reading in the man page, ret should *always* be the sum
> > of the two string lengths. I guess it helps for reallocation. It's even
> > explicitly mentioned:
> > 
> >    "While this may seem somewhat confusing, it was done to make truncation
> >     detection simple."
> 
> Yes, that was my *first* understanding of the manpage too. But it doesn't
> seem to be the correct interpretation.
> 
> Also, this is exactly what I tried to say in the cover letter, with:
> 
> 	I thought the manpage was clear, but when checking against that,
> 	I noted a few twists (like the manpage says the return code of
> 	strlcat is strlen(src) + strlen(dst), but it was not clear it is
> 	not that if size < strlen(dst). When looking at the libbsd
> 	implementation and re-reading the manpage, I understood what it
> 	really meant).
> 
> 
> Sorry if I wasn't clear. Let me try again.
> 
> My first interpretation of the manpage was also that, and I think it would
> make sense to be that one. However, it is wrong, they also say this, that is
> what made me add the ternary operator:
> 
> 	Note, however, that if strlcat() traverses size characters
> 	without finding a NUL, the length of the string is considered
> 	to be  size and the destination string will not be NUL
> 	terminated (since there was no space for the NUL)
> 
> So, my interpretation is that it is the sum of both, except when we can't
> find the NUL in that size, in which case we conside "size" to be the len of
> dst.

I've read it as well and I don't interpret it the same way. I'm reading it
as "if dst doesn't contain a NUL char before size, its length is considered
to be size", and the reason is explicitly explained just after:

   This keeps strlcat() from running off the end of a string. In practice
   this should not happen (as it means that either size is incorrect or
   that dst is not a proper ``C'' string).

So this explicitly means that supporting this specific use case is by
definition incompatible with the use of strlen(). Thus it's a matter
of choice for us, either we explicitly want to support invalid strings
in the destination and we need the check but we're not allowed to use
strlen() on dst, or we're not interested in such bogus cases and we can
stick to strlen() and the test is not needed. But the test combined with
strlen() is not logical.

> If you compare it with the output of libbsd, the return code seems to be
> exactly that. I was surprised too, as the manpage seem so clear... :-/

I trust you since I have not tried. I understand the rationale, i.e. still
being able to realloc() the new string, except that the caller must be
extremely prudent here since there's no way for it to know that it faces
a non-terminated string and that it must resort to a special code path
that relies on two strlcpy() instead of strlcat().

> > Above ret will be bound to the existing size so a realloc wouldn't work.
> > Thus I think the correct solution is:
> 
> Note that this implementation fails the tests added on patch 4. I've tested
> them (output and return code) to match the libbsd implementation.

OK.

> > The test inside the loop is going to make this not very efficient. Same
> > for the fact that we're measuring the length of src twice (once via
> > strlen, a second time through the loop). I've just had a look and it
> > compiles to 77 bytes at -Os. A simpler variant would consist in trying
> 
> How are you measuring the size?
> 
> I've added noinline to strlcat to the version I sent, so now it is shown in
> nm, but I have this as output:
> 
> $ nm --size -t x test.o
> 	0000000000000004 V errno
> 	0000000000000006 t strlcat.constprop.0
> 	0000000000000008 V _auxv
> 	0000000000000008 V environ
> 	000000000000000e W strlen
> 	000000000000000f W _start
> 	0000000000000018 W raise
> 	000000000000001b W abort
> 	000000000000004c T main
> 	000000000000005a t u64toa_r.isra.0
> 	0000000000000095 W _start_c
> 	00000000000002a8 t printf
> 
> How are you measuring it there?
> 
> Sorry, I'm not familiar with this :)

Oh, sorry for not providing the detalis! I just remove "static" in front
of the function. The reason for this is that if the function is used only
once in a program, and it is inlined, you never know in practice how it
will be inlined, depending on the opportunities the compiler will face
in the calling function. However, when it compiles it into its own
function, you get a better picture at the emitted code.

A second option, that's sometimes more convenient when you're hacking
directly in the include files themselves, is to write wrappers around
these functions and look at them. For example:

  $ cd tools/testing/selftests/nolibc/
  $ printf "size_t test_strlcat(char *dst, const char *src, size_t size) { return strlcat(dst, src, size); }\n" | gcc-9.5 -xc -c -Os -I sysroot/x86/include -include nolibc.h - -o test.o
  $ nm --size test.o
  0000000000000004 V errno
  0000000000000008 V _auxv
  0000000000000008 V environ
  000000000000000f W _start
  0000000000000018 W raise
  000000000000001b W abort
  0000000000000025 T test_strlcat
  000000000000008d W _start_c
  $ objdump --disassemble=test_strlcat test.o
  ...

I can't say I'm having a preference, it depends how I'm proceeding.
When comparing multiple variants of a same function, I generally like
to just copy them into a new file under different names so that I can
compare them all at once.

> > to copy what fits in <size> and once reached, go on just for trailing
> > zero and the size measurement:
> > 
> > size_t strlcat(char *dst, const char *src, size_t size)
> > {
> >          size_t len = strlen(dst);
> 
> The thing is, we need to return always at least strlen(src). Maybe plus
> something else. Even if size==0 and we don't copy anything.

Yes, but that's exactly what the function does, look at the end:

        while (*src++)
                len++;

        return len;

> Maybe we can special case that, so we simplify the loop, and it's smaller?

As a general rule, to keep code small it's best to avoid special cases
and to make them part of the general case as much as possible. And if
some special cases need to be made, as much as possible we need to
arrange them around existing jump or return points, i.e. preferably
just before a return statement that uses a value that was already
computed, or sometimes around a break or continue in a loop, but
conditions inside loops should be avoided as much as possible because
compilers often maintain multiple indexes inside loops (e.g. both target
pointer and a counter), while conditions also tend to consume registers
that force the compiler to perform some permutations to keep all of its
variables available, the worst being calling functions from loops since
the ABI indicates that a number of registers are clobbered and need to
be saved and restored. But these are essentially hints and need to be
verified on a case-by-case basis. Similarly, some architectures provide
convenient addressing mechanisms such as a=b[c+d] that we have on x86
and not necessarily elsewhere, and which favors the usage of offsets
instead of pointers. But again it depends on a lot of variables.

> I've been playing, but as I can't measure the size, I'm not sure what is
> really better. I'd like to play a little once I know how to measure it :)

Be careful not to spend too much time on it, nm --size and objdump are
quickly addictive ;-)

Willy

