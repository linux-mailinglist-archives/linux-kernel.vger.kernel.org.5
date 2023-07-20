Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFC975BA60
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 00:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjGTWQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 18:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjGTWQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:16:53 -0400
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5902709;
        Thu, 20 Jul 2023 15:16:44 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 11AB72017E.AD805
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:143:242:ac11:20])
        by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id 11AB72017E;
        Fri, 21 Jul 2023 00:16:42 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1689891402;
        bh=zgFp9luiS/nACLf5WfG0kxqQ7DKIThEPGSwRSk6PYmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=e/tQt9yC57l7W9JTjgCTYdgxtEKddhAVbHbpqyNBQyD2r+myj1dMPXzGoBL+wMOJl
         NiRCynQdIkdbet8tM5eXXpaRG0mCJJNWPbnBbEftRkmREvIMX+jSWoINBmB9bW3m4Z
         vMV2gwBkA1zVHo+5qL5OoernET6+2KsxHPuwmfkk=
Received: from librem.home (unknown [IPv6:2a02:1210:6c17:f000:92c2:ccf4:848b:6bf4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id B0E3FD4EC61F5;
        Fri, 21 Jul 2023 00:16:41 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH 3/4] selftests/sgx: Harden test enclave API
Date:   Fri, 21 Jul 2023 00:16:22 +0200
Message-Id: <20230720221623.9530-4-jo.vanbulck@cs.kuleuven.be>
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

Adhere to enclave programming best practices and prevent confused-deputy
attacks on the test enclave by validating that untrusted pointer arguments
do not fall inside the protected enclave range.

Note that the test enclave deliberately allows arbitrary reads/writes in
enclave memory through the get_from_addr/put_to_addr operations for
explicit testing purposes. Hence, only allow remaining unchecked pointer
dereferences in these functions.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
---
 tools/testing/selftests/sgx/main.c      |   7 +-
 tools/testing/selftests/sgx/test_encl.c | 190 ++++++++++++++++++------
 2 files changed, 152 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index b1a7988c1..5919f5759 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -341,7 +341,7 @@ TEST_F(enclave, init_size)
 
 /*
  * Sanity check that the test enclave properly sanitizes untrusted
- * CPU configuration registers.
+ * CPU configuration registers and pointer arguments.
  */
 TEST_F(enclave, poison_args)
 {
@@ -362,6 +362,11 @@ TEST_F(enclave, poison_args)
 	    : "=m"(flags) : : );
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(flags & 0x40400, 0);
+
+	/* attempt API pointer poisoning */
+	EXPECT_EQ(ENCL_CALL(self->encl.encl_base + self->encl.encl_size - 1, &self->run, false), 0);
+	EXPECT_EQ((&self->run)->function, ERESUME);
+	EXPECT_EQ((&self->run)->exception_vector, 6 /* expect ud2 */);
 }
 
 /*
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index c0d639729..ea24cdf9e 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -16,69 +16,148 @@ enum sgx_enclu_function {
 	EMODPE = 0x6,
 };
 
+uint64_t get_enclave_base(void);
+uint64_t get_enclave_size(void);
+
+static void *memcpy(void *dest, const void *src, size_t n)
+{
+	size_t i;
+
+	for (i = 0; i < n; i++)
+		((char *)dest)[i] = ((char *)src)[i];
+
+	return dest;
+}
+
+static void *memset(void *dest, int c, size_t n)
+{
+	size_t i;
+
+	for (i = 0; i < n; i++)
+		((char *)dest)[i] = c;
+
+	return dest;
+}
+
+static int is_outside_enclave(void *addr, size_t len)
+{
+	/* need cast since void pointer arithmetics are undefined in C */
+	size_t start = (size_t) addr;
+	size_t end = start + len - 1;
+	size_t enclave_end = get_enclave_base() + get_enclave_size();
+
+	/* check for integer overflow with untrusted length */
+	if (start > end)
+		return 0;
+
+	return (start > enclave_end || end < get_enclave_base());
+}
+
+static int is_inside_enclave(void *addr, size_t len)
+{
+	/* need cast since void pointer arithmetics are undefined in C */
+	size_t start = (size_t) addr;
+	size_t end = start + len - 1;
+	size_t enclave_end = get_enclave_base() + get_enclave_size();
+
+	/* check for integer overflow with untrusted length */
+	if (start > end)
+		return 0;
+
+	return (start >= get_enclave_base() && end <= enclave_end);
+}
+
+static inline void panic(void)
+{
+	asm("ud2\n\t");
+}
+
+/*
+ * Asserts the buffer @src of @len bytes lies entirely outside the enclave
+ * and copies it to @dst to prevent TOCTOU issues.
+ */
+static inline void copy_inside_enclave(void *dst, void *src, size_t len)
+{
+	if (!is_outside_enclave(src, len))
+		panic();
+
+	memcpy(dst, src, len);
+}
+
+/*
+ * Asserts the buffer @dst of @len bytes lies entirely outside the enclave
+ * and fills it with @len bytes from @src.
+ */
+static inline void copy_outside_enclave(void *dst, void *src, size_t len)
+{
+	if (!is_outside_enclave(dst, len))
+		panic();
+
+	memcpy(dst, src, len);
+}
+
+static inline void assert_inside_enclave(uint64_t arg, size_t len)
+{
+	if (!is_inside_enclave((void *) arg, len))
+		panic();
+}
+
 static void do_encl_emodpe(void *_op)
 {
+	struct encl_op_emodpe op;
 	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
-	struct encl_op_emodpe *op = _op;
 
-	secinfo.flags = op->flags;
+	copy_inside_enclave(&op, _op, sizeof(op));
+	assert_inside_enclave(op.epc_addr, PAGE_SIZE);
+
+	secinfo.flags = op.flags;
 
 	asm volatile(".byte 0x0f, 0x01, 0xd7"
 				:
 				: "a" (EMODPE),
 				  "b" (&secinfo),
-				  "c" (op->epc_addr));
+				  "c" (op.epc_addr));
 }
 
 static void do_encl_eaccept(void *_op)
 {
+	struct encl_op_eaccept op;
 	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
-	struct encl_op_eaccept *op = _op;
 	int rax;
 
-	secinfo.flags = op->flags;
+	copy_inside_enclave(&op, _op, sizeof(op));
+	assert_inside_enclave(op.epc_addr, PAGE_SIZE);
+
+	secinfo.flags = op.flags;
 
 	asm volatile(".byte 0x0f, 0x01, 0xd7"
 				: "=a" (rax)
 				: "a" (EACCEPT),
 				  "b" (&secinfo),
-				  "c" (op->epc_addr));
-
-	op->ret = rax;
-}
-
-static void *memcpy(void *dest, const void *src, size_t n)
-{
-	size_t i;
+				  "c" (op.epc_addr));
 
