Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00BE7910B8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 07:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352172AbjIDFGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 01:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352110AbjIDFGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 01:06:51 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF53126;
        Sun,  3 Sep 2023 22:06:44 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 383M0leU008921;
        Sun, 3 Sep 2023 22:06:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=hc+Gf+zauvASElrSmlJ7hOR2X08qqMLQw81+hFpvqpM=;
 b=by1eDe1oLy3VyXNuSzwWgmFpSUUc9eyRVNOWp1q+ngcxgPlP76piTT9IhZUrjGDYXJjj
 LvB80gGUNtGCqMg72msm3Uzctzhxx0DMamLm0jC4B8jykTknXJzedNcZwF2AeIPbV2u3
 jfyR1huEfx4mCo6piMrz0bWKXPP+Q4s5O2HeKnrbKeGiJZJudsGaE95zud9Cfz+A1m4x
 lYhwagSZwT8jfM8Y3WLeSOJ2ggVkNzCSGa4Wu/puEFKQBzfQDAcGesMeAoeeoaOHRLWl
 dZ/mBv//91G9n9P3MqxvrWHTE6BFX2q0JT5nql7bq56NXBDusdP9WbMI8u/AnDVvsTE+ yg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sv4jk4b86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 03 Sep 2023 22:06:26 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 3 Sep
 2023 22:06:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 3 Sep 2023 22:06:24 -0700
Received: from localhost.localdomain (unknown [10.28.34.196])
        by maili.marvell.com (Postfix) with ESMTP id 13E203F7062;
        Sun,  3 Sep 2023 22:06:19 -0700 (PDT)
From:   Linu Cherian <lcherian@marvell.com>
To:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@arm.com>, <leo.yan@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: [RFC PATCH v3 3/7] coresight: core: Add provision for panic callbacks
Date:   Mon, 4 Sep 2023 10:35:43 +0530
Message-ID: <20230904050548.28047-4-lcherian@marvell.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904050548.28047-1-lcherian@marvell.com>
References: <20230904050548.28047-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: KjlDWI-iRg6_PHu3z-O9R_bu0MWUlHMa
X-Proofpoint-ORIG-GUID: KjlDWI-iRg6_PHu3z-O9R_bu0MWUlHMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_02,2023-08-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 118fcf27854d..de4e3947c8e5 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -20,6 +20,7 @@
 #include <linux/of_platform.h>
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
index bf70987240e4..09978ea6abe1 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -299,6 +299,7 @@ enum cs_mode {
 #define link_ops(csdev)		csdev->ops->link_ops
 #define helper_ops(csdev)	csdev->ops->helper_ops
 #define ect_ops(csdev)		csdev->ops->ect_ops
+#define panic_ops(csdev)	csdev->ops->panic_ops
 
 /**
  * struct coresight_ops_sink - basic operations for a sink
@@ -368,11 +369,22 @@ struct coresight_ops_helper {
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
2.41.0

