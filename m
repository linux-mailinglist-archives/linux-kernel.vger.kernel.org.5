Return-Path: <linux-kernel+bounces-79032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AC3861CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D081F23DD2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03C8145B08;
	Fri, 23 Feb 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSsEw+jr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22B71420B7;
	Fri, 23 Feb 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717025; cv=none; b=oSHNmq9jvd8QxPobC1T6h/bYrKvbQR9rSnsYf0Yzyje9F8mhuqEv3yRKU5GxbVdoVKQhDwkzATYzGjxbYL/UmfEWWekI4AMaMKNCrWIXDmr6smBeYSYfRXKk0LrQSCHfcvMm+t1xpT3RMtNsHZAAj5hqBUiOjxcRHiPkU0aexA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717025; c=relaxed/simple;
	bh=Y3ySrz1oDy2VdIWP8KqhKgzBK85YCNmxVjOAZb69QGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TI1zR55euTlkFo8igFXo9ndTGItIZezNFGQHs6niFhSRr4Z1gvD32ntyoXtmirPhJnWVOf5bpgIO64qosiFfWr0WBD10s7K0BIw2RJUzsDlhRPZbioivH/BwKYQmtCog4D2OoITlB/QSxw6458cCsIGywZ73ctY17EYFLQMtIWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSsEw+jr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7DCCC433C7;
	Fri, 23 Feb 2024 19:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708717024;
	bh=Y3ySrz1oDy2VdIWP8KqhKgzBK85YCNmxVjOAZb69QGc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VSsEw+jrZDzhkgMEgV4+Gcw+7KVsCDNEEs5P/s4HAxxTLlfStp2dMMzF/BPKpUAJx
	 T/y7YvdsGkPPc24f4WYTDeCkhr2nTTqfvAlXNEu1XHUEPpvly5EyN+sN//UPv6P/h5
	 moSUCzwrbkKhT1wjbScM7tZm/4UkT4hzXEuavhLmxFP2fd6VGKjh8GA98b3YfqSXKC
	 ZgbHObR1Hq6ozJzRwifjPNf4CXcBAXJGvurwpzCmKnN94HquXGzs1xk3W5NUxdeS59
	 rSjWSpfqKID5LGZc2Ky7CuTKWHjzPFDohYsXeF6LP/djX8P6ZuCwx+M1nc9ZJst4P0
	 SGCYhCUeOzlyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A932C54E49;
	Fri, 23 Feb 2024 19:37:04 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Fri, 23 Feb 2024 20:36:47 +0100
Subject: [PATCH 1/6] sparc32: Use generic cmpdi2/ucmpdi2 variants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240223-sam-fix-sparc32-all-builds-v1-1-5c60fd5c9250@ravnborg.org>
References:
 <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
In-Reply-To:
 <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: sparclinux@vger.kernel.org, linux-parport@lists.infradead.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708717023; l=3407;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=29TdsRP/R2LmI+LIbEQqDi2Bdx01Dq7gEBtiS6nu5bo=; =?utf-8?q?b=3DEZRSjOFa3fv5?=
 =?utf-8?q?8gfK6zprK0eC07yJzc8FhmSdLTMB2lUFaZrffJQk4aajMyG/Syy5Fsvf8tIGe0Dj?=
 ZlaRS+PXAJ24fFkMWQugmp4S2FzISQY22UdAByym++h54YDBEtT4
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

From: Sam Ravnborg <sam@ravnborg.org>

Use the generic variants - the implementation is the same.
As a nice side-effect fix the following warnings:

cmpdi2.c: warning: no previous prototype for '__cmpdi2' [-Wmissing-prototypes]
ucmpdi2.c: warning: no previous prototype for '__ucmpdi2' [-Wmissing-prototypes]

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/Kconfig       |  2 ++
 arch/sparc/lib/Makefile  |  4 ++--
 arch/sparc/lib/cmpdi2.c  | 28 ----------------------------
 arch/sparc/lib/ucmpdi2.c | 20 --------------------
 4 files changed, 4 insertions(+), 50 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index b087d4fe00af..734f23daecca 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -57,6 +57,8 @@ config SPARC32
 	select CLZ_TAB
 	select DMA_DIRECT_REMAP
 	select GENERIC_ATOMIC64
+	select GENERIC_LIB_CMPDI2
+	select GENERIC_LIB_UCMPDI2
 	select HAVE_UID16
 	select LOCK_MM_AND_FIND_VMA
 	select OLD_SIGACTION
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 59669ebddd4e..ee5091dd67ed 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -14,7 +14,7 @@ lib-$(CONFIG_SPARC32) += divdi3.o udivdi3.o
 lib-$(CONFIG_SPARC32) += copy_user.o locks.o
 lib-$(CONFIG_SPARC64) += atomic_64.o
 lib-$(CONFIG_SPARC32) += lshrdi3.o ashldi3.o
-lib-$(CONFIG_SPARC32) += muldi3.o bitext.o cmpdi2.o
+lib-$(CONFIG_SPARC32) += muldi3.o bitext.o
 lib-$(CONFIG_SPARC64) += multi3.o
 lib-$(CONFIG_SPARC64) += fls.o
 lib-$(CONFIG_SPARC64) += fls64.o
@@ -51,5 +51,5 @@ lib-$(CONFIG_SPARC64) += copy_in_user.o memmove.o
 lib-$(CONFIG_SPARC64) += mcount.o ipcsum.o xor.o hweight.o ffs.o
 
 obj-$(CONFIG_SPARC64) += iomap.o
-obj-$(CONFIG_SPARC32) += atomic32.o ucmpdi2.o
+obj-$(CONFIG_SPARC32) += atomic32.o
 obj-$(CONFIG_SPARC64) += PeeCeeI.o
diff --git a/arch/sparc/lib/cmpdi2.c b/arch/sparc/lib/cmpdi2.c
deleted file mode 100644
index 333367fe7353..000000000000
--- a/arch/sparc/lib/cmpdi2.c
+++ /dev/null
@@ -1,28 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/module.h>
-
-#include "libgcc.h"
-
-word_type __cmpdi2(long long a, long long b)
-{
-	const DWunion au = {
-		.ll = a
-	};
-	const DWunion bu = {
-		.ll = b
-	};
-
-	if (au.s.high < bu.s.high)
-		return 0;
-	else if (au.s.high > bu.s.high)
-		return 2;
-
-	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
-		return 0;
-	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
-		return 2;
-
-	return 1;
-}
-
-EXPORT_SYMBOL(__cmpdi2);
diff --git a/arch/sparc/lib/ucmpdi2.c b/arch/sparc/lib/ucmpdi2.c
deleted file mode 100644
index 82c1cccb1264..000000000000
--- a/arch/sparc/lib/ucmpdi2.c
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/module.h>
-#include "libgcc.h"
-
-word_type __ucmpdi2(unsigned long long a, unsigned long long b)
-{
-	const DWunion au = {.ll = a};
-	const DWunion bu = {.ll = b};
-
-	if ((unsigned int) au.s.high < (unsigned int) bu.s.high)
-		return 0;
-	else if ((unsigned int) au.s.high > (unsigned int) bu.s.high)
-		return 2;
-	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
-		return 0;
-	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
-		return 2;
-	return 1;
-}
-EXPORT_SYMBOL(__ucmpdi2);

-- 
2.34.1


