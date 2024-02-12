Return-Path: <linux-kernel+bounces-61582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CC08513E4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6731728145F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBF63A29E;
	Mon, 12 Feb 2024 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k9bx45/T"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7376F3A262;
	Mon, 12 Feb 2024 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742685; cv=none; b=kjFEOIDDE446yN75JMdM2LHixjJBa4M9wAuVgeQTN0BaDyV74KrDMWVc4wuMETJTwYoj+JjEMkHeuoEGcIkcT6ycOz0wCvw5Uy7xA2A0evs+ig4kehiVAr44Nogx3TnN7OW/RghlG+GWD8I7B4iCN41gW9yxqvauLTfVHPNHs9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742685; c=relaxed/simple;
	bh=Q6ISYfSKMe0JRvETZ/CD9+AQxsVIiWIjENVVuC0PpvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ba79MyMkFoGwvusebg/zDvtCTVkcx6RMoNXTMzdwtKkyhriQJ8RsHuBeigx1nLXk/rIc34NzgNrxp7lm6UkmSVBY8sDzsAk6b+cXqHHYBQbmcUPqpY3vUkgTlt0nyosrNX4zYj/FKCAuni2M7L1ToHCSJMIFG0c7205dyfsEZKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k9bx45/T; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1823BFF806;
	Mon, 12 Feb 2024 12:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707742680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oHSB4EWfMf4xbLc27oNsm2iYLKxUgQDGZiBycNxHBzw=;
	b=k9bx45/TM+03a5Y0cTOwzNo9Sk0AAozCjelhRPVmIXOyZNJbR5bzO4E36gORC/3ZMHgu2n
	JZ3TAPqcE0nL9ep6RvKzYuW2O6AWBx9oDp9o3pr0kvgviZEAbT9CH4DjKwTP6IZxKvVt7W
	gjqc5RWhbFTCBl8zOrfWlpAae/W9parP67lEDzqR7lz+OaVlhwbpFpFnrjKFL8OAsGaksq
	yAS5QRApqlWVxeBEFUQd4e4kRCttcSmKkQbPhPtNzs34j1ljCDfJz/ivJoUHftmp6uU6/V
	CoXE57b5qvdpe0br4UGlxkTDLA7vZvbxxOqYneSBjS4EJJFkWMKsqUetvINt0g==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Mon, 12 Feb 2024 13:57:37 +0100
Subject: [PATCH] wifi: wilc1000: prevent use-after-free on vif when
 cleaning up all interfaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240212-wilc_rework_deinit-v1-1-9203ae56c27f@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAMAVymUC/x3M0QpAMBSA4VfRubaaocWrSIvt4ESjM6GWd7dcf
 hf/HyEgEwZoswiMFwXafUKRZ2CXwc8oyCWDkqqSSjbips0axnvn1TgkT6cobV1W2k3NWGhI4cE
 40fNPu/59P1tVoLhkAAAA
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 David Mosberger-Tang <davidm@egauge.net>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: alexis.lothore@bootlin.com

wilc_netdev_cleanup currently triggers a KASAN warning, which can be
observed on interface registration error path, or simply by
removing the module/unbinding device from driver:

echo spi0.1 > /sys/bus/spi/drivers/wilc1000_spi/unbind

==================================================================
BUG: KASAN: slab-use-after-free in wilc_netdev_cleanup+0x508/0x5cc
Read of size 4 at addr c54d1ce8 by task sh/86

CPU: 0 PID: 86 Comm: sh Not tainted 6.8.0-rc1+ #117
Hardware name: Atmel SAMA5
 unwind_backtrace from show_stack+0x18/0x1c
 show_stack from dump_stack_lvl+0x34/0x58
 dump_stack_lvl from print_report+0x154/0x500
 print_report from kasan_report+0xac/0xd8
 kasan_report from wilc_netdev_cleanup+0x508/0x5cc
 wilc_netdev_cleanup from wilc_bus_remove+0xc8/0xec
 wilc_bus_remove from spi_remove+0x8c/0xac
 spi_remove from device_release_driver_internal+0x434/0x5f8
 device_release_driver_internal from unbind_store+0xbc/0x108
 unbind_store from kernfs_fop_write_iter+0x398/0x584
 kernfs_fop_write_iter from vfs_write+0x728/0xf88
 vfs_write from ksys_write+0x110/0x1e4
 ksys_write from ret_fast_syscall+0x0/0x1c

[...]

