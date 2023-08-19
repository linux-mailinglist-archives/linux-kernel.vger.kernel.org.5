Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D417818E7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjHSKkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjHSKkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:40:33 -0400
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008E9149658;
        Sat, 19 Aug 2023 02:44:46 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 982DB20174.A9AC2
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:145:242:ac11:22])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 982DB20174;
        Sat, 19 Aug 2023 11:44:44 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692438284;
        bh=Go3rtD87YXREVaeVp3Xz6onrRpQhrhHVDA9+EDx58PA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Y4q1zaTy/G+VWazPAXrQnv0tyXPM4j0KAAYup5N2U7IegUpPVxSLBE/tLb4EobGPn
         /0c0JL+IslbrCwmFuMNNM47Vb9/xeN4riWlDFBtTYeUJoljvronTSfoNxgEctC784T
         +SEMDXlDTMyDhqiHLr0dI3mEMAENwNJXkp9VG7Z0=
Received: from localhost.localdomain (ip-185-104-137-32.ptr.icomera.net [185.104.137.32])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 9800FD4EB61BA;
        Sat, 19 Aug 2023 11:44:43 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v3 7/9] selftests/sgx: Ensure expected location of test enclave buffer
Date:   Sat, 19 Aug 2023 11:43:30 +0200
Message-Id: <20230819094332.8535-8-jo.vanbulck@cs.kuleuven.be>
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

The external tests manipulating page permissions expect encl_buffer to be
placed at the start of the test enclave's .data section. As this is not
guaranteed per the C standard, explicitly place encl_buffer in a separate
section that is explicitly placed at the start of the .data segment in the
linker script to avoid the compiler placing it somewhere else in .data.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
---
 tools/testing/selftests/sgx/defines.h     | 1 +
 tools/testing/selftests/sgx/test_encl.c   | 8 ++++----
 tools/testing/selftests/sgx/test_encl.lds | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index b8f482667..402f8787a 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -14,6 +14,7 @@
 #define __aligned(x) __attribute__((__aligned__(x)))
 #define __packed __attribute__((packed))
 #define __used __attribute__((used))
+#define __section(x)__attribute__((__section__(x)))
 
 #include "../../../../arch/x86/include/asm/sgx.h"
 #include "../../../../arch/x86/include/asm/enclu.h"
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index c7bcbc85b..151600353 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -6,11 +6,11 @@
 
 /*
  * Data buffer spanning two pages that will be placed first in the .data
- * segment. Even if not used internally the second page is needed by external
- * test manipulating page permissions, so mark encl_buffer as "used" to make
- * sure it is entirely preserved by the compiler.
+ * segment via the linker script. Even if not used internally the second page
+ * is needed by external test manipulating page permissions, so mark
+ * encl_buffer as "used" to make sure it is entirely preserved by the compiler.
  */
-static uint8_t __used encl_buffer[8192] = { 1 };
+static uint8_t __used __section(".data.encl_buffer") encl_buffer[8192] = { 1 };
 
 enum sgx_enclu_function {
 	EACCEPT = 0x5,
diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index 13144b045..ffe851a1c 100644
--- a/tools/testing/selftests/sgx/test_encl.lds
+++ b/tools/testing/selftests/sgx/test_encl.lds
@@ -24,6 +24,7 @@ SECTIONS
 	} : text
 
 	.data : {
+		*(.data.encl_buffer)
 		*(.data*)
 	} : data
 
-- 
2.25.1

