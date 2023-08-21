Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFAF78211B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjHUBTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjHUBTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:19:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424C5A7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 225AD62656
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BAFC433C9;
        Mon, 21 Aug 2023 01:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692580775;
        bh=vKe6g7DJFD+sOe7LW8LR2j3xCIXy2maEKLpUAkuZCqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TgQqsDKnDmHtsRZF3oUHDf/yfoAfdZnAkGT8FNzNcJqvEBAnkPnMtPcQq7NEQmATw
         UcADyqtnf/s/OjicDNRRcaKikjzfIyJA6BVCtgAyDELo3CXeNvwnFn13inDa6UJbwx
         5xXxYm9oVpOMcUmey472VWup/up60iW++XUHPFmVQzTYWLoJDhYCqEPB1Wpo7bBmuj
         0xon5XfBizve3jNyEvkWmbw/pgYlnTVbNCrNZIftuLbh398Zk3fkKLwK5M0lka3ajh
         EguRaGKco3FUQs272lKviQ4sGhiDrCZm1Fcwd6kdtuDFSGJl6ZOx91qaONrJyP7FHq
         Rrcacc7ll0+0Q==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 14/22] x86/srso: Fix unret validation dependencies
Date:   Sun, 20 Aug 2023 18:19:11 -0700
Message-ID: <0defc3c027db91a6349d4d8a638245212854dddf.1692580085.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692580085.git.jpoimboe@kernel.org>
References: <cover.1692580085.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CPU_SRSO isn't dependent on CONFIG_CPU_UNRET_ENTRY (AMD
Retbleed), so the two features are independently configurable.  Fix
several issues for the (presumably rare) case where CONFIG_CPU_SRSO is
enabled but CONFIG_CPU_UNRET_ENTRY isn't.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/nospec-branch.h | 4 ++--
 include/linux/objtool.h              | 3 ++-
 scripts/Makefile.vmlinux_o           | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index c55cc243592e..197ff4f4d1ce 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -271,7 +271,7 @@
 .Lskip_rsb_\@:
 .endm
 
-#ifdef CONFIG_CPU_UNRET_ENTRY
+#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO)
 #define CALL_UNTRAIN_RET	"call entry_untrain_ret"
 #else
 #define CALL_UNTRAIN_RET	""
@@ -312,7 +312,7 @@
 
 .macro UNTRAIN_RET_FROM_CALL
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
-	defined(CONFIG_CALL_DEPTH_TRACKING)
+	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
 	VALIDATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 03f82c2c2ebf..b5440e7da55b 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -130,7 +130,8 @@
  * it will be ignored.
  */
 .macro VALIDATE_UNRET_BEGIN
-#if defined(CONFIG_NOINSTR_VALIDATION) && defined(CONFIG_CPU_UNRET_ENTRY)
+#if defined(CONFIG_NOINSTR_VALIDATION) && \
+	(defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO))
 .Lhere_\@:
 	.pushsection .discard.validate_unret
 	.long	.Lhere_\@ - .
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 0edfdb40364b..25b3b587d37c 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -37,7 +37,8 @@ objtool-enabled := $(or $(delay-objtool),$(CONFIG_NOINSTR_VALIDATION))
 
 vmlinux-objtool-args-$(delay-objtool)			+= $(objtool-args-y)
 vmlinux-objtool-args-$(CONFIG_GCOV_KERNEL)		+= --no-unreachable
-vmlinux-objtool-args-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr $(if $(CONFIG_CPU_UNRET_ENTRY), --unret)
+vmlinux-objtool-args-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr \
+							   $(if $(or $(CONFIG_CPU_UNRET_ENTRY),$(CONFIG_CPU_SRSO)), --unret)
 
 objtool-args = $(vmlinux-objtool-args-y) --link
 
-- 
2.41.0

