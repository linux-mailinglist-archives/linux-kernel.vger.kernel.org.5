Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434827978D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbjIGQzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjIGQzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:55:52 -0400
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [IPv6:2a02:1800:120:4::f00:11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A1D94
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:55:22 -0700 (PDT)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by gauss.telenet-ops.be (Postfix) with ESMTPS id 4RhL6D0XDgz4x5gx
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:43:00 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c214:2eac:128d:f67e])
        by michel.telenet-ops.be with bizsmtp
        id j1hx2A00K2mGBSJ061hxu1; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002m83-2W;
        Thu, 07 Sep 2023 15:41:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGf-00CMfP-Ac;
        Thu, 07 Sep 2023 15:41:57 +0200
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
Subject: [PATCH 05/52] m68k: kernel: Add and use "ints.h"
Date:   Thu,  7 Sep 2023 15:41:06 +0200
Message-Id: <7bdbe698a2a4a9cd50542499e28fdce80cba4e12.1694093327.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694093327.git.geert@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1:

    arch/m68k/kernel/ints.c:165:17: warning: no previous prototype for ‘handle_badint’ [-Wmissing-prototypes]
      165 | asmlinkage void handle_badint(struct pt_regs *regs)
	  |                 ^~~~~~~~~~~~~

Fix this by introducing a new header file "ints.h" for holding the
prototypes of functions implemented in arch/m68k/kernel/ints.c.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/kernel/ints.c | 2 ++
 arch/m68k/kernel/ints.h | 7 +++++++
 2 files changed, 9 insertions(+)
 create mode 100644 arch/m68k/kernel/ints.h

diff --git a/arch/m68k/kernel/ints.c b/arch/m68k/kernel/ints.c
index 5b8d66fbf3832a2c..cf2b13488476c8c6 100644
--- a/arch/m68k/kernel/ints.c
+++ b/arch/m68k/kernel/ints.c
@@ -26,6 +26,8 @@
 #include <asm/q40ints.h>
 #endif
 
+#include "ints.h"
+
 extern u32 auto_irqhandler_fixup[];
 extern u16 user_irqvec_fixup[];
 
diff --git a/arch/m68k/kernel/ints.h b/arch/m68k/kernel/ints.h
new file mode 100644
index 0000000000000000..ecac6011c1a45489
--- /dev/null
+++ b/arch/m68k/kernel/ints.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/linkage.h>
+
+struct pt_regs;
+
+asmlinkage void handle_badint(struct pt_regs *regs);
-- 
2.34.1

