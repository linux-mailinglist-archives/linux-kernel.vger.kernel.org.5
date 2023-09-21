Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D837AA0D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjIUUtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjIUUsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:48:31 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC7E890F0D;
        Thu, 21 Sep 2023 10:47:21 -0700 (PDT)
Received: from pwmachine.localnet (unknown [84.232.150.101])
        by linux.microsoft.com (Postfix) with ESMTPSA id 15678212C5B7;
        Thu, 21 Sep 2023 04:48:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 15678212C5B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695296917;
        bh=eiwknSMO6gOPG6GXnXGJVCG4zh6xm5v/whvqYJur2mE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=coX0ubyyQrBiwakCvl4pVGhl4hemBcb+4RptEFBWnrE9r3RiHFpLhQcCq4QYgtYjk
         L0U22UOUDZsFH4rd02W4E6IKE6FoKu0AaJZATuImixC/ssoSnqVT3yxQljL1VIDJG3
         aqIYhtbcUPG1F5LFVdjL+ZmbyWzoHys5ioumcymk=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Alessandro Carminati <alessandro.carminati@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Kris Van Hees <kris.van.hees@oracle.com>,
        Eugene Loh <eugene.loh@oracle.com>,
        Viktor Malik <vmalik@redhat.com>,
        Petr Mladek <pmladek@suse.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4] scripts/link-vmlinux.sh: Add alias to duplicate symbols for kallsyms
Date:   Thu, 21 Sep 2023 14:48:29 +0300
Message-ID: <5711978.DvuYhMxLoT@pwmachine>
In-Reply-To: <CAPp5cGQH1QYM6fr_TRqh6BJDgYS89ncPzx3que5q92o2b0gmLw@mail.gmail.com>
References: <20230919193948.465340-1-alessandro.carminati@gmail.com> <4833924.GXAFRqVoOG@pwmachine> <CAPp5cGQH1QYM6fr_TRqh6BJDgYS89ncPzx3que5q92o2b0gmLw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Le mercredi 20 septembre 2023, 21:04:42 EEST Alessandro Carminati a =E9crit=
 :
> Hello Francis,
>=20
> Thanks a lot for the review.

You are welcome.
I also tested it and it works well:
root@vm-amd64:~# grep ' name_show' /proc/kallsyms | head -6
ffffffff810fa070 t name_show
ffffffff810fa070 t name_show@kernel_irq_irqdesc_c_264
ffffffff815e67c0 t name_show
ffffffff815e67c0 t name_show@drivers_pnp_card_c_186
ffffffff81728bb0 t name_show
ffffffff81728bb0 t name_show@drivers_gpu_drm_i915_gt_sysfs_engines_c_26

