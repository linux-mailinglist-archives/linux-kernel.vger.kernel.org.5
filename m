Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FB477F2EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349367AbjHQJNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349362AbjHQJNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:13:10 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AB0210E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:13:03 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68934672e7bso614892b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692263583; x=1692868383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K91jE8EwBVM4Sp8konKF5372FTO4dIFG97TRQaKzO0E=;
        b=xQHA384K0ZO0OrkqcjlZ6MKQ35pNbmw9PsSE4SF6cz2yKQ3DvFVOMQ4vWLngH8n3Zs
         fXMdjr7lAbZajSWjm05I7a3lCsRNAN+Kp1Hk6y3ybWbpRnIPvZNzHngJggX1uKF3yQ5v
         3nRKEF3MzfvDS1s5QwUjp05Z5euKAQ9TKU11o9wNgMddyQjbG+MskSZMHMcfQ3I959QT
         0SSIkbPU0hxUBI8au0kBoaH3BoAEinsMkJTUNMvHnZkHve+ZSdreLauiStkkmDd1wfu9
         YjJKb8dlZY4a8Gs1yZDci9Xh2D2U89tlo8115a6S1ppGfok08LT2gWwagiy32jv1zFOA
         pAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692263583; x=1692868383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K91jE8EwBVM4Sp8konKF5372FTO4dIFG97TRQaKzO0E=;
        b=PwqVGB+UkDZdthHtdkbXA8KRNNJ3JGCw8yFg3OsMdjcR2hPQzZsvAKVBSK5e+W1alz
         EFE0oDjYtU+82VRwl5TpK4iqmbnIu0hUvDNQA1b3q2XmHp95rfmFJyZQSC0ICgMgQiUy
         +Wq01+Yb7Fz7CAOuZHZ5sW/XU7A9+z6+8S1ndLvi4ZZr6y0QsU02zef3lEwklIIqHSse
         nhxT8iEC6HwBd4VbHvqd5Mun9+eiqepDFhHIzmi6TStfb7joMDsNLCx8p2xDE/1SzUi+
         r9pi3/k/HdHB3ytLUvtjmNtjCj2OALorhupxt5yvB80GEjYp05mb3zN67BQ63c2+nSPp
         hn/A==
X-Gm-Message-State: AOJu0YyzaOkCGid0YeaQgAjioZS+qKLcFADD/1hUOUKQ/fFHnwgiG12b
        1qDOXLbCg1bEEAUyagR9FL3bgQ==
X-Google-Smtp-Source: AGHT+IEIqqs40KIfRVtyjO6BfEq3bmiOt6WXaiauiTs9IDaui+L8JnWcsz+icvL898LfGWIQpaV3xg==
X-Received: by 2002:a05:6a20:3251:b0:130:b19d:ec1f with SMTP id hm17-20020a056a20325100b00130b19dec1fmr4423496pzc.11.1692263582886;
        Thu, 17 Aug 2023 02:13:02 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ce8200b001bbfa86ca3bsm14709012plg.78.2023.08.17.02.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 02:13:02 -0700 (PDT)
Date:   Thu, 17 Aug 2023 17:12:54 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
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
Subject: Re: [PATCH v2 0/6] perf parse-regs: Refactor architecture functions
Message-ID: <20230817091254.GA176609@leoy-huanghe.lan>
References: <20230606014559.21783-1-leo.yan@linaro.org>
 <CAP-5=fV1m440mKc0R=m5C4N2NtoiixchtnpX2eR3PA_5hXbqEQ@mail.gmail.com>
 <ZNvCxM/ULdUfzHtR@kernel.org>
 <ZNvHx+KxIL6JzEl/@kernel.org>
 <ZNvJdsVmmAWLmfH6@kernel.org>
 <ZNvKjeFkXY8ezf9e@kernel.org>
 <20230816020715.GA135657@leoy-huanghe.lan>
 <ZNy3D6DV3Q9YjxKd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNy3D6DV3Q9YjxKd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 08:46:23AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 16, 2023 at 10:07:15AM +0800, Leo Yan escreveu:
