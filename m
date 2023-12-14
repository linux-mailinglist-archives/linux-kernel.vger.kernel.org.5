Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2F9813721
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjLNRBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLNRBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:01:50 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143E18E;
        Thu, 14 Dec 2023 09:01:54 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 8C3912144D;
        Thu, 14 Dec 2023 18:01:51 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, greybus-dev@lists.linaro.org,
        linux-iio@vger.kernel.org, netdev@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-sound@vger.kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v1] treewide, serdev: change receive_buf() return type to size_t
Date:   Thu, 14 Dec 2023 18:01:46 +0100
Message-Id: <20231214170146.641783-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
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

receive_buf() is called from ttyport_receive_buf() that expects values
">= 0" from serdev_controller_receive_buf(), change its return type from
ssize_t to size_t.

Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/all/087be419-ec6b-47ad-851a-5e1e3ea5cfcc@kernel.org/
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
hello,
patch is based on current linux next.

It has an obvious problem, it touches files from multiple subsystem in a single
patch that is complicated to review and eventually merge, just splitting this
would however not work, it will break bisectability and the build.

I am looking for advise on the best way to move forward.

I see the following options:
 - keep it as it is
 - break it down with a patch with each subsystem, and squash before applying
   from a single (tty?) subsystem
 - go for a multi stage approach, defining a new callback, move to it and in
   the end remove the original one, likewise it was done for i2c lately

---
 drivers/bluetooth/btmtkuart.c              |  4 ++--
 drivers/bluetooth/btnxpuart.c              |  4 ++--
 drivers/bluetooth/hci_serdev.c             |  4 ++--
 drivers/gnss/core.c                        |  6 +++---
 drivers/gnss/serial.c                      |  4 ++--
 drivers/gnss/sirf.c                        |  6 +++---
 drivers/greybus/gb-beagleplay.c            |  6 +++---
 drivers/iio/chemical/pms7003.c             |  4 ++--
 drivers/iio/chemical/scd30_serial.c        |  4 ++--
 drivers/iio/chemical/sps30_serial.c        |  4 ++--
 drivers/iio/imu/bno055/bno055_ser_core.c   |  4 ++--
 drivers/mfd/rave-sp.c                      |  4 ++--
 drivers/net/ethernet/qualcomm/qca_uart.c   |  2 +-
 drivers/nfc/pn533/uart.c                   |  4 ++--
 drivers/nfc/s3fwrn5/uart.c                 |  4 ++--
 drivers/platform/chrome/cros_ec_uart.c     |  4 ++--
 drivers/platform/surface/aggregator/core.c |  4 ++--
 drivers/tty/serdev/serdev-ttyport.c        | 10 ++++------
 include/linux/gnss.h                       |  4 ++--
 include/linux/serdev.h                     |  8 ++++----
 sound/drivers/serial-generic.c             |  4 ++--
 21 files changed, 48 insertions(+), 50 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 3c84fcbda01a..e6bc4a73c9fc 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -383,8 +383,8 @@ static void btmtkuart_recv(struct hci_dev *hdev, const u8 *data, size_t count)
 	}
 }
 
