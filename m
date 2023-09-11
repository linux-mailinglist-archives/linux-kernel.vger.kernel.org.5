Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568EE79B84F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344662AbjIKVOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241346AbjIKPHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:07:00 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B087CCC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:06:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31c8321c48fso3662991f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694444815; x=1695049615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XQQwAsg44hbarepY67H1tYdIQRedwFcPBpbpUI6JdQk=;
        b=TQqc2KuP+6ms7GgpeWI4q4JhV0uiUNKWYYXfJ05Aae1V0akmZrf85DfVYubE2V1O/A
         JUcKGIBmZHnjOlrRIxD6xqgw/6PCnF/zBGUJRIRlGIaKr9NLDqBJMFRRODkS3/7tXg4p
         OzQO5vUKbE/HcGdBYWJkfD6b6GAmoHBZiRZn2frHRwbpagffTKwlTH/G+eBljJ5KxATf
         lUcMxbany1Xo09ZJIRQS6bDDEhid1J6Pwibpiu4EQt9ALFcfjJ37PGTGEojToBgmvbcY
         6JO9nor6UC4uTFOmZpmsN+774f6QvXpL+2nViFTFvVludSAlB3gw+WiBte/Ao4tyVQwi
         hVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444815; x=1695049615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQQwAsg44hbarepY67H1tYdIQRedwFcPBpbpUI6JdQk=;
        b=smzK4tOUuib8iI4Is7+WP/hLwXUjr1FxwjoAWTN90nMDaDeXLWd5iJnwBLwoFDhtK0
         hohui1yRL3pqLpImXv0CSEwSEuWQPdJqClL6vW8DIZOImomTUPQTsNlXgDMuhAADCpaA
         TMLjud4o/llSS8EVdeAZmmh3y4wvWW8U/qVcrssuCxMVGrxNO3Oxnfp6GXC2vvFh3jwF
         Fk7QgK8O53V2NqyRz91ynv06pmQITF1r4kHNUavLxEyncdA8uOqAjV+S8UJl8RcE0fXN
         aMQ4MNrcwKcroHGfW/4jkssnwCGMOkcjCFxL8UiKdH+FrhBysyFGAlggtwN2Kl85UK8z
         9GJg==
X-Gm-Message-State: AOJu0YwSFg4rthTSd4chw9V34kn2+ORfgDBZgo1cnLSlwe89lEbBQIVa
        PFu39cqQXu3J36486N0xTBgcv/wNBr63C/G+E5h9kw==
X-Google-Smtp-Source: AGHT+IGReBrbKqxORJbla+3AcEcMLSzpziaq4ZeTJZaPJ5ttO31D7JbdZ3f5vAmMblVNIn2q7Bnre6e0XbdThrPeJ9g=
X-Received: by 2002:adf:e5c6:0:b0:314:3e96:bd7e with SMTP id
 a6-20020adfe5c6000000b003143e96bd7emr9131234wrn.4.1694444814652; Mon, 11 Sep
 2023 08:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230911145702.2663753-1-glider@google.com> <20230911145702.2663753-4-glider@google.com>
In-Reply-To: <20230911145702.2663753-4-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 11 Sep 2023 17:06:15 +0200
Message-ID: <CANpmjNOnPhYg1hyvDRzatUF6aNdysOW4ftv=W4foRd6Wr8bPpQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] kmsan: introduce test_memcpy_initialized_gap()
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
> Add a regression test for the special case where memcpy() previously
> failed to correctly set the origins: if upon memcpy() four aligned
> initialized bytes with a zero origin value ended up split between two
> aligned four-byte chunks, one of those chunks could've received the zero
> origin value even despite it contained uninitialized bytes from other
> writes.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Suggested-by: Marco Elver <elver@google.com>

Acked-by: Marco Elver <elver@google.com>

> ---
>  mm/kmsan/kmsan_test.c | 53 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> index 6eb1e1a4d08f9..07d3a3a5a9c52 100644
> --- a/mm/kmsan/kmsan_test.c
> +++ b/mm/kmsan/kmsan_test.c
> @@ -486,6 +486,58 @@ static void test_memcpy_aligned_to_unaligned(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
>
> +/*
> + * Test case: ensure that origin slots do not accidentally get overwritten with
> + * zeroes during memcpy().
> + *
> + * Previously, when copying memory from an aligned buffer to an unaligned one,
> + * if there were zero origins corresponding to zero shadow values in the source
> + * buffer, they could have ended up being copied to nonzero shadow values in the
> + * destination buffer:
> + *
> + *  memcpy(0xffff888080a00000, 0xffff888080900002, 8)
> + *
> + *  src (0xffff888080900002): ..xx .... xx..
> + *  src origins:              o111 0000 o222
> + *  dst (0xffff888080a00000): xx.. ..xx
> + *  dst origins:              o111 0000
> + *                        (or 0000 o222)
> + *
> + * (here . stands for an initialized byte, and x for an uninitialized one.
> + *
> + * Ensure that this does not happen anymore, and for both destination bytes
> + * the origin is nonzero (i.e. KMSAN reports an error).
> + */
> +static void test_memcpy_initialized_gap(struct kunit *test)
> +{
> +       EXPECTATION_UNINIT_VALUE_FN(expect, "test_memcpy_initialized_gap");
> +       volatile char uninit_src[12];
> +       volatile char dst[8] = { 0 };
> +
> +       kunit_info(
> +               test,
> +               "unaligned 4-byte initialized value gets a nonzero origin after memcpy() - (2 UMR reports)\n");
> +
> +       uninit_src[0] = 42;
> +       uninit_src[1] = 42;
> +       uninit_src[4] = 42;
> +       uninit_src[5] = 42;
> +       uninit_src[6] = 42;
> +       uninit_src[7] = 42;
> +       uninit_src[10] = 42;
> +       uninit_src[11] = 42;
> +       memcpy_noinline((void *)&dst[0], (void *)&uninit_src[2], 8);
> +
> +       kmsan_check_memory((void *)&dst[0], 4);
> +       KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> +       report_reset();
> +       kmsan_check_memory((void *)&dst[2], 4);
> +       KUNIT_EXPECT_FALSE(test, report_matches(&expect));
> +       report_reset();
> +       kmsan_check_memory((void *)&dst[4], 4);
> +       KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> +}
> +
>  /* Generate test cases for memset16(), memset32(), memset64(). */
>  #define DEFINE_TEST_MEMSETXX(size)                                          \
>         static void test_memset##size(struct kunit *test)                   \
> @@ -579,6 +631,7 @@ static struct kunit_case kmsan_test_cases[] = {
>         KUNIT_CASE(test_init_memcpy),
>         KUNIT_CASE(test_memcpy_aligned_to_aligned),
>         KUNIT_CASE(test_memcpy_aligned_to_unaligned),
> +       KUNIT_CASE(test_memcpy_initialized_gap),
>         KUNIT_CASE(test_memset16),
>         KUNIT_CASE(test_memset32),
>         KUNIT_CASE(test_memset64),
> --
> 2.42.0.283.g2d96d420d3-goog
>
