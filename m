Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083688068C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377038AbjLFHjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377033AbjLFHjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:39:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578822129
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:38:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9F2C433AD;
        Wed,  6 Dec 2023 07:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848284;
        bh=9piAtxpwd8QyPr3dV4ljR+h7hsPpKYrwLhTQlg23Blw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oj4AkOH+Sckjfnft+wXQIAMTSF7mo5zJ10N1qglDCu2U4pSDua6XEnKqmBJSjQOxt
         IiUc0o2311c3eIh6hLWqsQYQfrtFihM1gR6JljSRtEUFnImhorHjax2ENmm+tDxo7u
         c4FWUcDavhETstQvuujoXNCwBNWM426e7AyVfC9U9RbO3vCDdfj2GsLYORjsGmlekG
         UMaecVlXRfT87J26i1LlvQ6BkPm29lWtjy8N/keA109s8pThXZiCYbc78qPLcG3MvF
         aBLJ1KfhdpYoQkCQawPrXRw2G4wCgwe8Wn/jPNK9MB6HtAQxvLeYXH7Z8DF7XYizgF
         pnV9jNYUI6p2w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 23/27] tty: serdev: convert to u8 and size_t
Date:   Wed,  6 Dec 2023 08:37:08 +0100
Message-ID: <20231206073712.17776-24-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch character types to u8 and sizes to size_t. To conform to
characters/sizes in the rest of the tty layer.

This patch converts struct serdev_device_ops hooks and its
instantiations.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>
---
 drivers/bluetooth/btmtkuart.c                  |  4 ++--
 drivers/bluetooth/btnxpuart.c                  |  4 ++--
 drivers/bluetooth/hci_serdev.c                 |  4 ++--
 drivers/gnss/serial.c                          |  4 ++--
 drivers/gnss/sirf.c                            |  4 ++--
 drivers/greybus/gb-beagleplay.c                |  5 +++--
 drivers/iio/chemical/pms7003.c                 |  6 +++---
 drivers/iio/chemical/scd30_serial.c            |  6 +++---
 drivers/iio/chemical/sps30_serial.c            | 18 +++++++++---------
 drivers/iio/imu/bno055/bno055_ser_core.c       |  6 +++---
 drivers/mfd/rave-sp.c                          | 10 +++++-----
 drivers/net/ethernet/qualcomm/qca_uart.c       |  5 ++---
 drivers/nfc/pn533/uart.c                       |  4 ++--
 drivers/nfc/s3fwrn5/uart.c                     |  5 ++---
 drivers/platform/chrome/cros_ec_uart.c         |  5 ++---
 .../platform/surface/aggregator/controller.h   |  4 ++--
 drivers/platform/surface/aggregator/core.c     |  4 ++--
 .../surface/aggregator/ssh_packet_layer.c      |  4 ++--
 .../surface/aggregator/ssh_packet_layer.h      |  2 +-
 drivers/tty/serdev/core.c                      | 12 +++++-------
 include/linux/serdev.h                         | 13 +++++++------
 sound/drivers/serial-generic.c                 |  4 ++--
 22 files changed, 65 insertions(+), 68 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 935feab815d9..d4f4e40ac5d2 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -385,8 +385,8 @@ static int btmtkuart_recv(struct hci_dev *hdev, const u8 *data, size_t count)
 	return 0;
 }
 
