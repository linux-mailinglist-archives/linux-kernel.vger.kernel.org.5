Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5E97979E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243146AbjIGRZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243246AbjIGRZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:25:02 -0400
X-Greylist: delayed 3981 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Sep 2023 10:24:36 PDT
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169BF1FF5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:24:36 -0700 (PDT)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by cantor.telenet-ops.be (Postfix) with ESMTPS id 4RhL534lcMz4x4qw
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:41:59 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c214:2eac:128d:f67e])
        by michel.telenet-ops.be with bizsmtp
        id j1hx2A00E2mGBSJ061hxtx; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGP-002m7j-Ui;
        Thu, 07 Sep 2023 15:41:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGf-00CMf5-43;
        Thu, 07 Sep 2023 15:41:57 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Philip Blundell <philb@gnu.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 00/52] m68k: W=1 fixes
Date:   Thu,  7 Sep 2023 15:41:01 +0200
Message-Id: <cover.1694093327.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series addresses the remaining (after [1]) warnings seen when
building arch/m68k/ with W=1.  Perhaps surprisingly, this work has
identified and fixes a genuine bug in the Sun-3 TLB handling (see [PATCH
39/52]).

Most of the patches in these series are fairly trivial changes with a
very low risk of introducing any regressions.  For the less trivial
patches, I did look at the assembler output before and after.  As Arnd
is working actively on enabling W=1 rather sooner than later, and if no
one objects, I plan to rebase [1] and this series after the release of
v6.6-rc1, and send it as a fixes pull request to Linus.

Note that this series does not address warnings on Coldfire or MMU-less
systems.

Thanks for your comments!

[1] "[PATCH 0/6] m68k: math-emu: Miscellaneous esthetical improvements"
    https://lore.kernel.org/r/cover.1692283195.git.geert@linux-m68k.org

