Return-Path: <linux-kernel+bounces-119478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AC988C97F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266001F81F08
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09E81BC57;
	Tue, 26 Mar 2024 16:36:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEF918EB0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471000; cv=none; b=bH5Jb4LOHWeiSl6I48Ct9+cThkcy6IpG9ZlS4cWub5PcNe3lgH840u1aggTECUYvOJT+RPBq5nbmrg/+w5gy5yjp2iE0dA6qErqRrChnTo98zCi26suczlqUomGldSg+nllSSvttSK/IMFDgy4L7FetA0wpyVBpQ3DCExnGoQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471000; c=relaxed/simple;
	bh=QUwI2RCMWuIgtyxjD85G7dzGZd5QakpCU9SqOUS/EmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o3nBTNY1VhGZOnLjcwjDVx3LWnjGGh1WZO6wtqckKMYAYumFELEmoMIGyRHuZ2NJoGcZQuk1iklD88rpo2oGf8Hzj3rN4ZO0ylgU7iHswbhx0p+bDmKBoP3HKegE9xRD9QDl6QYYVauNWuj73FEyt6nWASYaYahLqKPJZbAVtEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CD22339;
	Tue, 26 Mar 2024 09:37:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2AAD73F694;
	Tue, 26 Mar 2024 09:36:34 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: agordeev@linux.ibm.com,
	anil.s.keshavamurthy@intel.com,
	aou@eecs.berkeley.edu,
	bp@alien8.de,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	jarkko@kernel.org,
	jcalvinowens@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	mark.rutland@arm.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	tglx@linutronix.de,
	will@kernel.org
Subject: [PATCH 1/4] arm64: patching: always use fixmap
Date: Tue, 26 Mar 2024 16:36:21 +0000
Message-Id: <20240326163624.3253157-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240326163624.3253157-1-mark.rutland@arm.com>
References: <20240326163624.3253157-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For historical reasons, patch_map() won't bother to fixmap non-image
addresses when CONFIG_STRICT_MODULE_RWX=n, matching the behaviour prior
to the introduction of CONFIG_STRICT_MODULE_RWX. However, as arm64
doesn't select CONFIG_ARCH_OPTIONAL_KERNEL_RWX, CONFIG_MODULES implies
CONFIG_STRICT_MODULE_RWX, so any kernel built with module support will
use the fixmap for any non-image address.

Historically we only used patch_map() for the kernel image and modules,
but these days its also used by BPF and KPROBES to write to read-only
pages of executable text. Currently these both depend on CONFIG_MODULES,
but we'd like to change that in subsequent patches, which will require
using the fixmap regardless of CONFIG_STRICT_MODULE_RWX.

This patch changes patch_map() to always use the fixmap, and simplifies
the logic.

* Use is_image_text() directly in the if-else, rather than using a
  temporary boolean variable.

* Use offset_in_page() to get the offset within the mapping.

* Remove uintaddr and cast the address directly when using
  is_image_text().

For kernels built with CONFIG_MODULES=y, there should be no functional
change as a result of this patch. For kernels built with
CONFIG_MODULES=n, patch_map() will use the fixmap for non-image
addresses, but there are no extant users with non-image addresses when
CONFIG_MODULES=n.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/patching.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
index 2555349303684..f0f3a2a82ca5a 100644
--- a/arch/arm64/kernel/patching.c
+++ b/arch/arm64/kernel/patching.c
@@ -30,20 +30,16 @@ static bool is_image_text(unsigned long addr)
 
 static void __kprobes *patch_map(void *addr, int fixmap)
 {
-	unsigned long uintaddr = (uintptr_t) addr;
-	bool image = is_image_text(uintaddr);
 	struct page *page;
 
-	if (image)
+	if (is_image_text((unsigned long)addr))
 		page = phys_to_page(__pa_symbol(addr));
-	else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
-		page = vmalloc_to_page(addr);
 	else
-		return addr;
+		page = vmalloc_to_page(addr);
 
 	BUG_ON(!page);
 	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
-			(uintaddr & ~PAGE_MASK));
+					 offset_in_page(addr));
 }
 
 static void __kprobes patch_unmap(int fixmap)
-- 
2.30.2