> Il giorno mer 20 set 2023 alle ore 12:53 Francis Laniel
>=20
> <flaniel@linux.microsoft.com> ha scritto:
> > Hi.
> >=20
> > Le mardi 19 septembre 2023, 22:39:48 EEST Alessandro Carminati (Red Hat=
) a
> >=20
> > =E9crit :
> > > It is not uncommon for drivers or modules related to similar peripher=
als
> > > to have symbols with the exact same name.
> > > While this is not a problem for the kernel's binary itself, it becomes
> > > an
> > > issue when attempting to trace or probe specific functions using
> > > infrastructure like ftrace or kprobe.
> > >=20
> > > The tracing subsystem relies on the `nm -n vmlinux` output, which
> > > provides
> > > symbol information from the kernel's ELF binary. However, when multip=
le
> > > symbols share the same name, the standard nm output does not
> > > differentiate
> > > between them. This can lead to confusion and difficulty when trying to
> > > probe the intended symbol.
> > >=20
> > >  ~ # cat /proc/kallsyms | grep " name_show"
> > >  ffffffff8c4f76d0 t name_show
> > >  ffffffff8c9cccb0 t name_show
> > >  ffffffff8cb0ac20 t name_show
> > >  ffffffff8cc728c0 t name_show
> > >  ffffffff8ce0efd0 t name_show
> > >  ffffffff8ce126c0 t name_show
> > >  ffffffff8ce1dd20 t name_show
> > >  ffffffff8ce24e70 t name_show
> > >  ffffffff8d1104c0 t name_show
> > >  ffffffff8d1fe480 t name_show
> > >=20
> > > kas_alias addresses this challenge by enhancing symbol names with
> > > meaningful suffixes generated from the source file and line number
> > > during the kernel build process.
> > > These newly generated aliases provide tracers with the ability to
> > > comprehend the symbols they are interacting with when utilizing the
> > > ftracefs interface.
> > > This approach may also allow for the probing by name of previously
> > > inaccessible symbols.
> > >=20
> > >  ~ # cat /proc/kallsyms | grep gic_mask_irq
> > >  ffffd15671e505ac t gic_mask_irq
> > >  ffffd15671e505ac t gic_mask_irq@drivers_irqchip_irq_gic_c_167
> > >  ffffd15671e532a4 t gic_mask_irq
> > >  ffffd15671e532a4 t gic_mask_irq@drivers_irqchip_irq_gic_v3_c_407
> > >  ~ #
> > >=20
> > > Changes from v1:
> > > - Integrated changes requested by Masami to exclude symbols with
> > > prefixes
> > >=20
> > >   "_cfi" and "_pfx".
> > >=20
> > > - Introduced a small framework to handle patterns that need to be
> > > excluded
> > >=20
> > >   from the alias production.
> > >=20
> > > - Excluded other symbols using the framework.
> > > - Introduced the ability to discriminate between text and data symbol=
s.
> > > - Added two new config symbols in this version:
> > > CONFIG_KALLSYMS_ALIAS_DATA,
> > >=20
> > >   which allows data for data, and CONFIG_KALLSYMS_ALIAS_DATA_ALL, whi=
ch
> > >   excludes all filters and provides an alias for each duplicated symb=
ol.
> > >=20
> > > https://lore.kernel.org/all/20230711151925.1092080-1-alessandro.carmi=
nat
> > > i@gm ail.com/
> > >=20
> > > Changes from v2:
> > > - Alias tags are created by querying DWARF information from the vmlin=
ux.
> > > - The filename + line number is normalized and appended to the origin=
al
> > >=20
> > >   name.
> > >=20
> > > - The tag begins with '@' to indicate the symbol source.
> > > - Not a change, but worth mentioning, since the alias is added to the
> > >=20
> > >   existing list, the old duplicated name is preserved, and the livepa=
tch
> > >   way of dealing with duplicates is maintained.
> > >=20
> > > - Acknowledging the existence of scenarios where inlined functions
> > >=20
> > >   declared in header files may result in multiple copies due to compi=
ler
> > >   behavior, though it is not actionable as it does not pose an
> > >   operational
> > >   issue.
> > >=20
> > > - Highlighting a single exception where the same name refers to
> > > different
> > >=20
> > >   functions: the case of "compat_binfmt_elf.c," which directly includ=
es
> > >   "binfmt_elf.c" producing identical function copies in two separate
> > >   modules.
> > >=20
> > > https://lore.kernel.org/all/20230714150326.1152359-1-alessandro.carmi=
nat
> > > i@gm ail.com/
> > >=20
> > > Changes from v3:
> > > - kas_alias was rewritten in Python to create a more concise and
> > >=20
> > >   maintainable codebase.
> > >=20
> > > - The previous automation process used by kas_alias to locate the
> > > vmlinux
> > >=20
> > >   and the addr2line has been replaced with an explicit command-line
> > >   switch
> > >   for specifying these requirements.
> > >=20
> > > - addr2line has been added into the main Makefile.
> > > - A new command-line switch has been introduced, enabling users to
> > > extend
> > >=20
> > >   the alias to global data names.
> > >=20
> > > https://lore.kernel.org/all/20230828080423.3539686-1-alessandro.carmi=
nat
> > > i@gm ail.com/
> > >=20
> > > NOTE:
> > > About the symbols name duplication that happens as consequence of the
> > > inclusion compat_binfmt_elf.c does, it is evident that this corner is
> > > inherently challenging the addr2line approach.
> > > Attempting to conceal this limitation would be counterproductive.
> > >=20
> > > compat_binfmt_elf.c includes directly binfmt_elf.c, addr2line can't h=
elp
> > > but report all functions and data declared by that file, coming from
> > > binfmt_elf.c.
> > >=20
> > > My position is that, rather than producing a more complicated pipeline
> > > to handle this corner case, it is better to fix the compat_binfmt_elf=
=2Ec
> > > anomaly.
> > >=20
> > > This patch does not deal with the two potentially problematic symbols
> > > defined by compat_binfmt_elf.c
> >=20
> > First, thank you for the v4, you will find in the remaining of the
> > messages
> > some comments but for now, I did not test it (this is planned).
> > On a general way, using python really helps here as the code is more
> > straightforward, thank you for this change.
> >=20
> > Regarding the problem with compat_binfmt_elf.c, do you have any idea on
> > how to address it?
> > I can maybe take a look at it but I would like to avoid breaking
> > everything.
> compat_binfmt_elf.c is a clever hack that enables sharing source code
> between two different modules while allowing for command differences thro=
ugh
> config macros [1] [2].
> The key lies in the fact they have only few differences.
>=20
> In my view, a good approach would be to refactor both compat_binfmt_elf.c
> and binfmt_elf.c, extracting common code and accessing it through wrapper=
s.
> This way, anyone looking to explore the functionality provided by either
> module would have distinct symbols to work with.
> Consolidating the two functions into one also seems beneficial, including=
 in
