Return-Path: <linux-kernel+bounces-127377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9BD894A75
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0744B22D83
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1CE224EE;
	Tue,  2 Apr 2024 04:27:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E7522313
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 04:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712032034; cv=none; b=o0r91r10w0F88K1l3ZRAnOgo+XpK6YRVg9daouqbnsLtOAxpHfXPVbGQn2eI89BywEwWi7ipXEu4xPX7xNn41jUc4mJDac4R7kd/KIzitEfZZQhgy0035Ei+9W+QukJ6lL1iyKqcFO9St8bgdQYailQaeix8q6yWISNjOHIXKSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712032034; c=relaxed/simple;
	bh=1MizhstMEeC0AVY1oEJM1Q9Lsl46flUajVFqAXBsSt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IDkJuFWq/ag/WRNCWL94IPHyZNjZtiOZwY5lL4INop9xYu8OdINq8iJbNnv6xI3gHsH+4svbUXpWoUH7T5WnEdjtKAkpYvcuxNYdwN8B9ELVoCPqbXaDq0L2HJI8o+d3jkm/5kVwGpYBmgmrL9V1kFHyD6ukLuU33bNzovmkomA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AB4C433F1;
	Tue,  2 Apr 2024 04:27:13 +0000 (UTC)
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: [PATCH 6/8] parisc: unify implementations of __cmpxchg_u{8,32,64}
Date: Tue,  2 Apr 2024 00:28:33 -0400
Message-Id: <20240402042835.11815-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402042835.11815-1-viro@zeniv.linux.org.uk>
References: <20240402041138.GF538574@ZenIV>
 <20240402042835.11815-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

identical except for type name involved

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/parisc/lib/bitops.c | 51 +++++++++++++---------------------------
 1 file changed, 16 insertions(+), 35 deletions(-)

diff --git a/arch/parisc/lib/bitops.c b/arch/parisc/lib/bitops.c
index ae2231d92198..cae30a3eb6d9 100644
--- a/arch/parisc/lib/bitops.c
+++ b/arch/parisc/lib/bitops.c
@@ -56,38 +56,19 @@ unsigned long notrace __xchg8(char x, volatile char *ptr)
 }
 
 
-u64 notrace __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new)
-{
-	unsigned long flags;
-	u64 prev;
-
-	_atomic_spin_lock_irqsave(ptr, flags);
-	if ((prev = *ptr) == old)
-		*ptr = new;
-	_atomic_spin_unlock_irqrestore(ptr, flags);
-	return prev;
-}
-
-u32 notrace __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
-{
-	unsigned long flags;
-	u32 prev;
-
-	_atomic_spin_lock_irqsave(ptr, flags);
-	if ((prev = *ptr) == old)
-		*ptr = new;
-	_atomic_spin_unlock_irqrestore(ptr, flags);
-	return prev;
-}
-
-u8 notrace __cmpxchg_u8(volatile u8 *ptr, u8 old, u8 new)
-{
-	unsigned long flags;
-	u8 prev;
-
-	_atomic_spin_lock_irqsave(ptr, flags);
-	if ((prev = *ptr) == old)
-		*ptr = new;
-	_atomic_spin_unlock_irqrestore(ptr, flags);
-	return prev;
-}
+#define CMPXCHG(T)						\
+	T notrace __cmpxchg_##T(volatile T *ptr, T old, T new)	\
+	{							\
+		unsigned long flags;				\
+		T prev;						\
+								\
+		_atomic_spin_lock_irqsave(ptr, flags);		\
+		if ((prev = *ptr) == old)			\
+			*ptr = new;				\
+		_atomic_spin_unlock_irqrestore(ptr, flags);	\
+		return prev;					\
+	}
+
+CMPXCHG(u64)
+CMPXCHG(u32)
+CMPXCHG(u8)
-- 
2.39.2


