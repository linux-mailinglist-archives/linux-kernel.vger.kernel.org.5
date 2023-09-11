Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F2A79C01E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358471AbjIKWLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241390AbjIKPHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:07:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B4ECCC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:07:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so49004665e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694444856; x=1695049656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FOHcmU4SPBlFSrepvb7+SqS7flL0n1Vuqk9odxNTsOE=;
        b=WRhp0V9hKqAO77KDi//ETl8WMUU3eFr5tvU3nnQSt1CcJpmUSfAFNqPa6OYjA9ZCV2
         SrZ6C5/BvAXQkK3cSTp16DyAWPJvsFLP5EaQQsyJkAlxSyFCEzp19VLzPwKAS2PVrhaz
         X2U/W8ozyA09qMB5EmkddhMQRh1zYJoG+jrqnmHCzJa8vVyfomWmd5Ke0+vpYl93iJYF
         pTc+NP5apNdyvKx5MVklSOjNpIrlLsKI2zd6OFnkaobEj4bi+JH60yixu5G3tB0UCnE2
         kIRl1PJ9Qwe7JXN5HQT0N5Oo1xHrxVtGkiOErpGUIzGIGxauFBw2Rmt6R7RnEYHqrrLJ
         XUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444856; x=1695049656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOHcmU4SPBlFSrepvb7+SqS7flL0n1Vuqk9odxNTsOE=;
        b=o6HeaQnqSPKSoIXgc95VT3GIGMg0ICydYsAwJItEg+OFrY8N9QvsxfnO/btHpYESVJ
         XcpY+abcC3wUGRaFx7H74SR8GiKkTg1MJ8BQVhAL5e9Z1ZO/7dObT1T3MUv7uMlHq9fy
         v9oo0u8ia+QjdFdSvHRWlKmYvCsXLps9BujL5Ylx7RFLdY2dMO+Zk2apJjAf313lH224
         yUFe+AJsTvArmKbYge0kPqJvLbH0A+wXO2K6n7Yikau5nr2abTbFf/S/MxA3L8iuWbKi
         PeGkjJ/f6hFdczSegEPZJWs7tHgRBWepquNTPQkgdVln9bYG5ki2kBG41mcG7j/Xw/Ob
         Ap5w==
X-Gm-Message-State: AOJu0Yz6HD5HIHwnKPo7jQJRJegZMq6uePaYYz6tx25yGALh3tM4KyVR
        uBTMzbq3SeWNq2Q7Tjx3ErPebiSCHsnRmhyMo6wXPQ==
X-Google-Smtp-Source: AGHT+IHJwjh/esyBhhgQWt69PjwsvB4s+p0GsaI4PnNXFSErHyI+u2wqbc2C6yPHrGQm2qHssYYi8IYTl8FnbqIJH2Y=
X-Received: by 2002:a05:600c:452:b0:402:cc5c:c98 with SMTP id
 s18-20020a05600c045200b00402cc5c0c98mr8376028wmb.13.1694444856665; Mon, 11
 Sep 2023 08:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230911145702.2663753-1-glider@google.com> <20230911145702.2663753-2-glider@google.com>
In-Reply-To: <20230911145702.2663753-2-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 11 Sep 2023 17:07:00 +0200
Message-ID: <CANpmjNNhtYPf82=o+NYB64xkHy-8aRy2w9BZgjERbN_+fuK=DA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] kmsan: prevent optimizations in memcpy tests
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
> Clang 18 learned to optimize away memcpy() calls of small uninitialized
> scalar values. To ensure that memcpy tests in kmsan_test.c still perform
> calls to memcpy() (which KMSAN replaces with __msan_memcpy()), declare a
> separate memcpy_noinline() function with volatile parameters, which
> won't be optimized.
>
> Also retire DO_NOT_OPTIMIZE(), as memcpy_noinline() is apparently
> enough.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Acked-by: Marco Elver <elver@google.com>

