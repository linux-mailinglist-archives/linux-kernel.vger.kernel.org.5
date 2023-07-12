Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7147513A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjGLWhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGLWhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:37:51 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D2C1FDB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:37:49 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4036bd4fff1so59111cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689201468; x=1691793468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSLm7OgvDjCIbcXOw5uuAV7h48kPlKZpDxLeFUfyiq4=;
        b=rnQ9o0E2l/BiQrlY+riM1wbukDiYm1B48anGRuDdYPOxCaotBOlbTDOO8nAHSy2B6a
         fNyQAt8/reux4SzDQmE5JW0MF65yecvSCO+embQk0rQq41N5BYc9Dqs7Db0v/w605Kg8
         PfSC7f7xFOYzyz+/n3CZtnU/jGwKQlLlAh+2vMvMSP3l5EqB++UphBZkrAyKuGS6iFrE
         hmdPG10EKrbRyzKPRiDg2c29TjTMJJbLlDzAIJcPOiHVXYwUCvjhAVA5jYRBQEVH5tI+
         +KuWX5z2t7lk/J0pA9vD4t0JSBrBBzrGmPGzgmYFfawsOyMj7Ln4pHNu2W40bc01DCbt
         fVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689201468; x=1691793468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSLm7OgvDjCIbcXOw5uuAV7h48kPlKZpDxLeFUfyiq4=;
        b=VNnVsUhRpM28K5r4lj5Vk332F43OZqdmbMpTDV7VdXi4BBqGetdStRKWXM4tiDqc+c
         8/tkkD5JK4kG6/QOh2/+fckNZ4qwx2VN+KuyOy+pdz8mYFFTOajfI5TuJUqm2e2UF4ZS
         isTSjAavZUllWHz6zPdnbXmPW47k+DeCESLh5z3O7odrpalgV0JD5BYXRjtjcCt9YUb6
         VBFUWulh4On5iIL+Wl56nsMSFTNnoSVgc9kAS9cpa87OFAfUwIOFJ0zzWf4q/jLOvroo
         jMLLryOiBy30hwUopkhcT7lMZu6rhI78PikR/YgBwcIXLc2YsB7bWn+tUSu5qF1Lje29
         epxw==
X-Gm-Message-State: ABy/qLYiomh7loUIB7vFMwnNP7ka/46VFhpy4viGzNl92093E412+03h
        hGQ06oXTSBHe22sD5O3khoP+RUlwV/0kBGjSoU08uA==
X-Google-Smtp-Source: APBJJlFoMk+z4lKf+SvAMxufHc4BBJvzVx9uo4K8JqABLWNqGUM9+naj9MCfru1kTFeZ7n5YwjAuktO0HSMGF1b6IGQ=
X-Received: by 2002:ac8:5bd1:0:b0:3f8:1db6:201c with SMTP id
 b17-20020ac85bd1000000b003f81db6201cmr354287qtb.13.1689201468137; Wed, 12 Jul
 2023 15:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230606014559.21783-1-leo.yan@linaro.org>
In-Reply-To: <20230606014559.21783-1-leo.yan@linaro.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 15:37:36 -0700
Message-ID: <CAP-5=fV1m440mKc0R=m5C4N2NtoiixchtnpX2eR3PA_5hXbqEQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] perf parse-regs: Refactor architecture functions
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ming Wang <wangming01@loongson.cn>,
        Eric Lin <eric.lin@sifive.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 6:46=E2=80=AFPM Leo Yan <leo.yan@linaro.org> wrote:
>
> This patch series is to refactor arch related functions for register
> parsing, which follows up the discussion for v1:
> https://lore.kernel.org/lkml/20230520025537.1811986-1-leo.yan@linaro.org/
>
> Compared to patch series v1, this patch series introduces new functions
> perf_arch_reg_{ip|sp}(), so this can allow the tool to support cross
> analysis.
>
> To verify the cross analysis, I used below steps:
>
> - Firstly, I captured perf data on Arm64 machine:
>
>   $ perf record --call-graph fp -- ./test_program
>
>   Or ...
>
>   $ perf record --call-graph dwarf -- ./test_program
>
>   Then, I also archived associated debug data:
>
>   $ perf archive
>
> - Secondly, I copied the perf data file and debug tar file on my x86
>   machine:
>
>   $ scp perf.data perf.data.tar.bz2 leoy@IP_ADDRESS:/target/path/
>
> - On x86 machine, I need to build perf for support multi-arch unwinding:
>
>   $ git clone http://git.savannah.gnu.org/r/libunwind.git
>   $ cd libunwind
>   $ autoreconf -i
>
>   # Build and install libunwind aarch64:
>   $ ./configure prefix=3D/home/leoy/Work/tools/libunwind/install/ \
>         --target=3Daarch64-linux-gnu CC=3Dx86_64-linux-gnu-gcc
>   $ make && make install
>
>   # Build and install libunwind x86:
>   $ ./configure prefix=3D/home/leoy/Work/tools/libunwind/install/ \
>         --target=3Dx86_64-linux-gnu CC=3Dx86_64-linux-gnu-gcc
>   $ make && make install
>
> - Build perf tool for support multi-archs:
>
>   $ cd $LINUX/tools/perf
>   $ make VF=3D1 DEBUG=3D1 LIBUNWIND_DIR=3D/home/leoy/Work/tools/libunwind=
/install
>
> At the end, I verified the x86 perf tool can do cross analysis for aarch6=
4's
> perf data file.
>
> Note, I still see x86 perf tool cannot display the complete callgraph
> for aarch64, but it should not the issue caused by this series, which
> will be addressed by separate patches.
>
> I also built this patch series on my Arm64 and x86 machines, both can
> compile perf tool successfully; but I have no chance to build other
> archs natively.
>
> Changes from v1:
> - For support cross analysis for IP/SP registers, introduced patch 0002
>   (James Clark, Ian Rogers).
>
>
> Leo Yan (6):
>   perf parse-regs: Refactor arch register parsing functions
>   perf parse-regs: Introduce functions perf_arch_reg_{ip|sp}()
>   perf unwind: Use perf_arch_reg_{ip|sp}() to substitute macros
>   perf parse-regs: Remove unused macros PERF_REG_{IP|SP}
>   perf parse-regs: Remove PERF_REGS_{MAX|MASK} from common code
>   perf parse-regs: Move out arch specific header from util/perf_regs.h

