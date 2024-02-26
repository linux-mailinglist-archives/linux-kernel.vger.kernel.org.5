Return-Path: <linux-kernel+bounces-81882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CF3867B82
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565791C29208
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF9A12CD8E;
	Mon, 26 Feb 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiZAMuXY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7583D12C7F4;
	Mon, 26 Feb 2024 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964111; cv=none; b=E/Yq6LQ17wd1kPe/YuQaUug64lyw7CPU4vqG9WZ6NaJ2zMkxAZWp8w0gm2m8hhdC8JWFcobWRzUi+f6dFtAPLOsI0EXcHVgm44TTc10M0uw/LRWZOdqAmbROpbLPUr3+78BvfLXDASs6DH93wM1uDHCaILbsZd4n6apS/7QlkE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964111; c=relaxed/simple;
	bh=AO14Twor4Epqfova99BdXRAOjLIWQcQyPi3BUqYZmuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QEcppADMtfH7yYzbceLqJnAJ+ylNLVAYdkMie3GyPvINMkbsu0kIDWZiYRh+zPXWZ7RAkzb5ZLuwHfdOlKs/mW5aSftjjMGpnJ1ttHBPBe3QU3glZzcfLJArmB5tr37PUqwRDcIolhPoZWm7Sd9Kd+K+z9vBdautl5ipE4PLFp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiZAMuXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC888C433B2;
	Mon, 26 Feb 2024 16:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708964110;
	bh=AO14Twor4Epqfova99BdXRAOjLIWQcQyPi3BUqYZmuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZiZAMuXYiDyR2hDknZ4xgVy8TWczoqlYaz+54BPEoKIfJs4BSV182oJ1ZYu9Y5JbD
	 WmVlYt52eCJD6AGhn7U0y3EC75bLKVFGbI7wGmXiVDKgZPTwDaVuTJTSVkJKvUISzS
	 2XRA3a5n6YOmUElWz/EoUJbwtBXGMm0MnBobEcfj+6UoFFgUN+ewdn1/f3BBURGCAf
	 oK4FRWPsN9e+IXZu64v2vjYmcNQRQ8eM254ceqdZ/GIQhQ58ktIQY1PjwK8pNlnHUX
	 azFtrkzqYG46sjmhqFVs4snXAZo3hTMRuuCQkCC5flzHnC0ice4Qu8BYIkByoxWD5F
	 EP1u+qVkKv5IQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Matt Turner <mattst88@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	x86@kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH 4/4] vdso: avoid including asm/page.h
Date: Mon, 26 Feb 2024 17:14:14 +0100
Message-Id: <20240226161414.2316610-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226161414.2316610-1-arnd@kernel.org>
References: <20240226161414.2316610-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The recent change to the vdso_data_store broke building compat VDSO
on at least arm64 because it includes headers outside of the include/vdso/
namespace:

In file included from arch/arm64/include/asm/lse.h:5,
                 from arch/arm64/include/asm/cmpxchg.h:14,
                 from arch/arm64/include/asm/atomic.h:16,
                 from include/linux/atomic.h:7,
                 from include/asm-generic/bitops/atomic.h:5,
                 from arch/arm64/include/asm/bitops.h:25,
                 from include/linux/bitops.h:68,
                 from arch/arm64/include/asm/memory.h:209,
                 from arch/arm64/include/asm/page.h:46,
                 from include/vdso/datapage.h:22,
                 from lib/vdso/gettimeofday.c:5,
                 from <command-line>:
arch/arm64/include/asm/atomic_ll_sc.h:298:9: error: unknown type name 'u128'
  298 |         u128 full;

Use an open-coded page size calculation based on the new CONFIG_PAGE_SHIFT
Kconfig symbol instead.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Fixes: a0d2fcd62ac2 ("vdso/ARM: Make union vdso_data_store available for all architectures")
Link: https://lore.kernel.org/lkml/CA+G9fYtrXXm_KO9fNPz3XaRxHV7UD_yQp-TEuPQrNRHU+_0W_Q@mail.gmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/vdso/datapage.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 7ba44379a095..2c39a67d7e23 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,8 +19,6 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
-#include <asm/page.h>
-
 #ifdef CONFIG_ARCH_HAS_VDSO_DATA
 #include <asm/vdso/data.h>
 #else
@@ -128,7 +126,7 @@ extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden
  */
 union vdso_data_store {
 	struct vdso_data	data[CS_BASES];
-	u8			page[PAGE_SIZE];
+	u8			page[1ul << CONFIG_PAGE_SHIFT];
 };
 
 /*
-- 
2.39.2


