Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F7177EA2A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345976AbjHPT6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346056AbjHPT6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:58:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D232D5A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 12:57:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so24045e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 12:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692215856; x=1692820656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNKWnHIQQZ0aSLb7HtqGkLz5AlRXqGWtbS0HyZaK6cs=;
        b=YBiI9bOBc9MC64Uni/M51C7iD5BOVtCOvUyXvLMZTQz3miEp/csE0fwf9eFjuvzwAh
         n6bRwzy1LiWikijApWDCFIYp1MEP6qry8Ko6oawHfDkz7bgCuclY2XURu65LY0KYKhQe
         ZEULNQhDBshe+NUX1rmkLLMnAsRU/e7EMoTQsjm9LAPIauAai2mEFqfs3oDhFYYVAxoF
         1ibHtKP2CnQcdEjWAaGBpISxGNsNPNP8s7K+408r0iAmzGQAorVaUixSyD2MEC8Y9Zhd
         R+lkanExAshaGpdcMvXNf+OtN/D0SAzz7GHdXrxldGtAWLue2n6ccB7Te0mooC63TCZx
         PgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692215856; x=1692820656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNKWnHIQQZ0aSLb7HtqGkLz5AlRXqGWtbS0HyZaK6cs=;
        b=icwJvQHNrZmwXqECNIQziK9IfLsKGrYSt1RBPIACPDxYTXCCDoLbGzzNUvlmFIwakc
         37ffZP/Bk2EL47bVGPJ/uOxOXexQYD+4Dlo5SG69AKn3SNtwzSqI9Sve3O1zGkumIx7U
         g8ugpw3VlZnf3vZxxzbwdntUGw1nIV+Nd0UnRhGBYrqsYrIRGHU8HlAFyIQHqOzJSEmT
         wp4YIDUQz6B1hWibkskb/k9XhRVB8emLqm8wMrxezqaMoTkzevvSz04FwGgyTLrC7N1X
         FoEFrY6wO/QG1MXS7K+ZlbZn/EucA74T99JF3Zx3BmmXaiCjT1oVNAbRo9zBEH8QnzI9
         1kQg==
X-Gm-Message-State: AOJu0YyXbavGzO8Hm8r7icCfePtjxDic+ZrXQMq/lzZKIqqMKIAtm/TY
        MK0GGlGnUOUViDsSgELgOKdZ7WtOcUy4qCQxJDvcnQ==
X-Google-Smtp-Source: AGHT+IH0PqX0BJb2mtdzcKcGGGSitPIIrMUuADR0yCW0mCu6YsgbW1xNq1aT8VEy4Q3tji7GwRGzqSN/V48djiKK/n0=
X-Received: by 2002:a05:600c:1d1f:b0:3fd:e15:41e3 with SMTP id
 l31-20020a05600c1d1f00b003fd0e1541e3mr28934wms.2.1692215856104; Wed, 16 Aug
 2023 12:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132309.32641-1-rf@opensource.cirrus.com>
In-Reply-To: <20230814132309.32641-1-rf@opensource.cirrus.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 16 Aug 2023 15:57:24 -0400
Message-ID: <CA+GJov6dkLkeUE4nAW6BnY+75VAemqMxTE-na6SUrGqAz1ntWQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] kunit: Add dynamically-extending log
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Aug 14, 2023 at 9:23=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> This patch chain changes the logging implementation to use string_stream
> so that the log will grow dynamically.
>
> The first 8 patches add test code for string_stream, and make some
> changes to string_stream needed to be able to use it for the log.
>
> The final patch adds a performance report of string_stream.
>
> CHANGES SINCE V3:
>
> Completely rewritten to use string_stream instead of implementing a
> separate extending-buffer implementation for logging.
>
> I have used the performance test from the final patch on my original
> fixed-size-fragment implementation from V3 to get a comparison of the
> two implementations (run on i3-8145UE CPU @ 2.20GHz):
>
>                         string_stream     V3 fixed-size-buffer
> Time elapsed:           7748 us           3251 us
> Total string length:    573890            573890
> Bytes requested:        823994            728336
> Actual bytes allocated: 1061440           728352
>
> I don't think the difference is enough to be worth complicating the
> string_stream implementation with my fixed-fragment implementation from
> V3 of this patch chain.

Hello!

I just wanted to note that I have tested this series and it looks good
to me. I specifically looked over the newline handling and that looks
really good.

I understand you will likely be doing a new version of this. But other
than the things noted in comments by David, this seems to be working
really well.

Tested-by: Rae Moar <rmoar@google.com>

Thanks for all the work you did in moving this framework to string-stream!
-Rae

>
> Richard Fitzgerald (10):
>   kunit: string-stream: Improve testing of string_stream
>   kunit: string-stream: Don't create a fragment for empty strings
>   kunit: string-stream: Add cases for adding empty strings to a
>     string_stream
>   kunit: string-stream: Add option to make all lines end with newline
>   kunit: string-stream: Add cases for string_stream newline appending
>   kunit: string-stream: Pass struct kunit to string_stream_get_string()
>   kunit: string-stream: Decouple string_stream from kunit
>   kunit: string-stream: Add test for freeing resource-managed
>     string_stream
>   kunit: Use string_stream for test log
>   kunit: string-stream: Test performance of string_stream
>
>  include/kunit/test.h           |  14 +-
>  lib/kunit/Makefile             |   5 +-
>  lib/kunit/debugfs.c            |  36 ++-
>  lib/kunit/kunit-test.c         |  52 +---
>  lib/kunit/log-test.c           |  72 ++++++
>  lib/kunit/string-stream-test.c | 447 +++++++++++++++++++++++++++++++--
>  lib/kunit/string-stream.c      | 129 +++++++---
>  lib/kunit/string-stream.h      |  22 +-
>  lib/kunit/test.c               |  48 +---
>  9 files changed, 656 insertions(+), 169 deletions(-)
>  create mode 100644 lib/kunit/log-test.c
>
> --
> 2.30.2
>
