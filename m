Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289517D6D04
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344191AbjJYNVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjJYNVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:21:32 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B99DC116;
        Wed, 25 Oct 2023 06:21:26 -0700 (PDT)
Received: from pwmachine.localnet (unknown [188.24.154.80])
        by linux.microsoft.com (Postfix) with ESMTPSA id BC0FD20B74C0;
        Wed, 25 Oct 2023 06:21:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BC0FD20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1698240085;
        bh=RfSniGF8XEBep7MAZLtF7zpKVn0osyBCIe5LRqrvFks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I75uFBh+Pv/2QNIpVwJlk75ecoZHagSUPslKXfnNARlxftiH1PGNvPO3/hycpFQQK
         EDk84+MqT8GAr5O0ASZDpOxYCdk4SGnEir4Q33E1D87Pyg1i38NmQiGQx7EvA4xTOG
         hJPUXQAsLL7pOUPT8/EUEdwoWhOnwck3OrVQMkGY=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Kris Van Hees <kris.van.hees@oracle.com>,
        Eugene Loh <eugene.loh@oracle.com>,
        Viktor Malik <vmalik@redhat.com>,
        Petr Mladek <pmladek@suse.com>, Tom Rix <trix@redhat.com>,
        Alessandro Carminati <alessandro.carminati@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6] scripts/link-vmlinux.sh: Add alias to duplicate symbols for kallsyms
Date:   Wed, 25 Oct 2023 16:21:17 +0300
Message-ID: <5776666.DvuYhMxLoT@pwmachine>
In-Reply-To: <20231024201157.748254-1-alessandro.carminati@gmail.com>
References: <20231024201157.748254-1-alessandro.carminati@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


Le mardi 24 octobre 2023, 23:11:57 EEST Alessandro Carminati (Red Hat) a=20
=E9crit :
> In the kernel environment, scenarios often arise where identical names
> are shared among symbols within core image or modules.
> While this poses no complications for the kernel's binary itself, it
> creates challenges when conducting trace or probe operations using tools
> like kprobe.
>=20
> A solution has been introduced, referred to as "kas_alias."
> During the kernel's build process, an extensive scan of all objects is
> performed, encompassing both core kernel components and modules, to
> collect comprehensive symbol information.
> Subsequently, for all duplicate symbolsthe process enriches symbol names
> by appending meaningful suffixes derived from source files and line
> numbers.
> These freshly generated aliases simplify interaction with symbols.
>=20
> The procedure is executed as follows.
> During the kernel's build phase, an exhaustive search for duplicates among
> symbols that share the same name in both kernel image and all modules
> object files.
> For the kernel core image, a new nem data file is created and alias for
> all duplicate symbols is added.
> For modules, the lib objects the ELF symtable is modified with the
> addition of the alias for the duplicate symbols.
>=20
> Consider the symbol "device_show", you can expect an output like the
> following:
>=20
>  ~ # cat /proc/kallsyms | grep " device_show"
>  ffffffff963cd2a0 t device_show
>  ffffffff963cd2a0 t device_show@drivers_pci_pci_sysfs_c_49
>  ffffffff96454b60 t device_show
>  ffffffff96454b60 t device_show@drivers_virtio_virtio_c_16
>  ffffffff966e1700 T device_show_ulong
>  ffffffff966e1740 T device_show_int
>  ffffffff966e1770 T device_show_bool
>  ffffffffc04e10a0 t device_show [mmc_core]
>  ffffffffc04e10a0 t device_show@drivers_mmc_core_sdio_bus_c_45  [mmc_core]
>=20
> Signed-off-by: Alessandro Carminati (Red Hat)
> <alessandro.carminati@gmail.com>
>=20
> NOTE1:
> About the symbols name duplication that happens as consequence of the
> inclusion compat_binfmt_elf.c does, it is evident that this corner is
> inherently challenging the addr2line approach.
> Attempting to conceal this limitation would be counterproductive.
>=20
> compat_binfmt_elf.c includes directly binfmt_elf.c, addr2line can't help
> but report all functions and data declared by that file, coming from
> binfmt_elf.c.
>=20
> My position is that, rather than producing a more complicated pipeline
> to handle this corner case, it is better to fix the compat_binfmt_elf.c
> anomaly.
>=20
> This patch does not deal with the two potentially problematic symbols
> defined by compat_binfmt_elf.c
>=20
> NOTE2:
> The current implementation does not offer a solution for out-of-tree
> modules. My stance is that these modules fall outside the scope, but I
> welcome any comments or feedback regarding this matter.
>=20
> Changes from v1:
> * Integrated changes requested by Masami to exclude symbols with prefixes
>   "_cfi" and "_pfx".
> * Introduced a small framework to handle patterns that need to be excluded
>   from the alias production.
> * Excluded other symbols using the framework.
> * Introduced the ability to discriminate between text and data symbols.
> * Added two new config symbols in this version:
>   CONFIG_KALLSYMS_ALIAS_DATA, which allows data for data, and
>   CONFIG_KALLSYMS_ALIAS_DATA_ALL, which excludes all filters and provides
>   an alias for each duplicated symbol.
>=20
> https://lore.kernel.org/all/20230711151925.1092080-1-alessandro.carminati=
@gm
> ail.com/
>=20
> Changes from v2:
> * Alias tags are created by querying DWARF information from the vmlinux.
> * The filename + line number is normalized and appended to the original
>   name.
> * The tag begins with '@' to indicate the symbol source.
> * Not a change, but worth mentioning, since the alias is added to the
>   existing list, the old duplicated name is preserved, and the livepatch
>   way of dealing with duplicates is maintained.
> * Acknowledging the existence of scenarios where inlined functions
>   declared in header files may result in multiple copies due to compiler
>   behavior, though it is not actionable as it does not pose an operational
>   issue.
> * Highlighting a single exception where the same name refers to different
>   functions: the case of "compat_binfmt_elf.c," which directly includes
>   "binfmt_elf.c" producing identical function copies in two separate
>   modules.
>=20
> https://lore.kernel.org/all/20230714150326.1152359-1-alessandro.carminati=
@gm
> ail.com/
>=20
> Changes from v3:
> * kas_alias was rewritten in Python to create a more concise and
>   maintainable codebase.
> * The previous automation process used by kas_alias to locate the vmlinux
>   and the addr2line has been replaced with an explicit command-line switch
>   for specifying these requirements.
> * addr2line has been added into the main Makefile.
> * A new command-line switch has been introduced, enabling users to extend
>   the alias to global data names.
>=20
> https://lore.kernel.org/all/20230828080423.3539686-1-alessandro.carminati=
@gm
> ail.com/
>=20
> Changes from v4:
> * Fixed the O=3D<build dir> build issue
> * The tool halts execution upon encountering major issues, thereby ensuri=
ng
>   the pipeline is interrupted.
> * A cmdline option to specify the source directory added.
> * Minor code adjusments.
> * Tested on mips32 and i386
>=20
> https://lore.kernel.org/all/20230919193948.465340-1-alessandro.carminati@=
gma
> il.com/
>=20
> Changes from v5:
> * Regex filter extended to all symbols
> * Alias creation extended to module objects
> * Code cleaned and commented
> * kas_alias verbose execution via KAS_ALIAS_DEBUG env variable
> * CONFIG_KALLSYMS_ALIAS_SRCLINE selects KBUILD_BUILTIN to ensure no races
>   during modules build
> * Tested on x86_64, aarch64 and i386

