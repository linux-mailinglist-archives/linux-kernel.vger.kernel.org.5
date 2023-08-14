Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000CC77BC7B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjHNPIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjHNPIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:08:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7396410F4;
        Mon, 14 Aug 2023 08:08:08 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:08:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692025687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+9KtufBaYgo54ysjDk7SUlAA47oGnzGYwwcRXS9alE=;
        b=IvhNj7zbTkTawoRo7s1c0hIrnGrzSzWl7D9XyCUt9Xy8ORqecBL/khBh1KbLROnsebkC9b
        K0htwf7y6vpomDnVz2g5irHm2pVAeh+EDWuYQ2qN7pE2yDGU52hMVzvxwCro2tMWPzGpQR
        13Ry53t6+5POmEdUlpGwLwb2eerdVgdY09vMVavl2l7qM+a/W3zqKsx9jrQX4ENMuuj2cP
        IVn7vL4ehoLfqwTSHkXewCB4udqzfRH9JqeF79Lf8+MtN/MkPF6JkMzVHD7Lzh7mqBHjp+
        GD/VPKqbWpgeo6Za9NSaTpkQuU1C0m3IBWMI3Lm5P5u3prywImJyP5++TEqw9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692025687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+9KtufBaYgo54ysjDk7SUlAA47oGnzGYwwcRXS9alE=;
        b=Qed8k9Bx+afHNwUxzZSTADaNXNOAHe1ZQw8P6T/zWfIaT2g8pHHuchmXHj5XSI58kUPYtX
        COGGFi3BoeRHPkAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify sysctl_sched_uclamp_handler()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230801211811.896559109@infradead.org>
References: <20230801211811.896559109@infradead.org>
MIME-Version: 1.0
Message-ID: <169202568664.27769.1824574211611441233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0f92cdf36f848f1c077924f857a49789e00331c0
Gitweb:        https://git.kernel.org/tip/0f92cdf36f848f1c077924f857a49789e00331c0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 01 Aug 2023 22:41:23 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Aug 2023 17:01:24 +02:00

sched: Simplify sysctl_sched_uclamp_handler()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20230801211811.896559109@infradead.org
---
 kernel/sched/core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6cda296..6e8a8e9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1827,7 +1827,8 @@ static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 	int old_min, old_max, old_min_rt;
 	int result;
 
-	mutex_lock(&uclamp_mutex);
+	guard(mutex)(&uclamp_mutex);
+
 	old_min = sysctl_sched_uclamp_util_min;
 	old_max = sysctl_sched_uclamp_util_max;
 	old_min_rt = sysctl_sched_uclamp_util_min_rt_default;
@@ -1836,7 +1837,7 @@ static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 	if (result)
 		goto undo;
 	if (!write)
-		goto done;
+		return 0;
 
 	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
 	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE	||
@@ -1872,16 +1873,12 @@ static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 	 * Otherwise, keep it simple and do just a lazy update at each next
 	 * task enqueue time.
 	 */
-
-	goto done;
+	return 0;
 
 undo:
 	sysctl_sched_uclamp_util_min = old_min;
 	sysctl_sched_uclamp_util_max = old_max;
 	sysctl_sched_uclamp_util_min_rt_default = old_min_rt;
-done:
-	mutex_unlock(&uclamp_mutex);
-
 	return result;
 }
 #endif
