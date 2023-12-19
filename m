Return-Path: <linux-kernel+bounces-6004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447BE81930D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68DE51C251AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C3341212;
	Tue, 19 Dec 2023 22:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5QMTCd6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E570D3D0A3;
	Tue, 19 Dec 2023 22:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77895C433C8;
	Tue, 19 Dec 2023 22:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703023395;
	bh=LSGLbURhz4kXuH8yA/CEvKS5/EgYgYOz98eK0xHObss=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=l5QMTCd6HhdF6a60y0+ypSrNUmQuyb4sq4bLoTyTncjbOyZItzHM6lQ0IBaj9nXSI
	 jQXPiShC+bJup8TdCwu1KZEo8Ih+xleXNciySMqkDRqvFLr056+Mfysy2vwgkhHlUT
	 mmdJSEZ66+3B/AQ2lAmIYxIMu9XmxQkATGzgcF5ReuuhmNPVdzUIScE7hdV/PTUULF
	 spCjtLWprJcYRhO0llpsDvTW01Z6boNbm4CAj7OxHMWVyZJDlBBg9SSD+4fcuaNT+z
	 EW1KAZlPCobJ4NGCgxJycaZC/nwEqLJMAN5G/2g1+P3Vt6d0pEc8UVJ/9XMp67Z81h
	 gZckrNAhMoFww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7DBC46CCD;
	Tue, 19 Dec 2023 22:03:15 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Subject: [PATCH 00/27] sparc32: sunset sun4m and sun4d
Date: Tue, 19 Dec 2023 23:03:05 +0100
Message-Id: <20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABoTgmUC/x3MTQqEMAxA4atI1gZs6uDPVcRFsHHMwiqNiiDef
 cosv8V7D5gkFYO+eCDJpaZbzHBlAdPC8SuoIRuoIu/IdWi8ou2cJk9oZzQ58PJYNx8n3HaBKUB
 u9ySz3v/vML7vDwFqAWNnAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Arnd Bergmann <arnd@kernel.org>, Andreas Larsson <andreas@gaisler.com>
Cc: Helge Deller <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Alan Stern <stern@rowland.harvard.edu>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, sparclinux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-sound@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703023392; l=8425;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=LSGLbURhz4kXuH8yA/CEvKS5/EgYgYOz98eK0xHObss=; =?utf-8?q?b=3DO6RVaNl0bgru?=
 =?utf-8?q?hPQwsWhDUiXWfR4vIytJ1HAcnLakB1LjztJc5BZKZw3ByqrtNAf2zZmJ5AdxcVpi?=
 zfZrtpnDADyn77qNG90KZonJHpAywnInvHSywzOhGk578Gr1t+y+
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

This is the second attempt to sunset sun4m and sun4d.
See [1] for the inital attempt.

The sun4m and sun4d parts of the kernel have seen no real interest
for several years now. Last time a few people surfaced, but it was
either due to a personal project or for nostalgic reasons.
It is time to let go and drop the parts of sparc32 that in reality
are not in use.

LEON from Frontgrade Gaisler is the only real user of sparc32,
and this patchset reduces sparc32 to what is required by LEON.

The defconfig is first adapted to the one used by Gaisler.
Then the patches removes sun4m and sun4d specific
implementations such as small drivers, SMP support, IRQ suppor etc.

Removing sun4m and sun4d support allowed removal of the run time
patching of the code as well as a lot of assembler code.
The result is a much cleaner assembler code that is easier to
understand and thus maintain and extend.

So far the code builds but it has seen no run-time testing.

If anyone can tell me how to boot a linux kernel with the leon_genric
machine with QEMU that would be super as this would be a minimal
testing that others can reproduce as well.
I assume QEMU needs a few patches to make it work, but maybe I
just failed to use the right bootloader.

TODO before this can be applied:
- Ack from davem - as he is the principal sparc maintainer
- Tested-by: preferably on a target or QEMU (see above)
  I expect bugs as there are some involved changes!

