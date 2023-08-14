Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852A777BC83
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjHNPIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjHNPIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:08:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ED410C8;
        Mon, 14 Aug 2023 08:08:09 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:08:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692025688;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YqjiB9b9W31Axoru4v2fACC/gOxJ7s3KyJ0ZqfuVUqA=;
        b=QCn9wF87dFadGwJJ5okww0tNYqH4y+VTIN6/bOBGSnDG7N1pDWodly2O4/SJYBFtX7m8sX
        +XX9T4PzMScE4/ftlXNK3UU17gmaqfIxBGB1AsVGy1aBIOBN/9g/o6ZW+4AfK9x5wZ3k8K
        fSTGzBhaHoef9esB/0YO80xbtTfTmlCg3FmQgZqCmLXwgbAIDCMI3A2AJZW0/htx+LFyKA
        LMVlOxbllhNip+DSZMEfc93o1k63yznmBkAMIwxoaSG61XNxydXUL+NB4R14w/DHe7iG07
        1K5crwUSKJH+jFHBT5DMACsQRLxthI5qK+OX6mlGuyqu7un1Jj83E00uBD+0Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692025688;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YqjiB9b9W31Axoru4v2fACC/gOxJ7s3KyJ0ZqfuVUqA=;
        b=tTSEcl06DpfwEY6Po6Q7lmgTxRo5W5y1/zI3p+y3ycwx5rRZcPhMqnc/TJteiPRfNlFuoE
        7fMn1+7ti3P1Q0DQ==
From:   "tip-bot2 for Cyril Hrubis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Fix sysctl_sched_rr_timeslice intial value
Cc:     Cyril Hrubis <chrubis@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Petr Vorel <pvorel@suse.cz>, Mel Gorman <mgorman@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230802151906.25258-2-chrubis@suse.cz>
References: <20230802151906.25258-2-chrubis@suse.cz>
MIME-Version: 1.0
Message-ID: <169202568796.27769.5144994079483945988.tip-bot2@tip-bot2>
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

Commit-ID:     c7fcb99877f9f542c918509b2801065adcaf46fa
Gitweb:        https://git.kernel.org/tip/c7fcb99877f9f542c918509b2801065adcaf46fa
Author:        Cyril Hrubis <chrubis@suse.cz>
AuthorDate:    Wed, 02 Aug 2023 17:19:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Aug 2023 17:01:23 +02:00

sched/rt: Fix sysctl_sched_rr_timeslice intial value

There is a 10% rounding error in the intial value of the
sysctl_sched_rr_timeslice with CONFIG_HZ_300=y.

This was found with LTP test sched_rr_get_interval01:

sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90
sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90

What this test does is to compare the return value from the
sched_rr_get_interval() and the sched_rr_timeslice_ms sysctl file and
fails if they do not match.

The problem it found is the intial sysctl file value which was computed as:

static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;

which works fine as long as MSEC_PER_SEC is multiple of HZ, however it
introduces 10% rounding error for CONFIG_HZ_300:

(MSEC_PER_SEC / HZ) * (100 * HZ / 1000)

(1000 / 300) * (100 * 300 / 1000)

3 * 30 = 90

This can be easily fixed by reversing the order of the multiplication
and division. After this fix we get:

(MSEC_PER_SEC * (100 * HZ / 1000)) / HZ

(1000 * (100 * 300 / 1000)) / 300

(1000 * 30) / 300 = 100

Fixes: 975e155ed873 ("sched/rt: Show the 'sched_rr_timeslice' SCHED_RR timeslice tuning knob in milliseconds")
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Acked-by: Mel Gorman <mgorman@suse.de>
Tested-by: Petr Vorel <pvorel@suse.cz>
Link: https://lore.kernel.org/r/20230802151906.25258-2-chrubis@suse.cz
---
 kernel/sched/rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 00e0e50..185d3d7 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -25,7 +25,7 @@ unsigned int sysctl_sched_rt_period = 1000000;
 int sysctl_sched_rt_runtime = 950000;
 
 #ifdef CONFIG_SYSCTL
-static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
+static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ;
 static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