> contexts like livepatch scenarios.
>=20
> The trade-off here is that the modifications currently made using macros
> would need to be done at runtime.
> Fortunately, from what I see in the code, these changes appear to be
> relatively modest, and the functions don't seem to be critical loops.
> Therefore, sacrificing a few cycles to evaluate a flag doesn't appear to =
be
> a game-changer.

Thank you for all this information, I will take a deeper look at it but can=
not=20
guarantee I will come back with something.

> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/f=
s/
> binfmt_elf.c#n754 [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/f=
s/
> binfmt_elf.c#n1317
> > > Signed-off-by: Alessandro Carminati (Red Hat)
> > > <alessandro.carminati@gmail.com> ---
> > >=20
> > >  Makefile                |   4 +-
> > >  init/Kconfig            |  22 +++++++
> > >  scripts/kas_alias.py    | 132 ++++++++++++++++++++++++++++++++++++++=
++
> > >  scripts/link-vmlinux.sh |  20 +++++-
> > >  4 files changed, 175 insertions(+), 3 deletions(-)
> > >  create mode 100755 scripts/kas_alias.py
> > >=20
> > > diff --git a/Makefile b/Makefile
> > > index 4f283d915e54..f33c179f4cc3 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -488,6 +488,7 @@ OBJCOPY           =3D $(LLVM_PREFIX)llvm-objcopy$
> >=20
> > (LLVM_SUFFIX)
> >=20
> > >  OBJDUMP              =3D $(LLVM_PREFIX)llvm-objdump$(LLVM_SUFFIX)
> > >  READELF              =3D $(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)
> > >  STRIP                =3D $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
> > >=20
> > > +ADDR2LINE    =3D $(LLVM_PREFIX)llvm-addr2line$(LLVM_SUFFIX)
> > >=20
> > >  else
> > >  CC           =3D $(CROSS_COMPILE)gcc
> > >  LD           =3D $(CROSS_COMPILE)ld
> > >=20
> > > @@ -497,6 +498,7 @@ OBJCOPY           =3D $(CROSS_COMPILE)objcopy
> > >=20
> > >  OBJDUMP              =3D $(CROSS_COMPILE)objdump
> > >  READELF              =3D $(CROSS_COMPILE)readelf
> > >  STRIP                =3D $(CROSS_COMPILE)strip
> > >=20
> > > +ADDR2LINE    =3D $(CROSS_COMPILE)addr2line
> > >=20
> > >  endif
> > >  RUSTC                =3D rustc
> > >  RUSTDOC              =3D rustdoc
> > >=20
> > > @@ -611,7 +613,7 @@ export RUSTC_BOOTSTRAP :=3D 1
> > >=20
> > >  export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS
> > >=20
> > > CROSS_COMPILE LD CC HOSTPKG_CONFIG export RUSTC RUSTDOC RUSTFMT
> > > RUSTC_OR_CLIPPY_QUIET RUSTC_OR_CLIPPY BINDGEN CARGO export HOSTRUSTC
> > > KBUILD_HOSTRUSTFLAGS
> > > -export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS
> > > LEX
> > > YACC AWK INSTALLKERNEL +export CPP AR NM STRIP OBJCOPY OBJDUMP READELF
> > > ADDR2LINE PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL export PERL
> > > PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
> > >=20
> > >  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
> > >  export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS
> > >=20
> > > LDFLAGS_MODULE diff --git a/init/Kconfig b/init/Kconfig
> > > index 6d35728b94b2..d45dd423e1ec 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -1738,6 +1738,28 @@ config KALLSYMS_BASE_RELATIVE
> > >=20
> > >         time constants, and no relocation pass is required at runtime=
 to
