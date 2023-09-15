Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631D67A1D66
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjIOLZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjIOLZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:25:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86781CC4;
        Fri, 15 Sep 2023 04:25:03 -0700 (PDT)
Date:   Fri, 15 Sep 2023 11:25:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694777102;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aFgNEf9KkosXtEXMOYUFxRfb/yHPUkGh+NbET7KpgyU=;
        b=BxzqdzKLCC1b/mn/ogPsTNMt3ljEdYQzXUokqdYIFGCn/MePX5+v5wvsraHgjr/DA8Rc6U
        KcsgJtXvNxz/FqrTg8yrNxRyCpAxxcyalC/QBts4p4oA7oEOsvPS6IWbuXyQCBQb0JK1Jo
        xzdDZCVbwIn1L53/aDg4Kui5XvQsvCfi3RCcR25mHY/YmZF4BAPUe2nea5Hzurx+GfpNuO
        /y0kCwJwXTV63JwFxNfettgbcthG42h7K/S3pXK3mDFk9aGTH9+0kMB51/K7C1jvOHrWpF
        8elcT5tVHa1HsjSLfbo9zeGxal95iKIcHDwyKusuHpaNc2+bc523AIOB42GQ5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694777102;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aFgNEf9KkosXtEXMOYUFxRfb/yHPUkGh+NbET7KpgyU=;
        b=Ivms8OZDGOMcjNzHLUZrk6b5c+YZ9EMkUZqY6LJ3yy/ioxCYvk3OfWU3u3fAwRaNlNx3uD
        8tTkrS+uDCXjL8AA==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/percpu: Use raw_cpu_try_cmpxchg() in preempt_count_set()
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230830151623.3900-2-ubizjak@gmail.com>
References: <20230830151623.3900-2-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169477710134.27769.4966191345863204187.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     b8e3dfa16ec55f310dd95831614af3d24abf5ed5
Gitweb:        https://git.kernel.org/tip/b8e3dfa16ec55f310dd95831614af3d24abf5ed5
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 30 Aug 2023 17:13:57 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Sep 2023 13:19:22 +02:00

x86/percpu: Use raw_cpu_try_cmpxchg() in preempt_count_set()

Use raw_cpu_try_cmpxchg() instead of raw_cpu_cmpxchg(*ptr, old, new) == old.
x86 CMPXCHG instruction returns success in ZF flag, so this change saves a
compare after CMPXCHG (and related MOV instruction in front of CMPXCHG).

Also, raw_cpu_try_cmpxchg() implicitly assigns old *ptr value to "old" when
cmpxchg fails. There is no need to re-read the value in the loop.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230830151623.3900-2-ubizjak@gmail.com
---
 arch/x86/include/asm/preempt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 2d13f25..4527e14 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -31,11 +31,11 @@ static __always_inline void preempt_count_set(int pc)
 {
 	int old, new;
 
+	old = raw_cpu_read_4(pcpu_hot.preempt_count);
 	do {
-		old = raw_cpu_read_4(pcpu_hot.preempt_count);
 		new = (old & PREEMPT_NEED_RESCHED) |
 			(pc & ~PREEMPT_NEED_RESCHED);
-	} while (raw_cpu_cmpxchg_4(pcpu_hot.preempt_count, old, new) != old);
+	} while (!raw_cpu_try_cmpxchg_4(pcpu_hot.preempt_count, &old, new));
 }
 
 /*
