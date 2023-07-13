Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6376C75169F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjGMDKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjGMDKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:10:31 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EFE1BDC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:10:30 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-403b622101bso105361cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689217829; x=1691809829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCEbI3WgmGp1pRdtBWdu/+PPGiU0Pj/o+/7oiTniyaE=;
        b=Hg1CGXQ0eyM5/jE5SmlcTlo1bRmry0Wt9Vl2FzVAPRYpMMTj9uVyJmQtFcKikEXSTB
         B1cG/SdA3VD/wuesbYyHeJaaIvyBZwm72uzXcOFXKEzkOpeP8mQ+TSpGyZ68TxiA5hzd
         4nJO+mL7FXol+qEfzYM0i0rzMEQ7mmLDcaFH/2oxm+PbCKIpj4fOmg4CdznFuDgCZ5qi
         XonaexQDgP884JigkO5lDS3IMk7TIR16xhivyb4/oai+7V4aeqzq8QFGOXQBQ1UU2/Zm
         O4WvwDzz7X30j+2LpOFe9Nwr70u0SRsRiJcg1VjFYDgwIyvccFumbXd4pnr8s7PYi7U3
         IB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689217829; x=1691809829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCEbI3WgmGp1pRdtBWdu/+PPGiU0Pj/o+/7oiTniyaE=;
        b=AgbIMpaZ+VryBHuyOB4YlHpR6s0cPVVUA8SJqa6lltK/ohALmLhRBJEG2ivRfLtcWH
         UVxQDlu4JdaVD5lWUPL/To8vnQM/DseBfbG/MJXmdJ6GBJEAJ3CBRoIz0b/S3LT0yf4n
         dZ5O/dz+dH/BtQZ656JHKOrH5F2okuH6jDv0R2aeBXubag468PqdTAeKNp7a3qhiz+xq
         L2lkNAXTmjpFy6jijqQ6k+29IHyf+58N+nrTcyOuGy00b0q6wnidUiDAzs6bkSqdAh3Q
         /HTVFPG3qJ0ZzGwhyTVoMgO/UPqdDXaz3aaUyuDSgLCI9tC5bUOH5ZA+gvqpJ019KjXV
         Y6kw==
X-Gm-Message-State: ABy/qLZuz39EpUlFtFGgXn83MI9cr6OHeJsL3RUmlsBAuzNs8hU38nDP
        eaR1CMFWnqwRQKpVil2RMjyRAPjSA6/Of8U6lqSguw==
X-Google-Smtp-Source: APBJJlH79jPWzG5n9UA0czpeAGh9irvaLp4SsnIBSq4hmhIVAqPafLLD+MqdLwOqYP+Fs8W+vcZSUxgUYsb+cU46bpE=
X-Received: by 2002:a05:622a:307:b0:403:b1e5:bcae with SMTP id
 q7-20020a05622a030700b00403b1e5bcaemr454336qtw.10.1689217829371; Wed, 12 Jul
 2023 20:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230712083037.4081444-1-tmricht@linux.ibm.com>
In-Reply-To: <20230712083037.4081444-1-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 20:10:18 -0700
Message-ID: <CAP-5=fUM5w8o4LOh470ciNhvH3bRPnOQ8AojGcWNXeQJJq-TsQ@mail.gmail.com>
Subject: Re: [PATCH] perf build: Fix broken feature check for llvm due to C++ standard
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
> Such a check is also done for llvm. And this check fails.
> Fix this and update to the latest C++ standard.
>
> Output before:
>  # rm -f ./test-llvm.bin; make test-llvm.bin; ./test-llvm.bin
>  g++  -MD -Wall -Werror -o test-llvm.bin test-llvm.cpp \
>                 > test-llvm.make.output 2>&1 -std=3Dgnu++14 \
>         -I/usr/include          \
>         -L/usr/lib64            \
>         -lLLVM-16               \
>                         \
>         > test-llvm.make.output 2>&1
>
>  make: *** [Makefile:343: test-llvm.bin] Error 1
>  -bash: ./test-llvm.bin: No such file or directory
>  #
>
> Output after:
>  # rm -f ./test-llvm.bin; make test-llvm.bin; ./test-llvm.bin
>  g++  -MD -Wall -Werror -o test-llvm.bin test-llvm.cpp \
>                 > test-llvm.make.output 2>&1 -std=3Dgnu++17 \
>         -I/usr/include          \
>         -L/usr/lib64            \
>         -lLLVM-16               \
>                         \
>         > test-llvm.make.output 2>&1
>  Hello World!
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Tested-by: Ian Rogers <irogers@google.com>

Tested with clang/llvm 15.

Thanks,
Ian

> ---
>  tools/build/feature/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 0f0aa9b7d7b5..f8db69654791 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -340,7 +340,7 @@ $(OUTPUT)test-jvmti-cmlr.bin:
>         $(BUILD)
>
>  $(OUTPUT)test-llvm.bin:
> -       $(BUILDXX) -std=3Dgnu++14                                 \
> +       $(BUILDXX) -std=3Dgnu++17                                 \
>                 -I$(shell $(LLVM_CONFIG) --includedir)          \
>                 -L$(shell $(LLVM_CONFIG) --libdir)              \
>                 $(shell $(LLVM_CONFIG) --libs Core BPF)         \
> --
> 2.41.0
>
