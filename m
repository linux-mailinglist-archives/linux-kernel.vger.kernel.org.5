Return-Path: <linux-kernel+bounces-167352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123288BA85E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22AECB22192
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B472F148840;
	Fri,  3 May 2024 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnwD0kkL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA31D219EB;
	Fri,  3 May 2024 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723926; cv=none; b=AlD0lEjoxcvH/klRdfT0Eo24tBnnPa5N5CdBHGgROBJkAM8135Wm1VJ5F5n4BZbBg7patGTh1fnX0N/pT08jgn1sgCIFrKUfUe/L7o4Qcb6jrgZjTkQltjuXGndeXsTW4waH8rHY3y4ZkOLfcbOJldOdwMgwYScL94YNpo6Mqlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723926; c=relaxed/simple;
	bh=kfgjwj2N0kfhguWzN5AvIcmR11gWBtySO+0DLdeui+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kV0LzQjzkRpMUHaehsOKrb6+IDUu+9Y+vPT8Hfp62jXZrg/3AaBIOJ16dCqDnkJGnXlVnRIdtyTnd5wsO91OkRSKeFaRWVtMvFV0Z/WizI3XreDIcM0ExxYtIK1UQiD/vxfHq9jFk286YPkkA0RAH5XuuYC5e5kj6mrSPuoNe6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnwD0kkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256ACC32789;
	Fri,  3 May 2024 08:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714723926;
	bh=kfgjwj2N0kfhguWzN5AvIcmR11gWBtySO+0DLdeui+0=;
	h=From:To:Cc:Subject:Date:From;
	b=dnwD0kkLrvjpyFVRcXSEa4Yv+8HD4+Gpu/hw8iCXppDdjnBWtkycN/RNJfWHHCS0j
	 bOHgk/TB28TTz6XfZu7sgFXYZ6Uc5sooL3KlR6g1xDdqEhaLDOlTKz3eHLRgLgnYWt
	 p94Vn5XB8CgjVeYAsacv8M8Xk291gy7iLah0LqYVPtcVCNCVS44izQ4Og9famptmAF
	 G0vsObcz5mtGH7aoOuDiOUnDsz62lqtIgBwS1zllSEV3pWlyJE2hMcWlDzVyuEAIiZ
	 PtezHf86GHrzx+hlsjCz/XbYkSSdw0rBs+0PigGxms8cB3tSXjbXfOyI+nBX0H7AkR
	 QtnOHScj7g37Q==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-alpha@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] alpha: cleanups for 6.10
Date: Fri,  3 May 2024 10:11:11 +0200
Message-Id: <20240503081125.67990-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

I had investigated dropping support for alpha EV5 and earlier a while
ago after noticing that this is the only supported CPU family
in the kernel without native byte access and that Debian has already
dropped support for this generation last year [1] after it turned
out to be broken.

This topic came up again when Paul E. McKenney noticed that
parts of the RCU code already rely on byte access and do not
work on alpha EV5 reliably, so I refreshed my series now for
inclusion into the next merge window.

Al Viro did another series for alpha to address all the known build
issues. I rebased his patches without any further changes and included
it as a baseline for my work here to avoid conflicts.

      Arnd

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1036158
[2] https://lore.kernel.org/lkml/b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop/

Al Viro (9):
  alpha: sort scr_mem{cpy,move}w() out
  alpha: fix modversions for strcpy() et.al.
  alpha: add clone3() support
  alpha: don't make functions public without a reason
  alpha: sys_sio: fix misspelled ifdefs
  alpha: missing includes
  alpha: core_lca: take the unused functions out
  alpha: jensen, t2 - make __EXTERN_INLINE same as for the rest
  alpha: trim the unused stuff from asm-offsets.c

