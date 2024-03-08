Return-Path: <linux-kernel+bounces-96507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8402D875D3D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E270C2825B9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDF12DF9C;
	Fri,  8 Mar 2024 04:45:17 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D8C1E487
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 04:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709873116; cv=none; b=D9HqH9pOF+Oi5ZGI/gO2szmvTVAs8RdRH8j71sZ7O//VZAib/sN2aWle9IXIM+96XaDKXg4lenlJviJO914VBx28BPP1XtOhzKIDFAGuD+vhi0xc20F5w6otqmjMaOSCNEczm24dynAcEJj4BSdn+5+Yfp1IB8Ct5kPu9KR/Ro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709873116; c=relaxed/simple;
	bh=Hf1XWUB1fz27uQAd3k10izX6ave3Sc00He5qxOo1P70=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iFX2mc/DcJJbxZqn+sxlIQM9Hwj+cMnoOetzOHFIo8opeMhGKyxnSTJamRULGHiENVPgVMlCPKoA6ksdXNUpKcj40t7gfgaXx6ZbdvDTq2tMdVPXZm3c4RJD3Ghy6hsEiE+lp7Pb7n90zehUBVKfwRfG/ibNGDenqYBCGvIHiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TrYSS3T7zz2BfcD;
	Fri,  8 Mar 2024 12:42:48 +0800 (CST)
Received: from kwepemd500003.china.huawei.com (unknown [7.221.188.36])
	by mail.maildlp.com (Postfix) with ESMTPS id 28E4014040F;
	Fri,  8 Mar 2024 12:45:11 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd500003.china.huawei.com (7.221.188.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 8 Mar 2024 12:45:10 +0800
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 8 Mar 2024 12:45:09 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<kasan-dev@googlegroups.com>, Changbin Du <changbin.du@huawei.com>
Subject: [PATCH] x86: kmsan: fix boot failure due to instrumentation
Date: Fri, 8 Mar 2024 12:44:01 +0800
Message-ID: <20240308044401.1120395-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100011.china.huawei.com (7.221.188.204)

Instrumenting sev.c and mem_encrypt_identity.c with KMSAN will result in
kernel being unable to boot. Some of the code are invoked too early in
boot stage that before kmsan is ready.

This change disable kmsan instrumentation for above two files to fix the
boot failure.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 arch/x86/kernel/Makefile | 1 +
 arch/x86/mm/Makefile     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0000325ab98f..04591d0145e0 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -33,6 +33,7 @@ KASAN_SANITIZE_sev.o					:= n
 KCSAN_SANITIZE := n
 KMSAN_SANITIZE_head$(BITS).o				:= n
 KMSAN_SANITIZE_nmi.o					:= n
+KMSAN_SANITIZE_sev.o					:= n
 
 # If instrumentation of the following files is enabled, boot hangs during
 # first second.
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index c80febc44cd2..6ec103bedcf1 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -16,6 +16,7 @@ KASAN_SANITIZE_pgprot.o		:= n
 KCSAN_SANITIZE := n
 # Avoid recursion by not calling KMSAN hooks for CEA code.
 KMSAN_SANITIZE_cpu_entry_area.o := n
+KMSAN_SANITIZE_mem_encrypt_identity.o := n
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_mem_encrypt.o		= -pg
-- 
2.25.1


