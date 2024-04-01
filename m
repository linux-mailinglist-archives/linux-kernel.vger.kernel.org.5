Return-Path: <linux-kernel+bounces-127093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82DE8946A3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93651282CAA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B23A56B64;
	Mon,  1 Apr 2024 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMIuRxBF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536FD55C3B;
	Mon,  1 Apr 2024 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712007595; cv=none; b=D+WE98tjQrWbqWlfnP7aVw/g7cv7BY6x6ouiyKMSUTgMA0tezb1xAVAtZaIC2mblKd2YEMbBjFZEkqMwIWdpZT01UoTpuMkau6ff9mvr4MhHppyYEEXlMZ2rDoXkZkNUqnL13rLluT3IMVQkStRONM0LCXR5HyDRh39Q3cD+Nw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712007595; c=relaxed/simple;
	bh=tz6SD2Mww8E4+R0q2v0WTL1Y7yCpZZWUXYJiKBI2ETk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m3HKvSzQV0ZdZZ7r57AjbdcOp3OTf+CcFcEuNg1GQoANi1hqGcYBBQuyPBTJwJFDjJDI0RQN9jCTrfxVNIF1HELi7uG3JWQUhqDhaoX1QeE+Py/lhDfgZCD6fw/HgTF920LktXH90qsV+66FND2N7B9AQWF8PMVTSs+rFTeMqnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMIuRxBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33564C433B2;
	Mon,  1 Apr 2024 21:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712007595;
	bh=tz6SD2Mww8E4+R0q2v0WTL1Y7yCpZZWUXYJiKBI2ETk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WMIuRxBFlQY2FUMDKIZBJYahDw6AsGLigwwGSJoFHI3fcSx1OXczvoC8b+Cbkx09r
	 5nr6nq0QPHlGh6eBkUbqT7dHd4Gb80oz0O7UYpF8mIOT0LNdJF3jsFll8yzEGDzwLT
	 X2bh3/ECmqLUWCHpXsM7bNsnmqH8Le4Z2dHITr7Mo6C+Q38O/Uj7Jw0nkDOodAFq7S
	 3JOW9fzL8+U8BEqjPb1dGmGZop+e620ZB75mpuI/4A4LT9Xh3aGnxkjj8iLzHdFfXm
	 tw9aB5Ob5VUIcBGkhOPBvo9fwrWulYN4suPZYqRMbz/wGRYyIsEWcyv5xFoeti3D46
	 WaR+F3MG11fiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C573DCE0D0C; Mon,  1 Apr 2024 14:39:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-sh@vger.kernel.org
Subject: [PATCH RFC cmpxchg 5/8] sh: Emulate one-byte and two-byte cmpxchg
Date: Mon,  1 Apr 2024 14:39:47 -0700
Message-Id: <20240401213950.3910531-5-paulmck@kernel.org>
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
and two-byte cmpxchg() on sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: <linux-sh@vger.kernel.org>
---
 arch/sh/Kconfig               | 1 +
 arch/sh/include/asm/cmpxchg.h | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 2ad3e29f0ebec..43a121c6ca0f3 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -16,6 +16,7 @@ config SUPERH
 	select ARCH_HIBERNATION_POSSIBLE if MMU
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
+	select ARCH_NEED_CMPXCHG_1_2_EMU
 	select CPU_NO_EFFICIENT_FFS
 	select DMA_DECLARE_COHERENT
 	select GENERIC_ATOMIC64
diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index 5d617b3ef78f7..18233cc14419e 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -56,6 +56,10 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
 		unsigned long new, int size)
 {
 	switch (size) {
+	case 1:
+		return cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
+	case 2:
+		return cmpxchg_emu_u16((volatile u16 *)ptr, old, new);
 	case 4:
 		return __cmpxchg_u32(ptr, old, new);
 	}
-- 
2.40.1


