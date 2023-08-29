Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE2178CD2F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbjH2Tyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjH2TyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:54:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1517F1A6;
        Tue, 29 Aug 2023 12:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Va/RSFhbdKl23N01Y3bjzYNfsXfnbqRnHN67I1kNSDw=; b=q/+n7Xi+eRdEMRNDoI3mCYXYAf
        FeDJF/NmB2WoDQHGWWRumW6W8c74QxZH14hxg+AG3HkNiAIkayMU6PhZvW1VNGExP1W37bhYOtClG
        vhCTU1k6qjwVB4MHhVjG8/HGIiWYL9uNgz6FHpCGYCvBLznSiO7D2cfbeU2x9t6rOCOT/rFTB8YrT
        s8YLSJ26KhFR+7X2KAma6wvTqGl+3xL2QWktM4yhM93laZl7IeOT/9W0B9P5EtmZEORfhMiOjqX1W
        XLxl6F98+Bzkzlr6DUo1xUS0w565f//46t73LiJYry/H2KJ/xEoUWB6QlFp5ANONVTN7KkwHkL+ss
        nbFsMiCA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qb4mx-00CBqm-0o;
        Tue, 29 Aug 2023 19:54:11 +0000
Date:   Tue, 29 Aug 2023 12:54:11 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-modules@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de,
        gregkh@linuxfoundation.org, manuel.lauss@gmail.com,
        kuba@kernel.org, kumba@gentoo.org, palmer@rivosinc.com,
        masahiroy@kernel.org, rdunlap@infradead.org, zeming@nfschina.com,
        rongtao@cestc.cn, arnd@arndb.de, pmladek@suse.com,
        chenjiahao16@huawei.com, christian@bricart.de,
        peterz@infradead.org, song@kernel.org, keescook@chromium.org,
        thunder.leizhen@huawei.com, mcgrof@kernel.org
Subject: [GIT PULL] Modules changes for v6.6-rc1
Message-ID: <ZO5M45JsJYzNF59H@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.6-rc1

for you to fetch changes up to a419beac4a070aff63c520f36ebf7cb8a76a8ae5:

  module/decompress: use vmalloc() for zstd decompression workspace (2023-08-29 09:39:08 -0700)

I forgot to mention below that most of this except the last couple of minor
patches have been in linux-next for about a month.

----------------------------------------------------------------
Modules changes for v6.6-rc1

