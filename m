Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2630B7EDC0B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344907AbjKPHdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjKPHdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:33:36 -0500
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D572DD;
        Wed, 15 Nov 2023 23:33:32 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3AG7XR8v007559;
        Thu, 16 Nov 2023 08:33:27 +0100
Date:   Thu, 16 Nov 2023 08:33:27 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] selftests/nolibc: migrate startup tests to new
 harness
Message-ID: <ZVXFxyK8xY4mVcrS@1wt.eu>
References: <20231115-nolibc-harness-v1-0-4d61382d9bf3@weissschuh.net>
 <20231115-nolibc-harness-v1-2-4d61382d9bf3@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231115-nolibc-harness-v1-2-4d61382d9bf3@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 10:08:20PM +0100, Thomas Weiﬂschuh wrote:
> Migrate part of nolibc-test.c to the new test harness.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

A few points, mostly questions and food for thoughts.

> -static void putcharn(char c, size_t n)
> -{
> -	char buf[64];
> -
> -	memset(buf, c, n);
> -	buf[n] = '\0';
> -	fputs(buf, stdout);
> -}
> -

Ah now I see how the other one came from :-)  My comment about the size
check still stands anyway, especially when placed in an include file.

> +#if defined(NOLIBC)
> +
> +#define ASSUME_NOLIBC(stmt)
> +
> +#else /* defined(NOLIBC) */
> +
> +/* differ from nolibc, both glibc and musl have no global _auxv */
> +unsigned long *_auxv = (void *)-1;
> +#define ASSUME_NOLIBC(stmt) SKIP(stmt)
> +
> +#endif /* defined(NOLIBC) */
> +

I've seen below how it's used and don't find this very clear. In general,
passing a statement as an argument to a macro, especially control statements
such as "return" is a bit difficult to grasp. If the macro is only used for
this, maybe it should integrate the return statement and be called something
like "RETURN_UNLESS_NOLIBC()" which is quite explicit this time. If you really
need to keep the statement adjustable, then most likely that calling the
macro "UNLESS_NOLIBC()" would help, because I understand more naturally
that the following will perform a return if we're not on nolibc:

    UNLESS_NOLIBC(return);

than:

    ASSUME_NOLIBC(return);