-static ssize_t btmtkuart_receive_buf(struct serdev_device *serdev,
-				     const u8 *data, size_t count)
+static size_t btmtkuart_receive_buf(struct serdev_device *serdev,
+				    const u8 *data, size_t count)
 {
 	struct btmtkuart_dev *bdev = serdev_device_get_drvdata(serdev);
 
diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 1d592ac413d1..056bef5b2919 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1264,8 +1264,8 @@ static const struct h4_recv_pkt nxp_recv_pkts[] = {
 	{ NXP_RECV_FW_REQ_V3,   .recv = nxp_recv_fw_req_v3 },
 };
 
-static ssize_t btnxpuart_receive_buf(struct serdev_device *serdev,
-				     const u8 *data, size_t count)
+static size_t btnxpuart_receive_buf(struct serdev_device *serdev,
+				    const u8 *data, size_t count)
 {
 	struct btnxpuart_dev *nxpdev = serdev_device_get_drvdata(serdev);
 
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 39c8b567da3c..a3c3beb2806d 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -271,8 +271,8 @@ static void hci_uart_write_wakeup(struct serdev_device *serdev)
  *
  * Return: number of processed bytes
  */
-static ssize_t hci_uart_receive_buf(struct serdev_device *serdev,
-				    const u8 *data, size_t count)
+static size_t hci_uart_receive_buf(struct serdev_device *serdev,
+				   const u8 *data, size_t count)
 {
 	struct hci_uart *hu = serdev_device_get_drvdata(serdev);
 
diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index 48f2ee0f78c4..9b8a0605ec76 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -317,10 +317,10 @@ EXPORT_SYMBOL_GPL(gnss_deregister_device);
  *
  * Must not be called for a closed device.
  */
-int gnss_insert_raw(struct gnss_device *gdev, const unsigned char *buf,
-				size_t count)
+size_t gnss_insert_raw(struct gnss_device *gdev, const unsigned char *buf,
+		       size_t count)
 {
-	int ret;
+	size_t ret;
 
 	ret = kfifo_in(&gdev->read_fifo, buf, count);
 
diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
index baa956494e79..bf55aa2c1cf0 100644
--- a/drivers/gnss/serial.c
+++ b/drivers/gnss/serial.c
@@ -80,8 +80,8 @@ static const struct gnss_operations gnss_serial_gnss_ops = {
 	.write_raw	= gnss_serial_write_raw,
 };
 
-static ssize_t gnss_serial_receive_buf(struct serdev_device *serdev,
-				       const u8 *buf, size_t count)
+static size_t gnss_serial_receive_buf(struct serdev_device *serdev,
+				      const u8 *buf, size_t count)
 {
 	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
 	struct gnss_device *gdev = gserial->gdev;
diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index 6801a8fb2040..2aae3c02156d 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -160,12 +160,12 @@ static const struct gnss_operations sirf_gnss_ops = {
 	.write_raw	= sirf_write_raw,
 };
 
-static ssize_t sirf_receive_buf(struct serdev_device *serdev,
-				const u8 *buf, size_t count)
+static size_t sirf_receive_buf(struct serdev_device *serdev,
+			       const u8 *buf, size_t count)
 {
 	struct sirf_data *data = serdev_device_get_drvdata(serdev);
 	struct gnss_device *gdev = data->gdev;
-	int ret = 0;
+	size_t ret = 0;
 
 	if (!data->wakeup && !data->active) {
 		data->active = true;
diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
index 2da37ff92cf1..26c95efe2fff 100644
--- a/drivers/greybus/gb-beagleplay.c
+++ b/drivers/greybus/gb-beagleplay.c
@@ -257,7 +257,7 @@ static void hdlc_rx_frame(struct gb_beagleplay *bg)
 	}
 }
 
-static ssize_t hdlc_rx(struct gb_beagleplay *bg, const u8 *data, size_t count)
+static size_t hdlc_rx(struct gb_beagleplay *bg, const u8 *data, size_t count)
 {
 	size_t i;
 	u8 c;
@@ -317,8 +317,8 @@ static void hdlc_deinit(struct gb_beagleplay *bg)
 	flush_work(&bg->tx_work);
 }
 
-static ssize_t gb_tty_receive(struct serdev_device *sd, const u8 *data,
-			      size_t count)
+static size_t gb_tty_receive(struct serdev_device *sd, const u8 *data,
+			     size_t count)
 {
 	struct gb_beagleplay *bg = serdev_device_get_drvdata(sd);
 
diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index b5cf15a515d2..43025866d5b7 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -211,8 +211,8 @@ static bool pms7003_frame_is_okay(struct pms7003_frame *frame)
 	return checksum == pms7003_calc_checksum(frame);
 }
 
-static ssize_t pms7003_receive_buf(struct serdev_device *serdev, const u8 *buf,
-				   size_t size)
+static size_t pms7003_receive_buf(struct serdev_device *serdev, const u8 *buf,
+				  size_t size)
 {
 	struct iio_dev *indio_dev = serdev_device_get_drvdata(serdev);
 	struct pms7003_state *state = iio_priv(indio_dev);
diff --git a/drivers/iio/chemical/scd30_serial.c b/drivers/iio/chemical/scd30_serial.c
index a47654591e55..2adb76dbb020 100644
--- a/drivers/iio/chemical/scd30_serial.c
+++ b/drivers/iio/chemical/scd30_serial.c
@@ -174,8 +174,8 @@ static int scd30_serdev_command(struct scd30_state *state, enum scd30_cmd cmd, u
 	return 0;
 }
 
-static ssize_t scd30_serdev_receive_buf(struct serdev_device *serdev,
-					const u8 *buf, size_t size)
+static size_t scd30_serdev_receive_buf(struct serdev_device *serdev,
+				       const u8 *buf, size_t size)
 {
 	struct iio_dev *indio_dev = serdev_device_get_drvdata(serdev);
 	struct scd30_serdev_priv *priv;
diff --git a/drivers/iio/chemical/sps30_serial.c b/drivers/iio/chemical/sps30_serial.c
index 3afa89f8acc3..a6dfbe28c914 100644
--- a/drivers/iio/chemical/sps30_serial.c
+++ b/drivers/iio/chemical/sps30_serial.c
@@ -210,8 +210,8 @@ static int sps30_serial_command(struct sps30_state *state, unsigned char cmd,
 	return rsp_size;
 }
 
-static ssize_t sps30_serial_receive_buf(struct serdev_device *serdev,
-					const u8 *buf, size_t size)
+static size_t sps30_serial_receive_buf(struct serdev_device *serdev,
+				       const u8 *buf, size_t size)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
 	struct sps30_serial_priv *priv;
diff --git a/drivers/iio/imu/bno055/bno055_ser_core.c b/drivers/iio/imu/bno055/bno055_ser_core.c
index 5677bdf4f846..694ff14a3aa2 100644
--- a/drivers/iio/imu/bno055/bno055_ser_core.c
+++ b/drivers/iio/imu/bno055/bno055_ser_core.c
@@ -378,8 +378,8 @@ static void bno055_ser_handle_rx(struct bno055_ser_priv *priv, int status)
  * Also, we assume to RX one pkt per time (i.e. the HW doesn't send anything
  * unless we require to AND we don't queue more than one request per time).
  */
-static ssize_t bno055_ser_receive_buf(struct serdev_device *serdev,
-				      const u8 *buf, size_t size)
+static size_t bno055_ser_receive_buf(struct serdev_device *serdev,
+				     const u8 *buf, size_t size)
 {
 	int status;
 	struct bno055_ser_priv *priv = serdev_device_get_drvdata(serdev);
diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index b1229bb143ee..f517e59e1c01 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -471,8 +471,8 @@ static void rave_sp_receive_frame(struct rave_sp *sp,
 		rave_sp_receive_reply(sp, data, length);
 }
 
-static ssize_t rave_sp_receive_buf(struct serdev_device *serdev,
-				   const u8 *buf, size_t size)
+static size_t rave_sp_receive_buf(struct serdev_device *serdev,
+				  const u8 *buf, size_t size)
 {
 	struct device *dev = &serdev->dev;
 	struct rave_sp *sp = dev_get_drvdata(dev);
diff --git a/drivers/net/ethernet/qualcomm/qca_uart.c b/drivers/net/ethernet/qualcomm/qca_uart.c
index 223321897b96..20f50bde82ac 100644
--- a/drivers/net/ethernet/qualcomm/qca_uart.c
+++ b/drivers/net/ethernet/qualcomm/qca_uart.c
@@ -58,7 +58,7 @@ struct qcauart {
 	unsigned char *tx_buffer;
 };
 
-static ssize_t
+static size_t
 qca_tty_receive(struct serdev_device *serdev, const u8 *data, size_t count)
 {
 	struct qcauart *qca = serdev_device_get_drvdata(serdev);
diff --git a/drivers/nfc/pn533/uart.c b/drivers/nfc/pn533/uart.c
index 2eb5978bd79e..cfbbe0713317 100644
--- a/drivers/nfc/pn533/uart.c
+++ b/drivers/nfc/pn533/uart.c
@@ -203,8 +203,8 @@ static int pn532_uart_rx_is_frame(struct sk_buff *skb)
 	return 0;
 }
 
-static ssize_t pn532_receive_buf(struct serdev_device *serdev,
-				 const u8 *data, size_t count)
+static size_t pn532_receive_buf(struct serdev_device *serdev,
+				const u8 *data, size_t count)
 {
 	struct pn532_uart_phy *dev = serdev_device_get_drvdata(serdev);
 	size_t i;
diff --git a/drivers/nfc/s3fwrn5/uart.c b/drivers/nfc/s3fwrn5/uart.c
index 456d3947116c..9c09c10c2a46 100644
--- a/drivers/nfc/s3fwrn5/uart.c
+++ b/drivers/nfc/s3fwrn5/uart.c
@@ -51,8 +51,8 @@ static const struct s3fwrn5_phy_ops uart_phy_ops = {
 	.write = s3fwrn82_uart_write,
 };
 
-static ssize_t s3fwrn82_uart_read(struct serdev_device *serdev,
-				  const u8 *data, size_t count)
+static size_t s3fwrn82_uart_read(struct serdev_device *serdev,
+				 const u8 *data, size_t count)
 {
 	struct s3fwrn82_uart_phy *phy = serdev_device_get_drvdata(serdev);
 	size_t i;
diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
index 68d80559fddc..8ea867c2a01a 100644
--- a/drivers/platform/chrome/cros_ec_uart.c
+++ b/drivers/platform/chrome/cros_ec_uart.c
@@ -81,8 +81,8 @@ struct cros_ec_uart {
 	struct response_info response;
 };
 
-static ssize_t cros_ec_uart_rx_bytes(struct serdev_device *serdev,
-				     const u8 *data, size_t count)
+static size_t cros_ec_uart_rx_bytes(struct serdev_device *serdev,
+				    const u8 *data, size_t count)
 {
 	struct ec_host_response *host_response;
 	struct cros_ec_device *ec_dev = serdev_device_get_drvdata(serdev);
diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index 9591a28bc38a..ba550eaa06fc 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -227,8 +227,8 @@ EXPORT_SYMBOL_GPL(ssam_client_bind);
 
 /* -- Glue layer (serdev_device -> ssam_controller). ------------------------ */
 
-static ssize_t ssam_receive_buf(struct serdev_device *dev, const u8 *buf,
-				size_t n)
+static size_t ssam_receive_buf(struct serdev_device *dev, const u8 *buf,
+			       size_t n)
 {
 	struct ssam_controller *ctrl;
 	int ret;
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index e94e090cf0a1..3d7ae7fa5018 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -27,19 +27,17 @@ static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp,
 {
 	struct serdev_controller *ctrl = port->client_data;
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
-	int ret;
+	size_t ret;
 
 	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
 		return 0;
 
 	ret = serdev_controller_receive_buf(ctrl, cp, count);
 
-	dev_WARN_ONCE(&ctrl->dev, ret < 0 || ret > count,
-				"receive_buf returns %d (count = %zu)\n",
+	dev_WARN_ONCE(&ctrl->dev, ret > count,
+				"receive_buf returns %zu (count = %zu)\n",
 				ret, count);
-	if (ret < 0)
-		return 0;
-	else if (ret > count)
+	if (ret > count)
 		return count;
 
 	return ret;
diff --git a/include/linux/gnss.h b/include/linux/gnss.h
index 36968a0f33e8..9857c4029e65 100644
--- a/include/linux/gnss.h
+++ b/include/linux/gnss.h
@@ -60,8 +60,8 @@ void gnss_put_device(struct gnss_device *gdev);
 int gnss_register_device(struct gnss_device *gdev);
 void gnss_deregister_device(struct gnss_device *gdev);
 
-int gnss_insert_raw(struct gnss_device *gdev, const unsigned char *buf,
-			size_t count);
+size_t gnss_insert_raw(struct gnss_device *gdev, const unsigned char *buf,
+		       size_t count);
 
 static inline void gnss_set_drvdata(struct gnss_device *gdev, void *data)
 {
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 3fab88ba265e..ff78efc1f60d 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -27,7 +27,7 @@ struct serdev_device;
  *			not sleep.
  */
 struct serdev_device_ops {
-	ssize_t (*receive_buf)(struct serdev_device *, const u8 *, size_t);
+	size_t (*receive_buf)(struct serdev_device *, const u8 *, size_t);
 	void (*write_wakeup)(struct serdev_device *);
 };
 
@@ -185,9 +185,9 @@ static inline void serdev_controller_write_wakeup(struct serdev_controller *ctrl
 	serdev->ops->write_wakeup(serdev);
 }
 
-static inline ssize_t serdev_controller_receive_buf(struct serdev_controller *ctrl,
-						    const u8 *data,
-						    size_t count)
+static inline size_t serdev_controller_receive_buf(struct serdev_controller *ctrl,
+						   const u8 *data,
+						   size_t count)
 {
 	struct serdev_device *serdev = ctrl->serdev;
 
diff --git a/sound/drivers/serial-generic.c b/sound/drivers/serial-generic.c
index d6e5aafd697c..36409a56c675 100644
--- a/sound/drivers/serial-generic.c
+++ b/sound/drivers/serial-generic.c
@@ -100,8 +100,8 @@ static void snd_serial_generic_write_wakeup(struct serdev_device *serdev)
 	snd_serial_generic_tx_wakeup(drvdata);
 }
 
-static ssize_t snd_serial_generic_receive_buf(struct serdev_device *serdev,
-					      const u8 *buf, size_t count)
+static size_t snd_serial_generic_receive_buf(struct serdev_device *serdev,
+					     const u8 *buf, size_t count)
 {
 	int ret;
 	struct snd_serial_generic *drvdata = serdev_device_get_drvdata(serdev);

base-commit: 11651f8cb2e88372d4ed523d909514dc9a613ea3
-- 
2.25.1