-	for (i = 0; i < n; i++)
-		((char *)dest)[i] = ((char *)src)[i];
-
-	return dest;
-}
-
-static void *memset(void *dest, int c, size_t n)
-{
-	size_t i;
-
-	for (i = 0; i < n; i++)
-		((char *)dest)[i] = c;
-
-	return dest;
+	op.ret = rax;
+	copy_outside_enclave(_op, &op, sizeof(op));
 }
 
 static void do_encl_init_tcs_page(void *_op)
 {
-	struct encl_op_init_tcs_page *op = _op;
-	void *tcs = (void *)op->tcs_page;
+	struct encl_op_init_tcs_page op;
+	void *tcs;
 	uint32_t val_32;
 
+	copy_inside_enclave(&op, _op, sizeof(op));
+	assert_inside_enclave(get_enclave_base() + op.ssa, PAGE_SIZE);
+	assert_inside_enclave(get_enclave_base() + op.entry, 1);
+	assert_inside_enclave(op.tcs_page, PAGE_SIZE);
+
+	tcs = (void *)op.tcs_page;
 	memset(tcs, 0, 16);			/* STATE and FLAGS */
-	memcpy(tcs + 16, &op->ssa, 8);		/* OSSA */
+	memcpy(tcs + 16, &op.ssa, 8);		/* OSSA */
 	memset(tcs + 24, 0, 4);			/* CSSA */
 	val_32 = 1;
 	memcpy(tcs + 28, &val_32, 4);		/* NSSA */
-	memcpy(tcs + 32, &op->entry, 8);	/* OENTRY */
+	memcpy(tcs + 32, &op.entry, 8);		/* OENTRY */
 	memset(tcs + 40, 0, 24);		/* AEP, OFSBASE, OGSBASE */
 	val_32 = 0xFFFFFFFF;
 	memcpy(tcs + 64, &val_32, 4);		/* FSLIMIT */
@@ -86,32 +165,54 @@ static void do_encl_init_tcs_page(void *_op)
 	memset(tcs + 72, 0, 4024);		/* Reserved */
 }
 
