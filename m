Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2703C7980EA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 05:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241851AbjIHDSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 23:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjIHDSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 23:18:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947D51BD9;
        Thu,  7 Sep 2023 20:18:28 -0700 (PDT)
Received: from kwepemd200002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rhh7D1cc1zMlFV;
        Fri,  8 Sep 2023 11:15:04 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200002.china.huawei.com
 (7.221.188.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.23; Fri, 8 Sep
 2023 11:18:25 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: ondemand: Allow powersave_bias_target() to bail out if freq_table is unsorted
Date:   Fri, 8 Sep 2023 03:16:14 +0000
Message-ID: <20230908031614.2262451-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.28]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200002.china.huawei.com (7.221.188.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic_powersave_bias_target() function uses the
cpufreq_table_find_index_[h/l]() functions to calculate the frequency
bounds for the powersave bias target. However, these two functions only
work on sorted frequency tables. Therefore, the
generic_powersave_bias_target() function should bail out early if the
frequency table is unsorted.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 drivers/cpufreq/cpufreq_ondemand.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index c52d19d67557..f7ff94f71395 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -71,7 +71,8 @@ static unsigned int generic_powersave_bias_target(struct cpufreq_policy *policy,
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	struct cpufreq_frequency_table *freq_table = policy->freq_table;
 
-	if (!freq_table) {
+	if (!freq_table ||
+	    WARN_ON_ONCE(policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED)) {
 		dbs_info->freq_lo = 0;
 		dbs_info->freq_lo_delay_us = 0;
 		return freq_next;
-- 
2.34.1

