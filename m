Return-Path: <linux-kernel+bounces-103275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E6D87BD56
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D481F21B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F346D1CE;
	Thu, 14 Mar 2024 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f/JghuY+"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867905B053;
	Thu, 14 Mar 2024 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421782; cv=none; b=Zjks980vXUfnoGY7LNHRDKQ5Cd+12nli/op6fGkkHB7Uw3jSc0rzvVoES4OXIq8Y2PoIuUotaw5wgUgXqMprOYmZBwnEbGunJhbgQ4GMAL03xTNdy5CYQ50pu1jD2n4/IwXt4jN6d04s31vGxyhz+fIPbV2rjgNb+TgDg8+3Xu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421782; c=relaxed/simple;
	bh=yOPR0Zbn1qcczRJNU2nNR4U21WiG7WeES3qpgQLUzdo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=MZb9TmavpJaxWbkIC1S2Xi27giZz1h2Wl9Frib8BQGVJTmYngcEhVWzCNOdn71YopkHT8p11NTCWLwXknUnCpA0734DiLPMLtfaMl8OUEpYcFywxMWKKTKtTG6kOg0FuO/GN7E1kfN/6wuk8SYZp/JZ7CBi7PNTJMVA4UXA4FkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f/JghuY+; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710421777; h=From:To:Subject:Date:Message-Id;
	bh=ylsWvCOgTo7S38bqWioWFn9s2xSgJZ6Xd6Q/rSdKfeE=;
	b=f/JghuY+tMIIOyFc8hjWn/RYD7nGIs8x2H4Tq6E2KCu7YS2Bx6t/DfO+jHqqPLH/Sp+Xai4KdWqFQrv3iEteaDqL6I9niKVOrOuSTsM7BDl8yISN+cqLbfRjjMQk9FyPRbHxJiAHJ04vePJF+1RpsuMsEKGZidhYp0r/fZtzNgg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W2Ssz9s_1710421775;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W2Ssz9s_1710421775)
          by smtp.aliyun-inc.com;
          Thu, 14 Mar 2024 21:09:36 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "David S. Miller" <davem@davemloft.net>,
	Tal Gilboa <talgi@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [RFC PATCH 1/2] net: add sysfs attributes for customized dim profile management
Date: Thu, 14 Mar 2024 21:09:32 +0800
Message-Id: <1710421773-61277-2-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710421773-61277-1-git-send-email-hengqi@linux.alibaba.com>
References: <1710421773-61277-1-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The NetDIM library, currently leveraged by an array of NICs, delivers
excellent acceleration benefits. Nevertheless, NICs vary significantly
in their dim profile list prerequisites.

Specifically, virtio-net backends may present diverse sw or hw device
implementation, making a one-size-fits-all parameter list impractical.
On Alibaba Cloud, the virtio DPU's performance under the default DIM
profile falls short of expectations, partly due to a mismatch in
parameter configuration.

I also noticed that ice/idpf/ena and other NICs have customized
profilelist or placed some restrictions on dim capabilities.

Motivated by this, I tried adding new sysfs attributes that provides
a per-device control to modify and access a device's interrupt parameters.

Usage
========
1. Query the currently customized list of the device

$ cat dim_profs
The profiles of (RX, EQE):
{.usec =   1, .pkts = 256, .comps =   0,},
{.usec =   8, .pkts = 256, .comps =   0,},
{.usec =  64, .pkts = 256, .comps =   0,},
{.usec = 128, .pkts = 256, .comps =   0,},
{.usec = 256, .pkts = 256, .comps =   0,}
The profiles of (TX, EQE):
{.usec =   1, .pkts = 256, .comps =   0,},
{.usec =   2, .pkts = 256, .comps =   0,},
{.usec =   3, .pkts = 256, .comps =   0,},
{.usec =   4, .pkts = 256, .comps =   0,},
{.usec =   5, .pkts = 256, .comps =   0,}

2. Tune

