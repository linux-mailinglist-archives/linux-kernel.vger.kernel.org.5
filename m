Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B3C79C6AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjILGMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjILGMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:12:06 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62869AF;
        Mon, 11 Sep 2023 23:12:02 -0700 (PDT)
Received: from kwepemd200002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RlCnX6qYjzMlBJ;
        Tue, 12 Sep 2023 14:08:32 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200002.china.huawei.com
 (7.221.188.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.23; Tue, 12 Sep
 2023 14:11:58 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: conservative: Simplify the condition of storing 'down_threshold'
Date:   Tue, 12 Sep 2023 06:09:42 +0000
Message-ID: <20230912060942.2516761-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.28]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200002.china.huawei.com (7.221.188.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The governor currently checks if the input new down_threshold is less
than 100 before storing it. However, the up_threshold field of dbs_data
structure is also limited to be less than 100, so this check is
unnecessary and remove it.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index b6bd0ff35323..56500b25d77c 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -187,8 +187,7 @@ static ssize_t down_threshold_store(struct gov_attr_set *attr_set,
 	ret = sscanf(buf, "%u", &input);
 
 	/* cannot be lower than 1 otherwise freq will not fall */
-	if (ret != 1 || input < 1 || input > 100 ||
-			input >= dbs_data->up_threshold)
+	if (ret != 1 || input < 1 || input >= dbs_data->up_threshold)
 		return -EINVAL;
 
 	cs_tuners->down_threshold = input;
-- 
2.34.1

