Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BA7790083
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242856AbjIAQJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343731AbjIAQJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:09:08 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC1B7CF3;
        Fri,  1 Sep 2023 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:Reply-To:MIME-Version;
        bh=Vmzu2CljRxiz++/tCmMxg1rZKkWM8sIRzFFEFEOaxX8=; b=Rdm1OIN0qApTS
        I61hhLkW0IB4st5KtRSSkV4jTqv+QKAZ4fHUpj+6OapaEZ+FrLbrW3hJYftgC+X/
        SxsMLt8ubwJSLXy3N5r0FhVIRwC+UA8mKFX6hPizEDHBHkmmtl+Jd7br2ywDZN9/
        IrnmEN0sxw6KbNWy+sDo1dU8tlMFo8=
Received: from sc9-mailhost1.vmware.com (unknown [114.250.138.216])
        by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wDHw8jhC_Jk_VGaAw--.15069S2;
        Sat, 02 Sep 2023 00:05:53 +0800 (CST)
From:   Dingyan Li <18500469033@163.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        mathias.nyman@intel.com, pawell@cadence.com
Cc:     linux-mediatek@lists.infradead.org,
        brcm80211-dev-list.pdl@broadcom.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, mina86@mina86.com,
        clemens@ladisch.de, ruslan.bilovol@gmail.com, balbi@ti.com,
        bigeasy@linutronix.de, treding@nvidia.com, oneukum@suse.com,
        laurent.pinchart@ideasonboard.com, nic_swsd@realtek.com,
        marcel@holtmann.org
Subject: [PATCH v3] USB: Extend usb_device_speed with new value USB_SPEED_SUPER_PLUS_BY2
Date:   Sat,  2 Sep 2023 00:05:32 +0800
Message-Id: <20230901160532.6313-1-18500469033@163.com>
X-Mailer: git-send-email 2.25.1
Reply-To: 07c821ae-2391-474c-aec9-65f47d3fecf2@rowland.harvard.edu
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHw8jhC_Jk_VGaAw--.15069S2
X-Coremail-Antispam: 1Uf129KBjvAXoWDAw48CF1rtrWfXw4xJry7ZFb_yoWrKF4xXo
        Z7JF1fKF10yry2ga4kArn7tF9rWryDZan3t3y5Cw1DJ3y5urnxXF17G3Z8Zws8AF93Za18
        Gw4xAw4rWrsxGw4xn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU35l1UUUUU
X-Originating-IP: [114.250.138.216]
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/1tbiNgTdy1WBt83QjAAAsW
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are there major generations when speaking of
USB_SPEED_SUPER_PLUS devices. However, they actually stands
for different physical speeds. GEN_2x2 means 20Gbps, while
the others mean 10Gbps. So in order to confirm 20Gbps, both
speed and generation need ti be checked. This causes a trouble
for ioctl USBDEVFS_GET_SPEED since it can only return speed
value to userspace.

In order not to add a new ioctl to get ssp generation, extending
usb_device_speed is a good option. The side effect is that
USB_SPEED_SUPER_PLUS has been used in lots of places and
it also takes some effort to go through all of them and check
whether the new speed should be used too.

Besides, as suggested by Alen, ssp_rate is not a proper name,
change it to ssp_gen. And change all functions/struct fileds
ended with ssp_rate to ssp_gen. And there is also some code
refactor to reduce duplicate definition of strings and increase
the utilization of commonly defined utilities.

