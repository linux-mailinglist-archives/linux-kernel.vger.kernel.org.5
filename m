Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BC57598CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjGSOtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjGSOt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:49:26 -0400
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CE41711;
        Wed, 19 Jul 2023 07:49:19 -0700 (PDT)
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:132])
        by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id D37361EE6;
        Wed, 19 Jul 2023 16:25:46 +0200 (CEST)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 6D14C2005F.A9FE9
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:136:242:ac11:f])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 6D14C2005F;
        Wed, 19 Jul 2023 16:25:43 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1689776743;
        bh=JFhy+W9SL4/6R8071U2QocEnLT8+xt0+g+pWSvUXX9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Hhzi3i/uMiFwBe7GYuJ3TV0euVZshQF4DQT4iTIPKPeb932A2pz8lo1INjScAFfF3
         1jVRFL+J6VR0Oe8fjbDcZR6w0oKND8jRxKF/t9Nvqh6SMEDtENPATZUE427952p8S8
         F8s7c24HiXWJcpDzVPVo9+Ix7qPD9HkHOAg5Xw1s=
Received: from librem.epfl.ch (eduroam-269-1-126.epfl.ch [192.33.197.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 36769D4E66FFB;
        Wed, 19 Jul 2023 16:25:43 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH 3/4] selftests/sgx: Harden test enclave API
Date:   Wed, 19 Jul 2023 16:24:59 +0200
Message-Id: <20230719142500.13623-4-jo.vanbulck@cs.kuleuven.be>
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

Adhere to enclave programming best practices and prevent confused-deputy
attacks on the test enclave by validating that untrusted pointer arguments
do not fall inside the protected enclave range.

Note that the test enclave deliberately allows arbitrary reads/writes in
enclave memory through the get_from_addr/put_to_addr operations for
explicit testing purposes. Hence, only allow remaining unchecked pointer
dereferences in these functions.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
---
 tools/testing/selftests/sgx/main.c      |   5 +
 tools/testing/selftests/sgx/test_encl.c | 161 ++++++++++++++++++------
 2 files changed, 128 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index bad963c79..8d60f8dcd 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -355,6 +355,11 @@ TEST_F(enclave, poison_args)
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
index c0d639729..5531f5d48 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -16,37 +16,55 @@ enum sgx_enclu_function {
 	EMODPE = 0x6,
 };
 
-static void do_encl_emodpe(void *_op)
+uint64_t get_enclave_base(void);
+uint64_t get_enclave_size(void);
+
+static int is_outside_enclave(void *addr, size_t len)
 {
-	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
-	struct encl_op_emodpe *op = _op;
+	/* need cast since void pointer arithmetics are undefined in C */
+	size_t start = (size_t) addr;
+	size_t end = start + len - 1;
+	size_t enclave_end = get_enclave_base() + get_enclave_size();
 
-	secinfo.flags = op->flags;
+	/* check for integer overflow with untrusted length */
+	if (start > end)
+		return 0;
 
-	asm volatile(".byte 0x0f, 0x01, 0xd7"
-				:
-				: "a" (EMODPE),
-				  "b" (&secinfo),
-				  "c" (op->epc_addr));
+	return (start > enclave_end || end < get_enclave_base());
 }
 
-static void do_encl_eaccept(void *_op)
+static int is_inside_enclave(void *addr, size_t len)
 {
-	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
-	struct encl_op_eaccept *op = _op;
-	int rax;
+	/* need cast since void pointer arithmetics are undefined in C */
+	size_t start = (size_t) addr;
+	size_t end = start + len - 1;
+	size_t enclave_end = get_enclave_base() + get_enclave_size();
 
-	secinfo.flags = op->flags;
+	/* check for integer overflow with untrusted length */
+	if (start > end)
+		return 0;
 
-	asm volatile(".byte 0x0f, 0x01, 0xd7"
-				: "=a" (rax)
-				: "a" (EACCEPT),
-				  "b" (&secinfo),
-				  "c" (op->epc_addr));
-
-	op->ret = rax;
+	return (start >= get_enclave_base() && end <= enclave_end);
 }
 
+#define PANIC()								\
+	asm("ud2\n\t")
+
+#define SAFE_COPY_STRUCT(u_arg, t_cp)					\
+	do {								\
+		/* 1. check if the argument lies entirely outside */	\
+		if (!is_outside_enclave((void *)u_arg, sizeof(*t_cp)))	\
+			PANIC();					\
+		/* 2. copy the argument inside to prevent TOCTOU */	\
+		memcpy(t_cp, u_arg, sizeof(*t_cp));			\
+	} while (0)
+
+#define ASSERT_INSIDE_ENCLAVE(u_arg, size)				\
+	do {								\
+		if (!is_inside_enclave(((void *)(u_arg)), size))	\
+			PANIC();					\
+	} while (0)
+
 static void *memcpy(void *dest, const void *src, size_t n)
 {
 	size_t i;
@@ -67,18 +85,62 @@ static void *memset(void *dest, int c, size_t n)
 	return dest;
 }
 
+static void do_encl_emodpe(void *_op)
+{
+	struct encl_op_emodpe op;
+	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
+
+	SAFE_COPY_STRUCT(_op, &op);
+	ASSERT_INSIDE_ENCLAVE(op.epc_addr, PAGE_SIZE);
+
+	secinfo.flags = op.flags;
+
+	asm volatile(".byte 0x0f, 0x01, 0xd7"
+				:
+				: "a" (EMODPE),
+				  "b" (&secinfo),
+				  "c" (op.epc_addr));
+}
+
+static void do_encl_eaccept(void *_op)
+{
+	struct encl_op_eaccept op;
+	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
+	int rax;
+
+	SAFE_COPY_STRUCT(_op, &op);
+	ASSERT_INSIDE_ENCLAVE(op.epc_addr, PAGE_SIZE);
+
+	secinfo.flags = op.flags;
+
+	asm volatile(".byte 0x0f, 0x01, 0xd7"
+				: "=a" (rax)
+				: "a" (EACCEPT),
+				  "b" (&secinfo),
+				  "c" (op.epc_addr));
+
+	op.ret = rax;
+	memcpy(_op, &op, sizeof(op));
+}
+
 static void do_encl_init_tcs_page(void *_op)
 {
-	struct encl_op_init_tcs_page *op = _op;
-	void *tcs = (void *)op->tcs_page;
+	struct encl_op_init_tcs_page op;
+	void *tcs;
 	uint32_t val_32;
 
+	SAFE_COPY_STRUCT(_op, &op);
+	tcs = (void *)op.tcs_page;
+	ASSERT_INSIDE_ENCLAVE(tcs, PAGE_SIZE);
+	ASSERT_INSIDE_ENCLAVE(get_enclave_base() + op.ssa, PAGE_SIZE);
+	ASSERT_INSIDE_ENCLAVE(get_enclave_base() + op.entry, 1);
+
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
@@ -86,32 +148,54 @@ static void do_encl_init_tcs_page(void *_op)
 	memset(tcs + 72, 0, 4024);		/* Reserved */
 }
 
-static void do_encl_op_put_to_buf(void *op)
+static void do_encl_op_put_to_buf(void *_op)
 {
-	struct encl_op_put_to_buf *op2 = op;
+	struct encl_op_get_from_buf op;
+
+	SAFE_COPY_STRUCT(_op, &op);
 
-	memcpy(&encl_buffer[0], &op2->value, 8);
+	memcpy(&encl_buffer[0], &op.value, 8);
+	memcpy(_op, &op, sizeof(op));
 }
 
-static void do_encl_op_get_from_buf(void *op)
+static void do_encl_op_get_from_buf(void *_op)
 {
-	struct encl_op_get_from_buf *op2 = op;
+	struct encl_op_get_from_buf op;
 
-	memcpy(&op2->value, &encl_buffer[0], 8);
+	SAFE_COPY_STRUCT(_op, &op);
+
+	memcpy(&op.value, &encl_buffer[0], 8);
+	memcpy(_op, &op, sizeof(op));
 }
 
 static void do_encl_op_put_to_addr(void *_op)
 {
-	struct encl_op_put_to_addr *op = _op;
+	struct encl_op_put_to_addr op;
+
+	SAFE_COPY_STRUCT(_op, &op);
 
-	memcpy((void *)op->addr, &op->value, 8);
+	/*
+	 * NOTE: not checking is_outside_enclave(op.addr, 8) here
+	 * deliberately allows arbitrary writes to enclave memory for
+	 * testing purposes.
+	 */
+	memcpy((void *)op.addr, &op.value, 8);
+	memcpy(_op, &op, sizeof(op));
 }
 
 static void do_encl_op_get_from_addr(void *_op)
 {
-	struct encl_op_get_from_addr *op = _op;
+	struct encl_op_get_from_addr op;
+
+	SAFE_COPY_STRUCT(_op, &op);
 
-	memcpy(&op->value, (void *)op->addr, 8);
+	/*
+	 * NOTE: not checking is_outside_enclave(op.addr, 8) here
+	 * deliberately allows arbitrary reads from enclave memory for
+	 * testing purposes.
+	 */
+	memcpy(&op.value, (void *)op.addr, 8);
+	memcpy(_op, &op, sizeof(op));
 }
 
 static void do_encl_op_nop(void *_op)
@@ -131,9 +215,10 @@ void encl_body(void *rdi,  void *rsi)
 		do_encl_emodpe,
 		do_encl_init_tcs_page,
 	};
+	struct encl_op_header op;
 
-	struct encl_op_header *op = (struct encl_op_header *)rdi;
+	SAFE_COPY_STRUCT(rdi, &op);
 
-	if (op->type < ENCL_OP_MAX)
-		(*encl_op_array[op->type])(op);
+	if (op.type < ENCL_OP_MAX)
+		(*encl_op_array[op.type])(rdi);
 }
-- 
2.34.1

