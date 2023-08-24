Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CB1787926
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243436AbjHXUNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243474AbjHXUM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:12:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDFD1BE6;
        Thu, 24 Aug 2023 13:12:55 -0700 (PDT)
Date:   Thu, 24 Aug 2023 20:12:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692907974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hdoVCrrpBYeH8i1L4mfx+DdHVTeu8v91hAhYxWRXbQQ=;
        b=DCvWWpWKv6CDRu/4DrUM963IuGcu7YU5xm7hhAxZ4whUihIloAnVvMyQbgagmgCHgXelQ/
        8mmJ7fG+bTeQbCsW1r+d/zTGTpK/1KXsn2ZyNzULu5ktthUHx5ICwGECzmaLjgJ22p/yJB
        yC9h5Q0HfR9lyAtYIlH2LK7RnRubhEGwHd4+/1BSuqQLi4uMPkhJeGNWRhZSXyChsaBBsD
        ELkgd8VLS9PHw9ev2SfPpWSPhw8uYdHrd6qroFTNOtfslc6M3MlL/FqkCJN4k1clE92gfI
        wsX9iE2Mf4QrodAkGXerLQazQ1cTrpRwZFdXhi8hEAnt6mI1+6+mNMUR6TROtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692907974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hdoVCrrpBYeH8i1L4mfx+DdHVTeu8v91hAhYxWRXbQQ=;
        b=1pxKT2fR5mj2xJtXi45nWAL1v6dqVy4uODppA6DheTFX+jC2k3lq6HZU0PZ0Rif52TAAxq
        mrLv/ftV6K8B4uAg==
From:   "tip-bot2 for Justin Stitt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/platform/uv: Refactor code using deprecated
 strcpy()/strncpy() interfaces to use strscpy()
Cc:     Justin Stitt <justinstitt@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Dimitri Sivanich <sivanich@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230824-strncpy-arch-x86-platform-uv-uv_nmi-v2-1-e16d9a3ec570@google.com>
References: <20230824-strncpy-arch-x86-platform-uv-uv_nmi-v2-1-e16d9a3ec570@google.com>
MIME-Version: 1.0
Message-ID: <169290797383.27769.5488858935763270789.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     1e6f01f7285559a5302e85677b8e59a5de9b0ea5
Gitweb:        https://git.kernel.org/tip/1e6f01f7285559a5302e85677b8e59a5de9b0ea5
Author:        Justin Stitt <justinstitt@google.com>
AuthorDate:    Thu, 24 Aug 2023 18:52:18 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 24 Aug 2023 21:22:06 +02:00

x86/platform/uv: Refactor code using deprecated strcpy()/strncpy() interfaces to use strscpy()

Both `strncpy` and `strcpy` are deprecated for use on NUL-terminated
destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy` or `strcpy`!

In this case, we can drop both the forced NUL-termination and the `... -1` from:
|       strncpy(arg, val, ACTION_LEN - 1);
as `strscpy` implicitly has this behavior.

Also include slight refactor to code removing possible new-line chars as
per Yang Yang's work at [3]. This reduces code size and complexity by
using more robust and better understood interfaces.

Co-developed-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dimitri Sivanich <sivanich@hpe.com>
Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://lore.kernel.org/all/202212091545310085328@zte.com.cn/ [3]
Link: https://github.com/KSPP/linux/issues/90
Link: https://lore.kernel.org/r/20230824-strncpy-arch-x86-platform-uv-uv_nmi-v2-1-e16d9a3ec570@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/platform/uv/uv_nmi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index a60af02..a6ab43f 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -202,21 +202,17 @@ static int param_set_action(const char *val, const struct kernel_param *kp)
 {
 	int i;
 	int n = ARRAY_SIZE(valid_acts);
-	char arg[ACTION_LEN], *p;
+	char arg[ACTION_LEN];
 
 	/* (remove possible '\n') */
-	strncpy(arg, val, ACTION_LEN - 1);
-	arg[ACTION_LEN - 1] = '\0';
-	p = strchr(arg, '\n');
-	if (p)
-		*p = '\0';
+	strscpy(arg, val, strnchrnul(val, sizeof(arg)-1, '\n') - val + 1);
 
 	for (i = 0; i < n; i++)
 		if (!strcmp(arg, valid_acts[i].action))
 			break;
 
 	if (i < n) {
-		strcpy(uv_nmi_action, arg);
+		strscpy(uv_nmi_action, arg, sizeof(uv_nmi_action));
 		pr_info("UV: New NMI action:%s\n", uv_nmi_action);
 		return 0;
 	}
@@ -959,7 +955,7 @@ static int uv_handle_nmi(unsigned int reason, struct pt_regs *regs)
 
 		/* Unexpected return, revert action to "dump" */
 		if (master)
-			strncpy(uv_nmi_action, "dump", strlen(uv_nmi_action));
+			strscpy(uv_nmi_action, "dump", sizeof(uv_nmi_action));
 	}
 
 	/* Pause as all CPU's enter the NMI handler */
