Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F3079F8EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 05:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjINDdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 23:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjINDdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 23:33:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 476021BE2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 20:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694662337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CuyFNbtk2D5ZLNQLEQ3vxhJMzL7nFa+vxdXXthC35r8=;
        b=Fi/3adqoOKVAtk7yKniszuOzaePBjGmv/h7nJDN7mpFcptPw8+6heGrF1OyvbdmHdHXGve
        Ki2/Ohg+B4+ob34q3h6bz95pCKLNJFXDzx/oXEzG2QRphOxLkULZV3V3+d7dX2PeFET+xl
        aODzS5+N1Bo8+I4pyVs2Ubc5kOsmb5o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-VMWE-biJMa2FUkSHDLWytw-1; Wed, 13 Sep 2023 23:32:13 -0400
X-MC-Unique: VMWE-biJMa2FUkSHDLWytw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FC77857A9A;
        Thu, 14 Sep 2023 03:32:12 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7E9510F1BE7;
        Thu, 14 Sep 2023 03:32:08 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, thunder.leizhen@huawei.com,
        catalin.marinas@arm.com, chenjiahao16@huawei.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 5/9] crash_core: move crashk_*res definition into crash_core.c
Date:   Thu, 14 Sep 2023 11:31:38 +0800
Message-ID: <20230914033142.676708-6-bhe@redhat.com>
In-Reply-To: <20230914033142.676708-1-bhe@redhat.com>
References: <20230914033142.676708-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both crashk_res and crashk_low_res are used to mark the reserved
crashkernel regions in iomem_resource tree. And later the generic
crashkernel resrvation will be added into crash_core.c. So move
crashk_res and crashk_low_res definition into crash_core.c to avoid
compiling error if CONFIG_CRASH_CORE=on while CONFIG_KEXEC_CORE is
unset.

Meanwhile include <asm/crash_core.h> in <linux/crash_core.h> if generic
reservation is needed. In that case, <asm/crash_core.h> need be added
by ARCH. In asm/crash_core.h, ARCH can provide its own macro definitions
to override macros in <linux/crash_core.h> if needed. Wrap the including
into CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION ifdeffery scope to
avoid compiling error in other ARCH-es which don't take the generic
reservation way yet.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |  8 ++++++++
 include/linux/kexec.h      |  4 ----
 kernel/crash_core.c        | 16 ++++++++++++++++
 kernel/kexec_core.c        | 17 -----------------
 4 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 4dbd6565e0ff..3c735a7e33fb 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -5,6 +5,14 @@
 #include <linux/linkage.h>
 #include <linux/elfcore.h>
 #include <linux/elf.h>
+#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+#include <asm/crash_core.h>
+#endif
+
+/* Location of a reserved region to hold the crash kernel.
+ */
+extern struct resource crashk_res;
+extern struct resource crashk_low_res;
 
 #define CRASH_CORE_NOTE_NAME	   "CORE"
 #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 32c78078552c..8227455192b7 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -22,10 +22,6 @@
 #include <uapi/linux/kexec.h>
 #include <linux/verification.h>
 
-/* Location of a reserved region to hold the crash kernel.
- */
-extern struct resource crashk_res;
-extern struct resource crashk_low_res;
 extern note_buf_t __percpu *crash_notes;
 
 #ifdef CONFIG_KEXEC_CORE
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index ca66b5f41dc7..ad7dc03f3993 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -35,6 +35,22 @@ u32 *vmcoreinfo_note;
 /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
 static unsigned char *vmcoreinfo_data_safecopy;
 
+/* Location of the reserved area for the crash kernel */
+struct resource crashk_res = {
+	.name  = "Crash kernel",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+	.desc  = IORES_DESC_CRASH_KERNEL
+};
+struct resource crashk_low_res = {
+	.name  = "Crash kernel",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+	.desc  = IORES_DESC_CRASH_KERNEL
+};
+
 /*
  * parsing the "crashkernel" commandline
  *
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 9dc728982d79..be5642a4ec49 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -52,23 +52,6 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
 
-
-/* Location of the reserved area for the crash kernel */
-struct resource crashk_res = {
-	.name  = "Crash kernel",
-	.start = 0,
-	.end   = 0,
-	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
-	.desc  = IORES_DESC_CRASH_KERNEL
-};
-struct resource crashk_low_res = {
-	.name  = "Crash kernel",
-	.start = 0,
-	.end   = 0,
-	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
-	.desc  = IORES_DESC_CRASH_KERNEL
-};
-
 int kexec_should_crash(struct task_struct *p)
 {
 	/*
-- 
2.41.0

