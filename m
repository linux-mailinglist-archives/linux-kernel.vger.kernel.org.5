Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0257180EE0E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376386AbjLLNsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376341AbjLLNsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:48:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DED3D10A;
        Tue, 12 Dec 2023 05:48:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5D211474;
        Tue, 12 Dec 2023 05:48:51 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 62F0E3F738;
        Tue, 12 Dec 2023 05:48:04 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Subject: [PATCH v2 6/8] thermal/sysfs: Update instance->weight under tz lock
Date:   Tue, 12 Dec 2023 13:48:42 +0000
Message-Id: <20231212134844.1213381-7-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212134844.1213381-1-lukasz.luba@arm.com>
References: <20231212134844.1213381-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user-space can change thermal instance weight value while the
throtte() callback is running for a governor. The IPA governor uses the
'weight' value for power calculation and also keeps it in 'total_weight'.
Therefore, the 'weight' value must not change during the throttle()
callback. Use 'tz->lock' mutex which also guards the throttle() to make
the update value safe.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index eef40d4f3063..df85df7d4a88 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -961,6 +961,7 @@ ssize_t weight_store(struct device *dev, struct device_attribute *attr,
 		     const char *buf, size_t count)
 {
 	struct thermal_instance *instance;
+	struct thermal_zone_device *tz;
 	int ret, weight;
 
 	ret = kstrtoint(buf, 0, &weight);
@@ -968,7 +969,12 @@ ssize_t weight_store(struct device *dev, struct device_attribute *attr,
 		return ret;
 
 	instance = container_of(attr, struct thermal_instance, weight_attr);
+	tz = instance->tz;
+
+	/* Don't race with governors using the 'weight' value */
+	mutex_lock(&tz->lock);
 	instance->weight = weight;
+	mutex_unlock(&tz->lock);
 
 	return count;
 }
-- 
2.25.1

