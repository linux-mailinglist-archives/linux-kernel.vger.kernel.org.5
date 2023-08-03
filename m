Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B9E76EEE0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbjHCP7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbjHCP7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:59:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AFB115;
        Thu,  3 Aug 2023 08:59:16 -0700 (PDT)
Date:   Thu, 03 Aug 2023 15:59:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691078355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Y/CjetvjY5uFuYteC4d6UqH4YG+n/luPhJHaaNAgT4=;
        b=K8FHM6hD4+iwY1zjud/2m+APX4VhYcNLxX5gkoSvDRLTvdEeD0Q+3yabm1jYWmsh6oaPOZ
        G+xXsvqKRk6XZk/NR0R5gUNPjn6AHd/cXS1SisH3fp8NNy538MPI/hCucc6vppBBK3DHkG
        L5UjHQn5EMU5L+Tf8DPWSV4PGj42xc4imUIa5thyCRa4OnF6GsJgMga22CgQ4rQSRTWmnt
        4NuzDS0ljDILiW7m9Hb41+8itNdeIne0ZdyIeXmodISH8fBbokvq9R4pRON0DM1EmMnIvt
        qMuma8EhwSh3klea2WiiZ2oADUt2ckvY8tJwL37aWAfZSTfIVuap3/VaTvqpqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691078355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Y/CjetvjY5uFuYteC4d6UqH4YG+n/luPhJHaaNAgT4=;
        b=ZTfh4YLqRp9UpN5Y33hVGHYgCGuW0VAJ9kUKvQCHD+8eHucqUFKQI0X1MkUsPYB4tsoP1f
        W67qxasPEbCpBqAQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/purgatory: Include header for warn() declaration
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230803082619.1369127-5-arnd@kernel.org>
References: <20230803082619.1369127-5-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <169107835437.28540.15117483789537490130.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     6d33531bc0234332572ae612232d947f353a4450
Gitweb:        https://git.kernel.org/tip/6d33531bc0234332572ae612232d947f353a4450
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Thu, 03 Aug 2023 10:26:16 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 03 Aug 2023 16:37:18 +02:00

x86/purgatory: Include header for warn() declaration

The purgatory code uses parts of the decompressor and provides its own
warn() function, but has to include the corresponding header file to
avoid a -Wmissing-prototypes warning.

It turns out that this function prototype actually differs from the
declaration, so change it to get a constant pointer in the declaration
and the other definition as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230803082619.1369127-5-arnd@kernel.org
---
 arch/x86/boot/compressed/error.c | 2 +-
 arch/x86/boot/compressed/error.h | 2 +-
 arch/x86/purgatory/purgatory.c   | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/error.c b/arch/x86/boot/compressed/error.c
index 5313c5c..19a8251 100644
--- a/arch/x86/boot/compressed/error.c
+++ b/arch/x86/boot/compressed/error.c
@@ -7,7 +7,7 @@
 #include "misc.h"
 #include "error.h"
 
-void warn(char *m)
+void warn(const char *m)
 {
 	error_putstr("\n\n");
 	error_putstr(m);
diff --git a/arch/x86/boot/compressed/error.h b/arch/x86/boot/compressed/error.h
index 86fe33b..31f9e08 100644
--- a/arch/x86/boot/compressed/error.h
+++ b/arch/x86/boot/compressed/error.h
@@ -4,7 +4,7 @@
 
 #include <linux/compiler.h>
 
-void warn(char *m);
+void warn(const char *m);
 void error(char *m) __noreturn;
 void panic(const char *fmt, ...) __noreturn __cold;
 
diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
index 7558139..aea47e7 100644
--- a/arch/x86/purgatory/purgatory.c
+++ b/arch/x86/purgatory/purgatory.c
@@ -14,6 +14,7 @@
 #include <crypto/sha2.h>
 #include <asm/purgatory.h>
 
+#include "../boot/compressed/error.h"
 #include "../boot/string.h"
 
 u8 purgatory_sha256_digest[SHA256_DIGEST_SIZE] __section(".kexec-purgatory");
