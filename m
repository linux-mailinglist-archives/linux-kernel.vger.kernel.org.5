Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C725B8031F8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbjLDL5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjLDL5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:57:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477321BD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6FCC433C7;
        Mon,  4 Dec 2023 11:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701691041;
        bh=fRSxX8E7EKRIPQBydKhoEniyM3aLhKn+xL3XzYVaAk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=femcIS3omFfgXtyufGHVJom0uXomMX8jSMxADx9BQCYIjldQAsUEIf8MhP4M978r7
         O7bai8L2nmJW3W8l56yzH9LN3RtLW8Y0TulhUd4noZ38Gr6atBE96UZ1N2ObjY1F4x
         hqu3OmhDd2LYanShqrKOZDDRBLQzSn6unOCaFnNxVXTrlc4L252xz+J2q0/Qy+YIJs
         GGlZ0H2R7AskDgd3KWUtZyW1Gz1LorE2/k+I9ur+2cTDTfYiYfQlt9kt3Li3WR+zJB
         vXjedYrAzAKBdNoLauwN22lUVaZ67lAkiPv3lPxnW9flUNhK1V640WBFjIWiucJ455
         rk+M1ei9P3PpQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-mips@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Stephen Rothwell" <sfr@rothwell.id.au>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: [PATCH 01/20] mips: decompress: fix add missing prototypes
Date:   Mon,  4 Dec 2023 12:56:51 +0100
Message-Id: <20231204115710.2247097-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204115710.2247097-1-arnd@kernel.org>
References: <20231204115710.2247097-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The mips decompressor has some string functions defined locally that are not
declared in the right place:

arch/mips/boot/compressed/dbg.c:12:13: error: no previous prototype for 'putc' [-Werror=missing-prototypes]
arch/mips/boot/compressed/dbg.c:16:6: error: no previous prototype for 'puts' [-Werror=missing-prototypes]
arch/mips/boot/compressed/dbg.c:26:6: error: no previous prototype for 'puthex' [-Werror=missing-prototypes]
arch/mips/boot/compressed/string.c:11:7: error: no previous prototype for 'memcpy' [-Werror=missing-prototypes]
arch/mips/boot/compressed/string.c:22:7: error: no previous prototype for 'memset' [-Werror=missing-prototypes]
arch/mips/boot/compressed/string.c:32:15: error: no previous prototype for 'memmove' [-Werror=missing-prototypes]
arch/mips/boot/compressed/decompress.c:43:6: error: no previous prototype for 'error' [-Werror=missing-prototypes]
arch/mips/boot/compressed/decompress.c:91:6: error: no previous prototype for 'decompress_kernel' [-Werror=missing-prototypes]

Include the string.h header where needed and add a decompress.h header to
have shared prototypes for the rest.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/boot/compressed/dbg.c        |  2 ++
 arch/mips/boot/compressed/decompress.c | 16 ++--------------
 arch/mips/boot/compressed/decompress.h | 24 ++++++++++++++++++++++++
 arch/mips/boot/compressed/string.c     |  1 +
 4 files changed, 29 insertions(+), 14 deletions(-)
 create mode 100644 arch/mips/boot/compressed/decompress.h

diff --git a/arch/mips/boot/compressed/dbg.c b/arch/mips/boot/compressed/dbg.c
index f6728a8fd1c3..2f1ac38fe1cc 100644
--- a/arch/mips/boot/compressed/dbg.c
+++ b/arch/mips/boot/compressed/dbg.c
@@ -9,6 +9,8 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 
+#include "decompress.h"
+
 void __weak putc(char c)
 {
 }
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index c5dd415254d3..adb6d5b0e6eb 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -19,6 +19,8 @@
 #include <asm/unaligned.h>
 #include <asm-generic/vmlinux.lds.h>
 
+#include "decompress.h"
+
 /*
  * These two variables specify the free mem region
  * that can be used for temporary malloc area
@@ -26,20 +28,6 @@
 unsigned long free_mem_ptr;
 unsigned long free_mem_end_ptr;
 
-/* The linker tells us where the image is. */
-extern unsigned char __image_begin[], __image_end[];
-
-/* debug interfaces  */
-#ifdef CONFIG_DEBUG_ZBOOT
-extern void puts(const char *s);
-extern void puthex(unsigned long long val);
-#else
-#define puts(s) do {} while (0)
-#define puthex(val) do {} while (0)
-#endif
-
-extern char __appended_dtb[];
-
 void error(char *x)
 {
 	puts("\n\n");
diff --git a/arch/mips/boot/compressed/decompress.h b/arch/mips/boot/compressed/decompress.h
new file mode 100644
index 000000000000..073b64593b3d
--- /dev/null
+++ b/arch/mips/boot/compressed/decompress.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _DECOMPRESSOR_H
+#define _DECOMPRESSOR_H
+
+/* The linker tells us where the image is. */
+extern unsigned char __image_begin[], __image_end[];
+
+/* debug interfaces  */
+#ifdef CONFIG_DEBUG_ZBOOT
+extern void putc(char c);
+extern void puts(const char *s);
+extern void puthex(unsigned long long val);
+#else
+#define putc(s) do {} while (0)
+#define puts(s) do {} while (0)
+#define puthex(val) do {} while (0)
+#endif
+
+extern char __appended_dtb[];
+
+void error(char *x);
+void decompress_kernel(unsigned long boot_heap_start);
+
+#endif
diff --git a/arch/mips/boot/compressed/string.c b/arch/mips/boot/compressed/string.c
index 0b593b709228..f0eb251e44e5 100644
--- a/arch/mips/boot/compressed/string.c
+++ b/arch/mips/boot/compressed/string.c
@@ -7,6 +7,7 @@
 
 #include <linux/compiler_attributes.h>
 #include <linux/types.h>
+#include <asm/string.h>
 
 void *memcpy(void *dest, const void *src, size_t n)
 {
-- 
2.39.2

