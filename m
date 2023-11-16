Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B177EE357
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345340AbjKPOwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345262AbjKPOwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:52:03 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07381130;
        Thu, 16 Nov 2023 06:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1700146318;
        bh=VJ7RN0lzgbPYXdxxqICHsYygAN4e9y4IsXQGHBOjHj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXfrW9p7mvA2w6vEjR3kZYLRv4WkD/Cz2to6vWrZmV5p6U3dezjj8Ilzsw/DvRcmd
         d4GGVFQGUXfZN6shfgmG63VB4c0GSxzJc1rhxW/UpvuK16THoHGOftSSI5xDIZ5W9b
         9s0jAy42RwbYMAvrYnoOI2Thz2qJuG8mi4ZNRJsA=
Date:   Thu, 16 Nov 2023 15:51:57 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] selftests/nolibc: migrate vfprintf tests to new
 harness
Message-ID: <72c14cb1-5ac2-47a0-9759-fce10f3c59cc@t-8ch.de>
References: <20231115-nolibc-harness-v1-0-4d61382d9bf3@weissschuh.net>
 <20231115-nolibc-harness-v1-3-4d61382d9bf3@weissschuh.net>
 <ZVXJMgly7/et8JAt@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZVXJMgly7/et8JAt@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-16 08:48:02+0100, Willy Tarreau wrote:
> On Wed, Nov 15, 2023 at 10:08:21PM +0100, Thomas Weißschuh wrote:
> > Migrate part of nolibc-test.c to the new test harness.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  tools/testing/selftests/nolibc/nolibc-test.c | 74 +++++++++++-----------------
> >  1 file changed, 28 insertions(+), 46 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index 6c1b42b58e3e..c0e7e090a05a 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -1039,10 +1039,13 @@ int run_stdlib(int min, int max)
> >  	return ret;
> >  }
> >  
> > -#define EXPECT_VFPRINTF(c, expected, fmt, ...)				\
> > -	ret += expect_vfprintf(llen, c, expected, fmt, ##__VA_ARGS__)
> > +#define ASSERT_VFPRINTF(c, expected, fmt, ...)				\
> > +	enum RESULT res = assert_vfprintf(_metadata, c, expected, fmt, ##__VA_ARGS__); \
> > +	if (res == SKIPPED) SKIP(return); \
> > +	if (res == FAIL) FAIL(return);
> 
> Please enclose this in a "do { } while (0)" block when using more than
> one statement, because you can be certain that sooner or later someone
> will put an "if" or "for" above it. This will also avoid the double
> colon caused by the trailing one.

Ack.

> 
> > -static int expect_vfprintf(int llen, int c, const char *expected, const char *fmt, ...)
> > +static enum RESULT assert_vfprintf(struct __test_metadata *_metadata, int c,
> > +				   const char *expected, const char *fmt, ...)
> >  {
> >  	int ret, fd;
> >  	ssize_t w, r;
> > @@ -1051,25 +1054,20 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
> >  	va_list args;
> >  
> >  	fd = open("/tmp", O_TMPFILE | O_EXCL | O_RDWR, 0600);
> > -	if (fd == -1) {
> > -		result(llen, SKIPPED);
> > -		return 0;
> > -	}
> > +	if (fd == -1)
> > +		return SKIPPED;
> >  
> >  	memfile = fdopen(fd, "w+");
> > -	if (!memfile) {
> > -		result(llen, FAIL);
> > -		return 1;
> > -	}
> > +	if (!memfile)
> > +		return FAIL;
>  
> 
> Till now it looks easier and more readable.
> 
> >  	va_start(args, fmt);
> >  	w = vfprintf(memfile, fmt, args);
> >  	va_end(args);
> >  
> >  	if (w != c) {
> > -		llen += printf(" written(%d) != %d", (int)w, c);
> > -		result(llen, FAIL);
> > -		return 1;
> > +		_metadata->exe.llen += printf(" written(%d) != %d", (int)w, c);
> > +		return FAIL;
> >  	}
> 
> Here however I feel like we're already hacking internals of the test
> system and that doesn't seem natural nor logical. OK I understand that
> llen contains the lenght of the emitted message, but how should the
> user easily guess that it's placed into ->exe.llen, and they may or may
> not touch other fields there, etc ? Also the fact that the variable is
> prefixed with an underscore signals a warning to the user that they
> should not fiddle too much with its internals.

Agree that this is ugly.

> I'm seeing basically two possible approaches:
>   - one consisting in having a wrapper around printf() that transparently
>     sets the llen field in _metadata->exe. This at least offload this
>     knowledge from the user who can then just know they have to pass an
>     opaque metadata argument and that's all.
> 
>   - one consisting in saying that such functions should not affect the
>     test's metadata themselves and that it ought to be the caller's job
>     instead. The function then only ought to return the printed length,
>     and will not need the metadata at all.
> 
> I tend to prefer the second option. In addition, you seem to be returning
> only 3 statuses (ok/skip/fail) so returning a single composite value for
> this is easy, e.g. (result | llen) with result made of macros only touching
> the high bits. If in the future more returns are needed, either a larger
> int or shift can be used, or we can then return pairs or structs.

I am prefering the first option. It will make it easier to adapt the
backend of the harness to KTAP I think.

If you are fine with the basics of the harness I can convert all of
nolibc-test.c and then also add the KTAP output at the end.

WDYT?


Thomas
