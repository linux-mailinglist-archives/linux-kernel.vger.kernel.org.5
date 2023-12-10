Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764DE80BAEC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 14:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjLJNYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 08:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjLJNYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 08:24:23 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F1E10D;
        Sun, 10 Dec 2023 05:24:26 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vy8Bbmi_1702214662;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vy8Bbmi_1702214662)
          by smtp.aliyun-inc.com;
          Sun, 10 Dec 2023 21:24:24 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 03/13] net/smc: introduce virtual ISM device loopback-ism
Date:   Sun, 10 Dec 2023 21:24:04 +0800
Message-Id: <1702214654-32069-4-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702214654-32069-1-git-send-email-guwen@linux.alibaba.com>
References: <1702214654-32069-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a kind of virtual ISM device loopback-ism for SMCDv2.1.
loopback-ism is implemented by software and serves inter-process or
inter-container SMC communication in the same OS instance. It is created
during SMC module loading and destroyed upon unloading. The support for
loopback-ism can be configured via CONFIG_SMC_LO.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/Kconfig        |  13 ++++
 net/smc/Makefile       |   2 +-
 net/smc/af_smc.c       |  12 +++-
 net/smc/smc_loopback.c | 181 +++++++++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_loopback.h |  33 +++++++++
 5 files changed, 239 insertions(+), 2 deletions(-)
 create mode 100644 net/smc/smc_loopback.c
 create mode 100644 net/smc/smc_loopback.h

diff --git a/net/smc/Kconfig b/net/smc/Kconfig
index 746be39..e191f78 100644
--- a/net/smc/Kconfig
+++ b/net/smc/Kconfig
@@ -20,3 +20,16 @@ config SMC_DIAG
 	  smcss.
 
 	  if unsure, say Y.
+
+config SMC_LO
+	bool "SMC_LO: virtual ISM loopback-ism for SMC"
+	depends on SMC
+	default n
+	help
+	  SMC_LO provides a kind of virtual ISM device called loopback-ism
+	  for SMCD to upgrade AF_INET TCP connections whose ends share the
+	  same kernel.
+	  loopback-ism is a software implemented device that does not depend
+	  on a specific architecture or hardware.
+
+	  if unsure, say N.
diff --git a/net/smc/Makefile b/net/smc/Makefile
index 875efcd..a8c3711 100644
--- a/net/smc/Makefile
+++ b/net/smc/Makefile
@@ -4,5 +4,5 @@ obj-$(CONFIG_SMC)	+= smc.o
 obj-$(CONFIG_SMC_DIAG)	+= smc_diag.o
 smc-y := af_smc.o smc_pnet.o smc_ib.o smc_clc.o smc_core.o smc_wr.o smc_llc.o
 smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o smc_netlink.o smc_stats.o
-smc-y += smc_tracepoint.o
+smc-y += smc_tracepoint.o smc_loopback.o
 smc-$(CONFIG_SYSCTL) += smc_sysctl.o
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9cdc974..6c0e381 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -53,6 +53,7 @@
 #include "smc_stats.h"
 #include "smc_tracepoint.h"
 #include "smc_sysctl.h"
+#include "smc_loopback.h"
 
 static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
 						 * creation on server
@@ -3574,15 +3575,23 @@ static int __init smc_init(void)
 		goto out_sock;
 	}
 
+	rc = smc_loopback_init();
+	if (rc) {
+		pr_err("%s: smc_loopback_init fails with %d\n", __func__, rc);
+		goto out_ib;
+	}
+
 	rc = tcp_register_ulp(&smc_ulp_ops);
 	if (rc) {
 		pr_err("%s: tcp_ulp_register fails with %d\n", __func__, rc);
-		goto out_ib;
+		goto out_lo;
 	}
 
 	static_branch_enable(&tcp_have_smc);
 	return 0;
 
+out_lo:
+	smc_loopback_exit();
 out_ib:
 	smc_ib_unregister_client();
 out_sock:
@@ -3620,6 +3629,7 @@ static void __exit smc_exit(void)
 	tcp_unregister_ulp(&smc_ulp_ops);
 	sock_unregister(PF_SMC);
 	smc_core_exit();