> > >         fix
> > >         up the entries based on the runtime load address of the kerne=
l.
> > >=20
> > > +config KALLSYMS_ALIAS_SRCLINE
> > > +     bool "Produces alias for duplicated text symbols" if EXPERT
> > > +     depends on KALLSYMS && DEBUG_INFO && !DEBUG_INFO_SPLIT
> > > +     help
> > > +       It is not uncommon for drivers or modules related to similar
> > > +       peripherals to have symbols with the exact same name.
> > > +       While this is not a problem for the kernel's binary itself, it
> > > +       becomes an issue when attempting to trace or probe specific
> > > +       functions using infrastructure like ftrace or kprobe.
> > > +
> > > +       This option addresses this challenge, producing alias for text
> > > +       symbol names that include the file name and line where the
> > > symbols
> > > +       are defined in the source code.
> > > +
> > > +config KALLSYMS_ALIAS_SRCLINE_DATA
> > > +     bool "Produces alias also for global variables names"
> > > +     depends on KALLSYMS_ALIAS_SRCLINE
> > > +     help
> > > +       Sometimes it can be useful to refer to global vars by name.
> > > Since
> > > +       they suffer the same issue as text symbols, this config option
> > > +       allows having aliases for global variables names too.
> > > +
> > >=20
> > >  # end of the "standard kernel features (expert users)" menu
> > > =20
> > >  # syscall, maps, verifier
> > >=20
> > > diff --git a/scripts/kas_alias.py b/scripts/kas_alias.py
> > > new file mode 100755
> > > index 000000000000..8cc2a2178da6
> > > --- /dev/null
> > > +++ b/scripts/kas_alias.py
> > > @@ -0,0 +1,132 @@
> > > +#!/usr/bin/env python3
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +#
> > > +# Copyright (C) 2023 Red Hat, Inc. Alessandro Carminati
> > > <alessandro.carminati@gmail.com> +#
> > > +# kas_alias: Adds alias to duplicate symbols in the kallsyms output.
> > > +
> > > +import subprocess
> > > +import sys
> > > +import os
> > > +import argparse
> > > +import re
> > > +from collections import namedtuple
> > > +
> > > +regex_filter =3D [
> > > +        "^__compound_literal\\.[0-9]+$",
> > > +        "^__[wm]*key\\.[0-9]+$",
> > > +        "^_*TRACE_SYSTEM.*$",
> > > +        "^__already_done\\.[0-9]+$",
> > > +        "^__msg\\.[0-9]+$",
> > > +        "^__func__\\.[0-9]+$",
> > > +        "^CSWTCH\\.[0-9]+$",
> > > +        "^_rs\\.[0-9]+$",
> > > +        "^___tp_str\\.[0-9]+$",
> > > +        "^__flags\\.[0-9]+$",
> > > +        "^___done\\.[0-9]+$",
> > > +        "^__print_once\\.[0-9]+$",
> > > +        "^___once_key\\.[0-9]+$",
> > > +        "^__pfx_.*$",
> > > +        "^__cfi_.*$"
> > > +        ]
> > > +
> > > +class SeparatorType:
> > > +    def __call__(self, separator):
> > > +        if len(separator) !=3D 1:
> > > +            raise argparse.ArgumentTypeError("Separator must be a
> > > single
> > > character") +        return separator
> > > +
> > > +Line =3D namedtuple('Line', ['address', 'type', 'name'])
> > > +
> > > +def parse_file(filename):
> > > +    symbol_list =3D []
> > > +    name_occurrences =3D {}
> > > +
> > > +    with open(filename, 'r') as file:
> > > +        for line in file:
> > > +            fields =3D line.strip().split()
> > > +
> > > +            if len(fields) >=3D 3:
> > > +                address, type, name =3D fields[0], fields[1], '
> > > '.join(fields[2:]) +                symbol_list.append(Line(address,
> > > type,
> > > name))
> > > +                name_occurrences[name] =3D name_occurrences.get(name=
, 0)
> > > + 1
> > > +
> > > +    return symbol_list, name_occurrences
> > > +
> > > +def find_duplicate(symbol_list, name_occurrences):
> > > +    name_to_lines =3D {}
> > > +    duplicate_lines =3D []
> > > +
> > > +    for line in symbol_list:
> > > +        if line.name in name_to_lines:
> > > +            first_occurrence =3D name_to_lines[line.name]
> > > +            duplicate_lines.extend([first_occurrence, line])
> > > +        else:
> > > +            name_to_lines[line.name] =3D line
> > > +
> > > +    return duplicate_lines
> > > +
> > > +def start_addr2line_process(binary_file, addr2line_file):
> > > +    try:
> > > +        addr2line_process =3D subprocess.Popen([addr2line_file, '-fe=
',
> > > binary_file], +
> > > stdin=3Dsubprocess.PIPE, +
> > > stdout=3Dsubprocess.PIPE, +
> > > stderr=3Dsubprocess.PIPE, +
> > > text=3DTrue)
> > > +        return addr2line_process
> > > +    except Exception as e:
> > > +        print(f"Error starting addr2line process: {str(e)}")
> > > +        return None
> >=20
> > Here, you can raise another exception, otherwise this error message will
> > be
> > printed on stdout as you use print().
> >=20
> > > +
> > > +def addr2line_fetch_address(addr2line_process, address):
> > > +    try:
> > > +        addr2line_process.stdin.write(address + '\n')
> > > +        addr2line_process.stdin.flush()
> > > +        addr2line_process.stdout.readline().strip()
> > > +        output =3D addr2line_process.stdout.readline().strip()
> > > +
> > > +        return os.path.normpath(output)
> > > +    except Exception as e:
> > > +        print(f"Error communicating with addr2line: {str(e)}")
> > > +        return None
> >=20
> > Same comment than above.
>=20
> Hmm, you might be onto something there.
> The issue here is that I probably shouldn't return at all and should just
> go ahead and terminate the program. I mean, if I hit this exception, it
> means I couldn't spawn addr2line or fetch results from it.
> In that case, I can't provide the functionality anyway.
> When I initially wrote the function, my idea was to prevent the kernel
> build pipeline from failing completely by taking the input and pushing it
> to the output (even though the application wouldn't provide the
> functionality).
> But now I started thinking about it from the perspective of a user who
> really needs that functionality.
> Despite having to enable it, it does not present itself.
> That way I'm just complicating the debug.
>=20
> I came to the conclusion that it's best to just crash the application and
> halt the pipeline if either of the two fails.
> I will change it accordingly.
>=20
> > > +def process_line(line, config):
> > line should be named obj here.
>=20
> fair.
>=20
> > > +    if config:
> > > +        return not (any(re.match(regex, obj.name) for regex in
> > > regex_filter)) +    else:
> > > +        return obj.type in {"T", "t"}
> > > +if __name__ =3D=3D "__main__":
> > > +    parser =3D argparse.ArgumentParser(description=3D'Add alias to m=
ultiple
> > > occurring symbols name in kallsyms') +    parser.add_argument('-a',
> > > "--addr2line", dest=3D"addr2line_file", required=3DTrue) +
> > > parser.add_argument('-v', "--vmlinux", dest=3D"vmlinux_file",
> > > required=3DTrue)
> > > +    parser.add_argument('-o', "--outfile", dest=3D"output_file",
> > > required=3DTrue) +    parser.add_argument('-n', "--nmdata",
> > > dest=3D"nm_data_file", required=3DTrue) +    parser.add_argument('-s',
> > > "--separator", dest=3D"separator", required=3DFalse, default=3D"@",
> > > type=3DSeparatorType()) +    parser.add_argument('-d', "--data",
> > > dest=3D"include_data", required=3DFalse, action=3D'store_true') +    =
config =3D
> > > parser.parse_args()
> > > +
> > > +    try:
> > > +        config.linux_base_dir =3D os.getcwd()+"/"
> > > +        symbol_list, name_occurrences =3D parse_file(config.nm_data_=
file)
> > > +        addr2line_process =3D
> > > start_addr2line_process(config.vmlinux_file,
> > > config.addr2line_file) +
> > > +        with open(config.output_file, 'w') as file:
> > > +            for obj in symbol_list:
> > > +                file.write("{} {} {}\n".format(obj.address, obj.type,
> > > obj.name))
> >=20
> > I am not a python expert but is there something which prevents using
> > f-string here?
>=20
> Agree, best to have a single style.
>=20
> > > +                if (name_occurrences[obj.name] > 1) and
> > > process_line(obj, config.include_data) : +                    output =
=3D
> > > addr2line_fetch_address(addr2line_process, obj.address) +
> > >=20
> > >  decoration =3D config.separator + "".join(
> > >=20
> > > +                        "_" if not c.isalnum() else c for c in
> > > output.replace(config.linux_base_dir, "") +                    )
> >=20
> > Cannot the above be simplified to:
> > decoration =3D config.separator + config.linux_base_dir + ("_" if not
> > c.isalnum() else c for c in output)
> >=20
> > > +                    if decoration !=3D config.separator + "____":
> > Why exactly "____" and not "_+" (+ in the regex meaning of {1, n})?
>=20
> The reason for using "____" is because when addr2line emits the special
> string "?:??" its normalized version becomes "____" .
> "?:??" occurs when addr2line can not find the specified address in the
> DWARF section, which is typical of symbols introduced by the compiler.
> In such cases, emitting an alias wouldn't make sense, so I skip it.

