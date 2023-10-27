Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2FE7D8DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 06:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjJ0E3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 00:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJ0E3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 00:29:31 -0400
Received: from icp-osb-irony-out4.external.iinet.net.au (icp-osb-irony-out4.external.iinet.net.au [203.59.1.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 059D61AD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 21:29:19 -0700 (PDT)
Received: from gateway.pc5.atmailcloud.com (HELO mqr.i-08c0d97331176e550) ([13.54.26.16])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 27 Oct 2023 12:29:10 +0800
Received: from CMR-KAKADU04.i-0d656febc51e9ef2a by MQR.i-08c0d97331176e550 with esmtps
        (envelope-from <gregungerer@westnet.com.au>)
        id 1qwET7-0004bJ-2a;
        Fri, 27 Oct 2023 04:29:09 +0000
Received: from [203.87.15.156] (helo=[192.168.0.22])
         by CMR-KAKADU04.i-0d656febc51e9ef2a with esmtpsa
        (envelope-from <gregungerer@westnet.com.au>)
        id 1qwET7-0001rV-1E;
        Fri, 27 Oct 2023 04:29:09 +0000
Message-ID: <1fac9d12-2ec2-4ccb-bb81-34f3fc34789e@westnet.com.au>
Date:   Fri, 27 Oct 2023 14:29:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Greg Ungerer <gregungerer@westnet.com.au>
Subject: Re: [PATCH v5 16/21] kbuild: generate KSYMTAB entries by modpost
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>
References: <20230514152739.962109-1-masahiroy@kernel.org>
 <20230514152739.962109-17-masahiroy@kernel.org>
Content-Language: en-US
In-Reply-To: <20230514152739.962109-17-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Atmail-Id: gregungerer@westnet.com.au
X-atmailcloud-spam-action: no action
X-atmailcloud-spam-report: Action: no action
X-Cm-Envelope: MS4xfFXufhrbusa9MhPZespdi097ILTbhCSpqqe5PrGfjKRxDAoBGx2Ac1yKFXQMCFCkblxeKpMTZ49iLQgCCFrszvx3D/1h4thdV5c1noeqf7VpBXH+xn3W zPFbk8xXtfPvSgki37eaXj6jTKR33P6VY3sYikH9WrjfjsVqlwbgpXWr9n2J2HawyBgN7or7AJgcVw==
X-Cm-Analysis: v=2.4 cv=Zs0raf3G c=1 sm=1 tr=0 ts=653b3c95 a=Qq7imNNZi2wOFNr6RxuhDA==:117 a=Qq7imNNZi2wOFNr6RxuhDA==:17 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=80-xaVIC0AIA:10 a=x7bEGLp0ZPQA:10 a=VwQbUJbxAAAA:8 a=RiFP0eX-WucStWrHcg4A:9 a=QEXdDO2ut3YA:10 a=t4F5_PRhjUa2PXbBaQQF:22 a=AjGcO6oz07-iQ99wixmX:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On 15/5/23 01:27, Masahiro Yamada wrote:
> Commit 7b4537199a4a ("kbuild: link symbol CRCs at final link, removing
> CONFIG_MODULE_REL_CRCS") made modpost output CRCs in the same way
> whether the EXPORT_SYMBOL() is placed in *.c or *.S.
> 
> This commit applies a similar approach to the entire data structure of
> EXPORT_SYMBOL() for further cleanups. The EXPORT_SYMBOL() compilation
> is split into two stages.
> 
> When a source file is compiled, EXPORT_SYMBOL() is converted into a
> dummy symbol in the .export_symbol section.
> 
> For example,
> 
>      EXPORT_SYMBOL(foo);
>      EXPORT_SYMBOL_NS_GPL(bar, BAR_NAMESPACE);
> 
> will be encoded into the following assembly code:
> 
>      .section ".export_symbol","a"
>      __export_symbol__foo:
>              .asciz ""
>              .balign 8
>              .quad foo
>      .previous
> 
>      .section ".export_symbol","a"
>      __export_symbol_gpl_bar:
>              .asciz "BAR_NAMESPACE"
>              .balign 8
>              .quad bar
>      .previous
> 
> They are just markers to tell modpost the name, license, and namespace
> of the symbols. They will be dropped from the final vmlinux and modules
> because the *(.export_symbol) will go into /DISCARD/ in the linker script.
> 
> Then, modpost extracts all the information about EXPORT_SYMBOL() from the
> .export_symbol section, and generates C code:
> 
>      KSYMTAB_FUNC(foo, "", "");
>      KSYMTAB_FUNC(bar, "_gpl", "BAR_NAMESPACE");
> 
> KSYMTAB_FUNC() (or KSYMTAB_DATA() if it is data) is expanded to struct
> kernel_symbol that will be linked to the vmlinux or a module.
> 
> With this change, EXPORT_SYMBOL() works in the same way for *.c and *.S
> files, providing the following benefits.
> 
> [1] Deprecate EXPORT_DATA_SYMBOL()
> 
> In the old days, EXPORT_SYMBOL() was only available in C files. To export
> a symbol in *.S, EXPORT_SYMBOL() was placed in a separate *.c file.
> arch/arm/kernel/armksyms.c is one example written in the classic manner.
> 
> Commit 22823ab419d8 ("EXPORT_SYMBOL() for asm") removed this limitation.
> Since then, EXPORT_SYMBOL() can be placed close to the symbol definition
> in *.S files. It was a nice improvement.
> 
> However, as that commit mentioned, you need to use EXPORT_DATA_SYMBOL()
> for data objects on some architectures.
> 
> In the new approach, modpost checks symbol's type (STT_FUNC or not),
> and outputs KSYMTAB_FUNC() or KSYMTAB_DATA() accordingly.
> 
> There are only two users of EXPORT_DATA_SYMBOL:
> 
>    EXPORT_DATA_SYMBOL_GPL(empty_zero_page)    (arch/ia64/kernel/head.S)
>    EXPORT_DATA_SYMBOL(ia64_ivt)               (arch/ia64/kernel/ivt.S)
> 
> They are transformed as follows and output into .vmlinux.export.c
> 
>    KSYMTAB_DATA(empty_zero_page, "_gpl", "");
>    KSYMTAB_DATA(ia64_ivt, "", "");
> 
> The other EXPORT_SYMBOL users in ia64 assembly are output as
> KSYMTAB_FUNC().
> 
> EXPORT_DATA_SYMBOL() is now deprecated.
> 
> [2] merge <linux/export.h> and <asm-generic/export.h>
> 
> There are two similar header implementations:
> 
>    include/linux/export.h        for .c files
>    include/asm-generic/export.h  for .S files
> 
> Ideally, the functionality should be consistent between them, but they
> tend to diverge.
> 
> Commit 8651ec01daed ("module: add support for symbol namespaces.") did
> not support the namespace for *.S files.
> 
> This commit shifts the essential implementation part to C, which supports
> EXPORT_SYMBOL_NS() for *.S files.
> 
> <asm/export.h> and <asm-generic/export.h> will remain as a wrapper of
> <linux/export.h> for a while.
> 
> They will be removed after #include <asm/export.h> directives are all
> replaced with #include <linux/export.h>.
> 
> [3] Implement CONFIG_TRIM_UNUSED_KSYMS in one-pass algorithm (by a later commit)
> 
> When CONFIG_TRIM_UNUSED_KSYMS is enabled, Kbuild recursively traverses
> the directory tree to determine which EXPORT_SYMBOL to trim. If an
> EXPORT_SYMBOL turns out to be unused by anyone, Kbuild begins the
> second traverse, where some source files are recompiled with their
> EXPORT_SYMBOL() tuned into a no-op.
> 
> We can do this better now; modpost can selectively emit KSYMTAB entries
> that are really used by modules.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

This breaks building kernels with an m68k-uclinux-gcc toolchain that have
modules configured. Before this change they built and ran fine.
They build and run fine if CONFIG_MODULES is not set.

A few hundred errors like this spew out:

     scripts/mod/modpost -o Module.symvers -T modules.order vmlinux.o
     ERROR: modpost: vmlinux: .export_symbol section references '', but it does not seem to be an export symbol
     ERROR: modpost: vmlinux: .export_symbol section references '', but it does not seem to be an export symbol
     ERROR: modpost: vmlinux: .export_symbol section references '', but it does not seem to be an export symbol
     ...

This is still broken all the way through to the current 6.6-rc7, though the error
messages are slightly better:

     ERROR: modpost: vmlinux: local symbol 'system_state' was exported
     ERROR: modpost: vmlinux: local symbol 'static_key_initialized' was exported
     ERROR: modpost: vmlinux: local symbol 'reset_devices' was exported
     ...

I tried a bunch of different binutils and gcc versions (binutils-2.251 through
2.40 and gcc versions 8.3.0 through 12.3.0). If I compile with an m68k-linux
targeted toolchain then it works - no modpost processing problems.

nm reports the same information for symbols in both cases, eg:

$ m68k-uclinux-nm vmlinux.o | grep system_state
00000000 r __export_symbol_system_state
00000008 B system_state
0000000c d __UNIQUE_ID___addressable_system_state320

$ m68k-linux-nm vmlinux.o | grep system_state
00000000 r __export_symbol_system_state
00000008 B system_state
0000000c d __UNIQUE_ID___addressable_system_state320

Tracing in scripts/mod/modpost.c I see that for this symbol example
("system_state") that ELF_ST_BIND(sym->st_info) is 0x0 for the
m68k-uclinux toolchain case, so STB_LOCAL, whereas for the m68k-linux
case it is 0x1, so STB_GLOBAL.

Any idea what is going on here?

Regards
Greg
