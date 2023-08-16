Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ECE77E536
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240881AbjHPPeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244131AbjHPPdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:33:41 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E92210D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:33:38 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d85a:258d:2c59:b44])
        by laurent.telenet-ops.be with bizsmtp
        id aFZc2A00U4QHFyo01FZc1i; Wed, 16 Aug 2023 17:33:37 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWIWY-000qpl-6P;
        Wed, 16 Aug 2023 17:33:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWIWe-006b9U-HJ;
        Wed, 16 Aug 2023 17:33:36 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] scripts/bloat-o-meter: Count weak symbol sizes
Date:   Wed, 16 Aug 2023 17:33:34 +0200
Message-Id: <a1e7abd2571c3bbfe75345d6ee98b276d2d5c39d.1692200010.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, bloat-o-meter does not take into account weak symbols, and
thus ignores any size changes in code or data marked __weak.

Fix this by handling weak code ("w"/"W") and data ("v"/"V").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 scripts/bloat-o-meter | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/bloat-o-meter b/scripts/bloat-o-meter
index 36303afa9dfc33b1..888ce286a351e6e3 100755
--- a/scripts/bloat-o-meter
+++ b/scripts/bloat-o-meter
@@ -100,12 +100,12 @@ def print_result(symboltype, symbolformat):
     print("Total: Before=%d, After=%d, chg %+.2f%%" % (otot, ntot, percent))
 
 if args.c:
-    print_result("Function", "tT")
-    print_result("Data", "dDbB")
+    print_result("Function", "tTwW")
+    print_result("Data", "dDbBvV")
     print_result("RO Data", "rR")
 elif args.d:
-    print_result("Data", "dDbBrR")
+    print_result("Data", "dDbBrRvV")
 elif args.t:
-    print_result("Function", "tT")
+    print_result("Function", "tTwW")
 else:
-    print_result("Function", "tTdDbBrR")
+    print_result("Function", "tTdDbBrRvVwW")
-- 
2.34.1

