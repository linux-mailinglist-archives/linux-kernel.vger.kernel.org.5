Return-Path: <linux-kernel+bounces-131514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7928988E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0811C20D8D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDEE128811;
	Thu,  4 Apr 2024 13:37:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C19128362;
	Thu,  4 Apr 2024 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237843; cv=none; b=DVJOBGSnl3/6N8YxZs4J0V0OKxsNraNW6H0VE0JeqYCNgTSIQtgK4m2qZvd8je2A58iWbmy0dDGe5/nsFejYNRPKztr6fByzC3sJpqbtsgctRfM0ruUtcFh8zCS7gZrj/TaJfp9fJw5ZCMjXBcHdX5s6YDICWjv5aoj7F3VXlxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237843; c=relaxed/simple;
	bh=L5JuVTwYjhYNtocqaBlZrcI4/RRu7dj6AmX+ESPnNdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tECuZZQSqTJZjGFrfGiGUROpqWk88vcADcDBNUsLYT10bhsiWJ+aLTaZ4S4UJQWsV72xs3Pt2M0mbKUv26qAUL0SWd8EGqqaEZI3gOrmvyl+/MSVy6apioLTSCYxIWh1eF6elOoe8vg6NAdAI3VYrmVvbktsIB1Tj4gBdPaGpPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1989BC433F1;
	Thu,  4 Apr 2024 13:37:19 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-mm@kvack.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/3] LoongArch: Make virt_addr_valid()/__virt_addr_valid() work with KFENCE
Date: Thu,  4 Apr 2024 21:36:36 +0800
Message-ID: <20240404133642.971583-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404133642.971583-1-chenhuacai@loongson.cn>
References: <20240404133642.971583-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When enabling both CONFIG_KFENCE and CONFIG_DEBUG_SG, I get the
following backtraces when running LongArch kernels.

[    2.496257] kernel BUG at include/linux/scatterlist.h:187!
..
[    2.501925] Call Trace:
[    2.501950] [<9000000004ad59c4>] sg_init_one+0xac/0xc0
[    2.502204] [<9000000004a438f8>] do_test_kpp+0x278/0x6e4
[    2.502353] [<9000000004a43dd4>] alg_test_kpp+0x70/0xf4
[    2.502494] [<9000000004a41b48>] alg_test+0x128/0x690
[    2.502631] [<9000000004a3d898>] cryptomgr_test+0x20/0x40
[    2.502775] [<90000000041b4508>] kthread+0x138/0x158
[    2.502912] [<9000000004161c48>] ret_from_kernel_thread+0xc/0xa4

The backtrace is always similar but not exactly the same. It is always
triggered from cryptomgr_test, but not always from the same test.

Analysis shows that with CONFIG_KFENCE active, the address returned from
kmalloc() and friends is not always below vm_map_base. It is allocated
by kfence_alloc() which at least sometimes seems to get its memory from
an address space above vm_map_base. This causes __virt_addr_valid() to
return false for the affected objects.

Let __virt_addr_valid() return 1 for kfence pool addresses, this make
virt_addr_valid()/__virt_addr_valid() work with KFENCE.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/mm/mmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/loongarch/mm/mmap.c b/arch/loongarch/mm/mmap.c
index a9630a81b38a..89af7c12e8c0 100644
--- a/arch/loongarch/mm/mmap.c
+++ b/arch/loongarch/mm/mmap.c
@@ -4,6 +4,7 @@
  */
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/kfence.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
@@ -111,6 +112,9 @@ int __virt_addr_valid(volatile void *kaddr)
 {
 	unsigned long vaddr = (unsigned long)kaddr;
 
+	if (is_kfence_address((void *)kaddr))
+		return 1;
+
 	if ((vaddr < PAGE_OFFSET) || (vaddr >= vm_map_base))
 		return 0;
 
-- 
2.43.0