$ echo "RX EQE 8,8,0 16,16,0 32,32,0 64,64,0 128,128,0" > dim_profs
$ echo "  TX  EQE 0,2,0   1,3,0 2,4,0   3,5,0  4,6,0   " > dim_profs
$ cat dim_profs
The profiles of (RX, EQE):
{.usec =   8, .pkts =   8, .comps =   0,},
{.usec =  16, .pkts =  16, .comps =   0,},
{.usec =  32, .pkts =  32, .comps =   0,},
{.usec =  64, .pkts =  64, .comps =   0,},
{.usec = 128, .pkts = 128, .comps =   0,}
The profiles of (TX, EQE):
{.usec =   0, .pkts =   2, .comps =   0,},
{.usec =   1, .pkts =   3, .comps =   0,},
{.usec =   2, .pkts =   4, .comps =   0,},
{.usec =   3, .pkts =   5, .comps =   0,},
{.usec =   4, .pkts =   6, .comps =   0,}

3. Warn
If the device does not support .ndo_dim_moder_{set, get},
the following warning will response:
"Profile is default and not customized by the device."

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 Documentation/ABI/testing/sysfs-class-net |  17 +++
 include/linux/dim.h                       |   7 ++
 include/linux/netdevice.h                 |  35 ++++++
 lib/dim/net_dim.c                         |   6 --
 net/core/net-sysfs.c                      | 172 ++++++++++++++++++++++++++++++
 5 files changed, 231 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net b/Documentation/ABI/testing/sysfs-class-net
index ebf21be..1e4faa8 100644
--- a/Documentation/ABI/testing/sysfs-class-net
+++ b/Documentation/ABI/testing/sysfs-class-net
@@ -352,3 +352,20 @@ Description:
 		0  threaded mode disabled for this dev
 		1  threaded mode enabled for this dev
 		== ==================================
+
+What:		/sys/class/net/<iface>/dim_profs
+Date:		Mar 2024
+KernelVersion:	6.8
+Contact:	netdev@vger.kernel.org
+Description:
+		String value to control the profile list of DIM per device. User could
+		set this value to tune the profile list for RX/TX direction and EQE/CQE
+		mode respectively.
+
+		Possible values:
+		================================================ ==========================
+		RX EQE 1,1,0  2,2,0   3,3,0   4,4,0    5,5,0     tune RX + EQE profile list
+		RX CQE 8,8,0  16,16,0 32,32,0 64,64,0  128,128,0 tune RX + CQE profile list
+		TX EQE 16,8,0 2,16,0  16,8,0  32,64,0  128,64,0  tune TX + EQE profile list
+		TX CQE 8,5,0  8,16,0  32,12,0 128,64,0 256,128,0 tune TX + CQE profile list
+		================================================ ==========================
diff --git a/include/linux/dim.h b/include/linux/dim.h
index f343bc9..43398f5 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -10,6 +10,13 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+/* Number of DIM profiles and period mode. */
+#define NET_DIM_PARAMS_NUM_PROFILES 5
+#define NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE 256
+#define NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE 128
+#define NET_DIM_DEF_PROFILE_CQE 1
+#define NET_DIM_DEF_PROFILE_EQE 1
+
 /*
  * Number of events between DIM iterations.
  * Causes a moderation of the algorithm run.
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c6f6ac7..bc2f3ac 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -49,6 +49,7 @@
 #include <uapi/linux/netdev.h>
 #include <linux/hashtable.h>
 #include <linux/rbtree.h>
+#include <linux/dim.h>
 #include <net/net_trackers.h>
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
@@ -998,6 +999,27 @@ struct netdev_net_notifier {
 	struct notifier_block *nb;
 };
 
+enum dim_direction {
+	DIM_RX_DIRECTION = 0x0,
+	DIM_TX_DIRECTION = 0x1,
+	DIM_NUM_DIRECTIONS
+};
+/**
+ * struct dim_profs_list - Structure for dim sysfs configuration.
+ * Used to exchange profile list between the sysfs and the driver.
+ *
+ * @direction: RX or TX dim information
+ * @mode: CQ period count mode (from CQE/EQE)
+ * @num: the number of profs array
+ * @profs: dim profile list
+ */
+struct dim_profs_list {
+	u8 direction;
+	u8 mode;
+	u8 num;
+	struct dim_cq_moder profs[];
+};
+
 /*
  * This structure defines the management hooks for network devices.
  * The following hooks can be defined; unless noted otherwise, they are
@@ -1351,6 +1373,14 @@ struct netdev_net_notifier {
  *			   struct kernel_hwtstamp_config *kernel_config,
  *			   struct netlink_ext_ack *extack);
  *	Change the hardware timestamping parameters for NIC device.
+ *
+ * int (*ndo_dim_moder_get)(struct net_device *dev,
+ *			    struct dim_profs_list *list);
+ *	Get dim profiles list from the NIC device.
+ *
+ * int (*ndo_dim_moder_set)(struct net_device *dev,
+ *			    struct dim_profs_list *list);
+ *	Configure dim profiles list for the NIC device.
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1595,6 +1625,11 @@ struct net_device_ops {
 	int			(*ndo_hwtstamp_set)(struct net_device *dev,
 						    struct kernel_hwtstamp_config *kernel_config,
 						    struct netlink_ext_ack *extack);
+	int			(*ndo_dim_moder_get)(struct net_device *dev,
+						     struct dim_profs_list *list);
+
+	int			(*ndo_dim_moder_set)(struct net_device *dev,
+						     struct dim_profs_list *list);
 };
 
 /**
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index 4e32f7a..67d5beb 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -11,12 +11,6 @@
  *        There are different set of profiles for RX/TX CQs.
  *        Each profile size must be of NET_DIM_PARAMS_NUM_PROFILES
  */
