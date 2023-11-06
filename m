Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71FD7E1959
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 05:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjKFEMw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 5 Nov 2023 23:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFEMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 23:12:50 -0500
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B48B3;
        Sun,  5 Nov 2023 20:12:47 -0800 (PST)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5bda105206fso15084a12.3;
        Sun, 05 Nov 2023 20:12:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699243966; x=1699848766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zElg2gHoZLp6PFI5FrVwiSrAB0jQgVqcXfU6cDRFjZE=;
        b=u9h6RNLlRtY01nAcZSq/jIZdozxQa+KiTif6VfL4fRPG57165m9xfH7vyy6dXMqR+Q
         MAA9AQCoZDJ3gyEPd0t0JEn7WYwuZJIy8V9rmJFzwbf8AirXvx/RShy/hskl65Ny2FJP
         KsZ9W6wahmMrTD4wdlliRm0XQXkv08QTQ4URwxKubV2caSLVUPDvkvFTFqchw5VN/WY+
         n+MtXSGOsvMQRbfFvp+2zhJcqXjJdRsYG4w1/3UyUicgLwiIFPI64J/kmBxxswevkROv
         4OQ4yy9oCVxuBgDdulXOmsbENLrr4XBdwlURtprOlNdupHtPFazYCoHrZx/N51PGk+y3
         I3Fw==
X-Gm-Message-State: AOJu0YwKrJu18UOXFc178ji1vfWw34/1svPRcsxVyXHpG7cBd5gouq54
        BLhQpt2DFG0ygqUOZ/bDqG2p1fK62RwvOou7U1k=
X-Google-Smtp-Source: AGHT+IEHsFBCOrV2v1VPctO7UEKuD7iw/CPc+Zs5eLvi4t7HT1vLebdAv12tnMYlLwH83eCkrGUFOLJ+5Ly3flcy9t8=
X-Received: by 2002:a05:6a20:e109:b0:180:d9de:2d5e with SMTP id
 kr9-20020a056a20e10900b00180d9de2d5emr19017424pzb.39.1699243966394; Sun, 05
 Nov 2023 20:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20231012035111.676789-1-namhyung@kernel.org> <20231012035111.676789-10-namhyung@kernel.org>
 <20231105173618.c3e5d9faef347f27a6c4f049@kernel.org>
In-Reply-To: <20231105173618.c3e5d9faef347f27a6c4f049@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 5 Nov 2023 20:12:35 -0800
Message-ID: <CAM9d7ci_GqRKGLWeDgNx7yyOPURnMML6C9nzgT6XWcsNXGqWjQ@mail.gmail.com>
Subject: Re: [PATCH 09/48] perf dwarf-regs: Add get_dwarf_regnum()
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 5, 2023 at 1:36 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Wed, 11 Oct 2023 20:50:32 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
>
> > The get_dwarf_regnum() returns a DWARF register number from a register
> > name string according to the psABI.  Also add two pseudo encodings of
> > DWARF_REG_PC which is a register that are used by PC-relative addressing
> > and DWARF_REG_FB which is a frame base register.  They need to be
> > handled in a special way.
> >
>
> I have some comments below.

Sure! :)

