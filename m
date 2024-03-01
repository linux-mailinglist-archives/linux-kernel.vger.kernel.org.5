Return-Path: <linux-kernel+bounces-88096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C24F886DD4C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC0E28688C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6076A013;
	Fri,  1 Mar 2024 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IgxvAT/b"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5710969E11
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282489; cv=none; b=PzQ7LGG2FOHYMZVS+jWSd8s5GTVGtMq0MGyVCpeiISQIOSQrrsP9VXLNXRqIVQurkx75MUrcOTNVbAqS64HrcXH3gHLC9ccPvi0CEXaoZ3QMDy/Co2qGRwVQ+0drsXsxVkxocAhRUZQWXfJ11f6ifMufe6wqu4NOnPOt679xIok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282489; c=relaxed/simple;
	bh=ZU05d8rgL+KouMacXKQ7YsJZM3JuNUeEZVl84wyTLE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5fhMW1Q6YN5O/LkwPL+HuBt/bAzx4NIrgPfDLFN6wcdvyg1BfcmfomMIPDfiVOKeEUk2CSagcY9ZXc+jS0NaLdDVVWGvmppu13LestTOzU3jnVY/oIaE15Hymj1PF6u8MMD8vujGi//LzGoPzBxWEwtIQIeqoi+ZBELTBNGWxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=IgxvAT/b; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4218elje3370386
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 1 Mar 2024 00:40:51 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4218elje3370386
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1709282452;
	bh=XHDUSdp3fzgtKbz1MB2i6kRiFtguTPR1L2wgsX/y370=;
	h=From:To:Cc:Subject:Date:From;
	b=IgxvAT/b5pPtrkD2o+Qs/LXL4q5C7xWmeYT0I0Nsswgzi6K6V9wDP80kZ/ett1+/6
	 +c+7DO2i9jYYDi9XGNQSNs3Hm927ZUR5Sf25qCQaMdFJbJFjokI12uTTYQjxX0zL8F
	 XFf9TuC+fsoEppfz2iSCyrnlc3CLGsfzmqHL3smI5W1EnNadAlpUHuKVYyblQQss2s
	 y0rFAZTyJdE0y8qC7fbKiKIE6VyZp7202CS4p1rkn4luH/VlHEfsIL3VgzUeLByNRY
	 wpSinfHmpQ2TNp3RfbklxovH3aRMMrPwVe8B/VcXrw09CQu5LVmrczq7UDMnzlaKhK
	 OIPCFXhK7wfjQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        brgerst@gmail.com
Subject: [PATCH v1 1/1] x86/fred: Fix init_task thread stack pointer initialization
Date: Fri,  1 Mar 2024 00:40:46 -0800
Message-ID: <20240301084046.3370376-1-xin@zytor.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As TOP_OF_KERNEL_STACK_PADDING is defined as 0 on x86_64, no one noticed
it's missing in the calculation of the .sp field in INIT_THREAD until it
is defined to 16 with CONFIG_X86_FRED=y.

Subtract TOP_OF_KERNEL_STACK_PADDING from the .sp field of INIT_THREAD.

Fixes: 65c9cc9e2c14 ("x86/fred: Reserve space for the FRED stack frame")
Fixes: 3adee777ad0d ("x86/smpboot: Remove initial_stack on 64-bit")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202402262159.183c2a37-lkp@intel.com
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/include/asm/processor.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 26620d7642a9..17fe81998ce4 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -664,8 +664,10 @@ static __always_inline void prefetchw(const void *x)
 #else
 extern unsigned long __end_init_task[];
 
-#define INIT_THREAD {							    \
-	.sp	= (unsigned long)&__end_init_task - sizeof(struct pt_regs), \
+#define INIT_THREAD {							\
+	.sp	= (unsigned long)&__end_init_task -			\
+		  TOP_OF_KERNEL_STACK_PADDING -				\
+		  sizeof(struct pt_regs),				\
 }
 
 extern unsigned long KSTK_ESP(struct task_struct *task);

base-commit: e13841907b8fda0ae0ce1ec03684665f578416a8
-- 
2.44.0


