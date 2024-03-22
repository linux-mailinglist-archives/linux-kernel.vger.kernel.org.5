Return-Path: <linux-kernel+bounces-111463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0730F886CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D991F22D77
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4854945BF3;
	Fri, 22 Mar 2024 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qq3mjn6v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C91D44C89
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113653; cv=none; b=UkHF97Ki1Lo3qv0ZGmXw3HY6h8dnJVFPHc3aNP7F5d3g6DJ8HaR3EClLt6AoE+p374RyJHnJgcQOjK1tSN2tghdBGjj5C3a/VxdMHBz0rp4894e8LKfSAdr6QwSJSFdKHLpfGV7v0QBtpxYueKhXV9bLRgFgbY1eZ0bl22AIKGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113653; c=relaxed/simple;
	bh=dhmhIvje5pxo5icHU70XN8P5F1o5mH5/DMloOr13o3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QEz+REk7QJLB9FqAxj7gCtP2HiL5DBjHFvzpbEaEq7yL6LVIZbI1K7ACX/Kg6qSd3vU48F7j82bIKn7+guAE8xxBDvFe1N78lsL9EhHHTz9UsdmofnhEP6CK7CuwvCWkX7ijLF94Y6AyfATReeb+Du+4d96WB1mQHhNMyCp7x18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qq3mjn6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9C2C433F1;
	Fri, 22 Mar 2024 13:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711113653;
	bh=dhmhIvje5pxo5icHU70XN8P5F1o5mH5/DMloOr13o3A=;
	h=From:To:Cc:Subject:Date:From;
	b=Qq3mjn6vj8RZWJYxfxxnpEvc+V64Pv2z1S7DaLBh2S95ywbixFJKMZi8eUqot7ise
	 akn8sLWuI5u/riMOd2j+hmDYdSugsywayXQN11pf4YjegBDE13Ks7C4opHlJJ94sii
	 kZ3dkDCjKBjvD7NLkxyQDzgFwccG8nAZA7fP/0pTskSed9Qrta3KrSbBSEFEHuTULt
	 QWE+KhCk8vm0FCAv3F+uOqGGGcYfPuaQ9SazmOsz2PSiaweG/8xDi1FsvKtQOACjMv
	 LIbGu8bgispM5m3wDkjOoZkZqERgKBkzjYZ2oC2voGB2RrdSIXbT19JbGnZwkngC6N
	 JZvH0sfHImUrw==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] irqflags: explicitly ignore lockdep_hrtimer_exit() argument
Date: Fri, 22 Mar 2024 14:20:41 +0100
Message-Id: <20240322132048.906325-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When building with 'make W=1' but CONFIG_TRACE_IRQFLAGS=n, the
unused argument to lockdep_hrtimer_exit() causes a warning:

kernel/time/hrtimer.c:1655:14: error: variable 'expires_in_hardirq' set but not used [-Werror=unused-but-set-variable]

This is intentional behavior, so add a cast to void to shut up the warning.

Fixes: 73d20564e0dc ("hrtimer: Don't dereference the hrtimer pointer after the callback")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/irqflags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 147feebd508c..3f003d5fde53 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -114,7 +114,7 @@ do {						\
 # define lockdep_softirq_enter()		do { } while (0)
 # define lockdep_softirq_exit()			do { } while (0)
 # define lockdep_hrtimer_enter(__hrtimer)	false
-# define lockdep_hrtimer_exit(__context)	do { } while (0)
+# define lockdep_hrtimer_exit(__context)	do { (void)(__context); } while (0)
 # define lockdep_posixtimer_enter()		do { } while (0)
 # define lockdep_posixtimer_exit()		do { } while (0)
 # define lockdep_irq_work_enter(__work)		do { } while (0)
-- 
2.39.2


