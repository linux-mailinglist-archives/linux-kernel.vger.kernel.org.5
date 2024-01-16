Return-Path: <linux-kernel+bounces-26834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9E682E6BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F942836A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D2C1CFBD;
	Tue, 16 Jan 2024 01:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFzP6wVF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930271CD31;
	Tue, 16 Jan 2024 01:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08660C433C7;
	Tue, 16 Jan 2024 01:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367151;
	bh=bHmHzXMQuQaQ1dfueZo4EHk2ecWS1Z3I2SB+GQETulY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gFzP6wVFRt7fe9T+CN2IhguwcHmlPqvMeiFP9soSOg+zC9oK3M4EfWJJx8ma430Vp
	 ytNGRVjmj+/S/sF1CmGjk3R/hqUNcFssDDr+ITYP/I95iB98ItnWvmfK4whHtWZp/v
	 E+Y5b09ydUPG5PgWvN+9ytPFtxk9dXoOLOfiWTDe3/ekF6dz3dHsNpXXE00Bc82VHe
	 CGdvENAA8D46tN40GBUT7qzQSLbDSDWmezXMWgDTIsJPtuq1aWh9Kx18D7yFfiw7Xw
	 i5DKl5iEwris05OFXGuVK8p03SI1eAjb/bEKLpnTeP82D8+9h1iloLNpNloQHqWFyo
	 PqLmixARBnDHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Brian Cain <bcain@quicinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>,
	rppt@kernel.org,
	shorne@gmail.com,
	guoren@kernel.org,
	linux-hexagon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/19] Hexagon: Make pfn accessors statics inlines
Date: Mon, 15 Jan 2024 20:04:59 -0500
Message-ID: <20240116010532.218428-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010532.218428-1-sashal@kernel.org>
References: <20240116010532.218428-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index 9c03b9965f07..10f1bc07423c 100644
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
@@ -125,8 +128,16 @@ static inline void clear_page(void *page)
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


