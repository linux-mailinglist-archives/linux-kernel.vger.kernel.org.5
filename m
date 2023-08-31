Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECB978EED7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346367AbjHaNm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345339AbjHaNmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:42:11 -0400
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [134.58.240.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E78E40;
        Thu, 31 Aug 2023 06:42:08 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 09BF32016A.ABE6C
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:139:242:ac11:1e])
        by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id 09BF32016A;
        Thu, 31 Aug 2023 15:42:06 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1693489325;
        bh=NdUR+7nosFPVu+HpEjxUpAINbu4PmwNYym3jDerAKxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lD0AXFKjpmENRB4X0xuZaTAf/+oH5xnX+Lqxqm4v/O4Kow8F1dCRshk3yHUy/lSWM
         EEQa8zDNZYDzFPrOSIfaOuZKOsmvI/g8lG2Y0CPmMAYP4fH2o4mmG1og48nG6ewRj1
         nCOl88P7mrs6WS41Fo4pJ1szwLOF3YckB35B4mtc=
Received: from localhost.localdomain (unknown [10.45.168.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id C08FAD4F6440C;
        Thu, 31 Aug 2023 15:42:05 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v5 03/13] selftests/sgx: Include memory clobber for inline asm in test enclave
Date:   Thu, 31 Aug 2023 15:41:34 +0200
Message-Id: <20230831134144.22686-4-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831134144.22686-1-jo.vanbulck@cs.kuleuven.be>
References: <20230831134144.22686-1-jo.vanbulck@cs.kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "memory" clobber to the EMODPE and EACCEPT asm blocks to tell the
compiler the assembly code accesses to the secinfo struct. This ensures
the compiler treats the asm block as a memory barrier and the write to
secinfo will be visible to ENCLU.

Fixes: 20404a808593 ("selftests/sgx: Add test for EPCM permission changes")
Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/test_encl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index c0d6397295e3..ae791df3e5a5 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -24,10 +24,11 @@ static void do_encl_emodpe(void *_op)
 	secinfo.flags = op->flags;
 
 	asm volatile(".byte 0x0f, 0x01, 0xd7"
-				:
+				: /* no outputs */
 				: "a" (EMODPE),
 				  "b" (&secinfo),
-				  "c" (op->epc_addr));
+				  "c" (op->epc_addr)
+				: "memory" /* read from secinfo pointer */);
 }
 
 static void do_encl_eaccept(void *_op)
@@ -42,7 +43,8 @@ static void do_encl_eaccept(void *_op)
 				: "=a" (rax)
 				: "a" (EACCEPT),
 				  "b" (&secinfo),
-				  "c" (op->epc_addr));
+				  "c" (op->epc_addr)
+				: "memory" /* read from secinfo pointer */);
 
 	op->ret = rax;
 }
-- 
2.25.1

