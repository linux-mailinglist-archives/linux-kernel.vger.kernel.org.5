Return-Path: <linux-kernel+bounces-137851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AA889E842
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC525B2159D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D538944E;
	Wed, 10 Apr 2024 02:41:41 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E661C0DF7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712716901; cv=none; b=DkCKKG+AhGkLjqHE6Z+04GM9cw+x/RkQKkiC2B4M6t17lkoKKHiEQEZjR1WEI6sYmUzNDqFJET+Hn86WykZIylu2O8WT3PM2gdMAw4vYc6MNfGtlczKRy3TTb2miGboGZ1feH/FH2dZleB3AIYZyhhyB+dpMSAGO4w2WQxgr1W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712716901; c=relaxed/simple;
	bh=JP4edOYcvTr2nOSePK/AZ4E/aJzYBM/Vm8VtB3E6TfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QmruOM8eYA/SGIjJVXAP48l1j0PVS3ZFhL5JyEP8WliaSFxMBkNXDWlHVnNCaN+eZLOL94ykcKJX1UOPEjLmwAfMdfzLl7PuDRIqQ0HXRSH1MHbH8FbT7aiIlhFANnPQoKu36FyEYSsdktwXA7MVKaQeZmhrd/RiExGRmoRnmPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VDnBV6gS9z1GGgj;
	Wed, 10 Apr 2024 10:40:50 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (unknown [7.193.23.54])
	by mail.maildlp.com (Postfix) with ESMTPS id A0EAE14010C;
	Wed, 10 Apr 2024 10:41:36 +0800 (CST)
Received: from Linux-SUSE12SP5.huawei.com (10.67.136.233) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 10:41:36 +0800
From: zhuqiuer <zhuqiuer1@huawei.com>
To: <nathan@kernel.org>
CC: <ardb@kernel.org>, <justinstitt@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux@armlinux.org.uk>, <llvm@lists.linux.dev>, <morbo@google.com>,
	<ndesaulniers@google.com>, <zhuqiuer1@huawei.com>
Subject: [PATCH v2] ARM: Add a memory clobber to the fmrx instruction
Date: Wed, 10 Apr 2024 10:41:26 +0800
Message-ID: <20240410024126.21589-2-zhuqiuer1@huawei.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20240410024126.21589-1-zhuqiuer1@huawei.com>
References: <20240409164641.GC3219862@dev-arch.thelio-3990X>
 <20240410024126.21589-1-zhuqiuer1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
 arch/arm/vfp/vfpinstr.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
index 3c7938fd40aa..ae2c9b9b7701 100644
--- a/arch/arm/vfp/vfpinstr.h
+++ b/arch/arm/vfp/vfpinstr.h
@@ -68,14 +68,14 @@
 	u32 __v;			\
 	asm(".fpu	vfpv2\n"	\
 	    "vmrs	%0, " #_vfp_	\
-	    : "=r" (__v) : : "cc");	\
+	    : "=r" (__v) : : "memory", "cc");	\
 	__v;				\
  })
 
 #define fmxr(_vfp_,_var_)		\
 	asm(".fpu	vfpv2\n"	\
 	    "vmsr	" #_vfp_ ", %0"	\
-	   : : "r" (_var_) : "cc")
+	   : : "r" (_var_) : "memory", "cc")
 
 #else
 
-- 
2.12.3


