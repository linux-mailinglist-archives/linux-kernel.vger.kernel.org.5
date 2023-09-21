Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894397A9FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjIUU0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjIUU0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:26:25 -0400
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3BA8CC8F;
        Thu, 21 Sep 2023 10:42:40 -0700 (PDT)
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [134.58.240.133])
        by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id 7A7FB29C7;
        Thu, 21 Sep 2023 16:37:01 +0200 (CEST)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 1BADB201E8.A9C18
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:140:242:ac11:1d])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 1BADB201E8;
        Thu, 21 Sep 2023 16:36:41 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1695307001;
        bh=DkDARNB92D40iLpwhVTiKEDgJy/wmtJ7/ecGi3xcfk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ALXLwVZ+VpB22wRf+2I3R24UjU5LGPWBfWzBxwKoVMYzPMKOyFZm+Rc4kPgAdZEjP
         6DV81j8OASOE3UKTr+rhBPF0EkbHH4lpqWWHy6STAtMv5R4IIoy/zpnqmus+BwWB9e
         WyjLDCmHoU5u/wmwKs8kxfKV0mAWlngDSX+2WQwA=
Received: from localhost.localdomain (ptr-82s0fs8p4onqm1q5sl7.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:c962:1db3:c9ed:fdfb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id D7213D4F30837;
        Thu, 21 Sep 2023 16:36:40 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v6 13/13] selftests/sgx: Remove incomplete ABI sanitization code in test enclave
Date:   Thu, 21 Sep 2023 16:36:04 +0200
Message-Id: <20230921143604.6561-14-jo.vanbulck@cs.kuleuven.be>
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

As the selftest enclave is *not* intended for production, simplify the
code by not initializing CPU configuration registers as expected by the
ABI on enclave entry or cleansing caller-save registers on enclave exit.

Link: https://lore.kernel.org/all/da0cfb1e-e347-f7f2-ac72-aec0ee0d867d@intel.com/
Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 .../testing/selftests/sgx/test_encl_bootstrap.S  | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index 28fe5d2ac0af..d8c4ac94e032 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -59,21 +59,11 @@ encl_entry_core:
 
 	push	%rcx # push the address after EENTER
 
+	# NOTE: as the selftest enclave is *not* intended for production,
+	# simplify the code by not initializing ABI registers on entry or
+	# cleansing caller-save registers on exit.
 	call	encl_body
 
-	/* Clear volatile GPRs, except RAX (EEXIT function). */
-	xor     %rcx, %rcx
-	xor     %rdx, %rdx
-	xor     %rdi, %rdi
-	xor     %rsi, %rsi
-	xor     %r8, %r8
-	xor     %r9, %r9
-	xor     %r10, %r10
-	xor     %r11, %r11
-
-	# Reset status flags.
-	add     %rdx, %rdx # OF = SF = AF = CF = 0; ZF = PF = 1
-
 	# Prepare EEXIT target by popping the address of the instruction after
 	# EENTER to RBX.
 	pop	%rbx
-- 
2.25.1

