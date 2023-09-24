Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076A37ACA5C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 17:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjIXPR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 11:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjIXPRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 11:17:38 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D3ECD7;
        Sun, 24 Sep 2023 08:17:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VsilXj7_1695568638;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsilXj7_1695568638)
          by smtp.aliyun-inc.com;
          Sun, 24 Sep 2023 23:17:20 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     wintera@linux.ibm.com, schnelle@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, guwen@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 09/18] net/smc: introduce SMC-D loopback device
Date:   Sun, 24 Sep 2023 23:16:44 +0800
Message-Id: <1695568613-125057-10-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a kind of loopback device for SMC-D. The device
is created when SMC module is loaded and destroyed when the SMC module
is unloaded. The loopback device is a kernel device used only by the
SMC module and is not restricted by net namespace, so it can be used
for local inter-process or inter-container communication.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/Kconfig        |  13 ++++
 net/smc/Makefile       |   2 +-
 net/smc/af_smc.c       |  12 +++-
 net/smc/smc_loopback.c | 165 +++++++++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_loopback.h |  33 ++++++++++
 5 files changed, 223 insertions(+), 2 deletions(-)
 create mode 100644 net/smc/smc_loopback.c
 create mode 100644 net/smc/smc_loopback.h

diff --git a/net/smc/Kconfig b/net/smc/Kconfig
index 1ab3c5a..3e9e03e 100644
--- a/net/smc/Kconfig
+++ b/net/smc/Kconfig
@@ -19,3 +19,16 @@ config SMC_DIAG
 	  smcss.
 
 	  if unsure, say Y.
+
+config SMC_LO
+	bool "SMC_LO: virtual loopback-ism for SMC"
+	depends on SMC
+	default n
+	help
+	  SMC_LO provides a kind of virtual ISM device called loopback-ism
+	  for SMC-D to upgrade AF_INET TCP connections whose ends share the
+	  same kernel.
+	  loopback-ism is a software-implemented simulation device that does
+	  not depend on a specific architecture or hardware.
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
index c5b7716..6435659 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -53,6 +53,7 @@
 #include "smc_stats.h"
 #include "smc_tracepoint.h"
 #include "smc_sysctl.h"
+#include "smc_loopback.h"
 
 static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
 						 * creation on server
@@ -3565,15 +3566,23 @@ static int __init smc_init(void)
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
@@ -3611,6 +3620,7 @@ static void __exit smc_exit(void)
 	tcp_unregister_ulp(&smc_ulp_ops);
 	sock_unregister(PF_SMC);
 	smc_core_exit();
+	smc_loopback_exit();
 	smc_ib_unregister_client();
 	smc_ism_exit();
 	destroy_workqueue(smc_close_wq);
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
new file mode 100644
index 0000000..4631236
--- /dev/null
+++ b/net/smc/smc_loopback.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Shared Memory Communications Direct over loopback device.
+ *
+ *  Provide a SMC-D loopback dummy device.
+ *
+ *  Copyright (c) 2022, Alibaba Inc.
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
+static const char smc_lo_dev_name[] = "smc_lo";
+static struct smc_lo_dev *lo_dev;
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
+	.get_system_eid		= NULL,
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
+	smcd = smcd_lo_alloc_dev(&lo_ops, SMC_LODEV_MAX_DMBS);
+	if (!smcd)
+		return -ENOMEM;
+
+	ldev->smcd = smcd;
+	smcd->priv = ldev;
+
+	/* TODO:
+	 * register smc_lo to smcd_dev list.
+	 */
+	return 0;
+}
+
+static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
+{
+	/* TODO:
+	 * unregister smc_lo from smcd_dev list.
+	 */
+}
+
+static void smc_lo_dev_release(struct device *dev)
+{
+	struct smc_lo_dev *ldev =
+		container_of(dev, struct smc_lo_dev, dev);
+	struct smcd_dev *smcd = ldev->smcd;
+
+	kfree(smcd->conn);
+	kfree(smcd);
+	kfree(ldev);
+}
+
+static int smc_lo_dev_init(struct smc_lo_dev *ldev)
+{
+	return smcd_lo_register_dev(ldev);
+}
+
+static int smc_lo_dev_probe(void)
+{
+	struct smc_lo_dev *ldev;
+	int ret;
+
+	ldev = kzalloc(sizeof(*ldev), GFP_KERNEL);
+	if (!ldev)
+		return -ENOMEM;
+
+	ldev->dev.parent = NULL;
+	ldev->dev.release = smc_lo_dev_release;
+	device_initialize(&ldev->dev);
+	dev_set_name(&ldev->dev, smc_lo_dev_name);
+
+	ret = smc_lo_dev_init(ldev);
+	if (ret)
+		goto free_dev;
+
+	lo_dev = ldev; /* global loopback device */
+	return 0;
+
+free_dev:
+	kfree(ldev);
+	return ret;
+}
+
+static void smc_lo_dev_exit(struct smc_lo_dev *ldev)
+{
+	smcd_lo_unregister_dev(ldev);
+}
+
+static void smc_lo_dev_remove(void)
+{
+	if (!lo_dev)
+		return;
+
+	smc_lo_dev_exit(lo_dev);
+	put_device(&lo_dev->dev); /* device_initialize in smc_lo_dev_probe */
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
index 0000000..39aa1dc
--- /dev/null
+++ b/net/smc/smc_loopback.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Shared Memory Communications Direct over loopback device.
+ *
+ *  Provide a SMC-D loopback dummy device.
+ *
+ *  Copyright (c) 2022, Alibaba Inc.
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
+#define SMC_LODEV_MAX_DMBS 5000
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