> ---
> v2:
>  - fix W=1 warnings reported by LKP test robot
> ---
>  mm/kmsan/kmsan_test.c | 41 ++++++++++++++++-------------------------
>  1 file changed, 16 insertions(+), 25 deletions(-)
>
> diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> index 312989aa2865c..a8d4ca4a1066d 100644
> --- a/mm/kmsan/kmsan_test.c
> +++ b/mm/kmsan/kmsan_test.c
> @@ -407,33 +407,25 @@ static void test_printk(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
>
> -/*
> - * Prevent the compiler from optimizing @var away. Without this, Clang may
> - * notice that @var is uninitialized and drop memcpy() calls that use it.
> - *
> - * There is OPTIMIZER_HIDE_VAR() in linux/compier.h that we cannot use here,
> - * because it is implemented as inline assembly receiving @var as a parameter
> - * and will enforce a KMSAN check. Same is true for e.g. barrier_data(var).
> - */
> -#define DO_NOT_OPTIMIZE(var) barrier()
> +/* Prevent the compiler from inlining a memcpy() call. */
> +static noinline void *memcpy_noinline(volatile void *dst,
> +                                     const volatile void *src, size_t size)
> +{
> +       return memcpy((void *)dst, (const void *)src, size);
> +}
>
> -/*
> - * Test case: ensure that memcpy() correctly copies initialized values.
> - * Also serves as a regression test to ensure DO_NOT_OPTIMIZE() does not cause
> - * extra checks.
> - */
> +/* Test case: ensure that memcpy() correctly copies initialized values. */
>  static void test_init_memcpy(struct kunit *test)
>  {
>         EXPECTATION_NO_REPORT(expect);
> -       volatile int src;
> -       volatile int dst = 0;
> +       volatile long long src;
> +       volatile long long dst = 0;
>
> -       DO_NOT_OPTIMIZE(src);
>         src = 1;
>         kunit_info(
>                 test,
>                 "memcpy()ing aligned initialized src to aligned dst (no reports)\n");
> -       memcpy((void *)&dst, (void *)&src, sizeof(src));
> +       memcpy_noinline((void *)&dst, (void *)&src, sizeof(src));
>         kmsan_check_memory((void *)&dst, sizeof(dst));
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
> @@ -451,8 +443,7 @@ static void test_memcpy_aligned_to_aligned(struct kunit *test)
>         kunit_info(
>                 test,
>                 "memcpy()ing aligned uninit src to aligned dst (UMR report)\n");
> -       DO_NOT_OPTIMIZE(uninit_src);
> -       memcpy((void *)&dst, (void *)&uninit_src, sizeof(uninit_src));
> +       memcpy_noinline((void *)&dst, (void *)&uninit_src, sizeof(uninit_src));
>         kmsan_check_memory((void *)&dst, sizeof(dst));
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
> @@ -474,8 +465,9 @@ static void test_memcpy_aligned_to_unaligned(struct kunit *test)
>         kunit_info(
>                 test,
>                 "memcpy()ing aligned uninit src to unaligned dst (UMR report)\n");
> -       DO_NOT_OPTIMIZE(uninit_src);
> -       memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
> +       kmsan_check_memory((void *)&uninit_src, sizeof(uninit_src));
> +       memcpy_noinline((void *)&dst[1], (void *)&uninit_src,
> +                       sizeof(uninit_src));
>         kmsan_check_memory((void *)dst, 4);
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
> @@ -498,8 +490,8 @@ static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
>         kunit_info(
>                 test,
>                 "memcpy()ing aligned uninit src to unaligned dst - part 2 (UMR report)\n");
> -       DO_NOT_OPTIMIZE(uninit_src);
> -       memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
> +       memcpy_noinline((void *)&dst[1], (void *)&uninit_src,
> +                       sizeof(uninit_src));
>         kmsan_check_memory((void *)&dst[4], sizeof(uninit_src));
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
> @@ -513,7 +505,6 @@ static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
>                                                                              \
>                 kunit_info(test,                                            \
>                            "memset" #size "() should initialize memory\n"); \
> -               DO_NOT_OPTIMIZE(uninit);                                    \
>                 memset##size((uint##size##_t *)&uninit, 0, 1);              \
>                 kmsan_check_memory((void *)&uninit, sizeof(uninit));        \
>                 KUNIT_EXPECT_TRUE(test, report_matches(&expect));           \
> --
> 2.42.0.283.g2d96d420d3-goog
>