OK, this makes sense!
I am wondering nonetheless what do you think about adding a comment which=20
would indicate that "____" is the translation of "?:??"? This would be usef=
ul=20
for people, like me, who does not have a great knowledge about addr2line.

> > > +                        file.write("{} {} {}\n".format(obj.address,
> > > obj.type, obj.name + decoration)) +
> > > +        addr2line_process.stdin.close()
> > > +        addr2line_process.stdout.close()
> > > +        addr2line_process.stderr.close()
> > > +        addr2line_process.wait()
> > > +
> > > +    except Exception as e:
> > > +        print(f"An error occurred: {str(e)}")
> > > +        raise SystemExit("Script terminated due to an error")
> >=20
> > Maybe you can fuse the two:
> > raise SystemExit(f"Script terminated due to an error: {str(e)}")
>=20
> Got it, thanks
>=20
> > > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > > index a432b171be82..7cc24fd5f6b4 100755
> > > --- a/scripts/link-vmlinux.sh
> > > +++ b/scripts/link-vmlinux.sh
> > > @@ -91,7 +91,12 @@ vmlinux_link()
> > >=20
> > >       # The kallsyms linking does not need debug symbols included.
> > >       if [ "$output" !=3D "${output#.tmp_vmlinux.kallsyms}" ] ; then
> > >=20
> > > -             ldflags=3D"${ldflags} ${wl}--strip-debug"
> > > +             # The kallsyms linking does not need debug symbols
> > > included,
> > > +             # unless the KALLSYMS_ALIAS_SRCLINE.
> > > +             if ! is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE && \
> > > +                [ "$output" !=3D "${output#.tmp_vmlinux.kallsyms}" ]=
 ;
