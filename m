Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8A28114B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441964AbjLMOe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441923AbjLMOe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:34:28 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC83B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:34:33 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce9e897aeaso6192457b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702478072; x=1703082872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbOaPVmJ7E4boaoj6IocNcjRghNie5jLjB39Y35NZkE=;
        b=MzuUHnRKvU4ENtNoq+H5yTlCm37pMFnVOnYWl6IZdKcJVqkBZCzO/eQmyMa8//Ge+W
         LQ1jbJtKld2oVjP7vb4I2bHAKIxvCtRkCX0mdicSws6kOVYsEcCYLk/ZL7QiQ8Hp/aB3
         gm+GO7y+18omFgBm7KEICTJ2qygV7rDG+yTZSbMSHdW34n19Sab0M7HU7mE8N00nM+lT
         wUUXPNmtFxaY3NblVpxTsYqUzPcfKt4ydtaktt3xKmW6EOiro0hkoZauvdgE2MFrXVcL
         SljgabINDOZVNNBa6ezNfpuxgm+Bie7TeIQjgwgqyuwiF7xAkBzh0bUCxvEndrP8DrG2
         AOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702478072; x=1703082872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbOaPVmJ7E4boaoj6IocNcjRghNie5jLjB39Y35NZkE=;
        b=khreHgLjgJ04/aLcpiwY/tTyi+fq49Qz6zMA009UCB2Y+II63iga/jCv587vD0Bm3W
         MuBi1ljjKz3nWJkXxcjiOaDCGrY9hKaOmFm+mN/9Y6I7AyTAx6yROUTgR49CrVYfVAvi
         /gI0fH22EW1yADKAi09O21MSi3BKVKmjRvKKLg6iQ7rOl+yuzPPo5f8b5JPqTQPnbK+d
         bSTyrDomXCUvc3g90J1AyEUPhE7swCBRMgtHWsL2km9W9yqBcVqW3q09TkZy/veftBt7
         9ujHITm4DSh3lSiVsPmEtd51FDnnSO5Ic/thCc/p3qb+wFSB+2hJBdgsRrpJerwH/Y1n
         SOgw==
X-Gm-Message-State: AOJu0Yx0ygnYic4u3jowdi9tVR/xxNnYZ79APCJ9txvJsoYxzbGw0BBN
        IQh/mV2Of+46BE2zj6JF0Bt/vQ1NOA+g6ZHWjaxE+Uvq
X-Google-Smtp-Source: AGHT+IGoeTELoKZIUySzntD4U8AHBobuBQTV1qRo1vfNtYiB/gZi2nsHPSNCb7OxU6Ep5v2NDoelfkeQ2thuszguRvE=
X-Received: by 2002:a05:6a20:2590:b0:190:7d54:f0c4 with SMTP id
 k16-20020a056a20259000b001907d54f0c4mr10315674pzd.87.1702478072405; Wed, 13
 Dec 2023 06:34:32 -0800 (PST)
MIME-Version: 1.0
References: <20231212232659.18839-1-npache@redhat.com>
In-Reply-To: <20231212232659.18839-1-npache@redhat.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 13 Dec 2023 15:34:21 +0100
Message-ID: <CA+fCnZeE1g7F6UDruw-3v5eTO9u_jcROG4Hbndz8Bnr62Opnyg@mail.gmail.com>
Subject: Re: [PATCH] kunit: kasan_test: disable fortify string checker on kmalloc_oob_memset
To:     Nico Pache <npache@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, akpm@linux-foundation.org,
        vincenzo.frascino@arm.com, dvyukov@google.com, glider@google.com,
        ryabinin.a.a@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 12:27=E2=80=AFAM Nico Pache <npache@redhat.com> wro=
te:
>
> similar to commit 09c6304e38e4 ("kasan: test: fix compatibility with
> FORTIFY_SOURCE") the kernel is panicing in kmalloc_oob_memset_*.
>
> This is due to the `ptr` not being hidden from the optimizer which would
> disable the runtime fortify string checker.
>
> kernel BUG at lib/string_helpers.c:1048!
> Call Trace:
> [<00000000272502e2>] fortify_panic+0x2a/0x30
> ([<00000000272502de>] fortify_panic+0x26/0x30)
> [<001bffff817045c4>] kmalloc_oob_memset_2+0x22c/0x230 [kasan_test]
>
> Hide the `ptr` variable from the optimizer to fix the kernel panic.
> Also define a size2 variable and hide that as well. This cleans up
> the code and follows the same convention as other tests.
>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/kasan/kasan_test.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index 8281eb42464b..5aeba810ba70 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -493,14 +493,17 @@ static void kmalloc_oob_memset_2(struct kunit *test=
)
>  {
>         char *ptr;
>         size_t size =3D 128 - KASAN_GRANULE_SIZE;
> +       size_t size2 =3D 2;

Let's name this variable access_size or memset_size. Here and in the
other changed tests.

>         KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
>
>         ptr =3D kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         OPTIMIZER_HIDE_VAR(size);
> -       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 1, 0, 2));
> +       OPTIMIZER_HIDE_VAR(size2);
> +       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 1, 0, size2));
>         kfree(ptr);
>  }
>
> @@ -508,14 +511,17 @@ static void kmalloc_oob_memset_4(struct kunit *test=
)
>  {
>         char *ptr;
>         size_t size =3D 128 - KASAN_GRANULE_SIZE;
> +       size_t size2 =3D 4;
>
>         KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
>
>         ptr =3D kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         OPTIMIZER_HIDE_VAR(size);
> -       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 3, 0, 4));
> +       OPTIMIZER_HIDE_VAR(size2);
> +       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 3, 0, size2));
>         kfree(ptr);
>  }
>
> @@ -523,14 +529,17 @@ static void kmalloc_oob_memset_8(struct kunit *test=
)
>  {
>         char *ptr;
>         size_t size =3D 128 - KASAN_GRANULE_SIZE;
> +       size_t size2 =3D 8;
>
>         KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
>
>         ptr =3D kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         OPTIMIZER_HIDE_VAR(size);
> -       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 7, 0, 8));
> +       OPTIMIZER_HIDE_VAR(size2);
> +       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 7, 0, size2));
>         kfree(ptr);
>  }
>
> @@ -538,14 +547,17 @@ static void kmalloc_oob_memset_16(struct kunit *tes=
t)
>  {
>         char *ptr;
>         size_t size =3D 128 - KASAN_GRANULE_SIZE;
> +       size_t size2 =3D 16;
>
>         KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
>
>         ptr =3D kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         OPTIMIZER_HIDE_VAR(size);
> -       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 15, 0, 16));
> +       OPTIMIZER_HIDE_VAR(size2);
> +       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 15, 0, size2));
>         kfree(ptr);
>  }
>
> --
> 2.43.0
>

With the fix mentioned above addressed:

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
