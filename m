Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C997EDF36
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345155AbjKPLKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345095AbjKPLJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:09:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBB6D5E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:09:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB33BC433C9;
        Thu, 16 Nov 2023 11:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700132986;
        bh=raNlC7mrg2U1+Ov9wD9k3ulfQ5++HiMipSCqEUSd0ps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H7msaxSJtY7XzfGBAnzqpYomoYWyfJtUrleurQwz6tUaxdw8lTJE1j5Y9U8h/lifh
         1idk7gqSwGmAMvolZlv/8LM2XIGgQEjcGVJno+zPdhkIuQiAv0++/u5B+fjm19SQDa
         z/XvVDW/viuMsKSmyq5qtzrSWoxLBbDvrRVogEAHCw0oMjyCGal64HTD14TEA4xPqJ
         /tS8lNO3p3TxWchxd60yiTs/qJhavMBk2V8qtcRMG+bjOFqko2cBNAFbe0M2OB8rhV
         kwy8+tGGcPHdGVPtkPGPcJlVMIT5XJGWQ7tnSdykn061bgUY+ZIqtbMDD+eAz9qGYu
         TJP01TTVz73RA==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     vladimir.oltean@nxp.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net 2/2] net: ti: am65-cpsw-nuss: Fix NULL pointer dereference at module removal
Date:   Thu, 16 Nov 2023 13:09:30 +0200
Message-Id: <20231116110930.36244-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116110930.36244-1-rogerq@kernel.org>
References: <20231116110930.36244-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NULL pointer derefernce error seems to come from the
list_for_each_entry_safe() helper in free_netdev(). It looks like
the napi pointers are stale contents but I coudn't figure out why.

An easy fix is to not use the devm variant of alloc_etherdev_mqs()
and call free_netdev() ourselves at .remove().

Gets rid of below NULL pointer dereference at module removal.

[   19.954962] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[   19.963798] Mem abort info:
[   19.966582]   ESR = 0x0000000096000006
[   19.970343]   EC = 0x25: DABT (current EL), IL = 32 bits
[   19.975660]   SET = 0, FnV = 0
[   19.978709]   EA = 0, S1PTW = 0
[   19.981850]   FSC = 0x06: level 2 translation fault
[   19.986726] Data abort info:
[   19.989606]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[   19.995116]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   20.000174]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   20.005486] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000083f69000
[   20.011925] [0000000000000000] pgd=08000000855b8003, p4d=08000000855b8003, pud=08000000855b9003, pmd=0000000000000000
[   20.022538] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
[   20.028792] Modules linked in: overlay xhci_plat_hcd cfg80211 rfkill dwc3 snd_soc_hdmi_codec snd_soc_simple_card crct10dif_ce snd_soc_simple_card_utils rtc_ti_k3 dwc3_am62 k3_j72xx_bandgap rti_wdt tidss ti_am65_cpsw_nuss(-) snd_soc_d6
[   20.072087] CPU: 2 PID: 675 Comm: modprobe Not tainted 6.6.0-15864-g2888b90a5073 #540
[   20.079902] Hardware name: Texas Instruments AM625 SK (DT)
[   20.085375] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   20.092323] pc : free_netdev+0xac/0x190
[   20.096162] lr : free_netdev+0xa4/0x190
[   20.099988] sp : ffff8000827c3bd0
[   20.103291] x29: ffff8000827c3bd0 x28: ffff0000044263c0 x27: 0000000000000000
[   20.110417] x26: 0000000000000000 x25: 0000000000000000 x24: ffff000000dbdab8
[   20.117542] x23: ffff000000dbdac0 x22: ffff000000dbd810 x21: ffff000003dfb050
[   20.124667] x20: ffff000003dfb000 x19: fffffffffffffe98 x18: 0000000000000000
[   20.131791] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   20.138916] x14: 000000000000027d x13: 0000000000000000 x12: 0000000000000001
[   20.146040] x11: 0000000000000000 x10: 00000000000009b0 x9 : ffff8000827c3910
[   20.153165] x8 : ffff000004426dd0 x7 : ffff000003c9c880 x6 : ffff000003c9c800
[   20.160290] x5 : 00000000410fd030 x4 : 0000000000000000 x3 : 0000000000000001
[   20.167415] x2 : 0000000000000000 x1 : 0000000000000000 x0 : fffffffffffffe98
[   20.174540] Call trace:
[   20.176978]  free_netdev+0xac/0x190
[   20.180459]  devm_free_netdev+0x14/0x20
[   20.184291]  release_nodes+0x3c/0x68
[   20.187863]  devres_release_all+0x8c/0xdc
[   20.191868]  device_unbind_cleanup+0x18/0x68
[   20.196128]  device_release_driver_internal+0xf8/0x178
[   20.201255]  driver_detach+0x50/0x9c
[   20.204822]  bus_remove_driver+0x6c/0xbc
[   20.208735]  driver_unregister+0x30/0x60
[   20.212650]  platform_driver_unregister+0x14/0x20
[   20.217344]  am65_cpsw_nuss_driver_exit+0x18/0xcc4 [ti_am65_cpsw_nuss]
[   20.223887]  __arm64_sys_delete_module+0x17c/0x25c
[   20.228673]  invoke_syscall+0x44/0x104
[   20.232419]  el0_svc_common.constprop.0+0xc0/0xe0
[   20.237114]  do_el0_svc+0x1c/0x28
[   20.240423]  el0_svc+0x34/0xb8
[   20.243474]  el0t_64_sync_handler+0xc0/0xc4
[   20.247649]  el0t_64_sync+0x190/0x194
[   20.251309] Code: 97fffdee 97fffaf9 9105a261 aa1303e0 (f940b673)
[   20.257390] ---[ end trace 0000000000000000 ]---

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index cbbede094b2c..830c0c1825d9 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2149,10 +2149,9 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 		return 0;
 
 	/* alloc netdev */
-	port->ndev = devm_alloc_etherdev_mqs(common->dev,
-					     sizeof(struct am65_cpsw_ndev_priv),
-					     AM65_CPSW_MAX_TX_QUEUES,
-					     AM65_CPSW_MAX_RX_QUEUES);
+	port->ndev = alloc_etherdev_mqs(sizeof(struct am65_cpsw_ndev_priv),
+					AM65_CPSW_MAX_TX_QUEUES,
+					AM65_CPSW_MAX_RX_QUEUES);
 	if (!port->ndev) {
 		dev_err(dev, "error allocating slave net_device %u\n",
 			port->port_id);
@@ -2266,6 +2265,8 @@ static void am65_cpsw_nuss_cleanup_ndev(struct am65_cpsw_common *common)
 		port = &common->ports[i];
 		if (port->ndev && port->ndev->reg_state == NETREG_REGISTERED)
 			unregister_netdev(port->ndev);
+
+		free_netdev(port->ndev);
 	}
 }
 
-- 
2.34.1