> > > then
> > > +                     ldflags=3D"${ldflags} ${wl}--strip-debug"
> > > +             fi
> > >=20
> > >       fi
> > >      =20
> > >       if is_enabled CONFIG_VMLINUX_MAP; then
> > >=20
> > > @@ -161,7 +166,18 @@ kallsyms()
> > >=20
> > >       fi
> > >      =20
> > >       info KSYMS ${2}
> > >=20
> > > -     scripts/kallsyms ${kallsymopt} ${1} > ${2}
> > > +     ALIAS=3D""
> > > +     KAS_DATA=3D""
> > > +     if is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE_DATA; then
> > > +             KAS_DATA=3D"-d"
> > > +     fi
> > > +     if is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE; then
> > > +             ALIAS=3D".alias"
> > > +             scripts/kas_alias.py \
> > > +                     -a ${ADDR2LINE} -v ${kallsyms_vmlinux} -n ${1} \
> > > +                     -o ${1}${ALIAS} -s @ ${KAS_DATA}
> >=20
> > The separator can indeed be set for the python script but is hardcoded
> > from
> > the kernel point of view as there are no corresponding CONFIG_.
> > This is totally fine for me, as if someone wants a specific separator
> > he/she can edit this file, but was it your goal?
>=20
> Indeed.
> While your earlier point made sense to me, Petr's arguments were quite
> convincing.
> So, the kernel does hardcode the separator, but if someone really wants
> to change it, they can simply edit a character in the
> scripts/link-vmlinux.sh file.

I totally agree with Petr's comment.
I think adding a format or other complicated stuff is just a remix of "the=
=20
highway to hell is paved with good intentions".
So better to let it as it, and expert users can just edit the script.

> > > +     fi
> > > +     scripts/kallsyms ${kallsymopt} ${1}${ALIAS} > ${2}
> > >=20
> > >  }
> > > =20
> > >  # Perform one step in kallsyms generation, including temporary linki=
ng
> > >  of
> >=20
> > Best regards.

Best regards.