> > On Tue, Aug 15, 2023 at 03:57:17PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Aug 15, 2023 at 03:52:38PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Tue, Aug 15, 2023 at 03:45:27PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > > Agreed, applied to perf-tools-next, sorry for the delay.
> > > > > 
> > > > > Had to add this to make 'perf test python' to work. Please run 'perf
> > > > > test' before sending patches.
> > > > 
> > > > One more, please also do a 'make -C tools/perf build-test', with it I
> > > > caught this:
> > > > 
> > > >          make_no_libunwind_O: cd . && make NO_LIBUNWIND=1 FEATURES_DUMP=/var/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.yeEGyQq2HR DESTDIR=/tmp/tmp.ITgoO16jjH
> > > > cd . && make NO_LIBUNWIND=1 FEATURES_DUMP=/var/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.yeEGyQq2HR DESTDIR=/tmp/tmp.ITgoO16jjH
> > > 
> > > +#include "util/env.h"
> > > 
> > > As now we need it for perf_env__arch(ui->machine->env)
> > 
> > Sorry for inconvenience.
> > 
> > I saw this patch series has been picked into the branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf-tools-next
> > 
> > If want me to follow up, let me know.  Thank you!
> 
> Right, I'll fix this ones:
> 
> [perfbuilder@five ~]$ grep "unused variable" dm.log/*:*
> dm.log/ubuntu:18.04-x-m68k:util/evsel.c:848:14: error: unused variable 'arch' [-Werror=unused-variable]
> dm.log/ubuntu:18.04-x-riscv64:util/evsel.c:848:14: error: unused variable 'arch' [-Werror=unused-variable]
> dm.log/ubuntu:18.04-x-sh4:util/evsel.c:848:14: error: unused variable 'arch' [-Werror=unused-variable]
> dm.log/ubuntu:18.04-x-sparc64:util/evsel.c:848:14: error: unused variable 'arch' [-Werror=unused-variable]
> [perfbuilder@five ~]$
> 
> And move that to perf-tools-next, we can go on from there.
> 
> The above is because we don't define CONFIG_PERF_REGS for these
> architectures and thus that variable ends up not being used, so I'm
> fixing up like below, in the cset where you made DWARF_MINIMAL_REGS
> receive the arch parameter.

I reviewed your below amended change, it looks good to me.

And I tested the latest perf-tools-next branch for both native and cross
register parsing with perf Arm64 binaries.  Looks good to me.

Thanks a lot for fixing up!

> Also I haven't checked how gracefully we react when processing a
> perf.data collected in one of those unsupported arches, can you please
> check?

At the first glance, we can add checking arch support of register
parsing in the function callchain_param_setup(), which is invoked by
`perf report` and `perf script`, but we need to handle `perf top`
specifically.  Or we can consider to add checking in the function
__parse_callchain_report_opt().

Anyway, I will look into deails and work out patches.

Thanks,
Leo

> - Arnaldo
> 
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index 790c1a26bbfe9b4b..de1673057e502de9 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -32,9 +32,6 @@ extern const struct sample_reg sample_reg_masks[];
>  
>  #include <perf_regs.h>
>  
> -#define DWARF_MINIMAL_REGS(arch)	\
> -	((1ULL << perf_arch_reg_ip(arch)) | (1ULL << perf_arch_reg_sp(arch)))
> -
>  const char *perf_reg_name(int id, const char *arch);
>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
>  uint64_t perf_arch_reg_ip(const char *arch);
> @@ -67,11 +64,19 @@ const char *__perf_reg_name_x86(int id);
>  uint64_t __perf_reg_ip_x86(void);
>  uint64_t __perf_reg_sp_x86(void);
>  
> +static inline uint64_t DWARF_MINIMAL_REGS(const char *arch)
> +{
> +	return (1ULL << perf_arch_reg_ip(arch)) | (1ULL << perf_arch_reg_sp(arch));
> +}
> +
>  #else
>  #define PERF_REGS_MASK	0
>  #define PERF_REGS_MAX	0
>  
> -#define DWARF_MINIMAL_REGS(arch)	PERF_REGS_MASK
> +static inline uint64_t DWARF_MINIMAL_REGS(const char *arch __maybe_unused)
> +{
> +	return PERF_REGS_MASK;
> +}
>  
>  static inline const char *perf_reg_name(int id __maybe_unused, const char *arch __maybe_unused)
>  {
>  
> > > >   CC      /tmp/tmp.yeEGyQq2HR/util/expr-flex.o
> > > > util/unwind-libdw.c: In function ‘memory_read’:
> > > > util/unwind-libdw.c:173:28: error: implicit declaration of function ‘perf_env__arch’ [-Werror=implicit-function-declaration]
> > > >   173 |         const char *arch = perf_env__arch(ui->machine->env);
> > > >       |                            ^~~~~~~~~~~~~~
> > > > util/unwind-libdw.c:173:28: error: initialization of ‘const char *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
> > > > util/unwind-libdw.c: In function ‘unwind__get_entries’:
> > > > util/unwind-libdw.c:258:28: error: initialization of ‘const char *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
> > > >   258 |         const char *arch = perf_env__arch(ui_buf.machine->env);
> > > >       |                            ^~~~~~~~~~~~~~
> > > > cc1: all warnings being treated as errors
> > > > make[6]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:98: /tmp/tmp.yeEGyQq2HR/util/unwind-libdw.o] Error 1
> > > > make[6]: *** Waiting for unfinished jobs....
> > > > make[5]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:150: util] Error 2
> > > > make[4]: *** [Makefile.perf:662: /tmp/tmp.yeEGyQq2HR/perf-in.o] Error 2
> > > > make[4]: *** Waiting for unfinished jobs....
> > > >   CC      /tmp/tmp.yeEGyQq2HR/pmu-events/pmu-events.o
> > > >   LD      /tmp/tmp.yeEGyQq2HR/pmu-events/pmu-events-in.o
> > > > make[3]: *** [Makefile.perf:238: sub-make] Error 2
> > > > make[2]: *** [Makefile:70: all] Error 2
> > > > make[1]: *** [tests/make:337: make_no_libunwind_O] Error 1
> > > > make: *** [Makefile:103: build-test] Error 2
> > > > make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'
> > > > 
> > > > real	1m29.784s
> > > > user	10m41.597s
> > > > sys	2m55.948s
> > > > ⬢[acme@toolbox perf-tools-next]$
> > > > 
> > > > I'm trying to fix
> > > 
> > > -- 
> > > 
> > > - Arnaldo
> 
> -- 
> 
> - Arnaldo
