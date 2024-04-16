Return-Path: <linux-kernel+bounces-146545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3408A66E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909471C218AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF9F85293;
	Tue, 16 Apr 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kr55DqIc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C684E0A;
	Tue, 16 Apr 2024 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713259018; cv=none; b=YY0yCf1o7PAqKAn5Hxztj2zViDyVScL+AGYDuA0RCXkygg5UMw8fheFO33R0+e5+cC5dlb14lZmbXiDWWCSVCYZ/ZsR+lRUrhNJ8b92RuSQUdUGl8E0oW1WkrJpwtDY9P1jbg0/IcWejL3FCRZAAneM2kS0OLkW1/6pqfeukoNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713259018; c=relaxed/simple;
	bh=Et/xGVRO67Io7N9eFsHAPc1PlNaNznIJ/8e09IRteZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bMup2jcnQj9kfUqOmLeisnapjzVAkQzTWxCg0OGDvwoh8CgZd8gl94kgJWyRovK6mgXdFYRyIQ7wuk1UF8ez6Lhw02E/MOTNEdJ2xnaUWmsKVuXWeyKp1CXuwSKQwBSFn8UJyDvu9nwCC2d76ERfpWavbTui12V87rZHbzbdEZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kr55DqIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8FAC113CE;
	Tue, 16 Apr 2024 09:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713259018;
	bh=Et/xGVRO67Io7N9eFsHAPc1PlNaNznIJ/8e09IRteZI=;
	h=From:To:Cc:Subject:Date:From;
	b=kr55DqIcHpqG3Al2mrRmGyIOmA4znqmdkhqdJdezTxhEHudatB8Ikl7Y+j+jJMtzo
	 zi7LAgPZuwxs7XbFlmWgr+8l1vcKHyrnC3yfCs8gsBkge8aHl64dg37Rdm6wXdeYVN
	 Jp7rXByi6LJHd3qaR7H5e8DK5Wwv8y0PhsW5VQaHyurV4utsW/u6tJdWKXS6xa4mf8
	 JzzUXmg7dN9kiIBhrAfoNhClXOyOQ61ZW44vj94JwOxljoM+TNmesGkbBoX3pstXMO
	 MC+zdMNU4KKca8c0X2cFDZU8Sxph5ax53S6jFbMMm+sJUFWJuMvMb0olo5EZkdmzbV
	 +x3sf90R5CNQg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rwevu-000000005EL-3yOS;
	Tue, 16 Apr 2024 11:16:55 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Matthias Kaehlcke <mka@chromium.org>,
	Doug Anderson <dianders@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: qca: fix invalid device address check
Date: Tue, 16 Apr 2024 11:15:09 +0200
Message-ID: <20240416091509.19995-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm Bluetooth controllers may not have been provisioned with a
valid device address and instead end up using the default address
00:00:00:00:5a:ad.

This was previously believed to be due to lack of persistent storage for
the address but it may also be due to integrators opting to not use the
on-chip OTP memory and instead store the address elsewhere (e.g. in
storage managed by secure world firmware).

According to Qualcomm, at least WCN6750, WCN6855 and WCN7850 have
on-chip OTP storage for the address.

As the device type alone cannot be used to determine when the address is
valid, instead read back the address during setup() and only set the
HCI_QUIRK_USE_BDADDR_PROPERTY flag when needed.

This specifically makes sure that controllers that have been provisioned
with an address do not start as unconfigured.

Reported-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Link: https://lore.kernel.org/r/124a7d54-5a18-4be7-9a76-a12017f6cce5@quicinc.com/
Fixes: 5971752de44c ("Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPERTY for wcn3990")
Fixes: e668eb1e1578 ("Bluetooth: hci_core: Don't stop BT if the BD address missing in dts")
Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
Cc: stable@vger.kernel.org	# 6.5
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/btqca.c   | 38 +++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_qca.c |  2 --
 2 files changed, 38 insertions(+), 2 deletions(-)


Matthias and Doug,

As Chromium is the only known user of the 'local-bd-address' property,
could you please confirm that your controllers use the 00:00:00:00:5a:ad
address by default so that the quirk continues to be set as intended?

Johan



diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 19cfc342fc7b..216826c31ee3 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -15,6 +15,8 @@
 
 #define VERSION "0.1"
 
+#define QCA_BDADDR_DEFAULT (&(bdaddr_t) {{ 0xad, 0x5a, 0x00, 0x00, 0x00, 0x00 }})
+
 int qca_read_soc_version(struct hci_dev *hdev, struct qca_btsoc_version *ver,
 			 enum qca_btsoc_type soc_type)
 {
@@ -612,6 +614,38 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
 
+static int qca_check_bdaddr(struct hci_dev *hdev)
+{
+	struct hci_rp_read_bd_addr *bda;
+	struct sk_buff *skb;
+	int err;
+
+	if (bacmp(&hdev->public_addr, BDADDR_ANY))
+		return 0;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Failed to read device address (%d)", err);
+		return err;
+	}
+
+	if (skb->len != sizeof(*bda)) {
+		bt_dev_err(hdev, "Device address length mismatch");
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	bda = (struct hci_rp_read_bd_addr *)skb->data;
+	if (!bacmp(&bda->bdaddr, QCA_BDADDR_DEFAULT))
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
 static void qca_generate_hsp_nvm_name(char *fwname, size_t max_size,
 		struct qca_btsoc_version ver, u8 rom_ver, u16 bid)
 {
@@ -818,6 +852,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		break;
 	}
 
+	err = qca_check_bdaddr(hdev);
+	if (err)
+		return err;
+
 	bt_dev_info(hdev, "QCA setup on UART is completed");
 
 	return 0;
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ecbc52eaf101..92fa20f5ac7d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1905,8 +1905,6 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
-
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 		if (qcadev->bdaddr_property_broken)
 			set_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks);
-- 
2.43.2


