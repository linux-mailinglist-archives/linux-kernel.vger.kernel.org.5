Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C2880ABCA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574541AbjLHSNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjLHSNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:13:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185DF10EB;
        Fri,  8 Dec 2023 10:13:05 -0800 (PST)
Date:   Fri, 08 Dec 2023 18:13:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702059183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZQXZPXMdeQWj4ugI1z+dfinMnf9b1h8LiYzaMCwoG1I=;
        b=o9cRehzZDgPw5+O9jx8dfwsSlqDFVMzLDoI0nGSugJtTnY5pevm7aqg0QPbS3G/adRoehk
        WBUQYRwgaUIZSRuLVB17H15OQ9huo7e9ZjCnTpu8FNpm5iTHpLJiLAQsCt2R0SoiGZ/Xd+
        iWTD7gwJ4CiSdukvYLs8yJb4ZxGa8r4N5912wjj1ijaS5pqbTSVXwmIqZKrfIBMXFfxlRx
        UvuB7/jqXg+IwgEVcpyM8qyF4wPGe+R7RPY+lJn9Gv5HLhbT3vihgBohlnRvHvBjrwyC1+
        yFMhm8/zRNj8vPtsJidOxuk/uWiyAcKIUixbevOjbi6E1DKfGmSWm0mPzuPrnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702059183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZQXZPXMdeQWj4ugI1z+dfinMnf9b1h8LiYzaMCwoG1I=;
        b=Zzgr0q3hvSyWNzH2myiWSYacG8lPK5CCvYh/+3s7s4G6hXzobYDtUQbdE5jAOBOqchT99s
        uJxUQjeIxs6kXuDw==
From:   "tip-bot2 for Jo Van Bulck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Include memory clobber for inline asm
 in test enclave
Cc:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205918296.398.18099309646140167454.tip-bot2@tip-bot2>
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

Commit-ID:     853a57a43ebdb8c024160c1a0990bae85f4bcc2f
Gitweb:        https://git.kernel.org/tip/853a57a43ebdb8c024160c1a0990bae85f4bcc2f
Author:        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
AuthorDate:    Thu, 05 Oct 2023 17:38:44 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:05:26 -08:00

selftests/sgx: Include memory clobber for inline asm in test enclave

Add the "memory" clobber to the EMODPE and EACCEPT asm blocks to tell the
compiler the assembly code accesses to the secinfo struct. This ensures
the compiler treats the asm block as a memory barrier and the write to
secinfo will be visible to ENCLU.

Fixes: 20404a808593 ("selftests/sgx: Add test for EPCM permission changes")
Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/all/20231005153854.25566-4-jo.vanbulck%40cs.kuleuven.be
---
 tools/testing/selftests/sgx/test_encl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index c0d6397..ae791df 100644
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
