Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E45F751696
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjGMDCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjGMDCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:02:21 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54305172C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:02:19 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4036bd4fff1so108491cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689217338; x=1691809338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIFkxB9A0AOt1dYmcYEHChkUZQD7NhokkZtrgkit9BY=;
        b=g+zVxbL2z6mybLHi+2HTL/WIKOIaFujr2zSdTzumu2druuVWj2hZRlFkUIaOWWNDha
         KZtni230KYTxUEd2FaScZvv8WFgOaAhNnV0h6dUBTMmgSqIE14nzRchRaQ8dBsfa07F7
         W7upSvVEbdmjxVA7bCZij7EEV8DahImSa8H1K6hNVZDCb1yQTFmhcyRkmc/whr+5pxIb
         VIo92thFZ14Y8NZzHKKbVMl6UBsbfvcNMyBISOJjhb0VRCT/Fiy1YBV/XtFJLyo95q8G
         bhQY8h1fYoVasywlnd4P0r9Db7PaY2dS0ksn1aiDWwb7rV3c+mGhCR1iyyH41FS7fDR9
         7kPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689217338; x=1691809338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIFkxB9A0AOt1dYmcYEHChkUZQD7NhokkZtrgkit9BY=;
        b=PfCZenQrjl0CgeElzdxYBWbTykwRTngTuKDFZbCt0NNU79ohX3h3a+JgVIrWXpXZuW
         ITbdBCbCnuNQUF4gAMYqOtiJulRxHBYuIAPBEcYRRJ+cZlTIhZcJCghvMn2BDwvfDt9Q
         B8YNYuG7yL833ICgfOrKiu+WJFNP3mJrLUmnKPQW/GCjCMwE1NC30cFOYRV2BIfmuY+c
         3/lt7upvSg0utF4yQB6XfDMX4ByDt4Felo01Iro/wTOAb0ZMlP5176DdAcwJqypODfkv
         yi+D7A3W5OR26QGuR8DUdx2IM+zbJweSPSDbWaQ0yzniIOxtisk4FhvIWoboW+zlspH1
         A4og==
X-Gm-Message-State: ABy/qLaLn2+21z4zooRUtyDO4kBoBlwt3zooQtjJs9K676fqIti5ZyCD
        /d0mh6idmfmtSkE0rVIN/ojQhMMu9B35J4kxp54GSw==
X-Google-Smtp-Source: APBJJlG8TaltLxKm9J/vUdjmovKCz8knWSknq9x+hEMuJFHTC9iHbr6YIxHJ/dMRzFqyM5cbmshvaYQGamRnII3hpns=
X-Received: by 2002:ac8:5bd1:0:b0:3f8:1db6:201c with SMTP id
 b17-20020ac85bd1000000b003f81db6201cmr398644qtb.13.1689217338380; Wed, 12 Jul
 2023 20:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230712083037.4081444-1-tmricht@linux.ibm.com> <20230712083037.4081444-2-tmricht@linux.ibm.com>
In-Reply-To: <20230712083037.4081444-2-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 20:02:07 -0700
Message-ID: <CAP-5=fW3M-RaOF=3wBzyimc1oZwJ9cPndRsvVs0fG9=B+D0FoQ@mail.gmail.com>
Subject: Re: [PATCH] perf build: Fix broken feature check for clang due to C++
 standard and changed library packaging
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, wangnan0@huawei.com, jolsa@kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 1:35=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Perf build auto-detects features and packages already installed
> for its build. This is done in directory tools/build/feature. This
> directory contains small sample programs. When they successfully
> compile the necessary prereqs in form of libraries and header
> files are present.
>
> Such a check is also done for clang. And this check fails.
>
> Fix this and update to the latest C++ standard and use the
> new library provided by clang (which contains new packaging)
> see this link for reference:
>  https://fedoraproject.org/wiki/Changes/Stop-Shipping-Individual-Componen=
t-Libraries-In-clang-lib-Package
>
> Output before:
>  # rm -f ./test-clang.bin; make test-clang.bin; ./test-clang.bin; \
>         ll test-clang.make.output
>  g++  -MD -Wall -Werror -o test-clang.bin test-clang.cpp \
>                 > test-clang.make.output 2>&1 -std=3Dgnu++14 \
>         -I/usr/include          \
>         -L/usr/lib64            \
>         -Wl,--start-group -lclangBasic -lclangDriver    \
>           -lclangFrontend -lclangEdit -lclangLex        \
>           -lclangAST -Wl,--end-group                    \
>         -lLLVM-16       \
>                         \
>         > test-clang.make.output 2>&1
>  make: *** [Makefile:356: test-clang.bin] Error 1
>  -bash: ./test-clang.bin: No such file or directory
>  -rw-r--r--. 1 root root 252041 Jul 12 09:56 test-clang.make.output
>  #
>
> File test-clang.make.output contains many lines of unreferenced
> symbols.
>
> Output after:
>  # rm -f ./test-clang.bin; make test-clang.bin; ./test-clang.bin; \
>         cat test-clang.make.output
>  g++  -MD -Wall -Werror -o test-clang.bin test-clang.cpp \
>          > test-clang.make.output 2>&1 -std=3Dgnu++17     \
>         -I/usr/include          \
>         -L/usr/lib64            \
>         -Wl,--start-group -lclang-cpp -Wl,--end-group   \
>         -lLLVM-16       \
>                         \
>         > test-clang.make.output 2>&1
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Tested-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/build/feature/Makefile | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index f8db69654791..0b4a6e43c5cc 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -353,12 +353,10 @@ $(OUTPUT)test-llvm-version.bin:
>                 > $(@:.bin=3D.make.output) 2>&1
>
>  $(OUTPUT)test-clang.bin:
> -       $(BUILDXX) -std=3Dgnu++14                                 \
> +       $(BUILDXX) -std=3Dgnu++17                                 \
>                 -I$(shell $(LLVM_CONFIG) --includedir)          \
>                 -L$(shell $(LLVM_CONFIG) --libdir)              \
> -               -Wl,--start-group -lclangBasic -lclangDriver    \
> -                 -lclangFrontend -lclangEdit -lclangLex        \
> -                 -lclangAST -Wl,--end-group                    \
> +               -Wl,--start-group -lclang-cpp -Wl,--end-group   \
>                 $(shell $(LLVM_CONFIG) --libs Core option)      \
>                 $(shell $(LLVM_CONFIG) --system-libs)           \
>                 > $(@:.bin=3D.make.output) 2>&1
> --
> 2.41.0
>
