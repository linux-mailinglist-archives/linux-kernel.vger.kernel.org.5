Return-Path: <linux-kernel+bounces-77132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CABB860185
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E791F25A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E136AF95;
	Thu, 22 Feb 2024 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3KMfIw9"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04375491F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626254; cv=none; b=i094RGf1i6Sg2NjnrIdi88OGZ6+N0J+EFU/bcX7y1hkQi+VllCyp7Xfk5BAeQB0bAPUDpKPeDZpqXeiQbnNXoIIRPiGBnjyDzcPOYVD5nEquMtYKaxv3vbe+EpmKYV0p+KiOpcTiDnlfyFRynFIc7gT9BnA/Vex3UAWK/Hib9ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626254; c=relaxed/simple;
	bh=jRj9g/e5y+7mPp797YSNxH82vqmTM40/2K74tJ+n/68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ci9hqu/MTUVuk4MWjLLFG4HJj5o5ku5GWBSd85kpMH/Z9veNuvYr7yV1b3vcdyWbUQ7hipqtgmY4r3rRRpOPvT3AkG9Z5wBqBDkugaCNcP+ysRF7Kgpip2j1Q3oaNYgIkBW97Tn6wfjtqN7yjYl9WcH6wEe7cWnvDbyxMF1Zrko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3KMfIw9; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68fb74416ccso444846d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708626249; x=1709231049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e7tNy5a20yjAdBWrxhg+cmTPuB6N559ig/Ixy5c9u2c=;
        b=c3KMfIw9nGAY3JNyQRsPqo/wyvMGdMDyMcH4BNWir6oQ19l/9N6snxhPoLmo6dhABt
         jYm+QMd90ppRBrOO+ys+FsqN6uqCQuaSjgBIVptXGwqGZ2LGyNPwJtAAs5kMNA/sRlGd
         rcCC9nGxcGS/d9ER1yvk4dSj2nLuoORm8RgNjdvtUWcsXoWdnzizyK1I2L9synzkMYca
         88CW5986C0hgJrXsBh9nLU4X2pTMd3JRx4t1mAuJ1KKw8bUj2RhdwUeNprWJEYheCMop
         GRCey/iIpO7mIkHSPfZ8NR4jJd9ZtvkijgoF5x6/H9UQE5IDqpwQL61eWijVd6FjG1WI
         47Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708626249; x=1709231049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e7tNy5a20yjAdBWrxhg+cmTPuB6N559ig/Ixy5c9u2c=;
        b=T4NMRXht5osxRZRv9fW3j4lezF8KkN4V12mm7e9Jp+dODVYoJzhix3YTzFWymm26h6
         XQScKiXB9ncNX9v7VkbGlglb86CsGSmdZmWqu1sSJghp2almFPxUyW5S7ARNAYP62D8g
         r1YNJZEkdDEVqvoHsZs5EFVydhAYopvHg283oa5kDDN3+tZOFza4UfEd/v3lVkuLavUI
         glwWMIYOFUQpqHq8GGXAbn/S1P3Vw+1U2TwHbwqu6y0eleyPJM3gZH8sLX69b6vcY5Ag
         46WvB6TaA3+JlX6kLBR1RXgTYvHt0aBN4GFOexOiynNST4Uv+p+RbCluvrIUaOhXwQHI
         FVjA==
X-Gm-Message-State: AOJu0Yw3/rPk8VJ2zFUakAwwtgfyqqJngeMbZRrIosaA/niMU6xXCoWI
	JUXk69+kAbGLIlge4yAiG1qOcuQ7qw5ezrbdYZh/cse7JnDm9v4plACazb0=
X-Google-Smtp-Source: AGHT+IFD5pCdUL7HLyakcMva/NFH+I7GdBCyBWmBqVFrljPelM5bfpl5K4rAUdsAnARbHSA4a8cM9A==
X-Received: by 2002:a05:6214:484:b0:68f:1138:8ee3 with SMTP id pt4-20020a056214048400b0068f11388ee3mr27099297qvb.52.1708626249583;
        Thu, 22 Feb 2024 10:24:09 -0800 (PST)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id lh10-20020a05621454ca00b0068fbe6d38f6sm949541qvb.54.2024.02.22.10.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:24:09 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH] x86/boot/64: Load kernel GDT in early boot
Date: Thu, 22 Feb 2024 13:23:56 -0500
Message-ID: <20240222182356.69549-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of loading a duplicate GDT just for early boot, load the kernel
GDT from its physical address.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/desc.h |  1 +
 arch/x86/kernel/head64.c    | 14 +++-----------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index ec95fe44fa3a..62dc9f59ea76 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -46,6 +46,7 @@ struct gdt_page {
 } __attribute__((aligned(PAGE_SIZE)));
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
+DECLARE_INIT_PER_CPU(gdt_page);
 
 /* Provide the original GDT */
 static inline struct desc_struct *get_cpu_gdt_rw(unsigned int cpu)
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index dc0956067944..09c67e6add62 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -67,21 +67,12 @@ unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
 EXPORT_SYMBOL(vmemmap_base);
 #endif
 
-/*
- * GDT used on the boot CPU before switching to virtual addresses.
- */
-static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
-	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(DESC_CODE32, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(DESC_CODE64, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(DESC_DATA64, 0, 0xfffff),
-};
-
 /*
  * Address needs to be set at runtime because it references the startup_gdt
  * while the kernel still uses a direct mapping.
  */
 static struct desc_ptr startup_gdt_descr __initdata = {
-	.size = sizeof(startup_gdt)-1,
+	.size = GDT_SIZE - 1,
 	.address = 0,
 };
 
@@ -624,7 +615,8 @@ void early_setup_idt(void)
 void __head startup_64_setup_env(unsigned long physbase)
 {
 	/* Load GDT */
-	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
+	startup_gdt_descr.address =
+		(unsigned long)fixup_pointer(&init_per_cpu_var(gdt_page.gdt), physbase);
 	native_load_gdt(&startup_gdt_descr);
 
 	/* New GDT is live - reload data segment registers */

base-commit: c56ac217a3c00d12e23606e0635cc95d6eb8c36a
-- 
2.43.2