-static int btmtkuart_receive_buf(struct serdev_device *serdev, const u8 *data,
-				 size_t count)
+static ssize_t btmtkuart_receive_buf(struct serdev_device *serdev,
+				     const u8 *data, size_t count)
 {
 	struct btmtkuart_dev *bdev = serdev_device_get_drvdata(serdev);
 	int err;
diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index b7e66b7ac570..d75487a90bba 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1264,8 +1264,8 @@ static const struct h4_recv_pkt nxp_recv_pkts[] = {
 	{ NXP_RECV_FW_REQ_V3,   .recv = nxp_recv_fw_req_v3 },
 };
 
-static int btnxpuart_receive_buf(struct serdev_device *serdev, const u8 *data,
-				 size_t count)
+static ssize_t btnxpuart_receive_buf(struct serdev_device *serdev,
+				     const u8 *data, size_t count)
 {
 	struct btnxpuart_dev *nxpdev = serdev_device_get_drvdata(serdev);
 
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index f16fd79bc02b..39c8b567da3c 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -271,8 +271,8 @@ static void hci_uart_write_wakeup(struct serdev_device *serdev)
  *
  * Return: number of processed bytes
  */
-static int hci_uart_receive_buf(struct serdev_device *serdev, const u8 *data,
-				   size_t count)
+static ssize_t hci_uart_receive_buf(struct serdev_device *serdev,
+				    const u8 *data, size_t count)
 {
 	struct hci_uart *hu = serdev_device_get_drvdata(serdev);
 
diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
index 5d8e9bfb24d0..baa956494e79 100644
--- a/drivers/gnss/serial.c
+++ b/drivers/gnss/serial.c
@@ -80,8 +80,8 @@ static const struct gnss_operations gnss_serial_gnss_ops = {
 	.write_raw	= gnss_serial_write_raw,
 };
 
-static int gnss_serial_receive_buf(struct serdev_device *serdev,
-					const unsigned char *buf, size_t count)
+static ssize_t gnss_serial_receive_buf(struct serdev_device *serdev,
+				       const u8 *buf, size_t count)
 {
 	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
 	struct gnss_device *gdev = gserial->gdev;
diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index bcb53ccfee4d..6801a8fb2040 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -160,8 +160,8 @@ static const struct gnss_operations sirf_gnss_ops = {
 	.write_raw	= sirf_write_raw,
 };
 
-static int sirf_receive_buf(struct serdev_device *serdev,
-				const unsigned char *buf, size_t count)
+static ssize_t sirf_receive_buf(struct serdev_device *serdev,
+				const u8 *buf, size_t count)
 {
 	struct sirf_data *data = serdev_device_get_drvdata(serdev);
 	struct gnss_device *gdev = data->gdev;
diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
index 1e70ff7e3da4..b8383a5f6770 100644
--- a/drivers/greybus/gb-beagleplay.c
+++ b/drivers/greybus/gb-beagleplay.c
@@ -257,7 +257,7 @@ static void hdlc_rx_frame(struct gb_beagleplay *bg)
 	}
 }
 
-static int hdlc_rx(struct gb_beagleplay *bg, const u8 *data, size_t count)
+static ssize_t hdlc_rx(struct gb_beagleplay *bg, const u8 *data, size_t count)
 {
 	size_t i;
 	u8 c;
@@ -317,7 +317,8 @@ static void hdlc_deinit(struct gb_beagleplay *bg)
 	flush_work(&bg->tx_work);
 }
 
-static int gb_tty_receive(struct serdev_device *sd, const unsigned char *data, size_t count)
+static ssize_t gb_tty_receive(struct serdev_device *sd, const u8 *data,
+			      size_t count)
 {
 	struct gb_beagleplay *bg = serdev_device_get_drvdata(sd);
 
diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index e9857d93b307..b5cf15a515d2 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -211,13 +211,13 @@ static bool pms7003_frame_is_okay(struct pms7003_frame *frame)
 	return checksum == pms7003_calc_checksum(frame);
 }
 
-static int pms7003_receive_buf(struct serdev_device *serdev,
-			       const unsigned char *buf, size_t size)
+static ssize_t pms7003_receive_buf(struct serdev_device *serdev, const u8 *buf,
+				   size_t size)
 {
 	struct iio_dev *indio_dev = serdev_device_get_drvdata(serdev);
 	struct pms7003_state *state = iio_priv(indio_dev);
 	struct pms7003_frame *frame = &state->frame;
-	int num;
+	size_t num;
 
 	if (!frame->expected_length) {
 		u16 magic;
diff --git a/drivers/iio/chemical/scd30_serial.c b/drivers/iio/chemical/scd30_serial.c
index 3c519103d30b..a47654591e55 100644
--- a/drivers/iio/chemical/scd30_serial.c
+++ b/drivers/iio/chemical/scd30_serial.c
@@ -174,13 +174,13 @@ static int scd30_serdev_command(struct scd30_state *state, enum scd30_cmd cmd, u
 	return 0;
 }
 
-static int scd30_serdev_receive_buf(struct serdev_device *serdev,
-				    const unsigned char *buf, size_t size)
+static ssize_t scd30_serdev_receive_buf(struct serdev_device *serdev,
+					const u8 *buf, size_t size)
 {
 	struct iio_dev *indio_dev = serdev_device_get_drvdata(serdev);
 	struct scd30_serdev_priv *priv;
 	struct scd30_state *state;
-	int num;
+	size_t num;
 
 	if (!indio_dev)
 		return 0;
diff --git a/drivers/iio/chemical/sps30_serial.c b/drivers/iio/chemical/sps30_serial.c
index 164f4b3e025c..3afa89f8acc3 100644
--- a/drivers/iio/chemical/sps30_serial.c
+++ b/drivers/iio/chemical/sps30_serial.c
@@ -74,8 +74,8 @@ static int sps30_serial_xfer(struct sps30_state *state, const unsigned char *buf
 }
 
 static const struct {
-	unsigned char byte;
-	unsigned char byte2;
+	u8 byte;
+	u8 byte2;
 } sps30_serial_bytes[] = {
 	{ 0x11, 0x31 },
 	{ 0x13, 0x33 },
@@ -83,7 +83,7 @@ static const struct {
 	{ 0x7d, 0x5d },
 };
 
-static int sps30_serial_put_byte(unsigned char *buf, unsigned char byte)
+static int sps30_serial_put_byte(u8 *buf, u8 byte)
 {
 	int i;
 
@@ -102,7 +102,7 @@ static int sps30_serial_put_byte(unsigned char *buf, unsigned char byte)
 	return 1;
 }
 
-static char sps30_serial_get_byte(bool escaped, unsigned char byte2)
+static u8 sps30_serial_get_byte(bool escaped, u8 byte2)
 {
 	int i;
 
@@ -130,8 +130,8 @@ static unsigned char sps30_serial_calc_chksum(const unsigned char *buf, size_t n
 	return ~chksum;
 }
 
-static int sps30_serial_prep_frame(unsigned char *buf, unsigned char cmd,
-				   const unsigned char *arg, size_t arg_size)
+static int sps30_serial_prep_frame(u8 *buf, u8 cmd, const u8 *arg,
+				   size_t arg_size)
 {
 	unsigned char chksum;
 	int num = 0;
@@ -210,14 +210,14 @@ static int sps30_serial_command(struct sps30_state *state, unsigned char cmd,
 	return rsp_size;
 }
 
-static int sps30_serial_receive_buf(struct serdev_device *serdev,
-				    const unsigned char *buf, size_t size)
+static ssize_t sps30_serial_receive_buf(struct serdev_device *serdev,
+					const u8 *buf, size_t size)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
 	struct sps30_serial_priv *priv;
 	struct sps30_state *state;
-	unsigned char byte;
 	size_t i;
+	u8 byte;
 
 	if (!indio_dev)
 		return 0;
diff --git a/drivers/iio/imu/bno055/bno055_ser_core.c b/drivers/iio/imu/bno055/bno055_ser_core.c
index 57728a568471..5677bdf4f846 100644
--- a/drivers/iio/imu/bno055/bno055_ser_core.c
+++ b/drivers/iio/imu/bno055/bno055_ser_core.c
@@ -378,12 +378,12 @@ static void bno055_ser_handle_rx(struct bno055_ser_priv *priv, int status)
  * Also, we assume to RX one pkt per time (i.e. the HW doesn't send anything
  * unless we require to AND we don't queue more than one request per time).
  */
-static int bno055_ser_receive_buf(struct serdev_device *serdev,
-				  const unsigned char *buf, size_t size)
+static ssize_t bno055_ser_receive_buf(struct serdev_device *serdev,
+				      const u8 *buf, size_t size)
 {
 	int status;
 	struct bno055_ser_priv *priv = serdev_device_get_drvdata(serdev);
-	int remaining = size;
+	size_t remaining = size;
 
 	if (size == 0)
 		return 0;
diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index da50eba10014..b1229bb143ee 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -471,17 +471,17 @@ static void rave_sp_receive_frame(struct rave_sp *sp,
 		rave_sp_receive_reply(sp, data, length);
 }
 
-static int rave_sp_receive_buf(struct serdev_device *serdev,
-			       const unsigned char *buf, size_t size)
+static ssize_t rave_sp_receive_buf(struct serdev_device *serdev,
+				   const u8 *buf, size_t size)
 {
 	struct device *dev = &serdev->dev;
 	struct rave_sp *sp = dev_get_drvdata(dev);
 	struct rave_sp_deframer *deframer = &sp->deframer;
-	const unsigned char *src = buf;
-	const unsigned char *end = buf + size;
+	const u8 *src = buf;
+	const u8 *end = buf + size;
 
 	while (src < end) {
-		const unsigned char byte = *src++;
+		const u8 byte = *src++;
 
 		switch (deframer->state) {
 		case RAVE_SP_EXPECT_SOF:
diff --git a/drivers/net/ethernet/qualcomm/qca_uart.c b/drivers/net/ethernet/qualcomm/qca_uart.c
index 9adec91f35e9..223321897b96 100644
--- a/drivers/net/ethernet/qualcomm/qca_uart.c
+++ b/drivers/net/ethernet/qualcomm/qca_uart.c
@@ -58,9 +58,8 @@ struct qcauart {
 	unsigned char *tx_buffer;
 };
 
-static int
-qca_tty_receive(struct serdev_device *serdev, const unsigned char *data,
-		size_t count)
+static ssize_t
+qca_tty_receive(struct serdev_device *serdev, const u8 *data, size_t count)
 {
 	struct qcauart *qca = serdev_device_get_drvdata(serdev);
 	struct net_device *netdev = qca->net_dev;
diff --git a/drivers/nfc/pn533/uart.c b/drivers/nfc/pn533/uart.c
index a556acdb947b..2eb5978bd79e 100644
--- a/drivers/nfc/pn533/uart.c
+++ b/drivers/nfc/pn533/uart.c
@@ -203,8 +203,8 @@ static int pn532_uart_rx_is_frame(struct sk_buff *skb)
 	return 0;
 }
 
-static int pn532_receive_buf(struct serdev_device *serdev,
-		const unsigned char *data, size_t count)
+static ssize_t pn532_receive_buf(struct serdev_device *serdev,
+				 const u8 *data, size_t count)
 {
 	struct pn532_uart_phy *dev = serdev_device_get_drvdata(serdev);
 	size_t i;
diff --git a/drivers/nfc/s3fwrn5/uart.c b/drivers/nfc/s3fwrn5/uart.c
index 82ea35d748a5..456d3947116c 100644
--- a/drivers/nfc/s3fwrn5/uart.c
+++ b/drivers/nfc/s3fwrn5/uart.c
@@ -51,9 +51,8 @@ static const struct s3fwrn5_phy_ops uart_phy_ops = {
 	.write = s3fwrn82_uart_write,
 };
 
-static int s3fwrn82_uart_read(struct serdev_device *serdev,
-			      const unsigned char *data,
-			      size_t count)
+static ssize_t s3fwrn82_uart_read(struct serdev_device *serdev,
+				  const u8 *data, size_t count)
 {
 	struct s3fwrn82_uart_phy *phy = serdev_device_get_drvdata(serdev);
 	size_t i;
diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
index 788246559bbb..68d80559fddc 100644
--- a/drivers/platform/chrome/cros_ec_uart.c
+++ b/drivers/platform/chrome/cros_ec_uart.c
@@ -81,9 +81,8 @@ struct cros_ec_uart {
 	struct response_info response;
 };
 
-static int cros_ec_uart_rx_bytes(struct serdev_device *serdev,
-				 const u8 *data,
-				 size_t count)
+static ssize_t cros_ec_uart_rx_bytes(struct serdev_device *serdev,
+				     const u8 *data, size_t count)
 {
 	struct ec_host_response *host_response;
 	struct cros_ec_device *ec_dev = serdev_device_get_drvdata(serdev);
diff --git a/drivers/platform/surface/aggregator/controller.h b/drivers/platform/surface/aggregator/controller.h
index f0d987abc51e..f1638c2081e8 100644
--- a/drivers/platform/surface/aggregator/controller.h
+++ b/drivers/platform/surface/aggregator/controller.h
@@ -238,8 +238,8 @@ struct ssam_controller {
  * layer of the controller has been shut down, %-ESHUTDOWN.
  */
 static inline
-int ssam_controller_receive_buf(struct ssam_controller *ctrl,
-				const unsigned char *buf, size_t n)
+ssize_t ssam_controller_receive_buf(struct ssam_controller *ctrl, const u8 *buf,
+				    size_t n)
 {
 	return ssh_ptl_rx_rcvbuf(&ctrl->rtl.ptl, buf, n);
 }
diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index 6152be38398c..9591a28bc38a 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -227,8 +227,8 @@ EXPORT_SYMBOL_GPL(ssam_client_bind);
 
 /* -- Glue layer (serdev_device -> ssam_controller). ------------------------ */
 
-static int ssam_receive_buf(struct serdev_device *dev, const unsigned char *buf,
-			    size_t n)
+static ssize_t ssam_receive_buf(struct serdev_device *dev, const u8 *buf,
+				size_t n)
 {
 	struct ssam_controller *ctrl;
 	int ret;
diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
index def8d7ac541f..d726b1a86319 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -1887,9 +1887,9 @@ int ssh_ptl_rx_stop(struct ssh_ptl *ptl)
  * Return: Returns the number of bytes transferred (positive or zero) on
  * success. Returns %-ESHUTDOWN if the packet layer has been shut down.
  */
-int ssh_ptl_rx_rcvbuf(struct ssh_ptl *ptl, const u8 *buf, size_t n)
+ssize_t ssh_ptl_rx_rcvbuf(struct ssh_ptl *ptl, const u8 *buf, size_t n)
 {
-	int used;
+	size_t used;
 
 	if (test_bit(SSH_PTL_SF_SHUTDOWN_BIT, &ptl->state))
 		return -ESHUTDOWN;
diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.h b/drivers/platform/surface/aggregator/ssh_packet_layer.h
index 64633522f971..c80e822070df 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.h
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.h
@@ -162,7 +162,7 @@ void ssh_ptl_shutdown(struct ssh_ptl *ptl);
 int ssh_ptl_submit(struct ssh_ptl *ptl, struct ssh_packet *p);
 void ssh_ptl_cancel(struct ssh_packet *p);
 
-int ssh_ptl_rx_rcvbuf(struct ssh_ptl *ptl, const u8 *buf, size_t n);
+ssize_t ssh_ptl_rx_rcvbuf(struct ssh_ptl *ptl, const u8 *buf, size_t n);
 
 /**
  * ssh_ptl_tx_wakeup_transfer() - Wake up packet transmitter thread for
diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 3090e3454c44..de8d87d4858d 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -225,8 +225,7 @@ EXPORT_SYMBOL_GPL(serdev_device_write_wakeup);
  * Return: The number of bytes written (less than count if not enough room in
  * the write buffer), or a negative errno on errors.
  */
-int serdev_device_write_buf(struct serdev_device *serdev,
-			    const unsigned char *buf, size_t count)
+int serdev_device_write_buf(struct serdev_device *serdev, const u8 *buf, size_t count)
 {
 	struct serdev_controller *ctrl = serdev->ctrl;
 
@@ -259,13 +258,12 @@ EXPORT_SYMBOL_GPL(serdev_device_write_buf);
  * -ETIMEDOUT or -ERESTARTSYS if interrupted before any bytes were written, or
  * a negative errno on errors.
  */
-int serdev_device_write(struct serdev_device *serdev,
-			const unsigned char *buf, size_t count,
-			long timeout)
+ssize_t serdev_device_write(struct serdev_device *serdev, const u8 *buf,
+			    size_t count, long timeout)
 {
 	struct serdev_controller *ctrl = serdev->ctrl;
-	int written = 0;
-	int ret;
+	size_t written = 0;
+	ssize_t ret;
 
 	if (!ctrl || !ctrl->ops->write_buf || !serdev->ops->write_wakeup)
 		return -EINVAL;
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 8cdab2c3b6d5..3fab88ba265e 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -27,7 +27,7 @@ struct serdev_device;
  *			not sleep.
  */
 struct serdev_device_ops {
-	int (*receive_buf)(struct serdev_device *, const unsigned char *, size_t);
+	ssize_t (*receive_buf)(struct serdev_device *, const u8 *, size_t);
 	void (*write_wakeup)(struct serdev_device *);
 };
 
@@ -204,13 +204,13 @@ void serdev_device_close(struct serdev_device *);
 int devm_serdev_device_open(struct device *, struct serdev_device *);
 unsigned int serdev_device_set_baudrate(struct serdev_device *, unsigned int);
 void serdev_device_set_flow_control(struct serdev_device *, bool);
-int serdev_device_write_buf(struct serdev_device *, const unsigned char *, size_t);
+int serdev_device_write_buf(struct serdev_device *, const u8 *, size_t);
 void serdev_device_wait_until_sent(struct serdev_device *, long);
 int serdev_device_get_tiocm(struct serdev_device *);
 int serdev_device_set_tiocm(struct serdev_device *, int, int);
 int serdev_device_break_ctl(struct serdev_device *serdev, int break_state);
 void serdev_device_write_wakeup(struct serdev_device *);
-int serdev_device_write(struct serdev_device *, const unsigned char *, size_t, long);
+ssize_t serdev_device_write(struct serdev_device *, const u8 *, size_t, long);
 void serdev_device_write_flush(struct serdev_device *);
 int serdev_device_write_room(struct serdev_device *);
 
@@ -248,7 +248,7 @@ static inline unsigned int serdev_device_set_baudrate(struct serdev_device *sdev
 }
 static inline void serdev_device_set_flow_control(struct serdev_device *sdev, bool enable) {}
 static inline int serdev_device_write_buf(struct serdev_device *serdev,
-					  const unsigned char *buf,
+					  const u8 *buf,
 					  size_t count)
 {
 	return -ENODEV;
@@ -266,8 +266,9 @@ static inline int serdev_device_break_ctl(struct serdev_device *serdev, int brea
 {
 	return -EOPNOTSUPP;
 }
-static inline int serdev_device_write(struct serdev_device *sdev, const unsigned char *buf,
-				      size_t count, unsigned long timeout)
+static inline ssize_t serdev_device_write(struct serdev_device *sdev,
+					  const u8 *buf, size_t count,
+					  unsigned long timeout)
 {
 	return -ENODEV;
 }
diff --git a/sound/drivers/serial-generic.c b/sound/drivers/serial-generic.c
index c8db6c75d133..d6e5aafd697c 100644
--- a/sound/drivers/serial-generic.c
+++ b/sound/drivers/serial-generic.c
@@ -100,8 +100,8 @@ static void snd_serial_generic_write_wakeup(struct serdev_device *serdev)
 	snd_serial_generic_tx_wakeup(drvdata);
 }
 
-static int snd_serial_generic_receive_buf(struct serdev_device *serdev,
-				const unsigned char *buf, size_t count)
+static ssize_t snd_serial_generic_receive_buf(struct serdev_device *serdev,
+					      const u8 *buf, size_t count)
 {
 	int ret;
 	struct snd_serial_generic *drvdata = serdev_device_get_drvdata(serdev);
-- 
2.43.0

