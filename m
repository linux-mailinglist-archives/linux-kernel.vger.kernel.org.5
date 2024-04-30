Return-Path: <linux-kernel+bounces-164491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A938B7E31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8DA286AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F211802BA;
	Tue, 30 Apr 2024 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMygWH51"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB8117164E;
	Tue, 30 Apr 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496931; cv=none; b=qdWCy35DgAeW4XC+w2tPVSLlBxPsKw5oZl9k7zzyi+uatIUoTAsOgmtawNJNKZMEGnwnyLiDeUCYm11vXLXbdlh1XEiQnD9xY6H6z9yGoQfg5u9BPB4DwheS60aL5vvMe/TNoDySGCdPHSVcH/82J/W64oMq+wtXdnQWqanh5SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496931; c=relaxed/simple;
	bh=e0/6a8zI7qlfmUzhIdgSTDIhViQTmWLkZY4lOE8TrGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVEOm1DV17EyKeqDWlr4mCh7OI4ytta3xu9YDnL9pV9ZOrfTJwRieSv8VqKlZ5YiTnfqriwmcuOEbXEXkwoVEszV5n29nHoVGMgMHhZIF/Yhi8yQUjeiJSOfoVdEvNeHeF32KpBcaCsDiW/yoSzr8WYzMIA8gwiv3ilm8I9vSfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMygWH51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3808C4AF14;
	Tue, 30 Apr 2024 17:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714496930;
	bh=e0/6a8zI7qlfmUzhIdgSTDIhViQTmWLkZY4lOE8TrGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMygWH51AQDO8JXpP9CSUNV6DlRygTjpidNiAX95vt9fPYWmcW2VGeJCvQQP+vfwx
	 IkkRBDO2ZS3h+KAdV1XyvUw+64syEd9VQCdoeqqBYFH3bNf7618NeQqXDDBgQ57ZZ+
	 rMRsehAI3u0bj0kAmBE07NkeAz/RqcHOL81GyirCnLHo4f8XXurmfsj/xkbkzRfudC
	 GjfM7Uoe4l10c0DZmDgav5K1H1lqB2uR4MGPD7PhshUabmoopkdTpkxCcDxQozKD5A
	 t0irnv0wek/qE7m5a6lqyImPfE9ZeCoyIXT0xOjHuhUIC+u/dxeuEYJukdDPZwRGMg
	 EqAAV9uwnuOqg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1s1qyK-0000000047S-2qZF;
	Tue, 30 Apr 2024 19:08:52 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: qca: add missing firmware sanity checks
Date: Tue, 30 Apr 2024 19:07:39 +0200
Message-ID: <20240430170741.15742-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240430170741.15742-1-johan+linaro@kernel.org>
References: <20240430170741.15742-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing sanity checks when parsing the firmware files before
downloading them to avoid accessing and corrupting memory beyond the
vmalloced buffer.

Fixes: 83e81961ff7e ("Bluetooth: btqca: Introduce generic QCA ROME support")
Cc: stable@vger.kernel.org	# 4.10
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/btqca.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index cfa71708397b..6743b0a79d7a 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -268,9 +268,10 @@ int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(qca_send_pre_shutdown_cmd);
 
-static void qca_tlv_check_data(struct hci_dev *hdev,
+static int qca_tlv_check_data(struct hci_dev *hdev,
 			       struct qca_fw_config *config,
-		u8 *fw_data, enum qca_btsoc_type soc_type)
+			       u8 *fw_data, size_t fw_size,
+			       enum qca_btsoc_type soc_type)
 {
 	const u8 *data;
 	u32 type_len;
@@ -286,6 +287,9 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 
 	switch (config->type) {
 	case ELF_TYPE_PATCH:
+		if (fw_size < 7)
+			return -EINVAL;
+
 		config->dnld_mode = QCA_SKIP_EVT_VSE_CC;
 		config->dnld_type = QCA_SKIP_EVT_VSE_CC;
 
@@ -294,6 +298,9 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 		bt_dev_dbg(hdev, "File version      : 0x%x", fw_data[6]);
 		break;
 	case TLV_TYPE_PATCH:
+		if (fw_size < sizeof(struct tlv_type_hdr) + sizeof(struct tlv_type_patch))
+			return -EINVAL;
+
 		tlv = (struct tlv_type_hdr *)fw_data;
 		type_len = le32_to_cpu(tlv->type_len);
 		tlv_patch = (struct tlv_type_patch *)tlv->data;
@@ -333,6 +340,9 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 		break;
 
 	case TLV_TYPE_NVM:
+		if (fw_size < sizeof(struct tlv_type_hdr))
+			return -EINVAL;
+
 		tlv = (struct tlv_type_hdr *)fw_data;
 
 		type_len = le32_to_cpu(tlv->type_len);
@@ -341,17 +351,26 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 		BT_DBG("TLV Type\t\t : 0x%x", type_len & 0x000000ff);
 		BT_DBG("Length\t\t : %d bytes", length);
 
+		if (fw_size < length + (tlv->data - fw_data))
+			return -EINVAL;
+
 		idx = 0;
 		data = tlv->data;
-		while (idx < length) {
+		while (idx < length - sizeof(struct tlv_type_nvm)) {
 			tlv_nvm = (struct tlv_type_nvm *)(data + idx);
 
 			tag_id = le16_to_cpu(tlv_nvm->tag_id);
 			tag_len = le16_to_cpu(tlv_nvm->tag_len);
 
+			if (length < idx + sizeof(struct tlv_type_nvm) + tag_len)
+				return -EINVAL;
+
 			/* Update NVM tags as needed */
 			switch (tag_id) {
 			case EDL_TAG_ID_HCI:
+				if (tag_len < 3)
+					return -EINVAL;
+
 				/* HCI transport layer parameters
 				 * enabling software inband sleep
 				 * onto controller side.
@@ -367,6 +386,9 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 				break;
 
 			case EDL_TAG_ID_DEEP_SLEEP:
+				if (tag_len < 1)
+					return -EINVAL;
+
 				/* Sleep enable mask
 				 * enabling deep sleep feature on controller.
 				 */
@@ -375,14 +397,16 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 				break;
 			}
 
-			idx += (sizeof(u16) + sizeof(u16) + 8 + tag_len);
+			idx += sizeof(struct tlv_type_nvm) + tag_len;
 		}
 		break;
 
 	default:
 		BT_ERR("Unknown TLV type %d", config->type);
-		break;
+		return -EINVAL;
 	}
+
+	return 0;
 }
 
 static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
@@ -532,7 +556,9 @@ static int qca_download_firmware(struct hci_dev *hdev,
 	memcpy(data, fw->data, size);
 	release_firmware(fw);
 
-	qca_tlv_check_data(hdev, config, data, soc_type);
+	ret = qca_tlv_check_data(hdev, config, data, size, soc_type);
+	if (ret)
+		return ret;
 
 	segment = data;
 	remain = size;
-- 
2.43.2


