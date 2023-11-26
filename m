Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE57F9504
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 20:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjKZTS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 14:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjKZTSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 14:18:49 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A1DF5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 11:18:53 -0800 (PST)
Received: from p200301077700a9001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:a900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1r7KeT-006khQ-0v; Sun, 26 Nov 2023 20:18:45 +0100
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1r7KeS-000Slj-2U;
        Sun, 26 Nov 2023 20:18:44 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        johan@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        andreas@kemnade.info, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
        Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@gmail.com>,
        robh@kernel.org
Subject: [RFC PATCH 2/3] bluetooth: ti-st: add GNSS support for TI Wilink chips
Date:   Sun, 26 Nov 2023 20:18:39 +0100
Message-Id: <20231126191840.110564-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231126191840.110564-1-andreas@kemnade.info>
References: <20231126191840.110564-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of these chips have GNSS support. GNSS support
is available through channel 9 whilst FM is through channel 8.
Add support for it.
A driver providing a /dev/tigps device is found in some vendor-kernels. The
GNSS device provided by this patch seems to be compatible.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/bluetooth/hci_ll.c | 154 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 4a0b5c3160c2b..718dab0f529a7 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -39,6 +39,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <linux/gnss.h>
 #include <linux/gpio/consumer.h>
 #include <linux/nvmem-consumer.h>
 
