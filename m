Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE52D80ABC6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574608AbjLHSNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574482AbjLHSMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:12:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4510EA3;
        Fri,  8 Dec 2023 10:13:01 -0800 (PST)
Date:   Fri, 08 Dec 2023 18:12:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702059179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dvTiWZawvnttS4+GL5aT5rzsJeSaTFYf97yFzwvhD2w=;
        b=FC9bfl2p3ufvhmRM6DsAIM6LtcSxquBTJ+nWeRy23DK6+CaXDfI3JnUnlCJiVpKn2DtxE/
        9ZXtaTAgITs/WVv8ue4cCuHH4CMHH0lBgLqrunqZ/mXweOQe5EeIdNYH7Izqqd5o6RbG3F
        v9/dkNb3nBtTbCXqnre40Uxo6oFnZSuPT8riJuhkCdr7gkzxUshiYER01JxFEyOzq9fmjd
        EVcgtCzFAJe4i5cxvZj2M+6soIu2NYkqiER3ERv8cbB5sENuVsO2LZIi1cJcN7NBNzW+YD
        iBG4LhekqLSHxMAsSOLt5okOoccXLbT0UMvapYgna5WbOzUD4ut//YGpQuMpBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702059179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dvTiWZawvnttS4+GL5aT5rzsJeSaTFYf97yFzwvhD2w=;
        b=guD1ulodz8VIttw5dshTayhnKZbyGV+ft+pISwLxTYlWeoxcfQLVLtMJmPpnXTx17st7Je
        suCoMCtXrPhWBKDA==
From:   "tip-bot2 for Jo Van Bulck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Handle relocations in test enclave
Cc:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205917924.398.6222151209323327457.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     d06978e8e47a348c0d33462a8c2bf8f46d2b7df5
Gitweb:        https://git.kernel.org/tip/d06978e8e47a348c0d33462a8c2bf8f46d2b7df5
Author:        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
AuthorDate:    Thu, 05 Oct 2023 17:38:49 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:05:27 -08:00

selftests/sgx: Handle relocations in test enclave

Static-pie binaries normally include a startup routine to perform any ELF
relocations from .rela.dyn. Since the enclave loading process is different
and glibc is not included, do the necessary relocation for encl_op_array
entries manually at runtime relative to the enclave base to ensure correct
function pointers.

When keeping encl_op_array as a local variable on the stack, gcc without
optimizations generates code that explicitly gets the right function
addresses and stores them to create the array on the stack:

encl_body:
    /* snipped */
    lea    do_encl_op_put_to_buf(%rip), %rax
    mov    %rax, -0x50(%rbp)
    lea    do_encl_op_get_from_buf(%rip), %rax
    mov    %rax,-0x48(%rbp)
    lea    do_encl_op_put_to_addr(%rip), %rax
    /* snipped */

However, gcc -Os or clang generate more efficient code that initializes
encl_op_array by copying a "prepared copy" containing the absolute
addresses of the functions (i.e., relative to the image base starting from
0) generated by the compiler/linker:

encl_body:
    /* snipped */
    lea    prepared_copy(%rip), %rsi
    lea    -0x48(%rsp), %rdi
    mov    $0x10,%ecx
    rep movsl %ds:(%rsi),%es:(%rdi)
    /* snipped */

When building the enclave with -static-pie, the compiler/linker includes
relocation entries for the function symbols in the "prepared copy":

Relocation section '.rela.dyn' at offset 0x4000 contains 12 entries:
  Offset          Info           Type         Symbol
/* snipped; "prepared_copy" starts at 0x6000 */
000000006000  000000000008 R_X86_64_RELATIVE  <do_encl_emodpe>
000000006008  000000000008 R_X86_64_RELATIVE  <do_encl_eaccept>
000000006010  000000000008 R_X86_64_RELATIVE  <do_encl_op_put_to_buf>
000000006018  000000000008 R_X86_64_RELATIVE  <do_encl_op_get_from_buf>
000000006020  000000000008 R_X86_64_RELATIVE  <do_encl_op_put_to_addr>
000000006028  000000000008 R_X86_64_RELATIVE  <do_encl_op_get_from_addr>
000000006030  000000000008 R_X86_64_RELATIVE  <do_encl_op_nop>
000000006038  000000000008 R_X86_64_RELATIVE  <do_encl_init_tcs_page>

Static-pie binaries normally include a glibc "_dl_relocate_static_pie"
routine that will perform these relocations as part of the startup.
However, since the enclave loading process is different and glibc is not
included, we cannot rely on these relocations to be performed. Without
relocations, the code would erroneously jump to the _absolute_ function
address loaded from the local copy.

Thus, declare "encl_op_array" as global and manually relocate the loaded
function-pointer entries relative to the enclave base at runtime. This
generates the following code:

encl_body:
    /* snipped */
    lea    encl_op_array(%rip), %rcx
    lea    __encl_base(%rip), %rax
    add    (%rcx,%rdx,8),%rax
    jmp    *%rax

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/150d8ca8-2c66-60d1-f9fc-8e6279824e94@cs.kuleuven.be/
Link: https://lore.kernel.org/all/5c22de5a-4b3b-1f38-9771-409b4ec7f96d@cs.kuleuven.be/#r
Link: https://lore.kernel.org/all/20231005153854.25566-9-jo.vanbulck%40cs.kuleuven.be
---
 tools/testing/selftests/sgx/test_encl.c | 50 ++++++++++++++++--------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index ae791df..649604c 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -121,21 +121,41 @@ static void do_encl_op_nop(void *_op)
 
 }
 
+/*
+ * Symbol placed at the start of the enclave image by the linker script.
+ * Declare this extern symbol with visibility "hidden" to ensure the compiler
+ * does not access it through the GOT and generates position-independent
+ * addressing as __encl_base(%rip), so we can get the actual enclave base
+ * during runtime.
+ */
+extern const uint8_t __attribute__((visibility("hidden"))) __encl_base;
+
+typedef void (*encl_op_t)(void *);
+static const encl_op_t encl_op_array[ENCL_OP_MAX] = {
+	do_encl_op_put_to_buf,
+	do_encl_op_get_from_buf,
+	do_encl_op_put_to_addr,
+	do_encl_op_get_from_addr,
+	do_encl_op_nop,
+	do_encl_eaccept,
+	do_encl_emodpe,
+	do_encl_init_tcs_page,
+};
+
 void encl_body(void *rdi,  void *rsi)
 {
-	const void (*encl_op_array[ENCL_OP_MAX])(void *) = {
-		do_encl_op_put_to_buf,
-		do_encl_op_get_from_buf,
-		do_encl_op_put_to_addr,
-		do_encl_op_get_from_addr,
-		do_encl_op_nop,
-		do_encl_eaccept,
-		do_encl_emodpe,
-		do_encl_init_tcs_page,
-	};
-
-	struct encl_op_header *op = (struct encl_op_header *)rdi;
-
-	if (op->type < ENCL_OP_MAX)
-		(*encl_op_array[op->type])(op);
+	struct encl_op_header *header = (struct encl_op_header *)rdi;
+	encl_op_t op;
+
+	if (header->type >= ENCL_OP_MAX)
+		return;
+
+	/*
+	 * The enclave base address needs to be added, as this call site
+	 * *cannot be* made rip-relative by the compiler, or fixed up by
+	 * any other possible means.
+	 */
+	op = ((uint64_t)&__encl_base) + encl_op_array[header->type];
+
+	(*op)(header);
 }
