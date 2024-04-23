Return-Path: <linux-kernel+bounces-155233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAF08AE731
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD1E1F26363
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C616130AEE;
	Tue, 23 Apr 2024 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="2LHNAiGx"
Received: from out0-197.mail.aliyun.com (out0-197.mail.aliyun.com [140.205.0.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F3A126F10
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877153; cv=none; b=ovis45ZmwptW1EE6QGrT6VTkYiWLnXZhFhVXsTZlNIGj0FDZ9bTUoafEg3jrvM0Eb8d7HQK+GuZdbLODg4aOsMcVacwmyV9OXCP9WZkebIf2I2SAYAKl4IRg3121xUzT2iBKCPjikK8lSIn1mSIieuly3VO/jbz/vCN30MFxgSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877153; c=relaxed/simple;
	bh=cxe3FA+juKRwuhcRoo2BgZ+cSuJhZPREFLKbwZ0iAbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sA7r/tXytsoY5eQAihL30IpGcb2Cxmpwy4PCuKEUzW40iYmoZ3Op3laU1E802s9av/ZIjd+x1N3a86Ig6ZubVPMhzHnWjPL+SUkEW0IlLuXYZfMgob5KiDhtSgzmBaYnKEBQGi6vwziTFEXsxb172yoDgk8tfO+qTyTIQprMdng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=2LHNAiGx; arc=none smtp.client-ip=140.205.0.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713877148; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ztht0K4jTp/9L7ckF5yEd/2TUV3jSzUX1GNvcqyFTsA=;
	b=2LHNAiGxxXWVyrfk1Z3pfDvNMuuasRGBT+aBh8LC0qgnODd99QFY+ZR3EYoH353MzQB84J/bE7vtlg5NgosZniY+r1UnoXv6PftQDG86OU8AMAYieiC8Ah7i4DHxJ8/ETXEMTNYI80bsTs8VJ6QS8RikOIb00o9+SVU/Tew9E4U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047194;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJXNjST_1713877147;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJXNjST_1713877147)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 20:59:07 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 3/7] um: Fix the -Wmissing-prototypes warning for get_thread_reg
Date: Tue, 23 Apr 2024 20:58:54 +0800
Message-Id: <20240423125858.137709-4-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423125858.137709-1-tiwei.btw@antgroup.com>
References: <20240423125858.137709-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_thread_reg function is defined in the user code, and is
called by the kernel code. It should be declared in a shared header.

Fixes: dbba7f704aa0 ("um: stop polluting the namespace with registers.h contents")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/processor-generic.h | 1 -
 arch/x86/um/shared/sysdep/archsetjmp.h  | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 6c3779541845..5a7c05275aa7 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -94,7 +94,6 @@ extern struct cpuinfo_um boot_cpu_data;
 #define current_cpu_data boot_cpu_data
 #define cache_line_size()	(boot_cpu_data.cache_alignment)
 
-extern unsigned long get_thread_reg(int reg, jmp_buf *buf);
 #define KSTK_REG(tsk, reg) get_thread_reg(reg, &tsk->thread.switch_buf)
 extern unsigned long __get_wchan(struct task_struct *p);
 
diff --git a/arch/x86/um/shared/sysdep/archsetjmp.h b/arch/x86/um/shared/sysdep/archsetjmp.h
index 166cedbab926..8c81d1a604a9 100644
--- a/arch/x86/um/shared/sysdep/archsetjmp.h
+++ b/arch/x86/um/shared/sysdep/archsetjmp.h
@@ -1,6 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __X86_UM_SYSDEP_ARCHSETJMP_H
+#define __X86_UM_SYSDEP_ARCHSETJMP_H
+
 #ifdef __i386__
 #include "archsetjmp_32.h"
 #else
 #include "archsetjmp_64.h"
 #endif
+
+unsigned long get_thread_reg(int reg, jmp_buf *buf);
+
+#endif /* __X86_UM_SYSDEP_ARCHSETJMP_H */
-- 
2.34.1


