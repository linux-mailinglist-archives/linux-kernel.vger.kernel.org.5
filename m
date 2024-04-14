Return-Path: <linux-kernel+bounces-143959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFC38A4014
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E63C1C20FAA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCCB1CD2B;
	Sun, 14 Apr 2024 04:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Q4qpUMf9"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E6D1B962;
	Sun, 14 Apr 2024 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713067404; cv=none; b=Q+WNJ5K9UQFwK1V6/c+U0UFu6b2nuMNZL/e8LH9RgMHOR9NWwSg0zhMJwn3dhSfeoLPILy5xFH/rlotSRxZDzUxUjZwdA86rtd7z1FEYCGH8tZJToVDkxjYGPw8beb0eATosSL70DirYfgsssxJO5DJ7rOfdJ5yU/EA9fgGRk68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713067404; c=relaxed/simple;
	bh=xffJsXZmlAYAJhmxP7GbTCnj01b/iE/pnPuGnE3/YT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CxYnZXExbur2wBgb5Qe5974xOeSp3nPcA2X7Mhp8nMa/HcN6KqXWyuPoyVrle6zu5P0mHo/a9f8tOMAieGPBYuB6rt1w9btiyRpXOlgZIOCCKNtI0sQGC9Dj/jmZ9g6kXe9/DMUwoy30u8egtHIXOobBwELbtExr962jmDTBfYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Q4qpUMf9; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713067393; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LzYDkPPpX+JS4P8DJQhEGWcb0woJLRsAFkOvM5MDYds=;
	b=Q4qpUMf99vqoNVM+FOFjujpzHaU6bdNNTCGn1t8iHhUlRVgyet7Z7MuhGSxz8SDTljpyMiO60Do2hRHKu50dPInDJ3Wzu/fIYKZaX0lZ/sWIUI2NVaiT66fP0Oy7gDb4xckhCr7tJ5Imy7Vyck/cMQACh5Muf4QYOUjPJuM3leI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W4RtLgZ_1713067391;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W4RtLgZ_1713067391)
          by smtp.aliyun-inc.com;
          Sun, 14 Apr 2024 12:03:13 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	twinkler@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 02/11] net/smc: introduce loopback-ism for SMC intra-OS shortcut
Date: Sun, 14 Apr 2024 12:02:55 +0800
Message-Id: <20240414040304.54255-3-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240414040304.54255-1-guwen@linux.alibaba.com>
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This introduces a kind of Emulated-ISM device named loopback-ism for
SMCv2.1. The loopback-ism device is currently exclusive for SMC usage,
and aims to provide an SMC shortcut for sockets within the same kernel,
leading to improved intra-OS traffic performance. Configuration of this
feature is managed through the config SMC_LO.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/Kconfig        |  13 ++++
 net/smc/Makefile       |   1 +
 net/smc/af_smc.c       |  12 +++-
 net/smc/smc_loopback.c | 156 +++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_loopback.h |  43 ++++++++++++
 5 files changed, 224 insertions(+), 1 deletion(-)
 create mode 100644 net/smc/smc_loopback.c
 create mode 100644 net/smc/smc_loopback.h

diff --git a/net/smc/Kconfig b/net/smc/Kconfig
index 746be3996768..ba5e6a2dd2fd 100644
--- a/net/smc/Kconfig
+++ b/net/smc/Kconfig
@@ -20,3 +20,16 @@ config SMC_DIAG
 	  smcss.
 
 	  if unsure, say Y.
+
+config SMC_LO
+	bool "SMC intra-OS shortcut with loopback-ism"
+	depends on SMC
+	default n
+	help
+	  SMC_LO enables the creation of an Emulated-ISM device named
+	  loopback-ism in SMC and makes use of it for transferring data
+	  when communication occurs within the same OS. This helps in
+	  convenient testing of SMC-D since loopback-ism is independent
+	  of architecture or hardware.
+
+	  if unsure, say N.
diff --git a/net/smc/Makefile b/net/smc/Makefile
index 875efcd126a2..2c510d543058 100644
--- a/net/smc/Makefile
+++ b/net/smc/Makefile
@@ -6,3 +6,4 @@ smc-y := af_smc.o smc_pnet.o smc_ib.o smc_clc.o smc_core.o smc_wr.o smc_llc.o
 smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o smc_netlink.o smc_stats.o
 smc-y += smc_tracepoint.o
 smc-$(CONFIG_SYSCTL) += smc_sysctl.o
+smc-$(CONFIG_SMC_LO) += smc_loopback.o
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e8dcd28a554c..47f3bc1470bc 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -53,6 +53,7 @@
 #include "smc_stats.h"
 #include "smc_tracepoint.h"
 #include "smc_sysctl.h"
+#include "smc_loopback.h"
 
 static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
 						 * creation on server
@@ -3555,15 +3556,23 @@ static int __init smc_init(void)
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
@@ -3601,6 +3610,7 @@ static void __exit smc_exit(void)
 	tcp_unregister_ulp(&smc_ulp_ops);
 	sock_unregister(PF_SMC);
 	smc_core_exit();
+	smc_loopback_exit();
 	smc_ib_unregister_client();
 	smc_ism_exit();
 	destroy_workqueue(smc_close_wq);
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
new file mode 100644
index 000000000000..c364e3e6e3fb
--- /dev/null
+++ b/net/smc/smc_loopback.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Shared Memory Communications Direct over loopback-ism device.
+ *
+ *  Functions for loopback-ism device.
+ *
+ *  Copyright (c) 2024, Alibaba Inc.
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
+static const char smc_lo_dev_name[] = "loopback-ism";
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
+	put_device(&ldev->dev);
+	return ret;
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
+
+int smc_loopback_init(void)
+{
+	return smc_lo_dev_probe();
+}
+
+void smc_loopback_exit(void)
+{
+	smc_lo_dev_remove();
+}
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
new file mode 100644
index 000000000000..c6c97e2c461d
--- /dev/null
+++ b/net/smc/smc_loopback.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Shared Memory Communications Direct over loopback-ism device.
+ *
+ *  SMC-D loopback-ism device structure definitions.
+ *
+ *  Copyright (c) 2024, Alibaba Inc.
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
+
+int smc_loopback_init(void);
+void smc_loopback_exit(void);
+#else
+static inline int smc_loopback_init(void)
+{
+	return 0;
+}
+
+static inline void smc_loopback_exit(void)
+{
+	return;
+}
+#endif
+
+#endif /* _SMC_LOOPBACK_H */
-- 
2.32.0.3.g01195cf9f


