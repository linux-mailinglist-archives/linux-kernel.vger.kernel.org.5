Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6894D7A9FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjIUU1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjIUU0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:26:41 -0400
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CFB8C634;
        Thu, 21 Sep 2023 10:42:34 -0700 (PDT)
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [134.58.240.131])
        by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id A3F7D299C;
        Thu, 21 Sep 2023 16:36:58 +0200 (CEST)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 51194201BA.AED27
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:140:242:ac11:1d])
        by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id 51194201BA;
        Thu, 21 Sep 2023 16:36:38 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1695306998;
        bh=NdUR+7nosFPVu+HpEjxUpAINbu4PmwNYym3jDerAKxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bpTRGeDDukL4LXpKSwzaIleGdAFs0lZQ6aqtoLIthWCc3cXrSEwP7XOesFutciQnl
         RA8WchEs+KmJlREAD3HePXJuNTb7AaT3BedHTC2OT9w7qQ3aEO5s5F44yp8scx2swW
         Sg4zfx2Mzs+2HP/RIiXQ5OA9EIir/TNeaxARrxPQ=
Received: from localhost.localdomain (ptr-82s0fs8p4onqm1q5sl7.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:c962:1db3:c9ed:fdfb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 1A92DD4F38757;
        Thu, 21 Sep 2023 16:36:38 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v6 03/13] selftests/sgx: Include memory clobber for inline asm in test enclave
Date:   Thu, 21 Sep 2023 16:35:54 +0200
Message-Id: <20230921143604.6561-4-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921143604.6561-1-jo.vanbulck@cs.kuleuven.be>
References: <20230921143604.6561-1-jo.vanbulck@cs.kuleuven.be>
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

