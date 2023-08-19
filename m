Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F1D7818E1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjHSKkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjHSKka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:40:30 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3173010E84A;
        Sat, 19 Aug 2023 02:44:07 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 1D9E42005A.A6461
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:145:242:ac11:22])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 1D9E42005A;
        Sat, 19 Aug 2023 11:44:02 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692438242;
        bh=qYpkmbdvc8VnZBswzR4/5zVtk1WS0m64jDrwetC+1zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MPQNqC2sZDdgPm05jIJIwUwwq1loUblWW8ETPmRSbZF7Q1vwyT8PQt7BenPChoqlw
         CvbOawcw1dw0Jk/EM0tGDT+KfGYIIhW+c83JANhFfCVeYX+4A0BZYljzvEfUAzcuVB
         cwC54xrQnUdFfhC0bl7l07+g+JczybW92FSqYp94=
Received: from localhost.localdomain (ip-185-104-137-32.ptr.icomera.net [185.104.137.32])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 16166D4EB61BA;
        Sat, 19 Aug 2023 11:44:00 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v3 1/9] selftests/sgx: Fix uninitialized pointer dereference in error path
Date:   Sat, 19 Aug 2023 11:43:24 +0200
Message-Id: <20230819094332.8535-2-jo.vanbulck@cs.kuleuven.be>
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

Ensure ctx is zero-initialized, such that the encl_measure function will
not call EVP_MD_CTX_destroy with an uninitialized ctx pointer in case of an
early error during key generation.

Fixes: 2adcba79e69d ("selftests/x86: Add a selftest for SGX")
Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
---
 tools/testing/selftests/sgx/sigstruct.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index a07896a46..d73b29bec 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -318,9 +318,9 @@ bool encl_measure(struct encl *encl)
 	struct sgx_sigstruct *sigstruct = &encl->sigstruct;
 	struct sgx_sigstruct_payload payload;
 	uint8_t digest[SHA256_DIGEST_LENGTH];
+	EVP_MD_CTX *ctx = NULL;
 	unsigned int siglen;
 	RSA *key = NULL;
-	EVP_MD_CTX *ctx;
 	int i;
 
 	memset(sigstruct, 0, sizeof(*sigstruct));
@@ -384,7 +384,8 @@ bool encl_measure(struct encl *encl)
 	return true;
 
 err:
-	EVP_MD_CTX_destroy(ctx);
+	if (ctx)
+		EVP_MD_CTX_destroy(ctx);
 	RSA_free(key);
 	return false;
 }
-- 
2.25.1

