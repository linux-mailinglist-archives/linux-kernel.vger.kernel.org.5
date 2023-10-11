Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ECC7C4B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344466AbjJKHQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjJKHQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:16:45 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADF49B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:16:42 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:a251:6312:1f1a:2a48])
        by michel.telenet-ops.be with bizsmtp
        id wXGe2A0023RY9Je06XGemh; Wed, 11 Oct 2023 09:16:38 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qqTSO-0063iR-Fp;
        Wed, 11 Oct 2023 09:16:38 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qqTSQ-00HIng-1m;
        Wed, 11 Oct 2023 09:16:38 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: lib: Include <linux/libgcc.h> for __muldi3()
Date:   Wed, 11 Oct 2023 09:16:33 +0200
Message-Id: <160c1fd14b4798f576d9649334b1d2c77db5cb07.1697008341.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1:

    arch/m68k/lib/muldi3.c:82:1: warning: no previous prototype for ‘__muldi3’ [-Wmissing-prototypes]
       82 | __muldi3 (DItype u, DItype v)
	  | ^~~~~~~~

Fix this by including <linux/libgcc.h>.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To bequeued in the m68k for-v6.7 branch.

Missed before, as "make arch/m68k/" does not (re)build arch/m68k/lib/?

arch/m68k/Makefile has:

    libs-y += arch/m68k/lib/

while all the other subdirs use "obj-y".
---
 arch/m68k/lib/muldi3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/lib/muldi3.c b/arch/m68k/lib/muldi3.c
index eb7d9d86ff6697a5..5012a9b218c7824c 100644
--- a/arch/m68k/lib/muldi3.c
+++ b/arch/m68k/lib/muldi3.c
@@ -16,6 +16,7 @@ GNU General Public License for more details. */
 
 #include <linux/compiler.h>
 #include <linux/export.h>
+#include <linux/libgcc.h>
 
 #ifdef CONFIG_CPU_HAS_NO_MULDIV64
 
-- 
2.34.1

