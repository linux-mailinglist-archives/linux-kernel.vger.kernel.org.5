Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AD67D0511
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346705AbjJSWyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346697AbjJSWyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:54:17 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979C498;
        Thu, 19 Oct 2023 15:54:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so198164a12.2;
        Thu, 19 Oct 2023 15:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697756054; x=1698360854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znKTjYCMK7qVlPe1x85VLsQxhjgS/CN/1N2ibCS0Pek=;
        b=ToZ/deRvOJgo7YWy09hdxkSvDUdtiNPE6yGKf7IsAh+Ao+YfgXFcKBx3vB2x8xEf+l
         YhNeZZPft61eii3LD7CFV7oSTZkkdtq/X4tGQDLBGVrSLt3D6JhdXugX+vFGQuIZLp3Y
         9D9YsNX5QEGjPikAayXcSJxKR8AJxy55WFfZoJ2dbJLtd6bHxSCpreRNjOcRqpRaeH9f
         08XdooA+mY0lmstpvCssiEJg36IUZgWzp4Yqmmf5Gm0xnCK1rBqLM4JDLx7PmxOkBSPH
         WT763tl1DP3/PsGKWuUw8D6owr9jLft3swwOoTidcw69I3p+jWbj97bfe1hG5JwZuvMY
         NdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697756054; x=1698360854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znKTjYCMK7qVlPe1x85VLsQxhjgS/CN/1N2ibCS0Pek=;
        b=nypuCifFDmRzA6zPalA3OAYXGHISLv7FBFlWH3rjIQCkm2cUcWnyZ3CpSMPt5Yz2Qz
         GNrHiHpDpOoJmsstts2lOj9eOw90Q3UN4QWBmuZlK5ykj1USeuQjp2NLLtv7R10fIlZi
         MkO3+kdpRJiiXDRFwcyeZ1nWV8SuTL0+bx/KGpT1tIg9y9UmS7WsHk/kMUPqmshgUwvo
         cux3kdEwpoEiQddCpRlHd227VOWKh90GMEiUc50sAvPMMq0KEUHEP35MGw595qaFr+4E
         hjcuam9yIYIUB57yYdWrgH8WrwY2P/rOZmkQYBQfFjZDx0HTB79B72Stpr8AlBSaHSDG
         +xjA==
X-Gm-Message-State: AOJu0YxvBHX5I3Efyunu6QBQvk2g9ATmNtmSAM6tJ7dO68/n71XOEeo2
        6ecgchJKpXWjTQYJWNHc0Y2dlLtzFVFT3zSpl73I19lp
X-Google-Smtp-Source: AGHT+IHy65GTNdlUTy4eWmv1QGEZswUfHu0S4xVwjoBxCKL4FFUBpAf6AJ5h6EW3YDS7FnH5QqZ8dN+gP6T4uQF8cf8=
X-Received: by 2002:ac2:5470:0:b0:500:a6c1:36f7 with SMTP id
 e16-20020ac25470000000b00500a6c136f7mr73421lfn.3.1697755649162; Thu, 19 Oct
 2023 15:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <ZTGc8S293uaTqHja@kernel.org>
In-Reply-To: <ZTGc8S293uaTqHja@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 19 Oct 2023 15:47:17 -0700
Message-ID: <CAEf4BzYC01Uvj5R+eipu8wmWpNH6K_=_ptj-Wxezdk_O7AFAyA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools build: Fix llvm feature detection, still used
 by bpftool
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Manu Bretelle <chantr4@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Fangrui Song <maskray@google.com>,
        He Kuang <hekuang@huawei.com>, Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, llvm@lists.linux.dev,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Tom Rix <trix@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Yonghong Song <yhs@fb.com>, YueHaibing <yuehaibing@huawei.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 2:17=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> When removing the BPF event for perf a feature test that checks if the
> llvm devel files are availabe was removed but that is also used by
> bpftool.
>
> bpftool uses it to decide what kind of disassembly it will use: llvm or
> binutils based.
>
> Removing the tools/build/feature/test-llvm.cpp file made bpftool to
> always fallback to binutils disassembly, even with the llvm devel files
> installed, fix it by restoring just that small test-llvm.cpp test file.
>
> Fixes: 56b11a2126bf2f42 ("perf bpf: Remove support for embedding clang fo=
r compiling BPF events (-e foo.c)")

Should we route this through the bpf-next tree to get the fix for
bpftool into Github mirror ASAP?

> Reported-by: Manu Bretelle <chantr4@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Carsten Haitzler <carsten.haitzler@arm.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Fangrui Song <maskray@google.com>
> Cc: He Kuang <hekuang@huawei.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@arm.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: llvm@lists.linux.dev
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Quentin Monnet <quentin@isovalent.com>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Wang Nan <wangnan0@huawei.com>
> Cc: Wang ShaoBo <bobo.shaobowang@huawei.com>
> Cc: Yang Jihong <yangjihong1@huawei.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: YueHaibing <yuehaibing@huawei.com>
> Link: https://lore.kernel.org/lkml/ZTGa0Ukt7QyxWcVy@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/build/feature/test-llvm.cpp | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 tools/build/feature/test-llvm.cpp
>
> diff --git a/tools/build/feature/test-llvm.cpp b/tools/build/feature/test=
-llvm.cpp
> new file mode 100644
> index 0000000000000000..88a3d1bdd9f6978e
> --- /dev/null
> +++ b/tools/build/feature/test-llvm.cpp
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "llvm/Support/ManagedStatic.h"
> +#include "llvm/Support/raw_ostream.h"
> +#define NUM_VERSION (((LLVM_VERSION_MAJOR) << 16) + (LLVM_VERSION_MINOR =
<< 8) + LLVM_VERSION_PATCH)
> +
> +#if NUM_VERSION < 0x030900
> +# error "LLVM version too low"
> +#endif
> +int main()
> +{
> +       llvm::errs() << "Hello World!\n";
> +       llvm::llvm_shutdown();
> +       return 0;
> +}
> --
> 2.41.0
>