+	smc_loopback_exit();
 	smc_ib_unregister_client();
 	smc_ism_exit();
 	destroy_workqueue(smc_close_wq);
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
new file mode 100644
index 0000000..149ccaa
--- /dev/null
+++ b/net/smc/smc_loopback.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Shared Memory Communications Direct over loopback-ism device.
+ *
+ *  Provide a SMC-D loopback-ism device.
+ *
+ *  Copyright (c) 2023, Alibaba Inc.
+ *
+ *  Author: Wen Gu <guwen@linux.alibaba.com>
+ *          Tony Lu <tonylu@linux.alibaba.com>
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/types.h>
+#include <net/smc.h>
+
+#include "smc_ism.h"
+#include "smc_loopback.h"
+
+#if IS_ENABLED(CONFIG_SMC_LO)
+static const char smc_lo_dev_name[] = "loopback-ism";
+static struct smc_lo_dev *lo_dev;
+static struct class *smc_class;
+
+static const struct smcd_ops lo_ops = {
+	.query_remote_gid	= NULL,
+	.register_dmb		= NULL,
+	.unregister_dmb		= NULL,
+	.add_vlan_id		= NULL,
+	.del_vlan_id		= NULL,
+	.set_vlan_required	= NULL,
+	.reset_vlan_required	= NULL,
+	.signal_event		= NULL,
+	.move_data		= NULL,
+	.supports_v2		= NULL,
+	.get_local_gid		= NULL,
+	.get_chid		= NULL,
+	.get_dev		= NULL,
+};
+
+static struct smcd_dev *smcd_lo_alloc_dev(const struct smcd_ops *ops,
+					  int max_dmbs)
+{
+	struct smcd_dev *smcd;
+
+	smcd = kzalloc(sizeof(*smcd), GFP_KERNEL);
+	if (!smcd)
+		return NULL;
+
+	smcd->conn = kcalloc(max_dmbs, sizeof(struct smc_connection *),
+			     GFP_KERNEL);
+	if (!smcd->conn)
+		goto out_smcd;
+
+	smcd->ops = ops;
+
+	spin_lock_init(&smcd->lock);
+	spin_lock_init(&smcd->lgr_lock);
+	INIT_LIST_HEAD(&smcd->vlan);
+	INIT_LIST_HEAD(&smcd->lgr_list);
+	init_waitqueue_head(&smcd->lgrs_deleted);
+	return smcd;
+
+out_smcd:
+	kfree(smcd);
+	return NULL;
+}
+
+static int smcd_lo_register_dev(struct smc_lo_dev *ldev)
+{
+	struct smcd_dev *smcd;
+
+	smcd = smcd_lo_alloc_dev(&lo_ops, SMC_LO_MAX_DMBS);
+	if (!smcd)
+		return -ENOMEM;
+	ldev->smcd = smcd;
+	smcd->priv = ldev;
+
+	/* TODO:
+	 * register loopback-ism to smcd_dev list.
+	 */
+	return 0;
+}
+
+static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
+{
+	struct smcd_dev *smcd = ldev->smcd;
+
+	/* TODO:
+	 * unregister loopback-ism from smcd_dev list.
+	 */
+	kfree(smcd->conn);
+	kfree(smcd);
+}
+
+static int smc_lo_dev_init(struct smc_lo_dev *ldev)
+{
+	return smcd_lo_register_dev(ldev);
+}
+
+static void smc_lo_dev_exit(struct smc_lo_dev *ldev)
+{
+	smcd_lo_unregister_dev(ldev);
+}
+
+static void smc_lo_dev_release(struct device *dev)
+{
+	struct smc_lo_dev *ldev =
+		container_of(dev, struct smc_lo_dev, dev);
+
+	kfree(ldev);
+}
+
+static int smc_lo_dev_probe(void)
+{
+	struct smc_lo_dev *ldev;
+	int ret;
+
+	smc_class = class_create("smc");
+	if (IS_ERR(smc_class))
+		return PTR_ERR(smc_class);
+
+	ldev = kzalloc(sizeof(*ldev), GFP_KERNEL);
+	if (!ldev) {
+		ret = -ENOMEM;
+		goto destroy_class;
+	}
+
+	ldev->dev.parent = NULL;
+	ldev->dev.class = smc_class;
+	ldev->dev.release = smc_lo_dev_release;
+	device_initialize(&ldev->dev);
+	dev_set_name(&ldev->dev, smc_lo_dev_name);
+	ret = device_add(&ldev->dev);
+	if (ret)
+		goto free_dev;
+
+	ret = smc_lo_dev_init(ldev);
+	if (ret)
+		goto del_dev;
+
+	lo_dev = ldev; /* global loopback device */
+	return 0;
+
+del_dev:
+	device_del(&ldev->dev);
+free_dev:
+	put_device(&ldev->dev);
+destroy_class:
+	class_destroy(smc_class);
+	return ret;
+}
+
+static void smc_lo_dev_remove(void)
+{
+	if (!lo_dev)
+		return;
+
+	smc_lo_dev_exit(lo_dev);
+	device_del(&lo_dev->dev); /* device_add in smc_lo_dev_probe */
+	put_device(&lo_dev->dev); /* device_initialize in smc_lo_dev_probe */
+	class_destroy(smc_class);
+}
+#endif
+
+int smc_loopback_init(void)
+{
+#if IS_ENABLED(CONFIG_SMC_LO)
+	return smc_lo_dev_probe();
+#else
+	return 0;
+#endif
+}
+
+void smc_loopback_exit(void)
+{
+#if IS_ENABLED(CONFIG_SMC_LO)
+	smc_lo_dev_remove();
+#endif
+}
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
new file mode 100644
index 0000000..a7c418b
--- /dev/null
+++ b/net/smc/smc_loopback.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Shared Memory Communications Direct over loopback-ism device.
+ *
+ *  Provide a SMC-D loopback-ism device.
+ *
+ *  Copyright (c) 2023, Alibaba Inc.
+ *
+ *  Author: Wen Gu <guwen@linux.alibaba.com>
+ *          Tony Lu <tonylu@linux.alibaba.com>
+ *
+ */
+
+#ifndef _SMC_LOOPBACK_H
+#define _SMC_LOOPBACK_H
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <net/smc.h>
+
+#if IS_ENABLED(CONFIG_SMC_LO)
+#define SMC_LO_MAX_DMBS		5000
+
+struct smc_lo_dev {
+	struct smcd_dev *smcd;
+	struct device dev;
+};
+#endif
+
+int smc_loopback_init(void);
+void smc_loopback_exit(void);
+
+#endif /* _SMC_LOOPBACK_H */
-- 
1.8.3.1

