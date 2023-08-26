Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB75D7895AF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 12:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjHZKAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 06:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjHZJ7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 05:59:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624B49B;
        Sat, 26 Aug 2023 02:59:41 -0700 (PDT)
Received: from kwepemd100002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RXsdh0tPJztSDq;
        Sat, 26 Aug 2023 17:55:52 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.23; Sat, 26 Aug
 2023 17:59:39 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: pcc: Fix the potentinal scheduling delays in target_index()
Date:   Sat, 26 Aug 2023 09:57:43 +0000
Message-ID: <20230826095743.1138495-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.28]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100002.china.huawei.com (7.221.188.184)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcc_cpufreq_target():
	cpufreq_freq_transition_begin();
	spin_lock(&pcc_lock);
	[critical section]
	cpufreq_freq_transition_end();
	spin_unlock(&pcc_lock);

Above code has a performance issue, consider that Task0 executes
'cpufreq_freq_transition_end()' to wake Task1 and preempted imediatedly
without releasing 'pcc_lock', then Task1 needs to wait for Task0 to
release 'pcc_lock'. In the worst case, this locking order can result in
Task1 wasting two scheduling rounds before it can enter the critical
section.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 drivers/cpufreq/pcc-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 73efbcf5513b..9d732a00e2a5 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -232,8 +232,8 @@ static int pcc_cpufreq_target(struct cpufreq_policy *policy,
 	status = ioread16(&pcch_hdr->status);
 	iowrite16(0, &pcch_hdr->status);
 
-	cpufreq_freq_transition_end(policy, &freqs, status != CMD_COMPLETE);
 	spin_unlock(&pcc_lock);
+	cpufreq_freq_transition_end(policy, &freqs, status != CMD_COMPLETE);
 
 	if (status != CMD_COMPLETE) {
 		pr_debug("target: FAILED for cpu %d, with status: 0x%x\n",
-- 
2.34.1

