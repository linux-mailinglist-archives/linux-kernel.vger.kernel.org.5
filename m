Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2F57E29A9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjKFQ0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjKFQ0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:26:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A471BC;
        Mon,  6 Nov 2023 08:26:06 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 62D3F21FAC;
        Mon,  6 Nov 2023 16:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699287965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37EtSuEzhmU45RwRWxfsxLJpp8I7CAOaubIcYziFsEU=;
        b=PtZKhl94vwNSH1o9jUF1PuRya994j7rI+zkTzpF1y1vclk22RjwseOMShjSV4KXAVF+wGD
        Mw9xvsm4jm1e1PU/slemP+fDZ2l2k+HDdImdpP3bGCVrheaOXrE6v6wEaqQsd4RyQdUSYT
        XEFi2UlNFLMlq4IqBdnM3H9+bajkRZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699287965;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37EtSuEzhmU45RwRWxfsxLJpp8I7CAOaubIcYziFsEU=;
        b=crK/d7wGA8JSdr8fgEWCJGkIp5/syKti+38j8Rf61XzNk+wEQ5R9Dy/ZrLH1dO/f5mPV/4
        JiXWCwiWZvvAy4DA==
Received: from localhost.cz (lhruska.udp.ovpn2.prg.suse.de [10.100.204.118])
        by relay2.suse.de (Postfix) with ESMTP id F2D0C2CB05;
        Mon,  6 Nov 2023 16:26:04 +0000 (UTC)
From:   Lukas Hruska <lhruska@suse.cz>
To:     Petr Mladek <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Lukas Hruska <lhruska@suse.cz>
Subject: [PATCH v1 1/5] livepatch: Create and include UAPI headers
Date:   Mon,  6 Nov 2023 17:25:09 +0100
Message-ID: <20231106162513.17556-2-lhruska@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106162513.17556-1-lhruska@suse.cz>
References: <20231106162513.17556-1-lhruska@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

Define klp prefixes in include/uapi/linux/livepatch.h, and use them for
replacing hard-coded values in kernel/livepatch/core.c.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Lukas Hruska <lhruska@suse.cz>
---
 MAINTAINERS                    |  1 +
 include/uapi/linux/livepatch.h | 15 +++++++++++++++
 kernel/livepatch/core.c        |  5 +++--
 3 files changed, 19 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/linux/livepatch.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4cc6bf79fdd8..11a2d84c1277 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12130,6 +12130,7 @@ F:	Documentation/ABI/testing/sysfs-kernel-livepatch
 F:	Documentation/livepatch/
 F:	arch/powerpc/include/asm/livepatch.h
 F:	include/linux/livepatch.h
+F:	include/uapi/linux/livepatch.h
 F:	kernel/livepatch/
 F:	kernel/module/livepatch.c
 F:	lib/livepatch/
diff --git a/include/uapi/linux/livepatch.h b/include/uapi/linux/livepatch.h
new file mode 100644
index 000000000000..e19430918a07
--- /dev/null
+++ b/include/uapi/linux/livepatch.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+/*
+ * livepatch.h - Kernel Live Patching Core
+ *
+ * Copyright (C) 2016 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+
+#ifndef _UAPI_LIVEPATCH_H
+#define _UAPI_LIVEPATCH_H
+
+#define KLP_RELA_PREFIX		".klp.rela."
+#define KLP_SYM_PREFIX		".klp.sym."
+
+#endif /* _UAPI_LIVEPATCH_H */
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 61328328c474..622f1916a5c8 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -20,6 +20,7 @@
 #include <linux/completion.h>
 #include <linux/memory.h>
 #include <linux/rcupdate.h>
+#include <uapi/linux/livepatch.h>
 #include <asm/cacheflush.h>
 #include "core.h"
 #include "patch.h"
@@ -226,7 +227,7 @@ static int klp_resolve_symbols(Elf_Shdr *sechdrs, const char *strtab,
 
 		/* Format: .klp.sym.sym_objname.sym_name,sympos */
 		cnt = sscanf(strtab + sym->st_name,
-			     ".klp.sym.%55[^.].%511[^,],%lu",
+			     KLP_SYM_PREFIX "%55[^.].%511[^,],%lu",
 			     sym_objname, sym_name, &sympos);
 		if (cnt != 3) {
 			pr_err("symbol %s has an incorrectly formatted name\n",
@@ -305,7 +306,7 @@ static int klp_write_section_relocs(struct module *pmod, Elf_Shdr *sechdrs,
 	 * See comment in klp_resolve_symbols() for an explanation
 	 * of the selected field width value.
 	 */
-	cnt = sscanf(shstrtab + sec->sh_name, ".klp.rela.%55[^.]",
+	cnt = sscanf(shstrtab + sec->sh_name, KLP_RELA_PREFIX "%55[^.]",
 		     sec_objname);
 	if (cnt != 1) {
 		pr_err("section %s has an incorrectly formatted name\n",
-- 
2.42.0

