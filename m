Return-Path: <linux-kernel+bounces-129082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640D7896487
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C954B22005
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BED17555;
	Wed,  3 Apr 2024 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=zytor.com header.i=@zytor.com header.b="eCVYGEc7"
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1434C6C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712125853; cv=none; b=QLitmASpi6Afy+cjMegA9hlMBHC8de0sjmgxA27utn+W9p0Z+bOHNQVbvqAbp3B/atFV+BlCvlqZSsMUDIlCbYGnylXckP1oM69lzDrhSYKICeGc6rQCxAqTcAoXKmL65xjbgJpZSLSi7rRKh9jFD1VvHQLhYjvfqANVo/gIS6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712125853; c=relaxed/simple;
	bh=gbtbUqxbaz6VMoeylt37LSG9t554n6QMImJyt1TGVr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kjXLMwt6/ZgBV0+84UDS+4eb6KJlK800VmWmZNyuwzzLs8XC6fk5xruB7zz80h0x4MPCONcWQv4xIfs2bSraUgXr4fik82cvb41Lj5pX4k+mmIQ8YBqnMd3XUPgKiPuNKd43YjUtM77+dyhQ0gLs3TNM06lq80V3pH5u9LKs3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=eCVYGEc7; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4336O46p2956324
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 2 Apr 2024 23:24:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4336O46p2956324
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024031401; t=1712125450;
	bh=oO0Elqz94WP7GY3TrrPoB3tMYCy5mnohKTYdv4otdqc=;
	h=From:To:Cc:Subject:Date:From;
	b=eCVYGEc7rjThZC73vxuoL27CYn2WI0ynm0NSY8UPhQsM8s9Y8qgNFeRC47DovJNOK
	 e4wFkzW7mbjlONSYz3IV/q17wZ8cvNQLd8HToc2o46LcMBT+6FftPyLOIdrfveIh/1
	 Tt9/0Z9rhqDf35bp58P0aPTBmtk4y2PUrA4ENJ1eFFM12f8PFJAf9Sxc2FUsfaACGf
	 JNyfhXZY6fX7gr6bhJS+5jVrktoIeZ4l7kwd1QaBv8w9k2qYy+rvVjoeYVXNnRoNXq
	 7BKPD/v7lhhG2p8I1Du+GTgmryjkM/lKiQus+hOiO142MNqOoM3Vnvhzx2uQxOLZio
	 HwVwM0wjoNSew==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        brgerst@gmail.com
Subject: [PATCH v1 1/1] x86/entry/64: Skip SYSRET validation tests when FRED is enabled
Date: Tue,  2 Apr 2024 23:24:03 -0700
Message-ID: <20240403062404.2956240-1-xin@zytor.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't do SYSRET validation tests when FRED is enabled, since ERETU is
the only legit instruction to return to user level.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/entry/common.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6356060caaf3..1c3944eb9901 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -72,7 +72,7 @@ static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
 	return false;
 }
 
-/* Returns true to return using SYSRET, or false to use IRET */
+/* Returns true to return using SYSRET, or false to use IRET/ERETU */
 __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
 {
 	add_random_kstack_offset();
@@ -88,6 +88,10 @@ __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
 
+	/* No test for FRED, which returns to user level with ERETU only */
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		return false;
+
 	/*
 	 * Check that the register state is valid for using SYSRET to exit
 	 * to userspace.  Otherwise use the slower but fully capable IRET
@@ -325,7 +329,7 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 	return true;
 }
 
-/* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET */
+/* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET/ERETU */
 __visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
 {
 	/*
@@ -346,6 +350,10 @@ __visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
 	if (!__do_fast_syscall_32(regs))
 		return false;
 
+	/* No test for FRED, which returns to user level with ERETU only */
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		return false;
+
 	/*
 	 * Check that the register state is valid for using SYSRETL/SYSEXIT
 	 * to exit to userspace.  Otherwise use the slower but fully capable

base-commit: 65d1240b6728b38e4d2068d6738a17e4ee4351f5
-- 
2.44.0


