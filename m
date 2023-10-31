Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB497DD482
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344330AbjJaRTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjJaRSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:18:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6E28F;
        Tue, 31 Oct 2023 10:18:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA93AC433C8;
        Tue, 31 Oct 2023 17:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698772728;
        bh=BTZd7EpRhpdSX1QULrBJXUtu8CRgYp3NM5Co1HUWeto=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a3XK4DFrjRv6yt2nTZXaROJBQ553HpRbY3BGg/QdxhZFsrdxDrETwG31mWqdx9Ql5
         Bx4JWGigl6jjT9wY3RvXX0RaaFfByInWiWi6z5Tet9DIxcpfEXW12nShU/nOOZufAh
         8413o5NAyN1qQ5LhszsOwbOyjgboy2Zvc+HX+6JZzt9XUFGiGhZ2oVuv6JAxzyPbYv
         x7GUzF+cmltn9/29VGuPQiDBH9wlKB/y00241AzFARYIThxJ2pfUynNzD2OsniqnNE
         TMSNZCqd2V6TXK1KV42B5kS++aFiCSVTJUZlM7LkQ1yibU+gNM4gZfkF9iBgqbpNvW
         ZkyYEWYW402qw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1e59894d105so3865073fac.1;
        Tue, 31 Oct 2023 10:18:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YxLWXiOMUnzPy1GQQqRnzSRQHC0nHi2OyfSne/q/UpDkS29FU+Y
        +qPMsLexZnvY8u5mOVU7ZAabF5pL3a1btuMk1Ys=
X-Google-Smtp-Source: AGHT+IFyxDaht9RMir8LvYHqImVA0ycy/mZV5HDt1VZMotqiGxTnghQCP8F+ZyD5PcUe7l0BSgHjcrSzXidyRBAensM=
X-Received: by 2002:a05:6870:e992:b0:1e9:c84a:947a with SMTP id
 r18-20020a056870e99200b001e9c84a947amr17826065oao.41.1698772727985; Tue, 31
 Oct 2023 10:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231020161217.255765-1-ak@linux.intel.com>
