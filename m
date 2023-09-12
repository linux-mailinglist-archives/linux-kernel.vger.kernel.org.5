Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FA679C6AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjILGMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjILGMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:12:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E432DE78;
        Mon, 11 Sep 2023 23:12:17 -0700 (PDT)
Received: from kwepemd200002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RlCn518WPztQSC;
        Tue, 12 Sep 2023 14:08:09 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200002.china.huawei.com
 (7.221.188.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.23; Tue, 12 Sep
 2023 14:12:14 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: conservative: Ensure requested_freq is greater than min frequency
Date:   Tue, 12 Sep 2023 06:09:57 +0000
Message-ID: <20230912060957.2516790-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.28]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200002.china.huawei.com (7.221.188.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The governor ensures that the requested frequency is greater than the
minimum frequency when the condition for decreasing frequency is
satisfied. This is done by either reducing the frequency step from the
current frequency if the current frequency is greater than the sum of
the frequency step and the minimum frequency, or setting the frequency
to the minimum one otherwise.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 56500b25d77c..54e09242b2e2 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -130,7 +130,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 		if (requested_freq == policy->min)
 			goto out;
 
-		if (requested_freq > freq_step)
+		if (requested_freq > policy->min + freq_step)
 			requested_freq -= freq_step;
 		else
 			requested_freq = policy->min;
-- 
2.34.1

