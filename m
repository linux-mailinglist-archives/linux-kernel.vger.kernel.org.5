Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67527AAC54
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjIVIMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjIVILq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:11:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA8CE6C;
        Fri, 22 Sep 2023 01:11:40 -0700 (PDT)
Date:   Fri, 22 Sep 2023 08:11:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695370298;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1p8WzcJOAWfYeWI6UQE2QRNFJdJzCKra8K3fwBKeWYE=;
        b=ojpQtcDn+LyAKsQwFJpccq0mc9T+icQ5zwJAy9mD/mDkYxbA1wgwN/MTi/sp3f3UKvGShQ
        CnMEMhN74yG1GEis2wJtbsKBgeDOB3Qo6cMqfkegHFgQvUc1t3rO+ltXRUzrsr/HdTA+vU
        paVOSSfPn7n+r0tnYJwEdVsJVcj1DYDLhPt2Jfm+mobAxuZGEziyAfFC0yrSeKjmQRCCeJ
        DOjfgu1wKEZZUPFTKJck5if23NNo5FF/P3KfwkbDHuyjya2HwJ7wtpCSsAFulB4YbG6jGI
        /frecf0xMVgafYkAK0CK9y+jDlCE9bPw3hmZXj8DWEnao2E4QICTNNyBZqGHJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695370298;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1p8WzcJOAWfYeWI6UQE2QRNFJdJzCKra8K3fwBKeWYE=;
        b=byVsDRShUDXLgoVlAO8FzCm+vF3pcbOix7HsbYe9bdUyp/q4TjX3cegaOVr+lbUErZcrph
        0EyvoRTRRiq/72Bw==
From:   "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex/test: Use prng instead of rng to
 avoid hangs at bootup
Cc:     John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230922043616.19282-2-jstultz@google.com>
References: <20230922043616.19282-2-jstultz@google.com>
MIME-Version: 1.0
Message-ID: <169537029801.27769.5775811116918279412.tip-bot2@tip-bot2>
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

Commit-ID:     4812c54dc0498c4b757cbc7f41c1999b5a1c9f67
Gitweb:        https://git.kernel.org/tip/4812c54dc0498c4b757cbc7f41c1999b5a1c9f67
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Fri, 22 Sep 2023 04:35:59 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Sep 2023 09:43:40 +02:00

locking/ww_mutex/test: Use prng instead of rng to avoid hangs at bootup

Booting w/ qemu without kvm, and with 64 cpus, I noticed we'd
sometimes hung task watchdog splats in get_random_u32_below()
when using the test-ww_mutex stress test.

While entropy exhaustion is no longer an issue, the RNG may be
slower early in boot. The test-ww_mutex code will spawn off
128 threads (2x cpus) and each thread will call
get_random_u32_below() a number of times to generate a random
order of the 16 locks.

This intense use takes time and without kvm, qemu can be slow
enough that we trip the hung task watchdogs.

For this test, we don't need true randomness, just mixed up
orders for testing ww_mutex lock acquisitions, so it changes
the logic to use the prng instead, which takes less time
and avoids the watchdgos.

Feedback would be appreciated!

Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230922043616.19282-2-jstultz@google.com
---
 kernel/locking/test-ww_mutex.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 93cca6e..9bceba6 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -9,7 +9,7 @@
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/slab.h>
 #include <linux/ww_mutex.h>
 
@@ -386,6 +386,19 @@ struct stress {
 	int nlocks;
 };
 
+struct rnd_state rng;
+DEFINE_SPINLOCK(rng_lock);
+
+static inline u32 prandom_u32_below(u32 ceil)
+{
+	u32 ret;
+
+	spin_lock(&rng_lock);
+	ret = prandom_u32_state(&rng) % ceil;
+	spin_unlock(&rng_lock);
+	return ret;
+}
+
 static int *get_random_order(int count)
 {
 	int *order;
@@ -399,7 +412,7 @@ static int *get_random_order(int count)
 		order[n] = n;
 
 	for (n = count - 1; n > 1; n--) {
-		r = get_random_u32_below(n + 1);
+		r = prandom_u32_below(n + 1);
 		if (r != n) {
 			tmp = order[n];
 			order[n] = order[r];
@@ -625,6 +638,8 @@ static int __init test_ww_mutex_init(void)
 
 	printk(KERN_INFO "Beginning ww mutex selftests\n");
 
+	prandom_seed_state(&rng, get_random_u64());
+
 	wq = alloc_workqueue("test-ww_mutex", WQ_UNBOUND, 0);
 	if (!wq)
 		return -ENOMEM;
