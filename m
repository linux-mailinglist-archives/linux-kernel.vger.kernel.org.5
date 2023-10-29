Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E99C7DB141
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjJ2X33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjJ2X3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:29:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791841724;
        Sun, 29 Oct 2023 15:57:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10712C433C7;
        Sun, 29 Oct 2023 22:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620209;
        bh=ChxiZgj1s8N53L3B1UfbFt7sFdErPWaTFgDKiWCLX6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o3WXAjUdVZmoJNWTCQBxxg8qybKdXraPXEqRtA8wlZ5JJjrLxbDUZ18A+diSq3DSr
         CUnsj7Ke75ePtOG5vZZDfR0aZf+LGNYmSoyIVOabb1e90Tr0FYJ933HWNIwaU9gqjT
         IIkXhmE+OFevPPA39mYWJznu+o4f4r+k7jHQxZkDZ+j/7OgntDXlB7xmSxjiOBcx1D
         27ave2Nv4+EWa+WB4T/e5YcElWZKA5MdP3loy5UkjYykdfqrgqQbS6Gl8wApbS0456
         s8QtVfv9zwdORR5oswRJbO9FArSKpPNjr4gLY1l4dV4Rt/h3Yewd7f3WEQMJuOeAYr
         V7DMoSm5mcRPA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Icenowy Zheng <uwu@icenowy.me>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
        kernel@xen0n.name, akpm@linux-foundation.org, bhe@redhat.com,
        rppt@kernel.org, willy@infradead.org, zhanghongchen@loongson.cn,
        david@redhat.com, zhoubinbin@loongson.cn, donmor3000@hotmail.com,
        yangtiezhu@loongson.cn, tangyouling@loongson.cn,
        tglx@linutronix.de, loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 43/52] LoongArch: Disable WUC for pgprot_writecombine() like ioremap_wc()
Date:   Sun, 29 Oct 2023 18:53:30 -0400
Message-ID: <20231029225441.789781-43-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <uwu@icenowy.me>

[ Upstream commit 278be83601dd1725d4732241f066d528e160a39d ]

Currently the code disables WUC only disables it for ioremap_wc(), which
is only used when mapping writecombine pages like ioremap() (mapped to
the kernel space). But for VRAM mapped in TTM/GEM, it is mapped with a
crafted pgprot by the pgprot_writecombine() function, in which case WUC
isn't disabled now.

Disable WUC for pgprot_writecombine() (fallback to SUC) if needed, like
ioremap_wc().

This improves the AMDGPU driver's stability (solves some misrendering)
on Loongson-3A5000/3A6000 machines.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/io.h           |  5 ++---
 arch/loongarch/include/asm/pgtable-bits.h |  4 +++-
 arch/loongarch/kernel/setup.c             | 10 +++++-----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index 1c94102200407..0355b64e90ed0 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -54,10 +54,9 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
  * @offset:    bus address of the memory
  * @size:      size of the resource to map
  */
-extern pgprot_t pgprot_wc;
-
 #define ioremap_wc(offset, size)	\
-	ioremap_prot((offset), (size), pgprot_val(pgprot_wc))
+	ioremap_prot((offset), (size),	\
+		pgprot_val(wc_enabled ? PAGE_KERNEL_WUC : PAGE_KERNEL_SUC))
 
 #define ioremap_cache(offset, size)	\
 	ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL))
diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/include/asm/pgtable-bits.h
index de46a6b1e9f11..7b9ac012cd090 100644
--- a/arch/loongarch/include/asm/pgtable-bits.h
+++ b/arch/loongarch/include/asm/pgtable-bits.h
@@ -105,13 +105,15 @@ static inline pgprot_t pgprot_noncached(pgprot_t _prot)
 	return __pgprot(prot);
 }
 
+extern bool wc_enabled;
+
 #define pgprot_writecombine pgprot_writecombine
 
 static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
 {
 	unsigned long prot = pgprot_val(_prot);
 
-	prot = (prot & ~_CACHE_MASK) | _CACHE_WUC;
+	prot = (prot & ~_CACHE_MASK) | (wc_enabled ? _CACHE_WUC : _CACHE_SUC);
 
 	return __pgprot(prot);
 }
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 9d830ab4e3025..1351614042d4e 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -161,19 +161,19 @@ static void __init smbios_parse(void)
 }
 
 #ifdef CONFIG_ARCH_WRITECOMBINE
-pgprot_t pgprot_wc = PAGE_KERNEL_WUC;
+bool wc_enabled = true;
 #else
-pgprot_t pgprot_wc = PAGE_KERNEL_SUC;
+bool wc_enabled = false;
 #endif
 
-EXPORT_SYMBOL(pgprot_wc);
+EXPORT_SYMBOL(wc_enabled);
 
 static int __init setup_writecombine(char *p)
 {
 	if (!strcmp(p, "on"))
-		pgprot_wc = PAGE_KERNEL_WUC;
+		wc_enabled = true;
 	else if (!strcmp(p, "off"))
-		pgprot_wc = PAGE_KERNEL_SUC;
+		wc_enabled = false;
 	else
 		pr_warn("Unknown writecombine setting \"%s\".\n", p);
 
-- 
2.42.0

