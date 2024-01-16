Return-Path: <linux-kernel+bounces-26886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C70C482E75F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5451C22B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C767135294;
	Tue, 16 Jan 2024 01:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLzxMJ+G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F40020B33;
	Tue, 16 Jan 2024 01:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9127AC433F1;
	Tue, 16 Jan 2024 01:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367303;
	bh=x3jxym4lIRpzNoP0ctkBN0XWggj9cHnUcUoNBoXllUY=;
	h=From:To:Cc:Subject:Date:From;
	b=GLzxMJ+G5E7xY+4svcvTqmH+l/XrMAz1tFL1W88SDAGbEKHVgaFrHh7tOLfoNRc5L
	 rtiipZ428hs9gxKXdDquYf0fTYNcL2Vm9z8aW4m8I6k+n4DWz54U5+FYS5AyUAulA6
	 WjFhg5CelNSIndyQXqA7JfuEYbhZtFlQr0/5zDCsXBkK06albdUZvtleYjfaYdQx0A
	 tqBZ7RXbe4f20AJe5qyS4ENRTd4TdNpZ30viHnpX0Usf8vF8nLgWUzI09ruMT+bvMS
	 hK1x5vlEEk8V7ONMaud2IdfEKmL0pbPSse9jeK+KijEYwS13SLj3l9/B57x4erFI7n
	 B/XF+6M7PAyHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Brian Cain <bcain@quicinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	david@redhat.com,
	mpe@ellerman.id.au,
	guoren@kernel.org,
	rppt@kernel.org,
	linux-hexagon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/9] Hexagon: Make pfn accessors statics inlines
Date: Mon, 15 Jan 2024 20:08:07 -0500
Message-ID: <20240116010819.219701-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit d6e81532b10d8deb2bc30f7b44f09534876893e3 ]

Making virt_to_pfn() a static inline taking a strongly typed
(const void *) makes the contract of a passing a pointer of that
type to the function explicit and exposes any misuse of the
macro virt_to_pfn() acting polymorphic and accepting many types
such as (void *), (unitptr_t) or (unsigned long) as arguments
without warnings.

For symmetry do the same with pfn_to_virt().

For compiletime resolution of __pa() we need PAGE_OFFSET which
was not available to __pa() and resolved by the preprocessor
wherever __pa() was used. Fix this by explicitly including
<asm/mem-layout.h> where required, following the pattern of the
architectures page.h file.

Acked-by: Brian Cain <bcain@quicinc.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/hexagon/include/asm/page.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
index ee31f36f48f3..62976e38a963 100644
--- a/arch/hexagon/include/asm/page.h
+++ b/arch/hexagon/include/asm/page.h
@@ -78,6 +78,9 @@ typedef struct page *pgtable_t;
 #define __pgd(x)       ((pgd_t) { (x) })
 #define __pgprot(x)    ((pgprot_t) { (x) })
 
+/* Needed for PAGE_OFFSET used in the macro right below */
+#include <asm/mem-layout.h>
+
 /*
  * We need a __pa and a __va routine for kernel space.
  * MIPS says they're only used during mem_init.
@@ -127,8 +130,16 @@ static inline void clear_page(void *page)
  */
 #define page_to_phys(page)      (page_to_pfn(page) << PAGE_SHIFT)
 
-#define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)
-#define pfn_to_virt(pfn)        __va((pfn) << PAGE_SHIFT)
+static inline unsigned long virt_to_pfn(const void *kaddr)
+{
+	return __pa(kaddr) >> PAGE_SHIFT;
+}
+
+static inline void *pfn_to_virt(unsigned long pfn)
+{
+	return (void *)((unsigned long)__va(pfn) << PAGE_SHIFT);
+}
+
 
 #define page_to_virt(page)	__va(page_to_phys(page))
 
-- 
2.43.0