-#define NET_DIM_PARAMS_NUM_PROFILES 5
-#define NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE 256
-#define NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE 128
-#define NET_DIM_DEF_PROFILE_CQE 1
-#define NET_DIM_DEF_PROFILE_EQE 1
-
 #define NET_DIM_RX_EQE_PROFILES { \
 	{.usec = 1,   .pkts = NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
 	{.usec = 8,   .pkts = NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index e3d7a8c..801cb07 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/cpu.h>
+#include <linux/dim.h>
 #include <net/netdev_rx_queue.h>
 #include <net/rps.h>
 
@@ -638,6 +639,176 @@ static ssize_t threaded_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(threaded);
 
+static struct dim_profs_list *parse_dim_profs(const char *buf, ssize_t len)
+{
+	int i, ret, size, totlen = 0, retlen = 0;
+	char direction[3], period_mode[4];
+	struct dim_profs_list *list;
+
+	size = sizeof(*list) + NET_DIM_PARAMS_NUM_PROFILES * sizeof(struct dim_cq_moder);
+	list = kzalloc(size, GFP_KERNEL);
+	if (!list)
+		goto err_list;
+
+	list->num = NET_DIM_PARAMS_NUM_PROFILES;
+
+	ret = sscanf(buf, "%2s %3s%n", direction, period_mode, &retlen);
+	if (ret != 2)
+		goto err_parse;
+
+	if (!strcasecmp(direction, "RX"))
+		list->direction = DIM_RX_DIRECTION;
+	else if (!strcasecmp(direction, "TX"))
+		list->direction = DIM_TX_DIRECTION;
+	else
+		goto err_parse;
+
+	if (!strcasecmp(period_mode, "EQE"))
+		list->mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+	else if (!strcasecmp(period_mode, "CQE"))
+		list->mode = DIM_CQ_PERIOD_MODE_START_FROM_CQE;
+	else
+		goto err_parse;
+
+	totlen += retlen;
+	if (totlen > len)
+		goto err_parse;
+
+	buf += retlen;
+	if (!buf)
+		goto err_parse;
+
+	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
+		ret = sscanf(buf, "%hu,%hu,%hu%n", &list->profs[i].usec,
+			     &list->profs[i].pkts, &list->profs[i].comps, &retlen);
+		if (ret != 3)
+			goto err_parse;
+
+		totlen += retlen;
+		if (totlen > len)
+			goto err_parse;
+
+		buf += retlen;
+		if (i == NET_DIM_PARAMS_NUM_PROFILES - 1)
+			break;
+	}
+
+	return list;
+
+err_parse:
+	kfree(list);
+err_list:
+	return NULL;
+}
+
+static ssize_t dim_profs_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t len)
+{
+	struct net_device *netdev = to_net_dev(dev);
+	const struct net_device_ops *ops = netdev->netdev_ops;
+	struct net *net = dev_net(netdev);
+	struct dim_profs_list *list;
+	int ret = 0;
+
+	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
+	list = parse_dim_profs(buf, len);
+	if (!list)
+		return -EINVAL;
+
+	if (!rtnl_trylock())
+		return restart_syscall();
+
+	if (dev_isalive(netdev)) {
+		if (!ops->ndo_dim_moder_set)
+			ret = -EINVAL;
+		else
+			ret = ops->ndo_dim_moder_set(netdev, list) ? : len;
+	}
+
+	kfree(list);
+	rtnl_unlock();
+
+	return ret;
+}
+
+static ssize_t dim_profs_show_one(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf, u8 direct, u8 mode,
+				  size_t *len_)
+{
+	static const char fmt_body[] = "{.usec = %3hu, .pkts = %3hu, .comps = %3hu,}%s";
+	static const char fmt_hdr[] = "The profiles of (%2s, %3s):\n";
+	const char *direction[2] = {"RX", "TX"}, *period_mode[2] = {"EQE", "CQE"};
+	struct net_device *netdev = to_net_dev(dev);
+	const struct net_device_ops *ops = netdev->netdev_ops;
+	struct dim_profs_list *list;
+	size_t size, len = *len_;
+	ssize_t i;
+
+	size = sizeof(*list) + NET_DIM_PARAMS_NUM_PROFILES * sizeof(struct dim_cq_moder);
+	list = kzalloc(size, GFP_KERNEL);
+	if (!list)
+		return -ENOMEM;
+
+	list->num = NET_DIM_PARAMS_NUM_PROFILES;
+	list->direction = direct;
+	list->mode = mode;
+	if (ops->ndo_dim_moder_get(netdev, list))
+		goto ret_;
+
+	len += scnprintf(buf + len, PAGE_SIZE - len,
+			 fmt_hdr, direction[direct], period_mode[mode]);
+	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
+		len += scnprintf(buf + len, PAGE_SIZE - len, fmt_body,
+				list->profs[i].usec, list->profs[i].pkts,
+				list->profs[i].comps,
+				(i == NET_DIM_PARAMS_NUM_PROFILES - 1) ? "\n" : ",\n");
+	}
+	*len_ = len;
+ret_:
+	kfree(list);
+	return 0;
+}
+
+static ssize_t dim_profs_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	static const char out[] = "profile is default and not customized by the device.";
+	struct net_device *netdev = to_net_dev(dev);
+	const struct net_device_ops *ops = netdev->netdev_ops;
+	ssize_t i, j, ret = 0;
+	size_t len = 0;
+
+	if (!rtnl_trylock())
+		return restart_syscall();
+
+	if (!ops->ndo_dim_moder_get) {
+		ret = sysfs_emit(buf, "%s\n", out);
+		goto ret_;
+	}
+
+	for (i = 0; i < DIM_NUM_DIRECTIONS; i++) {
+		for (j = 0; j < DIM_CQ_PERIOD_NUM_MODES; j++) {
+			ret = dim_profs_show_one(dev, attr, buf, i, j, &len);
+			if (ret)
+				goto ret_;
+		}
+	}
+
+	rtnl_unlock();
+	return len;
+
+ret_:
+	rtnl_unlock();
+	return ret;
+}
+
+static DEVICE_ATTR_RW(dim_profs);
+
 static struct attribute *net_class_attrs[] __ro_after_init = {
 	&dev_attr_netdev_group.attr,
 	&dev_attr_type.attr,
@@ -671,6 +842,7 @@ static ssize_t threaded_store(struct device *dev,
 	&dev_attr_carrier_up_count.attr,
 	&dev_attr_carrier_down_count.attr,
 	&dev_attr_threaded.attr,
+	&dev_attr_dim_profs.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(net_class);
-- 
1.8.3.1


