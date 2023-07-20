Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9011075BA61
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 00:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjGTWRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 18:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjGTWQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:16:53 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [134.58.240.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD11C271C;
        Thu, 20 Jul 2023 15:16:44 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: BE83920062.A53EC
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:143:242:ac11:20])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id BE83920062;
        Fri, 21 Jul 2023 00:16:42 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1689891402;
        bh=p/mHGCHU9khZV4ahP2OfNg5iVtTSORj6dJBV/UvLFD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WXR1gBZvHSMCVKOSkVSDLVNQ1HqnPY8CT9/76KL/3whkSnHuXNkqfdd0Pin3e69FP
         jXOwtWjl+KRvQwEexQUvXINBHyxmzHTYFA8by+yDR2Tp7x+Ght8cCpB03r3SZp4ciT
         xAt+sCneVAMTgRLgsRMP7hMRbmRXbD1KcBNdTgvo=
Received: from librem.home (unknown [IPv6:2a02:1210:6c17:f000:92c2:ccf4:848b:6bf4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 77134D4EC61F5;
        Fri, 21 Jul 2023 00:16:42 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH 4/4] selftests/sgx: Fix compiler optimizations in test enclave
Date:   Fri, 21 Jul 2023 00:16:23 +0200
Message-Id: <20230720221623.9530-5-jo.vanbulck@cs.kuleuven.be>
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

Relocate encl_op_array entries at runtime relative to the enclave base to
ensure correct function pointer when compiling the test enclave with -Os.

Declare the secinfo struct as volatile to prevent compiler optimizations
from passing an unaligned pointer to ENCLU.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
---
 tools/testing/selftests/sgx/test_encl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index ea24cdf9e..b580c37f3 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -105,7 +105,8 @@ static inline void assert_inside_enclave(uint64_t arg, size_t len)
 static void do_encl_emodpe(void *_op)
 {
 	struct encl_op_emodpe op;
-	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
+	/* declare secinfo volatile to preserve alignment */
+	volatile struct __aligned(sizeof(struct sgx_secinfo)) sgx_secinfo secinfo = {0};
 
 	copy_inside_enclave(&op, _op, sizeof(op));
 	assert_inside_enclave(op.epc_addr, PAGE_SIZE);
@@ -122,8 +123,9 @@ static void do_encl_emodpe(void *_op)
 static void do_encl_eaccept(void *_op)
 {
 	struct encl_op_eaccept op;
-	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
 	int rax;
+	/* declare secinfo volatile to preserve alignment */
+	volatile struct __aligned(sizeof(struct sgx_secinfo)) sgx_secinfo secinfo = {0};
 
 	copy_inside_enclave(&op, _op, sizeof(op));
 	assert_inside_enclave(op.epc_addr, PAGE_SIZE);
@@ -222,7 +224,7 @@ static void do_encl_op_nop(void *_op)
 
 void encl_body(void *rdi,  void *rsi)
 {
-	const void (*encl_op_array[ENCL_OP_MAX])(void *) = {
+	static const void (*encl_op_array[ENCL_OP_MAX])(void *) = {
 		do_encl_op_put_to_buf,
 		do_encl_op_get_from_buf,
 		do_encl_op_put_to_addr,
@@ -237,5 +239,5 @@ void encl_body(void *rdi,  void *rsi)
 	copy_inside_enclave(&op, rdi, sizeof(op));
 
 	if (op.type < ENCL_OP_MAX)
-		(*encl_op_array[op.type])(rdi);
+		(*(get_enclave_base() + encl_op_array[op.type]))(rdi);
 }
-- 
2.34.1