Arnd Bergmann (5):
  alpha: remove DECpc AXP150 (Jensen) support
  alpha: sable: remove early machine support
  alpha: remove LCA and APECS based machines
  alpha: cabriolet: remove EV5 CPU support
  alpha: drop pre-EV56 support

 Documentation/driver-api/eisa.rst      |   4 +-
 arch/alpha/Kconfig                     | 175 +-------
 arch/alpha/Makefile                    |   8 +-
 arch/alpha/include/asm/core_apecs.h    | 534 -------------------------
 arch/alpha/include/asm/core_lca.h      | 378 -----------------
 arch/alpha/include/asm/core_t2.h       |   8 -
 arch/alpha/include/asm/dma-mapping.h   |   4 -
 arch/alpha/include/asm/dma.h           |   9 +-
 arch/alpha/include/asm/elf.h           |   4 +-
 arch/alpha/include/asm/io.h            |  26 +-
 arch/alpha/include/asm/irq.h           |  10 +-
 arch/alpha/include/asm/jensen.h        | 363 -----------------
 arch/alpha/include/asm/machvec.h       |   9 -
 arch/alpha/include/asm/mmu_context.h   |  45 +--
 arch/alpha/include/asm/special_insns.h |   5 +-
 arch/alpha/include/asm/tlbflush.h      |  41 +-
 arch/alpha/include/asm/uaccess.h       |  80 ----
 arch/alpha/include/asm/vga.h           |   2 +
 arch/alpha/include/uapi/asm/compiler.h |  18 -
 arch/alpha/kernel/Makefile             |  25 +-
 arch/alpha/kernel/asm-offsets.c        |  21 +-
 arch/alpha/kernel/bugs.c               |   1 +
 arch/alpha/kernel/console.c            |   1 +
 arch/alpha/kernel/core_apecs.c         | 420 -------------------
 arch/alpha/kernel/core_cia.c           |   6 +-
 arch/alpha/kernel/core_irongate.c      |   1 -
 arch/alpha/kernel/core_lca.c           | 517 ------------------------
 arch/alpha/kernel/core_marvel.c        |   2 +-
 arch/alpha/kernel/core_t2.c            |   2 +-
 arch/alpha/kernel/core_wildfire.c      |   8 +-
 arch/alpha/kernel/entry.S              |   1 +
 arch/alpha/kernel/io.c                 |  19 +
 arch/alpha/kernel/irq.c                |   1 +
 arch/alpha/kernel/irq_i8259.c          |   4 -
 arch/alpha/kernel/machvec_impl.h       |  25 +-
 arch/alpha/kernel/pci-noop.c           | 113 ------
 arch/alpha/kernel/pci_impl.h           |   4 +-
 arch/alpha/kernel/perf_event.c         |   2 +-
 arch/alpha/kernel/proto.h              |  44 +-
 arch/alpha/kernel/setup.c              | 109 +----
 arch/alpha/kernel/smc37c669.c          |   6 +-
 arch/alpha/kernel/smc37c93x.c          |   2 +
 arch/alpha/kernel/smp.c                |   1 +
 arch/alpha/kernel/srmcons.c            |   2 +
 arch/alpha/kernel/sys_cabriolet.c      |  87 +---
 arch/alpha/kernel/sys_eb64p.c          | 238 -----------
 arch/alpha/kernel/sys_jensen.c         | 237 -----------
 arch/alpha/kernel/sys_mikasa.c         |  57 ---
 arch/alpha/kernel/sys_nautilus.c       |   8 +-
 arch/alpha/kernel/sys_noritake.c       |  60 ---
 arch/alpha/kernel/sys_sable.c          | 294 +-------------
 arch/alpha/kernel/sys_sio.c            | 486 ----------------------
 arch/alpha/kernel/syscalls/syscall.tbl |   2 +-
 arch/alpha/kernel/traps.c              |  64 ---
 arch/alpha/lib/Makefile                |  14 -
 arch/alpha/lib/checksum.c              |   1 +
 arch/alpha/lib/fpreg.c                 |   1 +
 arch/alpha/lib/memcpy.c                |   3 +
 arch/alpha/lib/stycpy.S                |  11 +
 arch/alpha/lib/styncpy.S               |  11 +
 arch/alpha/math-emu/math.c             |   7 +-
 arch/alpha/mm/init.c                   |   2 +-
 drivers/char/agp/alpha-agp.c           |   2 +-
 drivers/eisa/Kconfig                   |   9 +-
 drivers/eisa/virtual_root.c            |   2 +-
 drivers/input/serio/i8042-io.h         |   5 +-
 drivers/tty/serial/8250/8250.h         |   3 -
 drivers/tty/serial/8250/8250_alpha.c   |  21 -
 drivers/tty/serial/8250/8250_core.c    |   4 -
 drivers/tty/serial/8250/Makefile       |   2 -
 include/linux/blk_types.h              |   6 -
 include/linux/tty.h                    |  14 +-
 72 files changed, 166 insertions(+), 4545 deletions(-)
 delete mode 100644 arch/alpha/include/asm/core_apecs.h
 delete mode 100644 arch/alpha/include/asm/core_lca.h
 delete mode 100644 arch/alpha/include/asm/jensen.h
 delete mode 100644 arch/alpha/kernel/core_apecs.c
 delete mode 100644 arch/alpha/kernel/core_lca.c
 delete mode 100644 arch/alpha/kernel/pci-noop.c
 delete mode 100644 arch/alpha/kernel/sys_eb64p.c
 delete mode 100644 arch/alpha/kernel/sys_jensen.c
 delete mode 100644 arch/alpha/kernel/sys_sio.c
 create mode 100644 arch/alpha/lib/stycpy.S
 create mode 100644 arch/alpha/lib/styncpy.S
 delete mode 100644 drivers/tty/serial/8250/8250_alpha.c

-- 
2.39.2

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

