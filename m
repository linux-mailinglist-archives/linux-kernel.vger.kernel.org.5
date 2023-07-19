Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC2A7598CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjGSOtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjGSOt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:49:26 -0400
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652AD171D;
        Wed, 19 Jul 2023 07:49:21 -0700 (PDT)
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [134.58.240.133])
        by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id 48E5A1EDB;
        Wed, 19 Jul 2023 16:25:46 +0200 (CEST)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 86997201C4.A879C
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:136:242:ac11:f])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 86997201C4;
        Wed, 19 Jul 2023 16:25:42 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1689776742;
        bh=Nv3EyBGczwLEZB8AWa6Fp/AcP4hw5HdF1V+cNhE8Nuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=X4Iucye8FCdaJb5+iAqfdDzW+CSJGmK/Ux8lQa4MrogF7/czdvRq6SbLwAzA4mmuU
         xyHLw1rWBhp8fp5O1xBoj4DSMf053Nl/anKrqOuy8e3fZvE33oQRiu2R3CaryrCsEl
         JABKmMjoBQRMcfWaOuJgZxX76FOAoYCQAIHOWb1o=
Received: from librem.epfl.ch (eduroam-269-1-126.epfl.ch [192.33.197.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 5227CD4E6AFDA;
        Wed, 19 Jul 2023 16:25:42 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH 2/4] selftests/sgx: Store base address and size in test enclave
Date:   Wed, 19 Jul 2023 16:24:58 +0200
Message-Id: <20230719142500.13623-3-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230719142500.13623-1-jo.vanbulck@cs.kuleuven.be>
References: <20230719142500.13623-1-jo.vanbulck@cs.kuleuven.be>
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
 tools/testing/selftests/sgx/main.c            | 29 +++++++++++++++++++
 tools/testing/selftests/sgx/test_encl.lds     |  1 +
 .../selftests/sgx/test_encl_bootstrap.S       | 17 +++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

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
index d3c7a39f4..bad963c79 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -182,6 +182,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 	FILE *maps_file;
 	unsigned int i;
 	void *addr;
+	uint64_t encl_size_addr;
 
 	if (!encl_load("test_encl.elf", encl, heap_size)) {
 		encl_delete(encl);
@@ -189,6 +190,16 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 		return false;
 	}
 
+	/*
+	 * Fill in the expected symbol location with the final size of the
+	 * constructed enclave image.
+	 */
+	encl_size_addr = encl_get_entry(encl, "__enclave_size");
+	if (encl_size_addr) {
+		encl_size_addr += (uint64_t) encl->src;
+		*((uint64_t *) encl_size_addr) = encl->encl_size;
+	}
+
 	if (!encl_measure(encl))
 		goto err;
 
@@ -307,6 +318,24 @@ TEST_F(enclave, unclobbered_vdso)
 	EXPECT_EQ(self->run.user_data, 0);
 }
 
+TEST_F(enclave, init_size)
+{
+	struct encl_op_get_from_addr get_addr_op;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	/* __enclave_size is initialized by loader in measured enclave image */
+	get_addr_op.value = 0;
+	get_addr_op.addr = self->encl.encl_base + encl_get_entry(&self->encl, "__enclave_size");
+	get_addr_op.header.type = ENCL_OP_GET_FROM_ADDRESS;
+	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, false), 0);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(get_addr_op.value, self->encl.encl_size);
+}
+
 TEST_F(enclave, poison_args)
 {
 	struct encl_op_header nop_op;
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

