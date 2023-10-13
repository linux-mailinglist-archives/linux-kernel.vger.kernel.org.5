Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBD17C802F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjJMI1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjJMI0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:26:50 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C82CC;
        Fri, 13 Oct 2023 01:26:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39874C0009;
        Fri, 13 Oct 2023 08:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697185604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XnBwm2IvHLuWvz5q9qZS2KbVkC5/vLI/x4BmkQloMCc=;
        b=Jbac0TbSHmC1eG0PRUzvqNqBaaDAi5BFU9DGBKUJ8IgHy1uCpuwsw/gCUWXy09q8wD++Ia
        CXQQ7HmMcPFz0r3tI0dVmq1hzK4RBu4vrBxA+/Du+xvkT31ho+hc/3fZf2l72m2/dBdqrQ
        LTIoUNtSNIIc6w63UndezFo5wWZP+rSDuBgNdc48+gxWbb2SRsOykmo8DEtjw/wqnw9p2g
        7zv6fpXjvsXi3OAnJBjz36k5SS5D/9XRxtJttm8nQ4m9ic0RQCK3JznDR2I04ofAWg6S/Y
        v6eSbxQADPlBqDf80TMZtpqLbZgJ9O21lRzJyawXx2o00SdMQ0A63Ur74ZAvwg==
From:   =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date:   Fri, 13 Oct 2023 10:26:52 +0200
Subject: [PATCH] wifi: wilc1000: use vmm_table as array in wilc struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231013-wilc1000_tx_oops-v1-1-3761beb9524d@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAEv/KGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA0Mj3fLMnGRDAwOD+JKK+Pz8gmJdU4vkVEvD1FTjVEtjJaC2gqLUtMw
 KsJHRsbW1AKu7TRBiAAAA
To:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Kalle Valo <kvalo@kernel.org>,
        Michael Walle <mwalle@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ajay Singh <ajay.kathat@microchip.com>, stable@vger.kernel.org,
        =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: alexis.lothore@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Enabling KASAN and running some iperf tests raises some memory issues with
vmm_table:

BUG: KASAN: slab-out-of-bounds in wilc_wlan_handle_txq+0x6ac/0xdb4
Write of size 4 at addr c3a61540 by task wlan0-tx/95

KASAN detects that we are writing data beyond range allocated to vmm_table.
There is indeed a mismatch between the size passed to allocator in
wilc_wlan_init, and the range of possible indexes used later: allocation
size is missing a multiplication by sizeof(u32)

While at it, instead of simply multiplying the allocation size, do not keep
dedicated dynamic allocation for vmm_table: define it as an array with the
relevant size in wilc struct, which is already dynamically allocated

Fixes: 40b717bfcefa ("wifi: wilc1000: fix DMA on stack objects")
Cc: stable@vger.kernel.org
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.h |  2 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c   | 12 ------------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net/wireless/microchip/wilc1000/netdev.h
index bb1a315a7b7e..2137ef294953 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -245,7 +245,7 @@ struct wilc {
 	u8 *rx_buffer;
 	u32 rx_buffer_offset;
 	u8 *tx_buffer;
-	u32 *vmm_table;
+	u32 vmm_table[WILC_VMM_TBL_SIZE];
 
 	struct txq_handle txq[NQUEUES];
 	int txq_entries;
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 58bbf50081e4..d93493c40e49 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1252,8 +1252,6 @@ void wilc_wlan_cleanup(struct net_device *dev)
 	while ((rqe = wilc_wlan_rxq_remove(wilc)))
 		kfree(rqe);
 
-	kfree(wilc->vmm_table);
-	wilc->vmm_table = NULL;
 	kfree(wilc->rx_buffer);
 	wilc->rx_buffer = NULL;
 	kfree(wilc->tx_buffer);
@@ -1491,14 +1489,6 @@ int wilc_wlan_init(struct net_device *dev)
 			goto fail;
 	}
 
-	if (!wilc->vmm_table)
-		wilc->vmm_table = kzalloc(WILC_VMM_TBL_SIZE, GFP_KERNEL);
-
-	if (!wilc->vmm_table) {
-		ret = -ENOBUFS;
-		goto fail;
-	}
-
 	if (!wilc->tx_buffer)
 		wilc->tx_buffer = kmalloc(WILC_TX_BUFF_SIZE, GFP_KERNEL);
 
@@ -1523,8 +1513,6 @@ int wilc_wlan_init(struct net_device *dev)
 	return 0;
 
 fail:
-	kfree(wilc->vmm_table);
-	wilc->vmm_table = NULL;
 	kfree(wilc->rx_buffer);
 	wilc->rx_buffer = NULL;
 	kfree(wilc->tx_buffer);

---
base-commit: f28d2198de8cbefa17286d5182337a1d6d518643
change-id: 20231012-wilc1000_tx_oops-58ce91ee3e93

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

