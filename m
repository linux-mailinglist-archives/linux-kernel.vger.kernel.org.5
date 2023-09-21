Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3FC7A9FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjIUU1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjIUU11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:27:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA20181FFC;
        Thu, 21 Sep 2023 10:36:34 -0700 (PDT)
Date:   Thu, 21 Sep 2023 17:36:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695317765;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wU6UI6p5QQCQf2w0UwpMQsy++mNe/HQqCp2ajQz9M0=;
        b=aEFYaAhwG9PpzwceGAJ5O8Wiq9aZFIcNTO0hZrdsS+uGrdwxzi/LD+INXumqwlM/p6rcX8
        PA9a+shrIKLnloBfj5V7N1OiSwykdyxUpAI7ZAotKY2t68ZuFRZiBcsfW9xb2r48S/Fy5e
        +ZInjB3HvcxPYosMMb2MRILohKcbWnemHhTwWA+3cKDqzegNMyvkfuBzb/SGz25h+F59Ww
        ydM4ncmCRbkeV/Wsgr/J+oBEvoSKOJ4L+6yuMQLcMly69x+QzDvBq2Jl3lvH9asHH4T3o1
        EcipimSV5yFHhr2smE68Qoz1SBlsmbCuuwaC8OKtQAz0a50tvPmK812g3jP0uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695317765;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wU6UI6p5QQCQf2w0UwpMQsy++mNe/HQqCp2ajQz9M0=;
        b=pkq47KvNYoPg0V4z8r45o73Nhwxdi5vyMgjLQF6Ag6LWE2g5jVff8gssaor+pVrRk9Dk4H
        19dtRFuUx7oeG1BA==
From:   "tip-bot2 for peterz@infradead.org" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Validate futex value against futex size
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230921105247.828934099@noisy.programming.kicks-ass.net>
References: <20230921105247.828934099@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169531776519.27769.7035834121938466591.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     698eb826383616ce0e817d2384da6413d1439fb6
Gitweb:        https://git.kernel.org/tip/698eb826383616ce0e817d2384da6413d1439fb6
Author:        peterz@infradead.org <peterz@infradead.org>
AuthorDate:    Thu, 21 Sep 2023 12:45:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Sep 2023 19:22:06 +02:00

futex: Validate futex value against futex size

Ensure the futex value fits in the given futex size. Since this adds a
constraint to an existing syscall, it might possibly change behaviour.

Currently the value would be truncated to a u32 and any high bits
would get silently lost.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230921105247.828934099@noisy.programming.kicks-ass.net
---
 kernel/futex/futex.h    | 10 ++++++++++
 kernel/futex/syscalls.c |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 68fc052..a3f1fce 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -85,6 +85,16 @@ static inline bool futex_flags_valid(unsigned int flags)
 	return true;
 }
 
+static inline bool futex_validate_input(unsigned int flags, u64 val)
+{
+	int bits = 8 * futex_size(flags);
+
+	if (bits < 64 && (val >> bits))
+		return false;
+
+	return true;
+}
+
 #ifdef CONFIG_FAIL_FUTEX
 extern bool should_fail_futex(bool fshared);
 #else
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 948ac24..2339f9c 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -209,6 +209,9 @@ static int futex_parse_waitv(struct futex_vector *futexv,
 		if (!futex_flags_valid(flags))
 			return -EINVAL;
 
+		if (!futex_validate_input(flags, aux.val))
+			return -EINVAL;
+
 		futexv[i].w.flags = flags;
 		futexv[i].w.val = aux.val;
 		futexv[i].w.uaddr = aux.uaddr;