Ideas for the future
- Apply the most relevant downstream Gaisler patches
  - The ones introducing CAS should have preference as we then
    can drop the cmpxchg emulation
- Adjust defconfig to include all Gaisler drivers to make sure they
  see build time coverage
- Move the leon bits from leon files to the general files
  - Add leon smp support to smp_32.c
  - Add leon irq support to irq_32.c
- Integrate leom_mm support with srmmu and drop some of the
  function operations that are no longer needed
- The current sparc32 code assume the bootloader uses the prom
  provided by sun. Maybe migrate over to a more modern device tree
  way of working.
- Drop some of the homegrown memory allocators and use memblocks

[1]: https://lore.kernel.org/all/20201218184347.2180772-1-sam@ravnborg.org/

        Sam

---
Sam Ravnborg (27):
      sparc32: Update defconfig to LEON SMP
      sparc32: Drop sun4m/sun4d support from head_32.S
      sparc32: Drop floppy support
      sparc32: Drop sun4m specific led driver
      sparc32: Drop sun specific power management drivers
      sparc32: Drop auxio support
      sparc32: Drop run-time patching of ipi trap
      sparc32: Drop patching of interrupt vector
      sparc32: Drop sun4m/sun4d specific irq handling
      sparc32: Drop sun4d/sun4m smp support
      sparc32: Drop pcic support
      sparc32: Drop mbus support
      sparc32: Drop unused function __get_{phys,iospace}
      sparc32: Drop unused mmu models
      sparc32: Drop check for sparc_model
      sparc32: Drop use of sparc_config
      sparc32: Drop run-time patching of ASI instructions
      sparc32: Drop support for 7 register windows
      sparc32: Drop additional sun4d bits
      sparc32: Drop unused prom ranges support
      sparc32: Drop unused iommu support
      sparc32: Drop sun4m irq support
      sparc32: Drop unused trampoline code
      sparc32: Drop config SPARC_LEON
      sparc32: Drop sbus support
      sbus: char: Drop now unused uctrl driver
      fbdev/p9100: Drop now unused driver p9100

 arch/sparc/Kconfig                    |  54 +--
 arch/sparc/configs/sparc32_defconfig  | 170 +++----
 arch/sparc/include/asm/asmmacro.h     |  22 -
 arch/sparc/include/asm/auxio_32.h     |  73 +--
 arch/sparc/include/asm/cpu_type.h     |  18 -
 arch/sparc/include/asm/elf_32.h       |   2 -
 arch/sparc/include/asm/fb.h           |   8 +-
 arch/sparc/include/asm/floppy.h       |   2 -
 arch/sparc/include/asm/floppy_32.h    | 393 ----------------
 arch/sparc/include/asm/io-unit.h      |  59 ---
 arch/sparc/include/asm/io_32.h        |  83 ----
 arch/sparc/include/asm/iommu.h        |   2 -
 arch/sparc/include/asm/iommu_32.h     | 122 -----
 arch/sparc/include/asm/irq_32.h       |   2 -
 arch/sparc/include/asm/mbus.h         |  97 ----
 arch/sparc/include/asm/mxcc.h         | 138 ------
 arch/sparc/include/asm/obio.h         | 226 ---------
 arch/sparc/include/asm/oplib_32.h     |  11 -
 arch/sparc/include/asm/pcic.h         | 130 ------
 arch/sparc/include/asm/pgtable_32.h   |  24 -
 arch/sparc/include/asm/pgtsrmmu.h     |  33 +-
 arch/sparc/include/asm/ross.h         | 192 --------
 arch/sparc/include/asm/sbi.h          | 116 -----
 arch/sparc/include/asm/sections.h     |   3 -
 arch/sparc/include/asm/swift.h        | 107 -----
 arch/sparc/include/asm/switch_to_32.h |   1 -
 arch/sparc/include/asm/timer_32.h     |   1 +
 arch/sparc/include/asm/tsunami.h      |  65 ---
 arch/sparc/include/asm/turbosparc.h   | 126 -----
 arch/sparc/include/asm/viking.h       | 255 -----------
 arch/sparc/include/asm/winmacro.h     |  11 +-
 arch/sparc/kernel/Makefile            |   8 +-
 arch/sparc/kernel/apc.c               | 196 --------
 arch/sparc/kernel/auxio_32.c          | 139 ------
 arch/sparc/kernel/cpu.c               |   1 -
 arch/sparc/kernel/devices.c           |  10 +-
 arch/sparc/kernel/entry.S             | 413 +----------------
 arch/sparc/kernel/etrap_32.S          |  50 +-
 arch/sparc/kernel/head_32.S           | 255 +----------
 arch/sparc/kernel/ioport.c            |  55 +--
 arch/sparc/kernel/irq.h               |  85 +---
 arch/sparc/kernel/irq_32.c            | 133 +-----
 arch/sparc/kernel/kernel.h            |  53 +--
 arch/sparc/kernel/led.c               | 146 ------
 arch/sparc/kernel/leon_kernel.c       |  53 +--
 arch/sparc/kernel/leon_pmc.c          |  16 +-
 arch/sparc/kernel/leon_smp.c          |   3 -
 arch/sparc/kernel/of_device_32.c      |  18 +-
 arch/sparc/kernel/pcic.c              | 840 ----------------------------------
 arch/sparc/kernel/pmc.c               | 100 ----
 arch/sparc/kernel/process_32.c        |  10 -
 arch/sparc/kernel/rtrap_32.S          |  73 ++-
 arch/sparc/kernel/setup_32.c          | 115 -----
 arch/sparc/kernel/smp_32.c            | 102 +----
 arch/sparc/kernel/sun4d_irq.c         | 519 ---------------------
 arch/sparc/kernel/sun4d_smp.c         | 415 -----------------
 arch/sparc/kernel/sun4m_irq.c         | 478 -------------------
 arch/sparc/kernel/sun4m_smp.c         | 275 -----------
 arch/sparc/kernel/time_32.c           |  68 +--
 arch/sparc/kernel/trampoline_32.S     | 127 +----
 arch/sparc/kernel/ttable_32.S         |   9 +-
 arch/sparc/kernel/vmlinux.lds.S       |   5 -
 arch/sparc/kernel/wof.S               |  61 +--
 arch/sparc/kernel/wuf.S               |  41 +-
 arch/sparc/mm/Makefile                |   4 +-
 arch/sparc/mm/hypersparc.S            | 414 -----------------
 arch/sparc/mm/io-unit.c               | 286 ------------
 arch/sparc/mm/iommu.c                 | 455 ------------------
 arch/sparc/mm/mm_32.h                 |   4 -
 arch/sparc/mm/srmmu.c                 | 836 +--------------------------------
 arch/sparc/mm/srmmu_access.S          |  83 ----
 arch/sparc/mm/swift.S                 | 256 -----------
 arch/sparc/mm/tsunami.S               | 132 ------
 arch/sparc/mm/viking.S                | 284 ------------
 arch/sparc/prom/Makefile              |   1 -
 arch/sparc/prom/init_32.c             |   2 -
 arch/sparc/prom/misc_32.c             |   2 -
 arch/sparc/prom/ranges.c              | 114 -----
 drivers/sbus/char/Kconfig             |   8 -
 drivers/sbus/char/Makefile            |   1 -
 drivers/sbus/char/uctrl.c             | 435 ------------------
 drivers/usb/host/Kconfig              |   2 +-
 drivers/usb/host/ehci-hcd.c           |   4 +-
 drivers/usb/host/uhci-hcd.c           |   2 +-
 drivers/video/fbdev/Kconfig           |  10 +-
 drivers/video/fbdev/Makefile          |   1 -
 drivers/video/fbdev/p9100.c           | 372 ---------------
 sound/sparc/Kconfig                   |   1 +
 88 files changed, 318 insertions(+), 10809 deletions(-)
---
base-commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
change-id: 20231219-sam-sparc32-sunset-v3-4751ea89da2d

Best regards,
-- 
Sam Ravnborg <sam@ravnborg.org>


