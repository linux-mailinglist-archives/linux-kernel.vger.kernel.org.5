Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D91D7FA9FF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjK0TOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjK0TO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:14:26 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68899D60;
        Mon, 27 Nov 2023 11:14:32 -0800 (PST)
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        by mail11.truemail.it (Postfix) with ESMTPA id 6325D2075E;
        Mon, 27 Nov 2023 20:14:30 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH v1 1/3] Bluetooth: btnxpuart: fix recv_buf() return value
Date:   Mon, 27 Nov 2023 20:14:06 +0100
Message-Id: <20231127191409.151254-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127191409.151254-1-francesco@dolcini.it>
References: <20231127191409.151254-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Serdev recv_buf() callback is supposed to return the amount of bytes
consumed, therefore an int in between 0 and count.

Do not return negative number in case of issue, just print an error and
return count.  This fixes a WARN in ttyport_receive_buf().

[    9.962266] Bluetooth: hci0: Frame reassembly failed (-84)
[    9.972939] ------------[ cut here ]------------
[    9.977922] serial serial0: receive_buf returns -84 (count = 6)
[    9.994857] WARNING: CPU: 0 PID: 37 at drivers/tty/serdev/serdev-ttyport.c:37 ttyport_receive_buf+0xd8/0xf8
[   10.004840] Modules linked in: mwifiex_sdio(+) mwifiex snd_soc_simple_card crct10dif_ce cfg80211 snd_soc_simple_card_utils k3_j72xx_bandgap rti_wdt rtc_ti_k3 btnxpuart bluetooth sa2ul ecdh_generic ecc sha256_generic tidss rfkill libsha256 drm_dma_helper snd_soc_davinci_mcasp authenc omap_mailbox snd_soc_ti_udma snd_soc_ti_edma snd_soc_ti_sdma atmel_mxt_ts ina2xx snd_soc_nau8822 ti_sn65dsi83 tc358768 ti_ads1015 tps65219_pwrbutton at24 m_can_platform industrialio_triggered_buffer drm_kms_helper m_can kfifo_buf rtc_ds1307 lm75 pwm_tiehrpwm can_dev spi_omap2_mcspi panel_lvds pwm_bl libcomposite fuse drm backlight ipv6
[   10.059984] CPU: 0 PID: 37 Comm: kworker/u4:2 Not tainted 6.7.0-rc2-00147-gf1a09972a45a #1
[   10.071793] Hardware name: Toradex Verdin AM62 WB on Verdin Development Board (DT)
[   10.082898] Workqueue: events_unbound flush_to_ldisc
[   10.091345] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   10.101820] pc : ttyport_receive_buf+0xd8/0xf8
[   10.109712] lr : ttyport_receive_buf+0xd8/0xf8
[   10.117581] sp : ffff800082b9bd20
[   10.124202] x29: ffff800082b9bd20 x28: ffff00000000ee05 x27: ffff0000002f21c0
[   10.134735] x26: ffff000002931820 x25: 61c8864680b583eb x24: ffff0000002f21b8
[   10.145209] x23: ffff00000026e740 x22: ffff0000002f21e0 x21: ffffffffffffffac
[   10.155686] x20: ffff000000da5c00 x19: 0000000000000006 x18: 0000000000000000
[   10.166178] x17: ffff7fffbe0e7000 x16: ffff800080000000 x15: 000039966db1c650
[   10.176564] x14: 000000000000022c x13: 000000000000022c x12: 0000000000000000
[   10.186979] x11: 000000000000000a x10: 0000000000000a60 x9 : ffff800082b9bb80
[   10.197352] x8 : ffff00000026f200 x7 : ffff00003fd90080 x6 : 00000000000022e5
[   10.207680] x5 : 00000000410fd030 x4 : 0000000000c0000e x3 : ffff7fffbe0e7000
[   10.218051] x2 : 0000000000000002 x1 : 0000000000000000 x0 : 0000000000000000
[   10.228393] Call trace:
[   10.233989]  ttyport_receive_buf+0xd8/0xf8
[   10.241224]  flush_to_ldisc+0xbc/0x1a4
[   10.248117]  process_scheduled_works+0x16c/0x28c
[   10.255851]  worker_thread+0x16c/0x2e0
[   10.262673]  kthread+0x11c/0x128
[   10.268953]  ret_from_fork+0x10/0x20
[   10.275460] ---[ end trace 0000000000000000 ]---

Closes: https://lore.kernel.org/all/ZWEIhcUXfutb5SY6@francesco-nb.int.toradex.com/
Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/bluetooth/btnxpuart.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index b7e66b7ac570..951fe3014a3f 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1276,11 +1276,10 @@ static int btnxpuart_receive_buf(struct serdev_device *serdev, const u8 *data,
 	if (IS_ERR(nxpdev->rx_skb)) {
 		int err = PTR_ERR(nxpdev->rx_skb);
 		/* Safe to ignore out-of-sync bootloader signatures */
-		if (is_fw_downloading(nxpdev))
-			return count;
-		bt_dev_err(nxpdev->hdev, "Frame reassembly failed (%d)", err);
+		if (!is_fw_downloading(nxpdev))
+			bt_dev_err(nxpdev->hdev, "Frame reassembly failed (%d)", err);
 		nxpdev->rx_skb = NULL;
-		return err;
+		return count;
 	}
 	if (!is_fw_downloading(nxpdev))
 		nxpdev->hdev->stat.byte_rx += count;
-- 
2.25.1

