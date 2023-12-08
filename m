Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6EE80ABBA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574522AbjLHSM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjLHSMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:12:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2A311F;
        Fri,  8 Dec 2023 10:12:59 -0800 (PST)
Date:   Fri, 08 Dec 2023 18:12:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702059177;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Zn/FVBnPio9SbNtzmjX08TH6ufNpTFSAMDK6aNVelYM=;
        b=e+t5TsZ0JlcVFOldOzRLkG4V3VRg2II18RrnqBlVDVBbzGXHHSm+RDfZ1FttK9nK8WpWvZ
        WeIvVH14LQWCU7Vv/0BYWWNAXLaRwRo8Kth/DE//Aj9rF6jG7bB0HV8q2o5QIAyJywKNOL
        xrk3OtVCxQbNQZt6JzO599qMD02vFvundqgFbnQ8ZCszoNRj8jB6/YBUiA+HS2rQbttaTg
        m8u2tPdvP5S/37o4Ya0/IZvEh264x3xCsDBqAcQXHudVD4KNIzDUGxxMP5Sd4oZNz0KwDt
        LgbQVIpFzbNZRCynHB38Sxo5ZSVZFS6DEbW4t/Ljx+N6FRDbNe4lleB5iP7AsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702059177;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Zn/FVBnPio9SbNtzmjX08TH6ufNpTFSAMDK6aNVelYM=;
        b=aor1wBqmvDhV9fSoWFSYy3KsOX63G4y1gTKs4MmaBOPozxxgpNF6Uw5pZqquqCmpD/Ze2j
        Ac/8HfxasiXUA/AQ==
From:   "tip-bot2 for Jo Van Bulck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Ensure expected location of test enclave buffer
Cc:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205917698.398.13586264713492467391.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     022416496008bd51cb7b33975cc0008749329a86
Gitweb:        https://git.kernel.org/tip/022416496008bd51cb7b33975cc0008749329a86
Author:        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
AuthorDate:    Thu, 05 Oct 2023 17:38:52 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:05:27 -08:00

selftests/sgx: Ensure expected location of test enclave buffer

The external tests manipulating page permissions expect encl_buffer to be
placed at the start of the test enclave's .data section. As this is not
guaranteed per the C standard, explicitly place encl_buffer in a separate
section that is explicitly placed at the start of the .data segment in the
linker script to avoid the compiler placing it somewhere else in .data.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/20231005153854.25566-12-jo.vanbulck%40cs.kuleuven.be
---
 tools/testing/selftests/sgx/defines.h     | 1 +
 tools/testing/selftests/sgx/test_encl.c   | 8 ++++----
 tools/testing/selftests/sgx/test_encl.lds | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index b8f4826..402f878 100644
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
index 7465f12..2c4d709 100644
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
index 6ffdfc9..333a3e7 100644
--- a/tools/testing/selftests/sgx/test_encl.lds
+++ b/tools/testing/selftests/sgx/test_encl.lds
@@ -24,6 +24,7 @@ SECTIONS
 	} : text
 
 	.data : {
+		*(.data.encl_buffer)
 		*(.data*)
 	} : data
 
