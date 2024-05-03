Return-Path: <linux-kernel+bounces-167354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D0B8BA862
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D5E1F225EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89CC148834;
	Fri,  3 May 2024 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtVet1JO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254A614A0A4;
	Fri,  3 May 2024 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723932; cv=none; b=VqaGo6VhFW1hMkNACQDEzk4SooJQIpbgEWydOmHPTxukUP2C+9j0SWn09SdJj+QmXdp6laW2bkSu3tF9JK5tjK6sEMOM98ntQYTnA6epSDC3r+FtQ4ojCveI9b34SnpI+Wz5LrBZjjCgaO7hLe5aLTf3Pv0uW7WG18mQqCGQGMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723932; c=relaxed/simple;
	bh=f1FeIQOWdt/yunrrvWZvBDe9vGWa364dMqMNXLioroY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ez9YcC5AZ3GMOOkCEWXeqfTr32I6fGS9U7Ciaj1MwI6kISbvFWWsgT1ULJ54N0l36hSRJo46lOTYW4SV63XvaokuxWgTgmONR8OVg71s/19173R4hcy29tSkngzsn2r05W5rZo+lec1wUxQaaQ4fe5q+YDpdttY83F8Q3UCNBxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtVet1JO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D538C32789;
	Fri,  3 May 2024 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714723931;
	bh=f1FeIQOWdt/yunrrvWZvBDe9vGWa364dMqMNXLioroY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtVet1JO2GRiPm6pL3oVUZh45K4d0qU6WzlGzKY3fDQ25chmRzC69YIhphOPud0ga
	 gGBRIlTs79nB9SXXnK6XueA9CFvZKnCPOIv7/VcrC9X8BiTE76q0D7LRAurD/1YgRc
	 NQzvKcAvmPqwVO0CuBhc04xFrXQQnM/XPyl7ROYnKFKeHLbQG2ByGXJFCcdrI0kvUK
	 fMFc880MwNL2SHd/mLUzt+90jW8Ni2QLNo6eVWLi5SJjfwueUp1TGPmdvQLJGO1fvp
	 JuMxNK63P51akw64/QDJunXoYxfWRmwHqcxzhgAXLKHKUhVABQhUHdKZ4VekSysIBK
	 3VDD04J0CQpUw==
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
Subject: [PATCH 02/14] alpha: fix modversions for strcpy() et.al.
Date: Fri,  3 May 2024 10:11:13 +0200
Message-Id: <20240503081125.67990-3-arnd@kernel.org>
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

        On alpha str{n,}{cpy,cat}() implementations are playing
fun games with shared chunks of code.  The problem is, they are
using direct branches and need to be next to each other.
        Currently it's done by building them in separate object
files, then using ld -r to link those together.  Unfortunately,
genksyms machinery has no idea what to do with that - we have
generated in arch/alpha/lib/.strcat.S.cmd, but there's nothing
to propagate that into .stycpy.S.cmd, so modpost doesn't find
anything for those symbols, resulting in
WARNING: modpost: EXPORT symbol "strcpy" [vmlinux] version generation failed, symbol will not be versioned.
Is "strcpy" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strcat" [vmlinux] version generation failed, symbol will not be versioned.
Is "strcat" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strncpy" [vmlinux] version generation failed, symbol will not be versioned.
Is "strncpy" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strncat" [vmlinux] version generation failed, symbol will not be versioned.
Is "strncat" prototyped in <asm/asm-prototypes.h>?
spew on modversion-enabled builds (all 4 functions in question
are in fact prototyped in asm-prototypes.h)

        Fixing doesn't require messing with kbuild, thankfully -
just build one object (i.e. have sty{n,}cpy.S with includes of relevant
*.S instead of playing with ld -r) and that's it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/lib/Makefile  | 14 --------------
 arch/alpha/lib/stycpy.S  | 11 +++++++++++
 arch/alpha/lib/styncpy.S | 11 +++++++++++
 3 files changed, 22 insertions(+), 14 deletions(-)
 create mode 100644 arch/alpha/lib/stycpy.S
 create mode 100644 arch/alpha/lib/styncpy.S

diff --git a/arch/alpha/lib/Makefile b/arch/alpha/lib/Makefile
index 6a779b9018fd..84046e730e6d 100644
--- a/arch/alpha/lib/Makefile
+++ b/arch/alpha/lib/Makefile
@@ -44,17 +44,3 @@ AFLAGS___remlu.o =       -DREM -DINTSIZE
 $(addprefix $(obj)/,__divqu.o __remqu.o __divlu.o __remlu.o): \
 						$(src)/$(ev6-y)divide.S FORCE
 	$(call if_changed_rule,as_o_S)
-
-# There are direct branches between {str*cpy,str*cat} and stx*cpy.
-# Ensure the branches are within range by merging these objects.
-
-LDFLAGS_stycpy.o := -r
-LDFLAGS_styncpy.o := -r
-
-$(obj)/stycpy.o: $(obj)/strcpy.o $(obj)/$(ev67-y)strcat.o \
-		 $(obj)/$(ev6-y)stxcpy.o FORCE
-	$(call if_changed,ld)
-
-$(obj)/styncpy.o: $(obj)/strncpy.o $(obj)/$(ev67-y)strncat.o \
-		 $(obj)/$(ev6-y)stxncpy.o FORCE
-	$(call if_changed,ld)
diff --git a/arch/alpha/lib/stycpy.S b/arch/alpha/lib/stycpy.S
new file mode 100644
index 000000000000..32ecd9c5f90d
--- /dev/null
+++ b/arch/alpha/lib/stycpy.S
@@ -0,0 +1,11 @@
+#include "strcpy.S"
+#ifdef CONFIG_ALPHA_EV67
+#include "ev67-strcat.S"
+#else
+#include "strcat.S"
+#endif
+#ifdef CONFIG_ALPHA_EV6
+#include "ev6-stxcpy.S"
+#else
+#include "stxcpy.S"
+#endif
diff --git a/arch/alpha/lib/styncpy.S b/arch/alpha/lib/styncpy.S
new file mode 100644
index 000000000000..72fc2754eb57
--- /dev/null
+++ b/arch/alpha/lib/styncpy.S
@@ -0,0 +1,11 @@
+#include "strncpy.S"
+#ifdef CONFIG_ALPHA_EV67
+#include "ev67-strncat.S"
+#else
+#include "strncat.S"
+#endif
+#ifdef CONFIG_ALPHA_EV6
+#include "ev6-stxncpy.S"
+#else
+#include "stxncpy.S"
+#endif
-- 
2.39.2


