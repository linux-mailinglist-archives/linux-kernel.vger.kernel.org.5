Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A9A80ABC0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574523AbjLHSNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjLHSMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:12:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD502133;
        Fri,  8 Dec 2023 10:12:59 -0800 (PST)
Date:   Fri, 08 Dec 2023 18:12:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702059178;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=i8RSaAj1FoNLBcjrSnL0NCPi3yBIbLyBZKtk3ha6yyA=;
        b=WOoKNHyYaV+P3u37nwZGlqNKqqQt8D87qAKNyrcp/h2n6dAda5LnodpvTgBHNzaWCdvDDb
        FzzZg9dQwhd8HBVSwrOvn3s2o4im7LaROz4a74PvKa92AvvMK/06FAVTVked2/zawLXjyp
        vrDB9wzqINnHF5sE3eKJrqMOXrq3AdhXRdZfhv2hCvg2e7FA6q5g94v6pDThdskCmJYdQr
        tdtI/Eut/vkaQVxuKzARJAAczdlrcYDFVbqS5eqQjpXPvPxtA3JBSRihmp5TwPk0ib2jBO
        Vhd9LC2u9F9qGbSsNdZJtZ5uOGOmTTi7WO641sD1l0vGk8UZHFFaxqNZNl1NsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702059178;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=i8RSaAj1FoNLBcjrSnL0NCPi3yBIbLyBZKtk3ha6yyA=;
        b=HmoS92ZVfedx998orBwSSrPw/uETEZQHm6yQYdjwOkKsfpnPMR++7150Fpj7fsbq5xbMF1
        4kaFo8UlZDa/M2Cw==
From:   "tip-bot2 for Jo Van Bulck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Ensure test enclave buffer is entirely
 preserved
Cc:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205917777.398.5382474413072090594.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     a4c39ef4ed43103caef80029cd30427a9ff342d8
Gitweb:        https://git.kernel.org/tip/a4c39ef4ed43103caef80029cd30427a9ff342d8
Author:        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
AuthorDate:    Thu, 05 Oct 2023 17:38:51 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:05:27 -08:00

selftests/sgx: Ensure test enclave buffer is entirely preserved

Attach the "used" attribute to instruct the compiler to preserve the static
encl_buffer, even if it appears it is not entirely referenced in the enclave
code, as expected by the external tests manipulating page permissions.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/a2732938-f3db-a0af-3d68-a18060f66e79@cs.kuleuven.be/
Link: https://lore.kernel.org/all/20231005153854.25566-11-jo.vanbulck%40cs.kuleuven.be
---
 tools/testing/selftests/sgx/defines.h   |  1 +
 tools/testing/selftests/sgx/test_encl.c |  9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index d8587c9..b8f4826 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -13,6 +13,7 @@
 
 #define __aligned(x) __attribute__((__aligned__(x)))
 #define __packed __attribute__((packed))
+#define __used __attribute__((used))
 
 #include "../../../../arch/x86/include/asm/sgx.h"
 #include "../../../../arch/x86/include/asm/enclu.h"
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index 649604c..7465f12 100644
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
