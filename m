Return-Path: <linux-kernel+bounces-161276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2B18B4A01
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA08C281F02
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 06:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200BE42059;
	Sun, 28 Apr 2024 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A+fB4QYN"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1920D38F9A;
	Sun, 28 Apr 2024 06:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714284484; cv=none; b=iyx3YhpyxM7PfoK/sPdJoUWPpOzIOdjm971I3W3ZD2+rI2K8OLuY3t0EazrAPjJwUTmurikJ0u4tWSEfJTLWlBXkbJ1Kb1ZSDO+u7HFISpdtVBDmZZ3qZWnRb0/lB/g0AoCNhKAjKYjJ2VAMeesTixtuszLp94q4v5cA0lGyMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714284484; c=relaxed/simple;
	bh=VfChBb5NY2sD7cjJ+plI34GBwbzwhxKYRG5R1P3ErH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PpRRb+ddk0KTVxg8wbPI0N38m7HpJtc+IadIBr77DeCGGxRlHPUS6icpO3D2KDzpO4M+U+Ccqwy5FAz7Q/oljr0bkyGOY+FMjd+KdNuo9w7bGo/A4HnLxpKmQ/QUo4kc768XUPhuYgGtJpRSLW5sWecjthd9V7Gc0ItNp9uik9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A+fB4QYN; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714284479; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Pavbn5GKxTQ0KyFru8g513+oE9ZBHjO+JDIkr9qp/pw=;
	b=A+fB4QYNqA0CDcn0q33jf+5JlS3N/BOe8t0+59i+CirG9Ub+RokeI3wZMeDb4BDU/GUPdsOBSP70V1OHQl9jtR573KM9fZb1QbxDUIrIa02m5rqJ2S/DX1ThB22XBTco+jX/KmT+MxSnAlbpJOAxi3AJtzud0cTGacj1XIPjB3U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W5NOUuS_1714284476;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W5NOUuS_1714284476)
          by smtp.aliyun-inc.com;
          Sun, 28 Apr 2024 14:07:58 +0800
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
Subject: [PATCH net-next v7 07/11] net/smc: register loopback-ism into SMC-D device list
Date: Sun, 28 Apr 2024 14:07:34 +0800
Message-Id: <20240428060738.60843-8-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240428060738.60843-1-guwen@linux.alibaba.com>
References: <20240428060738.60843-1-guwen@linux.alibaba.com>
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
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-and-tested-by: Jan Karcher <jaka@linux.ibm.com>
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


