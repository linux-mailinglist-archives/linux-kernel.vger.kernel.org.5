Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FDF77017F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjHDN2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjHDN2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:28:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A214C0C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:28:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E31ED62007
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE43AC433C7;
        Fri,  4 Aug 2023 13:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691155699;
        bh=vy0FSMSttVRRFaJRP3hWeSTw6dRwdUvifrNV1x+yK38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFerwVGzMJy9bZcNdyC3h/6ViXW8M7DNM7ccJPKT+m1IDRuwYkJXEs6HFeEsbIUB3
         EHimMOsuTJKqSn3rSoRRN8j3WJhF7A3FI692a/FP4hOmfMwsLXML1TlK6eNyDXScsA
         0meSQCB9NH/wvXcl2Md04BZ2fQnzohajz4kh7xusVjm99AfHioBXg38HSMJvwQWxFw
         YDjf2WvJnZCxC495dtCLd9D7D69CkN98moNtPLH6yCtZPgWPfGM0URQBkRUThJN487
         rO4f0JynjCCi3NojHYnv51z3yZyx/lw2eBGWXQ3YgfazkaP15ZsKYtktmh0+QORYUw
         zTTZa61VnbfOQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] watchdog/hardlockup: simplify Kconfig selection
Date:   Fri,  4 Aug 2023 15:27:51 +0200
Message-Id: <20230804132800.2270896-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230804132800.2270896-1-arnd@kernel.org>
References: <20230804132800.2270896-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The use of the 'imply' keyword tends to be a bad idea, as it's at best
confusing to the reader but often actually doesn't do what the author
intended.

In this case, it seems to be used correctly, but doing the same thing
using 'default' statements as we have elsewhere in the kernel is simpler
and would be easier to understand by readers that are unfamiliar with
the special semantics of 'imply'.

Fixes: 1356d0b966e7e ("watchdog/hardlockup: make the config checks more straightforward")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I got confused by the 'imply' here myself and thought this had caused
a build failure that turned out to be unrelated, but it might help
to apply this anyway to save the next person the confusion.
---
 lib/Kconfig.debug | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 72177a80baddc..8cfb49b6974c8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1056,9 +1056,6 @@ config HARDLOCKUP_DETECTOR
 	bool "Detect Hard Lockups"
 	depends on DEBUG_KERNEL && !S390 && !HARDLOCKUP_DETECTOR_SPARC64
 	depends on HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_BUDDY || HAVE_HARDLOCKUP_DETECTOR_ARCH
-	imply HARDLOCKUP_DETECTOR_PERF
-	imply HARDLOCKUP_DETECTOR_BUDDY
-	imply HARDLOCKUP_DETECTOR_ARCH
 	select LOCKUP_DETECTOR
 
 	help
@@ -1090,24 +1087,21 @@ config HARDLOCKUP_DETECTOR_PREFER_BUDDY
 	  for the hardlockup detector are better used for other things.
 
 config HARDLOCKUP_DETECTOR_PERF
-	bool
+	def_bool HAVE_HARDLOCKUP_DETECTOR_PERF
 	depends on HARDLOCKUP_DETECTOR
-	depends on HAVE_HARDLOCKUP_DETECTOR_PERF && !HARDLOCKUP_DETECTOR_PREFER_BUDDY
-	depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
+	depends on !HARDLOCKUP_DETECTOR_PREFER_BUDDY && !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
 
 config HARDLOCKUP_DETECTOR_BUDDY
-	bool
+	def_bool HAVE_HARDLOCKUP_DETECTOR_BUDDY
 	depends on HARDLOCKUP_DETECTOR
-	depends on HAVE_HARDLOCKUP_DETECTOR_BUDDY
 	depends on !HAVE_HARDLOCKUP_DETECTOR_PERF || HARDLOCKUP_DETECTOR_PREFER_BUDDY
 	depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
 
 config HARDLOCKUP_DETECTOR_ARCH
-	bool
+	def_bool HAVE_HARDLOCKUP_DETECTOR_ARCH
 	depends on HARDLOCKUP_DETECTOR
-	depends on HAVE_HARDLOCKUP_DETECTOR_ARCH
 	help
 	  The arch-specific implementation of the hardlockup detector will
 	  be used.
-- 
2.39.2

