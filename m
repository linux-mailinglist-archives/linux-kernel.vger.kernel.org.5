Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF10D75FCC3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjGXQ65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGXQ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:58:54 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [134.58.240.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AA1126;
        Mon, 24 Jul 2023 09:58:52 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 1232220163.ABA9F
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:143:242:ac11:20])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 1232220163;
        Mon, 24 Jul 2023 18:58:50 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1690217930;
        bh=lD0kiMZBWsG3Ln0sGsNKeezq03rPSOt4ymfz5+VDe5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=X1MseRk3DkU3MNN07Fegf9l2srv+Bl1Gam+0X5B7xHLustc9BncqfUBNhkZB/bSxe
         1nGsE+H9tj39rHG2uugIWeFQhyuo7X9C1subFYGTyYPUOkcyApft7ogcfcBvTZ68D3
         lWCxeDWeflwNWkBP3FZQv2KULHybxfgkwaOvRrxI=
Received: from librem.epfl.ch (eduroam-269-1-126.epfl.ch [192.33.197.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id D3C9DD4E6AE09;
        Mon, 24 Jul 2023 18:58:49 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH 2/5] selftests/sgx: Fix function pointer relocation in test enclave.
Date:   Mon, 24 Jul 2023 18:58:29 +0200
Message-Id: <20230724165832.15797-3-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
References: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relocate encl_op_array entries at runtime relative to the enclave base to
ensure correct function pointer when compiling the test enclave with -Os.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
---
 tools/testing/selftests/sgx/test_encl.c           | 6 ++++--
 tools/testing/selftests/sgx/test_encl.lds         | 1 +
 tools/testing/selftests/sgx/test_encl_bootstrap.S | 5 +++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index c0d6397295e3..4e31a6c3d673 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -119,9 +119,11 @@ static void do_encl_op_nop(void *_op)
 
 }
 
+uint64_t get_enclave_base(void);
+
 void encl_body(void *rdi,  void *rsi)
 {
-	const void (*encl_op_array[ENCL_OP_MAX])(void *) = {
+	static void (*encl_op_array[ENCL_OP_MAX])(void *) = {
 		do_encl_op_put_to_buf,
 		do_encl_op_get_from_buf,
 		do_encl_op_put_to_addr,
@@ -135,5 +137,5 @@ void encl_body(void *rdi,  void *rsi)
 	struct encl_op_header *op = (struct encl_op_header *)rdi;
 
 	if (op->type < ENCL_OP_MAX)
-		(*encl_op_array[op->type])(op);
+		(*(get_enclave_base() + encl_op_array[op->type]))(op);
 }
diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index a1ec64f7d91f..ca659db2a534 100644
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
index 03ae0f57e29d..6126dbd7ad1c 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -86,6 +86,11 @@ encl_entry_core:
 	mov	$4, %rax
 	enclu
 
+	.global get_enclave_base
+get_enclave_base:
+	lea __enclave_base(%rip), %rax
+	ret
+
 	.section ".data", "aw"
 
 encl_ssa_tcs1:
-- 
2.34.1