Thank you for this new version!
I tested it and it works fine, particularly with the added information abou=
t=20
modules:
root@vm-amd64:~# grep ' name_show@' /proc/kallsyms | head -5
ffffffff810fa150 t name_show@kernel_irq_irqdesc_c_264
ffffffff815ddcd0 t name_show@drivers_pnp_card_c_186
ffffffff8171ccb0 t name_show@drivers_gpu_drm_i915_gt_sysfs_engines_c_26
ffffffff8189de00 t name_show@drivers_base_power_wakeup_stats_c_93
ffffffff81a3d140 t name_show@drivers_rtc_sysfs_c_26

I reviewed the code and only found nits.

> https://lore.kernel.org/all/20230927173516.1456594-1-alessandro.carminati=
@gm
> ail.com/ ---
>  Makefile                  |  14 +-
>  init/Kconfig              |  22 ++
>  scripts/Makefile.modfinal |  10 +-
>  scripts/kas_alias.py      | 545 ++++++++++++++++++++++++++++++++++++++
>  scripts/link-vmlinux.sh   |  26 +-
>  5 files changed, 613 insertions(+), 4 deletions(-)
>  create mode 100755 scripts/kas_alias.py
>=20
> diff --git a/Makefile b/Makefile
> index 4f283d915e54..f2c51340fa52 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -488,6 +488,7 @@ OBJCOPY		=3D $(LLVM_PREFIX)llvm-objcopy$
(LLVM_SUFFIX)
>  OBJDUMP		=3D $(LLVM_PREFIX)llvm-objdump$(LLVM_SUFFIX)
>  READELF		=3D $(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)
>  STRIP		=3D $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
> +ADDR2LINE	=3D $(LLVM_PREFIX)llvm-addr2line$(LLVM_SUFFIX)
>  else
>  CC		=3D $(CROSS_COMPILE)gcc
>  LD		=3D $(CROSS_COMPILE)ld
> @@ -497,6 +498,7 @@ OBJCOPY		=3D $(CROSS_COMPILE)objcopy
>  OBJDUMP		=3D $(CROSS_COMPILE)objdump
>  READELF		=3D $(CROSS_COMPILE)readelf
>  STRIP		=3D $(CROSS_COMPILE)strip
> +ADDR2LINE	=3D $(CROSS_COMPILE)addr2line
>  endif
>  RUSTC		=3D rustc
>  RUSTDOC		=3D rustdoc
> @@ -611,7 +613,7 @@ export RUSTC_BOOTSTRAP :=3D 1
>  export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS
> CROSS_COMPILE LD CC HOSTPKG_CONFIG export RUSTC RUSTDOC RUSTFMT
> RUSTC_OR_CLIPPY_QUIET RUSTC_OR_CLIPPY BINDGEN CARGO export HOSTRUSTC
> KBUILD_HOSTRUSTFLAGS
> -export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX
> YACC AWK INSTALLKERNEL +export CPP AR NM STRIP OBJCOPY OBJDUMP READELF
> ADDR2LINE PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL export PERL
> PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
>  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
>  export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS
> LDFLAGS_MODULE @@ -1542,6 +1544,16 @@ KBUILD_BUILTIN :=3D 1
>  modules: vmlinux
>  endif
>=20
> +# *.ko are usually independent of vmlinux, but
> CONFIG_KALLSYMS_ALIAS_SRCLINE +# is another exception.
> +# At the time when vmlinux is being linked, kas_alias operates on both
> vmlinux +# and modules. To prevent races with modules, kas_alias needs to
> pause operations +# while it is executed.
> +ifdef CONFIG_KALLSYMS_ALIAS_SRCLINE
> +KBUILD_BUILTIN :=3D 1
> +modules: vmlinux
> +endif
> +
>  modules: modules_prepare
>=20
>  # Target to prepare building external modules
> diff --git a/init/Kconfig b/init/Kconfig
> index 6d35728b94b2..d45dd423e1ec 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1738,6 +1738,28 @@ config KALLSYMS_BASE_RELATIVE
>  	  time constants, and no relocation pass is required at runtime to fix
>  	  up the entries based on the runtime load address of the kernel.
>=20
> +config KALLSYMS_ALIAS_SRCLINE
> +	bool "Produces alias for duplicated text symbols" if EXPERT
> +	depends on KALLSYMS && DEBUG_INFO && !DEBUG_INFO_SPLIT
> +	help
> +	  It is not uncommon for drivers or modules related to similar
> +	  peripherals to have symbols with the exact same name.
> +	  While this is not a problem for the kernel's binary itself, it
> +	  becomes an issue when attempting to trace or probe specific
> +	  functions using infrastructure like ftrace or kprobe.
> +
> +	  This option addresses this challenge, producing alias for text
> +	  symbol names that include the file name and line where the symbols
> +	  are defined in the source code.
> +
> +config KALLSYMS_ALIAS_SRCLINE_DATA
> +	bool "Produces alias also for global variables names"
> +	depends on KALLSYMS_ALIAS_SRCLINE
> +	help
> +	  Sometimes it can be useful to refer to global vars by name. Since
> +	  they suffer the same issue as text symbols, this config option
> +	  allows having aliases for global variables names too.
> +
>  # end of the "standard kernel features (expert users)" menu
>=20
>  # syscall, maps, verifier
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index b3a6aa8fbe8c..3d9756a6eb3e 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -15,6 +15,14 @@ include $(srctree)/scripts/Makefile.lib
>  # find all modules listed in modules.order
>  modules :=3D $(call read-file, $(MODORDER))
>=20
> +ifeq ($(KBUILD_BUILTIN),y)
> +  ifeq ($(or
> $(CONFIG_DEBUG_INFO_BTF_MODULES),$(CONFIG_KALLSYMS_ALIAS_SRCLINE)),y) +  =
=20
> VMLINUX_DEP :=3D vmlinux
> +  endif
> +endif
> +
> +VMLINUX_DEP ?=3D
> +
>  __modfinal: $(modules:%.o=3D%.ko)
>  	@:
>=20
> @@ -55,7 +63,7 @@ if_changed_except =3D $(if $(call
> newer_prereqs_except,$(2))$(cmd-check),      \ printf '%s\n' 'savedcmd_$@
> :=3D $(make-cmd)' > $(dot-target).cmd, @:)
>=20
>  # Re-generate module BTFs if either module's .ko or vmlinux changed
> -%.ko: %.o %.mod.o scripts/module.lds $(and
> $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),vmlinux) FORCE +%.ko:
> %.o %.mod.o scripts/module.lds $(VMLINUX_DEP) FORCE
>  	+$(call if_changed_except,ld_ko_o,vmlinux)
>  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>  	+$(if $(newer-prereqs),$(call cmd,btf_ko))
> diff --git a/scripts/kas_alias.py b/scripts/kas_alias.py
> new file mode 100755
> index 000000000000..bc930039867b
> --- /dev/null
> +++ b/scripts/kas_alias.py
> @@ -0,0 +1,545 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Copyright (C) 2023 Red Hat, Inc. Alessandro Carminati
> <alessandro.carminati@gmail.com> +#
> +# kas_alias: Adds alias to duplicate symbols for the kallsyms output.
> +
> +import os
> +import re
> +import argparse
> +import subprocess
> +from enum import Enum
> +from collections import namedtuple
> +
> +# Regex representing symbols that needs no alias
> +regex_filter =3D [
> +        "^__compound_literal\\.[0-9]+$",
> +        "^__[wm]*key\\.[0-9]+$",
> +        "^_*TRACE_SYSTEM.*$",
> +        "^__already_done\\.[0-9]+$",
> +        "^__msg\\.[0-9]+$",
> +        "^__func__\\.[0-9]+$",
> +        "^CSWTCH\\.[0-9]+$",
> +        "^_rs\\.[0-9]+$",
> +        "^___tp_str\\.[0-9]+$",
> +        "^__flags\\.[0-9]+$",
> +        "^___done\\.[0-9]+$",
> +        "^__print_once\\.[0-9]+$",
> +        "^___once_key\\.[0-9]+$",
> +        "^__pfx_.*$",
> +        "^__cfi_.*$",
> +        "^\\.LC[0-9]+$",
> +        "^\\.L[0-9]+.[0-9]+$",
> +        "^__UNIQUE_ID_.*$",
> +        "^symbols\\.[0-9]+$",
> +        "^_note_[0-9]+$"
> +        ]
> +
> +class DebugLevel(Enum):
> +    PRODUCTION =3D 0
> +    INFO =3D 1
> +    DEBUG_BASIC =3D 2
> +    DEBUG_MODULES =3D 3
> +    DEBUG_ALL =3D 4
> +
> +class SeparatorType:
> +    def __call__(self, separator):
> +        if len(separator) !=3D 1:
> +            raise argparse.ArgumentTypeError("Separator must be a single
> character") +        return separator
> +
> +class Addr2LineError(Exception):
> +    pass
> +
> +debug =3D DebugLevel.PRODUCTION
> +
> +Line =3D namedtuple('Line', ['address', 'type', 'name'])
> +
> +def parse_nm_lines(lines, name_occurrences=3DNone):
> +    """
> +    Parses a given nm output and returns the symbol list along with a ha=
sh
> of +    symbol occurrences.
> +    Args:
> +      lines: List of tuples representing one nm line.
> +      name_occurrences: Hash having the name as key, used to count names'
> +                        occurrences.
> +    Returns:
> +      Creates a new line list proper for the nm output it parsed and,
> updates +      the occurrences hash.
> +  """

Nit: The triple quote is not aligned.

> +    if debug >=3D DebugLevel.DEBUG_BASIC.value:
> +       print("parse_nm_lines: parse start")

Nit: You can define a logging function which takes the debug level as first=
=20
argument and only prints if its greater or egal than=20
DebugLevel.DEBUG_BASIC.value.

> +    if name_occurrences is None:
> +        name_occurrences =3D {}
> +
> +    symbol_list =3D []
> +
> +    for line in lines:
> +        fields =3D line.strip().split()
> +
> +        if len(fields) >=3D 3:
> +            address, type, name =3D fields[0], fields[1], '
> '.join(fields[2:]) +            symbol_list.append(Line(address, type,
> name))
> +            name_occurrences[name] =3D name_occurrences.get(name, 0) + 1
> +
> +    return symbol_list, name_occurrences
> +
> +def start_addr2line_process(binary_file, addr2line_file):
> +    """
> +    Initializes an addr2line server process operating on the given ELF
> object. +    Args:
> +      binary_file: String representing the binary file name object of
> addr2line +                   queries.
> +      addr2line_file: String representing the addr2line executable name.
> +    Returns:
> +      Returns addr2line process descriptor.
> +    """
> +    if debug >=3D DebugLevel.DEBUG_BASIC.value:
> +       print(f"start_addr2line_process: Starting addr2line process on
> {binary_file}") +
> +    try:
> +        addr2line_process =3D subprocess.Popen([addr2line_file, '-fe',
> +                                             binary_file],
> +                                             stdin=3Dsubprocess.PIPE,
> +                                             stdout=3Dsubprocess.PIPE,
> +                                             stderr=3Dsubprocess.PIPE,
> +                                             text=3DTrue)
> +        return addr2line_process
> +    except Exception as e:
> +         raise SystemExit(f"Fatal: Can't start addr2line resolver: {e}")
> +
> +
> +def addr2line_fetch_address(addr2line_process, address):
> +    """
> +    Queries a specific address using the active addr2line process.
> +    Args:
> +      addr2line_process: Descriptor of the addr2line process that is wan=
ted
> to +                         handle the query.
> +      address: The address of the symbol that needs to be resolved.
> +    Returns:
> +      Returns a string representing the file and line number where the
> symbol +      at the specified address has been defined. The address is
> normalized +      before being returned.
> +  """
> +    if debug >=3D DebugLevel.DEBUG_ALL.value:
> +       print(f"addr2line_fetch_address: Resolving {address}")
> +
> +    try:
> +        addr2line_process.stdin.write(address + '\n')
> +        addr2line_process.stdin.flush()
> +        addr2line_process.stdout.readline().strip()
> +        output =3D addr2line_process.stdout.readline().strip()
> +
> +        return os.path.normpath(output)
> +    except Exception as e:
> +        raise SystemExit(
> +                         "Fatal: Error communicating with"
> +                         f" the addr2line resolver: {e}."
> +                        )
> +
> +def process_line(line, process_data_sym, init_section_info):
> +    """
> +    Determines whether a duplicate item requires an alias or not.
> +    Args:
> +      line: nm line object that needs to be checked.
> +      process_data_sym: Flag indicating that the script requires to prod=
uce
> alias +                        also for data symbols.

Nit: init_section_info is not documented.

> +    Returns:
> +      Returns true if the line needs to be processed, false otherwise.
> +    """
> +    if debug >=3D DebugLevel.DEBUG_ALL.value:
> +       print(f"process_line: Processing {line.address} {line.type}
> {line.name}") +
> +    # The module contains symbols that were discarded after being loaded.
> Typically, +    # these symbols belong to the initialization function.
> These symbols have their +    # address in the init section addresses, so
> this check prevents these symbols +    # from being assigned aliases.
> +    if init_section_info !=3D None:
> +        if (int(line.address, 16) >=3D init_section_info["address"] and
> +          int(line.address, 16) <=3D init_section_info["address"] +
> init_section_info["size"]): +            if debug >=3D
> DebugLevel.DEBUG_ALL.value:

Nit: You can declare the following variable:
hex_adress =3D int(line.address, 16)
To avoid doing the cast twice (I do not know how Python optimizes code, so=
=20
maybe this is not needed).

> +                print(f"process_line: Skip {line.name} since its address=
 is
> .init.text") +            return False
> +
> +    if process_data_sym:
> +        return not (any(re.match(regex, line.name) for regex in
> regex_filter)) +    else:
> +        return (line.type in {"T", "t"}) and (
> +                not (any(re.match(regex, line.name) for regex in
> regex_filter))) +
> +def fetch_file_lines(filename):
> +    """
> +    Reads a text file and retrieves its content.
> +    Args:
> +      filename: String representing the name of the file that needs to be
> read. +    Returns:
> +      Returns a string list representing the lines read in the file.
> +    """
> +    if debug >=3D DebugLevel.DEBUG_BASIC.value:
> +       print(f"fetch_file_lines: Fetch {filename}")
> +
> +    try:
> +        with open(filename, 'r') as file:
> +            lines =3D [line.strip() for line in file.readlines()]
> +        return lines
> +    except FileNotFoundError:
> +        raise SystemExit(f"Fatal: File not found: {filename}")
> +
> +def do_nm(filename, nm_executable):
> +    """
> +    Runs the nm command on a specified file.
> +    Args:
> +      filename: String representing the name of the file on which nm sho=
uld
> +      run against.
> +      nm_executable: String representing the nm executable filename.
> +    Returns:
> +      Returns a strings list representing the nm output.
> +    """
> +    # Later, during processing, objcopy cannot modify files in place when
> +    # adding new alias symbols. It requires a source file and a destinat=
ion
> +    # file.
> +    # After this operation, there is an object file ".o" with the aliases
> and +    # a ".k{0,1}o.orig" file, which is the old intended object and
> serves as the +    # source for objcopy.
> +    # In a fresh build, the state is just fine.
> +    # However, in a second build without clean, an issue arises.
> +    # The ".k{0,1}o" file already contain the alias, and reprocessing it,
> do +    # corrupt the final result. To address this, do_nm must check if
> the file +    # ".k{0,1}o.orig" already exists.
> +    # If it does, that's the target for nm and must be renamed in
> ".k{0,1}o" +    # to restore the intended state. If not, it's a fresh
> build, and nm can +    # proceed with the ".k{0,1}o" file.
> +    backup_file =3D filename + '.orig'
> +    if os.path.exists(backup_file):
> +        print(f"do_nm: {filename} is not clean, restore {backup_file} to
> {filename}") +        os.rename(backup_file, filename)

Nit: Should the print be done conditionally on debug level?

> +
> +    if debug >=3D DebugLevel.DEBUG_BASIC.value:
> +       print(f"do_nm: executing {nm_executable} -n {filename}")
> +
> +    try:
> +        nm_output =3D subprocess.check_output([nm_executable, '-n',
> filename], +                      universal_newlines=3DTrue,
> stderr=3Dsubprocess.STDOUT).splitlines() +        return nm_output
> +    except subprocess.CalledProcessError as e:
> +        raise SystemExit(f"Fatal: Error executing nm: {e}")
> +
> +def make_objcpy_arg(line, decoration, elf_section_names):
> +    """
> +    Produces an objcopy argument statement for a single alias to be added
> in a +    module.
> +    Args:
> +      line: nm line object target for this iteration.
> +      decoration: String representing the decoration (normalized addr2li=
ne
> +                  output) to be added at the symbol name to have the ali=
as.
> +      elf_section_names: List of the section names that can be used by
> objcopy +                         to add a symbol to the ELF symbol table.
> +    Returns:
> +      Returns a string that directly maps the argument string objcopy
> should +      use to add the alias.
> +    """
> +    try:
> +        section =3D (
> +            elf_section_names[".text"] if line.type.upper() =3D=3D "T" e=
lse (
> +                elf_section_names[".data"] if line.type.upper() =3D=3D "=
D" else
> ( +                    elf_section_names[".rodata"] if line.type.upper() =
=3D=3D
> "R" else ".bss" +                )
> +            )
> +        )
> +        flag =3D "global" if line.type.isupper() else "local"
> +
> +        if debug >=3D DebugLevel.DEBUG_MODULES.value:
> +           print("make_objcpy_arg: "
> +                 f"{line.name +
> decoration}=3D{section}:0x{line.address},{flag}") +
> +
> +        return (
> +                "--add-symbol "
> +                f"{line.name +
> decoration}=3D{section}:0x{line.address},{flag} " +               )
> +    except Exception:
> +        print(
> +              f"make_objcpy_arg warning: Skip alias for {line.name}"
> +              f" type {line.type} because no corresponding section found=
=2E")
> +        return ""
> +
> +def execute_objcopy(objcopy_executable, objcopy_args, object_file):
> +    """
> +    Uses objcopy to add aliases to a given module object file.
> +    Since objcopy can't operate in place, the original object file is
> renamed +    before operating on it. At function end, a new object file
> having the old +    object's name is carrying the aliases for the duplica=
te
> symbols. +    Args:
> +      objcopy_executable: String representing the object copy executable
> file. +      objcopy_args: Arguments (aliases to add to the object file) =
to
> be used +                    in the objcopy execution command line.
> +      object_file: Target object file (module object file) against which
> objcopy is executed. +    Returns:
> +      Nothing is returned, but as a side effect of this function executi=
on,
> +      the module's object file contains the aliases for duplicated
> symbols. +    """
> +    # Rename the original object file by adding a suffix
> +    backup_file =3D object_file + '.orig'
> +    if debug >=3D DebugLevel.DEBUG_MODULES.value:
> +       print("execute_objcopy: "
> +             f"rename {object_file} to {backup_file}")
> +    os.rename(object_file, backup_file)
> +
> +    full_command =3D (
> +                    f"{objcopy_executable} "
> +                    f"{objcopy_args} {backup_file} {object_file}"
> +                   )
> +    if debug >=3D DebugLevel.DEBUG_MODULES.value:
> +       print(f"execute_objcopy: executing {full_command}")
> +
> +    try:
> +        subprocess.run(full_command, shell=3DTrue, check=3DTrue)
> +    except subprocess.CalledProcessError as e:
> +        os.rename(backup_file, object_file)
> +        raise SystemExit(f"Fatal: Error executing objcopy: {e}")
> +
> +def generate_decoration(line, config, addr2line_process):
> +    """
> +    Generates symbol decoration to be used to make the alias name, by
> +    querying addr2line.
> +    Args:
> +      line: nm line object that needs an alias.
> +      config: Object containing command line configuration.
> +      addr2line_process: Descriptor of the addr2line process that serves
> +                         the binary object where the symbol belongs.
> +    Returns:
> +      Returns a string representing the decoration for the given symbol,
> +      or empty string if this can not be done. E.g., addr2line can't find
> +      the point where the symbol is defined.
> +    """
> +    output =3D addr2line_fetch_address(addr2line_process, line.address)
> +    decoration =3D config.separator + "".join(
> +        "_" if not c.isalnum() else c for c in
> output.replace(config.linux_base_dir, "") +    )
> +    # The addr2line can emit the special string "?:??" when addr2line can
> not find the +    # specified address in the DWARF section that after
> normalization it becomes "____". +    # In such cases, emitting an alias
> wouldn't make sense, so it is skipped. +    if decoration !=3D
> config.separator + "____":
> +       return decoration
> +    return ""
> +
> +def get_objdump_text(objdump_executable, file_to_operate):
> +    """
> +    objdump output is needed for a couple of functions revolving around
> +    modules. This function kust query objdump to emit sections info and

Nit: "This function just queries".

> +    return its output.
> +    Args:
> +      objdump_executable: String representing the objdump executable.
> +      file_to_operate: file whose section names are wanted.
> +    Returns:
> +      Returns objdump output.
> +    """
> +    try:
> +        output =3D subprocess.check_output(
> +                   [objdump_executable, '-h', file_to_operate],
> +                   universal_newlines=3DTrue)
> +
> +    except Exception as e:
> +        raise SystemExit(
> +                         "Fatal: Can't find section names"
> +                         f" for {file_to_operate}. Error: {e}"
> +                        )
> +    return output
> +
> +def get_init_text_info(objdump_lines):
> +    """
> +    Recovers info on the .init.text section.
> +    Args:
> +      objdump_lines: output from objdump -h command.
> +    Returns:
> +      Returns a map containing the size and address of the .init.text
> section +      None if it is not there.
> +    """
> +    section_info =3D None
> +    section_name_pattern =3D re.compile(r'^\s*\d+')
> +
> +    for line in objdump_lines.strip().splitlines():
> +        if section_name_pattern.match(line):
> +            parts =3D line.split()
> +            if len(parts) >=3D 2:
> +                current_section_name =3D parts[1]
> +                if current_section_name =3D=3D ".init.text":
> +                    size =3D int(parts[2], 16)
> +                    address =3D int(parts[3], 16)
> +                    section_info =3D {"size": size, "address": address}
> +                    break
> +
> +    return section_info
> +
> +def get_section_names(objdump_lines):
> +    """
> +    objcopy needs to refer to a section name to assign the symbol type.
> +    Unfortunately, not always all the section are present into a given
> +    object file exist, for example, ".rodata" can not exist, and a [Rr]
> +    symbol my refer to some other section e.g., ".rodata.str1".
> +    For this reason this function tries to recover the exact names to use
> +    in an objcopy statement.
> +    Args:
> +      objdump_lines: output from objdump -h command.
> +    Returns:
> +      Returns a map containing four string indexed with typical section
> +      names.
> +    """
> +    section_names =3D []
> +    lines =3D objdump_lines.strip().splitlines()
> +    section_name_pattern =3D re.compile(r'^\s*\d+')
> +    for line in lines:
> +        if section_name_pattern.match(line):
> +            parts =3D line.split()
> +            if len(parts) >=3D 2:
> +                section_name =3D parts[1]
> +                section_names.append(section_name)
> +
> +    best_matches =3D [".text", ".rodata", ".data", ".bss"]
> +    result =3D {}
> +
> +    for match in best_matches:
> +        for section_name in section_names:
> +            if re.match(match+".*", section_name):

Nit: Is a regex needed? Or simply checking the section_name contains the=20
string is OK?

> +                result[match] =3D section_name
> +
> +    if debug >=3D DebugLevel.DEBUG_MODULES.value:
> +        for key, value in result.items():
> +            print(f"get_section_names: sections {key} =3D {value}")
> +
> +    return result
> +
> +def produce_output_modules(config, symbol_list, name_occurrences,
> +                           module_file_name, addr2line_process):
> +    """
> +    Computes the alias addition on a given module object file.
> +    Args:
> +      config: Object containing command line configuration.
> +      symbol_list: List of tuples representing nm lines for the given
> object +                   file.
> +      name_occurrences: Hash that stores symbol occurreces for the build.
> +      module_file_name: String representing the target moule object file.
> +      addr2line_process: Descriptor of the addr2line process that is wan=
ted
> to +                         handle the query.
> +    Returns:
> +      Nothing is returned, but as a side effect of this function executi=
on,
> +      the module's object file contains the aliases for duplicated
> symbols. +    """
> +    objcopy_args =3D "";
> +    args_cnt =3D 0
> +    objdump_data =3D get_objdump_text(config.objdump_file, module_file_n=
ame)
> +    elf_section_names =3D get_section_names(objdump_data)
> +    init_text_section_data =3D get_init_text_info(objdump_data)
> +    for obj in symbol_list:
> +        if (name_occurrences[obj.name] > 1) and process_line(obj,
> config.process_data_sym, init_text_section_data): +            decoration=
 =3D
> generate_decoration(obj, config, addr2line_process) +            if
> decoration !=3D "":
> +                objcopy_args =3D objcopy_args + make_objcpy_arg(obj,
> decoration, elf_section_names) +                args_cnt =3D args_cnt + 1
> +                if args_cnt > 50:

Is this a limitation of objcopy?

> +                   if debug >=3D DebugLevel.DEBUG_MODULES.value:
> +                      print("Produce_output_modules: Number of arguments
> high, split objcopy call into multiple statements.") +                 =20
> execute_objcopy(config.objcopy_file, objcopy_args, module_file_name) +   =
 =20
>              args_cnt =3D 0
> +                   objcopy_args =3D ""
> +
> +    execute_objcopy(config.objcopy_file, objcopy_args, module_file_name)
> +
> +def produce_output_vmlinux(config, symbol_list, name_occurrences,
> addr2line_process): +    """
> +    Computes the alias addition for the core Linux on image.
> +    Args:
> +      config: Object containing command line configuration.
> +      symbol_list: List of tuples representing nm lines for the given
> object +                   file.
> +      name_occurrences: Hash that stores symbol occurreces for the build.
> +      addr2line_process: Descriptor of the addr2line process that is wan=
ted
> to +                         handle the query.
> +    Returns:
> +      Nothing is returned, but as a side effect of this function executi=
on,
> +      the core kernel image contains the aliases for duplicated symbols.=
 +
>    """
> +    with open(config.output_file, 'w') as output_file:
> +        for obj in symbol_list:
> +            output_file.write(f"{obj.address} {obj.type} {obj.name}\n")
> +            if (name_occurrences[obj.name] > 1) and process_line(obj,
> config.process_data_sym, None): +                decoration =3D
> generate_decoration(obj, config, addr2line_process) +                if
> decoration !=3D "":
> +                    output_file.write(f"{obj.address} {obj.type} {obj.na=
me
> + decoration}\n") +
> +if __name__ =3D=3D "__main__":
> +    # Handles command-line arguments and generates a config object
> +    parser =3D argparse.ArgumentParser(description=3D'Add alias to multi=
ple
> occurring symbols name in kallsyms') +    parser.add_argument('-a',
> "--addr2line", dest=3D"addr2line_file", required=3DTrue, help=3D"Set the
> addr2line executable to be used.") +    parser.add_argument('-b',
> "--basedir", dest=3D"linux_base_dir", required=3DTrue, help=3D"Set base d=
irectory
> of the source kernel code.") +    parser.add_argument('-c', "--objcopy",
> dest=3D"objcopy_file", required=3DTrue, help=3D"Set the objcopy executabl=
e to be
> used.") +    parser.add_argument('-d', "--process_data",
> dest=3D"process_data_sym", required=3DFalse, help=3D"Requires the tool to=
 process
> data symbols along with text symbols.", action=3D'store_true') +  =20
> parser.add_argument('-e', "--nm", dest=3D"nm_file", required=3DTrue, help=
=3D"Set
> the nm executable to be used.") +    parser.add_argument('-m',
> "--modules_list", dest=3D"module_list", required=3DTrue, help=3D"Set the =
file
> containing the list of the modules object files.") +  =20
> parser.add_argument('-n', "--nmdata", dest=3D"nm_data_file", required=3DT=
rue,
> help=3D"Set vmlinux nm output file to use for core image.") +  =20
> parser.add_argument('-o', "--outfile", dest=3D"output_file", required=3DT=
rue,
> help=3D"Set the vmlinux nm output file containing aliases.") +  =20
> parser.add_argument('-s', "--separator", dest=3D"separator", required=3DF=
alse,
> help=3D"Set separator, character that separates original name from the
> addr2line data in alias symbols.", default=3D"@", type=3DSeparatorType())=
 +  =20
> parser.add_argument('-u', "--objdump", dest=3D"objdump_file", required=3D=
True,
> help=3D"Set objdump  executable to be used.") +    parser.add_argument('-=
v',
> "--vmlinux", dest=3D"vmlinux_file", required=3DTrue, help=3D"Set the vmli=
nux core
> image file.") +    parser.add_argument('-z', "--debug", dest=3D"debug",
> required=3DFalse, help=3D"Set the debug level.", choices=3D[f"{level.valu=
e}" for
> level in DebugLevel], default=3D"1" ) +    config =3D parser.parse_args()
> +    debug =3D int(config.debug)
> +
> +    try:
> +        if debug >=3D DebugLevel.INFO.value:
> +            print("kas_alias: Start processing")
> +
> +        # Determine kernel source code base directory
> +        config.linux_base_dir =3D os.path.normpath(os.getcwd() + "/" +
> config.linux_base_dir) + "/" +
> +        if debug >=3D DebugLevel.INFO.value:
> +            print("kas_alias: Process nm data from vmlinux")
> +
> +        # Process nm data from vmlinux
> +        vmlinux_nm_lines =3D fetch_file_lines(config.nm_data_file)
> +        vmlinux_symbol_list, name_occurrences =3D
> parse_nm_lines(vmlinux_nm_lines) +
> +        if debug >=3D DebugLevel.INFO.value:
> +            print("kas_alias: Process nm data for modules")
> +
> +        # Process nm data for modules
> +        module_list =3D fetch_file_lines(config.module_list)
> +        module_symbol_list =3D {}
> +        for module in module_list:
> +            module_nm_lines =3D do_nm(module, config.nm_file)
> +            module_symbol_list[module], name_occurrences =3D
> parse_nm_lines(module_nm_lines, name_occurrences) +
> +        if debug >=3D DebugLevel.INFO.value:
> +            print("kas_alias: Produce file for vmlinux")
> +
> +        # Produce file for vmlinux
> +        addr2line_process =3D start_addr2line_process(config.vmlinux_fil=
e,
> config.addr2line_file) +        produce_output_vmlinux(config,
> vmlinux_symbol_list, name_occurrences, addr2line_process) +      =20
> addr2line_process.stdin.close()
> +        addr2line_process.stdout.close()
> +        addr2line_process.stderr.close()
> +        addr2line_process.wait()
> +
> +        # link-vmlinux.sh calls this two times: Avoid running kas_alias
> twice for efficiency and prevent duplicate aliases +        # in module
> processing by checking the last letter of the nm data file +        if
> config.vmlinux_file and config.vmlinux_file[-1] =3D=3D '2': +            =
if
> debug >=3D DebugLevel.INFO.value:

Shouldn't this rather test nmdata?

> +                print("kas_alias: Add aliases to module files")
> +
> +            # Add aliases to module files
> +            for module in module_list:
> +                addr2line_process =3D start_addr2line_process(module,
> config.addr2line_file) +                produce_output_modules(config,
> module_symbol_list[module], name_occurrences, module, addr2line_process) =
+=20
>               addr2line_process.stdin.close()
> +                addr2line_process.stdout.close()
> +                addr2line_process.stderr.close()
> +                addr2line_process.wait()
> +        else:
> +            if debug >=3D DebugLevel.INFO.value:
> +                print("kas_alias: Skip module processing if pass is not =
the
> second") +
> +
> +    except Exception as e:
> +        raise SystemExit(f"Script terminated due to an error: {e}")
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index a432b171be82..beb94f1f7961 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -91,7 +91,12 @@ vmlinux_link()
>=20
>  	# The kallsyms linking does not need debug symbols included.
>  	if [ "$output" !=3D "${output#.tmp_vmlinux.kallsyms}" ] ; then
> -		ldflags=3D"${ldflags} ${wl}--strip-debug"
> +		# The kallsyms linking does not need debug symbols included,
> +		# unless the KALLSYMS_ALIAS_SRCLINE.
> +		if ! is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE && \
> +		   [ "$output" !=3D "${output#.tmp_vmlinux.kallsyms}" ] ; then
> +			ldflags=3D"${ldflags} ${wl}--strip-debug"
> +		fi
>  	fi
>=20
>  	if is_enabled CONFIG_VMLINUX_MAP; then
> @@ -161,7 +166,23 @@ kallsyms()
>  	fi
>=20
>  	info KSYMS ${2}
> -	scripts/kallsyms ${kallsymopt} ${1} > ${2}
> +	ALIAS=3D""
> +	KAS_DATA=3D""
> +	if is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE_DATA; then
> +		KAS_DATA=3D"--process_data"
> +	fi
> +	if is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE; then
> +		ALIAS=3D".alias"
> +		# You can use KAS_ALIAS_DEBUG=3D<debug level> in the make=20
statements to
> enable +		# verbose execution for kas_alias.
> +		${srctree}/scripts/kas_alias.py \
> +			--addr2line ${ADDR2LINE} --vmlinux ${kallsyms_vmlinux} \
> +			--nmdata ${1} --outfile ${1}${ALIAS} \
> +			--modules_list ${MODORDER} --nm ${NM} --debug $
{KAS_ALIAS_DEBUG:-0}\
> +			--objdump ${OBJDUMP} --objcopy ${OBJCOPY} \
> +			--basedir ${srctree} --separator @ ${KAS_DATA}
> +	fi
> +	scripts/kallsyms ${kallsymopt} ${1}${ALIAS} > ${2}
>  }
>=20
>  # Perform one step in kallsyms generation, including temporary linking of
> @@ -203,6 +224,7 @@ cleanup()
>  	rm -f System.map
>  	rm -f vmlinux
>  	rm -f vmlinux.map
> +	find . -type f -name "*.orig" -exec rm {} \;
>  }
>=20
>  # Use "make V=3D1" to debug this script


Best regards.


