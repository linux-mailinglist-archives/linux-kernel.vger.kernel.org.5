Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332A57888B8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245182AbjHYNda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245092AbjHYNdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:33:17 -0400
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416A12126;
        Fri, 25 Aug 2023 06:33:15 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 648D4201F4.AECF1
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 648D4201F4;
        Fri, 25 Aug 2023 15:33:12 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692970392;
        bh=CUGP0HNz7+v+Egq8G5bsUNJAb7h+DNIdd6i44FbjzPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UoJZeMpmjvwKv8Ge4RgJGY3/NhZJNEIpdoibuyb/A/Hv/zLiUbjbNm0gL0C8EXSeA
         TcNID72Oo8cclpbrsTGpqVyBnOZHF2MezY2R4jCTPcv8mpD9vZwhoYb4oYUc5n+Jya
         nnEwgS0VOd/eIHkSPxprkCx/4H0eWcdxgeREO7Yo=
Received: from localhost.localdomain (ptr-82s0fs8e775rpuqrs36.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:b56b:371:2317:a8f2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 247B2D4EB98F8;
        Fri, 25 Aug 2023 15:33:12 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v4 02/13] selftests/sgx: Produce static-pie executable for test enclave
Date:   Fri, 25 Aug 2023 15:32:41 +0200
Message-Id: <20230825133252.9056-3-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230825133252.9056-1-jo.vanbulck@cs.kuleuven.be>
References: <20230825133252.9056-1-jo.vanbulck@cs.kuleuven.be>
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
 tools/testing/selftests/sgx/Makefile              | 2 +-
 tools/testing/selftests/sgx/test_encl.lds         | 1 +
 tools/testing/selftests/sgx/test_encl_bootstrap.S | 9 ++++++---
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 50aab6b57da3..1d6315a2e5f5 100644
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
index 03ae0f57e29d..4e55d91566c4 100644
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

