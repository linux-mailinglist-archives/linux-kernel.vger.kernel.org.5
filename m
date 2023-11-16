Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFB87EDC45
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344942AbjKPHsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjKPHsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:48:13 -0500
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3BD719D;
        Wed, 15 Nov 2023 23:48:09 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3AG7m2HD007736;
        Thu, 16 Nov 2023 08:48:02 +0100
Date:   Thu, 16 Nov 2023 08:48:02 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] selftests/nolibc: migrate vfprintf tests to new
 harness
Message-ID: <ZVXJMgly7/et8JAt@1wt.eu>
References: <20231115-nolibc-harness-v1-0-4d61382d9bf3@weissschuh.net>
 <20231115-nolibc-harness-v1-3-4d61382d9bf3@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231115-nolibc-harness-v1-3-4d61382d9bf3@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 10:08:21PM +0100, Thomas Weiﬂschuh wrote:
> Migrate part of nolibc-test.c to the new test harness.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 74 +++++++++++-----------------
>  1 file changed, 28 insertions(+), 46 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 6c1b42b58e3e..c0e7e090a05a 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -1039,10 +1039,13 @@ int run_stdlib(int min, int max)
>  	return ret;
>  }
>  
> -#define EXPECT_VFPRINTF(c, expected, fmt, ...)				\
> -	ret += expect_vfprintf(llen, c, expected, fmt, ##__VA_ARGS__)
> +#define ASSERT_VFPRINTF(c, expected, fmt, ...)				\
> +	enum RESULT res = assert_vfprintf(_metadata, c, expected, fmt, ##__VA_ARGS__); \
> +	if (res == SKIPPED) SKIP(return); \
> +	if (res == FAIL) FAIL(return);

Please enclose this in a "do { } while (0)" block when using more than
one statement, because you can be certain that sooner or later someone
will put an "if" or "for" above it. This will also avoid the double
colon caused by the trailing one.

> -static int expect_vfprintf(int llen, int c, const char *expected, const char *fmt, ...)
> +static enum RESULT assert_vfprintf(struct __test_metadata *_metadata, int c,
> +				   const char *expected, const char *fmt, ...)
>  {
>  	int ret, fd;
>  	ssize_t w, r;
> @@ -1051,25 +1054,20 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
>  	va_list args;
>  
>  	fd = open("/tmp", O_TMPFILE | O_EXCL | O_RDWR, 0600);
> -	if (fd == -1) {
> -		result(llen, SKIPPED);
> -		return 0;
> -	}
> +	if (fd == -1)
> +		return SKIPPED;
>  
>  	memfile = fdopen(fd, "w+");
> -	if (!memfile) {
> -		result(llen, FAIL);
> -		return 1;
> -	}
> +	if (!memfile)
> +		return FAIL;
 

Till now it looks easier and more readable.

>  	va_start(args, fmt);
>  	w = vfprintf(memfile, fmt, args);
>  	va_end(args);
>  
>  	if (w != c) {
> -		llen += printf(" written(%d) != %d", (int)w, c);
> -		result(llen, FAIL);
> -		return 1;
> +		_metadata->exe.llen += printf(" written(%d) != %d", (int)w, c);
> +		return FAIL;
>  	}

Here however I feel like we're already hacking internals of the test
system and that doesn't seem natural nor logical. OK I understand that
llen contains the lenght of the emitted message, but how should the
user easily guess that it's placed into ->exe.llen, and they may or may
not touch other fields there, etc ? Also the fact that the variable is
prefixed with an underscore signals a warning to the user that they
should not fiddle too much with its internals.

I'm seeing basically two possible approaches:
  - one consisting in having a wrapper around printf() that transparently
    sets the llen field in _metadata->exe. This at least offload this
    knowledge from the user who can then just know they have to pass an
    opaque metadata argument and that's all.

  - one consisting in saying that such functions should not affect the
    test's metadata themselves and that it ought to be the caller's job
    instead. The function then only ought to return the printed length,
    and will not need the metadata at all.

I tend to prefer the second option. In addition, you seem to be returning
only 3 statuses (ok/skip/fail) so returning a single composite value for
this is easy, e.g. (result | llen) with result made of macros only touching
the high bits. If in the future more returns are needed, either a larger
int or shift can be used, or we can then return pairs or structs.

Regards,
Willy
