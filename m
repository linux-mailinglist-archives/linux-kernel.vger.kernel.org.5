Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE6278EED2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346150AbjHaNmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345431AbjHaNmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:42:13 -0400
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [134.58.240.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6C3CEB;
        Thu, 31 Aug 2023 06:42:10 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 7A22D146.A85DD
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:139:242:ac11:1e])
        by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id 7A22D146;
        Thu, 31 Aug 2023 15:42:08 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1693489328;
        bh=G6MSMTKkZN7DyiwjN3c8ohciKNBn5ePbhZJEt6SrDZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YX9MhDxZZPB+ZBu37m+DdzYmdWYnD+nWly8s5cb7Az6ygqxO1KrMLv120XnGBEQEC
         7Art5FCkBxU3fz0ymlyzmDFXD+ERpk3zCZVhU6/gB3dY8kfddODfaYDPm9E4hjyAOW
         bNgWoomF9bCytpbNePjPM5CTnrZ93BfsPRU/6z3Q=
Received: from localhost.localdomain (unknown [10.45.168.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 3E231D4F643EF;
        Thu, 31 Aug 2023 15:42:08 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v5 06/13] selftests/sgx: Remove redundant enclave base address save/restore
Date:   Thu, 31 Aug 2023 15:41:37 +0200
Message-Id: <20230831134144.22686-7-jo.vanbulck@cs.kuleuven.be>
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

Remove redundant push/pop pair that stores and restores the enclave base
address in the test enclave, as it is never used after the pop and can
anyway be easily retrieved via the __encl_base symbol.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Acked-by: Kai Huang <kai.huang@intel.com>
---
 tools/testing/selftests/sgx/test_encl_bootstrap.S | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index 03ae0f57e29d..e0ce993d3f2c 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -55,12 +55,9 @@ encl_entry_core:
 	push	%rax
 
 	push	%rcx # push the address after EENTER
-	push	%rbx # push the enclave base address
 
 	call	encl_body
 
-	pop	%rbx # pop the enclave base address
-
 	/* Clear volatile GPRs, except RAX (EEXIT function). */
 	xor     %rcx, %rcx
 	xor     %rdx, %rdx
-- 
2.25.1

