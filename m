Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8307773DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjHJJMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbjHJJMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:12:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25369273E;
        Thu, 10 Aug 2023 02:11:51 -0700 (PDT)
Date:   Thu, 10 Aug 2023 09:11:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691658708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iqd8hxH/JVHj2zElMsZyPmhL9UvDhbSOu1e+bbCcz/M=;
        b=k6QlX2mrbtASUEHbg7Y1Yp8SYKjijNMCdb+6ZlG+YiU1sFqtshY2ntfsQI439afUMeOpDG
        l4gjTWt53GIBV7kbnAQriUU+8DFnyo4MLWk/UpxWsBDh9lA73mNqJ5RNbiBKGah+HZTaX7
        xvQtkR49CcEqtCcRcAE9RbdyDl6zQxQ+A3VCT7RtYn3O8CIHGafJpaH1QQCYWfd2ROKyB0
        Y1PYw6E9WgXsGhoCSR84+ZgqZN510uXvF5G8upr06KHkuP/mQdiRrQ+V9l/7KNVzP3Ct55
        gUP+KP2pbiQ8rnwCiEK5kR4Tn9n7n/KU+BeVnzxpoDXkJWC4Igmljju96mfq6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691658708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iqd8hxH/JVHj2zElMsZyPmhL9UvDhbSOu1e+bbCcz/M=;
        b=gydce7zW9AoOBJdPYaysJX/6ZKRT7IheSPra25//yjMSUxXZ6Hpluy6n9teHzzGomBd6x9
        RGQSG1JIobIb3SDw==
From:   "tip-bot2 for Nick Desaulniers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Fix build breakage with the LLVM linker
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Daniel Kolesa <daniel@octaforge.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sven Volkinsfeld <thyrc@gmx.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230809-gds-v1-1-eaac90b0cbcc@google.com>
References: <20230809-gds-v1-1-eaac90b0cbcc@google.com>
MIME-Version: 1.0
Message-ID: <169165870802.27769.15353947574704602257.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     cbe8ded48b939b9d55d2c5589ab56caa7b530709
Gitweb:        https://git.kernel.org/tip/cbe8ded48b939b9d55d2c5589ab56caa7b530709
Author:        Nick Desaulniers <ndesaulniers@google.com>
AuthorDate:    Wed, 09 Aug 2023 09:40:26 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 10 Aug 2023 11:03:12 +02:00

x86/srso: Fix build breakage with the LLVM linker

The assertion added to verify the difference in bits set of the
addresses of srso_untrain_ret_alias() and srso_safe_ret_alias() would fail
to link in LLVM's ld.lld linker with the following error:

  ld.lld: error: ./arch/x86/kernel/vmlinux.lds:210: at least one side of
  the expression must be absolute
  ld.lld: error: ./arch/x86/kernel/vmlinux.lds:211: at least one side of
  the expression must be absolute

Use ABSOLUTE to evaluate the expression referring to at least one of the
symbols so that LLD can evaluate the linker script.

Also, add linker version info to the comment about XOR being unsupported
in either ld.bfd or ld.lld until somewhat recently.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Closes: https://lore.kernel.org/llvm/CA+G9fYsdUeNu-gwbs0+T6XHi4hYYk=Y9725-wFhZ7gJMspLDRA@mail.gmail.com/
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Daniel Kolesa <daniel@octaforge.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Suggested-by: Sven Volkinsfeld <thyrc@gmx.net>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://github.com/ClangBuiltLinux/linux/issues/1907
Link: https://lore.kernel.org/r/20230809-gds-v1-1-eaac90b0cbcc@google.com
---
 arch/x86/kernel/vmlinux.lds.S | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index e768132..ef06211 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -529,11 +529,17 @@ INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_CPU_SRSO
 /*
- * GNU ld cannot do XOR so do: (A | B) - (A & B) in order to compute the XOR
+ * GNU ld cannot do XOR until 2.41.
+ * https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=f6f78318fca803c4907fb8d7f6ded8295f1947b1
+ *
+ * LLVM lld cannot do XOR until lld-17.
+ * https://github.com/llvm/llvm-project/commit/fae96104d4378166cbe5c875ef8ed808a356f3fb
+ *
+ * Instead do: (A | B) - (A & B) in order to compute the XOR
  * of the two function addresses:
  */
-. = ASSERT(((srso_untrain_ret_alias | srso_safe_ret_alias) -
-		(srso_untrain_ret_alias & srso_safe_ret_alias)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
+. = ASSERT(((ABSOLUTE(srso_untrain_ret_alias) | srso_safe_ret_alias) -
+		(ABSOLUTE(srso_untrain_ret_alias) & srso_safe_ret_alias)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
 		"SRSO function pair won't alias");
 #endif
 
