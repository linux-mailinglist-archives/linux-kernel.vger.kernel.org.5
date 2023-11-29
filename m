Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A0C7FDA8D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjK2Oz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjK2Ozv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:55:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE19D5E;
        Wed, 29 Nov 2023 06:55:57 -0800 (PST)
Date:   Wed, 29 Nov 2023 14:55:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701269756;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLbikOtVJDhPJBfsK4WcWQ/4AM6wkB1f7QXWa/N/ZQw=;
        b=yid6oUJkHcYXRz3rztYDdSTogDbw2haTPKwU2WIusiyMeKNGDYF0k6lJaPQuHnnm81J/fl
        JMOHgvKFQqrmp+0vBNkPdITF/HYVvGJgN6WfAHkxNNbkgpaxuF3EwpqOjRW1W/3s6w8MMQ
        pZmw+rhjd+7yqJvGVMRryQkM0F4ViX6NEOtbagTx+MGsSu3G1rjqJAjQE5bm8H1zmQ3ByN
        BHwIGLvHATUYeJx4kUU0QHKQv4nNFKCoWDOG50Pk64Ugzu4xJQKTdQQB+V27BPix5HIGuB
        5RseIfxRC5ieK0Wsq8I5v8XEJSbyUoc/bphOVp8zPfwFcWipbNl6nFUHgdxCGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701269756;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLbikOtVJDhPJBfsK4WcWQ/4AM6wkB1f7QXWa/N/ZQw=;
        b=pinjTksFVPwufqzimrubx9ROVEhd8rpem3qJyZB+y0Golgkvd5w1S6fVPe7S/bMB8sg1FF
        XwQlg1OJC2CDE7Cg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Add a comment about the "magic" behind shadow
 sti before mwait
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231115151325.6262-2-frederic@kernel.org>
References: <20231115151325.6262-2-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <170126975575.398.1797223222857571697.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     7d09a052a3bdb62de9a86d43359d6c22eeaf105a
Gitweb:        https://git.kernel.org/tip/7d09a052a3bdb62de9a86d43359d6c22eeaf105a
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 15 Nov 2023 10:13:22 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Nov 2023 15:44:01 +01:00

x86: Add a comment about the "magic" behind shadow sti before mwait

Add a note to make sure we never miss and break the requirements behind
it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lkml.kernel.org/r/20231115151325.6262-2-frederic@kernel.org
---
 arch/x86/include/asm/mwait.h |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 778df05..341ee4f 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -87,6 +87,15 @@ static __always_inline void __mwaitx(unsigned long eax, unsigned long ebx,
 		     :: "a" (eax), "b" (ebx), "c" (ecx));
 }
 
+/*
+ * Re-enable interrupts right upon calling mwait in such a way that
+ * no interrupt can fire _before_ the execution of mwait, ie: no
+ * instruction must be placed between "sti" and "mwait".
+ *
+ * This is necessary because if an interrupt queues a timer before
+ * executing mwait, it would otherwise go unnoticed and the next tick
+ * would not be reprogrammed accordingly before mwait ever wakes up.
+ */
 static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
 	mds_idle_clear_cpu_buffers();
