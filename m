Return-Path: <linux-kernel+bounces-127096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A5D8946A6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662A9B22EB4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3804456B70;
	Mon,  1 Apr 2024 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALYUYhl+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B955E72;
	Mon,  1 Apr 2024 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712007595; cv=none; b=ungtlxZyvHacu++csu1pdGWk/Z8WfbJG4isW1LYDkBGvYgbVN3WYL4SSnVJhn2YqpnVRocpBwCnTixmvVKKY6+xh9BOSgC1HJV9Y1vah8cW7x4O1wtktkKzdan3BFeXevtKyVjiViBAWpOSEoOfktSa6+W6URgl0K4ucSNIlVBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712007595; c=relaxed/simple;
	bh=ZGz86/tSVAGS9mMQah03h/TzE5FSFLZz3YJL1al/ZP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WhgMA4EWJvtTfFi7h3ayCFykUPbIMaVASAuuNdU9/+kqmM2IxZJ2aQN77yDq369S14HA2EU3IBcU2m81z5ZIFj9xUZ6U1+HAAYqlmYF6/xisRjztYIJag5FN2YJ8FI5WiKR9xSf3hwy/yPI/NfR4QvlJkENrEbEbLTf5hiDYWE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALYUYhl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2699BC433C7;
	Mon,  1 Apr 2024 21:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712007595;
	bh=ZGz86/tSVAGS9mMQah03h/TzE5FSFLZz3YJL1al/ZP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ALYUYhl+t4DM33sILtMlLhGEKvST/UP5cm8J0LAwDf9/Bkm6xQWIE8iwoktinrOLb
	 iOY4BQXBBAc7rw68xS39P9s0VZqb1gn6Sbt/cle5KzcIslH938LBjGiI5gudH6VeqN
	 OozUjpH+jmiWYx3FRtKGYZhB46AAIsK+K29ePAFrWWpX9ACBCXRHUfDnXbxL60+1re
	 b6S0LI3KQDxmRqJFxFvQiFZvUcUEcRiHAGK8OcUeQSJ85joaso9fT5ZfBMhgI9mz84
	 R5kXXKaBktQmgMebBiD6EXkWq7rsNfl5TpPg6wqVywJLZA13bEwkRhwX0xKNm8P9mV
	 Cej7pK0/yQ74g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C2BACCE0B64; Mon,  1 Apr 2024 14:39:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org
Subject: [PATCH RFC cmpxchg 4/8] csky: Emulate one-byte and two-byte cmpxchg
Date: Mon,  1 Apr 2024 14:39:46 -0700
Message-Id: <20240401213950.3910531-4-paulmck@kernel.org>
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
and two-byte cmpxchg() on csky.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: <linux-csky@vger.kernel.org>
---
 arch/csky/Kconfig               |  1 +
 arch/csky/include/asm/cmpxchg.h | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index d3ac36751ad1f..860d4e02d6295 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -37,6 +37,7 @@ config CSKY
 	select ARCH_INLINE_SPIN_UNLOCK_BH if !PREEMPTION
 	select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPTION
 	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
+	select ARCH_NEED_CMPXCHG_1_2_EMU
 	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610 && $(cc-option,-mbacktrace)
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select COMMON_CLK
diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
index 916043b845f14..848a8691c5a2a 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -61,6 +61,12 @@
 	__typeof__(old) __old = (old);				\
 	__typeof__(*(ptr)) __ret;				\
 	switch (size) {						\
+	case 1:							\
+		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
+		break;						\
+	case 2:							\
+		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
+		break;						\
 	case 4:							\
 		asm volatile (					\
 		"1:	ldex.w		%0, (%3) \n"		\
@@ -91,6 +97,12 @@
 	__typeof__(old) __old = (old);				\
 	__typeof__(*(ptr)) __ret;				\
 	switch (size) {						\
+	case 1:							\
+		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
+		break;						\
+	case 2:							\
+		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
+		break;						\
 	case 4:							\
 		asm volatile (					\
 		"1:	ldex.w		%0, (%3) \n"		\
@@ -122,6 +134,12 @@
 	__typeof__(old) __old = (old);				\
 	__typeof__(*(ptr)) __ret;				\
 	switch (size) {						\
+	case 1:							\
+		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
+		break;						\
+	case 2:							\
+		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
+		break;						\
 	case 4:							\
 		asm volatile (					\
 		RELEASE_FENCE					\
-- 
2.40.1


