Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E62E7818E0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjHSKki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjHSKka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:40:30 -0400
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A20C2ECAB;
        Sat, 19 Aug 2023 02:44:24 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 59157C3.A8132
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:145:242:ac11:22])
        by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id 59157C3;
        Sat, 19 Aug 2023 11:44:21 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692438261;
        bh=k71hdEJlfzPeKAHJysTAMTOhU4xtNO6RTnAD2ZlQXFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CcysulpW9OJIuNRqtAAaEfZqOtmUEoQz9gNg9vUxnj04d2EAlXZaDcDEL0kQuWffS
         gna5cREOeWTiqmtA1ZNCKMymaobCxifKcOGYz6xr41R+qWd7QJX7geeFvt9b/lFbpV
         lzDnbVNnf9fx0q8QqgTCwJ/iAhnKykEzqj0CTsls=
Received: from localhost.localdomain (ip-185-104-137-32.ptr.icomera.net [185.104.137.32])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id E33B3D4EB63C2;
        Sat, 19 Aug 2023 11:44:03 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v3 2/9] selftests/sgx: Produce static-pie executable for test enclave
Date:   Sat, 19 Aug 2023 11:43:25 +0200
Message-Id: <20230819094332.8535-3-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
References: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current combination of -static and -fPIC creates a static executable
with position-dependent addresses for global variables. Use -static-pie
and -fPIE to create a proper static position independent executable that
can be loaded at any address without a dynamic linker.

Link: https://lore.kernel.org/all/f9c24d89-ed72-7d9e-c650-050d722c6b04@cs.kuleuven.be/
Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/Makefile              |  2 +-
 tools/testing/selftests/sgx/test_encl.lds         |  1 +
 tools/testing/selftests/sgx/test_encl_bootstrap.S | 12 ++++++------
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 50aab6b57..1d6315a2e 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -13,7 +13,7 @@ endif
 
 INCLUDES := -I$(top_srcdir)/tools/include
 HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC -z noexecstack
-ENCL_CFLAGS := -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
+ENCL_CFLAGS := -Wall -Werror -static-pie -nostdlib -nostartfiles -fPIE \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
 
 TEST_CUSTOM_PROGS := $(OUTPUT)/test_sgx
diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index a1ec64f7d..62d37160f 100644
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
index 03ae0f57e..28fe5d2ac 100644
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
@@ -55,12 +58,9 @@ encl_entry_core:
 	push	%rax
 
 	push	%rcx # push the address after EENTER
-	push	%rbx # push the enclave base address
 
 	call	encl_body
 
-	pop	%rbx # pop the enclave base address
-
 	/* Clear volatile GPRs, except RAX (EEXIT function). */
 	xor     %rcx, %rcx
 	xor     %rdx, %rdx
-- 
2.25.1

