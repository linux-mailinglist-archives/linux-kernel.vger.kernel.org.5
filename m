Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1A777D1D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbjHOS2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239103AbjHOS2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:28:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E1C1BC1;
        Tue, 15 Aug 2023 11:28:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D435E636E1;
        Tue, 15 Aug 2023 18:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13927C433C8;
        Tue, 15 Aug 2023 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692124088;
        bh=K+26otvjFP17cj7wEWOr2nFfsRJWCmK3+NoKvksgHS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RkdpQIw4DeWACFcizOeb+JqOBZSS+g1ZMqs3iIXgoXSa2nCvbbeW8sXmAg+TFraqQ
         6Qw3rv5ntIRC2COrrk4eFL09IzgWeHrNqW8Xn1GsQfl4x0wLiSpsiuQx6/wqPA7Y4d
         qG9qI54XfEmGTUk0YnVp7YQJ07bd++V/yHtpSFkCeBh9eHafjULLXBnI9FilEdvPiw
         JjtqGE7Y8MFIrpG3UCeOlNxQWhWslwMWyDd7wLqAm6GWWZ/QSVSAbwxB0efsTbvpQu
         UGaYpwSw2JakyBp7brO2aGob4ivUmK6r2HWMBIXxIAc7MqW2LwRJeKN98jnengdH5A
         HVZXW6d+LKiZA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AFE01404DF; Tue, 15 Aug 2023 15:28:05 -0300 (-03)
Date:   Tue, 15 Aug 2023 15:28:05 -0300
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
Subject: Re: [PATCH v6 09/10] tools: lib: perf: Implement riscv mmap support
Message-ID: <ZNvDtR/zmlDngjBH@kernel.org>
References: <20230802080328.1213905-1-alexghiti@rivosinc.com>
 <20230802080328.1213905-10-alexghiti@rivosinc.com>
 <CAP-5=fWZ8GDBn3fUUzjwknLq4KZV4tepX03oDn092zzboC8Dgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWZ8GDBn3fUUzjwknLq4KZV4tepX03oDn092zzboC8Dgw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 14, 2023 at 09:44:29AM -0700, Ian Rogers escreveu:
> On Wed, Aug 2, 2023 at 1:13 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> >
> > riscv now supports mmaping hardware counters so add what's needed to
> > take advantage of that in libperf.
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
> >  tools/lib/perf/mmap.c | 66 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >
> > diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> > index 0d1634cedf44..2184814b37dd 100644
> > --- a/tools/lib/perf/mmap.c
> > +++ b/tools/lib/perf/mmap.c
> > @@ -392,6 +392,72 @@ static u64 read_perf_counter(unsigned int counter)
> >
> >  static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); }
> >
> > +/* __riscv_xlen contains the witdh of the native base integer, here 64-bit */
> > +#elif defined(__riscv) && __riscv_xlen == 64
> > +
> > +/* TODO: implement rv32 support */
> > +
> > +#define CSR_CYCLE      0xc00
> > +#define CSR_TIME       0xc01
> > +
> > +#define csr_read(csr)                                          \
> > +({                                                             \
> > +       register unsigned long __v;                             \
> > +               __asm__ __volatile__ ("csrr %0, %1"             \
> > +                : "=r" (__v)                                   \
> > +                : "i" (csr) : );                               \
> > +                __v;                                           \
> > +})
> > +
> > +static unsigned long csr_read_num(int csr_num)
> > +{
> > +#define switchcase_csr_read(__csr_num, __val)           {\
> > +       case __csr_num:                                 \
> > +               __val = csr_read(__csr_num);            \
> > +               break; }
> > +#define switchcase_csr_read_2(__csr_num, __val)         {\
> > +       switchcase_csr_read(__csr_num + 0, __val)        \
> > +       switchcase_csr_read(__csr_num + 1, __val)}
> > +#define switchcase_csr_read_4(__csr_num, __val)         {\
> > +       switchcase_csr_read_2(__csr_num + 0, __val)      \
> > +       switchcase_csr_read_2(__csr_num + 2, __val)}
> > +#define switchcase_csr_read_8(__csr_num, __val)         {\
> > +       switchcase_csr_read_4(__csr_num + 0, __val)      \
> > +       switchcase_csr_read_4(__csr_num + 4, __val)}
> > +#define switchcase_csr_read_16(__csr_num, __val)        {\
> > +       switchcase_csr_read_8(__csr_num + 0, __val)      \
> > +       switchcase_csr_read_8(__csr_num + 8, __val)}
> > +#define switchcase_csr_read_32(__csr_num, __val)        {\
> > +       switchcase_csr_read_16(__csr_num + 0, __val)     \
> > +       switchcase_csr_read_16(__csr_num + 16, __val)}
> > +
> > +       unsigned long ret = 0;
> > +
> > +       switch (csr_num) {
> > +       switchcase_csr_read_32(CSR_CYCLE, ret)
> > +       default:
> > +               break;
> > +       }
> > +
> > +       return ret;
> > +#undef switchcase_csr_read_32
> > +#undef switchcase_csr_read_16
> > +#undef switchcase_csr_read_8
> > +#undef switchcase_csr_read_4
> > +#undef switchcase_csr_read_2
> > +#undef switchcase_csr_read
> > +}
> > +
> > +static u64 read_perf_counter(unsigned int counter)
> > +{
> > +       return csr_read_num(CSR_CYCLE + counter);
> > +}
> > +
> > +static u64 read_timestamp(void)
> > +{
> > +       return csr_read_num(CSR_TIME);
> > +}
> > +
> >  #else
> >  static u64 read_perf_counter(unsigned int counter __maybe_unused) { return 0; }
> >  static u64 read_timestamp(void) { return 0; }
> > --
> > 2.39.2
> >

-- 

- Arnaldo
