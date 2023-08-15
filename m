Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C9177D2A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbjHOS6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbjHOS5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:57:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8F71FE2;
        Tue, 15 Aug 2023 11:57:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EC0961576;
        Tue, 15 Aug 2023 18:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB4AC433C7;
        Tue, 15 Aug 2023 18:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692125840;
        bh=WcEDKCUsjhr4cwMNn5jRu8EtHbRs3LwUKYQvvm6dKFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mI7eWHPhIZiEuHucqMXNlVCl1x0rvOt6iFKVikOxWJLEmHvVvicCOdqx2QI/+0PyH
         9Wuq16EMnEYOsBqlmmXPzbEwap6c3d+3hRRjIjPxxokZ/U9nrqWgYAKmxcMQx0u1iR
         rr2yFlKalA3pg7EGlX0IVsrn2SgaL3fZw+OTMRJG39uoAPmm0sLTVQg3juEZ5op+V6
         2ubdQhTU4waT+TweStzeIjyqC/1W15gMYv7L00A0Df7SM9b+LEuwhBGKGpNfQ9QI8x
         j1gDQK6CgRRtTAUAWgcj1Z3AUVNet3rD+0DWjlBQecKJ3AzWrhgC7xdeGi+Rj1yMlj
         nBnOh33/kDssQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 93785404DF; Tue, 15 Aug 2023 15:57:17 -0300 (-03)
Date:   Tue, 15 Aug 2023 15:57:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>,
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
Message-ID: <ZNvKjeFkXY8ezf9e@kernel.org>
References: <20230606014559.21783-1-leo.yan@linaro.org>
 <CAP-5=fV1m440mKc0R=m5C4N2NtoiixchtnpX2eR3PA_5hXbqEQ@mail.gmail.com>
 <ZNvCxM/ULdUfzHtR@kernel.org>
 <ZNvHx+KxIL6JzEl/@kernel.org>
 <ZNvJdsVmmAWLmfH6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNvJdsVmmAWLmfH6@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 15, 2023 at 03:52:38PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Aug 15, 2023 at 03:45:27PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Agreed, applied to perf-tools-next, sorry for the delay.
> > 
> > Had to add this to make 'perf test python' to work. Please run 'perf
> > test' before sending patches.
> 
> One more, please also do a 'make -C tools/perf build-test', with it I
> caught this:
> 
>          make_no_libunwind_O: cd . && make NO_LIBUNWIND=1 FEATURES_DUMP=/var/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.yeEGyQq2HR DESTDIR=/tmp/tmp.ITgoO16jjH
> cd . && make NO_LIBUNWIND=1 FEATURES_DUMP=/var/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.yeEGyQq2HR DESTDIR=/tmp/tmp.ITgoO16jjH

+#include "util/env.h"

As now we need it for perf_env__arch(ui->machine->env)
 
>   CC      /tmp/tmp.yeEGyQq2HR/util/expr-flex.o
> util/unwind-libdw.c: In function ‘memory_read’:
> util/unwind-libdw.c:173:28: error: implicit declaration of function ‘perf_env__arch’ [-Werror=implicit-function-declaration]
>   173 |         const char *arch = perf_env__arch(ui->machine->env);
>       |                            ^~~~~~~~~~~~~~
> util/unwind-libdw.c:173:28: error: initialization of ‘const char *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
> util/unwind-libdw.c: In function ‘unwind__get_entries’:
> util/unwind-libdw.c:258:28: error: initialization of ‘const char *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
>   258 |         const char *arch = perf_env__arch(ui_buf.machine->env);
>       |                            ^~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:98: /tmp/tmp.yeEGyQq2HR/util/unwind-libdw.o] Error 1
> make[6]: *** Waiting for unfinished jobs....
> make[5]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:150: util] Error 2
> make[4]: *** [Makefile.perf:662: /tmp/tmp.yeEGyQq2HR/perf-in.o] Error 2
> make[4]: *** Waiting for unfinished jobs....
>   CC      /tmp/tmp.yeEGyQq2HR/pmu-events/pmu-events.o
>   LD      /tmp/tmp.yeEGyQq2HR/pmu-events/pmu-events-in.o
> make[3]: *** [Makefile.perf:238: sub-make] Error 2
> make[2]: *** [Makefile:70: all] Error 2
> make[1]: *** [tests/make:337: make_no_libunwind_O] Error 1
> make: *** [Makefile:103: build-test] Error 2
> make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'
> 
> real	1m29.784s
> user	10m41.597s
> sys	2m55.948s
> ⬢[acme@toolbox perf-tools-next]$
> 
> I'm trying to fix

-- 

- Arnaldo
