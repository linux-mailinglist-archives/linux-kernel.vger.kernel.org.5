Return-Path: <linux-kernel+bounces-109268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAB8881703
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD701C20D85
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2174E6A8AF;
	Wed, 20 Mar 2024 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMNZ2qoD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667A96A00B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957754; cv=none; b=Yqi0dL3TnZAd3yhZK4r9FjH7kJmTKgBkzsvV6XYl/Lq6Oao0BKErwqK3TFiyx9CiIyYkt6MnmKVTlKJiO9EFAOfRWpBWG3X1x4Cp59TMqcuetpV5DlqHYZEsqMVNQTbBdGea5loSWRLK/etJGCKd4soRonyNtQynBEloM9yt5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957754; c=relaxed/simple;
	bh=umPOZa/jmcrCOuLgb4lIp085lQH3xXqnpU9motcuApg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e03dEDvwT8B3tFNTdzN1TXpCOGGMA0Ul3XMaiTUJXhoel3SBR/uFvmmJf6c0Q6PWIrjF6FzCqCyBLL3o2gnQ7ZAp1UaEEIUimsdCNABGo0bjFX3uiKR6PKIsKWXwRuBzjLxOVJM3/Q4jjFkIXxrDwxVZ1RyiHDMj6dnKT3l1HYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMNZ2qoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3104AC433C7;
	Wed, 20 Mar 2024 18:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710957754;
	bh=umPOZa/jmcrCOuLgb4lIp085lQH3xXqnpU9motcuApg=;
	h=From:To:Cc:Subject:Date:From;
	b=eMNZ2qoDP61ykdvnIIcV4ZHzzHnTNZ4qdh23XzSN0Ei9JCExg30FCnJUHwsQURvVM
	 uuaIpZefH0Zukdoqi+z/aYwI89XYzaF23LHY+rgV8+L9wmiIzkEUZ+ljGPa6LLCKXr
	 Ari8Xx7qP+x2sfDiltFHw0GuUFlYF3ZqGtgaEBU9B71rJefgAzZk5VD7zx0kIu0r7U
	 Bvfia0i+YGPl7SMCuCS7qiY9CWuibLcmzFpjYi+MG/9hFP++p7v7+i7W+khKzmg0Xa
	 1T/LLC2MaqCUTSVuG1de4+Iy94uwqhYU78VYOF9vJXNdIlQMDxMDRwQ1jJEsDMST9r
	 SfSuVDFOcJz4g==
From: Arnd Bergmann <arnd@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@lists.ozlabs.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vdso: use CONFIG_PAGE_SHIFT in vdso/datapage.h
Date: Wed, 20 Mar 2024 19:02:15 +0100
Message-Id: <20240320180228.136371-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Both the vdso rework and the CONFIG_PAGE_SHIFT changes were merged during
the v6.9 merge window, so it is now possible to use CONFIG_PAGE_SHIFT
instead of including asm/page.h in the vdso.

This avoids the workaround for arm64 and addresses a build warning
for powerpc64:

In file included from <built-in>:4:
In file included from /home/arnd/arm-soc/arm-soc/lib/vdso/gettimeofday.c:5:
In file included from ../include/vdso/datapage.h:25:
arch/powerpc/include/asm/page.h:230:9: error: result of comparison of constant 13835058055282163712 with expression of type 'unsigned long' is always true [-Werror,-Wtautological-constant-out-of-range-compare]
  230 |         return __pa(kaddr) >> PAGE_SHIFT;
      |                ^~~~~~~~~~~
arch/powerpc/include/asm/page.h:217:37: note: expanded from macro '__pa'
  217 |         VIRTUAL_WARN_ON((unsigned long)(x) < PAGE_OFFSET);              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
arch/powerpc/include/asm/page.h:202:73: note: expanded from macro 'VIRTUAL_WARN_ON'
  202 | #define VIRTUAL_WARN_ON(x)      WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && (x))
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
arch/powerpc/include/asm/bug.h:88:25: note: expanded from macro 'WARN_ON'
   88 |         int __ret_warn_on = !!(x);                              \
      |                                ^

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
See-also: 8b3843ae3634 ("vdso/datapage: Quick fix - use asm/page-def.h for ARM64")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/vdso/gettimeofday.h | 3 +--
 include/vdso/datapage.h                      | 8 +-------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
index f0a4cf01e85c..78302f6c2580 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -4,7 +4,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <asm/page.h>
 #include <asm/vdso/timebase.h>
 #include <asm/barrier.h>
 #include <asm/unistd.h>
@@ -95,7 +94,7 @@ const struct vdso_data *__arch_get_vdso_data(void);
 static __always_inline
 const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
 {
-	return (void *)vd + PAGE_SIZE;
+	return (void *)vd + (1U << CONFIG_PAGE_SHIFT);
 }
 #endif
 
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 5d5c0b8efff2..c71ddb6d4691 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,12 +19,6 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
-#ifdef CONFIG_ARM64
-#include <asm/page-def.h>
-#else
-#include <asm/page.h>
-#endif
-
 #ifdef CONFIG_ARCH_HAS_VDSO_DATA
 #include <asm/vdso/data.h>
 #else
@@ -132,7 +126,7 @@ extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden
  */
 union vdso_data_store {
 	struct vdso_data	data[CS_BASES];
-	u8			page[PAGE_SIZE];
+	u8			page[1U << CONFIG_PAGE_SHIFT];
 };
 
 /*
-- 
2.39.2