@@ -68,6 +69,10 @@ struct ll_device {
 	struct gpio_desc *enable_gpio;
 	struct clk *ext_clk;
 	bdaddr_t bdaddr;
+
+	struct mutex gdev_mutex;
+	bool gdev_open;
+	struct gnss_device *gdev;
 };
 
 struct ll_struct {
@@ -78,6 +83,20 @@ struct ll_struct {
 	struct sk_buff_head tx_wait_q;	/* HCILL wait queue	*/
 };
 
+/* Channel-9 details for GPS */
+#define GPS_CH9_PKT_HDR_SIZE		4
+#define GPS_CH9_PKT_NUMBER		0x9
+#define GPS_CH9_OP_WRITE		0x1
+#define GPS_CH9_OP_READ			0x2
+#define GPS_CH9_OP_COMPLETED_EVT	0x3
+
+struct gnssdrv_event_hdr {
+	uint8_t opcode;
+	uint16_t plen;
+} __packed;
+
+
+static int gnss_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
 /*
  * Builds and sends an HCILL command packet.
  * These are very simple packets with only 1 cmd byte
@@ -411,6 +430,13 @@ static int ll_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	.lsize = 0, \
 	.maxlen = 0
 
+#define LL_RECV_GNSS \
+	.type = GPS_CH9_PKT_NUMBER, \
+	.hlen = 3, \
+	.loff = 1, \
+	.lsize = 2 \
+
+
 static const struct h4_recv_pkt ll_recv_pkts[] = {
 	{ H4_RECV_ACL,       .recv = hci_recv_frame },
 	{ H4_RECV_SCO,       .recv = hci_recv_frame },
@@ -419,6 +445,7 @@ static const struct h4_recv_pkt ll_recv_pkts[] = {
 	{ LL_RECV_SLEEP_ACK, .recv = ll_recv_frame  },
 	{ LL_RECV_WAKE_IND,  .recv = ll_recv_frame  },
 	{ LL_RECV_WAKE_ACK,  .recv = ll_recv_frame  },
+	{ LL_RECV_GNSS,      .recv = gnss_recv_frame },
 };
 
 /* Recv data */
@@ -682,12 +709,124 @@ static int ll_setup(struct hci_uart *hu)
 
 static const struct hci_uart_proto llp;
 
+static int gnss_lldev_open(struct gnss_device *gdev)
+{
+	struct ll_device *lldev = gnss_get_drvdata(gdev);
+
+	mutex_lock(&lldev->gdev_mutex);
+	lldev->gdev_open = true;
+	mutex_unlock(&lldev->gdev_mutex);
+
+	return 0;
+}
+
+static void gnss_lldev_close(struct gnss_device *gdev)
+{
+	struct ll_device *lldev = gnss_get_drvdata(gdev);
+
+	mutex_lock(&lldev->gdev_mutex);
+	lldev->gdev_open = false;
+	mutex_unlock(&lldev->gdev_mutex);
+}
+
+static int gnss_lldev_write_raw(struct gnss_device *gdev,
+		const unsigned char *buf, size_t count)
+{
+	struct ll_device *lldev = gnss_get_drvdata(gdev);
+	int err = 0;
+	struct sk_buff *skb = NULL;
+	struct gnssdrv_event_hdr gnssdrv_hdr = { GPS_CH9_OP_WRITE, 0x0000 };
+
+	/* allocate packet */
+	skb = bt_skb_alloc(sizeof(gnssdrv_hdr) + count, GFP_ATOMIC);
+	if (!skb) {
+		BT_ERR("cannot allocate memory for HCILL packet");
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* GPS channel */
+
+	gnssdrv_hdr.plen = count;
+	hci_skb_pkt_type(skb) = GPS_CH9_PKT_NUMBER;
+	skb_put_data(skb, &gnssdrv_hdr, sizeof(gnssdrv_hdr));
+	skb_put_data(skb, buf, count);
+
+	lldev->hu.hdev->send(lldev->hu.hdev, skb);
+
+	/* TODO: wait on completion? */
+	return count;
+out:
+	return err;
+}
+
+static const struct gnss_operations gnss_lldev_ops = {
+	.open		= gnss_lldev_open,
+	.close		= gnss_lldev_close,
+	.write_raw	= gnss_lldev_write_raw,
+};
+
+static int gnss_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct ll_device *lldev = container_of(hu, struct ll_device, hu);
+
+	if (!IS_ENABLED(CONFIG_GNSS))
+		return 0;
+
+	if (!lldev->gdev)
+		return 0;
+
+	if (hci_skb_pkt_type(skb) == GPS_CH9_PKT_NUMBER) {
+		struct gnssdrv_event_hdr *gnss_hdr =
+			(struct gnssdrv_event_hdr *)skb->data;
+		void *data = skb_pull(skb, sizeof(*gnss_hdr));
+		/*
+		 * REVISIT: maybe do something with the completed
+		 * event
+		 */
+		if (gnss_hdr->opcode ==	GPS_CH9_OP_READ) {
+			mutex_lock(&lldev->gdev_mutex);
+			if (lldev->gdev_open)
+				gnss_insert_raw(lldev->gdev, data, skb->len);
+			mutex_unlock(&lldev->gdev_mutex);
+		}
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
+static int ll_gnss_register(struct ll_device *lldev)
+{
+	struct gnss_device *gdev;
+	int ret;
+
+	gdev = gnss_allocate_device(&lldev->serdev->dev);
+	if (!gdev)
+		return -ENOMEM;
+
+	gdev->ops = &gnss_lldev_ops;
+	gdev->type = GNSS_TYPE_AI2;
+	gnss_set_drvdata(gdev, lldev);
+	mutex_init(&lldev->gdev_mutex);
+
+	ret = gnss_register_device(gdev);
+	if (ret == 0) {
+		lldev->gdev = gdev;
+		return 0;
+	}
+	gnss_put_device(gdev);
+	return ret;
+}
+
 static int hci_ti_probe(struct serdev_device *serdev)
 {
 	struct hci_uart *hu;
 	struct ll_device *lldev;
 	struct nvmem_cell *bdaddr_cell;
 	u32 max_speed = 3000000;
+	int ret;
 
 	lldev = devm_kzalloc(&serdev->dev, sizeof(struct ll_device), GFP_KERNEL);
 	if (!lldev)
@@ -756,14 +895,27 @@ static int hci_ti_probe(struct serdev_device *serdev)
 		kfree(bdaddr);
 	}
 
-	return hci_uart_register_device(hu, &llp);
+	ret = hci_uart_register_device(hu, &llp);
+	if (ret)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_GNSS) &&
+	    strstr(of_node_full_name(serdev->dev.of_node), "gnss"))
+		ll_gnss_register(lldev);
+
+	return 0;
 }
 
+
 static void hci_ti_remove(struct serdev_device *serdev)
 {
 	struct ll_device *lldev = serdev_device_get_drvdata(serdev);
 
 	hci_uart_unregister_device(&lldev->hu);
+	if (IS_ENABLED(CONFIG_GNSS) && lldev->gdev) {
+		gnss_deregister_device(lldev->gdev);
+		gnss_put_device(lldev->gdev);
+	}
 }
 
 static const struct of_device_id hci_ti_of_match[] = {
-- 
2.39.2

