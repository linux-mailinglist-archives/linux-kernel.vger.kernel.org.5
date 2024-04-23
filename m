Return-Path: <linux-kernel+bounces-155574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B988AF419
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C431C23081
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6624D13DBB3;
	Tue, 23 Apr 2024 16:28:47 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ACB13D52A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889727; cv=none; b=o7OJ6Rc+h4d5M/WP4ZoQkIbp3rDYJ0QsuxHP3XZmb77jZEXmTl9YfAPisNP2809Q/cxI+ROqgb4wAwHpB9InZHU5tEWyhL1swCc0BVs77Pu0q6akl8BQFPvVKW5EsDoPE/G0VSByRmj1USKrGOHMdMDpEXW3KtByNSMUMfXNSCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889727; c=relaxed/simple;
	bh=pB4VKsnN31I2O7fVXpDLnLWksgilJsrVoiT9rsc7u+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQYBr0JtAvZezAbxUV4vWPK0zUK1Ajbp+GDuCVV2x+Z2uDcSaeirnvOVh/o5ucdgSKRaj23+RDJLxgv+9V5VKn02XC0Kjrcy0+hKfNU/xMaf9+aD/NFWYKQW525/2T8xb7/uEzhSEzJYhyd/lBgqaACcxhRfMHKV5k7q6h2UYq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 43NGSVWL022815;
	Tue, 23 Apr 2024 18:28:31 +0200
Date: Tue, 23 Apr 2024 18:28:31 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: Re: [PATCH v3 4/4] selftests/nolibc: Add tests for strlcat() and
 strlcpy()
Message-ID: <Zifhr1sX5soHlXSG@1wt.eu>
References: <20240218195110.1386840-1-rodrigo@sdfg.com.ar>
 <20240218195110.1386840-5-rodrigo@sdfg.com.ar>
 <172d25cf-cfd7-4069-8c26-df2e81ffbad1@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172d25cf-cfd7-4069-8c26-df2e81ffbad1@t-8ch.de>

Hi Thomas,

On Tue, Apr 23, 2024 at 11:18:06AM +0200, Thomas Weißschuh wrote:
> + Shuah and Paul, please see below.
> 
> So I picked this up and it got picked up by Shuah, but...
> 
> On 2024-02-18 16:51:06+0000, Rodrigo Campos wrote:
> > I've verified that the tests matches libbsd's strlcat()/strlcpy()
> > implementation.
> > 
> > Please note that as strlcat()/strlcpy() are not part of the libc, the
> > tests are only compiled when using nolibc.
> > 
> > Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> > ---
> >  tools/testing/selftests/nolibc/nolibc-test.c | 40 ++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index 6ba4f8275ac4..d373fc14706c 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -600,6 +600,25 @@ int expect_strne(const char *expr, int llen, const char *cmp)
> >  	return ret;
> >  }
> >  
> > +#define EXPECT_STRBUFEQ(cond, expr, buf, val, cmp)				\
> > +	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_str_buf_eq(expr, buf, val, llen, cmp); } while (0)
> > +
> > +static __attribute__((unused))
> > +int expect_str_buf_eq(size_t expr, const char *buf, size_t val, int llen, const char *cmp)
> > +{
> > +	llen += printf(" = %lu <%s> ", expr, buf);
> 
> This introduces a compiler warning on 32bit:
> 
>     i386-linux-gcc -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra -fno-stack-protector -m32 -mstack-protector-guard=global -fstack-protector-all  -o nolibc-test \
>       -nostdlib -nostdinc -static -Isysroot/i386/include nolibc-test.c nolibc-test-linkage.c -lgcc
>     nolibc-test.c: In function 'expect_str_buf_eq':
>     nolibc-test.c:610:30: error: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>       610 |         llen += printf(" = %lu <%s> ", expr, buf);
>           |                            ~~^         ~~~~
>           |                              |         |
>           |                              |         size_t {aka unsigned int}
>           |                              long unsigned int
>           |                            %u
> 
> 
> It is easy enough to fix through a cast to "unsigned long".

Yes, that's usually what I do as well with size_t everywhere as well.

> The original patch was already sent to Shuah and included in -next.
> 
> Shuah, Paul:
> 
> I'd like to rewrite the offending commit instead of having a fixup commit.
> As it seems to me the original patch would only go into 6.10 anyways.
> 
> Any objections?

I, too, think it would be the cleanest history-wise, I just don't know
if that's the easiest for Shuah if it requires to change already published
commit IDs.

> Notes to self:
> 
> * Add flag to run-tests.sh to use -Werror
> * Implement "%zu" in nolibc printf()

Could be nice indeed!

Thanks Thomas for taking care of this!
Willy