Allocated by task 1:
 kasan_save_track+0x30/0x5c
 __kasan_kmalloc+0x8c/0x94
 __kmalloc_node+0x1cc/0x3e4
 kvmalloc_node+0x48/0x180
 alloc_netdev_mqs+0x68/0x11dc
 alloc_etherdev_mqs+0x28/0x34
 wilc_netdev_ifc_init+0x34/0x8ec
 wilc_cfg80211_init+0x690/0x910
 wilc_bus_probe+0xe0/0x4a0
 spi_probe+0x158/0x1b0
 really_probe+0x270/0xdf4
 __driver_probe_device+0x1dc/0x580
 driver_probe_device+0x60/0x140
 __driver_attach+0x228/0x5d4
 bus_for_each_dev+0x13c/0x1a8
 bus_add_driver+0x2a0/0x608
 driver_register+0x24c/0x578
 do_one_initcall+0x180/0x310
 kernel_init_freeable+0x424/0x484
 kernel_init+0x20/0x148
 ret_from_fork+0x14/0x28

Freed by task 86:
 kasan_save_track+0x30/0x5c
 kasan_save_free_info+0x38/0x58
 __kasan_slab_free+0xe4/0x140
 kfree+0xb0/0x238
 device_release+0xc0/0x2a8
 kobject_put+0x1d4/0x46c
 netdev_run_todo+0x8fc/0x11d0
 wilc_netdev_cleanup+0x1e4/0x5cc
 wilc_bus_remove+0xc8/0xec
 spi_remove+0x8c/0xac
 device_release_driver_internal+0x434/0x5f8
 unbind_store+0xbc/0x108
 kernfs_fop_write_iter+0x398/0x584
 vfs_write+0x728/0xf88
 ksys_write+0x110/0x1e4
 ret_fast_syscall+0x0/0x1c
 [...]

David Mosberger-Tan initial investigation [1] showed that this
use-after-free is due to netdevice unregistration during vif list
traversal. When unregistering a net device, since the needs_free_netdev has
been set to true during registration, the netdevice object is also freed,
and as a consequence, the corresponding vif object too, since it is
attached to it as private netdevice data. The next occurrence of the loop
then tries to access freed vif pointer to the list to move forward in the
list.

Fix this use-after-free thanks to two mechanisms:
- navigate in the list with list_for_each_entry_safe, which allows to
  safely modify the list as we go through each element. For each element,
  remove it from the list with list_del_rcu
- make sure to wait for RCU grace period end after each vif removal to make
  sure it is safe to free the corresponding vif too (through
  unregister_netdev)

Since we are in a RCU "modifier" path (not a "reader" path), and because
such path is expected not to be concurrent to any other modifier (we are
using the vif_mutex lock), we do not need to use RCU list API, that's why
we can benefit from list_for_each_entry_safe.

[1] https://lore.kernel.org/linux-wireless/ab077dbe58b1ea5de0a3b2ca21f275a07af967d2.camel@egauge.net/

Fixes: 8399918f3056 ("staging: wilc1000: use RCU list to maintain vif interfaces list")
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 28 ++++++------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index ef22bf6bf86a..8bae0f2485be 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -890,8 +890,7 @@ static const struct net_device_ops wilc_netdev_ops = {
 
 void wilc_netdev_cleanup(struct wilc *wilc)
 {
-	struct wilc_vif *vif;
-	int srcu_idx, ifc_cnt = 0;
+	struct wilc_vif *vif, *vif_tmp;
 
 	if (!wilc)
 		return;
@@ -901,32 +900,19 @@ void wilc_netdev_cleanup(struct wilc *wilc)
 		wilc->firmware = NULL;
 	}
 
-	srcu_idx = srcu_read_lock(&wilc->srcu);
-	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
+	list_for_each_entry_safe(vif, vif_tmp, &wilc->vif_list, list) {
+		mutex_lock(&wilc->vif_mutex);
+		list_del_rcu(&vif->list);
+		wilc->vif_num--;
+		mutex_unlock(&wilc->vif_mutex);
+		synchronize_srcu(&wilc->srcu);
 		if (vif->ndev)
 			unregister_netdev(vif->ndev);
 	}
-	srcu_read_unlock(&wilc->srcu, srcu_idx);
 
 	wilc_wfi_deinit_mon_interface(wilc, false);
 	destroy_workqueue(wilc->hif_workqueue);
 
-	while (ifc_cnt < WILC_NUM_CONCURRENT_IFC) {
-		mutex_lock(&wilc->vif_mutex);
-		if (wilc->vif_num <= 0) {
-			mutex_unlock(&wilc->vif_mutex);
-			break;
-		}
-		vif = wilc_get_wl_to_vif(wilc);
-		if (!IS_ERR(vif))
-			list_del_rcu(&vif->list);
-
-		wilc->vif_num--;
-		mutex_unlock(&wilc->vif_mutex);
-		synchronize_srcu(&wilc->srcu);
-		ifc_cnt++;
-	}
-
 	wilc_wlan_cfg_deinit(wilc);
 	wlan_deinit_locks(wilc);
 	wiphy_unregister(wilc->wiphy);

---
base-commit: d55b20fe9b6f0ec5552a3071ae63304978d70500
change-id: 20240209-wilc_rework_deinit-3c5347df9b17

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