> -	for (test = min; test >= 0 && test <= max; test++) {
> -		int llen = 0; /* line length */
> +	if (brk)
> +		return brk;
>  
> -		/* avoid leaving empty lines below, this will insert holes into
> -		 * test numbers.
> -		 */
> -		switch (test + __LINE__ + 1) {
> -		CASE_TEST(argc);             EXPECT_GE(1, test_argc, 1); break;
> -		CASE_TEST(argv_addr);        EXPECT_PTRGT(1, test_argv, brk); break;
> -		CASE_TEST(argv_environ);     EXPECT_PTRLT(1, test_argv, environ); break;
> -		CASE_TEST(argv_total);       EXPECT_EQ(1, environ - test_argv - 1, test_argc ?: 1); break;
> -		CASE_TEST(argv0_addr);       EXPECT_PTRGT(1, argv0, brk); break;
> -		CASE_TEST(argv0_str);        EXPECT_STRNZ(1, argv0 > brk ? argv0 : NULL); break;
> -		CASE_TEST(argv0_len);        EXPECT_GE(1,  argv0 > brk ? strlen(argv0) : 0, 1); break;
> -		CASE_TEST(environ_addr);     EXPECT_PTRGT(1, environ, brk); break;
> -		CASE_TEST(environ_envp);     EXPECT_PTREQ(1, environ, test_envp); break;
> -		CASE_TEST(environ_auxv);     EXPECT_PTRLT(test_auxv != (void *)-1, environ, test_auxv); break;
> -		CASE_TEST(environ_total);    EXPECT_GE(test_auxv != (void *)-1, (void *)test_auxv - (void *)environ - 1, env_total); break;
> -		CASE_TEST(environ_HOME);     EXPECT_PTRNZ(1, getenv("HOME")); break;
> -		CASE_TEST(auxv_addr);        EXPECT_PTRGT(test_auxv != (void *)-1, test_auxv, brk); break;
> -		CASE_TEST(auxv_AT_UID);      EXPECT_EQ(1, getauxval(AT_UID), getuid()); break;
> -		CASE_TEST(constructor);      EXPECT_EQ(1, constructor_test_value, 2); break;
> -		CASE_TEST(linkage_errno);    EXPECT_PTREQ(1, linkage_test_errno_addr(), &errno); break;
> -		CASE_TEST(linkage_constr);   EXPECT_EQ(1, linkage_test_constructor_test_value, 6); break;
> -		case __LINE__:
> -			return ret; /* must be last */
> -		/* note: do not set any defaults so as to permit holes above */
> -		}
> -	}
> -	return ret;
> +	brk = sbrk(0);
> +
> +	if (brk == (void *)-1)
> +		brk = &end;
> +
> +	return brk;
>  }
>  
> +TEST(startup, argc)           { ASSERT_GE(test_argc, 1); }
> +TEST(startup, argv_addr)      { ASSERT_GT((void *)test_argv, pbrk()); }
> +TEST(startup, argv_environ)   { ASSERT_LT(test_argv, environ); }
> +TEST(startup, argv_total)     { ASSERT_EQ(environ - test_argv - 1, test_argc ?: 1); }
> +TEST(startup, argv0_addr)     { ASSERT_GT((void *)argv0, pbrk()); }
> +TEST(startup, argv0_str)      { ASSERT_STRNZ((void *)argv0 > pbrk() ? argv0 : NULL); }
> +TEST(startup, argv0_len)      { ASSERT_GE((void *)argv0 > pbrk() ? strlen(argv0) : 0U, 1U); }
> +TEST(startup, environ_addr)   { ASSERT_GT((void *)environ, pbrk()); }
> +TEST(startup, environ_envp)   { ASSERT_EQ(environ, test_envp); }
> +TEST(startup, environ_auxv)   {
> +	ASSUME_NOLIBC(return);
> +	ASSERT_LT((void *)environ, (void *)_auxv);
> +}
> +TEST(startup, environ_total)  {
> +	ASSUME_NOLIBC(return);
> +	/* kernel at least passes HOME and TERM, shell passes more */
> +	ASSERT_GE((void *)_auxv - (void *)environ - 1, 2);
> +}
> +TEST(startup, environ_HOME)   { ASSERT_NE(getenv("HOME"), NULL); }
> +TEST(startup, auxv_addr)      {
> +	ASSUME_NOLIBC(return);
> +	ASSERT_GT((void *)_auxv, pbrk());
> +}
> +TEST(startup, auxv_AT_UID)    { ASSERT_EQ(getauxval(AT_UID), getuid()); }
> +TEST(startup, constructor)    { ASSERT_EQ(constructor_test_value, 2); }
> +TEST(startup, linkage_errno)  { ASSERT_EQ(linkage_test_errno_addr(), &errno); }
> +TEST(startup, linkage_constr) { ASSERT_EQ(linkage_test_constructor_test_value, 6); }

I do appreciate the much lower indent level that still manages to
enumerate tests easily. But given that test suites are grouped, shouldn't
we go a bit further and state that TEST() operates on the suite defined
by the TEST_SUITE macro that must be defined before it ? This way you would
have:

  #define TEST_SUITE startup
  TEST(argc)           { ASSERT_GE(test_argc, 1); }
  TEST(argv_addr)      { ASSERT_GT((void *)test_argv, pbrk()); }
  ...
  #undef TEST_SUITE

One thing that was not immediately obvious to me upon first read was
if TEST() defines or executes a test (i.e. "test" is both a noun and a
verb). Of course, spending 10 more seconds on the patch makes it obvious
it's a definition, but maybe following the same logic we have with
run_test_suite(), we should place the verb in front, for example
"DEF_TEST()" which then makes it quite unambiguous. Any opinion ?

Willy
