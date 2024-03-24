Return-Path: <linux-kernel+bounces-114799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFF188914E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6311F2C4E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7ED255C86;
	Mon, 25 Mar 2024 00:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7SaWn+7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D77A175C9E;
	Sun, 24 Mar 2024 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323403; cv=none; b=bgl15a/GfvwJPteJBAPnH5XKD9CYFSTJh5UUy1OoqQgoPM3xgigi3bfP4VvIVMew2EgR/AYky8LQ/xm6OtiYNyr+8j7Ug1SoGNBCd1WywUGOolcac/CaJK2JB9uaPQvfWZZnj6ircgl4Yp3x9Zx9528cIZsH74zGLo5Mo4gjnaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323403; c=relaxed/simple;
	bh=ywF7kYPrkCdFZ+QMKv18F5u11BtEIpfftiuZyKqS0Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWx/wcrBJLH+cHGI0E6L2B6yobKQTklvgxu9Redr86DarAtCmHzkG7IzT6ngouAJ1HXK8hp7P+pH1pVnKZNnXTZUuCrQ+MO/JGw1raQdhc6+jD3ZnTfqtP54xdEufX4TsR46AC6QvbeWsrKR1CTAZTqYdulpTM32Jsxoy00A/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7SaWn+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD04DC43399;
	Sun, 24 Mar 2024 23:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323402;
	bh=ywF7kYPrkCdFZ+QMKv18F5u11BtEIpfftiuZyKqS0Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7SaWn+7aCpvWzX3oTH0fAOA/fn3QDMlPGGSOkqokhTtM/p/xeB5kjqKD9ObOLuCR
	 CYSQ/0BZFnXntYyjIrfxXJnsx7B+B4CqItfCP+tn5nk/SbHPTiO5/Fkc1SddD6SEC3
	 r1XM0Gt00EFDM6L7sF4NgyeD/8AeWFFVu+xg/3x62aXkWi+8MOvc+RQ+G75TcL8R2s
	 bgZZazB5/X+hkruW0P4Gc7rMmkbFzLca4FY9RwAvnk2w9H610RIsqd+LCaiYjOFt7f
	 qJ5QjZxNOpO69F5N0l9NQwgl5TRvoNytu/LxI9QcnRtuJG9k5DHhhqRSblMcUxUESn
	 Vcqb5pN3oeeMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 103/317] wifi: wilc1000: prevent use-after-free on vif when cleaning up all interfaces
Date: Sun, 24 Mar 2024 19:31:23 -0400
Message-ID: <20240324233458.1352854-104-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Alexis Lothoré <alexis.lothore@bootlin.com>

[ Upstream commit cb5942b77c05d54310a0420cac12935e9b6aa21c ]

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
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240212-wilc_rework_deinit-v1-1-9203ae56c27f@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/microchip/wilc1000/netdev.c  | 28 +++++--------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index dc91739eff8c6..0cf9e123d8c7d 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -862,8 +862,7 @@ static const struct net_device_ops wilc_netdev_ops = {
 
 void wilc_netdev_cleanup(struct wilc *wilc)
 {
-	struct wilc_vif *vif;
-	int srcu_idx, ifc_cnt = 0;
+	struct wilc_vif *vif, *vif_tmp;
 
 	if (!wilc)
 		return;
@@ -873,32 +872,19 @@ void wilc_netdev_cleanup(struct wilc *wilc)
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
-- 
2.43.0


