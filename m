Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FAE75FCC6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjGXQ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjGXQ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:58:55 -0400
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE2410CE;
        Mon, 24 Jul 2023 09:58:53 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 34CDE20172.A54AF
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:143:242:ac11:20])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 34CDE20172;
        Mon, 24 Jul 2023 18:58:52 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1690217932;
        bh=3sTVjBcJqPPjo0OYzuqe+tfGHRmT4ncnbaTXkKSK/8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ue2HPViRtDvweYElbzuySHqCl1DMqOYVqkL9UDu4XyGNXo5uBgQSiT1tgHU9+oyLR
         p8doeRmvjGreVh06CSr+ISFNMd76XT7auLLlmfHexCeUY8iPo9O9RWPrNhBP9rlaBe
         Xd6aDJHapSjvFzZ2czbENmcXKaky8ZNJUucmlW8c=
Received: from librem.epfl.ch (eduroam-269-1-126.epfl.ch [192.33.197.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 04B32D4EC8A4D;
        Mon, 24 Jul 2023 18:58:51 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH 3/5] selftests/sgx: Ensure correct secinfo struct alignment in test enclave.
Date:   Mon, 24 Jul 2023 18:58:30 +0200
Message-Id: <20230724165832.15797-4-jo.vanbulck@cs.kuleuven.be>
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

Declare the secinfo struct as volatile to prevent compiler optimizations
from passing an unaligned pointer to ENCLU.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
---
 tools/testing/selftests/sgx/test_encl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index 4e31a6c3d673..aba301abefb8 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -18,7 +18,8 @@ enum sgx_enclu_function {
 
 static void do_encl_emodpe(void *_op)
 {
-	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
+	/* declare secinfo volatile to preserve alignment */
+	volatile struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
 	struct encl_op_emodpe *op = _op;
 
 	secinfo.flags = op->flags;
@@ -32,7 +33,8 @@ static void do_encl_emodpe(void *_op)
 
 static void do_encl_eaccept(void *_op)
 {
-	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
+	/* declare secinfo volatile to preserve alignment */
+	volatile struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
 	struct encl_op_eaccept *op = _op;
 	int rax;
 
-- 
2.34.1

