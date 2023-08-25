Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5BD7888BA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245187AbjHYNdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245108AbjHYNdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:33:22 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA241FDE;
        Fri, 25 Aug 2023 06:33:19 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: B1D2E2016C.A2991
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id B1D2E2016C;
        Fri, 25 Aug 2023 15:33:15 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692970395;
        bh=e1mPUG/ooE9eZdjDbd36N7hpG9BPPbdTR5ohvpBm6LM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=nZL8ky1jMtjiOyeJpZyabj6SfJWF0LCS6JWOxFTnmZpxVz9vJJMWSqtMKNqjN+srV
         EUjRRX5KiCmd3W0m+0vHkrJ04eGFWPBE8xmPn7J26kbMVVx4cerSYFgKXkWNAsD1b+
         TAX/8ZQHdVFN6PZGv+INtxOkDV8AvuMev/Jhu8QI=
Received: from localhost.localdomain (ptr-82s0fs8e775rpuqrs36.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:b56b:371:2317:a8f2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 701DCD4EB98F8;
        Fri, 25 Aug 2023 15:33:15 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v4 06/13] selftests/sgx: Ensure test enclave buffer is entirely preserved
Date:   Fri, 25 Aug 2023 15:32:45 +0200
Message-Id: <20230825133252.9056-7-jo.vanbulck@cs.kuleuven.be>
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

Attach the "used" attribute to instruct the compiler to preserve the static
encl_buffer, even if it appears it is not entirely referenced in the enclave
code, as expected by the external tests manipulating page permissions.

Link: https://lore.kernel.org/all/a2732938-f3db-a0af-3d68-a18060f66e79@cs.kuleuven.be/
Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
---
 tools/testing/selftests/sgx/defines.h   | 1 +
 tools/testing/selftests/sgx/test_encl.c | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index d8587c971941..b8f482667ce1 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -13,6 +13,7 @@
 
 #define __aligned(x) __attribute__((__aligned__(x)))
 #define __packed __attribute__((packed))
+#define __used __attribute__((used))
 
 #include "../../../../arch/x86/include/asm/sgx.h"
 #include "../../../../arch/x86/include/asm/enclu.h"
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index dfe531c5f560..81070492230f 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -5,11 +5,12 @@
 #include "defines.h"
 
 /*
- * Data buffer spanning two pages that will be placed first in .data
- * segment. Even if not used internally the second page is needed by
- * external test manipulating page permissions.
+ * Data buffer spanning two pages that will be placed first in the .data
+ * segment. Even if not used internally the second page is needed by external
+ * test manipulating page permissions, so mark encl_buffer as "used" to make
+ * sure it is entirely preserved by the compiler.
  */
-static uint8_t encl_buffer[8192] = { 1 };
+static uint8_t __used encl_buffer[8192] = { 1 };
 
 enum sgx_enclu_function {
 	EACCEPT = 0x5,
-- 
2.25.1

