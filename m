Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795EB774CE5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbjHHVUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbjHHVUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:20:37 -0400
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834C12CC64;
        Tue,  8 Aug 2023 12:32:40 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: BA371201BC.ACF76
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id BA371201BC;
        Tue,  8 Aug 2023 21:32:36 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1691523156;
        bh=45eKLn1uTvX7SPSO9cENYgFYF5bDArNL/pm57s2DnUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RdmIBYUJD2p/ZwL/QaG0Tmd3o/AZP615N4EpVYf/1txA5DtqE7mrz3BYKjdZEqmam
         UggH7tNjiEQkTexswE9mgkwmqeQz41uzRI5R+4OihuVg3DXgBZ3dgJIi8v0Q3Y8Uus
         z9XSmIAuRnshtHtU3SS1HI5i8Z4GHOmsJpDMRLrs=
Received: from localhost.localdomain (rrcs-24-123-120-98.central.biz.rr.com [24.123.120.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 2657BD4F6521B;
        Tue,  8 Aug 2023 21:32:34 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH 6/8] selftests/sgx: Ensure expected enclave data buffer size and placement
Date:   Tue,  8 Aug 2023 12:31:43 -0700
Message-Id: <20230808193145.8860-7-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808193145.8860-1-jo.vanbulck@cs.kuleuven.be>
References: <20230808193145.8860-1-jo.vanbulck@cs.kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure the compiler respects the size and placement of encl_buffer as
expected by the external tests manipulating page permissions:

1. Declare encl_buffer as global, in order to ensure that it is not
   optimized away by the compiler, even when not used entirely by the test
   enclave code.

2. Place encl_buffer in a separate section that is explicitly placed
   at the start of the .data segment in the linker script to avoid the
   compiler placing it somewhere else in .data.

Link: https://lore.kernel.org/all/a2732938-f3db-a0af-3d68-a18060f66e79@cs.kuleuven.be/
Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
---
 tools/testing/selftests/sgx/test_encl.c   | 9 +++++----
 tools/testing/selftests/sgx/test_encl.lds | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index 5b758eaf808c..02a9e8c55e82 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -5,11 +5,12 @@
 #include "defines.h"
 
 /*
- * Data buffer spanning two pages that will be placed first in .data
- * segment. Even if not used internally the second page is needed by
- * external test manipulating page permissions.
+ * Data buffer spanning two pages that will be placed first in the .data
+ * segment via the linker script. Even if not used internally the second page
+ * is needed by external test manipulating page permissions, so do not declare
+ * encl_buffer as static to make sure it is entirely preserved by the compiler.
  */
-static uint8_t encl_buffer[8192] = { 1 };
+uint8_t __attribute__((section(".data.encl_buffer"))) encl_buffer[8192];
 
 enum sgx_enclu_function {
 	EACCEPT = 0x5,
diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index 27c2527ecbc4..2ec29340ba94 100644
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

