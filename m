Return-Path: <linux-kernel+bounces-127374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 777BB894A72
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078D9B22AED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738561805E;
	Tue,  2 Apr 2024 04:27:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D15D18028
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712032032; cv=none; b=AxQxr6PIRKv62tjpabtfjgEEh88zGgE0pk/DzqpokrhGjJbENXxpoo2NHj/1ht8YnW9ozOZghIGYoUiPA24jixzwH1ir7QcdNQrXzCYtF+sT6BLZ+oyq0xpodTGy//asne6W2GWXkz1Xpu2j3r45DIjaKe7rHV0FuSgTbxaAU4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712032032; c=relaxed/simple;
	bh=0ty19jRxcR5LG1UDzrTwUm/X+9XwoVNaxUPstJldl5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gGAQNic9m6vMRi8JA8y8t7kfmPGwGCF0B4HgsQzwRf9oQfzXYa4PCACaWpgflqDz7m/v4eGd7RurKkcn7aqerkuHGQBCTUj8C7ejsxe0E28Ulkoh/OX2PEbb1LbBNUo6ldwRE6k1PhPeMtkuSjV4ljh7W22MDodOagIRO2pGa2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EC1C43390;
	Tue,  2 Apr 2024 04:27:10 +0000 (UTC)
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: [PATCH 3/8] sparc32: unify __cmpxchg_u{32,64}
Date: Tue,  2 Apr 2024 00:28:30 -0400
Message-Id: <20240402042835.11815-3-viro@zeniv.linux.org.uk>
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

Add a macro that expands to one of those when given u32 or u64
as an argument - atomic32.c has a lot of similar stuff already.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/lib/atomic32.c | 41 +++++++++++++++------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index e15affbbb523..0d215a772428 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -159,32 +159,23 @@ unsigned long sp32___change_bit(unsigned long *addr, unsigned long mask)
 }
 EXPORT_SYMBOL(sp32___change_bit);
 
-u32 __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
-{
-	unsigned long flags;
-	u32 prev;
-
-	spin_lock_irqsave(ATOMIC_HASH(ptr), flags);
-	if ((prev = *ptr) == old)
-		*ptr = new;
-	spin_unlock_irqrestore(ATOMIC_HASH(ptr), flags);
-
-	return prev;
-}
+#define CMPXCHG(T)						\
+	T __cmpxchg_##T(volatile T *ptr, T old, T new)		\
+	{							\
+		unsigned long flags;				\
+		T prev;						\
+								\
+		spin_lock_irqsave(ATOMIC_HASH(ptr), flags);	\
+		if ((prev = *ptr) == old)			\
+			*ptr = new;				\
+		spin_unlock_irqrestore(ATOMIC_HASH(ptr), flags);\
+								\
+		return prev;					\
+	}
+
+CMPXCHG(u32)
+CMPXCHG(u64)
 EXPORT_SYMBOL(__cmpxchg_u32);
-
-u64 __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new)
-{
-	unsigned long flags;
-	u64 prev;
-
-	spin_lock_irqsave(ATOMIC_HASH(ptr), flags);
-	if ((prev = *ptr) == old)
-		*ptr = new;
-	spin_unlock_irqrestore(ATOMIC_HASH(ptr), flags);
-
-	return prev;
-}
 EXPORT_SYMBOL(__cmpxchg_u64);
 
 unsigned long __xchg_u32(volatile u32 *ptr, u32 new)
-- 
2.39.2


