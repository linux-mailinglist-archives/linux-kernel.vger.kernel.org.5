Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB5F77D1B5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbjHOSYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbjHOSYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:24:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF0CE52;
        Tue, 15 Aug 2023 11:24:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD17B65874;
        Tue, 15 Aug 2023 18:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8874C433C8;
        Tue, 15 Aug 2023 18:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692123848;
        bh=SsbeNONUUIyspJrA7/OhX+EylvabLswNFMu31Y+23z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j+KNtdKHYKXl7VJYBnY+JJWYpp/VRA2CXUlBvpgpQbf6m4jeRVqcKSCvKbZc+Gnl9
         9H4RMbDdbVFrIuJ+DgKHBRTQY/B6TgkIWod1zmkTQEGpbRl2SkSj4xowoP4EcP2AEi
         w4eMhdSI0YOnrWEI4s861fC526uUaeJds8ShqgZ/pJXqAScEnn7OstLVxegAPd7cxb
         v+K73Yw9SU+MJA0cUdtyy8mgX76Il24D0MqbSJFIUc3KRiKxfsrYYe/E/OLhEjLYiV
         Lwnq03xgNKq7S8Dz95fAsdfkneqRwkDdZ44x/ryV3Oo8Y8Vv/ZRqhxrsm8B2vN/y9R
         iC2sfuF8v1kbA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E1388404DF; Tue, 15 Aug 2023 15:24:04 -0300 (-03)
Date:   Tue, 15 Aug 2023 15:24:04 -0300
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
Message-ID: <ZNvCxM/ULdUfzHtR@kernel.org>
References: <20230606014559.21783-1-leo.yan@linaro.org>
 <CAP-5=fV1m440mKc0R=m5C4N2NtoiixchtnpX2eR3PA_5hXbqEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV1m440mKc0R=m5C4N2NtoiixchtnpX2eR3PA_5hXbqEQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 12, 2023 at 03:37:36PM -0700, Ian Rogers escreveu:
> On Mon, Jun 5, 2023 at 6:46 PM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > This patch series is to refactor arch related functions for register
> > parsing, which follows up the discussion for v1:
> > https://lore.kernel.org/lkml/20230520025537.1811986-1-leo.yan@linaro.org/
> >
> > Compared to patch series v1, this patch series introduces new functions
> > perf_arch_reg_{ip|sp}(), so this can allow the tool to support cross
> > analysis.
> >
> > To verify the cross analysis, I used below steps:
> >
> > - Firstly, I captured perf data on Arm64 machine:
> >
> >   $ perf record --call-graph fp -- ./test_program
> >
> >   Or ...
> >
> >   $ perf record --call-graph dwarf -- ./test_program
> >
> >   Then, I also archived associated debug data:
> >
> >   $ perf archive
> >
> > - Secondly, I copied the perf data file and debug tar file on my x86
> >   machine:
> >
> >   $ scp perf.data perf.data.tar.bz2 leoy@IP_ADDRESS:/target/path/
> >
> > - On x86 machine, I need to build perf for support multi-arch unwinding:
> >
> >   $ git clone http://git.savannah.gnu.org/r/libunwind.git
> >   $ cd libunwind
> >   $ autoreconf -i
> >
> >   # Build and install libunwind aarch64:
> >   $ ./configure prefix=/home/leoy/Work/tools/libunwind/install/ \
> >         --target=aarch64-linux-gnu CC=x86_64-linux-gnu-gcc
> >   $ make && make install
> >
> >   # Build and install libunwind x86:
> >   $ ./configure prefix=/home/leoy/Work/tools/libunwind/install/ \
> >         --target=x86_64-linux-gnu CC=x86_64-linux-gnu-gcc
> >   $ make && make install
> >
> > - Build perf tool for support multi-archs:
> >
> >   $ cd $LINUX/tools/perf
> >   $ make VF=1 DEBUG=1 LIBUNWIND_DIR=/home/leoy/Work/tools/libunwind/install
> >
> > At the end, I verified the x86 perf tool can do cross analysis for aarch64's
> > perf data file.
> >
> > Note, I still see x86 perf tool cannot display the complete callgraph
> > for aarch64, but it should not the issue caused by this series, which
> > will be addressed by separate patches.
> >
> > I also built this patch series on my Arm64 and x86 machines, both can
> > compile perf tool successfully; but I have no chance to build other
> > archs natively.
> >
> > Changes from v1:
> > - For support cross analysis for IP/SP registers, introduced patch 0002
> >   (James Clark, Ian Rogers).
> >
> >
> > Leo Yan (6):
> >   perf parse-regs: Refactor arch register parsing functions
> >   perf parse-regs: Introduce functions perf_arch_reg_{ip|sp}()
> >   perf unwind: Use perf_arch_reg_{ip|sp}() to substitute macros
> >   perf parse-regs: Remove unused macros PERF_REG_{IP|SP}
> >   perf parse-regs: Remove PERF_REGS_{MAX|MASK} from common code
> >   perf parse-regs: Move out arch specific header from util/perf_regs.h
> 
> Sorry for the slow review. For the series:
> Acked-by: Ian Rogers <irogers@google.com>
> 
> Some thoughts:
> uint64_t __perf_reg_ip_arm(void)
> uint64_t seems like we're giving a lot of space for future register
> encodings. I think some of the other functions use this size of value
> due to returning a bitmap/mask, but here it isn't clear and just feels
> excessive.
> 
> Do we need the "__" prefix on all the functions?
> 
> In Makefile.config there are NO_PERF_REGS and CONFIG_PERF_REGS then
> the define HAVE_PERF_REGS_SUPPORT. Is this still relevant? If we had
> an architecture with no support, couldn't it still read a perf.data
> file from a supported architecture? It would be nice to remove at
> least NO_PERF_REGS and HAVE_PERF_REGS_SUPPORT.
> 
> This change is very worthwhile fix and cleanup, it didn't introduce
> what is pondered above, hence the acked-by.

Agreed, applied to perf-tools-next, sorry for the delay.

- Arnaldo
