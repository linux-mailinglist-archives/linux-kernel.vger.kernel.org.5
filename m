Return-Path: <linux-kernel+bounces-23546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2586082AE45
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3151C213B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A7F28372;
	Thu, 11 Jan 2024 12:01:40 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F5015AC3;
	Thu, 11 Jan 2024 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W-Pewec_1704974493;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W-Pewec_1704974493)
          by smtp.aliyun-inc.com;
          Thu, 11 Jan 2024 20:01:35 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	wenjia@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 14/15] net/smc: introduce loopback-ism DMB data copy control
Date: Thu, 11 Jan 2024 20:00:35 +0800
Message-Id: <20240111120036.109903-15-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240111120036.109903-1-guwen@linux.alibaba.com>
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This provides a way to {get|set} whether loopback-ism device supports
merging sndbuf with peer DMB to eliminate data copies between them.

echo 0 > /sys/devices/virtual/smc/loopback-ism/dmb_copy # support
echo 1 > /sys/devices/virtual/smc/loopback-ism/dmb_copy # not support

The settings take effect after re-activating loopback-ism by:

echo 0 > /sys/devices/virtual/smc/loopback-ism/active
echo 1 > /sys/devices/virtual/smc/loopback-ism/active

After this, the link group related to loopback-ism will be flushed and
the sndbufs of subsequent connections will be merged or not merged with
peer DMB.

The motivation of this control is that the bandwidth will be highly
improved when sndbuf and DMB are merged, but when virtually contiguous
DMB is provided and merged with sndbuf, it will be concurrently accessed
on Tx and Rx, then there will be a bottleneck caused by lock contention
of find_vmap_area when there are many CPUs and CONFIG_HARDENED_USERCOPY
is set (see link below). So an option is provided.

Link: https://lore.kernel.org/all/238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com/
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_loopback.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_loopback.h |  8 +++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 2e734f8e08f5..bfbb346ef01a 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -26,6 +26,7 @@
 
 static const char smc_lo_dev_name[] = "loopback-ism";
 static unsigned int smc_lo_dmb_type = SMC_LO_DMB_PHYS;
+static unsigned int smc_lo_dmb_copy = SMC_LO_DMB_NOCOPY;
 static struct smc_lo_dev *lo_dev;
 static struct class *smc_class;
 
@@ -167,9 +168,52 @@ static ssize_t dmb_type_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(dmb_type);
+
+static ssize_t dmb_copy_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct smc_lo_dev *ldev =
+		container_of(dev, struct smc_lo_dev, dev);
+	const char *copy;
+
+	switch (ldev->dmb_copy) {
+	case SMC_LO_DMB_NOCOPY:
+		copy = "sndbuf and DMB merged and no data copied";
+		break;
+	case SMC_LO_DMB_COPY:
+		copy = "sndbuf and DMB separated and data copied";
+		break;
+	default:
+		copy = "Unknown setting";
+	}
+
+	return sysfs_emit(buf, "%d: %s\n", ldev->dmb_copy, copy);
+}
+
+static ssize_t dmb_copy_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	unsigned int dmb_copy;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &dmb_copy);
+	if (ret)
+		return ret;
+
+	if (dmb_copy != SMC_LO_DMB_NOCOPY &&
+	    dmb_copy != SMC_LO_DMB_COPY)
+		return -EINVAL;
+
+	smc_lo_dmb_copy = dmb_copy; /* re-activate to take effect */
+	return count;
+}
+static DEVICE_ATTR_RW(dmb_copy);
+
 static struct attribute *smc_lo_attrs[] = {
 	&dev_attr_active.attr,
 	&dev_attr_dmb_type.attr,
+	&dev_attr_dmb_copy.attr,
 	&dev_attr_xfer_bytes.attr,
 	&dev_attr_dmbs_cnt.attr,
 	NULL,
@@ -451,6 +495,7 @@ static int smcd_lo_register_dev(struct smc_lo_dev *ldev)
 	smcd->priv = ldev;
 	smc_ism_set_v2_capable();
 	ldev->dmb_type = smc_lo_dmb_type;
+	ldev->dmb_copy = smc_lo_dmb_copy;
 	mutex_lock(&smcd_dev_list.mutex);
 	list_add(&smcd->list, &smcd_dev_list.list);
 	mutex_unlock(&smcd_dev_list.mutex);
@@ -475,6 +520,7 @@ static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
 	kfree(smcd->conn);
 	kfree(smcd);
 	ldev->dmb_type = smc_lo_dmb_type;
+	ldev->dmb_copy = smc_lo_dmb_copy;
 	smc_lo_clear_stats(ldev);
 }
 
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
index 8ee5c6805fc4..7ecb4a35eb36 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -28,6 +28,11 @@ enum {
 	SMC_LO_DMB_VIRT,
 };
 
+enum {
+	SMC_LO_DMB_NOCOPY,
+	SMC_LO_DMB_COPY,
+};
+
 struct smc_lo_dmb_node {
 	struct hlist_node list;
 	u64 token;
@@ -45,7 +50,8 @@ struct smc_lo_dev_stats64 {
 struct smc_lo_dev {
 	struct smcd_dev *smcd;
 	struct device dev;
-	u8 active;
+	u8 active : 1;
+	u8 dmb_copy : 1;
 	u8 dmb_type;
 	u16 chid;
 	struct smcd_gid local_gid;
-- 
2.32.0.3.g01195cf9f


