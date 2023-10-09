Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5AE7BD597
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345507AbjJIIsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjJIIsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:48:02 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03B1AB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 01:48:00 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-49d6bd3610cso1324757e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 01:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696841280; x=1697446080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dE3lQgYQrglH+136jeW6uJyH+jXehuS7mvTlptTmP9s=;
        b=sjP/CK2QclDmAPix6CZDvC+6aSYEEmbGt2EpRDFDrUNV64goE7Xw+098Hp7IqHgKoO
         QuIrPULLwwJjG462nExLW+cfdMSBjE+dBa9xg4XwTndWO5BeBWnzC3qY6gS5eiiHktyP
         fRSIUaUH90XtB/A7JsnKlz15f00pgL1YURLi24zv6hU+KlXDWorZ/9TIQdTR4Wk1wlHW
         0uOUWJIw0zblyMZuywOApb7w74eFJg0+2oajBwnmCPhfExI9v8VXpJfxURbUBXoy/exN
         2l17Y4l/vLaGheeO+BcTX0xsTtUoLFIyjZgrtvnlFltlwFQsUTxckTARUcAC494cm4YP
         aafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696841280; x=1697446080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dE3lQgYQrglH+136jeW6uJyH+jXehuS7mvTlptTmP9s=;
        b=SQyakrR9iwQFrPxYAnzKQdXQVK2LwwBEHonyEIgOy/cSqDT2mqY/fxhXThgdtXaurN
         wVHA390LZIA6kJ5qb9nMd7nn1aVF50UoymW962+tKOrarNsW7xscVs/F+9VKawO6P/BA
         ms6iplwCVwna+Bv88QP3aC729GVlT9aX7NdenXbRgg/IgWj1f3AnzF1Nl9aYfe56Fnol
         rF9gNhGOXb1XjZY+MOre0E9qB0CQhUyaLp4JZkA8oWBzAs74/D787K1DIl0E/a4RodsL
         nOe+ds6ioeI5BZ64lSxiAamFZbWK2xVBU38iV4pZeq4IVyKL99OLg/EisiaWf2K7pOyW
         JRlg==
X-Gm-Message-State: AOJu0YyGphsmqnrb4goEAB8rFUmq2H8H982hxeEDNsH/583zbRn3XyzS
        OBV1ymiw/ZnmkK1Le3zMYTx+Zz4TCV/zyfxdzOAvkA==
X-Google-Smtp-Source: AGHT+IGkEHB9+FkrxEWHBni/C8fdR2BOIvdSvmE0rrDALznxAP9Fyr8BrrEt9+PRFjg9zwhFRR42opgPmUXdx0/JIOM=
X-Received: by 2002:a1f:d3c4:0:b0:49a:b9ed:8c22 with SMTP id
 k187-20020a1fd3c4000000b0049ab9ed8c22mr11374478vkg.9.1696841279791; Mon, 09
 Oct 2023 01:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696605143.git.andreyknvl@google.com> <6fad6661e72c407450ae4b385c71bc4a7e1579cd.1696605143.git.andreyknvl@google.com>
In-Reply-To: <6fad6661e72c407450ae4b385c71bc4a7e1579cd.1696605143.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 9 Oct 2023 10:47:23 +0200
Message-ID: <CANpmjNOp0yq2vQmSmTim=AF7bm9XdStbaQE9B=wVwpKkO_y6tQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] kasan: fix and update KUNIT_EXPECT_KASAN_FAIL comment
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        kernel test robot <lkp@intel.com>
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

On Fri, 6 Oct 2023 at 17:18, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Update the comment for KUNIT_EXPECT_KASAN_FAIL to describe the parameters
> this macro accepts.
>
> Also drop the mention of the "kasan_status" KUnit resource, as it no
> longer exists.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308171757.7V5YUcje-lkp@intel.com/

"Closes" isn't a valid tag? Reported-by + Link should be enough to attribute.

> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/kasan_test.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index c707d6c6e019..2030c7ff7de9 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -91,10 +91,11 @@ static void kasan_test_exit(struct kunit *test)
>  }
>
>  /**
> - * KUNIT_EXPECT_KASAN_FAIL() - check that the executed expression produces a
> - * KASAN report; causes a test failure otherwise. This relies on a KUnit
> - * resource named "kasan_status". Do not use this name for KUnit resources
> - * outside of KASAN tests.
> + * KUNIT_EXPECT_KASAN_FAIL - check that the executed expression produces a
> + * KASAN report; causes a KUnit test failure otherwise.
> + *
> + * @test: Currently executing KUnit test.
> + * @expression: Expression that must produce a KASAN report.
>   *
>   * For hardware tag-based KASAN, when a synchronous tag fault happens, tag
>   * checking is auto-disabled. When this happens, this test handler reenables
> --
> 2.25.1
>
