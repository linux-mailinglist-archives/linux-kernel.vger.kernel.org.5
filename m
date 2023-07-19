Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D5775962D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGSNFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjGSNFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:05:46 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143161711
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:05:43 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 36JD5Zqj043653;
        Wed, 19 Jul 2023 21:05:35 +0800 (+08)
        (envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4R5bch0SXJz2K1r9p;
        Wed, 19 Jul 2023 21:04:20 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.72) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 19 Jul 2023 21:05:33 +0800
From:   Xuewen Yan <xuewen.yan@unisoc.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <guohua.yan@unisoc.com>,
        <qyousef@layalina.io>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: schedutil: next_freq need update when cpufreq_limits changed
Date:   Wed, 19 Jul 2023 21:05:27 +0800
Message-ID: <20230719130527.8074-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.73.72]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 36JD5Zqj043653
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cpufreq's policy is single, there is a scenario that will
cause sg_policy's next_freq to be unable to update.

When the cpu's util is always max, the cpufreq will be max,
and then if we change the policy's scaling_max_freq to be a
lower freq, indeed, the sg_policy's next_freq need change to
be the lower freq, however, because the cpu_is_busy, the next_freq
would keep the max_freq.

For example:
The cpu7 is single cpu:

unisoc:/sys/devices/system/cpu/cpufreq/policy7 # while true;do done&
[1] 4737
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

At this time, the sg_policy's next_freq would keep 2301000.

To prevent the case happen, add the judgment of the need_freq_update flag.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Co-developed-by: Guohua Yan <guohua.yan@unisoc.com>
Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
---
 kernel/sched/cpufreq_schedutil.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4492608b7d7f..458d359f5991 100644
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
-- 
2.25.1

