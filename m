Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C0579EA80
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241323AbjIMOJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241233AbjIMOI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:08:56 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E2B1BD3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f674:9611:cd05:f25a])
        by xavier.telenet-ops.be with bizsmtp
        id lS8n2A0023fvA4V01S8n2c; Wed, 13 Sep 2023 16:08:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXd-003crh-H7;
        Wed, 13 Sep 2023 16:08:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXu-00FV4I-SY;
        Wed, 13 Sep 2023 16:08:46 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Philip Blundell <philb@gnu.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 12/52] m68k: mm: Move paging_init() to common <asm/pgtable.h>
Date:   Wed, 13 Sep 2023 16:08:02 +0200
Message-Id: <1b03fde54f205e972e19959b8e335022205d538c.1694613528.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694613528.git.geert@linux-m68k.org>
References: <cover.1694613528.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1:

    arch/m68k/mm/motorola.c:414:13: warning: no previous prototype for ‘paging_init’ [-Wmissing-prototypes]
      414 | void __init paging_init(void)
	  |             ^~~~~~~~~~~
    arch/m68k/mm/sun3mmu.c:36:13: warning: no previous prototype for ‘paging_init’ [-Wmissing-prototypes]
       36 | void __init paging_init(void)
	  |             ^~~~~~~~~~~

Fix this by consolidating the multiple prototypes into the common
<asm/pgtable.h>.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/m68k/include/asm/pgtable.h    | 9 +++++++++
 arch/m68k/include/asm/pgtable_no.h | 1 -
 arch/m68k/kernel/setup_mm.c        | 2 --
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/include/asm/pgtable.h b/arch/m68k/include/asm/pgtable.h
index ad15d655a9bfb3b5..27525c6a12fd0c7f 100644
--- a/arch/m68k/include/asm/pgtable.h
+++ b/arch/m68k/include/asm/pgtable.h
@@ -1,6 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __M68K_PGTABLE_H
+#define __M68K_PGTABLE_H
+
 #ifdef __uClinux__
 #include <asm/pgtable_no.h>
 #else
 #include <asm/pgtable_mm.h>
 #endif
+
+#ifndef __ASSEMBLY__
+extern void paging_init(void);
+#endif
+
+#endif /* __M68K_PGTABLE_H */
diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
index fc044df52b96c149..1a86c15b9008f03d 100644
--- a/arch/m68k/include/asm/pgtable_no.h
+++ b/arch/m68k/include/asm/pgtable_no.h
@@ -28,7 +28,6 @@
 #define PAGE_READONLY	__pgprot(0)
 #define PAGE_KERNEL	__pgprot(0)
 
-extern void paging_init(void);
 #define swapper_pg_dir ((pgd_t *) 0)
 
 /*
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index 6f1ae01f322cf231..10310b04f77d8d79 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -107,8 +107,6 @@ EXPORT_SYMBOL(isa_sex);
 
 #define MASK_256K 0xfffc0000
 
-extern void paging_init(void);
-
 static void __init m68k_parse_bootinfo(const struct bi_record *record)
 {
 	const struct bi_record *first_record = record;
-- 
2.34.1

