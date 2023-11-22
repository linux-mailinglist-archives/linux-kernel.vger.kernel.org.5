Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA16B7F5468
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjKVXVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKVXVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:21:32 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A308191;
        Wed, 22 Nov 2023 15:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1700695286;
        bh=srEK4Dv24I4ReE5ME7PGG9hMAt6epR4KY8YZybZeB5w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=NxtE0Rxs/IstNAYI6ArnQO1zYfrUzt6WY1HUy37hXMYugi60xcSbuYmK81IOxZ26C
         TmrZYHwk9pMYh5iU2wEC2ZJcFFJ2QcCgokgvYaz0ylU1KCj5l4uhn6QY8boWQSKaZN
         eHbcoKEh49DE2zQV8V3m3e86mLkGpo1fTQoQh2pc=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 23 Nov 2023 00:21:25 +0100
Subject: [PATCH 1/3] tools/nolibc: drop custom definition of struct rusage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231123-nolibc-rlimit-v1-1-a428b131de2a@weissschuh.net>
References: <20231123-nolibc-rlimit-v1-0-a428b131de2a@weissschuh.net>
In-Reply-To: <20231123-nolibc-rlimit-v1-0-a428b131de2a@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700695285; l=1460;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=srEK4Dv24I4ReE5ME7PGG9hMAt6epR4KY8YZybZeB5w=;
 b=uchEGzHmA/GH3gMecABp7LlEuFjgup5ONftSDDvzrKWXE+Gzoa6yiHURMy9mNvR5ZAOZ/7ZtX
 1rCWhkLvVTwDHjsPhl/xbPCbUJYfBicSC4pXpWTxEhvaepi08nbySBD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A future commit will include linux/resource.h, which will conflict with
the private definition of struct rusage in nolibc.
Avoid the conflict by dropping the private definition and use the one
from the UAPI headers.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/types.h | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index ad0ddaa89e50..b26a5d0c417c 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -13,6 +13,7 @@
 #include <linux/stat.h>
 #include <linux/time.h>
 #include <linux/wait.h>
+#include <linux/resource.h>
 
 
 /* Only the generic macros and types may be defined here. The arch-specific
@@ -178,26 +179,6 @@ struct linux_dirent64 {
 	char           d_name[];
 };
 
-/* needed by wait4() */
-struct rusage {
-	struct timeval ru_utime;
-	struct timeval ru_stime;
-	long   ru_maxrss;
-	long   ru_ixrss;
-	long   ru_idrss;
-	long   ru_isrss;
-	long   ru_minflt;
-	long   ru_majflt;
-	long   ru_nswap;
-	long   ru_inblock;
-	long   ru_oublock;
-	long   ru_msgsnd;
-	long   ru_msgrcv;
-	long   ru_nsignals;
-	long   ru_nvcsw;
-	long   ru_nivcsw;
-};
-
 /* The format of the struct as returned by the libc to the application, which
  * significantly differs from the format returned by the stat() syscall flavours.
  */

-- 
2.43.0

