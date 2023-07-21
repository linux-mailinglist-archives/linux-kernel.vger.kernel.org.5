Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE31675CC8A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjGUPux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjGUPug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:50:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59E8E3AB5;
        Fri, 21 Jul 2023 08:50:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FB562F4;
        Fri, 21 Jul 2023 08:51:05 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.0.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E903E3F738;
        Fri, 21 Jul 2023 08:50:18 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, mhiramat@kernel.org
Subject: [PATCH v3 07/12] PM: EM: Add update_power() callback for runtime modifications
Date:   Fri, 21 Jul 2023 16:50:17 +0100
Message-Id: <20230721155022.2339982-8-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721155022.2339982-1-lukasz.luba@arm.com>
References: <20230721155022.2339982-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Energy Model (EM) is going to support runtime modifications. This
new callback would be used in the upcoming EM changes. The drivers
or frameworks which want to modify the EM have to implement the
update_power() callback and provide it via EM API
em_dev_update_perf_domain(). The callback is then used by the EM
framework to get new power values for each frequency in existing EM.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 90c0822b664b..9b67f54ddcf0 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -168,6 +168,26 @@ struct em_data_callback {
 	 */
 	int (*get_cost)(struct device *dev, unsigned long freq,
 			unsigned long *cost);
+
+	/**
+	 * update_power() - Provide new power at the given performance state of
+	 *		a device
+	 * @dev		: Device for which we do this operation (can be a CPU)
+	 * @freq	: Frequency at the performance state in kHz
+	 * @power	: New power value at the performance state
+	 *		(modified)
+	 * @priv	: Pointer to private data useful for tracking context
+	 *		during run-time modifications of EM.
+	 *
+	 * The update_power() is used by run-time modifiable EM. It aims to
+	 * provide updated power value for a given frequency, which is stored
+	 * in the performance state. The power value provided by this callback
+	 * should fit in the [0, EM_MAX_POWER] range.
+	 *
+	 * Return 0 on success, or appropriate error value in case of failure.
+	 */
+	int (*update_power)(struct device *dev, unsigned long freq,
+			    unsigned long *power, void *priv);
 };
 #define EM_SET_ACTIVE_POWER_CB(em_cb, cb) ((em_cb).active_power = cb)
 #define EM_ADV_DATA_CB(_active_power_cb, _cost_cb)	\
@@ -175,6 +195,7 @@ struct em_data_callback {
 	  .get_cost = _cost_cb }
 #define EM_DATA_CB(_active_power_cb)			\
 		EM_ADV_DATA_CB(_active_power_cb, NULL)
+#define EM_UPDATE_CB(_update_power_cb) { .update_power = &_update_power_cb }
 
 struct em_perf_domain *em_cpu_get(int cpu);
 struct em_perf_domain *em_pd_get(struct device *dev);
-- 
2.25.1

