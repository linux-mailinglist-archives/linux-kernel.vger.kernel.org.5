Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC587818E2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjHSKkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjHSKka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:40:30 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [134.58.240.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69805110245;
        Sat, 19 Aug 2023 02:44:27 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: CEE652020E.ABDB5
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:145:242:ac11:22])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id CEE652020E;
        Sat, 19 Aug 2023 11:44:25 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692438265;
        bh=ce5jn7+M4VSNKZDCgixq1Z8Vu3OOMYc0lEug27ax9C0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Yi8HzDGvn+hIvyLF18CaRct8UMlVhMqbjbVeCG9WA6pGCqkC2zn3oRJM2MPmRdoCS
         LQ0BnUVq5vRZAyxhEFodd/3jukBPlG9bzqhNMfm9nhZdj0GbaZtuFqGQOYwRPnVDb8
         pa58WWFSmVjvRM1Ifk1fB+XOUrXu3h7IESAXW2UI=
Received: from localhost.localdomain (ip-185-104-137-32.ptr.icomera.net [185.104.137.32])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id BC2DFD4EB61BA;
        Sat, 19 Aug 2023 11:44:24 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v3 3/9] selftests/sgx: Handle relocations in test enclave
Date:   Sat, 19 Aug 2023 11:43:26 +0200
Message-Id: <20230819094332.8535-4-jo.vanbulck@cs.kuleuven.be>
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

Static-pie binaries normally include a startup routine to perform any ELF
relocations from .rela.dyn. Since the enclave loading process is different
and glibc is not included, do the necessary relocation for encl_op_array
entries manually at runtime relative to the enclave base to ensure correct
function pointers.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
---
 tools/testing/selftests/sgx/test_encl.c   | 49 ++++++++++++++++-------
 tools/testing/selftests/sgx/test_encl.lds |  2 +
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index c0d639729..7633fb7cb 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -119,21 +119,40 @@ static void do_encl_op_nop(void *_op)
 
 }
 
+/*
+ * Symbol placed at the start of the enclave image by the linker script.
+ * Declare this extern symbol with visibility "hidden" to ensure the
+ * compiler does not access it through the GOT.
+ */
+extern const uint8_t __attribute__((visibility("hidden"))) __encl_base;
+static const uint64_t encl_base = (uint64_t)&__encl_base;
+
+typedef void (*encl_op_t)(void *);
+const encl_op_t encl_op_array[ENCL_OP_MAX] = {
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
+	 * "encl_base" needs to be added, as this call site *cannot be*
+	 * made rip-relative by the compiler, or fixed up by any other
+	 * possible means.
+	 */
+	op = encl_base + encl_op_array[header->type];
+
+	(*op)(header);
 }
diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index 62d37160f..b86c86060 100644
--- a/tools/testing/selftests/sgx/test_encl.lds
+++ b/tools/testing/selftests/sgx/test_encl.lds
@@ -32,6 +32,8 @@ SECTIONS
 		*(.note*)
 		*(.debug*)
 		*(.eh_frame*)
+		*(.dyn*)
+		*(.gnu.hash)
 	}
 }
 
-- 
2.25.1

