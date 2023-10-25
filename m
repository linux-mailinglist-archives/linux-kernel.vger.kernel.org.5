Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E68F7D639E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjJYHkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjJYHkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E317559B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698219488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WPhN4WgWrFt8KJh56S1ds5IuWAdjP+nxTuZMp1+QSOI=;
        b=h6uvDODAFlES7LRFtMUzTHgnQ4AXoq5j6xrcJZjwW2hmTJbmSkVTe3gDQQl3lNn2Y7IOG3
        dNPSV7QL5MQ8HkIa3kkDw6Y/hL9ZIkRuvLDnkGE4/oXXRxPod/402pV5Y+lw5Z5217WC5Y
        CZThRB1jdNemV8Qe3OQxj2roLu6f+uo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-N3W1iORqM6arSQApGlt4PA-1; Wed,
 25 Oct 2023 03:38:05 -0400
X-MC-Unique: N3W1iORqM6arSQApGlt4PA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CE1F3827978;
        Wed, 25 Oct 2023 07:38:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B548A492BD9;
        Wed, 25 Oct 2023 07:38:03 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-hexagon@vger.kernel.org, Brian Cain <bcain@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>
Subject: [PATCH] hexagon: Remove unusable symbols from the ptrace.h uapi
Date:   Wed, 25 Oct 2023 09:38:02 +0200
Message-ID: <20231025073802.117625-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel-internal prototypes, references to current_thread_info()
and code hidden behind a CONFIG_HEXAGON_ARCH_VERSION switch are
certainly not usable in userspace, so this should not reside
in a uapi header. Move the code into an internal version of
ptrace.h instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 I've compile tested it now with a hexagon cross-compiler and the kernel
 compiles fine with this change, so I think this should be good to go.

 arch/hexagon/include/asm/ptrace.h      | 25 +++++++++++++++++++++++++
 arch/hexagon/include/uapi/asm/ptrace.h | 13 -------------
 scripts/headers_install.sh             |  1 -
 3 files changed, 25 insertions(+), 14 deletions(-)
 create mode 100644 arch/hexagon/include/asm/ptrace.h

diff --git a/arch/hexagon/include/asm/ptrace.h b/arch/hexagon/include/asm/ptrace.h
new file mode 100644
index 000000000000..ed35da1ee685
--- /dev/null
+++ b/arch/hexagon/include/asm/ptrace.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Ptrace definitions for the Hexagon architecture
+ *
+ * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _ASM_HEXAGON_PTRACE_H
+#define _ASM_HEXAGON_PTRACE_H
+
+#include <uapi/asm/ptrace.h>
+
+/* kprobe-based event tracer support */
+extern int regs_query_register_offset(const char *name);
+extern const char *regs_query_register_name(unsigned int offset);
+
+#define current_pt_regs() \
+	((struct pt_regs *) \
+	 ((unsigned long)current_thread_info() + THREAD_SIZE) - 1)
+
+#if CONFIG_HEXAGON_ARCH_VERSION >= 4
+#define arch_has_single_step()	(1)
+#endif
+
+#endif
diff --git a/arch/hexagon/include/uapi/asm/ptrace.h b/arch/hexagon/include/uapi/asm/ptrace.h
index f79de05b8689..2a3ea14ad9b9 100644
--- a/arch/hexagon/include/uapi/asm/ptrace.h
+++ b/arch/hexagon/include/uapi/asm/ptrace.h
@@ -29,17 +29,4 @@
 
 #define profile_pc(regs) instruction_pointer(regs)
 
-/* kprobe-based event tracer support */
-extern int regs_query_register_offset(const char *name);
-extern const char *regs_query_register_name(unsigned int offset);
-
-#define current_pt_regs() \
-	((struct pt_regs *) \
-	 ((unsigned long)current_thread_info() + THREAD_SIZE) - 1)
-
-#if CONFIG_HEXAGON_ARCH_VERSION >= 4
-#define arch_has_single_step()	(1)
-#endif
-
-
 #endif
diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index 56d3c338d91d..c3064ac31003 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -74,7 +74,6 @@ arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_16K
 arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_4K
 arch/arc/include/uapi/asm/swab.h:CONFIG_ARC_HAS_SWAPE
 arch/arm/include/uapi/asm/ptrace.h:CONFIG_CPU_ENDIAN_BE8
-arch/hexagon/include/uapi/asm/ptrace.h:CONFIG_HEXAGON_ARCH_VERSION
 arch/hexagon/include/uapi/asm/user.h:CONFIG_HEXAGON_ARCH_VERSION
 arch/m68k/include/uapi/asm/ptrace.h:CONFIG_COLDFIRE
 arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_NO
-- 
2.41.0

