Return-Path: <linux-kernel+bounces-127098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AF98946A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB62282CEB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DF956B85;
	Mon,  1 Apr 2024 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUqSi9ov"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A644356457
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712007595; cv=none; b=VG9Mj19CZHQVEKEMGi21DPhg31ROfCrsVmsM0kGXL6M4WUhjDdmAE24Cbk0fw2J0WzYCOzWAExO7P6+6+iEW04hAnY0SkbWtNGJHVZxDLfK5JyHIzmN1v+7S+tpTGAEe6fc77ui4FOSw5i/1sCfHTgV9rT7+zfP8iVv5HhbxRlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712007595; c=relaxed/simple;
	bh=u5tsJRw/9iU5lxcxjKgSAWhkCKXYpp5m/rW4WPetzII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S1PRZ+hhJzI8gj8vN+TdnBIyZW6JcysNxbPVD3YEdc0nrjHeC0fy9iLkVqhnrnbl4RvCxEeXCmMUS2tts4i1ytzgAZFLPNtZjXlkgMVR0TY6gVC5zHjAaWEl3dkRvabYUFPSaNWg/uoKgqhx7YT50zVSkCCpUXxnX5lasqR4AHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUqSi9ov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EBDC4166A;
	Mon,  1 Apr 2024 21:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712007595;
	bh=u5tsJRw/9iU5lxcxjKgSAWhkCKXYpp5m/rW4WPetzII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GUqSi9ovGCLT3X5cFF43lGOqAMk5rGSvqS7ktl/RUY0aGffLc3YH44JviREseSD23
	 MPUwQkrG3/WBCGGpeHIB2j4jTtAIocYhUgvzAPBPwYUnY6wM0q32zbtYbpCeL+bKQH
	 Uy0HNXjb1U9ojXsSG8kZinow512/aaek7StZ85+vZA7l3bRJMRg201jHMrzWDZOL2o
	 wndVDOpebwh7SUcxByrv09p1oO4JNAdwUDE0pamN+OZf9EI4W8oBrw8S+16toQ+GKF
	 VZkZbMu+vhZ0xwWeOQVFYgZRwDY/6xbMjautEgB1jKi8aEx2brYU7oBMXRh9+USI+e
	 7sAlh1U47z2+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C7F9ACE0EE1; Mon,  1 Apr 2024 14:39:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH RFC cmpxchg 6/8] xtensa: Emulate one-byte and two-byte cmpxchg
Date: Mon,  1 Apr 2024 14:39:48 -0700
Message-Id: <20240401213950.3910531-6-paulmck@kernel.org>
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
and two-byte cmpxchg() on xtensa.

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
---
 arch/xtensa/Kconfig               | 1 +
 arch/xtensa/include/asm/cmpxchg.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index f200a4ec044e6..8131f0d75bb58 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -14,6 +14,7 @@ config XTENSA
 	select ARCH_HAS_DMA_SET_UNCACHED if MMU
 	select ARCH_HAS_STRNCPY_FROM_USER if !KASAN
 	select ARCH_HAS_STRNLEN_USER
+	select ARCH_NEED_CMPXCHG_1_2_EMU
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index 675a11ea8de76..a0f9a2070209b 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -15,6 +15,7 @@
 
 #include <linux/bits.h>
 #include <linux/stringify.h>
+#include <linux/cmpxchg-emu.h>
 
 /*
  * cmpxchg
@@ -74,6 +75,8 @@ static __inline__ unsigned long
 __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 {
 	switch (size) {
+	case 1:  return cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
+	case 2:  return cmpxchg_emu_u16((volatile u16 *)ptr, old, new);
 	case 4:  return __cmpxchg_u32(ptr, old, new);
 	default: __cmpxchg_called_with_bad_pointer();
 		 return old;
-- 
2.40.1