In-Reply-To: <20231020161217.255765-1-ak@linux.intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 1 Nov 2023 02:18:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ559zbgr-Xt46mXFLtW7mLHRZhJRCmqPtMwHybfwztvQ@mail.gmail.com>
Message-ID: <CAK7LNAQ559zbgr-Xt46mXFLtW7mLHRZhJRCmqPtMwHybfwztvQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Add inline-account tool
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 1:12=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> A common cause of binary code bloat is excessive inlining. Traditional
> tools (like nm --size-sort -t d) don't address that directly because
> they only see the final functions, but don't know about inlines.
>
> This patch adds inline-account that makes it easy to track that down
> by accounting code bytes to all functions visible in the debug informatio=
n,
> as well as code lines.
>
> Here are some examples:
>
> Show all inlines that increase code size by >1K in the core scheduler:
>
> $ inline-account.py --min-bytes=3D1000 kernel/sched/core.o
> Total code bytes seen 75690
>
> Code bytes by functions:
> Function                                           Total          Avg   N=
um
> rq_pin_lock                                        1401  (0.02%)  35    3=
9
> __sched_setscheduler                               1277  (0.02%)  41    3=
1
> perf_fetch_caller_regs                             1012  (0.01%)  17    5=
8
>
> Code bytes by nearby source line blocks:
> prefix /home/ak/lsrc/git/linux/
> Line                                               Total
> kernel/sched/sched.h:1610                          1387  (0.02%)
> include/trace/events/sched.h:16                    1172  (0.02%)
> include/trace/events/sched.h:222                   1058  (0.01%)
>
> This indicates that rq_pin_lock should likely be not inline,
> and perhaps perf_fetch_caller_regs not either.
>
> Note that not all large inlines are necessary bloat. If there is only
> a single call site it isn't bloat (the tool currently cannot distinguish
> that case). For example it is commonly seen with syscall definitions
> that use single large inlines with only a single caller. In the example
> above I think it's the case with __sched_setscheduler.
>
> Show the >1K inlines in lib/maple_tree.o, which for some reason
> comes in at a incredible 73k of code size:
>
> $ inline-account.py --min-bytes 1000 lib/maple_tree.o
> Total code bytes seen 73578
>
> Code bytes by functions:
> Function                                           Total          Avg   N=
um
> mas_mab_cp                                         5537  (0.08%)  37    1=
49
> mas_pop_node                                       3798  (0.05%)  28    1=
31
> ma_slots                                           2368  (0.03%)  14    1=
62
> ma_pivots                                          2353  (0.03%)  10    2=
22
> mas_destroy_rebalance                              2056  (0.03%)  42    4=
8
> mas_start                                          1661  (0.02%)  13    1=
25
> mas_set_parent                                     1454  (0.02%)  20    7=
2
> mas_set_alloc_req                                  1410  (0.02%)  17    8=
0
> mte_node_type                                      1360  (0.02%)  5     2=
28
> mas_data_end                                       1189  (0.02%)  16    7=
4
> mte_to_node                                        1085  (0.01%)  3     2=
76
> mas_split                                          1053  (0.01%)  65    1=
6
> mas_topiary_replace                                1033  (0.01%)  38    2=
7
> mas_root_expand                                    1001  (0.01%)  35    2=
8
>
> Code bytes by nearby source line blocks:
> prefix /home/ak/lsrc/git/linux/
> Line                                               Total
> lib/maple_tree.c:210                               1360  (0.02%)
> include/trace/events/maple_tree.h:80               1283  (0.02%)
> lib/maple_tree.c:649                               1193  (0.02%)
> lib/maple_tree.c:288                               1097  (0.01%)
>
> It's clear there is a lot of potential for shrinking here, as a quick
> experiment shows:
>
> $ size lib/maple_tree.o
>    text    data     bss     dec     hex filename
>   72257    5312       8   77577   12f09 lib/maple_tree.o
> $ sed -i -e s/__always_inline// -e 's/ inline/ /' lib/maple_tree.c
> $ make -s lib/maple_tree.o
> $ size lib/maple_tree.o
>    text    data     bss     dec     hex filename
>   47774    4720       8   52502    cd16 lib/maple_tree.o
>
> 34% reduction just from trusting the compiler. Most of it seems
> to come from abuse of __always_inline. I suppose a large scale
> tree purge of that would give some decent binary size results.
>
> $ inline-account.py --show=3D5 kernel/workqueue.o
> Total code bytes seen 40403
>
> Code bytes by functions:
> Function                                           Total          Avg   N=
um
> bitmap_copy                                        1477  (0.04%)  26    5=
6
> show_pwq                                           912   (0.02%)  76    1=
2
> workqueue_init_early                               846   (0.02%)  29    2=
9
> __flush_workqueue                                  753   (0.02%)  31    2=
4
> alloc_and_link_pwqs                                558   (0.01%)  69    8
>
> Code bytes by nearby source line blocks:
> prefix /home/ak/lsrc/git/linux/
> Line                                               Total
> include/linux/bitmap.h:268                         1336  (0.03%)
> include/trace/events/workqueue.h:23                1038  (0.03%)
> include/trace/events/workqueue.h:108               732   (0.02%)
> include/trace/events/workqueue.h:59                694   (0.02%)
> include/trace/events/workqueue.h:82                670   (0.02%)
> $
>
> This is an interesting case because bitmap_copy is just
>
> static inline void bitmap_copy(unsigned long *dst, const unsigned long *s=
rc,
>                         unsigned int nbits)
> {
>         unsigned int len =3D BITS_TO_LONGS(nbits) * sizeof(unsigned long)=
;
>
>         if (small_const_nbits(nbits))
>                 *dst =3D *src;
>         else
>                 memcpy(dst, src, len);
> }
>
> memcpy (which is a macro) must sometimes generate a lot of
> code. The small_const_nbits case definitely should be inlined though
> because it's likely even smaller than a call. Would need
> more investigation.
>
> The other large inlines are trace points. Perhaps there is something
> there that could be done to shrink that a bit.
>
> Finally we can do a global accounting (currently with multiple runs):
>
> (ignore the percentage numbers since they are just for the local file)
>
> $ find -name '*.o' | xargs -n1 inline-account.py > a
> $ sort -n -r -k 2 a | head -30
> ZSTD_count                                         81799 (0.19%)  32    2=
514
> ZSTD_count                                         52233 (0.25%)  33    1=
544
> kmalloc                                            43324 (0.00%)  12    3=
334
> pv_queued_spin_unlock                              42027 (0.00%)  9     4=
580
> constant_test_bit                                  41667 (0.00%)  5     8=
005
> arch/x86/include/asm/paravirt.h:591                41044 (0.00%)
> arch/x86/include/asm/bitops.h:207                  40153 (0.00%)
> __refcount_add                                     37968 (0.00%)  24    1=
532
> page_fixed_fake_head                               36368 (0.00%)  19    1=
832
> include/linux/slab.h:599                           35654 (0.00%)
> arch/x86/include/asm/jump_label.h:27               35156 (0.00%)
> spin_lock                                          32170 (0.00%)  10    3=
007
> __refcount_sub_and_test                            32068 (0.00%)  17    1=
842
> include/linux/spinlock.h:351                       31102 (0.00%)
> arch_static_branch                                 30874 (0.00%)  4     7=
022
> get_current                                        30714 (0.00%)  9     3=
351
> arch/x86/include/asm/current.h:41                  29912 (0.00%)
> trace_trigger_soft_disabled                        29814 (0.00%)  21    1=
368
> perf_fetch_caller_regs                             27504 (0.00%)  16    1=
634
> ZSTD_storeSeq                                      26060 (0.06%)  30    8=
62
> hid_map_usage                                      25582 (0.00%)  88    2=
88
> ZSTD_compressBlock_lazy_generic                    24953 (0.12%)  46    5=
35
> ZSTD_compressBlock_lazy_generic                    24953 (0.06%)  46    5=
35
> paravirt_ret0                                      24152 (0.00%)  24152 1
> spin_unlock_irqrestore                             23253 (0.00%)  10    2=
281
> include/linux/spinlock.h:406                       22526 (0.00%)
> ZSTD_RowFindBestMatch                              21527 (0.10%)  23    9=
22
> ZSTD_RowFindBestMatch                              21527 (0.05%)  23    9=
22
> __list_add                                         21209 (0.00%)  11    1=
851
> include/linux/refcount.h:283                       20642 (0.00%)
>
> - So my kernel is spending around ~30K just for getting task_structs in
> current.
> - I'm sure ZSTD is great, but is it >200K in duplicated code worth great?
> - page_fixed_fake_head probably shouldn't be inlined
> - There might be some potential in out lining reference counts
> (although that one might be truly performance critical)
> - There's maybe some potential in shrinking trace point bloat?
>
> ... and more similar insights.
>
> Also of course there can be critical inlines that really need
> to be inline in many sites for best performance. But that's rarely the ca=
se
> if they are big because it's unlikely the small call overhead is making
> a significant difference for a large chunk of code.
>
> In any case the tool is useful, so I think it deserves its place
> in scripts/
>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  scripts/inline-account.py | 173 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100755 scripts/inline-account.py
>
> diff --git a/scripts/inline-account.py b/scripts/inline-account.py
> new file mode 100755
> index 000000000000..b6cfe195efe6
> --- /dev/null
> +++ b/scripts/inline-account.py
> @@ -0,0 +1,173 @@
> +#!/usr/bin/env python3


