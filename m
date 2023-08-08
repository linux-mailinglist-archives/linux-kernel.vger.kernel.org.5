Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC9F774A3E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjHHUXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjHHUX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:23:27 -0400
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [134.58.240.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62D21CEB7;
        Tue,  8 Aug 2023 12:32:30 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 31E8E18.A01A5
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id 31E8E18;
        Tue,  8 Aug 2023 21:32:28 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1691523148;
        bh=O3MMx1jKqCMBrmzHHiOZ5ZmxbK2aeGgwborI0xITkqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MojbsmE41ABMVdaf/em/GKdwZCBuZyYW+0EtOkEuAVt1Yq8OBrDEmnZF79wjWWshy
         N0lFjjOjJcG6fFXsFj+dPKTfUrwshYj9mz5EN02EHJTQ0j1rQ+XDXk6oBudgqkGFM3
         3ZGwGLQxHPA6vJo+LXMWdauYe05HNeHWUId6zbVk=
Received: from localhost.localdomain (rrcs-24-123-120-98.central.biz.rr.com [24.123.120.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 980DDD4F7C0E7;
        Tue,  8 Aug 2023 21:32:26 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH 3/8] selftests/sgx: Handle relocations in test enclave
Date:   Tue,  8 Aug 2023 12:31:40 -0700
Message-Id: <20230808193145.8860-4-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808193145.8860-1-jo.vanbulck@cs.kuleuven.be>
References: <20230808193145.8860-1-jo.vanbulck@cs.kuleuven.be>
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
 tools/testing/selftests/sgx/test_encl.c   | 35 +++++++++++++++--------
 tools/testing/selftests/sgx/test_encl.lds |  3 ++
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index c0d6397295e3..c71dfbadd2d9 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -119,21 +119,32 @@ static void do_encl_op_nop(void *_op)
 
 }
 
+/*
+ * Symbol placed at the start of the enclave image by the linker script.
+ * Declare this extern symbol with visibility "hidden" to ensure the
+ * compiler does not access it through the GOT.
+ */
+extern uint8_t __attribute__((visibility("hidden"))) __enclave_base;
+
+void (*encl_op_array[ENCL_OP_MAX])(void *) = {
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
 	struct encl_op_header *op = (struct encl_op_header *)rdi;
 
+	/*
+	 * Manually rebase the loaded function pointer as enclaves cannot
+	 * rely on startup routines to perform static pie relocations.
+	 */
 	if (op->type < ENCL_OP_MAX)
-		(*encl_op_array[op->type])(op);
+		(*(((uint64_t) &__enclave_base) + encl_op_array[op->type]))(op);
 }
diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index ca659db2a534..73d9c8bbe7de 100644
--- a/tools/testing/selftests/sgx/test_encl.lds
+++ b/tools/testing/selftests/sgx/test_encl.lds
@@ -32,6 +32,9 @@ SECTIONS
 		*(.note*)
 		*(.debug*)
 		*(.eh_frame*)
+		/* Dynamic symbol table not supported in enclaves */
+		*(.dyn*)
+		*(.gnu.hash)
 	}
 }
 
-- 
2.34.1

