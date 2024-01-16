Return-Path: <linux-kernel+bounces-26853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4E182E6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7119E1C22A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C3623744;
	Tue, 16 Jan 2024 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgoT/KRp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F1D22F17;
	Tue, 16 Jan 2024 01:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BE1C43390;
	Tue, 16 Jan 2024 01:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367211;
	bh=Xoyym8SbFaFTJhnzUgEkGRcabuTho3/U89WhI3ZWbn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JgoT/KRpG3f5x1hYeHEe21MTUpkmSuDp1z90DD9UL70snIPvJLNYy0zjP5YMbSyGn
	 h1n57sAeQ/v6u/PizYzJtnoAoAnX2CZbo2vmEvSsfHZAWqz+eEEAPtQw3yAgc47d4p
	 tTK+okY5jQeTXqScO9Hn0YJDvudDEiWE5eKWBhjNpiq6DnpL4b8xtvcE7io5F78GpL
	 RObD2otTQgzfsc7YZAimZtVCnMIVERpt9P68h7AkXQnD8G+ZiyVslBFvVU9mxVTV0X
	 kpvPksOITmTvuwIJlibLg/jS/RxdzF2BS+B4RVwKqs2npArzJZe4H7B/i6ryfwadN7
	 LLqkqeI2UkN/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Brian Cain <bcain@quicinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>,
	david@redhat.com,
	rppt@kernel.org,
	mpe@ellerman.id.au,
	linux-hexagon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/14] Hexagon: Make pfn accessors statics inlines
Date: Mon, 15 Jan 2024 20:06:05 -0500
Message-ID: <20240116010642.218876-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010642.218876-1-sashal@kernel.org>
References: <20240116010642.218876-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
index 7cbf719c578e..2d8c681c3469 100644
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
@@ -126,8 +129,16 @@ static inline void clear_page(void *page)
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


