Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645EE77F980
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352185AbjHQOpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352232AbjHQOpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:45:05 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F2F2D78
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:45:01 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d85a:258d:2c59:b44])
        by laurent.telenet-ops.be with bizsmtp
        id aeky2A00E4QHFyo01ekyys; Thu, 17 Aug 2023 16:44:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWeF1-000u8j-7E;
        Thu, 17 Aug 2023 16:44:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWeF8-007SBY-O3;
        Thu, 17 Aug 2023 16:44:58 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4/6] m68k: math-emu: Replace external declarations by header inclusion
Date:   Thu, 17 Aug 2023 16:44:51 +0200
Message-Id: <163bc2f64b5a3dd7b96a12aaca6733b408ddc880.1692283195.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692283195.git.geert@linux-m68k.org>
References: <cover.1692283195.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the (incorrect) external declarations by an inclusion of the
appropriate header file.

Semantically, the "src" parameters of the various fp_*() functions are
constant.  However, they cannot actually be const as most of these
functions perform a normalization step first.  As the fp_one constant
passed to fp_add() is already normalized, it is safe to cast away its
constness when making the function call.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/math-emu/fp_log.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/math-emu/fp_log.c b/arch/m68k/math-emu/fp_log.c
index a8eac8c81757d22e..2426634c4ba74377 100644
--- a/arch/m68k/math-emu/fp_log.c
+++ b/arch/m68k/math-emu/fp_log.c
@@ -15,6 +15,7 @@
 
 */
 
+#include "fp_arith.h"
 #include "fp_emu.h"
 
 static const struct fp_ext fp_one =
@@ -22,9 +23,6 @@ static const struct fp_ext fp_one =
 	.exp = 0x3fff,
 };
 
-extern struct fp_ext *fp_fadd(struct fp_ext *dest, const struct fp_ext *src);
-extern struct fp_ext *fp_fdiv(struct fp_ext *dest, const struct fp_ext *src);
-
 struct fp_ext *
 fp_fsqrt(struct fp_ext *dest, struct fp_ext *src)
 {
@@ -70,7 +68,8 @@ fp_fsqrt(struct fp_ext *dest, struct fp_ext *src)
 	 *	sqrt(x) = 1 + 1/2*(x-1)
 	 *		= 1/2*(1+x)
 	 */
-	fp_fadd(dest, &fp_one);
+	/* It is safe to cast away the constness, as fp_one is normalized */
+	fp_fadd(dest, (struct fp_ext *)&fp_one);
 	dest->exp--;		/* * 1/2 */
 
 	/*
-- 
2.34.1

