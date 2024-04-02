Return-Path: <linux-kernel+bounces-127373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E90894A71
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D3D1F23023
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8446B17C66;
	Tue,  2 Apr 2024 04:27:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F18F17BC2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 04:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712032031; cv=none; b=cnD+NsGixpKBX47O1D1a+nHKY5o7FACHEtPjRqReQROrhKV/rGEIQscSHw+UJjmk3TLYWGE2IsrJ+Br9fLmIzIAH8e3LbiSrFYxFuRq0r+fVZrE2FoeaC11/RPiM+XMdcfadHjqd4sCGgPpYGwPLGchv6KSbwV3JPdZYBCfZxVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712032031; c=relaxed/simple;
	bh=eVuA0yXC9aDnw7es64OwZIQuGfIRFnPZ62OkGNWsTeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hmYpn9TUmTOLUrBRh22tT2dkBkK6WvtNUZ8+NveR3sbVa+ErbNtXUoEE/LNgx4RwBdwfB2HJa/0BRYLarZVUL9VSFrjMKlBW29OD1F06ePMgP0mwa2QDk+u4tlbmxO0Foz7UWcrR4xDjbq2tZMJrWqbQNTyDvZoDTMiimIW2liU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02899C43394;
	Tue,  2 Apr 2024 04:27:09 +0000 (UTC)
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: [PATCH 2/8] sparc32: make the first argument of __cmpxchg_u64() volatile u64 *
Date: Tue,  2 Apr 2024 00:28:29 -0400
Message-Id: <20240402042835.11815-2-viro@zeniv.linux.org.uk>
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

.. to match all cmpxchg variants.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/include/asm/cmpxchg_32.h | 2 +-
 arch/sparc/lib/atomic32.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index 112bfaa28729..86254c366477 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -63,7 +63,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 			(unsigned long)_n_, sizeof(*(ptr)));		\
 })
 
-u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new);
+u64 __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new);
 #define arch_cmpxchg64(ptr, old, new)	__cmpxchg_u64(ptr, old, new)
 
 #include <asm-generic/cmpxchg-local.h>
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index d90d756123d8..e15affbbb523 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -173,7 +173,7 @@ u32 __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
 }
 EXPORT_SYMBOL(__cmpxchg_u32);
 
-u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new)
+u64 __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new)
 {
 	unsigned long flags;
 	u64 prev;
-- 
2.39.2


