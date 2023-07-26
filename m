Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A008C763936
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbjGZOd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjGZOd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:33:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71240E78
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05F6261AF5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03551C433C8;
        Wed, 26 Jul 2023 14:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690382035;
        bh=yKI834690DMfFD3Ac39aSv3ombGoauP68gOWLlcu20s=;
        h=From:To:Cc:Subject:Date:From;
        b=XNg1U7w5Y5IoEainF926JUZdgDhOH2KC2ks7NYx3Ht3eEWO/YSwA+LWn9s4QJdYs2
         nAS/tWayqxr9CUeHMlUYWe44DKWSXL64RbhSvfkmrZkhU9cm7SEWkQ61cF7BqIlRQh
         k8CTzF/BwopObku3vHmJ6RKqCM/AbSxphYOaVjJt0Fl6xWfnwCZo5Ue3geQYkohWa1
         b/KmkF2vY1F+v07WsiBM1/f9EJbSnhthzCqHhAA7snCX4ZYAhrJ9moI+ksQMIC2Zfr
         7x2HDxkOEXrkmh39WU4Tq1aNe79vHtNyg9YSNZ3kX3+ZT0FF3+8w5z8IDFVul7Maef
         76iDM6Rf6eqiQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] init: keep boot_command_line after init
Date:   Wed, 26 Jul 2023 16:33:21 +0200
Message-Id: <20230726143348.724611-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The boot command line is not available after the init section gets discarded,
so adding a permanent reference to it causes a link time warning:

WARNING: modpost: vmlinux: section mismatch in reference: cmdline_load_proc_show+0x2 (section: .text) -> boot_command_line (section: .init.data)
ERROR: modpost: Section mismatches detected.
Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.

Change it to __ro_after_init to prevent it from getting freed.

Fixes: cf9eca90a3397 ("fs/proc: Add /proc/cmdline_load for boot loader arguments")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/init.h | 2 +-
 init/main.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 9a5973324072b..4e97a7a29a4d7 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -143,7 +143,7 @@ struct file_system_type;
 
 /* Defined in init/main.c */
 extern int do_one_initcall(initcall_t fn);
-extern char __initdata boot_command_line[];
+extern char boot_command_line[];
 extern char *saved_command_line;
 extern unsigned int saved_command_line_len;
 extern unsigned int reset_devices;
diff --git a/init/main.c b/init/main.c
index c946ab87783a1..981170da0b1cd 100644
--- a/init/main.c
+++ b/init/main.c
@@ -135,7 +135,7 @@ EXPORT_SYMBOL(system_state);
 void (*__initdata late_time_init)(void);
 
 /* Untouched command line saved by arch-specific code. */
-char __initdata boot_command_line[COMMAND_LINE_SIZE];
+char boot_command_line[COMMAND_LINE_SIZE] __ro_after_init;
 /* Untouched saved command line (eg. for /proc) */
 char *saved_command_line __ro_after_init;
 unsigned int saved_command_line_len __ro_after_init;
-- 
2.39.2

