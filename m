Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392E877F983
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352179AbjHQOpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352230AbjHQOpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:45:05 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AFB2727
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:45:01 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d85a:258d:2c59:b44])
        by laurent.telenet-ops.be with bizsmtp
        id aeky2A00F4QHFyo01ekyyt; Thu, 17 Aug 2023 16:44:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWeF1-000u8r-8W;
        Thu, 17 Aug 2023 16:44:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWeF8-007SBg-PI;
        Thu, 17 Aug 2023 16:44:58 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 6/6] m68k: math-emu: Add missing prototypes
Date:   Thu, 17 Aug 2023 16:44:53 +0200
Message-Id: <96c039640d76973ea762d79018de0bc75bbdc1dc.1692283195.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692283195.git.geert@linux-m68k.org>
References: <cover.1692283195.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1:

    arch/m68k/math-emu/fp_arith.c:301:16: warning: no previous prototype for ‘fp_fsglmul’ [-Wmissing-prototypes]
      301 | struct fp_ext *fp_fsglmul(struct fp_ext *dest, struct fp_ext *src)
	  |                ^~~~~~~~~~
    arch/m68k/math-emu/fp_arith.c:357:16: warning: no previous prototype for ‘fp_fsgldiv’ [-Wmissing-prototypes]
      357 | struct fp_ext *fp_fsgldiv(struct fp_ext *dest, struct fp_ext *src)
	  |                ^~~~~~~~~~
      CC      arch/m68k/math-emu/fp_log.o
    ...

Fix this by adding the missing prototypes to header files.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20230810141947.1236730-17-arnd@kernel.org/
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/math-emu/fp_arith.h |  2 ++
 arch/m68k/math-emu/fp_log.c   |  1 +
 arch/m68k/math-emu/fp_log.h   | 44 +++++++++++++++++++++++++++++++++++
 arch/m68k/math-emu/fp_trig.h  | 19 +++++++++++++++
 4 files changed, 66 insertions(+)
 create mode 100644 arch/m68k/math-emu/fp_log.h

diff --git a/arch/m68k/math-emu/fp_arith.h b/arch/m68k/math-emu/fp_arith.h
index 65b11e3f452db9d6..3f9c58b6d504f590 100644
--- a/arch/m68k/math-emu/fp_arith.h
+++ b/arch/m68k/math-emu/fp_arith.h
@@ -26,6 +26,8 @@ struct fp_ext *fp_fcmp(struct fp_ext *dest, struct fp_ext *src);
 struct fp_ext *fp_ftst(struct fp_ext *dest, struct fp_ext *src);
 struct fp_ext *fp_fmul(struct fp_ext *dest, struct fp_ext *src);
 struct fp_ext *fp_fdiv(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fsglmul(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fsgldiv(struct fp_ext *dest, struct fp_ext *src);
 
 /* ones that do rounding and integer conversions */
 struct fp_ext *fp_fmod(struct fp_ext *dest, struct fp_ext *src);
diff --git a/arch/m68k/math-emu/fp_log.c b/arch/m68k/math-emu/fp_log.c
index 9f93efd5ef496770..71a8fc25575af810 100644
--- a/arch/m68k/math-emu/fp_log.c
+++ b/arch/m68k/math-emu/fp_log.c
@@ -17,6 +17,7 @@
 
 #include "fp_arith.h"
 #include "fp_emu.h"
+#include "fp_log.h"
 
 static const struct fp_ext fp_one = {
 	.exp = 0x3fff,
diff --git a/arch/m68k/math-emu/fp_log.h b/arch/m68k/math-emu/fp_log.h
new file mode 100644
index 0000000000000000..c2bcfff11994cfb5
--- /dev/null
+++ b/arch/m68k/math-emu/fp_log.h
@@ -0,0 +1,44 @@
+/*
+
+  fp_log.h: floating-point math routines for the Linux-m68k
+  floating point emulator.
+
+  Copyright (c) 1998-1999 David Huggins-Daines / Roman Zippel.
+
+  I hereby give permission, free of charge, to copy, modify, and
+  redistribute this software, in source or binary form, provided that
+  the above copyright notice and the following disclaimer are included
+  in all such copies.
+
+  THIS SOFTWARE IS PROVIDED "AS IS", WITH ABSOLUTELY NO WARRANTY, REAL
+  OR IMPLIED.
+
+*/
+
+#ifndef _FP_LOG_H
+#define _FP_LOG_H
+
+#include "fp_emu.h"
+
+/* floating point logarithmic instructions:
+
+   the arguments to these are in the "internal" extended format, that
+   is, an "exploded" version of the 96-bit extended fp format used by
+   the 68881.
+
+   they return a status code, which should end up in %d0, if all goes
+   well.  */
+
+struct fp_ext *fp_fsqrt(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fetoxm1(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fetox(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_ftwotox(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_ftentox(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_flogn(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_flognp1(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_flog10(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_flog2(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fgetexp(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fgetman(struct fp_ext *dest, struct fp_ext *src);
+
+#endif /* _FP_LOG_H */
diff --git a/arch/m68k/math-emu/fp_trig.h b/arch/m68k/math-emu/fp_trig.h
index 52f0cc31cfe49cb7..1aae8ab1d41b15f2 100644
--- a/arch/m68k/math-emu/fp_trig.h
+++ b/arch/m68k/math-emu/fp_trig.h
@@ -29,4 +29,23 @@
    they return a status code, which should end up in %d0, if all goes
    well.  */
 
+struct fp_ext *fp_fsin(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fcos(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_ftan(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fasin(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_facos(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fatan(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fsinh(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fcosh(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_ftanh(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fatanh(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fsincos0(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fsincos1(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fsincos2(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fsincos3(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fsincos4(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fsincos5(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fsincos6(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fsincos7(struct fp_ext *dest, struct fp_ext *src);
+
 #endif /* _FP_TRIG_H */
-- 
2.34.1

