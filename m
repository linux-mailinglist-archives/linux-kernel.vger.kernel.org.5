Return-Path: <linux-kernel+bounces-167353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534E08BA860
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80BA1F22391
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3283F149C57;
	Fri,  3 May 2024 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4i6Ch0Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773B148FF3;
	Fri,  3 May 2024 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723929; cv=none; b=uRJOacK9xkplDnu2pxrqP9uPrtlSDfVGWTmpPm92vFh41T8Jy2Hppa9O9CmxAcDJgAxZoM0nA7K043Sp3/XY0HbrjyFheVozx7fWEHyeE2S/+go8Iqrr+f5Q6DCxQkbDr4yaNYbuZSILlLwD5sQZ9FYI8UkoCeJK4vs2GUk1xgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723929; c=relaxed/simple;
	bh=9O73EmjeYBY7iwhf3ePFN3iterJdli5ckZiBCP/CfUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=me8h4RKbIInsIeWgFnk5K1dIR7nofiEz/oSDgrXbCsEHofakadjAp3H35/ccQ7tKJHgbHHfh459OJbKWDybwqg0IZ2HB8GGkzA3LvMdbC8ch/1/aTpGOugGvwOKDZlTX37qEdICy4Kj3HxhHUKLB9UqgcsAptbFkMzYkB8gBqYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4i6Ch0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04C1C4AF18;
	Fri,  3 May 2024 08:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714723929;
	bh=9O73EmjeYBY7iwhf3ePFN3iterJdli5ckZiBCP/CfUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f4i6Ch0YRVVJYdTMNATrJPzeAhRA7nosPIwfGWzCIgUuGhUkwxhcH1nglvd0+adKh
	 tdWIwwIy7wxljULJBAoe94AdptvMHdFN3cn5FgPuiUCgYKWQfDUDS0a0mTBS7TLjG1
	 +CIlwzycBO4F9DJOV6rfNMSPn2mIj2gAA/ZCg+GPodptNw1OL6j3jpZIegpyrRls0d
	 qq+xoDUEi6PNksH+Xc5kFTH2H0ffxC+lROev/e/HFW27bE74KFbIXWZdusiCJNnqaw
	 psEkPeOAAVHJlpp0KXu1ehEriYpisQrmJUJfe6sJkd+VF4K/Xra8CpfXRpsWr0GXwW
	 MK0eYPcfLjFwA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-alpha@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] alpha: sort scr_mem{cpy,move}w() out
Date: Fri,  3 May 2024 10:11:12 +0200
Message-Id: <20240503081125.67990-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503081125.67990-1-arnd@kernel.org>
References: <20240503081125.67990-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

Take scr_memmove() out of line, make both it and scr_memcpyw()
conditional upon VGA_CONSOLE or MDA_CONSOLE (if neither is
selected, we are certain to be working with the kernel-allocated
buffer rather than VRAM and defaults will work just fine).

That allows to clean vt_buffer.h, but that's a separate story

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/vga.h |  2 ++
 arch/alpha/kernel/io.c       | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/alpha/include/asm/vga.h b/arch/alpha/include/asm/vga.h
index 4c347a8454c7..919931cb5b63 100644
--- a/arch/alpha/include/asm/vga.h
+++ b/arch/alpha/include/asm/vga.h
@@ -13,6 +13,7 @@
 #define VT_BUF_HAVE_RW
 #define VT_BUF_HAVE_MEMSETW
 #define VT_BUF_HAVE_MEMCPYW
+#define VT_BUF_HAVE_MEMMOVEW
 
 static inline void scr_writew(u16 val, volatile u16 *addr)
 {
@@ -40,6 +41,7 @@ static inline void scr_memsetw(u16 *s, u16 c, unsigned int count)
 
 /* Do not trust that the usage will be correct; analyze the arguments.  */
 extern void scr_memcpyw(u16 *d, const u16 *s, unsigned int count);
+extern void scr_memmovew(u16 *d, const u16 *s, unsigned int count);
 
 /* ??? These are currently only used for downloading character sets.  As
    such, they don't need memory barriers.  Is this all they are intended
diff --git a/arch/alpha/kernel/io.c b/arch/alpha/kernel/io.c
index eda09778268f..c28035d6d1e6 100644
--- a/arch/alpha/kernel/io.c
+++ b/arch/alpha/kernel/io.c
@@ -647,6 +647,10 @@ void _memset_c_io(volatile void __iomem *to, unsigned long c, long count)
 
 EXPORT_SYMBOL(_memset_c_io);
 
+#if IS_ENABLED(CONFIG_VGA_CONSOLE) || IS_ENABLED(CONFIG_MDA_CONSOLE)
+
+#include <asm/vga.h>
+
 /* A version of memcpy used by the vga console routines to move data around
    arbitrarily between screen and main memory.  */
 
@@ -681,6 +685,21 @@ scr_memcpyw(u16 *d, const u16 *s, unsigned int count)
 
 EXPORT_SYMBOL(scr_memcpyw);
 
+void scr_memmovew(u16 *d, const u16 *s, unsigned int count)
+{
+	if (d < s)
+		scr_memcpyw(d, s, count);
+	else {
+		count /= 2;
+		d += count;
+		s += count;
+		while (count--)
+			scr_writew(scr_readw(--s), --d);
+	}
+}
+EXPORT_SYMBOL(scr_memmovew);
+#endif
+
 void __iomem *ioport_map(unsigned long port, unsigned int size)
 {
 	return IO_CONCAT(__IO_PREFIX,ioportmap) (port);
-- 
2.39.2