Geert Uytterhoeven (52):
  m68k: kernel: Add missing asmlinkage to do_notify_resume()
  m68k: kernel: Include <linux/cpu.h> for trap_init()
  m68k: kernel: Make bad_super_trap() static
  m68k: kernel: Add and use <asm/syscalls.h>
  m68k: kernel: Add and use "ints.h"
  m68k: kernel: Add and use "process.h"
  m68k: kernel: Add and use "ptrace.h"
  m68k: kernel: Add and use "signal.h"
  m68k: kernel: Add and use "traps.h"
  m68k: kernel: Add and use "vectors.h"
  m68k: mm: Include <asm/hwtest.h> for hwreg_()
  m68k: mm: Move paging_init() to common <asm/pgtable.h>
  m68k: mm: Add and use "fault.h"
  m68k: emu: Remove unused vsnprintf() return value in nfprint()
  m68k: emu: Mark version[] __maybe_unused
  m68k: amiga: pcmcia: Replace set but not used variable by READ_ONCE()
  m68k: amiga: Add and use "amiga.h"
  m68k: atari: Document data parameter of stdma_try_lock()
  m68k: atari: Make ikbd_reset() static
  m68k: atari: Make atari_platform_init() static
  m68k: atari: Make atari_stram_map_pages() static
  m68k: atari: Add and use "atari.h"
  m68k: apollo: Remove unused debug console functions
  m68k: apollo: Make local reset, serial, and irq functions static
  m68k: apollo: Replace set but not used variable by READ_ONCE()
  m68k: apollo: Add and use "apollo.h"
  m68k: bvme6000: Make bvme6000_abort_int() static
  m68k: hp300: Include "time.h" for hp300_sched_init()
  m68k: mac: Remove unused sine_data[]
  m68k: mac: Remove unused yday in unmktime()
  m68k: mac: Make mac_platform_init() static
  m68k: mac: Add and use "mac.h"
  m68k: mvme147: Make mvme147_init_IRQ() static
  m68k: mvme16x: Remove unused sink in mvme16x_cons_write()
  m68k: mvme16x: Add and use "mvme16x.h"
  m68k: q40: Add and use "q40.h"
  m68k: sun3/3x: Include <asm/config.h> for config_sun3*()
  m68k: sun3: Improve Sun3/3x DVMA abstraction in <asm/dvma.h>
  m68k: sun3: Fix context restore in flush_tlb_range()
  m68k: sun3: Fix signature of sun3_get_model()
  m68k: sun3: Add missing asmlinkage to sun3_init()
  m68k: sun3: Remove unused orig_baddr in free_baddr()
  m68k: sun3: Remove unused start_page in sun3_bootmem_alloc()
  m68k: sun3: Remove unused vsprintf() return value in prom_printf()
  m68k: sun3: Annotate prom_printf() with __printf()
  m68k: sun3: Make print_pte() static
  m68k: sun3: Make sun3_platform_init() static
  m68k: sun3x: Fix signature of sun3_leds()
  m68k: sun3x: Do not mark dvma_map_iommu() inline
  m68k: sun3x: Make sun3x_halt() static
  m68k: sun3x: Make dvma_print() static
  m68k: sun3/3x: Add and use "sun3.h"

 arch/m68k/amiga/amiga.h            |  5 ++++
 arch/m68k/amiga/amisound.c         |  2 ++
 arch/m68k/amiga/config.c           |  4 +--
 arch/m68k/amiga/pcmcia.c           |  3 +-
 arch/m68k/apollo/apollo.h          |  4 +++
 arch/m68k/apollo/config.c          | 45 ++++++------------------------
 arch/m68k/apollo/dn_ints.c         |  8 ++++--
 arch/m68k/atari/ataints.c          |  3 +-
 arch/m68k/atari/atakeyb.c          |  2 +-
 arch/m68k/atari/atari.h            | 15 ++++++++++
 arch/m68k/atari/atasound.c         |  1 +
 arch/m68k/atari/config.c           | 13 ++-------
 arch/m68k/atari/stdma.c            |  1 +
 arch/m68k/atari/stram.c            |  2 +-
 arch/m68k/atari/time.c             |  2 ++
 arch/m68k/bvme6000/config.c        |  2 +-
 arch/m68k/emu/natfeat.c            |  3 +-
 arch/m68k/emu/nfeth.c              |  2 +-
 arch/m68k/hp300/time.c             |  2 ++
 arch/m68k/include/asm/dvma.h       |  8 +++++-
 arch/m68k/include/asm/oplib.h      |  4 ++-
 arch/m68k/include/asm/pgtable.h    |  9 ++++++
 arch/m68k/include/asm/pgtable_no.h |  1 -
 arch/m68k/include/asm/syscalls.h   | 20 +++++++++++++
 arch/m68k/include/asm/tlbflush.h   |  1 +
 arch/m68k/kernel/early_printk.c    |  4 +--
 arch/m68k/kernel/ints.c            |  2 ++
 arch/m68k/kernel/ints.h            |  7 +++++
 arch/m68k/kernel/process.c         |  1 +
 arch/m68k/kernel/process.h         |  8 ++++++
 arch/m68k/kernel/ptrace.c          |  2 ++
 arch/m68k/kernel/ptrace.h          |  6 ++++
 arch/m68k/kernel/setup_mm.c        |  2 --
 arch/m68k/kernel/signal.c          |  4 ++-
 arch/m68k/kernel/signal.h          |  7 +++++
 arch/m68k/kernel/sys_m68k.c        |  4 +--
 arch/m68k/kernel/traps.c           | 11 ++++----
 arch/m68k/kernel/traps.h           | 10 +++++++
 arch/m68k/kernel/vectors.c         |  3 ++
 arch/m68k/kernel/vectors.h         |  3 ++
 arch/m68k/mac/baboon.c             |  2 ++
 arch/m68k/mac/config.c             | 14 ++--------
 arch/m68k/mac/iop.c                |  2 ++
 arch/m68k/mac/mac.h                | 25 +++++++++++++++++
 arch/m68k/mac/macboing.c           | 11 ++------
 arch/m68k/mac/misc.c               |  5 ++--
 arch/m68k/mac/oss.c                |  2 ++
 arch/m68k/mac/psc.c                |  2 ++
 arch/m68k/mac/via.c                |  2 ++
 arch/m68k/mm/fault.c               |  2 ++
 arch/m68k/mm/fault.h               |  7 +++++
 arch/m68k/mm/hwtest.c              |  2 ++
 arch/m68k/mm/sun3kmap.c            |  6 ++--
 arch/m68k/mm/sun3mmu.c             |  2 +-
 arch/m68k/mvme147/config.c         |  2 +-
 arch/m68k/mvme16x/config.c         |  5 ++--
 arch/m68k/mvme16x/mvme16x.h        |  6 ++++
 arch/m68k/q40/config.c             |  6 ++--
 arch/m68k/q40/q40.h                |  6 ++++
 arch/m68k/q40/q40ints.c            |  2 ++
 arch/m68k/sun3/config.c            | 13 ++++-----
 arch/m68k/sun3/idprom.c            |  4 ++-
 arch/m68k/sun3/intersil.c          |  1 +
 arch/m68k/sun3/leds.c              |  2 ++
 arch/m68k/sun3/mmu_emu.c           |  3 +-
 arch/m68k/sun3/prom/printf.c       |  5 ++--
 arch/m68k/sun3/sun3.h              | 22 +++++++++++++++
 arch/m68k/sun3/sun3dvma.c          | 17 -----------
 arch/m68k/sun3/sun3ints.c          |  2 +-
 arch/m68k/sun3x/config.c           |  6 ++--
 arch/m68k/sun3x/dvma.c             |  5 ++--
 arch/m68k/sun3x/prom.c             |  2 +-
 72 files changed, 280 insertions(+), 149 deletions(-)
 create mode 100644 arch/m68k/amiga/amiga.h
 create mode 100644 arch/m68k/apollo/apollo.h
 create mode 100644 arch/m68k/atari/atari.h
 create mode 100644 arch/m68k/include/asm/syscalls.h
 create mode 100644 arch/m68k/kernel/ints.h
 create mode 100644 arch/m68k/kernel/process.h
 create mode 100644 arch/m68k/kernel/ptrace.h
 create mode 100644 arch/m68k/kernel/signal.h
 create mode 100644 arch/m68k/kernel/traps.h
 create mode 100644 arch/m68k/kernel/vectors.h
 create mode 100644 arch/m68k/mac/mac.h
 create mode 100644 arch/m68k/mm/fault.h
 create mode 100644 arch/m68k/mvme16x/mvme16x.h
 create mode 100644 arch/m68k/q40/q40.h
 create mode 100644 arch/m68k/sun3/sun3.h

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
