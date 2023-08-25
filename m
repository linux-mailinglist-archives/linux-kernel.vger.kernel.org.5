Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEA77888B4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245157AbjHYNd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245096AbjHYNdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:33:18 -0400
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [134.58.240.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59522128;
        Fri, 25 Aug 2023 06:33:16 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 4BF75113.A2BD5
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id 4BF75113;
        Fri, 25 Aug 2023 15:33:13 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692970393;
        bh=w/HbENVl+Yg9iILbZKZpZMp43oAvJJAVp05zuGTRdrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kifcq7xnIpJE8kb5H0MWIOMK9rrwxOg1mKVeX8srzRsS1kV7JbZeB81JdGipNP71X
         EH6Gmtt2jwOlqn8CMpB15nmHE6eD+I/X2Ebgpg7U6QfkrqtskO4+Rw1dE7SnKxlXs5
         +vslGazVZVD7C2e/xu47YQiC5vKf8E2+9s7aTVnM=
Received: from localhost.localdomain (ptr-82s0fs8e775rpuqrs36.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:b56b:371:2317:a8f2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 0AA7ED4EBACBB;
        Fri, 25 Aug 2023 15:33:13 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v4 03/13] selftests/sgx: Handle relocations in test enclave
Date:   Fri, 25 Aug 2023 15:32:42 +0200
Message-Id: <20230825133252.9056-4-jo.vanbulck@cs.kuleuven.be>
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

Static-pie binaries normally include a startup routine to perform any ELF
relocations from .rela.dyn. Since the enclave loading process is different
and glibc is not included, do the necessary relocation for encl_op_array
entries manually at runtime relative to the enclave base to ensure correct
function pointers.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/test_encl.c | 48 +++++++++++++++++--------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index c0d6397295e3..706c1f7260ff 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -119,21 +119,39 @@ static void do_encl_op_nop(void *_op)
 
 }
 
+/*
+ * Symbol placed at the start of the enclave image by the linker script.
+ * Declare this extern symbol with visibility "hidden" to ensure the
+ * compiler does not access it through the GOT.
+ */
+extern const uint8_t __attribute__((visibility("hidden"))) __encl_base;
+
+typedef void (*encl_op_t)(void *);
+static const encl_op_t encl_op_array[ENCL_OP_MAX] = {
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
+	 * The enclave base address needs to be added, as this call site
+	 * *cannot be* made rip-relative by the compiler, or fixed up by
+	 * any other possible means.
+	 */
+	op = ((uint64_t)&__encl_base) + encl_op_array[header->type];
+
+	(*op)(header);
 }
-- 
2.25.1

