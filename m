Return-Path: <linux-kernel+bounces-136792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F0789D834
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73EC51C22017
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD1512D20E;
	Tue,  9 Apr 2024 11:37:58 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010AD128826
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662678; cv=none; b=QDC5Un3MaSt3nkYZeN84nNO7dfhdVDq+0gy6EgnyjuppsitgWi2g7yiE7tAK/BOin3pQbvmsYv97ENWVk7G9V/snZNK69OPifkDORc0fW0yYBkCN+XB2DjLY7e63UqQwWOhP/9/2GzwoO84DCEeiKqcPousBa5PTPWZWNDzZb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662678; c=relaxed/simple;
	bh=Zr6aCdpoCKG0P7Z6ungADoq81IHnDx/2r+SXS7k/pMM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h+WUOR823kpmjqKdCfYmajg0qL4eK80b2qr4N3hDUOzysgeyAPcoS6LPEb58DSnObeizpAMC4B0gEVgVqo4N6pBq349y3RDqlLlkMxXWxan6+t6zDYdRLatN7LFGhokNS97+m0uvSE8GpecX4bDgzA54C1SST/d4kWlv/KnzXaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VDP5H4BRlzwRjB;
	Tue,  9 Apr 2024 19:34:59 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (unknown [7.193.23.54])
	by mail.maildlp.com (Postfix) with ESMTPS id 058691400FD;
	Tue,  9 Apr 2024 19:37:54 +0800 (CST)
Received: from Linux-SUSE12SP5.huawei.com (10.67.136.233) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 19:37:53 +0800
From: zhuqiuer <zhuqiuer1@huawei.com>
To: <linux@armlinux.org.uk>, <nathan@kernel.org>,
	<"ndesaulniers@google.commorbo"@google.com>, <morbo@google.com>,
	<justinstitt@google.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<zhuqiuer1@huawei.com>
Subject: [PATCH] ARM: Add a memory clobber to the fmrx instruction
Date: Tue, 9 Apr 2024 19:37:49 +0800
Message-ID: <20240409113749.4438-1-zhuqiuer1@huawei.com>
X-Mailer: git-send-email 2.12.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600014.china.huawei.com (7.193.23.54)

The instruction fmrx is used throughout the kernel,
where it is sometimes expected to be skipped
by incrementing the program counter, such as in vfpmodule.c:vfp_init().
Therefore, the instruction should not be reordered when it is not intended.
Adding a barrier() instruction before and after this call cannot prevent
reordering by the compiler, as the fmrx instruction is constrained
by '=r', meaning it works on the general register but not on memory.
To ensure the order of the instruction after compiling,
adding a memory clobber is necessary.

Below is the code snippet disassembled from the method:
vfpmodule.c:vfp_init(), compiled by LLVM.

Before the patching:
xxxxx:   xxxxx    bl  c010c688 <register_undef_hook>
xxxxx:   xxxxx    mov r0, r4
xxxxx:   xxxxx    bl  c010c6e4 <unregister_undef_hook>
..
xxxxx:   xxxxx    bl  c0791c8c <printk>
xxxxx:   xxxxx    movw    r5, #23132  ; 0x5a5c
xxxxx:   xxxxx    vmrs    r4, fpsid  <- this is the fmrx instruction

After the patching:
xxxxx:   xxxxx    bl  c010c688 <register_undef_hook>
xxxxx:   xxxxx    mov r0, r4
xxxxx:   xxxxx    vmrs    r5, fpsid  <- this is the fmrx instruction
xxxxx:   xxxxx    bl  c010c6e4 <unregister_undef_hook>

Signed-off-by: zhuqiuer <zhuqiuer1@huawei.com>
---
 arch/arm/vfp/vfpinstr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
index 3c7938fd40aa..e70129e10b8e 100644
--- a/arch/arm/vfp/vfpinstr.h
+++ b/arch/arm/vfp/vfpinstr.h
@@ -68,7 +68,7 @@
 	u32 __v;			\
 	asm(".fpu	vfpv2\n"	\
 	    "vmrs	%0, " #_vfp_	\
-	    : "=r" (__v) : : "cc");	\
+	    : "=r" (__v) : : "memory", "cc");	\
 	__v;				\
  })
 
-- 
2.12.3


