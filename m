Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EE67E127D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 08:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjKEHwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 02:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjKEHwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 02:52:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4169EE;
        Sun,  5 Nov 2023 00:52:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471F7C433CA;
        Sun,  5 Nov 2023 07:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699170750;
        bh=A5a3osThQWoTahhEklksxkVo9fkv0G/I6pPuMuYtcvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+hHVNKadgFpQQLCPsYUji10tNz0XUlfGUChkvfZ2Nk9NpdCF7KyCrcvNXDALBeM5
         vBwhs58zlgDopNAQbyrZ61yiO24fAfyt+LjBenGxC/emG90tF6kDBfoMrT9vSPTcbu
         0nF+Mcoy9F8twFx+BzO/viPz/JZ8olYJZTunVMzcsTy/eYqPtHYS1zbTPxpQA6JRHF
         jJWk3yxuqEwvD0g5iSCOztlkGUO9m8G0zyvXzh4X+EveNGh1W4dnZs1HxLpCYtF2nU
         okRMCZxGt2UTZMWs5deLKR0IvUrHWmx7/AYsQ+aT9CgMkUfvX/PGeCfuRD/TfVrMRL
         dRTZEu+ck26MA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] genksyms: use getopt_long() unconditionally
Date:   Sun,  5 Nov 2023 16:52:18 +0900
Message-Id: <20231105075218.61536-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231105075218.61536-1-masahiroy@kernel.org>
References: <20231105075218.61536-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

getopt_long() is used by various tools in the kernel (e.g. Kconfig).

It should be fine to use it all the time.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/genksyms/genksyms.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index 6636d5b30eba..f3901c55df23 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -16,9 +16,7 @@
 #include <unistd.h>
 #include <assert.h>
 #include <stdarg.h>
-#ifdef __GNU_LIBRARY__
 #include <getopt.h>
-#endif				/* __GNU_LIBRARY__ */
 
 #include "genksyms.h"
 /*----------------------------------------------------------------------*/
@@ -718,7 +716,6 @@ void error_with_pos(const char *fmt, ...)
 static void genksyms_usage(void)
 {
 	fputs("Usage:\n" "genksyms [-adDTwqhVR] > /path/to/.tmp_obj.ver\n" "\n"
-#ifdef __GNU_LIBRARY__
 	      "  -d, --debug           Increment the debug level (repeatable)\n"
 	      "  -D, --dump            Dump expanded symbol defs (for debugging only)\n"
 	      "  -r, --reference file  Read reference symbols from a file\n"
@@ -728,17 +725,6 @@ static void genksyms_usage(void)
 	      "  -q, --quiet           Disable warnings (default)\n"
 	      "  -h, --help            Print this message\n"
 	      "  -V, --version         Print the release version\n"
-#else				/* __GNU_LIBRARY__ */
-	      "  -d                    Increment the debug level (repeatable)\n"
-	      "  -D                    Dump expanded symbol defs (for debugging only)\n"
-	      "  -r file               Read reference symbols from a file\n"
-	      "  -T file               Dump expanded types into file\n"
-	      "  -p                    Preserve reference modversions or fail\n"
-	      "  -w                    Enable warnings\n"
-	      "  -q                    Disable warnings (default)\n"
-	      "  -h                    Print this message\n"
-	      "  -V                    Print the release version\n"
-#endif				/* __GNU_LIBRARY__ */
 	      , stderr);
 }
 
@@ -747,7 +733,6 @@ int main(int argc, char **argv)
 	FILE *dumpfile = NULL, *ref_file = NULL;
 	int o;
 
-#ifdef __GNU_LIBRARY__
 	struct option long_opts[] = {
 		{"debug", 0, 0, 'd'},
 		{"warnings", 0, 0, 'w'},
@@ -763,9 +748,6 @@ int main(int argc, char **argv)
 
 	while ((o = getopt_long(argc, argv, "dwqVDr:T:ph",
 				&long_opts[0], NULL)) != EOF)
-#else				/* __GNU_LIBRARY__ */
-	while ((o = getopt(argc, argv, "dwqVDr:T:ph")) != EOF)
-#endif				/* __GNU_LIBRARY__ */
 		switch (o) {
 		case 'd':
 			flag_debug++;
-- 
2.40.1

