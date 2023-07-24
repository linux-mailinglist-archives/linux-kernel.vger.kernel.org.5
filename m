Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F71075FCC7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjGXQ7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjGXQ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:58:56 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F02126;
        Mon, 24 Jul 2023 09:58:55 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 1D22F2005D.A8315
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:143:242:ac11:20])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 1D22F2005D;
        Mon, 24 Jul 2023 18:58:53 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1690217933;
        bh=Gi0IyqkKqOBe/zI/Lx9svnal+udDUH2FRaFTai1kGtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SHRygbfxOBfDkmBGSA75+2n1rA0RJm3xAeNC/GcGQAorTNuZxhlbyRpk+VPkcPqfw
         hzPsgw2BS8leWj1Wr2lpAPZOqf6uxC45XS4mrGoSSa9KY4h0H4dw+5vyKvpmD0GILt
         ce/U316itZYCOUJyyqUKiybF5Og+XYopBbcNxfkQ=
Received: from librem.epfl.ch (eduroam-269-1-126.epfl.ch [192.33.197.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id DE1B3D4ECBC84;
        Mon, 24 Jul 2023 18:58:52 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH 4/5] selftests/sgx: Ensure expected enclave data buffer size and placement.
Date:   Mon, 24 Jul 2023 18:58:31 +0200
Message-Id: <20230724165832.15797-5-jo.vanbulck@cs.kuleuven.be>
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

Do not declare the enclave data buffer static to ensure it is not optimized
away by the compiler, even when not used entirely by the test enclave code.
Use -fPIE to make the compiler access the non-static buffer with
RIP-relative addressing. Place the enclave data buffer in a separate
section that is explicitly placed at the start of the .data segment in the
linker script, as expected by the external tests manipulating page
permissions.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
---
 tools/testing/selftests/sgx/Makefile      | 2 +-
 tools/testing/selftests/sgx/test_encl.c   | 5 +++--
 tools/testing/selftests/sgx/test_encl.lds | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 50aab6b57da3..c5483445ba28 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -13,7 +13,7 @@ endif
 
 INCLUDES := -I$(top_srcdir)/tools/include
 HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC -z noexecstack
-ENCL_CFLAGS := -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
+ENCL_CFLAGS := -Wall -Werror -static -nostdlib -nostartfiles -fPIE \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
 
 TEST_CUSTOM_PROGS := $(OUTPUT)/test_sgx
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index aba301abefb8..5c274e517d13 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -7,9 +7,10 @@
 /*
  * Data buffer spanning two pages that will be placed first in .data
  * segment. Even if not used internally the second page is needed by
- * external test manipulating page permissions.
+ * external test manipulating page permissions. Do not declare this
+ * buffer as static, so the compiler cannot optimize it out.
  */
-static uint8_t encl_buffer[8192] = { 1 };
+uint8_t __attribute__((section(".data.encl_buffer"))) encl_buffer[8192];
 
 enum sgx_enclu_function {
 	EACCEPT = 0x5,
diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index ca659db2a534..79b1e41d8d24 100644
--- a/tools/testing/selftests/sgx/test_encl.lds
+++ b/tools/testing/selftests/sgx/test_encl.lds
@@ -24,6 +24,7 @@ SECTIONS
 	} : text
 
 	.data : {
+		*(.data.encl_buffer)
 		*(.data*)
 	} : data
 
-- 
2.34.1

