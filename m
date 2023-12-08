Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB0180ABC7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjLHSNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574486AbjLHSMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:12:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7FB10EB;
        Fri,  8 Dec 2023 10:13:01 -0800 (PST)
Date:   Fri, 08 Dec 2023 18:12:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702059180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=iw47ohedCEaZOlCqlGrH7FBw+ilqjehAoGogtWxJjsI=;
        b=SCStw0L31XDFyxvmjZ0GgHVej5jfvRF5TeuvkZ1alouLm0K6kcsIWA2gIlCCnbOwFvuQCx
        OI+lUbguFXD9LAVZAOYlbrKhELmpYnp8pRNrXsC0JoUT/veHaVe8LHPimgxYHkPM3rE9qd
        t9lJiGtTmxzppJ9tJiuc4QDkMU5S/k4PXjAeZpKVRDmrEPcWQ0yP0dhb1DmxF1HBri5N8z
        KiHmtwDCS0VF/q63URLqY9bywezG4b5gdTqsNUPz2SiOx5/HdWH6Fw/WTxpIgwS29ZIrxS
        HXct1blaDsjL8Y9jQ5MLG7SGOOR/+X0YBBMIG5Da6EsfaYF/jj/NfovK7AzcOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702059180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=iw47ohedCEaZOlCqlGrH7FBw+ilqjehAoGogtWxJjsI=;
        b=j9XEzSi1nzJOkjq6GbT+y+lw8KNIoc9nezn+mn9haGtKa8t41gqQOXcSL7gua+K1nC0SgA
        JJHLtLF0YcLjMcDg==
From:   "tip-bot2 for Jo Van Bulck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Produce static-pie executable for test enclave
Cc:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205917995.398.14866199583250820547.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     f7884e732841450de36c2b1ed49b91e8e854a7d1
Gitweb:        https://git.kernel.org/tip/f7884e732841450de36c2b1ed49b91e8e854a7d1
Author:        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
AuthorDate:    Thu, 05 Oct 2023 17:38:48 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:05:27 -08:00

selftests/sgx: Produce static-pie executable for test enclave

The current combination of -static and -fPIC creates a static executable
with position-dependent addresses for global variables. Use -static-pie
and -fPIE to create a proper static position independent executable that
can be loaded at any address without a dynamic linker.

When building the original "lea (encl_stack)(%rbx), %rax" assembly code
with -static-pie -fPIE, the linker complains about a relocation it cannot
resolve:

/usr/local/bin/ld: /tmp/cchIWyfG.o: relocation R_X86_64_32S against
`.data' can not be used when making a PIE object; recompile with -fPIE
collect2: error: ld returned 1 exit status

Thus, since only RIP-relative addressing is legit for local symbols, use
"encl_stack(%rip)" and declare an explicit "__encl_base" symbol at the
start of the linker script to be able to calculate the stack address
relative to the current TCS in the enclave assembly entry code.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/f9c24d89-ed72-7d9e-c650-050d722c6b04@cs.kuleuven.be/
Link: https://lore.kernel.org/all/20231005153854.25566-8-jo.vanbulck%40cs.kuleuven.be
---
 tools/testing/selftests/sgx/Makefile              |  2 +-
 tools/testing/selftests/sgx/test_encl.lds         |  1 +
 tools/testing/selftests/sgx/test_encl_bootstrap.S |  9 ++++++---
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 7eb890b..8d2ba6a 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -14,7 +14,7 @@ endif
 INCLUDES := -I$(top_srcdir)/tools/include
 HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC
 HOST_LDFLAGS := -z noexecstack -lcrypto
-ENCL_CFLAGS += -Wall -Werror -static -nostdlib -ffreestanding -fPIC \
+ENCL_CFLAGS += -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
 ENCL_LDFLAGS := -Wl,-T,test_encl.lds,--build-id=none
 
diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index a1ec64f..62d3716 100644
--- a/tools/testing/selftests/sgx/test_encl.lds
+++ b/tools/testing/selftests/sgx/test_encl.lds
@@ -10,6 +10,7 @@ PHDRS
 SECTIONS
 {
 	. = 0;
+        __encl_base = .;
 	.tcs : {
 		*(.tcs*)
 	} : tcs
diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index e0ce993..28fe5d2 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -42,9 +42,12 @@
 encl_entry:
 	# RBX contains the base address for TCS, which is the first address
 	# inside the enclave for TCS #1 and one page into the enclave for
-	# TCS #2. By adding the value of encl_stack to it, we get
-	# the absolute address for the stack.
-	lea	(encl_stack)(%rbx), %rax
+	# TCS #2. First make it relative by substracting __encl_base and
+	# then add the address of encl_stack to get the address for the stack.
+	lea __encl_base(%rip), %rax
+	sub %rax, %rbx
+	lea encl_stack(%rip), %rax
+	add %rbx, %rax
 	jmp encl_entry_core
 encl_dyn_entry:
 	# Entry point for dynamically created TCS page expected to follow
