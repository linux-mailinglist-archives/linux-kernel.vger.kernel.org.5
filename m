Return-Path: <linux-kernel+bounces-89206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 777F986EC02
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC3628744F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120BC5EE68;
	Fri,  1 Mar 2024 22:41:47 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C9059B6F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709332906; cv=none; b=LPgS1UWtKoxCHQPPLm9y1/Z2MIHsEb2RU2sVwXUyDrE4ziUENN5VEeXhsw0n/qGqSqhTGVwjbls1g2DikWoK73DnephC5naXO1sGCk4Wj/GS7HNZ/3x8gqtECAimPlIaxCFSWV2VkRtCtSWuPdgH8s8FFiSLdXKfRk7Ka5Bcbvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709332906; c=relaxed/simple;
	bh=y05OlHIzADcP3OrGVS6Hx+8JB8tEpPHFBEbcYJFqEzA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=V09dFfV6SaJrU1MYEnkPnaxc83kDO63csBrWa2NgovKg5ELHoIiBe8tSidHYOanzsd8YQfIJk0ErYrDBQ4eFb1iiPXxMez3EGIl4WVmEJmgVcpQ9yFvx6RRfwIyBUYJsIUqCDLOApg7PWvYNIlPp2pZ8xP0jiZY0lJpq/+VcuB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 421Mf9oZ091718;
	Sat, 2 Mar 2024 07:41:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sat, 02 Mar 2024 07:41:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 421Mf8l1091714
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 2 Mar 2024 07:41:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1a817eb5-7cd8-44d6-b409-b3bc3f377cb9@I-love.SAKURA.ne.jp>
Date: Sat, 2 Mar 2024 07:41:09 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v3] x86: disable non-instrumented version of copy_page when
 KMSAN is enabled
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Commit afb2d666d025 ("zsmalloc: use copy_page for full page copy") caused
a false-positive KMSAN warning. Implement copy_page() using memcpy() when
KMSAN is enabled.

  BUG: KMSAN: use-after-free in obj_malloc+0x6cc/0x7b0
  Uninit was stored to memory at:
   obj_malloc+0x70a/0x7b0
  Uninit was created at:
   free_unref_page_prepare+0x130/0xfc0

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v3:
  Update description/comment and use include file, suggested by
  Thomas Gleixner.
  
 arch/x86/include/asm/page_64.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index cc6b8e087192..98a71727dbac 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -9,6 +9,7 @@
 #include <asm/alternative.h>
 
 #include <linux/kmsan-checks.h>
+#include <linux/string.h>
 
 /* duplicated to the one in bootmem.h */
 extern unsigned long max_pfn;
@@ -58,7 +59,18 @@ static inline void clear_page(void *page)
 			   : "cc", "memory", "rax", "rcx");
 }
 
+#ifdef CONFIG_KMSAN
+/*
+ * The assembly version of copy_page() is not instrumented and
+ * therefore breaks KMSAN. Fall back to memcpy.
+ */
+static inline void copy_page(void *to, void *from)
+{
+	memcpy(to, from, PAGE_SIZE);
+}
+#else
 void copy_page(void *to, void *from);
+#endif
 
 #ifdef CONFIG_X86_5LEVEL
 /*
-- 
2.34.1