Sorry for the slow review. For the series:
Acked-by: Ian Rogers <irogers@google.com>

Some thoughts:
uint64_t __perf_reg_ip_arm(void)
uint64_t seems like we're giving a lot of space for future register
encodings. I think some of the other functions use this size of value
due to returning a bitmap/mask, but here it isn't clear and just feels
excessive.

Do we need the "__" prefix on all the functions?

In Makefile.config there are NO_PERF_REGS and CONFIG_PERF_REGS then
the define HAVE_PERF_REGS_SUPPORT. Is this still relevant? If we had
an architecture with no support, couldn't it still read a perf.data
file from a supported architecture? It would be nice to remove at
least NO_PERF_REGS and HAVE_PERF_REGS_SUPPORT.

This change is very worthwhile fix and cleanup, it didn't introduce
what is pondered above, hence the acked-by.

Thanks!
Ian

>  tools/perf/arch/arm/include/perf_regs.h       |   3 -
>  tools/perf/arch/arm/util/perf_regs.c          |  11 +
>  tools/perf/arch/arm/util/unwind-libdw.c       |   1 +
>  tools/perf/arch/arm64/include/perf_regs.h     |   3 -
>  tools/perf/arch/arm64/util/machine.c          |   1 +
>  tools/perf/arch/arm64/util/perf_regs.c        |   6 +
>  tools/perf/arch/arm64/util/unwind-libdw.c     |   1 +
>  tools/perf/arch/csky/include/perf_regs.h      |   3 -
>  tools/perf/arch/csky/util/perf_regs.c         |  11 +
>  tools/perf/arch/csky/util/unwind-libdw.c      |   1 +
>  tools/perf/arch/loongarch/include/perf_regs.h |   2 -
>  tools/perf/arch/loongarch/util/perf_regs.c    |  11 +
>  tools/perf/arch/loongarch/util/unwind-libdw.c |   1 +
>  tools/perf/arch/mips/include/perf_regs.h      |   2 -
>  tools/perf/arch/mips/util/perf_regs.c         |  11 +
>  tools/perf/arch/powerpc/include/perf_regs.h   |   3 -
>  tools/perf/arch/powerpc/util/perf_regs.c      |   6 +
>  tools/perf/arch/powerpc/util/unwind-libdw.c   |   1 +
>  tools/perf/arch/riscv/include/perf_regs.h     |   3 -
>  tools/perf/arch/riscv/util/perf_regs.c        |  11 +
>  tools/perf/arch/riscv/util/unwind-libdw.c     |   1 +
>  tools/perf/arch/s390/include/perf_regs.h      |   3 -
>  tools/perf/arch/s390/util/perf_regs.c         |  11 +
>  tools/perf/arch/s390/util/unwind-libdw.c      |   1 +
>  tools/perf/arch/x86/include/perf_regs.h       |   2 -
>  tools/perf/arch/x86/util/perf_regs.c          |   6 +
>  tools/perf/arch/x86/util/unwind-libdw.c       |   1 +
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/evsel.c                       |   6 +-
>  tools/perf/util/libunwind/arm64.c             |   2 -
>  tools/perf/util/libunwind/x86_32.c            |   2 -
>  tools/perf/util/perf-regs-arch/Build          |   9 +
>  .../util/perf-regs-arch/perf_regs_aarch64.c   |  96 +++
>  .../perf/util/perf-regs-arch/perf_regs_arm.c  |  60 ++
>  .../perf/util/perf-regs-arch/perf_regs_csky.c | 100 +++
>  .../util/perf-regs-arch/perf_regs_loongarch.c |  91 +++
>  .../perf/util/perf-regs-arch/perf_regs_mips.c |  87 ++
>  .../util/perf-regs-arch/perf_regs_powerpc.c   | 145 ++++
>  .../util/perf-regs-arch/perf_regs_riscv.c     |  92 +++
>  .../perf/util/perf-regs-arch/perf_regs_s390.c |  96 +++
>  .../perf/util/perf-regs-arch/perf_regs_x86.c  |  98 +++
>  tools/perf/util/perf_regs.c                   | 772 ++----------------
>  tools/perf/util/perf_regs.h                   |  49 +-
>  tools/perf/util/unwind-libdw.c                |   7 +-
>  tools/perf/util/unwind-libunwind-local.c      |   6 +-
>  tools/perf/util/unwind.h                      |   8 -
>  46 files changed, 1078 insertions(+), 766 deletions(-)
>  create mode 100644 tools/perf/util/perf-regs-arch/Build
>  create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
>  create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_arm.c
>  create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_csky.c
>  create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_loongarch.c
>  create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_mips.c
>  create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
>  create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_riscv.c
>  create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_s390.c
>  create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_x86.c
>
> --
> 2.34.1
>