Signed-off-by: Dingyan Li <18500469033@163.com>
---
 drivers/bluetooth/btusb.c                     |  1 +
 drivers/media/usb/uvc/uvc_video.c             |  1 +
 drivers/net/usb/r8152.c                       |  1 +
 drivers/net/usb/usbnet.c                      |  1 +
 .../broadcom/brcm80211/brcmfmac/usb.c         | 21 +++--
 drivers/phy/tegra/xusb.c                      |  2 +-
 drivers/usb/cdns3/cdnsp-gadget.c              |  3 +
 drivers/usb/cdns3/cdnsp-mem.c                 |  4 +-
 drivers/usb/common/common.c                   | 85 ++++++++++++++++---
 drivers/usb/core/config.c                     |  2 +
 drivers/usb/core/devices.c                    | 14 ++-
 drivers/usb/core/hcd.c                        |  8 +-
 drivers/usb/core/hub.c                        | 32 ++++---
 drivers/usb/core/sysfs.c                      | 24 ++----
 drivers/usb/core/urb.c                        |  3 +-
 drivers/usb/dwc3/core.c                       | 18 ++--
 drivers/usb/dwc3/core.h                       |  4 +-
 drivers/usb/dwc3/gadget.c                     | 58 +++++++------
 drivers/usb/gadget/composite.c                | 12 ++-
 drivers/usb/gadget/configfs.c                 | 22 ++---
 drivers/usb/gadget/function/f_fs.c            |  1 +
 drivers/usb/gadget/function/f_sourcesink.c    |  1 +
 drivers/usb/gadget/function/f_uac2.c          | 14 +--
 drivers/usb/gadget/udc/core.c                 |  4 +-
 drivers/usb/host/xhci-mem.c                   | 17 ++--
 drivers/usb/host/xhci-mtk-sch.c               |  1 +
 drivers/usb/host/xhci.c                       |  7 +-
 drivers/usb/host/xhci.h                       |  5 +-
 drivers/usb/mtu3/mtu3_core.c                  |  2 +
 drivers/usb/mtu3/mtu3_gadget.c                |  1 +
 include/linux/usb.h                           |  2 +-
 include/linux/usb/ch9.h                       | 14 +--
 include/linux/usb/gadget.h                    |  8 +-
 include/uapi/linux/usb/ch9.h                  | 13 ++-
 sound/usb/card.c                              | 15 ++--
 sound/usb/helper.c                            |  1 +
 sound/usb/midi.c                              |  1 +
 tools/usb/testusb.c                           |  6 +-
 38 files changed, 258 insertions(+), 171 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 764d176e9735..b926e9dbdbb9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1298,6 +1298,7 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	 * force_poll_sync changes.
 	 */
 	switch (urb->dev->speed) {
+	case USB_SPEED_SUPER_PLUS_BY2:
 	case USB_SPEED_SUPER_PLUS:
 	case USB_SPEED_SUPER:	/* units are 125us */
 		data->intr_interval = usecs_to_jiffies(urb->interval * 125);
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 28dde08ec6c5..ede56f46881f 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1791,6 +1791,7 @@ u16 uvc_endpoint_max_bpi(struct usb_device *dev, struct usb_host_endpoint *ep)
 	switch (dev->speed) {
 	case USB_SPEED_SUPER:
 	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER_PLUS_BY2:
 		return le16_to_cpu(ep->ss_ep_comp.wBytesPerInterval);
 	default:
 		psize = usb_endpoint_maxp(&ep->desc);
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 0738baa5b82e..e993ca78df09 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -7066,6 +7066,7 @@ static void r8153_init(struct r8152 *tp)
 	switch (tp->udev->speed) {
 	case USB_SPEED_SUPER:
 	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER_PLUS_BY2:
 		tp->coalesce = COALESCE_SUPER;
 		break;
 	case USB_SPEED_HIGH:
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 2d14b0d78541..e9032c1cf66b 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -366,6 +366,7 @@ void usbnet_update_max_qlen(struct usbnet *dev)
 		break;
 	case USB_SPEED_SUPER:
 	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER_PLUS_BY2:
 		/*
 		 * Not take default 5ms qlen for super speed HC to
 		 * save memory, and iperf tests show 2.5ms qlen can
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 2178675ae1a4..43571daf3df0 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1427,14 +1427,19 @@ brcmf_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 
 	devinfo->ifnum = desc->bInterfaceNumber;
 
-	if (usb->speed == USB_SPEED_SUPER_PLUS)
-		brcmf_dbg(USB, "Broadcom super speed plus USB WLAN interface detected\n");
-	else if (usb->speed == USB_SPEED_SUPER)
-		brcmf_dbg(USB, "Broadcom super speed USB WLAN interface detected\n");
-	else if (usb->speed == USB_SPEED_HIGH)
-		brcmf_dbg(USB, "Broadcom high speed USB WLAN interface detected\n");
-	else
-		brcmf_dbg(USB, "Broadcom full speed USB WLAN interface detected\n");
+	switch (usb->speed) {
+	case USB_SPEED_SUPER_PLUS_BY2:
+	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER:
+	case USB_SPEED_HIGH:
+		brcmf_dbg(USB, "Broadcom %s USB WLAN interface detected\n",
+			  usb_speed_string(usb->speed));
+		break;
+	default:
+		brcmf_dbg(USB, "Broadcom %s USB WLAN interface detected\n",
+			  usb_speed_string(USB_SPEED_FULL));
+		break;
+	}
 
 	ret = brcmf_usb_probe_cb(devinfo, id->driver_info);
 	if (ret)
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index a296b87dced1..2f6d7fee17bd 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -977,7 +977,7 @@ static int tegra_xusb_usb3_port_parse_dt(struct tegra_xusb_usb3_port *usb3)
 		maximum_speed =  usb_get_maximum_speed(&port->dev);
 		if (maximum_speed == USB_SPEED_SUPER)
 			usb3->disable_gen2 = true;
-		else if (maximum_speed == USB_SPEED_SUPER_PLUS)
+		else if (maximum_speed >= USB_SPEED_SUPER_PLUS)
 			usb3->disable_gen2 = false;
 		else
 			return -EINVAL;
diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index fff9ec9c391f..f755b947d7d8 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1250,6 +1250,7 @@ static int cdnsp_run(struct cdnsp_device *pdev,
 	temp = readl(&pdev->port3x_regs->mode_addr);
 
 	switch (speed) {
+	case USB_SPEED_SUPER_PLUS_BY2:
 	case USB_SPEED_SUPER_PLUS:
 		temp |= CFG_3XPORT_SSP_SUPPORT;
 		break;
@@ -1745,6 +1746,7 @@ void cdnsp_irq_reset(struct cdnsp_device *pdev)
 	spin_lock(&pdev->lock);
 
 	switch (pdev->gadget.speed) {
+	case USB_SPEED_SUPER_PLUS_BY2:
 	case USB_SPEED_SUPER_PLUS:
 	case USB_SPEED_SUPER:
 		cdnsp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
@@ -1873,6 +1875,7 @@ static int __cdnsp_gadget_init(struct cdns *cdns)
 	case USB_SPEED_HIGH:
 	case USB_SPEED_SUPER:
 	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER_PLUS_BY2:
 		break;
 	default:
 		dev_err(cdns->dev, "invalid speed parameter %d\n", max_speed);
diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-mem.c
index 97866bfb2da9..9cf3516eb9ce 100644
--- a/drivers/usb/cdns3/cdnsp-mem.c
+++ b/drivers/usb/cdns3/cdnsp-mem.c
@@ -736,6 +736,7 @@ int cdnsp_setup_addressable_priv_dev(struct cdnsp_device *pdev)
 	slot_ctx->dev_info |= cpu_to_le32(LAST_CTX(1));
 
 	switch (pdev->gadget.speed) {
+	case USB_SPEED_SUPER_PLUS_BY2:
 	case USB_SPEED_SUPER_PLUS:
 		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_SSP);
 		max_packets = MAX_PACKET(512);
@@ -833,8 +834,9 @@ static unsigned int cdnsp_get_endpoint_interval(struct usb_gadget *g,
 
 	switch (g->speed) {
 	case USB_SPEED_HIGH:
-	case USB_SPEED_SUPER_PLUS:
 	case USB_SPEED_SUPER:
+	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER_PLUS_BY2:
 		if (usb_endpoint_xfer_int(pep->endpoint.desc) ||
 		    usb_endpoint_xfer_isoc(pep->endpoint.desc))
 			interval = cdnsp_parse_exponent_interval(g, pep);
diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index b84efae26e15..41bd032fc139 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -67,22 +67,35 @@ const char *usb_otg_state_string(enum usb_otg_state state)
 EXPORT_SYMBOL_GPL(usb_otg_state_string);
 
 static const char *const speed_names[] = {
-	[USB_SPEED_UNKNOWN] = "UNKNOWN",
+	[USB_SPEED_UNKNOWN] = "unknown-speed",
 	[USB_SPEED_LOW] = "low-speed",
 	[USB_SPEED_FULL] = "full-speed",
 	[USB_SPEED_HIGH] = "high-speed",
 	[USB_SPEED_WIRELESS] = "wireless",
 	[USB_SPEED_SUPER] = "super-speed",
 	[USB_SPEED_SUPER_PLUS] = "super-speed-plus",
+	[USB_SPEED_SUPER_PLUS_BY2] = "super-speed-plus-by2",
 };
 
-static const char *const ssp_rate[] = {
-	[USB_SSP_GEN_UNKNOWN] = "UNKNOWN",
+static const char *const ssp_gen_names[] = {
+	[USB_SSP_GEN_UNKNOWN] = "super-speed-plus-gen-unknown",
 	[USB_SSP_GEN_2x1] = "super-speed-plus-gen2x1",
 	[USB_SSP_GEN_1x2] = "super-speed-plus-gen1x2",
 	[USB_SSP_GEN_2x2] = "super-speed-plus-gen2x2",
 };
 
+/* Mbps */
+static const char *const speed_values[] = {
+	[USB_SPEED_UNKNOWN] = "unknown-value",
+	[USB_SPEED_LOW] = "1.5",
+	[USB_SPEED_FULL] = "12",
+	[USB_SPEED_HIGH] = "480",
+	[USB_SPEED_WIRELESS] = "480",
+	[USB_SPEED_SUPER] = "5000",
+	[USB_SPEED_SUPER_PLUS] = "10000",
+	[USB_SPEED_SUPER_PLUS_BY2] = "20000",
+};
+
 /**
  * usb_speed_string() - Returns human readable-name of the speed.
  * @speed: The speed to return human-readable name for.  If it's not
@@ -97,6 +110,56 @@ const char *usb_speed_string(enum usb_device_speed speed)
 }
 EXPORT_SYMBOL_GPL(usb_speed_string);
 
+/**
+ * usb_speed_value() - Returns human readable speed value.
+ * @speed: The speed to return human-readable value for. If it's not
+ *   any of the speeds defined in usb_device_speed enum, value for
+ *   USB_SPEED_UNKNOWN will be returned.
+ */
+const char *usb_speed_value(enum usb_device_speed speed)
+{
+	if (speed < 0 || speed >= ARRAY_SIZE(speed_values))
+		speed = USB_SPEED_UNKNOWN;
+	return speed_values[speed];
+}
+EXPORT_SYMBOL_GPL(usb_speed_value);
+
+/**
+ * usb_ssp_gen_name() - Returns human readable-name of ssp generation.
+ * @gen: The ssp generation to return human-readable name for. If it's
+ *   not any of the values defined in usb_ssp_gen enum, name for
+ *   USB_SSP_GEN_UNKNOWN will be returned.
+ */
+const char *usb_ssp_gen_name(enum usb_ssp_gen gen)
+{
+	if (gen < 0 || gen >= ARRAY_SIZE(ssp_gen_names))
+		gen = USB_SSP_GEN_UNKNOWN;
+	return ssp_gen_names[gen];
+}
+EXPORT_SYMBOL_GPL(usb_ssp_gen_name);
+
+/**
+ * usb_speed_from_name() - Returns usb_device_speed enum from human
+ * readable name.
+ * @speed_name: The speed name to return usb_device_speed enum for,
+ *   which can be defined in speed_names or ssp_gen_names. USB_SPEED_UNKNOWN
+ *   will be returned if the name can't be recognized.
+ */
+enum usb_device_speed usb_speed_from_name(const char *speed_name)
+{
+	int ret;
+
+	ret = match_string(ssp_gen_names, ARRAY_SIZE(ssp_gen_names), speed_name);
+	if (ret == USB_SSP_GEN_2x2)
+		return USB_SPEED_SUPER_PLUS_BY2;
+	else if (ret > 0)
+		return USB_SPEED_SUPER_PLUS;
+
+	ret = match_string(speed_names, ARRAY_SIZE(speed_names), speed_name);
+	return (ret < 0) ? USB_SPEED_UNKNOWN : ret;
+}
+EXPORT_SYMBOL_GPL(usb_speed_from_name);
+
 /**
  * usb_get_maximum_speed - Get maximum requested speed for a given USB
  * controller.
@@ -114,25 +177,21 @@ enum usb_device_speed usb_get_maximum_speed(struct device *dev)
 	if (ret < 0)
 		return USB_SPEED_UNKNOWN;
 
-	ret = match_string(ssp_rate, ARRAY_SIZE(ssp_rate), maximum_speed);
-	if (ret > 0)
-		return USB_SPEED_SUPER_PLUS;
+	return usb_speed_from_name(maximum_speed);
 
-	ret = match_string(speed_names, ARRAY_SIZE(speed_names), maximum_speed);
-	return (ret < 0) ? USB_SPEED_UNKNOWN : ret;
 }
 EXPORT_SYMBOL_GPL(usb_get_maximum_speed);
 
 /**
- * usb_get_maximum_ssp_rate - Get the signaling rate generation and lane count
+ * usb_get_maximum_ssp_gen - Get the SSP signaling generation and lane count
  *	of a SuperSpeed Plus capable device.
  * @dev: Pointer to the given USB controller device
  *
  * If the string from "maximum-speed" property is super-speed-plus-genXxY where
  * 'X' is the generation number and 'Y' is the number of lanes, then this
- * function returns the corresponding enum usb_ssp_rate.
+ * function returns the corresponding enum usb_ssp_gen.
  */
-enum usb_ssp_rate usb_get_maximum_ssp_rate(struct device *dev)
+enum usb_ssp_gen usb_get_maximum_ssp_gen(struct device *dev)
 {
 	const char *maximum_speed;
 	int ret;
@@ -141,10 +200,10 @@ enum usb_ssp_rate usb_get_maximum_ssp_rate(struct device *dev)
 	if (ret < 0)
 		return USB_SSP_GEN_UNKNOWN;
 
-	ret = match_string(ssp_rate, ARRAY_SIZE(ssp_rate), maximum_speed);
+	ret = match_string(ssp_gen_names, ARRAY_SIZE(ssp_gen_names), maximum_speed);
 	return (ret < 0) ? USB_SSP_GEN_UNKNOWN : ret;
 }
-EXPORT_SYMBOL_GPL(usb_get_maximum_ssp_rate);
+EXPORT_SYMBOL_GPL(usb_get_maximum_ssp_gen);
 
 /**
  * usb_state_string - Returns human readable name for the state.
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index b19e38d5fd10..71708ee7190c 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -323,6 +323,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	if (usb_endpoint_xfer_int(d)) {
 		i = 1;
 		switch (udev->speed) {
+		case USB_SPEED_SUPER_PLUS_BY2:
 		case USB_SPEED_SUPER_PLUS:
 		case USB_SPEED_SUPER:
 		case USB_SPEED_HIGH:
@@ -433,6 +434,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 		break;
 	case USB_SPEED_SUPER:
 	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER_PLUS_BY2:
 		maxpacket_maxes = super_speed_maxpacket_maxes;
 		break;
 	}
diff --git a/drivers/usb/core/devices.c b/drivers/usb/core/devices.c
index a247da73f34d..62ab4dfa9a51 100644
--- a/drivers/usb/core/devices.c
+++ b/drivers/usb/core/devices.c
@@ -395,7 +395,8 @@ static ssize_t usb_device_dump(char __user **buffer, size_t *nbytes,
 	int chix;
 	int ret, cnt = 0;
 	int parent_devnum = 0;
-	char *pages_start, *data_end, *speed;
+	char *pages_start, *data_end;
+	const char *speed;
 	unsigned int length;
 	ssize_t total_written = 0;
 	struct usb_device *childdev = NULL;
@@ -419,19 +420,16 @@ static ssize_t usb_device_dump(char __user **buffer, size_t *nbytes,
 	 * plugged into the root hub has a parent of 0.
 	 */
 	switch (usbdev->speed) {
-	case USB_SPEED_LOW:
-		speed = "1.5"; break;
 	case USB_SPEED_UNKNOWN:		/* usb 1.1 root hub code */
-	case USB_SPEED_FULL:
 		speed = "12"; break;
+	case USB_SPEED_LOW:
+	case USB_SPEED_FULL:
 	case USB_SPEED_HIGH:
-		speed = "480"; break;
 	case USB_SPEED_SUPER:
-		speed = "5000"; break;
 	case USB_SPEED_SUPER_PLUS:
-		speed = "10000"; break;
+	case USB_SPEED_SUPER_PLUS_BY2:
 	default:
-		speed = "??";
+		speed = usb_speed_value(usbdev->speed); break;
 	}
 	data_end = pages_start + sprintf(pages_start, format_topo,
 			bus->busnum, level, parent_devnum,
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 12b6dfeaf658..315bb6887a06 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2865,7 +2865,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 
 	rhdev->rx_lanes = 1;
 	rhdev->tx_lanes = 1;
-	rhdev->ssp_rate = USB_SSP_GEN_UNKNOWN;
+	rhdev->ssp_gen = USB_SSP_GEN_UNKNOWN;
 
 	switch (hcd->speed) {
 	case HCD_USB11:
@@ -2880,11 +2880,11 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	case HCD_USB32:
 		rhdev->rx_lanes = 2;
 		rhdev->tx_lanes = 2;
-		rhdev->ssp_rate = USB_SSP_GEN_2x2;
-		rhdev->speed = USB_SPEED_SUPER_PLUS;
+		rhdev->ssp_gen = USB_SSP_GEN_2x2;
+		rhdev->speed = USB_SPEED_SUPER_PLUS_BY2;
 		break;
 	case HCD_USB31:
-		rhdev->ssp_rate = USB_SSP_GEN_2x1;
+		rhdev->ssp_gen = USB_SSP_GEN_2x1;
 		rhdev->speed = USB_SPEED_SUPER_PLUS;
 		break;
 	default:
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 3c54b218301c..76eb864f939c 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2693,16 +2693,16 @@ int usb_authorize_device(struct usb_device *usb_dev)
 }
 
 /**
- * get_port_ssp_rate - Match the extended port status to SSP rate
+ * get_port_ssp_gen - Match the extended port status to SSP generation
  * @hdev: The hub device
  * @ext_portstatus: extended port status
  *
  * Match the extended port status speed id to the SuperSpeed Plus sublink speed
  * capability attributes. Base on the number of connected lanes and speed,
- * return the corresponding enum usb_ssp_rate.
+ * return the corresponding enum usb_ssp_gen.
  */
-static enum usb_ssp_rate get_port_ssp_rate(struct usb_device *hdev,
-					   u32 ext_portstatus)
+static enum usb_ssp_gen get_port_ssp_gen(struct usb_device *hdev,
+					  u32 ext_portstatus)
 {
 	struct usb_ssp_cap_descriptor *ssp_cap = hdev->bos->ssp_cap;
 	u32 attr;
@@ -2913,13 +2913,15 @@ static int hub_port_wait_reset(struct usb_hub *hub, int port1,
 		/* extended portstatus Rx and Tx lane count are zero based */
 		udev->rx_lanes = USB_EXT_PORT_RX_LANES(ext_portstatus) + 1;
 		udev->tx_lanes = USB_EXT_PORT_TX_LANES(ext_portstatus) + 1;
-		udev->ssp_rate = get_port_ssp_rate(hub->hdev, ext_portstatus);
+		udev->ssp_gen = get_port_ssp_gen(hub->hdev, ext_portstatus);
 	} else {
 		udev->rx_lanes = 1;
 		udev->tx_lanes = 1;
-		udev->ssp_rate = USB_SSP_GEN_UNKNOWN;
+		udev->ssp_gen = USB_SSP_GEN_UNKNOWN;
 	}
-	if (udev->ssp_rate != USB_SSP_GEN_UNKNOWN)
+	if (udev->ssp_gen == USB_SSP_GEN_2x2)
+		udev->speed = USB_SPEED_SUPER_PLUS_BY2;
+	else if (udev->ssp_gen != USB_SSP_GEN_UNKNOWN)
 		udev->speed = USB_SPEED_SUPER_PLUS;
 	else if (hub_is_superspeed(hub->hdev))
 		udev->speed = USB_SPEED_SUPER;
@@ -4830,6 +4832,7 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 		 * it's fixed size except for full speed devices.
 		 */
 		switch (udev->speed) {
+		case USB_SPEED_SUPER_PLUS_BY2:
 		case USB_SPEED_SUPER_PLUS:
 		case USB_SPEED_SUPER:
 			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(512);
@@ -4960,16 +4963,11 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 		if (udev->speed >= USB_SPEED_SUPER) {
 			devnum = udev->devnum;
 			dev_info(&udev->dev,
-					"%s SuperSpeed%s%s USB device number %d using %s\n",
-					(udev->config) ? "reset" : "new",
-				 (udev->speed == USB_SPEED_SUPER_PLUS) ?
-						" Plus" : "",
-				 (udev->ssp_rate == USB_SSP_GEN_2x2) ?
-						" Gen 2x2" :
-				 (udev->ssp_rate == USB_SSP_GEN_2x1) ?
-						" Gen 2x1" :
-				 (udev->ssp_rate == USB_SSP_GEN_1x2) ?
-						" Gen 1x2" : "",
+				 "%s %s USB device number %d using %s\n",
+				 (udev->config) ? "reset" : "new",
+				 (udev->speed == USB_SPEED_SUPER) ?
+					usb_speed_string(USB_SPEED_SUPER) :
+					usb_ssp_gen_name(udev->ssp_gen),
 				 devnum, driver_name);
 		}
 
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index 5d21718afb05..121c94fd3599 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -146,32 +146,21 @@ static ssize_t speed_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct usb_device *udev;
-	char *speed;
+	const char *speed;
 
 	udev = to_usb_device(dev);
 
 	switch (udev->speed) {
-	case USB_SPEED_LOW:
-		speed = "1.5";
-		break;
 	case USB_SPEED_UNKNOWN:
+		speed = "12"; break;
+	case USB_SPEED_LOW:
 	case USB_SPEED_FULL:
-		speed = "12";
-		break;
 	case USB_SPEED_HIGH:
-		speed = "480";
-		break;
 	case USB_SPEED_SUPER:
-		speed = "5000";
-		break;
 	case USB_SPEED_SUPER_PLUS:
-		if (udev->ssp_rate == USB_SSP_GEN_2x2)
-			speed = "20000";
-		else
-			speed = "10000";
-		break;
+	case USB_SPEED_SUPER_PLUS_BY2:
 	default:
-		speed = "unknown";
+		speed = usb_speed_value(udev->speed); break;
 	}
 	return sysfs_emit(buf, "%s\n", speed);
 }
@@ -656,8 +645,7 @@ static int add_power_attributes(struct device *dev)
 		if (udev->usb2_hw_lpm_capable == 1)
 			rc = sysfs_merge_group(&dev->kobj,
 					&usb2_hardware_lpm_attr_group);
-		if ((udev->speed == USB_SPEED_SUPER ||
-		     udev->speed == USB_SPEED_SUPER_PLUS) &&
+		if (udev->speed >= USB_SPEED_SUPER &&
 				udev->lpm_capable == 1)
 			rc = sysfs_merge_group(&dev->kobj,
 					&usb3_hardware_lpm_attr_group);
diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 7576920e2d5a..d90df1ca050c 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -459,7 +459,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 			max *= mult;
 		}
 
-		if (dev->speed == USB_SPEED_SUPER_PLUS &&
+		if (dev->speed >= USB_SPEED_SUPER_PLUS &&
 		    USB_SS_SSP_ISOC_COMP(ep->ss_ep_comp.bmAttributes)) {
 			struct usb_ssp_isoc_ep_comp_descriptor *isoc_ep_comp;
 
@@ -544,6 +544,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 
 		/* too big? */
 		switch (dev->speed) {
+		case USB_SPEED_SUPER_PLUS_BY2:
 		case USB_SPEED_SUPER_PLUS:
 		case USB_SPEED_SUPER:	/* units are 125us */
 			/* Handle up to 2^(16-1) microframes */
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9c6bf054f15d..70ac85ad192d 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1408,7 +1408,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	tx_fifo_resize_max_num = 6;
 
 	dwc->maximum_speed = usb_get_maximum_speed(dev);
-	dwc->max_ssp_rate = usb_get_maximum_ssp_rate(dev);
+	dwc->max_ssp_gen = usb_get_maximum_ssp_gen(dev);
 	dwc->dr_mode = usb_get_dr_mode(dev);
 	dwc->hsphy_mode = of_usb_get_phy_mode(dev->of_node);
 
@@ -1575,6 +1575,7 @@ static void dwc3_check_params(struct dwc3 *dwc)
 			dev_warn(dev, "UDC doesn't support Gen 1\n");
 		break;
 	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER_PLUS_BY2:
 		if ((DWC3_IP_IS(DWC32) &&
 		     hwparam_gen == DWC3_GHWPARAMS3_SSPHY_IFC_DIS) ||
 		    (!DWC3_IP_IS(DWC32) &&
@@ -1613,8 +1614,8 @@ static void dwc3_check_params(struct dwc3 *dwc)
 	 * set the default to support dual-lane for DWC_usb32 and single-lane
 	 * for DWC_usb31 for super-speed-plus.
 	 */
-	if (dwc->maximum_speed == USB_SPEED_SUPER_PLUS) {
-		switch (dwc->max_ssp_rate) {
+	if (dwc->maximum_speed >= USB_SPEED_SUPER_PLUS) {
+		switch (dwc->max_ssp_gen) {
 		case USB_SSP_GEN_2x1:
 			if (hwparam_gen == DWC3_GHWPARAMS3_SSPHY_IFC_GEN1)
 				dev_warn(dev, "UDC only supports Gen 1\n");
@@ -1628,14 +1629,15 @@ static void dwc3_check_params(struct dwc3 *dwc)
 		default:
 			switch (hwparam_gen) {
 			case DWC3_GHWPARAMS3_SSPHY_IFC_GEN2:
-				if (DWC3_IP_IS(DWC32))
-					dwc->max_ssp_rate = USB_SSP_GEN_2x2;
-				else
-					dwc->max_ssp_rate = USB_SSP_GEN_2x1;
+				if (DWC3_IP_IS(DWC32)) {
+					dwc->max_ssp_gen = USB_SSP_GEN_2x2;
+					dwc->maximum_speed = USB_SPEED_SUPER_PLUS_BY2;
+				} else
+					dwc->max_ssp_gen = USB_SSP_GEN_2x1;
 				break;
 			case DWC3_GHWPARAMS3_SSPHY_IFC_GEN1:
 				if (DWC3_IP_IS(DWC32))
-					dwc->max_ssp_rate = USB_SSP_GEN_1x2;
+					dwc->max_ssp_gen = USB_SSP_GEN_1x2;
 				break;
 			}
 			break;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index a69ac67d89fe..414be70633df 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1194,8 +1194,8 @@ struct dwc3 {
 	u32			u1u2;
 	u32			maximum_speed;
 	u32			gadget_max_speed;
-	enum usb_ssp_rate	max_ssp_rate;
-	enum usb_ssp_rate	gadget_ssp_rate;
+	enum usb_ssp_gen	max_ssp_gen;
+	enum usb_ssp_gen	gadget_ssp_gen;
 
 	u32			ip;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 858fe4c299b7..a9998ea731b8 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2498,23 +2498,23 @@ static void dwc3_stop_active_transfers(struct dwc3 *dwc)
 
 static void __dwc3_gadget_set_ssp_rate(struct dwc3 *dwc)
 {
-	enum usb_ssp_rate	ssp_rate = dwc->gadget_ssp_rate;
+	enum usb_ssp_gen	ssp_gen = dwc->gadget_ssp_gen;
 	u32			reg;
 
-	if (ssp_rate == USB_SSP_GEN_UNKNOWN)
-		ssp_rate = dwc->max_ssp_rate;
+	if (ssp_gen == USB_SSP_GEN_UNKNOWN)
+		ssp_gen = dwc->max_ssp_gen;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
 	reg &= ~DWC3_DCFG_SPEED_MASK;
 	reg &= ~DWC3_DCFG_NUMLANES(~0);
 
-	if (ssp_rate == USB_SSP_GEN_1x2)
+	if (ssp_gen == USB_SSP_GEN_1x2)
 		reg |= DWC3_DCFG_SUPERSPEED;
-	else if (dwc->max_ssp_rate != USB_SSP_GEN_1x2)
+	else if (dwc->max_ssp_gen != USB_SSP_GEN_1x2)
 		reg |= DWC3_DCFG_SUPERSPEED_PLUS;
 
-	if (ssp_rate != USB_SSP_GEN_2x1 &&
-	    dwc->max_ssp_rate != USB_SSP_GEN_2x1)
+	if (ssp_gen != USB_SSP_GEN_2x1 &&
+	    dwc->max_ssp_gen != USB_SSP_GEN_2x1)
 		reg |= DWC3_DCFG_NUMLANES(1);
 
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
@@ -2529,7 +2529,7 @@ static void __dwc3_gadget_set_speed(struct dwc3 *dwc)
 	if (speed == USB_SPEED_UNKNOWN || speed > dwc->maximum_speed)
 		speed = dwc->maximum_speed;
 
-	if (speed == USB_SPEED_SUPER_PLUS &&
+	if (speed >= USB_SPEED_SUPER_PLUS &&
 	    DWC3_IP_IS(DWC32)) {
 		__dwc3_gadget_set_ssp_rate(dwc);
 		return;
@@ -2566,6 +2566,7 @@ static void __dwc3_gadget_set_speed(struct dwc3 *dwc)
 			reg |= DWC3_DCFG_SUPERSPEED;
 			break;
 		case USB_SPEED_SUPER_PLUS:
+		case USB_SPEED_SUPER_PLUS_BY2:
 			if (DWC3_IP_IS(DWC3))
 				reg |= DWC3_DCFG_SUPERSPEED;
 			else
@@ -3028,15 +3029,22 @@ static void dwc3_gadget_set_speed(struct usb_gadget *g,
 	spin_unlock_irqrestore(&dwc->lock, flags);
 }
 
-static void dwc3_gadget_set_ssp_rate(struct usb_gadget *g,
-				     enum usb_ssp_rate rate)
+static void dwc3_gadget_set_ssp_gen(struct usb_gadget *g,
+				    enum usb_ssp_gen gen)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
 	unsigned long		flags;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dwc->gadget_max_speed = USB_SPEED_SUPER_PLUS;
-	dwc->gadget_ssp_rate = rate;
+	switch (gen) {
+	case USB_SSP_GEN_2x2:
+		dwc->gadget_max_speed = USB_SPEED_SUPER_PLUS_BY2;
+		break;
+	default:
+		dwc->gadget_max_speed = USB_SPEED_SUPER_PLUS;
+		break;
+	}
+	dwc->gadget_ssp_gen = gen;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 }
 
@@ -3123,7 +3131,7 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.udc_start		= dwc3_gadget_start,
 	.udc_stop		= dwc3_gadget_stop,
 	.udc_set_speed		= dwc3_gadget_set_speed,
-	.udc_set_ssp_rate	= dwc3_gadget_set_ssp_rate,
+	.udc_set_ssp_gen	= dwc3_gadget_set_ssp_gen,
 	.get_config_params	= dwc3_gadget_config_params,
 	.vbus_draw		= dwc3_gadget_vbus_draw,
 	.check_config		= dwc3_gadget_check_config,
@@ -4071,7 +4079,7 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	if (DWC3_IP_IS(DWC32))
 		lanes = DWC3_DSTS_CONNLANES(reg) + 1;
 
-	dwc->gadget->ssp_rate = USB_SSP_GEN_UNKNOWN;
+	dwc->gadget->ssp_gen = USB_SSP_GEN_UNKNOWN;
 
 	/*
 	 * RAMClkSel is reset to 0 after USB reset, so it must be reprogrammed
@@ -4086,12 +4094,14 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	case DWC3_DSTS_SUPERSPEED_PLUS:
 		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 		dwc->gadget->ep0->maxpacket = 512;
-		dwc->gadget->speed = USB_SPEED_SUPER_PLUS;
 
-		if (lanes > 1)
-			dwc->gadget->ssp_rate = USB_SSP_GEN_2x2;
-		else
-			dwc->gadget->ssp_rate = USB_SSP_GEN_2x1;
+		if (lanes > 1) {
+			dwc->gadget->ssp_gen = USB_SSP_GEN_2x2;
+			dwc->gadget->speed = USB_SPEED_SUPER_PLUS_BY2;
+		} else {
+			dwc->gadget->ssp_gen = USB_SSP_GEN_2x1;
+			dwc->gadget->speed = USB_SPEED_SUPER_PLUS;
+		}
 		break;
 	case DWC3_DSTS_SUPERSPEED:
 		/*
@@ -4116,7 +4126,7 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 
 		if (lanes > 1) {
 			dwc->gadget->speed = USB_SPEED_SUPER_PLUS;
-			dwc->gadget->ssp_rate = USB_SSP_GEN_1x2;
+			dwc->gadget->ssp_gen = USB_SSP_GEN_1x2;
 		}
 		break;
 	case DWC3_DSTS_HIGHSPEED:
@@ -4592,7 +4602,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	dev->platform_data		= dwc;
 	dwc->gadget->ops		= &dwc3_gadget_ops;
 	dwc->gadget->speed		= USB_SPEED_UNKNOWN;
-	dwc->gadget->ssp_rate		= USB_SSP_GEN_UNKNOWN;
+	dwc->gadget->ssp_gen		= USB_SSP_GEN_UNKNOWN;
 	dwc->gadget->sg_supported	= true;
 	dwc->gadget->name		= "dwc3-gadget";
 	dwc->gadget->lpm_capable	= !dwc->usb2_gadget_lpm_disable;
@@ -4620,7 +4630,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 				dwc->revision);
 
 	dwc->gadget->max_speed		= dwc->maximum_speed;
-	dwc->gadget->max_ssp_rate	= dwc->max_ssp_rate;
+	dwc->gadget->max_ssp_gen	= dwc->max_ssp_gen;
 
 	/*
 	 * REVISIT: Here we should clear all pending IRQs to be
@@ -4637,8 +4647,8 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err5;
 	}
 
-	if (DWC3_IP_IS(DWC32) && dwc->maximum_speed == USB_SPEED_SUPER_PLUS)
-		dwc3_gadget_set_ssp_rate(dwc->gadget, dwc->max_ssp_rate);
+	if (DWC3_IP_IS(DWC32) && dwc->maximum_speed >= USB_SPEED_SUPER_PLUS)
+		dwc3_gadget_set_ssp_gen(dwc->gadget, dwc->max_ssp_gen);
 	else
 		dwc3_gadget_set_speed(dwc->gadget, dwc->maximum_speed);
 
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 0ace45b66a31..17f3b5e968a7 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -71,6 +71,7 @@ function_descriptors(struct usb_function *f,
 	 */
 
 	switch (speed) {
+	case USB_SPEED_SUPER_PLUS_BY2:
 	case USB_SPEED_SUPER_PLUS:
 		descriptors = f->ssp_descriptors;
 		if (descriptors)
@@ -169,6 +170,7 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g,
 
 	/* select desired speed */
 	switch (g->speed) {
+	case USB_SPEED_SUPER_PLUS_BY2:
 	case USB_SPEED_SUPER_PLUS:
 		if (f->ssp_descriptors) {
 			speed_desc = f->ssp_descriptors;
@@ -650,6 +652,7 @@ static int config_desc(struct usb_composite_dev *cdev, unsigned w_value)
 check_config:
 		/* ignore configs that won't work at this speed */
 		switch (speed) {
+		case USB_SPEED_SUPER_PLUS_BY2:
 		case USB_SPEED_SUPER_PLUS:
 			if (!c->superspeed_plus)
 				continue;
@@ -688,8 +691,9 @@ static int count_configs(struct usb_composite_dev *cdev, unsigned type)
 			hs = 1;
 		if (gadget->speed == USB_SPEED_SUPER)
 			ss = 1;
-		if (gadget->speed == USB_SPEED_SUPER_PLUS)
+		if (gadget->speed >= USB_SPEED_SUPER_PLUS)
 			ssp = 1;
+
 		if (type == USB_DT_DEVICE_QUALIFIER)
 			hs = !hs;
 	}
@@ -803,7 +807,7 @@ static int bos_desc(struct usb_composite_dev *cdev)
 		u8 ssic;
 		int i;
 
-		if (cdev->gadget->max_ssp_rate == USB_SSP_GEN_2x2)
+		if (cdev->gadget->max_ssp_gen == USB_SSP_GEN_2x2)
 			ssac = 3;
 
 		/*
@@ -850,8 +854,8 @@ static int bos_desc(struct usb_composite_dev *cdev)
 
 			ssid = i >> 1;
 
-			if (cdev->gadget->max_ssp_rate == USB_SSP_GEN_2x1 ||
-			    cdev->gadget->max_ssp_rate == USB_SSP_GEN_UNKNOWN)
+			if (cdev->gadget->max_ssp_gen == USB_SSP_GEN_2x1 ||
+			    cdev->gadget->max_ssp_gen == USB_SSP_GEN_UNKNOWN)
 				mantissa = 10;
 			else
 				mantissa = 5 << ssid;
diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 4c639e9ddedc..e85853bdacf7 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -327,18 +327,18 @@ static ssize_t gadget_dev_desc_max_speed_store(struct config_item *item,
 	if (gi->composite.gadget_driver.udc_name)
 		goto err;
 
-	if (strncmp(page, "super-speed-plus", 16) == 0)
-		gi->composite.max_speed = USB_SPEED_SUPER_PLUS;
-	else if (strncmp(page, "super-speed", 11) == 0)
-		gi->composite.max_speed = USB_SPEED_SUPER;
-	else if (strncmp(page, "high-speed", 10) == 0)
-		gi->composite.max_speed = USB_SPEED_HIGH;
-	else if (strncmp(page, "full-speed", 10) == 0)
-		gi->composite.max_speed = USB_SPEED_FULL;
-	else if (strncmp(page, "low-speed", 9) == 0)
-		gi->composite.max_speed = USB_SPEED_LOW;
-	else
+	gi->composite.max_speed = usb_speed_from_name(page);
+	switch (gi->composite.max_speed) {
+	case USB_SPEED_SUPER_PLUS_BY2:
+	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER:
+	case USB_SPEED_HIGH:
+	case USB_SPEED_FULL:
+	case USB_SPEED_LOW:
+		break;
+	default:
 		goto err;
+	}
 
 	gi->composite.gadget_driver.max_speed = gi->composite.max_speed;
 
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index f41a385a5c42..56e7b924f3c9 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1321,6 +1321,7 @@ static long ffs_epfile_ioctl(struct file *file, unsigned code,
 		switch (epfile->ffs->gadget->speed) {
 		case USB_SPEED_SUPER:
 		case USB_SPEED_SUPER_PLUS:
+		case USB_SPEED_SUPER_PLUS_BY2:
 			desc_idx = 2;
 			break;
 		case USB_SPEED_HIGH:
diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/gadget/function/f_sourcesink.c
index 2edbd9b510d6..e9bc2b9a1542 100644
--- a/drivers/usb/gadget/function/f_sourcesink.c
+++ b/drivers/usb/gadget/function/f_sourcesink.c
@@ -582,6 +582,7 @@ static int source_sink_start_ep(struct f_sourcesink *ss, bool is_in,
 
 	if (is_iso) {
 		switch (speed) {
+		case USB_SPEED_SUPER_PLUS_BY2:
 		case USB_SPEED_SUPER_PLUS:
 		case USB_SPEED_SUPER:
 			size = ss->isoc_maxpacket *
diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 0219cd79493a..0937f55c9c88 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -124,16 +124,6 @@ static struct usb_string strings_fn[] = {
 	{ },
 };
 
-static const char *const speed_names[] = {
-	[USB_SPEED_UNKNOWN] = "UNKNOWN",
-	[USB_SPEED_LOW] = "LS",
-	[USB_SPEED_FULL] = "FS",
-	[USB_SPEED_HIGH] = "HS",
-	[USB_SPEED_WIRELESS] = "W",
-	[USB_SPEED_SUPER] = "SS",
-	[USB_SPEED_SUPER_PLUS] = "SS+",
-};
-
 static struct usb_gadget_strings str_fn = {
 	.language = 0x0409,	/* en-us */
 	.strings = strings_fn,
@@ -763,11 +753,11 @@ static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac2_o
 	if (max_size_bw <= max_size_ep)
 		dev_dbg(dev,
 			"%s %s: Would use wMaxPacketSize %d and bInterval %d\n",
-			speed_names[speed], dir, max_size_bw, bint);
+			usb_speed_string(speed), dir, max_size_bw, bint);
 	else {
 		dev_warn(dev,
 			"%s %s: Req. wMaxPacketSize %d at bInterval %d > max ISOC %d, may drop data!\n",
-			speed_names[speed], dir, max_size_bw, bint, max_size_ep);
+			usb_speed_string(speed), dir, max_size_bw, bint, max_size_ep);
 		max_size_bw = max_size_ep;
 	}
 
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 7166d1117742..93773f60939b 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1266,8 +1266,8 @@ static inline void usb_gadget_udc_set_speed(struct usb_udc *udc,
 	else
 		s = min(speed, gadget->max_speed);
 
-	if (s == USB_SPEED_SUPER_PLUS && gadget->ops->udc_set_ssp_rate)
-		gadget->ops->udc_set_ssp_rate(gadget, gadget->max_ssp_rate);
+	if (s >= USB_SPEED_SUPER_PLUS && gadget->ops->udc_set_ssp_gen)
+		gadget->ops->udc_set_ssp_gen(gadget, gadget->max_ssp_gen);
 	else if (gadget->ops->udc_set_speed)
 		gadget->ops->udc_set_speed(gadget, s);
 }
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 8714ab5bf04d..e26384b24aa6 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1087,25 +1087,31 @@ int xhci_setup_addressable_virt_dev(struct xhci_hcd *xhci, struct usb_device *ud
 	/* 3) Only the control endpoint is valid - one endpoint context */
 	slot_ctx->dev_info |= cpu_to_le32(LAST_CTX(1) | udev->route);
 	switch (udev->speed) {
+	case USB_SPEED_SUPER_PLUS_BY2:
 	case USB_SPEED_SUPER_PLUS:
-		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_SSP);
+		slot_ctx->dev_info |= (xhci->hci_version < 0x120) ?
+					cpu_to_le32(SLOT_SPEED_SSP) : 0;
 		max_packets = MAX_PACKET(512);
 		break;
 	case USB_SPEED_SUPER:
-		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_SS);
+		slot_ctx->dev_info |= (xhci->hci_version < 0x120) ?
+					cpu_to_le32(SLOT_SPEED_SS) : 0;
 		max_packets = MAX_PACKET(512);
 		break;
 	case USB_SPEED_HIGH:
-		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_HS);
+		slot_ctx->dev_info |= (xhci->hci_version < 0x120) ?
+					cpu_to_le32(SLOT_SPEED_HS) : 0;
 		max_packets = MAX_PACKET(64);
 		break;
 	/* USB core guesses at a 64-byte max packet first for FS devices */
 	case USB_SPEED_FULL:
-		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_FS);
+		slot_ctx->dev_info |= (xhci->hci_version < 0x120) ?
+					cpu_to_le32(SLOT_SPEED_FS) : 0;
 		max_packets = MAX_PACKET(64);
 		break;
 	case USB_SPEED_LOW:
-		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_LS);
+		slot_ctx->dev_info |= (xhci->hci_version < 0x120) ?
+					cpu_to_le32(SLOT_SPEED_LS) : 0;
 		max_packets = MAX_PACKET(8);
 		break;
 	default:
@@ -1276,6 +1282,7 @@ static unsigned int xhci_get_endpoint_interval(struct usb_device *udev,
 		}
 		fallthrough;	/* SS and HS isoc/int have same decoding */
 
+	case USB_SPEED_SUPER_PLUS_BY2:
 	case USB_SPEED_SUPER_PLUS:
 	case USB_SPEED_SUPER:
 		if (usb_endpoint_xfer_int(&ep->desc) ||
diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 579899eb24c1..97318537612a 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -89,6 +89,7 @@ static u32 get_bw_boundary(enum usb_device_speed speed)
 	u32 boundary;
 
 	switch (speed) {
+	case USB_SPEED_SUPER_PLUS_BY2:
 	case USB_SPEED_SUPER_PLUS:
 		boundary = SSP_BW_BOUNDARY;
 		break;
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index e1b1b64a0723..5483920a6ce9 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -2192,6 +2192,7 @@ static unsigned int xhci_get_block_size(struct usb_device *udev)
 		return HS_BLOCK;
 	case USB_SPEED_SUPER:
 	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER_PLUS_BY2:
 		return SS_BLOCK;
 	case USB_SPEED_UNKNOWN:
 	default:
@@ -5102,15 +5103,15 @@ static void xhci_hcd_init_usb3_data(struct xhci_hcd *xhci, struct usb_hcd *hcd)
 	switch (minor_rev) {
 	case 2:
 		hcd->speed = HCD_USB32;
-		hcd->self.root_hub->speed = USB_SPEED_SUPER_PLUS;
+		hcd->self.root_hub->speed = USB_SPEED_SUPER_PLUS_BY2;
 		hcd->self.root_hub->rx_lanes = 2;
 		hcd->self.root_hub->tx_lanes = 2;
-		hcd->self.root_hub->ssp_rate = USB_SSP_GEN_2x2;
+		hcd->self.root_hub->ssp_gen = USB_SSP_GEN_2x2;
 		break;
 	case 1:
 		hcd->speed = HCD_USB31;
 		hcd->self.root_hub->speed = USB_SPEED_SUPER_PLUS;
-		hcd->self.root_hub->ssp_rate = USB_SSP_GEN_2x1;
+		hcd->self.root_hub->ssp_gen = USB_SSP_GEN_2x1;
 		break;
 	}
 	xhci_info(xhci, "Host supports USB 3.%x %sSuperSpeed\n",
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 7e282b4522c0..ec507770a559 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -345,7 +345,10 @@ struct xhci_op_regs {
 #define DEV_SUPERSPEED_ANY(p)	(((p) & DEV_SPEED_MASK) >= XDEV_SS)
 #define DEV_PORT_SPEED(p)	(((p) >> 10) & 0x0f)
 
-/* Bits 20:23 in the Slot Context are the speed for the device */
+/* Bits 20:23 in the Slot Context are the speed for the device.
+ * This field has been deprecated since xHCI spec revision 1.2
+ * and shall be reserved.
+ */
 #define	SLOT_SPEED_FS		(XDEV_FS << 10)
 #define	SLOT_SPEED_LS		(XDEV_LS << 10)
 #define	SLOT_SPEED_HS		(XDEV_HS << 10)
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index a3a6282893d0..346df653a1e4 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -254,6 +254,7 @@ static void mtu3_set_speed(struct mtu3 *mtu, enum usb_device_speed speed)
 			     SSUSB_U3_PORT_SSP_SPEED);
 		break;
 	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER_PLUS_BY2:
 		mtu3_setbits(mbase, U3D_POWER_MANAGEMENT, HS_ENABLE);
 		mtu3_setbits(mtu->ippc_base, SSUSB_U3_CTRL(0),
 			     SSUSB_U3_PORT_SSP_SPEED);
@@ -831,6 +832,7 @@ static void mtu3_check_params(struct mtu3 *mtu)
 	case USB_SPEED_HIGH:
 	case USB_SPEED_SUPER:
 	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER_PLUS_BY2:
 		break;
 	default:
 		dev_err(mtu->dev, "invalid max_speed: %s\n",
diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index ad0eeac4332d..1545d139907c 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -74,6 +74,7 @@ static int mtu3_ep_enable(struct mtu3_ep *mep)
 	switch (mtu->g.speed) {
 	case USB_SPEED_SUPER:
 	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER_PLUS_BY2:
 		if (usb_endpoint_xfer_int(desc) ||
 				usb_endpoint_xfer_isoc(desc)) {
 			interval = desc->bInterval;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index a21074861f91..af8674d95820 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -657,7 +657,7 @@ struct usb_device {
 	enum usb_device_speed	speed;
 	unsigned int		rx_lanes;
 	unsigned int		tx_lanes;
-	enum usb_ssp_rate	ssp_rate;
+	enum usb_ssp_gen	ssp_gen;
 
 	struct usb_tt	*tt;
 	int		ttport;
diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index c93b410b314a..bf9d66399d46 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -32,21 +32,15 @@
 
 #include <uapi/linux/usb/ch9.h>
 
-/* USB 3.2 SuperSpeed Plus phy signaling rate generation and lane count */
-
-enum usb_ssp_rate {
-	USB_SSP_GEN_UNKNOWN = 0,
-	USB_SSP_GEN_2x1,
-	USB_SSP_GEN_1x2,
-	USB_SSP_GEN_2x2,
-};
-
 struct device;
 
 extern const char *usb_ep_type_string(int ep_type);
 extern const char *usb_speed_string(enum usb_device_speed speed);
+extern const char *usb_speed_value(enum usb_device_speed speed);
+extern const char *usb_ssp_gen_name(enum usb_ssp_gen gen);
+extern enum usb_device_speed usb_speed_from_name(const char *speed_name);
 extern enum usb_device_speed usb_get_maximum_speed(struct device *dev);
-extern enum usb_ssp_rate usb_get_maximum_ssp_rate(struct device *dev);
+extern enum usb_ssp_gen usb_get_maximum_ssp_gen(struct device *dev);
 extern const char *usb_state_string(enum usb_device_state state);
 unsigned int usb_decode_interval(const struct usb_endpoint_descriptor *epd,
 				 enum usb_device_speed speed);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 75bda0783395..6f8040e3e29b 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -324,8 +324,8 @@ struct usb_gadget_ops {
 			struct usb_gadget_driver *);
 	int	(*udc_stop)(struct usb_gadget *);
 	void	(*udc_set_speed)(struct usb_gadget *, enum usb_device_speed);
-	void	(*udc_set_ssp_rate)(struct usb_gadget *gadget,
-			enum usb_ssp_rate rate);
+	void	(*udc_set_ssp_gen)(struct usb_gadget *gadget,
+			enum usb_ssp_gen gen);
 	void	(*udc_async_callbacks)(struct usb_gadget *gadget, bool enable);
 	struct usb_ep *(*match_ep)(struct usb_gadget *,
 			struct usb_endpoint_descriptor *,
@@ -420,8 +420,8 @@ struct usb_gadget {
 	enum usb_device_speed		max_speed;
 
 	/* USB SuperSpeed Plus only */
-	enum usb_ssp_rate		ssp_rate;
-	enum usb_ssp_rate		max_ssp_rate;
+	enum usb_ssp_gen		ssp_gen;
+	enum usb_ssp_gen		max_ssp_gen;
 
 	enum usb_device_state		state;
 	const char			*name;
diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
index 8a147abfc680..3522e2c20599 100644
--- a/include/uapi/linux/usb/ch9.h
+++ b/include/uapi/linux/usb/ch9.h
@@ -1181,10 +1181,19 @@ enum usb_device_speed {
 	USB_SPEED_LOW, USB_SPEED_FULL,		/* usb 1.1 */
 	USB_SPEED_HIGH,				/* usb 2.0 */
 	USB_SPEED_WIRELESS,			/* wireless (usb 2.5) */
-	USB_SPEED_SUPER,			/* usb 3.0 */
-	USB_SPEED_SUPER_PLUS,			/* usb 3.1 */
+	USB_SPEED_SUPER,			/* usb 3.0 5Gbps */
+	USB_SPEED_SUPER_PLUS,			/* usb 3.1 10Gbps */
+	USB_SPEED_SUPER_PLUS_BY2,		/* usb 3.2 20Gbps */
 };
 
+/* USB 3.2 SuperSpeed Plus phy signaling generation and lane count */
+
+enum usb_ssp_gen {
+	USB_SSP_GEN_UNKNOWN = 0,
+	USB_SSP_GEN_2x1,
+	USB_SSP_GEN_1x2,
+	USB_SSP_GEN_2x2,
+};
 
 enum usb_device_state {
 	/* NOTATTACHED isn't in the USB spec, and this state acts
diff --git a/sound/usb/card.c b/sound/usb/card.c
index 1b2edc0fd2e9..13c7da24571b 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -571,19 +571,15 @@ static void usb_audio_make_longname(struct usb_device *dev,
 
 	switch (snd_usb_get_speed(dev)) {
 	case USB_SPEED_LOW:
-		strlcat(card->longname, ", low speed", sizeof(card->longname));
-		break;
 	case USB_SPEED_FULL:
-		strlcat(card->longname, ", full speed", sizeof(card->longname));
-		break;
 	case USB_SPEED_HIGH:
-		strlcat(card->longname, ", high speed", sizeof(card->longname));
-		break;
 	case USB_SPEED_SUPER:
-		strlcat(card->longname, ", super speed", sizeof(card->longname));
-		break;
 	case USB_SPEED_SUPER_PLUS:
-		strlcat(card->longname, ", super speed plus", sizeof(card->longname));
+	case USB_SPEED_SUPER_PLUS_BY2:
+		strlcat(card->longname, ", ", sizeof(card->longname));
+		strlcat(card->longname,
+			usb_speed_string(snd_usb_get_speed(dev)),
+			sizeof(card->longname));
 		break;
 	default:
 		break;
@@ -612,6 +608,7 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 	case USB_SPEED_HIGH:
 	case USB_SPEED_SUPER:
 	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER_PLUS_BY2:
 		break;
 	default:
 		dev_err(&dev->dev, "unknown device speed %d\n", snd_usb_get_speed(dev));
diff --git a/sound/usb/helper.c b/sound/usb/helper.c
index bf80e55d013a..0cac8e0177e4 100644
--- a/sound/usb/helper.c
+++ b/sound/usb/helper.c
@@ -110,6 +110,7 @@ unsigned char snd_usb_parse_datainterval(struct snd_usb_audio *chip,
 	case USB_SPEED_HIGH:
 	case USB_SPEED_SUPER:
 	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER_PLUS_BY2:
 		if (get_endpoint(alts, 0)->bInterval >= 1 &&
 		    get_endpoint(alts, 0)->bInterval <= 4)
 			return get_endpoint(alts, 0)->bInterval - 1;
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 6b0993258e03..47159aaba8d5 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -897,6 +897,7 @@ static void snd_usbmidi_us122l_output(struct snd_usb_midi_out_endpoint *ep,
 	case USB_SPEED_HIGH:
 	case USB_SPEED_SUPER:
 	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER_PLUS_BY2:
 		count = 1;
 		break;
 	default:
diff --git a/tools/usb/testusb.c b/tools/usb/testusb.c
index cbaa1b9fdeac..6f6675c92e0c 100644
--- a/tools/usb/testusb.c
+++ b/tools/usb/testusb.c
@@ -98,8 +98,9 @@ enum usb_device_speed {
 	USB_SPEED_LOW, USB_SPEED_FULL,		/* usb 1.1 */
 	USB_SPEED_HIGH,				/* usb 2.0 */
 	USB_SPEED_WIRELESS,			/* wireless (usb 2.5) */
-	USB_SPEED_SUPER,			/* usb 3.0 */
-	USB_SPEED_SUPER_PLUS,			/* usb 3.1 */
+	USB_SPEED_SUPER,			/* usb 3.0 5Gbps */
+	USB_SPEED_SUPER_PLUS,			/* usb 3.1 10Gbps */
+	USB_SPEED_SUPER_PLUS_BY2,		/* usb 3.2 20Gbps */
 };
 
 /*-------------------------------------------------------------------------*/
@@ -114,6 +115,7 @@ static char *speed (enum usb_device_speed s)
 	case USB_SPEED_WIRELESS:	return "wireless";
 	case USB_SPEED_SUPER:		return "super";
 	case USB_SPEED_SUPER_PLUS:	return "super-plus";
+	case USB_SPEED_SUPER_PLUS_BY2:	return "super-plus-by2";
 	default:			return "??";
 	}
 }
-- 
2.25.1

