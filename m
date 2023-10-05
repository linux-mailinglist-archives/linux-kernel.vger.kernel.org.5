Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4BE7BAB67
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjJEUX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 16:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJEUXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:23:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC4793;
        Thu,  5 Oct 2023 13:23:53 -0700 (PDT)
Date:   Thu, 05 Oct 2023 20:23:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696537431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dO+aKjhk4MAL25uH/UDuHKKSgxIuG2Di9bAh6yHtAtY=;
        b=qzODLAM65gHT7XOAF4prJ2MxALLHdLauoBwxL/18hpY2PlRuqC3iwno4KARSiS/uViv43Y
        Khv1KPOjoFj7zoGP6SgibCQiu/jWMHxydbojZlAeHBS4ABAP6nNlt3kmTPTxp8YjOCjQ+X
        FV8hkhpm0GTs/owSjSwRaw4E7bvvbgSNpbr6knYFZ12fV4ePOtiQ0XeB44w+auGQJWjOk5
        ydyyA19uXdhK/k5pnEgkRasjvJXBS6Q+Fw4LZGpOLanp4auoPr0YQE4gthmvDGM1q3dg7H
        ERPOhXWmMHaSXsRdt/IzGj1dpLRJXkxnNpElWOSNAcm+T5u5+cFbuHxgFOekoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696537431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dO+aKjhk4MAL25uH/UDuHKKSgxIuG2Di9bAh6yHtAtY=;
        b=HER3RGNv7/z1f8iemBfj2zHxnBLR/rX3QQag4LD9u2AFl6uaELwdbYR3fU7r71kB8L8Iks
        s9AhEtytLiRUkZBQ==
From:   "tip-bot2 for Xuewen Yan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] cpufreq: schedutil: Update next_freq when
 cpufreq_limits change
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>,
        Guohua Yan <guohua.yan@unisoc.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230719130527.8074-1-xuewen.yan@unisoc.com>
References: <20230719130527.8074-1-xuewen.yan@unisoc.com>
MIME-Version: 1.0
Message-ID: <169653743031.3135.15393242028236328719.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     9e0bc36ab07c550d791bf17feeb479f1dfc42d89
Gitweb:        https://git.kernel.org/tip/9e0bc36ab07c550d791bf17feeb479f1dfc42d89
Author:        Xuewen Yan <xuewen.yan@unisoc.com>
AuthorDate:    Wed, 19 Jul 2023 21:05:27 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Oct 2023 22:09:50 +02:00

cpufreq: schedutil: Update next_freq when cpufreq_limits change

When cpufreq's policy is 'single', there is a scenario that will
cause sg_policy's next_freq to be unable to update.

When the CPU's util is always max, the cpufreq will be max,
and then if we change the policy's scaling_max_freq to be a
lower freq, indeed, the sg_policy's next_freq need change to
be the lower freq, however, because the cpu_is_busy, the next_freq
would keep the max_freq.

For example:

The cpu7 is a single CPU:

  unisoc:/sys/devices/system/cpu/cpufreq/policy7 # while true;do done& [1] 4737
  unisoc:/sys/devices/system/cpu/cpufreq/policy7 # taskset -p 80 4737
  pid 4737's current affinity mask: ff
  pid 4737's new affinity mask: 80
  unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_max_freq
  2301000
  unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_cur_freq
  2301000
  unisoc:/sys/devices/system/cpu/cpufreq/policy7 # echo 2171000 > scaling_max_freq
  unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_max_freq
  2171000

At this time, the sg_policy's next_freq would stay at 2301000, which
is wrong.

To fix this, add a check for the ->need_freq_update flag.

[ mingo: Clarified the changelog. ]

Co-developed-by: Guohua Yan <guohua.yan@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>
Link: https://lore.kernel.org/r/20230719130527.8074-1-xuewen.yan@unisoc.com
---
 kernel/sched/cpufreq_schedutil.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4492608..458d359 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -350,7 +350,8 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 	 * Except when the rq is capped by uclamp_max.
 	 */
 	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
-	    sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
+	    sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq &&
+	    !sg_policy->need_freq_update) {
 		next_f = sg_policy->next_freq;
 
 		/* Restore cached freq as next_freq has changed */
