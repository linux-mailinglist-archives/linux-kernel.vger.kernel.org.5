Return-Path: <linux-kernel+bounces-100356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 298F987963E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83653B253DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94B17E0EC;
	Tue, 12 Mar 2024 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gT7RMJL5"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A768D7CF1E;
	Tue, 12 Mar 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253692; cv=none; b=jIRUuPcs9L6vi/P8g6Kl1I0Pn+8nMh5+aZPxGiN2niDi5BhYjnH7n0i0lKqowVUuBXq1gxv+XPeR+dP8ErvK46eYFYFOw9nEpYx2PghYPR4i7/JW8ViBJeivLRLFqLO9HoyAlILuSSJ5C6z1ykw13BgtDho5NQcm6YC5/lF10sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253692; c=relaxed/simple;
	bh=5EwC3bhadXzJ+hUp9hD9WAJPjFyzgG3lHNPQviwJ9J8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MYh98i6N1xjEZxuDXTJ/dq+iy6hrNOlmmg/5UlgHdIJ/bn+iHeum7DH6pduLmQsy9ZNodanroPWcIZjkVjSU3zX1dXQEoTv810XVWegTJSHLTq8jGeZhiWKpMmbLaRsoieqbsgpldeQ288kDSfk4whYd2HE6ayx8zaZxYoMKeNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gT7RMJL5; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710253686; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xLD6AkbhABLaK4gsbGXt5WdC6JCys7PJYkOaexJ/m9E=;
	b=gT7RMJL5LrvtXZhOSYbh9EyeCv93G4ocWlxnNbXQTtHGit5UorSRq8/cguQdAK631jMQ0JAAViPY9/HxFwF3OvmvXu09gKiPW8IIiwK7giBMMjY5fToPk+QtllfIhsLKUfZ/IZSVMJM9kaDlBnBGyzL3YMYVvS6JTfR8EgVMfJ4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2MG3Ie_1710253683;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W2MG3Ie_1710253683)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 22:28:05 +0800
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
Subject: [PATCH net-next v3 03/11] net/smc: introduce loopback-ism for SMC intra-OS shortcut
Date: Tue, 12 Mar 2024 22:27:35 +0800
Message-Id: <20240312142743.41406-4-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240312142743.41406-1-guwen@linux.alibaba.com>
References: <20240312142743.41406-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This introduces a kind of Emulated-ISM device named loopback-ism for
SMCv2.1. The loopback-ism device is currently exclusive for SMC usage,
and aims to provide a SMC shortcut for sockets within the same kernel,
leading to improved intra-OS traffic performance. Configuration of this
feature is managed through the config SMC_LO.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/Kconfig        |  13 ++++
 net/smc/Makefile       |   2 +-
 net/smc/af_smc.c       |  12 ++-
 net/smc/smc_loopback.c | 164 +++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_loopback.h |  33 +++++++++
 5 files changed, 222 insertions(+), 2 deletions(-)
 create mode 100644 net/smc/smc_loopback.c
 create mode 100644 net/smc/smc_loopback.h

diff --git a/net/smc/Kconfig b/net/smc/Kconfig
index 746be3996768..2f1a8706a372 100644
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
+	  loopback-ism in SMC and the use of it for transferring data
+	  when communication occurs within the same OS. This helps in
+	  convenient testing of SMC-D since loopback-ism is independent
+	  of architecture or hardware.
+
+	  if unsure, say N.
diff --git a/net/smc/Makefile b/net/smc/Makefile
index 875efcd126a2..a8c37111abe1 100644
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
index 4b52b3b159c0..751a8fdd6eb0 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -53,6 +53,7 @@
 #include "smc_stats.h"
 #include "smc_tracepoint.h"
 #include "smc_sysctl.h"
+#include "smc_loopback.h"
 
 static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
 						 * creation on server
@@ -3557,15 +3558,23 @@ static int __init smc_init(void)
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
@@ -3603,6 +3612,7 @@ static void __exit smc_exit(void)
 	tcp_unregister_ulp(&smc_ulp_ops);
 	sock_unregister(PF_SMC);
 	smc_core_exit();
+	smc_loopback_exit();
 	smc_ib_unregister_client();
 	smc_ism_exit();
 	destroy_workqueue(smc_close_wq);
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
new file mode 100644
index 000000000000..e9170d86e58f
--- /dev/null
+++ b/net/smc/smc_loopback.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Shared Memory Communications Direct over loopback-ism device.
+ *
+ *  Provide a SMC-D loopback-ism device.
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
+#if IS_ENABLED(CONFIG_SMC_LO)
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
index 000000000000..9dd44d4c0ca3
--- /dev/null
+++ b/net/smc/smc_loopback.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Shared Memory Communications Direct over loopback-ism device.
+ *
+ *  Provide a SMC-D loopback-ism device.
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
+#endif
+
+int smc_loopback_init(void);
+void smc_loopback_exit(void);
+
+#endif /* _SMC_LOOPBACK_H */
-- 
2.32.0.3.g01195cf9f


