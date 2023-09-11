Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BBE79BD03
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376477AbjIKWTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241378AbjIKPH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:07:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334F4FA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:07:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401b5516104so48612755e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694444839; x=1695049639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dOpTUAby7ZVIO6+YPrYOI97+9Zg13vBp8MSTW+q41J4=;
        b=zS0IrBMC2DQJ4CUL13xIePZJxujhUYTFHX9YKiKrYhdJ4rwlSI+0kAuWnDHnMiDqQP
         ZPu/pWa6/W85/K+0t7ujy7aZfEl4/hIN4+hHik/00/HWjFesycVTjCSlnmv/rnlqU3Hi
         OhCV3fAMC+ZsVdztQ6NA3juPIjPBoalQSUOdwp5fcIw2WsYVW0lKNSvQ4Hb8sHdfhF3R
         jcjZ7zblOhmlU54TmVfqeYHvX/mKHwSRtAQ2DPtnl19JqKvogcB0Jnak+2tiozHRJ+kC
         XadNpS8Vpv5lLI4SSZ7gjBda45QsJ7s2EoZDogGo6aRLji0JS3Ti4WQ701CgMxrwcxhg
         KZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444839; x=1695049639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOpTUAby7ZVIO6+YPrYOI97+9Zg13vBp8MSTW+q41J4=;
        b=OZcWcwlsuNv+DwPGXnIBVBDOzyhudqEYPD3JafieYFC0npNT09jsFpd6DPqGDoKmqr
         L9sTork65T3nM6Qn+fwOxjpUcBO0Zy5E9uQ0CWTyeOkYMQdpy3Qv5lESFPIz7v0IpIEW
         n/ooBMA7URsCIk+iO/HnEK/k/EK64pK0NHOj8xFxqGwVyBL/tcdHTgWParnjbjZVtOag
         O33hmEE5PCIH0aUDPkyzZYjLBF7yGHUx/2+lfraLf/S9nyR0KVThL8urDds4Aq7BEJG7
         zSPN35lwxCk2uZeA7H17+RwWU8GoyQOvKu02g6hWxWDDA3Dnzrj2+VBnE0qaEDBfpOOA
         FvFg==
X-Gm-Message-State: AOJu0Yzyqy+ccsQlZsKA9KsFuqxIxm9+yI9MiB0SkaFQ3EBdNAzGTPS4
        hArT+w66Qy0CZw7YwFb1GYOGDfO0q2DX33wss2CMtA==
X-Google-Smtp-Source: AGHT+IFkSM8rCd+Ax4dNRpcacBlnBuDTSYOCnAOBXnLUsAtz+uztZOZO0zxzP7ZTobe3xjzx0Qi8LQI0Q9NOMxwQj/A=
X-Received: by 2002:a05:600c:b44:b0:401:dc7c:2488 with SMTP id
 k4-20020a05600c0b4400b00401dc7c2488mr8666846wmr.11.1694444839305; Mon, 11 Sep
 2023 08:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230911145702.2663753-1-glider@google.com> <20230911145702.2663753-3-glider@google.com>
In-Reply-To: <20230911145702.2663753-3-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 11 Sep 2023 17:06:42 +0200
Message-ID: <CANpmjNP61zOdXR=FYjtzUqcjxg=j_Otqotqv_OTN_Hi2E-LXLg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] kmsan: merge test_memcpy_aligned_to_unaligned{,2}()
 together
To:     Alexander Potapenko <glider@google.com>
Cc:     dvyukov@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sept 2023 at 16:57, Alexander Potapenko <glider@google.com> wrote:
>
> Introduce report_reset() that allows checking for more than one KMSAN
> report per testcase.
> Fold test_memcpy_aligned_to_unaligned2() into
> test_memcpy_aligned_to_unaligned(), so that they share the setup phase
> and check the behavior of a single memcpy() call.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Acked-by: Marco Elver <elver@google.com>

> ---
>  mm/kmsan/kmsan_test.c | 37 +++++++++++++------------------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
>
> diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> index a8d4ca4a1066d..6eb1e1a4d08f9 100644
> --- a/mm/kmsan/kmsan_test.c
> +++ b/mm/kmsan/kmsan_test.c
> @@ -67,6 +67,17 @@ static bool report_available(void)
>         return READ_ONCE(observed.available);
>  }
>
> +/* Reset observed.available, so that the test can trigger another report. */
> +static void report_reset(void)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&observed.lock, flags);
> +       WRITE_ONCE(observed.available, false);
> +       observed.ignore = false;
> +       spin_unlock_irqrestore(&observed.lock, flags);
> +}
> +
>  /* Information we expect in a report. */
>  struct expect_report {
>         const char *error_type; /* Error type. */
> @@ -454,7 +465,7 @@ static void test_memcpy_aligned_to_aligned(struct kunit *test)
>   *
>   * Copying aligned 4-byte value to an unaligned one leads to touching two
>   * aligned 4-byte values. This test case checks that KMSAN correctly reports an
> - * error on the first of the two values.
> + * error on the mentioned two values.
>   */
>  static void test_memcpy_aligned_to_unaligned(struct kunit *test)
>  {
> @@ -470,28 +481,7 @@ static void test_memcpy_aligned_to_unaligned(struct kunit *test)
>                         sizeof(uninit_src));
>         kmsan_check_memory((void *)dst, 4);
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> -}
> -
> -/*
> - * Test case: ensure that memcpy() correctly copies uninitialized values between
> - * aligned `src` and unaligned `dst`.
> - *
> - * Copying aligned 4-byte value to an unaligned one leads to touching two
> - * aligned 4-byte values. This test case checks that KMSAN correctly reports an
> - * error on the second of the two values.
> - */
> -static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
> -{
> -       EXPECTATION_UNINIT_VALUE_FN(expect,
> -                                   "test_memcpy_aligned_to_unaligned2");
> -       volatile int uninit_src;
> -       volatile char dst[8] = { 0 };
> -
> -       kunit_info(
> -               test,
> -               "memcpy()ing aligned uninit src to unaligned dst - part 2 (UMR report)\n");
> -       memcpy_noinline((void *)&dst[1], (void *)&uninit_src,
> -                       sizeof(uninit_src));
> +       report_reset();
>         kmsan_check_memory((void *)&dst[4], sizeof(uninit_src));
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
> @@ -589,7 +579,6 @@ static struct kunit_case kmsan_test_cases[] = {
>         KUNIT_CASE(test_init_memcpy),
>         KUNIT_CASE(test_memcpy_aligned_to_aligned),
>         KUNIT_CASE(test_memcpy_aligned_to_unaligned),
> -       KUNIT_CASE(test_memcpy_aligned_to_unaligned2),
>         KUNIT_CASE(test_memset16),
>         KUNIT_CASE(test_memset32),
>         KUNIT_CASE(test_memset64),
> --
> 2.42.0.283.g2d96d420d3-goog
>
