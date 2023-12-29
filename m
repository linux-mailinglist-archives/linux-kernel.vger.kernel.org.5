Return-Path: <linux-kernel+bounces-12983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C030281FDFA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4D11F21889
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9736B6FA9;
	Fri, 29 Dec 2023 08:02:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C39563BD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 08:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2140C433C8;
	Fri, 29 Dec 2023 08:02:31 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Youling Tang <tangyouling@kylinos.cn>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] kdump: Defer the insertion of crashkernel resources
Date: Fri, 29 Dec 2023 16:02:13 +0800
Message-Id: <20231229080213.2622204-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In /proc/iomem, sub-regions should be inserted after their parent,
otherwise the insertion of parent resource fails. But after generic
crashkernel reservation applied, in both RISC-V and ARM64 (LoongArch
will also use generic reservation later on), crashkernel resources are
inserted before their parent, which causes the parent disappear in
/proc/iomem. So we defer the insertion of crashkernel resources to an
early_initcall().

1, Without 'crashkernel' parameter:

 100d0100-100d01ff : LOON0001:00
   100d0100-100d01ff : LOON0001:00 LOON0001:00
 100e0000-100e0bff : LOON0002:00
   100e0000-100e0bff : LOON0002:00 LOON0002:00
 1fe001e0-1fe001e7 : serial
 90400000-fa17ffff : System RAM
   f6220000-f622ffff : Reserved
   f9ee0000-f9ee3fff : Reserved
   fa120000-fa17ffff : Reserved
 fa190000-fe0bffff : System RAM
   fa190000-fa1bffff : Reserved
 fe4e0000-47fffffff : System RAM
   43c000000-441ffffff : Reserved
   47ff98000-47ffa3fff : Reserved
   47ffa4000-47ffa7fff : Reserved
   47ffa8000-47ffabfff : Reserved
   47ffac000-47ffaffff : Reserved
   47ffb0000-47ffb3fff : Reserved

2, With 'crashkernel' parameter, before this patch:

 100d0100-100d01ff : LOON0001:00
   100d0100-100d01ff : LOON0001:00 LOON0001:00
 100e0000-100e0bff : LOON0002:00
   100e0000-100e0bff : LOON0002:00 LOON0002:00
 1fe001e0-1fe001e7 : serial
 e6200000-f61fffff : Crash kernel
 fa190000-fe0bffff : System RAM
   fa190000-fa1bffff : Reserved
 fe4e0000-47fffffff : System RAM
   43c000000-441ffffff : Reserved
   47ff98000-47ffa3fff : Reserved
   47ffa4000-47ffa7fff : Reserved
   47ffa8000-47ffabfff : Reserved
   47ffac000-47ffaffff : Reserved
   47ffb0000-47ffb3fff : Reserved

3, With 'crashkernel' parameter, after this patch:

 100d0100-100d01ff : LOON0001:00
   100d0100-100d01ff : LOON0001:00 LOON0001:00
 100e0000-100e0bff : LOON0002:00
   100e0000-100e0bff : LOON0002:00 LOON0002:00
 1fe001e0-1fe001e7 : serial
 90400000-fa17ffff : System RAM
   e6200000-f61fffff : Crash kernel
   f6220000-f622ffff : Reserved
   f9ee0000-f9ee3fff : Reserved
   fa120000-fa17ffff : Reserved
 fa190000-fe0bffff : System RAM
   fa190000-fa1bffff : Reserved
 fe4e0000-47fffffff : System RAM
   43c000000-441ffffff : Reserved
   47ff98000-47ffa3fff : Reserved
   47ffa4000-47ffa7fff : Reserved
   47ffa8000-47ffabfff : Reserved
   47ffac000-47ffaffff : Reserved
   47ffb0000-47ffb3fff : Reserved

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 kernel/crash_core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d4313b53837e..755d8d4ef5b0 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -377,7 +377,6 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
 
 	crashk_low_res.start = low_base;
 	crashk_low_res.end   = low_base + low_size - 1;
-	insert_resource(&iomem_resource, &crashk_low_res);
 #endif
 	return 0;
 }
@@ -459,8 +458,19 @@ void __init reserve_crashkernel_generic(char *cmdline,
 
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
-	insert_resource(&iomem_resource, &crashk_res);
 }
+
+static __init int insert_crashkernel_resources(void)
+{
+	if (crashk_res.start < crashk_res.end)
+		insert_resource(&iomem_resource, &crashk_res);
+
+	if (crashk_low_res.start < crashk_low_res.end)
+		insert_resource(&iomem_resource, &crashk_low_res);
+
+	return 0;
+}
+early_initcall(insert_crashkernel_resources);
 #endif
 
 int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-- 
2.39.3


