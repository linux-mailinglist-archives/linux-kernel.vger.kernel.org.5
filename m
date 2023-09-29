Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9245A7B33C8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjI2Nij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjI2Nif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:38:35 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8811BF2;
        Fri, 29 Sep 2023 06:38:30 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T27hux021218;
        Fri, 29 Sep 2023 06:38:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=MdfG2ojukoDEOsMMMrpEDyyuS2Js33DmU5C8pyHPvMk=;
 b=iXcPgEjzy1hq0vyRn6XJNjArTzlzCRm8XU4bEj49CxwN66V1Z6ICIV6w1zMZhXXqX4YG
 8PU3fxtqvyLbbEJOZJhHOqDt0KozaykzLFGQpWqjFLVZZgw2/MPfhqFp0vdgKHK3EIV2
 kvILr7xXOkNQPYST0gWaWXMloBVyIE3FcGghXhwHIDqskd+EvXMQJBI+yAL4RtUI3zj3
 dadW1MGdf6U3jmcx725N9drDqa57oXnwnUl9uq/bNl9JblVNLiZTRe3MPi3NyoTCl8oG
 TRuuq2wZIiZiz7C00uPQgW9lfiCbt1VYaEFNt1zxaQnsDzt1J6WsdPmQQJKSuoQ69Lb9 VA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3tcrrs985w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 06:38:22 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 29 Sep
 2023 06:38:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 29 Sep 2023 06:38:20 -0700
Received: from virtx40.. (unknown [10.28.34.196])
        by maili.marvell.com (Postfix) with ESMTP id BF28F5B6984;
        Fri, 29 Sep 2023 06:38:16 -0700 (PDT)
From:   Linu Cherian <lcherian@marvell.com>
To:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@arm.com>, <leo.yan@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: [PATCH 3/7] coresight: core: Add provision for panic callbacks
Date:   Fri, 29 Sep 2023 19:07:50 +0530
Message-ID: <20230929133754.857678-4-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929133754.857678-1-lcherian@marvell.com>
References: <20230929133754.857678-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: otehWNK3Ro0GH300KfnqgOdF7iKHWufn
X-Proofpoint-GUID: otehWNK3Ro0GH300KfnqgOdF7iKHWufn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panic callback handlers allows coresight device drivers to sync
relevant trace data and trace metadata to reserved memory
regions so that they can be retrieved later in the subsequent
boot or in the crashdump kernel.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 32 ++++++++++++++++++++
 include/linux/coresight.h                    | 12 ++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 9fabe00a40d6..dfa695c103de 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -20,6 +20,7 @@
 #include <linux/property.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
+#include <linux/panic_notifier.h>
 
 #include "coresight-etm-perf.h"
 #include "coresight-priv.h"
@@ -1800,6 +1801,31 @@ struct bus_type coresight_bustype = {
 	.name	= "coresight",
 };
 
+static int coresight_panic_sync(struct device *dev, void *data)
+{
+
+	struct coresight_device *csdev = container_of(dev, struct coresight_device, dev);
+
+	/* Run through panic sync handlers for all enabled devices */
+	if (csdev->enable && panic_ops(csdev))
+		panic_ops(csdev)->sync(csdev);
+
+	return 0;
+}
+
+static int coresight_panic_cb(struct notifier_block *self,
+			       unsigned long v, void *p)
+{
+	bus_for_each_dev(&coresight_bustype, NULL, NULL,
+				 coresight_panic_sync);
+
+	return 0;
+}
+
+static struct notifier_block coresight_notifier = {
+	.notifier_call = coresight_panic_cb,
+};
+
 static int __init coresight_init(void)
 {
 	int ret;
@@ -1812,6 +1838,10 @@ static int __init coresight_init(void)
 	if (ret)
 		goto exit_bus_unregister;
 
+	/* Register function to be called for panic */
+	ret = atomic_notifier_chain_register(&panic_notifier_list,
+					     &coresight_notifier);
+
 	/* initialise the coresight syscfg API */
 	ret = cscfg_init();
 	if (!ret)
@@ -1826,6 +1856,8 @@ static int __init coresight_init(void)
 static void __exit coresight_exit(void)
 {
 	cscfg_exit();
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					     &coresight_notifier);
 	etm_perf_exit();
 	bus_unregister(&coresight_bustype);
 }
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index a269fffaf991..4fd518738958 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -301,6 +301,7 @@ enum cs_mode {
 #define link_ops(csdev)		csdev->ops->link_ops
 #define helper_ops(csdev)	csdev->ops->helper_ops
 #define ect_ops(csdev)		csdev->ops->ect_ops
+#define panic_ops(csdev)	csdev->ops->panic_ops
 
 /**
  * struct coresight_ops_sink - basic operations for a sink
@@ -370,11 +371,22 @@ struct coresight_ops_helper {
 	int (*disable)(struct coresight_device *csdev, void *data);
 };
 
+
+/**
+ * struct coresight_ops_panic - Generic device ops for panic handing
+ *
+ * @sync	: Sync the device register state/trace data
+ */
+struct coresight_ops_panic {
+	int (*sync)(struct coresight_device *csdev);
+};
+
 struct coresight_ops {
 	const struct coresight_ops_sink *sink_ops;
 	const struct coresight_ops_link *link_ops;
 	const struct coresight_ops_source *source_ops;
 	const struct coresight_ops_helper *helper_ops;
+	const struct coresight_ops_panic *panic_ops;
 };
 
 #if IS_ENABLED(CONFIG_CORESIGHT)
-- 
2.34.1

