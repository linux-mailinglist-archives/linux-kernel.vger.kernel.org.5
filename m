Return-Path: <linux-kernel+bounces-113421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD4F888430
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF3C9B25715
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08C81A8A49;
	Sun, 24 Mar 2024 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuUWBBFQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224511A83F7;
	Sun, 24 Mar 2024 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320223; cv=none; b=RT1CedZI6QtRn3EgubLsEW25be9i5VmhWY0Pnx+/6Apw2z/tV+L3j6VchhqdrIJcShRlnc6baSa86xPAjfMi4VeSZm6Elxw50Ixs+p4P0hobyO5U7ZW1Nnpi/rOpmeVlj891e2QPGrxOWN5jKoW4cwld7bjL8ImjMW9+m0w1Oas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320223; c=relaxed/simple;
	bh=ChoPWhP9raUpj1qBrL5DD6Y3fNZl2x8Bp0/imvtvhAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVioQiGIl3DRW9d04mIlcH00D5q0HtfMHegEUNAOFNDYNFR3LDbygPJKazVDxehI7zpWgaKgnRTHqZEugutOMM7NxCLpxYumoHa2WngPNNFOvjUDvzn+6moJrzXacvG6we494nXiXwaTHYVXib1CshktJ5o+nV/1MXiJdRoQG/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuUWBBFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107CEC433B2;
	Sun, 24 Mar 2024 22:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320223;
	bh=ChoPWhP9raUpj1qBrL5DD6Y3fNZl2x8Bp0/imvtvhAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cuUWBBFQJ1HeTqM/uCpHHuRAfRCVx7MTMkfxL14GImXqc4Oy9xoePTv9aC34jpTp9
	 o+ZV/zy+hXOHtlROZz2onT+b8wYFXi7x2FqD+NNMNkK3X/uGCn1NhSduNc7xrDoSl8
	 cvghs39ZWXqUHX05+WvfZgGTJ01X6fEVoUn5Zz3uCXxupoE0Hwxc7NGL6bi5DntfF2
	 gJzwdZxCorNMc0FrdR8viwKmC+1F3qe5xDkW0y5Au0X9dhAFuFOOXhVRAIKioAJc1k
	 im3atw9L3Hj4CruuivhX2eBIGe8n3fEocM52M5xOE47Vu33Tii9y2ggF29MlCGDiUc
	 IzHJwKUArXKsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 530/715] sparc32: Use generic cmpdi2/ucmpdi2 variants
Date: Sun, 24 Mar 2024 18:31:49 -0400
Message-ID: <20240324223455.1342824-531-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Sam Ravnborg <sam@ravnborg.org>

[ Upstream commit 802a8874a3889a4a0d218d4f73e5855c96d5b8a8 ]

Use the generic variants - the implementation is the same.
As a nice side-effect fix the following warnings:

cmpdi2.c: warning: no previous prototype for '__cmpdi2' [-Wmissing-prototypes]
ucmpdi2.c: warning: no previous prototype for '__ucmpdi2' [-Wmissing-prototypes]

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Fixes: 0fcb70851fbf ("Makefile.extrawarn: turn on missing-prototypes globally")
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>
Tested-by: Maciej W. Rozycki <macro@orcam.me.uk> # build-tested
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Link: https://lore.kernel.org/r/20240224-sam-fix-sparc32-all-builds-v2-1-1f186603c5c4@ravnborg.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/Kconfig       |  2 ++
 arch/sparc/lib/Makefile  |  4 ++--
 arch/sparc/lib/cmpdi2.c  | 28 ----------------------------
 arch/sparc/lib/ucmpdi2.c | 20 --------------------
 4 files changed, 4 insertions(+), 50 deletions(-)
 delete mode 100644 arch/sparc/lib/cmpdi2.c
 delete mode 100644 arch/sparc/lib/ucmpdi2.c

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 204c43cb3d435..0c5a98ef11440 100644
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
index 59669ebddd4e1..ee5091dd67ed7 100644
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
index 333367fe73533..0000000000000
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
index 82c1cccb12644..0000000000000
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
2.43.0


