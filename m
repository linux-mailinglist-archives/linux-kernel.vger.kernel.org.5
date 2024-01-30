Return-Path: <linux-kernel+bounces-44391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A279484216F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5121F24782
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD12664AD;
	Tue, 30 Jan 2024 10:36:37 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19E4360AE;
	Tue, 30 Jan 2024 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610997; cv=none; b=dv0MOWs94PqDC8fl4oDUgZ5QVWXHbRAP3fSopm9Jn62n9Y34MAtx0rYHNVubgJUHeBuYJiENiITozCdGMkEXVO6VRhTCqJ/OhG/Ec0DfP/xvLFJ95ylfic+TDVzb6s62eJeC4ouWKFiXEYEKDHt03/KXg4dZ/9d47TrcpoZ7DxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610997; c=relaxed/simple;
	bh=GLnDgyafe3Abwdfr1jBJzmg1hyqpqoPnd3cHPH0oxrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lchc+oBzqIpFvulxq6KKZwvsa4HWzW0SIPOtI3nKWM8XmVpkfiDwSn+IjV92EQm3sq5Lb9Yf2rar+TUpWurN2nvDmLgrc6Slb7cK/Wl5XtVZKFkyHfFsAZaj0JAo/o6avbLSRapM2JItx6TLL9hrACW2T9AL1wYgWxeYomDU8vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4TPM625ppBz9sB6;
	Tue, 30 Jan 2024 11:36:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ws_uhNN709Je; Tue, 30 Jan 2024 11:36:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4TPM4R4bMWz9vDl;
	Tue, 30 Jan 2024 11:35:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 93C778B76E;
	Tue, 30 Jan 2024 11:35:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 5Vre96fi8PyS; Tue, 30 Jan 2024 11:35:03 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.134])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D09B58B763;
	Tue, 30 Jan 2024 11:35:01 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-mm@kvack.org,
	steven.price@arm.com,
	Phong Tran <tranmanphong@gmail.com>,
	mark.rutland@arm.com,
	Greg KH <greg@kroah.com>
Subject: [PATCH v2 0/5] mm: ptdump: Refactor CONFIG_DEBUG_WX and check_wx_pages debugfs attribute
Date: Tue, 30 Jan 2024 11:34:31 +0100
Message-ID: <cover.1706610398.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706610876; l=2737; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=GLnDgyafe3Abwdfr1jBJzmg1hyqpqoPnd3cHPH0oxrY=; b=tIZe4XZQjVwWyWqJ6WaH1FMomnKnFXJjNxF+XKnvH0G3eYwBTTFLAyHmPCAqyI2HJixgHIMEp +ciHrtrDDPHBl9BQwIT71a8HT+O9hvNWFDyEfO0KDZbwbPjdDLV5qLD
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Refer old discussion at https://lore.kernel.org/lkml/20200422152656.GF676@willie-the-truck/T/#m802eaf33efd6f8d575939d157301b35ac0d4a64f
And https://github.com/KSPP/linux/issues/35

This series refactors CONFIG_DEBUG_WX for the 5 architectures
implementing CONFIG_GENERIC_PTDUMP

First rename stuff in ARM which uses similar names while not
implementing CONFIG_GENERIC_PTDUMP.

Then define a generic version of debug_checkwx() that calls
ptdump_check_wx() when CONFIG_DEBUG_WX is set. Call it immediately
after calling mark_rodata_ro() instead of calling it at the end of
every mark_rodata_ro().

Then implement a debugfs attribute that can be used to trigger
a W^X test at anytime and regardless of CONFIG_DEBUG_WX

Changes in v2:
- Fixed a few build failures (patch 1 and 2)
- Added patch 4
- Make the attribute return SUCCESS/FAILURE as suggested by Heiko (patch 5)

Christophe Leroy (5):
  arm: ptdump: Rename CONFIG_DEBUG_WX to CONFIG_ARM_DEBUG_WX
  arm64, powerpc, riscv, s390, x86: ptdump: Refactor CONFIG_DEBUG_WX
  powerpc,s390: ptdump: Define ptdump_check_wx() regardless of
    CONFIG_DEBUG_WX
  mm: ptdump: Have ptdump_check_wx() return bool
  mm: ptdump: add check_wx_pages debugfs attribute

 arch/arm/Kconfig.debug               |  2 +-
 arch/arm/configs/aspeed_g4_defconfig |  2 +-
 arch/arm/configs/aspeed_g5_defconfig |  2 +-
 arch/arm/include/asm/ptdump.h        |  6 +++---
 arch/arm/mm/init.c                   |  2 +-
 arch/arm64/include/asm/ptdump.h      |  7 -------
 arch/arm64/mm/mmu.c                  |  2 --
 arch/arm64/mm/ptdump.c               | 11 ++++++++---
 arch/powerpc/mm/mmu_decl.h           |  6 ------
 arch/powerpc/mm/pgtable_32.c         |  4 ----
 arch/powerpc/mm/pgtable_64.c         |  3 ---
 arch/powerpc/mm/ptdump/ptdump.c      | 21 ++++++++++++++-------
 arch/riscv/include/asm/ptdump.h      | 22 ----------------------
 arch/riscv/mm/init.c                 |  3 ---
 arch/riscv/mm/ptdump.c               | 12 ++++++++----
 arch/s390/include/asm/ptdump.h       | 14 --------------
 arch/s390/mm/dump_pagetables.c       | 21 +++++++++++----------
 arch/s390/mm/init.c                  |  2 --
 arch/x86/include/asm/pgtable.h       |  5 ++---
 arch/x86/mm/dump_pagetables.c        | 20 ++++++++++++++------
 arch/x86/mm/init_32.c                |  2 --
 arch/x86/mm/init_64.c                |  2 --
 include/linux/ptdump.h               |  7 +++++++
 init/main.c                          |  2 ++
 mm/ptdump.c                          | 22 ++++++++++++++++++++++
 25 files changed, 95 insertions(+), 107 deletions(-)
 delete mode 100644 arch/riscv/include/asm/ptdump.h
 delete mode 100644 arch/s390/include/asm/ptdump.h

-- 
2.43.0