SPDX?





> +# account code bytes per source code / functions from objdump -Sl output
> +# useful to find inline bloat
> +# Author: Andi Kleen

A blank line please between the comment header
and the start of the code.




For example, see scripts/clang-tools/run-clang-tools.py
as a Python script written in a good coding style.









> +import os, sys, re, argparse, multiprocessing
> +from collections import Counter
> +from functools import reduce
> +
> +p =3D argparse.ArgumentParser(
> +        description=3D"""
> +Account code bytes per source code / functions from objdump.
> +Useful to find inline bloat.
> +
> +The line numbers are the beginning of a block, so the actual code can be=
 later.
> +Line numbers can be a also little off due to objdump bugs
> +also some misaccounting can happen due to inexact gcc debug information.
> +The number output for functions may account a single large function mult=
iple
> +times.  program/object files need to be built with -g.
> +
> +This is somewhat slow due to objdump -S being slow. It helps to have
> +plenty of cores.""")
> +p.add_argument('--min-bytes', type=3Dint, help=3D'minimum bytes to repor=
t', default=3D100)
> +p.add_argument('--threads', '-t', type=3Dint, default=3Dmultiprocessing.=
cpu_count(),
> +               help=3D'Number of objdump processes to run')
> +p.add_argument('--verbose', '-v', action=3D'store_true', help=3D"Print m=
ore")
> +p.add_argument('--show', type=3Dint, help=3D'Number of results to show')
> +p.add_argument('file', help=3D'object file/program as input')
> +args =3D p.parse_args()


Put the code lines in a function,
except import directives and

if __name__ =3D=3D '__main__':
    main()






> +
> +def get_syms(fn):
> +    f =3D os.popen("nm  --print-size " + fn)
> +    syms =3D []
> +    pc =3D None
> +    for l in f:
> +        n =3D l.split()
> +        if len(n) > 2 and n[2].upper() =3D=3D "T":
> +            pc =3D int(n[0], 16)
> +            syms.append(pc)
> +            ln =3D int(n[1], 16)
> +    f.close()



with os.popen("nm  --print-size " + fn) as f:

then, remove the f.close()










> +    if not pc:
> +        sys.exit(fn + " has no symbols")
> +    syms.append(pc + ln)


I guess you intended 'pc + ln' as the
tail of the .text

Not really because the output from 'nm --print-size'
is not sorted by address.


You need to pass the -n flag to
make 'nm' sort the output by address.








> +    return syms
> +
> +class Account:
> +    pass



class without any method?



Please make add_account() and account_range()
class methods for readability.

Maybe account_range() to __init().



If you want to use map(),

   al =3D list(map(lambda r: Account(r), ranges))








> +
> +def add_account(a, b):
> +    a.funcbytes +=3D b.funcbytes
> +    a.linebytes +=3D b.linebytes
> +    a.funccount +=3D b.funccount
> +    a.nolinebytes +=3D b.nolinebytes
> +    a.nofuncbytes +=3D b.nofuncbytes
> +    a.total +=3D b.total
> +    return a
> +
> +# dont add sys.exit here, causes deadlocks
> +def account_range(r):
> +    a =3D Account()
> +    a.funcbytes =3D Counter()
> +    a.linebytes =3D Counter()
> +    a.funccount =3D Counter()
> +    a.nolinebytes =3D 0
> +    a.nofuncbytes =3D 0
> +    a.total =3D 0
> +
> +    line =3D None
> +    func =3D None
> +    codefunc =3D None
> +
> +    cmd =3D ("objdump -Sl %s --start-address=3D%#x --stop-address=3D%#x"=
 %
> +                (args.file, r[0], r[1]))
> +    f =3D os.popen(cmd)


Ditto.   with os.popen(cmd) as f:



> +    for l in f:
> +        #      250:       e8 00 00 00 00          callq  255 <proc_skip_=
spaces+0x5>
> +        m =3D re.match(r'\s*([0-9a-fA-F]+):\s+(.*)', l)
> +        if m:
> +            #print "iscode", func, l,


Do not leave debugging code.


> +            bytes =3D len(re.findall(r'[0-9a-f][0-9a-f] ', m.group(2)))
> +            if not func:
> +                a.nofuncbytes +=3D bytes
> +                continue
> +            if not line:
> +                a.nolinebytes +=3D bytes
> +                continue
> +            a.total +=3D bytes
> +            a.funcbytes[func] +=3D bytes
> +            a.linebytes[(file, line)] +=3D bytes
> +            codefunc =3D func
> +            continue
> +
> +        # sysctl_init():
> +        m =3D re.match(r'([a-zA-Z_][a-zA-Z0-9_]*)\(\):$', l)
> +        if m:
> +            if codefunc and m.group(1) !=3D codefunc:
> +                a.funccount[codefunc] +=3D 1
> +                codefunc =3D None
> +            func =3D m.group(1)
> +            continue
> +
> +        # /sysctl.c:1666
> +        m =3D re.match(r'^([^:]+):(\d+)$', l)
> +        if m:
> +            file, line =3D m.group(1), int(m.group(2))
> +            continue
> +    f.close()
> +
> +    if codefunc:
> +        a.funccount[codefunc] +=3D 1
> +    return a
> +
> +# objdump -S is slow, so we parallelize
> +
> +# split symbol table into chunks for parallelization
> +# we split on functions boundaries to avoid mis-accounting
> +# assumes functions have roughly similar length
> +syms =3D sorted(get_syms(args.file))


This sorted() is too late.

Sorting must be done by 'nm -n'.




> +chunk =3D max(int(min((len(syms) - 1) / args.threads, len(syms) - 1)), 1=
)


I do not understand.

Why min()?

If you check args.threads >=3D 1,
(len(syms) - 1) / args.threads is smaller, isn't it?





> +boundaries =3D [syms[x] for x in range(0, len(syms) - 1, chunk)] + [syms=
[-1]]
> +ranges =3D [(boundaries[x], boundaries[x+1]) for x in range(0, len(bound=
aries) - 1)
> +          if boundaries[x+1] > boundaries[x]]
> +assert ranges[0][0] =3D=3D syms[0]
> +assert ranges[-1][1] =3D=3D syms[-1]
> +
> +# map-reduce
> +if args.threads =3D=3D 1:
> +    al =3D list(map(account_range, ranges))
> +else:
> +    al =3D multiprocessing.Pool(args.threads).map(account_range, ranges)
> +a =3D reduce(add_account, al)
> +
> +print("Total code bytes seen", a.total)
> +if args.verbose:
> +    print("Bytes with no function %d (%.2f%%)" % (a.nofuncbytes, 100.0*(=
float(a.nofuncbytes)/a.total)))
> +    print("Bytes with no lines %d (%.2f%%)" % (a.nolinebytes, 100.0*(flo=
at(a.nolinebytes)/a.total)))
> +
> +def sort_map(m):
> +    return sorted(list(m.keys()), key=3Dlambda x: m[x], reverse=3DTrue)
> +
> +print("\nCode bytes by functions:")
> +print("%-50s %-5s  %-5s   %-5s %-5s" % ("Function", "Total", "", "Avg", =
"Num"))
> +for i, j in enumerate(sort_map(a.funcbytes)):
> +    if a.funcbytes[j] < args.min_bytes:
> +        break
> +    if args.show and i >=3D args.show:
> +        break
> +    print("%-50s %-5d (%.2f%%)  %-5d %-5d" % (
> +            j,
> +            a.funcbytes[j],
> +            a.funcbytes[j] / float(a.total),
> +            a.funcbytes[j] / a.funccount[j],
> +            a.funccount[j]))
> +
> +for j in list(a.linebytes.keys()):
> +    if a.linebytes[j] < args.min_bytes:
> +        del a.linebytes[j]
> +
> +# os.path.commonprefix fails with >50k entries
> +# just use the first 10
> +prefix =3D os.path.commonprefix([x[0] for x in list(a.linebytes.keys())[=
:10]])


This does not seem to be a good idea.


I see a lot of absolute paths left behind,
and also empty lines.






> +
> +print("\nCode bytes by nearby source line blocks:")
> +print("prefix", prefix)
> +
> +print("%-50s %-5s" % ("Line", "Total"))
> +for i, j in enumerate(sort_map(a.linebytes)):
> +    if args.show and i >=3D args.show:
> +        break
> +    print("%-50s %-5d (%.2f%%)" % (
> +            "%s:%d" % (j[0].replace(prefix, ""), j[1]),


If j[0] and prefix are the same,
the file part disappears.




> +            a.linebytes[j],
> +            a.linebytes[j] / float(a.total)))
> --
> 2.41.0
>


--
Best Regards
Masahiro Yamada
