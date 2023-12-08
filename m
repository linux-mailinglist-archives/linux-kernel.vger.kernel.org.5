Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368AA80ABC5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574596AbjLHSNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574490AbjLHSM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:12:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CC211F;
        Fri,  8 Dec 2023 10:13:02 -0800 (PST)
Date:   Fri, 08 Dec 2023 18:13:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702059181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yvm4+gDjc9yZRURvOF5hsHgmgIuQOiG3VThauBnHAuM=;
        b=fZLsZDj2W6KDZXbVMq6WgFFW3z1ROEn+G8dQ0q1ZbNpvWaluEv2XEYb0ezcy1FDA2NQPrg
        zKHaLjtpsYsbnjBE9C/iv5nJ0/wXI4EqYFnDMDiIF/YnhJXmpuumzRZL9WP3iP5ojse36s
        Gw4FHrq3Z776a0HC0PLlSTTwpgJ+P7PfB88FakU2BhpQaSRHV4N+gEkbUg5tBjPmLIsA7k
        9uDxsPhFgv0wd30UBh1osbtPgLCgKmPhQ5JTKK1X5HvF5bNCfXaEHCafwWMdF9t0SGaoNw
        iJVoJeOkETctHb4W0AYdQ2JwryBTqeWIQG0CZOqKcMxBLpTQBg6qmLNHgnqCOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702059181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yvm4+gDjc9yZRURvOF5hsHgmgIuQOiG3VThauBnHAuM=;
        b=ykwsQkdMATCkFAftugd7iv8fmMHJDGUNWIsie3le/1SNNYWtw/+u7gb/2F9cm2+YKciZMp
        7lfUoQUkhzZjY9Dw==
From:   "tip-bot2 for Jo Van Bulck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Remove redundant enclave base address
 save/restore
Cc:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205918069.398.17416852974013342906.tip-bot2@tip-bot2>
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

Commit-ID:     4f812df8f37463767c2a74c2bd77de94acdb2be6
Gitweb:        https://git.kernel.org/tip/4f812df8f37463767c2a74c2bd77de94acdb2be6
Author:        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
AuthorDate:    Thu, 05 Oct 2023 17:38:47 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:05:27 -08:00

selftests/sgx: Remove redundant enclave base address save/restore

Remove redundant push/pop pair that stores and restores the enclave base
address in the test enclave, as it is never used after the pop and can
anyway be easily retrieved via the __encl_base symbol.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/20231005153854.25566-7-jo.vanbulck%40cs.kuleuven.be
---
 tools/testing/selftests/sgx/test_encl_bootstrap.S | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index 03ae0f5..e0ce993 100644
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
