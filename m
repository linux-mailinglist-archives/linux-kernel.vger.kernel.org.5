Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1F67AD2E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjIYIME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjIYILl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:11:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 672141AC;
        Mon, 25 Sep 2023 01:11:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E703DA7;
        Mon, 25 Sep 2023 01:12:12 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.93.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B604D3F5A1;
        Mon, 25 Sep 2023 01:11:31 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v4 08/18] PM: EM: Add update_power() callback for runtime modifications
Date:   Mon, 25 Sep 2023 09:11:29 +0100
Message-Id: <20230925081139.1305766-9-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230925081139.1305766-1-lukasz.luba@arm.com>
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Energy Model (EM) is going to support runtime modifications. This
new callback would be used in the upcoming EM changes. The drivers
or frameworks which want to modify the EM have to implement the
update_power() callback.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index d236e08e80dc..546dee90f716 100644
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
+	 *		during runtime modifications of EM.
+	 *
+	 * The update_power() is used by runtime modifiable EM. It aims to
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
@@ -331,6 +352,7 @@ struct em_data_callback {};
 #define EM_ADV_DATA_CB(_active_power_cb, _cost_cb) { }
 #define EM_DATA_CB(_active_power_cb) { }
 #define EM_SET_ACTIVE_POWER_CB(em_cb, cb) do { } while (0)
+#define EM_UPDATE_CB(_update_cb) { }
 
 static inline
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
-- 
2.25.1