-static void do_encl_op_put_to_buf(void *op)
+static void do_encl_op_put_to_buf(void *_op)
 {
-	struct encl_op_put_to_buf *op2 = op;
+	struct encl_op_get_from_buf op;
 
-	memcpy(&encl_buffer[0], &op2->value, 8);
+	copy_inside_enclave(&op, _op, sizeof(op));
+	memcpy(&encl_buffer[0], &op.value, 8);
+	copy_outside_enclave(_op, &op, sizeof(op));
 }
 
-static void do_encl_op_get_from_buf(void *op)
+static void do_encl_op_get_from_buf(void *_op)
 {
-	struct encl_op_get_from_buf *op2 = op;
+	struct encl_op_get_from_buf op;
 
-	memcpy(&op2->value, &encl_buffer[0], 8);
+	copy_inside_enclave(&op, _op, sizeof(op));
+	memcpy(&op.value, &encl_buffer[0], 8);
+	copy_outside_enclave(_op, &op, sizeof(op));
 }
 
 static void do_encl_op_put_to_addr(void *_op)
 {
-	struct encl_op_put_to_addr *op = _op;
+	struct encl_op_put_to_addr op;
 
-	memcpy((void *)op->addr, &op->value, 8);
+	copy_inside_enclave(&op, _op, sizeof(op));
+
+	/*
+	 * NOTE: not checking is_outside_enclave(op.addr, 8) here
+	 * deliberately allows arbitrary writes to enclave memory for
+	 * testing purposes.
+	 */
+	memcpy((void *)op.addr, &op.value, 8);
+
+	copy_outside_enclave(_op, &op, sizeof(op));
 }
 
 static void do_encl_op_get_from_addr(void *_op)
 {
-	struct encl_op_get_from_addr *op = _op;
+	struct encl_op_get_from_addr op;
+
+	copy_inside_enclave(&op, _op, sizeof(op));
+
+	/*
+	 * NOTE: not checking is_outside_enclave(op.addr, 8) here
+	 * deliberately allows arbitrary reads from enclave memory for
+	 * testing purposes.
+	 */
+	memcpy(&op.value, (void *)op.addr, 8);
 
-	memcpy(&op->value, (void *)op->addr, 8);
+	copy_outside_enclave(_op, &op, sizeof(op));
 }
 
 static void do_encl_op_nop(void *_op)
@@ -131,9 +232,10 @@ void encl_body(void *rdi,  void *rsi)
 		do_encl_emodpe,
 		do_encl_init_tcs_page,
 	};
+	struct encl_op_header op;
 
-	struct encl_op_header *op = (struct encl_op_header *)rdi;
+	copy_inside_enclave(&op, rdi, sizeof(op));
 
-	if (op->type < ENCL_OP_MAX)
-		(*encl_op_array[op->type])(op);
+	if (op.type < ENCL_OP_MAX)
+		(*encl_op_array[op.type])(rdi);
 }
-- 
2.34.1

