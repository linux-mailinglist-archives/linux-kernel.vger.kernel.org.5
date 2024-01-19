Return-Path: <linux-kernel+bounces-31279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D079A832BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4B34B2318B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15B654BCA;
	Fri, 19 Jan 2024 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAY2/lmG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E7F54650
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676007; cv=none; b=gNhhJkgvVerib6j2x3F1C2wAVU8H026H4kCiNK2rHUvnl2YBCTf+pgjrBr9BP2OjgbcArHm7uE7WGEY1ObXYrU6Q2A9Z23DuZ8zpcsHVjabBUTwgJAva0rBaD4WIPTp6FFOCsgCeFp5IvsjC6ooG3GlgDn5yQix/J3KoLg4A3o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676007; c=relaxed/simple;
	bh=Jw7BcSkg+fkI0cJf+FHKdJvseRkkfHEF7sMWUXh86Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=Zv/FPohwDINyeoZCPaGzBIpMqu9Bi9zj03+polENlxEzSYDW8UlOpa7sKwwBm+fkZHOICpiYnv8cQA24ZUSC+12f5tqAvVSSdbtR+HDhkFsogXupmELJXmmwfwqJ8JOLeJAB/goeTdAb+ARFH3jsbGxb6sz7pV0dZ0eFI7Y1uIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAY2/lmG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705676004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7S3FI85k6ctO+BbrXXBIV/RwVoqMqQpFkEo8oxKhpCE=;
	b=JAY2/lmGbXteVpg24ONlIrEEEyqO4rckGA0Vl7TAzlRzGPm4A/oZ6lAyBNG9XIrvxRee82
	BBKkActo4bE8EfHzKiGn0jS/NYl6suAI3CTEZ9+wCtxROismkFHI9tJla9jsZdYU4zpXmo
	XK88Bh2/Jz2yCRQPspFYe99ev9rQNac=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-bX-7zOb-MIWHGXFxchsW9g-1; Fri,
 19 Jan 2024 09:53:19 -0500
X-MC-Unique: bX-7zOb-MIWHGXFxchsW9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB4FB3C11CC4;
	Fri, 19 Jan 2024 14:53:18 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 992D351D5;
	Fri, 19 Jan 2024 14:53:09 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev,
	akpm@linux-foundation.org,
	ebiederm@xmission.com,
	hbathini@linux.ibm.com,
	piliu@redhat.com,
	viro@zeniv.linux.org.uk,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 03/14] crash: remove dependency of FA_DUMP on CRASH_DUMP
Date: Fri, 19 Jan 2024 22:52:30 +0800
Message-ID: <20240119145241.769622-4-bhe@redhat.com>
In-Reply-To: <20240119145241.769622-1-bhe@redhat.com>
References: <20240119145241.769622-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

In kdump kernel, /proc/vmcore is an elf file mapping the crashed kernel's
old memory content. Its elf header is constructed in 1st kernel and passed
to kdump kernel via elfcorehdr_addr. Config CRASH_DUMP enables the code
of 1st kernel's old memory accessing in different architectures.

Currently, config FA_DUMP has dependency on CRASH_DUMP because fadump
needs access global variable 'elfcorehdr_addr' to judge if it's in
kdump kernel within function is_kdump_kernel(). In the current
kernel/crash_dump.c, variable 'elfcorehdr_addr' is defined, and function
setup_elfcorehdr() used to parse kernel parameter to fetch the passed
value of elfcorehdr_addr. Only for accessing elfcorehdr_addr, FA_DUMP
really doesn't have to depends on CRASH_DUMP.

To remove the dependency of FA_DUMP on CRASH_DUMP to avoid confusion,
rename kernel/crash_dump.c to kernel/elfcorehdr.c, and build it when
CONFIG_VMCORE_INFO is ebabled. With this, FA_DUMP doesn't need to depend
on CRASH_DUMP.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/powerpc/Kconfig                  | 1 -
 kernel/Makefile                       | 3 +--
 kernel/{crash_dump.c => elfcorehdr.c} | 0
 kernel/kexec_internal.h               | 2 ++
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename kernel/{crash_dump.c => elfcorehdr.c} (100%)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1520146d7c2c..1cdb8fdd3735 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -692,7 +692,6 @@ config FA_DUMP
 	depends on PPC64 && (PPC_RTAS || PPC_POWERNV)
 	select VMCORE_INFO
 	select CRASH_RESERVE
-	select CRASH_DUMP
 	help
 	  A robust mechanism to get reliable kernel crash dump with
 	  assistance from firmware. This approach does not use kexec,
diff --git a/kernel/Makefile b/kernel/Makefile
index 649272a1d6b9..35abc65e1f1a 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -68,7 +68,7 @@ obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_KALLSYMS_SELFTEST) += kallsyms_selftest.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
-obj-$(CONFIG_VMCORE_INFO) += vmcore_info.o
+obj-$(CONFIG_VMCORE_INFO) += vmcore_info.o elfcorehdr.o
 obj-$(CONFIG_CRASH_RESERVE) += crash_reserve.o
 obj-$(CONFIG_KEXEC_CORE) += kexec_core.o crash_core.o
 obj-$(CONFIG_KEXEC) += kexec.o
@@ -121,7 +121,6 @@ obj-$(CONFIG_PERF_EVENTS) += events/
 
 obj-$(CONFIG_USER_RETURN_NOTIFIER) += user-return-notifier.o
 obj-$(CONFIG_PADATA) += padata.o
-obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_JUMP_LABEL) += jump_label.o
 obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
 obj-$(CONFIG_TORTURE_TEST) += torture.o
diff --git a/kernel/crash_dump.c b/kernel/elfcorehdr.c
similarity index 100%
rename from kernel/crash_dump.c
rename to kernel/elfcorehdr.c
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 74da1409cd14..2595defe8c0d 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -4,6 +4,8 @@
 
 #include <linux/kexec.h>
 
+struct kexec_segment;
+
 struct kimage *do_kimage_alloc_init(void);
 int sanity_check_segment_list(struct kimage *image);
 void kimage_free_page_list(struct list_head *list);
-- 
2.41.0


