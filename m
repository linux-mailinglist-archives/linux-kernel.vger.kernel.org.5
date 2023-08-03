Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A96B76E0BD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjHCHDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjHCHC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:02:26 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A85E93AA3;
        Thu,  3 Aug 2023 00:02:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 54906608EE266;
        Thu,  3 Aug 2023 15:02:19 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH net-next 8/9] wifi: rsi: Remove unnecessary (void*) conversions
Date:   Thu,  3 Aug 2023 15:02:18 +0800
Message-Id: <20230803070218.3654942-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void*) to (struct rsi_91x_usbdev *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/wireless/rsi/rsi_91x_usb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_usb.c b/drivers/net/wireless/rsi/rsi_91x_usb.c
index 66fe386ec9cc..10a465686439 100644
--- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -43,7 +43,7 @@ static int rsi_usb_card_write(struct rsi_hw *adapter,
 			      u16 len,
 			      u8 endpoint)
 {
-	struct rsi_91x_usbdev *dev = (struct rsi_91x_usbdev *)adapter->rsi_dev;
+	struct rsi_91x_usbdev *dev = adapter->rsi_dev;
 	int status;
 	u8 *seg = dev->tx_buffer;
 	int transfer;
@@ -91,7 +91,7 @@ static int rsi_write_multiple(struct rsi_hw *adapter,
 	if (endpoint == 0)
 		return -EINVAL;
 
-	dev = (struct rsi_91x_usbdev *)adapter->rsi_dev;
+	dev = adapter->rsi_dev;
 	if (dev->write_fail)
 		return -ENETDOWN;
 
@@ -109,7 +109,7 @@ static int rsi_write_multiple(struct rsi_hw *adapter,
 static int rsi_find_bulk_in_and_out_endpoints(struct usb_interface *interface,
 					      struct rsi_hw *adapter)
 {
-	struct rsi_91x_usbdev *dev = (struct rsi_91x_usbdev *)adapter->rsi_dev;
+	struct rsi_91x_usbdev *dev = adapter->rsi_dev;
 	struct usb_host_interface *iface_desc;
 	struct usb_endpoint_descriptor *endpoint;
 	__le16 buffer_size;
@@ -306,7 +306,7 @@ static void rsi_rx_done_handler(struct urb *urb)
 
 static void rsi_rx_urb_kill(struct rsi_hw *adapter, u8 ep_num)
 {
-	struct rsi_91x_usbdev *dev = (struct rsi_91x_usbdev *)adapter->rsi_dev;
+	struct rsi_91x_usbdev *dev = adapter->rsi_dev;
 	struct rx_usb_ctrl_block *rx_cb = &dev->rx_cb[ep_num - 1];
 	struct urb *urb = rx_cb->rx_urb;
 
@@ -323,7 +323,7 @@ static void rsi_rx_urb_kill(struct rsi_hw *adapter, u8 ep_num)
  */
 static int rsi_rx_urb_submit(struct rsi_hw *adapter, u8 ep_num, gfp_t mem_flags)
 {
-	struct rsi_91x_usbdev *dev = (struct rsi_91x_usbdev *)adapter->rsi_dev;
+	struct rsi_91x_usbdev *dev = adapter->rsi_dev;
 	struct rx_usb_ctrl_block *rx_cb = &dev->rx_cb[ep_num - 1];
 	struct urb *urb = rx_cb->rx_urb;
 	int status;
@@ -362,7 +362,7 @@ static int rsi_rx_urb_submit(struct rsi_hw *adapter, u8 ep_num, gfp_t mem_flags)
 static int rsi_usb_read_register_multiple(struct rsi_hw *adapter, u32 addr,
 					  u8 *data, u16 count)
 {
-	struct rsi_91x_usbdev *dev = (struct rsi_91x_usbdev *)adapter->rsi_dev;
+	struct rsi_91x_usbdev *dev = adapter->rsi_dev;
 	u8 *buf;
 	u16 transfer;
 	int status;
@@ -412,7 +412,7 @@ static int rsi_usb_read_register_multiple(struct rsi_hw *adapter, u32 addr,
 static int rsi_usb_write_register_multiple(struct rsi_hw *adapter, u32 addr,
 					   u8 *data, u16 count)
 {
-	struct rsi_91x_usbdev *dev = (struct rsi_91x_usbdev *)adapter->rsi_dev;
+	struct rsi_91x_usbdev *dev = adapter->rsi_dev;
 	u8 *buf;
 	u16 transfer;
 	int status = 0;
@@ -559,7 +559,7 @@ static struct rsi_host_intf_ops usb_host_intf_ops = {
  */
 static void rsi_deinit_usb_interface(struct rsi_hw *adapter)
 {
-	struct rsi_91x_usbdev *dev = (struct rsi_91x_usbdev *)adapter->rsi_dev;
+	struct rsi_91x_usbdev *dev = adapter->rsi_dev;
 
 	rsi_kill_thread(&dev->rx_thread);
 
@@ -572,7 +572,7 @@ static void rsi_deinit_usb_interface(struct rsi_hw *adapter)
 
 static int rsi_usb_init_rx(struct rsi_hw *adapter)
 {
-	struct rsi_91x_usbdev *dev = (struct rsi_91x_usbdev *)adapter->rsi_dev;
+	struct rsi_91x_usbdev *dev = adapter->rsi_dev;
 	struct rx_usb_ctrl_block *rx_cb;
 	u8 idx, num_rx_cb;
 
@@ -822,7 +822,7 @@ static int rsi_probe(struct usb_interface *pfunction,
 		goto err1;
 	}
 
-	dev = (struct rsi_91x_usbdev *)adapter->rsi_dev;
+	dev = adapter->rsi_dev;
 
 	status = rsi_usb_reg_read(dev->usbdev, FW_STATUS_REG, &fw_status, 2);
 	if (status < 0)
-- 
2.30.2

