Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3491761A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjGYNtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjGYNtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:49:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F241FF7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:48:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A84C6170C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E522C433C9;
        Tue, 25 Jul 2023 13:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690292936;
        bh=rn5AmJ5E/u7lh73YUSkNYYV834iPfRhN7MTY5kuEYCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E5EJ5sFExzL+l6ZHXgg7hLHU7rqWQA/ZT1COpzpppHrOGcDkiH6orSN/Rm9g/Rspz
         X+mTZwvX7S10EtizGzoOqonpuVw12/qXHokPsgiyabe1j0THXHLqdkkUguxVBaUbPJ
         9gzfJh2FG3ThHGVj/PGS+eB3U2V9/vnIICo2dpFUBZ/q8MnRtu2pGNNoIoia+2+eqS
         OG8ETn9mz2HduZMTeoiRW54UED6y2Ewu8T8bcZ7tvmT3cCkaxBv6JfJ9A2CScDc6xS
         ZFv0SlajI3hptFRrcSxspED7h8hLREWIa28NpE4guqJF91O+vmUmPyjibDxPS0GEoo
         QdjeVM1AmT3yw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 4/5] [RESEND] x86: purgatory: include header for warn() declaration
Date:   Tue, 25 Jul 2023 15:48:36 +0200
Message-Id: <20230725134837.1534228-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230725134837.1534228-1-arnd@kernel.org>
References: <20230725134837.1534228-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The purgatory code has uses parts of the decompressor and provides
its own warn() function, but has to include the corresponding
header file to avoid a -Wmissing-prototypes warning.

It turns out that this the function prototype actually differs
from the declaration, so change it to get a constant pointer
in the declaration and the other definition as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/boot/compressed/error.c | 2 +-
 arch/x86/boot/compressed/error.h | 2 +-
 arch/x86/purgatory/purgatory.c   | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/error.c b/arch/x86/boot/compressed/error.c
index 5313c5cb2b802..19a8251de506a 100644
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
index 86fe33b937154..31f9e080d61a8 100644
--- a/arch/x86/boot/compressed/error.h
+++ b/arch/x86/boot/compressed/error.h
@@ -4,7 +4,7 @@
 
 #include <linux/compiler.h>
 
-void warn(char *m);
+void warn(const char *m);
 void error(char *m) __noreturn;
 void panic(const char *fmt, ...) __noreturn __cold;
 
diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
index 7558139920f8c..aea47e7939637 100644
--- a/arch/x86/purgatory/purgatory.c
+++ b/arch/x86/purgatory/purgatory.c
@@ -14,6 +14,7 @@
 #include <crypto/sha2.h>
 #include <asm/purgatory.h>
 
+#include "../boot/compressed/error.h"
 #include "../boot/string.h"
 
 u8 purgatory_sha256_digest[SHA256_DIGEST_SIZE] __section(".kexec-purgatory");
-- 
2.39.2

