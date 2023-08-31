Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6D478EEDD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346380AbjHaNm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346347AbjHaNmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:42:24 -0400
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7140E50;
        Thu, 31 Aug 2023 06:42:16 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 43CA8201BA.A8592
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:139:242:ac11:1e])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 43CA8201BA;
        Thu, 31 Aug 2023 15:42:09 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1693489329;
        bh=6qiGv2+B+e9J2XY9shLKRTuexcZ/zKw3IKRdyHwgvg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LNUhF6ICFpl64oQDQzcjeiRbAxQB7uEy5PFPys909oMJ6AfXOLzBlCT/Gi1KxC61k
         ZrNhYOT2dFZ6PjKzOlU9SF4fG83m8AturrmqU9hiI9WdXXU9K7LwN1SvMFbBUBHRMc
         DMXGvmkYF5IqazPwVuRVZDteLD2FzLpsQCrVO43g=
Received: from localhost.localdomain (unknown [10.45.168.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id DF80ED4F61344;
        Thu, 31 Aug 2023 15:42:08 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v5 07/13] selftests/sgx: Produce static-pie executable for test enclave
Date:   Thu, 31 Aug 2023 15:41:38 +0200
Message-Id: <20230831134144.22686-8-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831134144.22686-1-jo.vanbulck@cs.kuleuven.be>
References: <20230831134144.22686-1-jo.vanbulck@cs.kuleuven.be>
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

Link: https://lore.kernel.org/all/f9c24d89-ed72-7d9e-c650-050d722c6b04@cs.kuleuven.be/
Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
---
 tools/testing/selftests/sgx/Makefile              | 2 +-
 tools/testing/selftests/sgx/test_encl.lds         | 1 +
 tools/testing/selftests/sgx/test_encl_bootstrap.S | 9 ++++++---
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 7eb890bdd3f0..8d2ba6adc92b 100644
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
index a1ec64f7d91f..62d37160f59b 100644
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
index e0ce993d3f2c..28fe5d2ac0af 100644
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
-- 
2.25.1

