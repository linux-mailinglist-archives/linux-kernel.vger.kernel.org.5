Return-Path: <linux-kernel+bounces-155822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFEE8AF796
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8491F236AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A491422BA;
	Tue, 23 Apr 2024 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dICKS0G9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692E13E3F8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901793; cv=none; b=boF/Uxi3uNZ6yTyLft/GqVnYQjM0RnTT9fH5SIWT99nRVwRZwYMQSW6G61xR7LUTmLPX1aAUA3RL9ldze0cH/niQclskyKhuWw6GkBEnBYSf5T8bd7O5d2UhWEP8CxRlOg0IrEHdMwxG2UuTOUiAPICJvRH1VKjhPgM0SpRtIEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901793; c=relaxed/simple;
	bh=p4ePbeqG6cRJBW5GIQ6tZmdVtnpRun7EiUCLgzd+ztE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceV6uYOdIRGVmJ/f06XPemk8MlhlxVlY50wUgUFpVPnW4n0YMnnqs9M8G+G1bvTikSJ+MfzFTXiwLn2Qiz/3gjVJD3yYJBD0YgPD2sbEpEm6UgXGKRRgdsfH1Wg4gfmTbP0pZSH8Vqeu4t1tpyhyJT0SDAgZksuJdIuPFaOijwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dICKS0G9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42F7C116B1;
	Tue, 23 Apr 2024 19:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713901792;
	bh=p4ePbeqG6cRJBW5GIQ6tZmdVtnpRun7EiUCLgzd+ztE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dICKS0G9TNFTz+s+Z/ZyQBlK2fcJzcPfj2x/4ApajgXk81lpSCqxMaIE2BFXp3fRy
	 LaQ3LMzgd0Oo7eUI+aCZY4dbF6/pEGuaFZocpyePlL48DzsfJJwwUdaGBi5GZ3Z1Rd
	 yL/KMAQtBY3z3Mrj+2DGRU3xX6l7qkpsTVmO1yV+nfc7y7518H6gj+xfBOZFNf0fjB
	 iAOrzzw1Ihns7GWCIkYyxB1up3dVWrtKgIws6jDdA/Ohgb375V5Qzp/dYu5sP3H7Kn
	 jD2bnjpYs+XxrzQJx0kYsGjDTeMMK9w1L6vKOirfft14Yvoj7EwNbs01GwEOfupTN4
	 gvNh31LYLzYdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 83714CE0962; Tue, 23 Apr 2024 12:49:52 -0700 (PDT)
Date: Tue, 23 Apr 2024 12:49:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: Re: [PATCH v3 4/4] selftests/nolibc: Add tests for strlcat() and
 strlcpy()
Message-ID: <ada70a65-5a87-489f-8080-97049740bff9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240218195110.1386840-1-rodrigo@sdfg.com.ar>
 <20240218195110.1386840-5-rodrigo@sdfg.com.ar>
 <172d25cf-cfd7-4069-8c26-df2e81ffbad1@t-8ch.de>
 <Zifhr1sX5soHlXSG@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zifhr1sX5soHlXSG@1wt.eu>

On Tue, Apr 23, 2024 at 06:28:31PM +0200, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Tue, Apr 23, 2024 at 11:18:06AM +0200, Thomas Weißschuh wrote:
> > + Shuah and Paul, please see below.
> > 
> > So I picked this up and it got picked up by Shuah, but...
> > 
> > On 2024-02-18 16:51:06+0000, Rodrigo Campos wrote:
> > > I've verified that the tests matches libbsd's strlcat()/strlcpy()
> > > implementation.
> > > 
> > > Please note that as strlcat()/strlcpy() are not part of the libc, the
> > > tests are only compiled when using nolibc.
> > > 
> > > Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> > > ---
> > >  tools/testing/selftests/nolibc/nolibc-test.c | 40 ++++++++++++++++++++
> > >  1 file changed, 40 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > > index 6ba4f8275ac4..d373fc14706c 100644
> > > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > > @@ -600,6 +600,25 @@ int expect_strne(const char *expr, int llen, const char *cmp)
> > >  	return ret;
> > >  }
> > >  
> > > +#define EXPECT_STRBUFEQ(cond, expr, buf, val, cmp)				\
> > > +	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_str_buf_eq(expr, buf, val, llen, cmp); } while (0)
> > > +
> > > +static __attribute__((unused))
> > > +int expect_str_buf_eq(size_t expr, const char *buf, size_t val, int llen, const char *cmp)
> > > +{
> > > +	llen += printf(" = %lu <%s> ", expr, buf);
> > 
> > This introduces a compiler warning on 32bit:
> > 
> >     i386-linux-gcc -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra -fno-stack-protector -m32 -mstack-protector-guard=global -fstack-protector-all  -o nolibc-test \
> >       -nostdlib -nostdinc -static -Isysroot/i386/include nolibc-test.c nolibc-test-linkage.c -lgcc
> >     nolibc-test.c: In function 'expect_str_buf_eq':
> >     nolibc-test.c:610:30: error: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
> >       610 |         llen += printf(" = %lu <%s> ", expr, buf);
> >           |                            ~~^         ~~~~
> >           |                              |         |
> >           |                              |         size_t {aka unsigned int}
> >           |                              long unsigned int
> >           |                            %u
> > 
> > 
> > It is easy enough to fix through a cast to "unsigned long".
> 
> Yes, that's usually what I do as well with size_t everywhere as well.
> 
> > The original patch was already sent to Shuah and included in -next.
> > 
> > Shuah, Paul:
> > 
> > I'd like to rewrite the offending commit instead of having a fixup commit.
> > As it seems to me the original patch would only go into 6.10 anyways.
> > 
> > Any objections?
> 
> I, too, think it would be the cleanest history-wise, I just don't know
> if that's the easiest for Shuah if it requires to change already published
> commit IDs.

One way would be to resend the series and have Shuah replace what she
has with the new series.  But I don't know enough about Shuah's process
to judge.

							Thanx, Paul

> > Notes to self:
> > 
> > * Add flag to run-tests.sh to use -Werror
> > * Implement "%zu" in nolibc printf()
> 
> Could be nice indeed!
> 
> Thanks Thomas for taking care of this!
> Willy