Summary of the changes worth highlighting from most interesting to boring below:

  * Christoph Hellwig's symbol_get() fix to Nvidia's efforts to circumvent the
    protection he put in place in year 2020 to prevent proprietary modules from
    using GPL only symbols, and also ensuring proprietary modules which export
    symbols grandfather their taint. That was done through year 2020 commit
    262e6ae7081d ("modules: inherit TAINT_PROPRIETARY_MODULE"). Christoph's new
    fix is done by clarifing __symbol_get() was only ever intended to prevent
    module reference loops by Linux kernel modules and so making it only find
    symbols exported via EXPORT_SYMBOL_GPL(). The circumvention tactic used
    by Nvidia was to use symbol_get() to purposely swift through proprietary
    module symbols and completley bypass our traditional EXPORT_SYMBOL*()
    annotations and community agreed upon restrictions.

    A small set of preamble patches fix up a few symbols which just needed
    adjusting for this on two modules, the rtc ds1685 and the networking enetc
    module. Two other modules just needed some build fixing and removal of use
    of __symbol_get() as they can't ever be modular, as was done by Arnd on
    the ARM pxa module and Christoph did on the mmc au1xmmc driver.

    This is a good reminder to us that symbol_get() is just a hack to address
    things which should be fixed through Kconfig at build time as was done in
    the later patches, and so ultimately it should just go.

  * Extremely late minor fix for old module layout 055f23b74b20 ("module: check
    for exit sections in layout_sections() instead of module_init_section()") by
    James Morse for arm64. Note that this layout thing is old, it is *not*
    Song Liu's commit ac3b43283923 ("module: replace module_layout with
    module_memory"). The issue however is very odd to run into and so there was
    no hurry to get this in fast.

  * Although the fix did not go through the modules tree I'd like to highlight
    the fix by Peter Zijlstra in commit 54097309620e ("x86/static_call: Fix
    __static_call_fixup()") now merged in your tree which came out of what
    was originally suspected to be a fallout of the the newer module layout
    changes by Song Liu commit ac3b43283923 ("module: replace module_layout
    with module_memory") instead of module_init_section()"). Thanks to the report
    by Christian Bricart and the debugging by Song Liu & Peter that turned to
    be noted as a kernel regression in place since v5.19 through commit
    ee88d363d156 ("x86,static_call: Use alternative RET encoding").

    I highlight this to reflect and clarify that we haven't seen more fallout
    from ac3b43283923 ("module: replace module_layout with module_memory").

  * RISC-V toolchain got mapping symbol support which prefix symbols with "$"
    to help with alignment considerations for disassembly. This is used to
    differentiate between incompatible instruction encodings when disassembling.
    RISC-V just matches what ARM/AARCH64 did for alignment considerations and
    Palmer Dabbelt extended is_mapping_symbol() to accept these symbols for
    RISC-V. We already had support for this for all architectures but it also
    checked for the second character, the RISC-V check Dabbelt added was just
    for the "$". After a bit of testing and fallout on linux-next and based on
    feedback from Masahiro Yamada it was decided to simplify the check and treat
    the first char "$" as unique for all architectures, and so we no make
    is_mapping_symbol() for all archs if the symbol starts with "$".

    The most relevant commit for this for RISC-V on binutils was:

    https://sourceware.org/pipermail/binutils/2021-July/117350.html

  * A late fix by Andrea Righi (today) to make module zstd decompression use
    vmalloc() instead of kmalloc() to account for large compressed modules. I
    suspect we'll see similar things for other decompression algorithms soon.

  * samples/hw_breakpoint minor fixes by Rong Tao, Arnd Bergmann and Chen Jiahao

----------------------------------------------------------------
Andrea Righi (1):
      module/decompress: use vmalloc() for zstd decompression workspace

Arnd Bergmann (2):
      samples/hw_breakpoint: fix building without module unloading
      ARM: pxa: remove use of symbol_get()

Chen Jiahao (1):
      samples/hw_breakpoint: mark sample_hbp as static

Christoph Hellwig (4):
      mmc: au1xmmc: force non-modular build and remove symbol_get usage
      net: enetc: use EXPORT_SYMBOL_GPL for enetc_phc_index
      rtc: ds1685: use EXPORT_SYMBOL_GPL for ds1685_rtc_poweroff
      modules: only allow symbol_get of EXPORT_SYMBOL_GPL modules

James Morse (3):
      module: Expose module_init_layout_section()
      arm64: module: Use module_init_layout_section() to spot init sections
      ARM: module: Use module_init_layout_section() to spot init sections

Kees Cook (1):
      kallsyms: Add more debug output for selftest

Li zeming (1):
      kernel: params: Remove unnecessary ‘0’ values from err

Palmer Dabbelt (2):
      module: Ignore RISC-V mapping symbols too
      modpost, kallsyms: Treat add '$'-prefixed symbols as mapping symbols

Rong Tao (1):
      samples/hw_breakpoint: Fix kernel BUG 'invalid opcode: 0000'

 arch/arm/kernel/module-plts.c                    |  2 +-
 arch/arm/mach-pxa/sharpsl_pm.c                   |  2 --
 arch/arm/mach-pxa/spitz.c                        | 14 +-------------
 arch/arm64/kernel/module-plts.c                  |  2 +-
 arch/mips/alchemy/devboards/db1000.c             |  8 +-------
 arch/mips/alchemy/devboards/db1200.c             | 19 ++-----------------
 arch/mips/alchemy/devboards/db1300.c             | 10 +---------
 drivers/mmc/host/Kconfig                         |  5 +++--
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c |  2 +-
 drivers/rtc/rtc-ds1685.c                         |  2 +-
 include/linux/module_symbol.h                    |  4 +---
 include/linux/moduleloader.h                     |  5 +++++
 kernel/kallsyms_selftest.c                       | 22 ++++++++++++++++++----
 kernel/module/decompress.c                       |  4 ++--
 kernel/module/main.c                             | 16 ++++++++++++----
 kernel/params.c                                  |  2 +-
 samples/hw_breakpoint/data_breakpoint.c          |  6 ++++--
 17 files changed, 55 insertions(+), 70 deletions(-)
