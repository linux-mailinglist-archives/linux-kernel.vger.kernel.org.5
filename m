Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACAD7808F4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359367AbjHRJwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357543AbjHRJvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:51:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60F92684;
        Fri, 18 Aug 2023 02:51:50 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRxtB4JmpzVk4Y;
        Fri, 18 Aug 2023 17:49:38 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 17:51:46 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: stats: Improve the performance of cpufreq_stats_create_table()
Date:   Fri, 18 Aug 2023 09:50:00 +0000
Message-ID: <20230818095000.937633-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.28]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the worst case, the freq_table of policy data is not sorted and
contains duplicate frequencies, this means that it needs to iterate
through the entire freq_table of policy to ensure each frequency is
unique in the freq_table of stats data, this has a time complexity of
O(N^2), where N is the number of frequencies in the freq_table of
policy.

However, if the policy.freq_table is already sorted and contains no
duplicate frequencices, it can reduce the time complexity of creating
stats.freq_table to O(N), the 'freq_table_sorted' field of policy data
can be used to indicate whether the policy.freq_table is sorted.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 drivers/cpufreq/cpufreq_stats.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 55c7ffd37d1c..fcb74050711a 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -243,7 +243,8 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
 
 	/* Find valid-unique entries */
 	cpufreq_for_each_valid_entry(pos, policy->freq_table)
-		if (freq_table_get_index(stats, pos->frequency) == -1)
+		if ((policy->freq_table_sorted != CPUFREQ_TABLE_UNSORTED) ||
+		    (freq_table_get_index(stats, pos->frequency) == -1))
 			stats->freq_table[i++] = pos->frequency;
 
 	stats->state_num = i;
-- 
2.34.1

