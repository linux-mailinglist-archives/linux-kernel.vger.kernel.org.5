Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4DF77D1CF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbjHOS1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239138AbjHOS0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:26:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C5C1BEB;
        Tue, 15 Aug 2023 11:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1396663F2B;
        Tue, 15 Aug 2023 18:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494A9C433C7;
        Tue, 15 Aug 2023 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692124010;
        bh=GtF+IvGHB4Z4BZ8g2oDDGN+Mv2CJPMog9By/QT4FL4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EM5zDvBWlYret5z1Qx59Uzh/QpcQK3QuWeUwer3GNul+PYlGMnrJ30EedNZcQ0nxs
         EiDfxrn3yzaYr8s6F5yPVJWAKPWVuEZxx4p9wlLvkNF9mkZDMyuBYQeMxdFz9d+Tu7
         M7pabO+YQvohFe7s3K4MaFZLRFVgdsls4WJmwzQJb1mBoyOpuAHAq9gQy4B2P7ZacH
         dyT1J9u7ke4/zx1PBsAfK9XyaTtJNP2MRslzsGsT7kmh4PUFAxZtIaPnv8GZriqwoB
         3mheMfQNgmE+E2Okfw1r2+VJ2/xOgBI+pk8ql+x25p5xXEUB4IThqqG+co4UCJ/NB6
         PjKhOmdPPr0SA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 54185404DF; Tue, 15 Aug 2023 15:26:47 -0300 (-03)
Date:   Tue, 15 Aug 2023 15:26:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v6 10/10] perf: tests: Adapt mmap-basic.c for riscv
Message-ID: <ZNvDZxIS1OhXGqg0@kernel.org>
References: <20230802080328.1213905-1-alexghiti@rivosinc.com>
 <20230802080328.1213905-11-alexghiti@rivosinc.com>
 <CAP-5=fVcMg7TL6W_jH61PW6dYMobuTs13d4JDuTAx=mxJ+PNtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVcMg7TL6W_jH61PW6dYMobuTs13d4JDuTAx=mxJ+PNtQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 14, 2023 at 09:44:58AM -0700, Ian Rogers escreveu:
> On Wed, Aug 2, 2023 at 1:14 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> >
> > riscv now supports mmaping hardware counters to userspace so adapt the test
> > to run on this architecture.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > Reviewed-by: Atish Patra <atishp@rivosinc.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/tests/mmap-basic.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> > index e68ca6229756..886a13a77a16 100644
> > --- a/tools/perf/tests/mmap-basic.c
> > +++ b/tools/perf/tests/mmap-basic.c
> > @@ -284,7 +284,8 @@ static struct test_case tests__basic_mmap[] = {
> >                          "permissions"),
> >         TEST_CASE_REASON("User space counter reading of instructions",
> >                          mmap_user_read_instr,
> > -#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> > +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || \
> > +                        (defined(__riscv) && __riscv_xlen == 64)
> >                          "permissions"
> >  #else
> >                          "unsupported"
> > @@ -292,7 +293,8 @@ static struct test_case tests__basic_mmap[] = {
> >                 ),
> >         TEST_CASE_REASON("User space counter reading of cycles",
> >                          mmap_user_read_cycles,
> > -#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> > +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || \
> > +                        (defined(__riscv) && __riscv_xlen == 64)
> >                          "permissions"
> >  #else
> >                          "unsupported"
> > --
> > 2.39.2
> >

-- 

- Arnaldo
