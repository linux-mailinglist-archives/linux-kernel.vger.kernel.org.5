Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BB97C6091
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347010AbjJKWsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjJKWs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:48:29 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD019D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1697064505;
        bh=E+6v163CL8VkWi7Xk/2zA6K5NLTXD66hkQycZmPY0lE=;
        h=From:Date:Subject:To:Cc:From;
        b=cCkBlBzaJhVmad4Z2tpeArYeYnSUejsapZ78O86edfsNxYLFDRDP+cITKPnDviKHQ
         nieRjF/4ouad8IyTOtTHyv0z85mCjds3B+EOHczrd+cEjPQDjw99cRiVkchJEv9skj
         vDZKs/QghVFcfGQM14H1WaHzvb+dWsQtz2+g3Qo4=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 12 Oct 2023 00:48:23 +0200
Subject: [PATCH] tools/nolibc: mark start_c as weak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231012-nolibc-start_c-multiple-v1-1-fbfc73e0283f@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIADYmJ2UC/x3M3wpAMBSA8VfRuXbKNvLnVSQxB6dmtI2UvLvl8
 nfxfQ94ckwemuQBRxd73m2ESBPQ62AXQp6iQWZSiUxItLvhUaMPgwu9xu00gQ9DKKq5LvJJSSp
 ziPXhaOb7P7fd+37r1XXhaQAAAA==
To:     Willy Tarreau <w@1wt.eu>, Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697064504; l=1173;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=E+6v163CL8VkWi7Xk/2zA6K5NLTXD66hkQycZmPY0lE=;
 b=r0xhlWCJP7TZXtAlMV4/HCfXVuQ8VXOSHGEgwiiLsOCgHrkF/fRYHPfLyVk+LoEog9SOtKTpb
 BMc+I+ad0YlCZ1RhhzX45E1q6b6kdB9zz96STVn8KP62aX4WxNme4M6
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise the different instances of _start_c from each compilation unit
will lead to linker errors:

/usr/bin/ld: /tmp/ccSNvRqs.o: in function `_start_c':
nolibc-test-foo.c:(.text.nolibc_memset+0x9): multiple definition of `_start_c'; /tmp/ccG25101.o:nolibc-test.c:(.text+0x1ea3): first defined here

Fixes: 17336755150b ("tools/nolibc: add new crt.h with _start_c")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/crt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
index b84f5fbb7b58..43b551468c2a 100644
--- a/tools/include/nolibc/crt.h
+++ b/tools/include/nolibc/crt.h
@@ -22,6 +22,7 @@ extern void (*const __init_array_end[])(void) __attribute__((weak));
 extern void (*const __fini_array_start[])(void) __attribute__((weak));
 extern void (*const __fini_array_end[])(void) __attribute__((weak));
 
+__attribute__((weak))
 void _start_c(long *sp)
 {
 	long argc;

---
base-commit: e76716696ba0c5c41667a11caa092cd619a79c5b
change-id: 20231012-nolibc-start_c-multiple-18f954d32e74

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

