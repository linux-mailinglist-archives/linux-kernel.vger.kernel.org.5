Return-Path: <linux-kernel+bounces-143964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 072088A4023
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE211F21687
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCED22E647;
	Sun, 14 Apr 2024 04:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Wc722VBQ"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0DB22F17;
	Sun, 14 Apr 2024 04:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713067413; cv=none; b=TtqdXXotqovGlQY5N6Pkxov4c/wC2eC5+mMDbbgJJbROqS6NS5ww/ToD31uk9otYxwvgcxJtWdcYo0PH0HtzdL1p8k0HzS6iQBSJH5rCMH+GiAOJRWhxM0GfffsPdH8B+xeGO1BCzjxkSCW8EWYYvum5nNQPB23oq7BctWtOM/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713067413; c=relaxed/simple;
	bh=fKpDMbrKl8K++wdglSVzMvXM+hzrb+2MWjM49Rjpe8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KOgRin+j0xvSGoTDv19/nkGzDb0gPyoI+tx+fLckwYcaSJl8zBUAkpKoOC4u9hsHFr/EMvOc46UTDHdJGssVZJjMBwEzdwom7aWm+1VlqoRglr5Iy7XSxUtMcsXsrcZKVxcQtYZJjPtOmzJIlp+NUEIgp0GSk8CPiTAK3DTPoFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Wc722VBQ; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713067402; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bd8DTjNw5WR4wcmAoIDKy8eSVD9/ZeI0KThVPW+Pde8=;
	b=Wc722VBQwgGVNtDF4YU3nwmbYGooDBVmqOmffeFUD2MLBY+CuIw0VwRklFHxD0phTXBMy1A5D98e/jIKRc+MrGI0mbZQ6QUQvNHnp9rc9sYc6GI6wUvN5A9gcNKcwUSUCcf46oshvstDijas7mx8IsUqztvFdx0czTk2MxI9goQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W4RtLjO_1713067400;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W4RtLjO_1713067400)
          by smtp.aliyun-inc.com;
          Sun, 14 Apr 2024 12:03:22 +0800
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
Subject: [PATCH net-next v6 07/11] net/smc: register loopback-ism into SMC-D device list
Date: Sun, 14 Apr 2024 12:03:00 +0800
Message-Id: <20240414040304.54255-8-guwen@linux.alibaba.com>
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

After the loopback-ism device is ready, add it to the SMC-D device list
as an ISMv2 device, and always keep it at the beginning to ensure it is
preferred for providing a shortcut for data transfer within the same
kernel.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_ism.c      | 30 +++++++++++++++++++++---------
 net/smc/smc_ism.h      |  1 +
 net/smc/smc_loopback.c | 20 +++++++++++++-------
 3 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 188fd28423c2..6bed0a61b746 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -91,6 +91,11 @@ bool smc_ism_is_v2_capable(void)
 	return smc_ism_v2_capable;
 }
 
+void smc_ism_set_v2_capable(void)
+{
+	smc_ism_v2_capable = true;
+}
+
 /* Set a connection using this DMBE. */
 void smc_ism_set_conn(struct smc_connection *conn)
 {
@@ -439,7 +444,7 @@ static struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
 static void smcd_register_dev(struct ism_dev *ism)
 {
 	const struct smcd_ops *ops = ism_get_smcd_ops();
-	struct smcd_dev *smcd;
+	struct smcd_dev *smcd, *fentry;
 
 	if (!ops)
 		return;
@@ -454,16 +459,23 @@ static void smcd_register_dev(struct ism_dev *ism)
 	if (smc_pnetid_by_dev_port(&ism->pdev->dev, 0, smcd->pnetid))
 		smc_pnetid_by_table_smcd(smcd);
 
+	if (smcd->ops->supports_v2())
+		smc_ism_set_v2_capable();
 	mutex_lock(&smcd_dev_list.mutex);
-	if (list_empty(&smcd_dev_list.list)) {
-		if (smcd->ops->supports_v2())
-			smc_ism_v2_capable = true;
-	}
-	/* sort list: devices without pnetid before devices with pnetid */
-	if (smcd->pnetid[0])
+	/* sort list:
+	 * - devices without pnetid before devices with pnetid;
+	 * - loopback-ism always at the very beginning;
+	 */
+	if (!smcd->pnetid[0]) {
+		fentry = list_first_entry_or_null(&smcd_dev_list.list,
+						  struct smcd_dev, list);
+		if (fentry && smc_ism_is_loopback(fentry))
+			list_add(&smcd->list, &fentry->list);
+		else
+			list_add(&smcd->list, &smcd_dev_list.list);
+	} else {
 		list_add_tail(&smcd->list, &smcd_dev_list.list);
-	else
-		list_add(&smcd->list, &smcd_dev_list.list);
+	}
 	mutex_unlock(&smcd_dev_list.mutex);
 
 	pr_warn_ratelimited("smc: adding smcd device %s with pnetid %.16s%s\n",
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 322973527c61..e6f57e5e1ef9 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -52,6 +52,7 @@ int smc_ism_signal_shutdown(struct smc_link_group *lgr);
 void smc_ism_get_system_eid(u8 **eid);
 u16 smc_ism_get_chid(struct smcd_dev *dev);
 bool smc_ism_is_v2_capable(void);
+void smc_ism_set_v2_capable(void);
 int smc_ism_init(void);
 void smc_ism_exit(void);
 int smcd_nl_get_device(struct sk_buff *skb, struct netlink_callback *cb);
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index d75852549b00..94a57f4ee3f9 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -246,10 +246,12 @@ static int smcd_lo_register_dev(struct smc_lo_dev *ldev)
 		return -ENOMEM;
 	ldev->smcd = smcd;
 	smcd->priv = ldev;
-
-	/* TODO:
-	 * register loopback-ism to smcd_dev list.
-	 */
+	smc_ism_set_v2_capable();
+	mutex_lock(&smcd_dev_list.mutex);
+	list_add(&smcd->list, &smcd_dev_list.list);
+	mutex_unlock(&smcd_dev_list.mutex);
+	pr_warn_ratelimited("smc: adding smcd device %s\n",
+			    dev_name(&ldev->dev));
 	return 0;
 }
 
@@ -257,9 +259,13 @@ static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
 {
 	struct smcd_dev *smcd = ldev->smcd;
 
-	/* TODO:
-	 * unregister loopback-ism from smcd_dev list.
-	 */
+	pr_warn_ratelimited("smc: removing smcd device %s\n",
+			    dev_name(&ldev->dev));
+	smcd->going_away = 1;
+	smc_smcd_terminate_all(smcd);
+	mutex_lock(&smcd_dev_list.mutex);
+	list_del_init(&smcd->list);
+	mutex_unlock(&smcd_dev_list.mutex);
 	kfree(smcd->conn);
 	kfree(smcd);
 }
-- 
2.32.0.3.g01195cf9f


