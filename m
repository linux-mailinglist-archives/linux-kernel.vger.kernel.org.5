Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C147888C2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245232AbjHYNeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245143AbjHYNdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:33:25 -0400
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3EAE6F;
        Fri, 25 Aug 2023 06:33:23 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 9227C129.AFF41
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id 9227C129;
        Fri, 25 Aug 2023 15:33:20 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692970400;
        bh=j144WYf/8e9sxIhwLkmgCp9/gIlwC5DAeurhO20Sgc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JfBQaVOI3KANtyPGuUYBf6mli+SK7q1Dul8LDNC0ofG7eZ7QCfjEV9aagtGqSy+NB
         JAe/SHA/g2VZ11krQeFJuKe6XJefsdfrYzcpuzwz826HwANjsMJei0K4FGu9v1pwrh
         36IqaekyCZySf55Ckn/ecdYgGs+CCYYg+d5qm4vk=
Received: from localhost.localdomain (ptr-82s0fs8e775rpuqrs36.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:b56b:371:2317:a8f2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 55986D4EBEF26;
        Fri, 25 Aug 2023 15:33:20 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v4 12/13] selftests/sgx: Remove redundant enclave base address save/restore
Date:   Fri, 25 Aug 2023 15:32:51 +0200
Message-Id: <20230825133252.9056-13-jo.vanbulck@cs.kuleuven.be>
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

Remove redundant push/pop pair that stores and restores the enclave base
address in the test enclave, as it is never used after the pop and can
anyway be easily retrieved via the __encl_base symbol.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
---
 tools/testing/selftests/sgx/test_encl_bootstrap.S | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index 4e55d91566c4..28fe5d2ac0af 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -58,12 +58,9 @@ encl_entry_core:
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

