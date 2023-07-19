Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575FB7598C9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjGSOt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjGSOtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:49:25 -0400
X-Greylist: delayed 1420 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Jul 2023 07:49:19 PDT
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBC111B;
        Wed, 19 Jul 2023 07:49:19 -0700 (PDT)
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:132])
        by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id 40DAF1EFF;
        Wed, 19 Jul 2023 16:25:49 +0200 (CEST)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 6937920172.A944A
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:136:242:ac11:f])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 6937920172;
        Wed, 19 Jul 2023 16:25:44 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1689776744;
        bh=5z6MJatlb5WblaaYzgRyXrmUXZWjDHrlu7vyGhgqg2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JW9DEm3ick7ApuOSP3FNiVODaBf8i7CQPoKihhhoq4aq3yujoarkCscviGKf4LiRa
         Chx/DxULB9XMJrWOxWqE4/3s1yFnTzVWgoig3LH1JTBDiHWHBjo2kyxopHIHrObpWY
         mxl7HaNM0k//MZBtY4JyWBqI5CvniiaQGuAffKdM=
Received: from librem.epfl.ch (eduroam-269-1-126.epfl.ch [192.33.197.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 38BBBD4EC4971;
        Wed, 19 Jul 2023 16:25:44 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH 4/4] selftests/sgx: Fix compiler optimizations in test enclave
Date:   Wed, 19 Jul 2023 16:25:00 +0200
Message-Id: <20230719142500.13623-5-jo.vanbulck@cs.kuleuven.be>
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

Relocate encl_op_array entries at runtime relative to the enclave base to
ensure correct function pointer when compiling the test enclave with -Os.

Declare the secinfo struct as volatile to prevent compiler optimizations
from passing an unaligned pointer to ENCLU.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
---
 tools/testing/selftests/sgx/test_encl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index 5531f5d48..d78596ccf 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -88,7 +88,8 @@ static void *memset(void *dest, int c, size_t n)
 static void do_encl_emodpe(void *_op)
 {
 	struct encl_op_emodpe op;
-	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
+	/* declare secinfo volatile to preserve alignment */
+	volatile struct __aligned(sizeof(struct sgx_secinfo)) sgx_secinfo secinfo = {0};
 
 	SAFE_COPY_STRUCT(_op, &op);
 	ASSERT_INSIDE_ENCLAVE(op.epc_addr, PAGE_SIZE);
@@ -105,8 +106,9 @@ static void do_encl_emodpe(void *_op)
 static void do_encl_eaccept(void *_op)
 {
 	struct encl_op_eaccept op;
-	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
 	int rax;
+	/* declare secinfo volatile to preserve alignment */
+	volatile struct __aligned(sizeof(struct sgx_secinfo)) sgx_secinfo secinfo = {0};
 
 	SAFE_COPY_STRUCT(_op, &op);
 	ASSERT_INSIDE_ENCLAVE(op.epc_addr, PAGE_SIZE);
@@ -205,7 +207,7 @@ static void do_encl_op_nop(void *_op)
 
 void encl_body(void *rdi,  void *rsi)
 {
-	const void (*encl_op_array[ENCL_OP_MAX])(void *) = {
+	static const void (*encl_op_array[ENCL_OP_MAX])(void *) = {
 		do_encl_op_put_to_buf,
 		do_encl_op_get_from_buf,
 		do_encl_op_put_to_addr,
@@ -220,5 +222,5 @@ void encl_body(void *rdi,  void *rsi)
 	SAFE_COPY_STRUCT(rdi, &op);
 
 	if (op.type < ENCL_OP_MAX)
-		(*encl_op_array[op.type])(rdi);
+		(*(get_enclave_base() + encl_op_array[op.type]))(rdi);
 }
-- 
2.34.1

