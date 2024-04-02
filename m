Return-Path: <linux-kernel+bounces-127372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDEB894A70
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FBF1C222AD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EE717BA8;
	Tue,  2 Apr 2024 04:27:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E167179AA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 04:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712032030; cv=none; b=i31Py/wVaOSsiZjB1ijDzx9zNzT8I40WU/SwcHZ4vMqZIPZhu/1InPPum5t8jAWkElqMIqtbb3/4NHt3ncaW4oic/ciHMZlT042GbAPSSzb1I98Uwwizwi0wSVRmGuzUODPBM8gO4EY4s9/wUhDMkgMln7R2gBfuN8WeLhn4dY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712032030; c=relaxed/simple;
	bh=nx3dhcwM3R76N0K2GnBM5xafccj0snz2GGo65nje9Ow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cf8VmULfOiYvdaqk6Mld092a2iM7dDrtNLzyOfCh1Tx/NGJ8U8hJlHOXJod9VU3Mtb9SraHk/R85Sq9TOMqEvtnfHvkmgAvR7GIfuxnswPUOJ6y5Ee1aahA9I9OitUm2MoY3LTGh3GjohMUIINIdq2Gd1KSYsz1x7G42NIo76H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BC3C43390;
	Tue,  2 Apr 2024 04:27:08 +0000 (UTC)
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: [PATCH 1/8] sparc32: make __cmpxchg_u32() return u32
Date: Tue,  2 Apr 2024 00:28:28 -0400
Message-Id: <20240402042835.11815-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402041138.GF538574@ZenIV>
References: <20240402041138.GF538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conversion between u32 and unsigned long is tautological there,
and the only use of return value is to return it from
__cmpxchg() (which return unsigned long).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/include/asm/cmpxchg_32.h | 2 +-
 arch/sparc/lib/atomic32.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index d0af82c240b7..112bfaa28729 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -39,7 +39,7 @@ static __always_inline unsigned long __arch_xchg(unsigned long x, __volatile__ v
 /* bug catcher for when unsupported size is used - won't link */
 void __cmpxchg_called_with_bad_pointer(void);
 /* we only need to support cmpxchg of a u32 on sparc */
-unsigned long __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
+u32 __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
 
 /* don't worry...optimizer will get rid of most of this */
 static inline unsigned long
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index cf80d1ae352b..d90d756123d8 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -159,7 +159,7 @@ unsigned long sp32___change_bit(unsigned long *addr, unsigned long mask)
 }
 EXPORT_SYMBOL(sp32___change_bit);
 
-unsigned long __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
+u32 __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
 {
 	unsigned long flags;
 	u32 prev;
@@ -169,7 +169,7 @@ unsigned long __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
 		*ptr = new;
 	spin_unlock_irqrestore(ATOMIC_HASH(ptr), flags);
 
-	return (unsigned long)prev;
+	return prev;
 }
 EXPORT_SYMBOL(__cmpxchg_u32);
 
-- 
2.39.2


