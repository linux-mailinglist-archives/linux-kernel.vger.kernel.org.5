Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E6C75BA5E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 00:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjGTWQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 18:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjGTWQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:16:49 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1067D1719;
        Thu, 20 Jul 2023 15:16:43 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 33B4620164.A6B9A
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:143:242:ac11:20])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 33B4620164;
        Fri, 21 Jul 2023 00:16:41 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1689891401;
        bh=fdSglpg2gn0pNgPh7u0LeMetohadIiU2uOtBPywtCXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CI1UMu98AM9NUyRAAMK+LeizxOpyb6xAj3bTuykZgQ01HHu0bI3IG5U6OSFRb0ud1
         FgLtAET6wh3TDYwzY2Az4E1TbA2LSOIlx0V/UZ70hIxSA5CkO4Z8qXPdilEAmynexm
         OKwX2/uexspiU+XHlShu1n865IjtVbz7S4dl3sZU=
Received: from librem.home (unknown [IPv6:2a02:1210:6c17:f000:92c2:ccf4:848b:6bf4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id E1244D4EB0CF8;
        Fri, 21 Jul 2023 00:16:40 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH 2/4] selftests/sgx: Store base address and size in test enclave
Date:   Fri, 21 Jul 2023 00:16:21 +0200
Message-Id: <20230720221623.9530-3-jo.vanbulck@cs.kuleuven.be>
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

Make the test enclave aware of its protected virtual address range to allow
untrusted pointer argument range checks.

Add a linker symbol for __enclave_base at the start of the enclave binary.
Similar to real-world enclave runtimes, rely on the untrusted loader to
fill in __enclave_size (measured as part of MRENCLAVE), as the final size
of the enclave image is determined during loading.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
---
 tools/testing/selftests/sgx/load.c            |  3 +-
 tools/testing/selftests/sgx/main.c            | 32 +++++++++++++++++++
 tools/testing/selftests/sgx/test_encl.lds     |  1 +
 .../selftests/sgx/test_encl_bootstrap.S       | 17 ++++++++++
 4 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 94bdeac1c..968a656a3 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -60,7 +60,8 @@ static bool encl_map_bin(const char *path, struct encl *encl)
 		goto err;
 	}
 
-	bin = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	/* NOTE: map read|write to allow __enclave_size to be filled in */
+	bin = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if (bin == MAP_FAILED) {
 		perror("enclave executable mmap()");
 		goto err;
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 9a671dbc6..b1a7988c1 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -178,6 +178,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 	Elf64_Sym *sgx_enter_enclave_sym = NULL;
 	struct vdso_symtab symtab;
 	struct encl_segment *seg;
+	uint64_t encl_size_pt;
 	char maps_line[256];
 	FILE *maps_file;
 	unsigned int i;
@@ -189,6 +190,16 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 		return false;
 	}
 
+	/*
+	 * Fill in the expected symbol location with the final size of the
+	 * constructed enclave image.
+	 */
+	encl_size_pt = encl_get_entry(encl, "__enclave_size");
+	if (encl_size_pt) {
+		encl_size_pt += (uint64_t) encl->src;
+		*((uint64_t *) encl_size_pt) = encl->encl_size;
+	}
+
 	if (!encl_measure(encl))
 		goto err;
 
@@ -307,6 +318,27 @@ TEST_F(enclave, unclobbered_vdso)
 	EXPECT_EQ(self->run.user_data, 0);
 }
 
+/*
+ * Sanity check that the loader correctly initializes __enclave_size in the
+ * measured enclave image.
+ */
+TEST_F(enclave, init_size)
+{
+	struct encl_op_get_from_addr get_addr_op;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	get_addr_op.value = 0;
+	get_addr_op.addr = self->encl.encl_base + encl_get_entry(&self->encl, "__enclave_size");
+	get_addr_op.header.type = ENCL_OP_GET_FROM_ADDRESS;
+	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, false), 0);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(get_addr_op.value, self->encl.encl_size);
+}
+
 /*
  * Sanity check that the test enclave properly sanitizes untrusted
  * CPU configuration registers.
diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index a1ec64f7d..ca659db2a 100644
--- a/tools/testing/selftests/sgx/test_encl.lds
+++ b/tools/testing/selftests/sgx/test_encl.lds
@@ -10,6 +10,7 @@ PHDRS
 SECTIONS
 {
 	. = 0;
+        __enclave_base = .;
 	.tcs : {
 		*(.tcs*)
 	} : tcs
diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index 3b69fea61..444a075c0 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -98,6 +98,23 @@ encl_entry_core:
 	mov	$4, %rax
 	enclu
 
+	.global get_enclave_base
+get_enclave_base:
+	lea __enclave_base(%rip), %rax
+	ret
+
+	.global get_enclave_size
+get_enclave_size:
+	mov __enclave_size(%rip), %rax
+	ret
+
+	# The following 8 bytes (measured as part of MRENCLAVE) will be
+	# filled in by the untrusted loader with the total size of the
+	# loaded enclave.
+	.global __enclave_size
+__enclave_size:
+	.quad 0x0
+
 	.section ".data", "aw"
 
 encl_ssa_tcs1:
-- 
2.34.1