>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/arch/x86/util/dwarf-regs.c | 38 +++++++++++++++++++++++++++
> >  tools/perf/util/dwarf-regs.c          | 33 +++++++++++++++++++++++
> >  tools/perf/util/include/dwarf-regs.h  | 11 ++++++++
> >  3 files changed, 82 insertions(+)
> >
> > diff --git a/tools/perf/arch/x86/util/dwarf-regs.c b/tools/perf/arch/x86/util/dwarf-regs.c
> > index 530934805710..79835b897cae 100644
> > --- a/tools/perf/arch/x86/util/dwarf-regs.c
> > +++ b/tools/perf/arch/x86/util/dwarf-regs.c
> > @@ -113,3 +113,41 @@ int regs_query_register_offset(const char *name)
> >                       return roff->offset;
> >       return -EINVAL;
> >  }
> > +
> > +struct dwarf_regs_idx {
> > +     const char *name;
> > +     int idx;
> > +};
> > +
> > +static const struct dwarf_regs_idx x86_regidx_table[] = {
> > +     { "rax", 0 }, { "eax", 0 }, { "ax", 0 }, { "al", 0 },
> > +     { "rdx", 1 }, { "edx", 1 }, { "dx", 1 }, { "dl", 1 },
> > +     { "rcx", 2 }, { "ecx", 2 }, { "cx", 2 }, { "cl", 2 },
> > +     { "rbx", 3 }, { "edx", 3 }, { "bx", 3 }, { "bl", 3 },
> > +     { "rsi", 4 }, { "esi", 4 }, { "si", 4 }, { "sil", 4 },
> > +     { "rdi", 5 }, { "edi", 5 }, { "di", 5 }, { "dil", 5 },
> > +     { "rbp", 6 }, { "ebp", 6 }, { "bp", 6 }, { "bpl", 6 },
> > +     { "rsp", 7 }, { "esp", 7 }, { "sp", 7 }, { "spl", 7 },
> > +     { "r8", 8 }, { "r8d", 8 }, { "r8w", 8 }, { "r8b", 8 },
> > +     { "r9", 9 }, { "r9d", 9 }, { "r9w", 9 }, { "r9b", 9 },
> > +     { "r10", 10 }, { "r10d", 10 }, { "r10w", 10 }, { "r10b", 10 },
> > +     { "r11", 11 }, { "r11d", 11 }, { "r11w", 11 }, { "r11b", 11 },
> > +     { "r12", 12 }, { "r12d", 12 }, { "r12w", 12 }, { "r12b", 12 },
> > +     { "r13", 13 }, { "r13d", 13 }, { "r13w", 13 }, { "r13b", 13 },
> > +     { "r14", 14 }, { "r14d", 14 }, { "r14w", 14 }, { "r14b", 14 },
> > +     { "r15", 15 }, { "r15d", 15 }, { "r15w", 15 }, { "r15b", 15 },
> > +     { "rip", DWARF_REG_PC },
> > +};
> > +
> > +int get_arch_regnum(const char *name)
> > +{
> > +     unsigned int i;
> > +
> > +     if (*name != '%')
> > +             return -1;
>
> Isn't it better to return an error code? e.g. -EINVAL.

Maybe.. any negative error code would work.

>
> > +
> > +     for (i = 0; i < ARRAY_SIZE(x86_regidx_table); i++)
> > +             if (!strcmp(x86_regidx_table[i].name, name + 1))
> > +                     return x86_regidx_table[i].idx;
> > +     return -1;
>
> And -ENOENT.
>
> > +}
> > diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
> > index 69cfaa5953bf..28d786c7df55 100644
> > --- a/tools/perf/util/dwarf-regs.c
> > +++ b/tools/perf/util/dwarf-regs.c
> > @@ -5,6 +5,8 @@
> >   * Written by: Masami Hiramatsu <mhiramat@kernel.org>
> >   */
> >
> > +#include <stdlib.h>
> > +#include <string.h>
> >  #include <debug.h>
> >  #include <dwarf-regs.h>
> >  #include <elf.h>
> > @@ -68,3 +70,34 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine)
> >       }
> >       return NULL;
> >  }
> > +
> > +__weak int get_arch_regnum(const char *name __maybe_unused)
> > +{
> > +     return -1;
>
> And -EOPNOTSUPP.

Could be -ENOTSUP.

>
> > +}
> > +
> > +/* Return DWARF register number from architecture register name */
> > +int get_dwarf_regnum(const char *name, unsigned int machine)
> > +{
> > +     char *regname = strdup(name);
> > +     int reg = -1;
> > +     char *p;
> > +
> > +     if (regname == NULL)
> > +             return -1;
>
> Here, -EINVAL.
>
> > +
> > +     /* For convenience, remove trailing characters */
> > +     p = strpbrk(regname, " ,)");
> > +     if (p)
> > +             *p = '\0';
> > +
> > +     switch (machine) {
> > +     case EM_NONE:   /* Generic arch - use host arch */
> > +             reg = get_arch_regnum(regname);
> > +             break;
> > +     default:
> > +             pr_err("ELF MACHINE %x is not supported.\n", machine);
> > +     }
> > +     free(regname);
> > +     return reg;
> > +}
> > diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
> > index 7d99a084e82d..b515f694f55e 100644
> > --- a/tools/perf/util/include/dwarf-regs.h
> > +++ b/tools/perf/util/include/dwarf-regs.h
> > @@ -2,6 +2,9 @@
> >  #ifndef _PERF_DWARF_REGS_H_
> >  #define _PERF_DWARF_REGS_H_
> >
> > +#define DWARF_REG_PC  0xd3af9c /* random number */
> > +#define DWARF_REG_FB  0xd3affb /* random number */
> > +
>
> Is this for other patch in the series?

Yes, they are to support global and local variables later.

Thanks,
Namhyung

>
> >  #ifdef HAVE_DWARF_SUPPORT
> >  const char *get_arch_regstr(unsigned int n);
> >  /*
> > @@ -10,6 +13,14 @@ const char *get_arch_regstr(unsigned int n);
> >   * machine: ELF machine signature (EM_*)
> >   */
> >  const char *get_dwarf_regstr(unsigned int n, unsigned int machine);
> > +
> > +int get_arch_regnum(const char *name);
> > +/*
> > + * get_dwarf_regnum - Returns DWARF regnum from register name
> > + * name: architecture register name
> > + * machine: ELF machine signature (EM_*)
> > + */
> > +int get_dwarf_regnum(const char *name, unsigned int machine);
> >  #endif
> >
> >  #ifdef HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
> > --
> > 2.42.0.655.g421f12c284-goog
> >
>
> Thank you,
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
