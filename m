Return-Path: <linux-kernel+bounces-20852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D835828641
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE94E28500A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78268381DA;
	Tue,  9 Jan 2024 12:50:08 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8F5364AE;
	Tue,  9 Jan 2024 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4T8VHN1DB7z9v5M;
	Tue,  9 Jan 2024 13:14:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3UZY3QTji_ou; Tue,  9 Jan 2024 13:14:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4T8VHN0Hfvz9v2V;
	Tue,  9 Jan 2024 13:14:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 003308B77D;
	Tue,  9 Jan 2024 13:14:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id HBR04NexVvw3; Tue,  9 Jan 2024 13:14:55 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.126])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6EFF18B774;
	Tue,  9 Jan 2024 13:14:54 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: linux-hardening@vger.kernel.org,
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
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
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
Subject: [PATCH 0/4] Refactor CONFIG_DEBUG_WX and check_wx_pages debugfs attribute
Date: Tue,  9 Jan 2024 13:14:34 +0100
Message-ID: <cover.1704800524.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704802473; l=2144; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=Rosrc8SJ5lP3rVnXrjZMc3fjClOukQO/LV2fzgZVpQs=; b=s3Okt6I7tVLtHH9cIsW0wOp8leAGxF9lRsidic0YqOYcxb/GPUWk/wsLaGOrOrDVlBeQJRl4d A3TZyNi11uFDTOsNtgCv9Dd/0t2LrUpaUdzKjfrAy93UgJ/oTqyg9E5
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

Christophe Leroy (4):
  arm: ptdump: Rename CONFIG_DEBUG_WX to CONFIG_ARM_DEBUG_WX
  arm64, powerpc, riscv, s390, x86: Refactor CONFIG_DEBUG_WX
  powerpc,s390: Define ptdump_check_wx() regardless of CONFIG_DEBUG_WX
  ptdump: add check_wx_pages debugfs attribute

 arch/arm/Kconfig.debug          |  2 +-
 arch/arm/include/asm/ptdump.h   |  6 +++---
 arch/arm64/include/asm/ptdump.h |  7 -------
 arch/arm64/mm/mmu.c             |  2 --
 arch/powerpc/mm/mmu_decl.h      |  6 ------
 arch/powerpc/mm/pgtable_32.c    |  4 ----
 arch/powerpc/mm/pgtable_64.c    |  3 ---
 arch/powerpc/mm/ptdump/ptdump.c | 10 ++++++----
 arch/riscv/include/asm/ptdump.h | 22 ----------------------
 arch/riscv/mm/init.c            |  3 ---
 arch/riscv/mm/ptdump.c          |  1 -
 arch/s390/include/asm/ptdump.h  | 14 --------------
 arch/s390/mm/dump_pagetables.c  |  8 ++------
 arch/s390/mm/init.c             |  2 --
 arch/x86/include/asm/pgtable.h  |  3 +--
 arch/x86/mm/dump_pagetables.c   |  3 +++
 arch/x86/mm/init_32.c           |  2 --
 arch/x86/mm/init_64.c           |  2 --
 include/linux/ptdump.h          |  7 +++++++
 init/main.c                     |  2 ++
 mm/ptdump.c                     | 19 +++++++++++++++++++
 21 files changed, 44 insertions(+), 84 deletions(-)
 delete mode 100644 arch/riscv/include/asm/ptdump.h
 delete mode 100644 arch/s390/include/asm/ptdump.h

-- 
2.41.0


