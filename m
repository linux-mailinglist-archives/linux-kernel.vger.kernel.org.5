Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC82075BA5D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 00:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGTWQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 18:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGTWQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:16:48 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8599B2128;
        Thu, 20 Jul 2023 15:16:42 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 4CDFF20164.A53FB
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:143:242:ac11:20])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 4CDFF20164;
        Fri, 21 Jul 2023 00:16:40 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1689891400;
        bh=VSQyg6gzCqsY2MIdg+AbxlLyn0u+sFUpjXke7m02e5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LhuuiFEwOfusGMu/EFsQQPLTgeWCF1osYI6hbEVZS8VGm0HTCsFGmAzvGOuGKm9jD
         WIjw439MXSlMa7C1OxlUeIZxI+gcAO3xIx6KdHAVnJlnnnk87J+BroWpoQji9ejWAF
         NeZRQ8o9PrE/CBNZkAgaCYoT5hObEMJJn+yJhrQY=
Received: from librem.home (unknown [IPv6:2a02:1210:6c17:f000:92c2:ccf4:848b:6bf4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 04756D4EC61F5;
        Fri, 21 Jul 2023 00:16:39 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH 1/4] selftests/sgx: Harden test enclave ABI
Date:   Fri, 21 Jul 2023 00:16:20 +0200
Message-Id: <20230720221623.9530-2-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720221623.9530-1-jo.vanbulck@cs.kuleuven.be>
References: <20230720221623.9530-1-jo.vanbulck@cs.kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The System V x86-64 ABI used by the C compiler defines certain low-level
CPU configuration registers to be set to expected values upon function
entry. However, SGX enclaves cannot expect the untrusted caller to respect
these ABI conventions. Therefore, adhere to SGX runtime best practices by
sanitizing RFLAGS.DF=0 before transitioning to C code. Additionally
sanitize RFLAGS.AC=0 to protect against known #AC-fault side channels for
unaligned memory accesses.

Note that the test enclave does currently not use any floating-point
instructions (-mno-sse). Hence, keep the code simple by _not_ using XRSTOR
to cleanse extended x87/SSE state.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
---
 tools/testing/selftests/sgx/Makefile          |  2 +-
 tools/testing/selftests/sgx/main.c            | 25 +++++++++++++++++++
 .../selftests/sgx/test_encl_bootstrap.S       | 12 +++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 50aab6b57..c2a13bc6e 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -14,7 +14,7 @@ endif
 INCLUDES := -I$(top_srcdir)/tools/include
 HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC -z noexecstack
 ENCL_CFLAGS := -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
-	       -fno-stack-protector -mrdrnd $(INCLUDES)
+	       -fno-stack-protector -mrdrnd -mno-sse $(INCLUDES)
 
 TEST_CUSTOM_PROGS := $(OUTPUT)/test_sgx
 TEST_FILES := $(OUTPUT)/test_encl.elf
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 9820b3809..9a671dbc6 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -307,6 +307,31 @@ TEST_F(enclave, unclobbered_vdso)
 	EXPECT_EQ(self->run.user_data, 0);
 }
 
+/*
+ * Sanity check that the test enclave properly sanitizes untrusted
+ * CPU configuration registers.
+ */
+TEST_F(enclave, poison_args)
+{
+	struct encl_op_header nop_op;
+	uint64_t flags = -1;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	/* attempt ABI register poisoning */
+	nop_op.type = ENCL_OP_NOP;
+	asm("std\n\t");
+	EXPECT_EQ(ENCL_CALL(&nop_op, &self->run, false), 0);
+	asm("pushfq\n\t"		\
+	    "popq %0\n\t"		\
+	    : "=m"(flags) : : );
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(flags & 0x40400, 0);
+}
+
 /*
  * A section metric is concatenated in a way that @low bits 12-31 define the
  * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index 03ae0f57e..3b69fea61 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -57,6 +57,18 @@ encl_entry_core:
 	push	%rcx # push the address after EENTER
 	push	%rbx # push the enclave base address
 
+	# Sanitize CPU state: x86-64 ABI requires RFLAGS.DF=0 on function
+	# entry, and we additionally clear RFLAGS.AC to prevent #AC-fault side
+	# channels.
+	# NOTE: Real-world enclave runtimes should also cleanse extended CPU
+	# state (i.e., x87 FPU and SSE/AVX/...) configuration registers,
+	# preferably using XRSTOR. This is _not_ done below to simplify the
+	# test enclave, which does not use any floating-point instructions.
+	cld
+	pushfq
+	andq $~0x40000, (%rsp)
+	popfq
+
 	call	encl_body
 
 	pop	%rbx # pop the enclave base address
-- 
2.34.1

