Return-Path: <linux-kernel+bounces-127095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7088946A4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686821C218BF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3833856B73;
	Mon,  1 Apr 2024 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smYGcuS9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7458955E6A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712007595; cv=none; b=CYGKy9BbbdI0tSqkf/n29zFahdKOvfT3CMZ2YrHSFOa6A91PxmLeB2XcbsNsLgQjpcbfFCF9l/nksU8XQgvSWHen41KKd7GFsRRYAyO+MmKFryv9Q2vfgxNKI/jL5ApfwRBI6/UwIc5G1eIKF/GXrTCdBpzrC8IHPehXgspV5Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712007595; c=relaxed/simple;
	bh=aFyRkJsj1cSeFgIbVoEnc7fhPQM9ciACtkQV40joVhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N+IdY+B4H31X3gQ5SNBP7ihqX2gZDB9bqnW2dgaQIznI2dJP11nlQjhB1WITRN2e2cgRUixFgSbbApIVPbuFAmfLyx0HXPU1LCgGgGMGmcFIhSihA7jaB/c7gZfEkyCvkZ3HNWHOLNtDnOXsKYcTnwS+eBnvk2aiHd0JJmC3Ikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smYGcuS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD85C43390;
	Mon,  1 Apr 2024 21:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712007595;
	bh=aFyRkJsj1cSeFgIbVoEnc7fhPQM9ciACtkQV40joVhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smYGcuS9pi8XHbtH4nZHtbho9hbNdPpGE1mOA7kUMwobaW0uM++mcAGgm+P/usgkq
	 a788LGBT+7a195WexMII81p/90C/oN2aYkzjedHdB6BKlYem2KnhOrqa6m3k687ahY
	 jlRCnVOfIcFFuUeMc4xjXBit6+AAauyZ9sPi5wypxV0yj6iJajuQfgOsPILUyTX2uL
	 +DXlCVlWCdRdkTosHxT0n/N46f/HIuk2s0OxtbI538hMAKP2rk9ZAqc+5GrAjK7uAC
	 oNB/79nOUn9igu7YnO8HsrGWyHLPwPOYbl1BT7bXJY0+iS5LovRLDUE2V3FatZuQ4G
	 C4FjgEZ9Yaanw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BD290CE0738; Mon,  1 Apr 2024 14:39:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: [PATCH RFC cmpxchg 2/8] sparc: Emulate one-byte and two-byte cmpxchg
Date: Mon,  1 Apr 2024 14:39:44 -0700
Message-Id: <20240401213950.3910531-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new cmpxchg_emu_u8() and cmpxchg_emu_u16() to emulate one-byte
and two-byte cmpxchg() on 32-bit sparc.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Marco Elver <elver@google.com>
---
 arch/sparc/Kconfig                  | 1 +
 arch/sparc/include/asm/cmpxchg_32.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 11bf9d312318c..e6d1bbc4fedd0 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -55,6 +55,7 @@ config SPARC32
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_CPU_FINALIZE_INIT if !SMP
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_NEED_CMPXCHG_1_2_EMU
 	select CLZ_TAB
 	select DMA_DIRECT_REMAP
 	select GENERIC_ATOMIC64
diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index d0af82c240b73..8eb483b5887a1 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -41,11 +41,17 @@ void __cmpxchg_called_with_bad_pointer(void);
 /* we only need to support cmpxchg of a u32 on sparc */
 unsigned long __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
 
+#include <linux/cmpxchg-emu.h>
+
 /* don't worry...optimizer will get rid of most of this */
 static inline unsigned long
 __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 {
 	switch (size) {
+	case 1:
+		return cmpxchg_emu_u8((volatile u8 *)ptr, old, new_);
+	case 2:
+		return cmpxchg_emu_u16((volatile u16 *)ptr, old, new_);
 	case 4:
 		return __cmpxchg_u32((u32 *)ptr, (u32)old, (u32)new_);
 	default:
-- 
2.40.1


