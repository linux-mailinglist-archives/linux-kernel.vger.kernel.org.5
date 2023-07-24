Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E2E75FCC5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjGXQ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjGXQ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:58:54 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4C0E5A;
        Mon, 24 Jul 2023 09:58:51 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 038372005D.ACF16
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:143:242:ac11:20])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 038372005D;
        Mon, 24 Jul 2023 18:58:49 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1690217928;
        bh=Dxe4W9x8+HN82nw05K2qrlUg5MVRgfjaV8O1qUj6+p0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hwmbn9rCqHz1P3oByOgsUimcVdmObnyariMY+tPGekHMmJYi2vKrXWBWipplbR2bG
         xZrREpROqLaG/OU+85t+bcsV9toeIdybkC/Cfp7nMHR3n7qujeOwQ8D8t8Ad9rqVmD
         f2MtIbHdL4FnuUgIb6mBuOKB/M0MFxqR/zhmHqkk=
Received: from librem.epfl.ch (eduroam-269-1-126.epfl.ch [192.33.197.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id C58F9D4EC8A4D;
        Mon, 24 Jul 2023 18:58:48 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH 1/5] selftests/sgx: Fix uninitialized pointer dereference in error path.
Date:   Mon, 24 Jul 2023 18:58:28 +0200
Message-Id: <20230724165832.15797-2-jo.vanbulck@cs.kuleuven.be>
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

Ensure ctx is zero-initialized, such that the encl_measure function will
not call EVP_MD_CTX_destroy with an uninitialized ctx pointer in case of an
early error during key generation.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
---
 tools/testing/selftests/sgx/sigstruct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index a07896a46364..dd1fdab90e26 100644
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
-- 
2.34.1

