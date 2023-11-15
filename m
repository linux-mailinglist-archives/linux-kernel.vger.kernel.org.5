Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5167EC6E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344408AbjKOPOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344468AbjKOPOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:14:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED45D41
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:14:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9651C433CA;
        Wed, 15 Nov 2023 15:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700061240;
        bh=CGc4yN675I1g1HtS2yRFvKBFqp1N2IpYVLKrHGqJRhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i5OSOvr+26OB70bGr8parKnbffR+qe+cbu6cntwePyetORAYqXomqnEf+fL9pK1nA
         oil1YHr0Ngj4yeGAdJjXSgqCzf8HyyZtltBVN7hrWyy5TY4NJBonMHGbhwVNGYME+h
         cfwWz8A4lZ6utJQNakqG1cT/t6t1aOb4N1PnGxbvfRag/XsbyQcu13wz8fAtMNlhGu
         +30WIPYtzl4OUvZvcFZgCYAU00jt01npgmCgwmDV+3cc5oXnM1FHxsLKs2ITAFFryn
         7Mt+n70WFKOhDEQKJhwn8+i92ASJo9pZ0RVp+XGD/esOsLCDE5v3zC0qY5wne766bW
         Zh76QhVKMQPBQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/4] x86: Add a comment about the "magic" behind shadow sti before mwait
Date:   Wed, 15 Nov 2023 10:13:22 -0500
Message-ID: <20231115151325.6262-2-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115151325.6262-1-frederic@kernel.org>
References: <20231115151325.6262-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a note to make sure we never miss and break the requirements behind
it.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/include/asm/mwait.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 778df05f8539..341ee4f1d91e 100644
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
-- 
2.42.1

