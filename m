Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C707AE59A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjIZGOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjIZGOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:14:01 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4799E9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:13:54 -0700 (PDT)
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 38Q6DK1r1929152
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 25 Sep 2023 23:13:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 38Q6DK1r1929152
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023091101; t=1695708805;
        bh=nNwOzyqfEzLt1zDWttF1YMiYKoXzfh/V3dbwJJ7gl5s=;
        h=From:To:Cc:Subject:Date:From;
        b=gBqMBgNBpIDGd5cUuIWQ6YV+PbFTrIYT/NNXbe2NsE5T7WEtq6IYB11ZCxkUXZMiV
         cQF78ZOnXpCM5O5iesps5qw81iWSk1cRq8X7btxdw/HayCk9iE7l21qF4tHMZbBcYw
         q/MUvXUMFHNhuxxhYNzukJbkuk5qsh9hvevvsG4gEf8XnuFROq1Oqa86SM3MhCCPH0
         Zzawh5LJ8XT9YdNodEGqZw9T3PD/NDJpVzmTnOHWZ1b9zz5laAzcYUiA9/7FyCXW1n
         ssrhzllEhjQo75H7TAoHXeksHjG15Vx+RXZ/77wYV/m1nc1EPIwV1njdKpmGIb+GLY
         fWdRhqhC5UFgA==
From:   xin@zytor.com
To:     linux-kernel@vger.kernel.org
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com
Subject: [PATCH 1/1] x86/entry: remove unused argument %rsi passed to exc_nmi()
Date:   Mon, 25 Sep 2023 23:13:19 -0700
Message-Id: <20230926061319.1929127-1-xin@zytor.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Xin Li (Intel)" <xin@zytor.com>

exc_nmi() only takes one argument of type struct pt_regs *, but
asm_exc_nmi() calls it with 2 arguments. The second one passed
in %rsi seems a leftover, so simply remove it.

BTW, fix 2 slips in the comments.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/entry/entry_64.S | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f71664dea1a3..9b4b512f2a75 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1163,8 +1163,8 @@ SYM_CODE_START(asm_exc_nmi)
 	 * anyway.
 	 *
 	 * To handle this case we do the following:
-	 *  Check the a special location on the stack that contains
-	 *  a variable that is set when NMIs are executing.
+	 *  Check a special location on the stack that contains a
+	 *  variable that is set when NMIs are executing.
 	 *  The interrupted task's stack is also checked to see if it
 	 *  is an NMI stack.
 	 *  If the variable is not set and the stack is not the NMI
@@ -1237,7 +1237,6 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	movq	%rsp, %rdi
-	movq	$-1, %rsi
 	call	exc_nmi
 
 	/*
@@ -1295,8 +1294,8 @@ SYM_CODE_START(asm_exc_nmi)
 	 * end_repeat_nmi, then we are a nested NMI.  We must not
 	 * modify the "iret" frame because it's being written by
 	 * the outer NMI.  That's okay; the outer NMI handler is
-	 * about to about to call exc_nmi() anyway, so we can just
-	 * resume the outer NMI.
+	 * about to call exc_nmi() anyway, so we can just resume
+	 * the outer NMI.
 	 */
 
 	movq	$repeat_nmi, %rdx
@@ -1451,7 +1450,6 @@ end_repeat_nmi:
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi
-	movq	$-1, %rsi
 	call	exc_nmi
 
 	/* Always restore stashed SPEC_CTRL value (see paranoid_entry) */
-- 
2.40.1

