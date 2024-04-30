Return-Path: <linux-kernel+bounces-164493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EF68B7E32
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F23286B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FB31802BC;
	Tue, 30 Apr 2024 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6nuSieo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC1B179654;
	Tue, 30 Apr 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496931; cv=none; b=QwL2ZobTHIVDHeUjwS+RXSCmC30FJT8VTRljvobku/KgO35UKd2XlbKaBnLVfNWV2Xc2BOAEbdYmBsaHQBJ50VpY3Gotv73jiyd3Ge87Pffc3KIcRX7wKkFVnKWwSRZSnR5DMdyF4jL4AeeuxRDT6oW5DuUKMVwyiXMmKH9n/f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496931; c=relaxed/simple;
	bh=AX8yI9iwutmkI36edFM3VBu7s37eedkRHUTRb8bbzHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBU2JW7WAmo22POa7C81u8OlDWJDcXJmJ/i+FFEXJjiuvCoUa2SnuzlM/Urk4WhEt5kE0V+AikE1LolOvSqdacG3ZezZLd3t7dHPmXlBqTQo5nQLs9MMd9a8TdI6D6VL0jTQbGPCicX9XeZMM004/CLfYYytnPYGpaZs7DVFmDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6nuSieo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF9BC4AF19;
	Tue, 30 Apr 2024 17:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714496930;
	bh=AX8yI9iwutmkI36edFM3VBu7s37eedkRHUTRb8bbzHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6nuSieoPK06bektIcj9zymhUw2IeblFndf3ZhqlLVnoI1/6lJdELM+PtEvFdtBFu
	 bM42/2FZfIQ5UyThRzZpSt4swo0ZT1HttL1zrxew/rctRUcOhEMrTSE9hmGS0qA+xa
	 +9bH+IBK2mUfYee7C88w1uLRC7ysVjtGEI15HLvcO0wXAomNhbMrbZA2+8SxCePOnE
	 y91tN1hQdQP5ZW1J1iqpb18mQADKilqOnm9gw5TUVn6ncJ9vw8D94Mtq9APFDilRGB
	 GAZiEPCNahY4RX9rLS529E5S6tAOZ+Ify3fBLK9ne4Jo8yFbNZAOsjZ3HlYjS3mtPS
	 7nw0rshcF9aCw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1s1qyK-0000000047a-3Dm7;
	Tue, 30 Apr 2024 19:08:52 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 2/3] Bluetooth: qca: fix NVM configuration parsing
Date: Tue, 30 Apr 2024 19:07:40 +0200
Message-ID: <20240430170741.15742-3-johan+linaro@kernel.org>
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

The NVM configuration files used by WCN3988 and WCN3990/1/8 have two
sets of configuration tags that are enclosed by a type-length header of
type four which the current parser fails to account for.

Instead the driver happily parses random data as if it were valid tags,
something which can lead to the configuration data being corrupted if it
ever encounters the words 0x0011 or 0x001b.

As is clear from commit b63882549b2b ("Bluetooth: btqca: Fix the NVM
baudrate tag offcet for wcn3991") the intention has always been to
process the configuration data also for WCN3991 and WCN3998 which
encodes the baud rate at a different offset.

Fix the parser so that it can handle the WCN3xxx configuration files,
which has an enclosing type-length header of type four and two sets of
TLV tags enclosed by a type-length header of type two and three,
respectively.

Note that only the first set, which contains the tags the driver is
currently looking for, will be parsed for now.

With the parser fixed, the software in-band sleep bit will now be set
for WCN3991 and WCN3998 (as it is for later controllers) and the default
baud rate 3200000 may be updated by the driver also for WCN3xxx
controllers.

Notably the deep-sleep feature bit is already set by default in all
configuration files in linux-firmware.

Fixes: 4219d4686875 ("Bluetooth: btqca: Add wcn3990 firmware download support.")
Cc: stable@vger.kernel.org	# 4.19
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/btqca.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 6743b0a79d7a..f6c9f89a6311 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -281,6 +281,7 @@ static int qca_tlv_check_data(struct hci_dev *hdev,
 	struct tlv_type_patch *tlv_patch;
 	struct tlv_type_nvm *tlv_nvm;
 	uint8_t nvm_baud_rate = config->user_baud_rate;
+	u8 type;
 
 	config->dnld_mode = QCA_SKIP_EVT_NONE;
 	config->dnld_type = QCA_SKIP_EVT_NONE;
@@ -346,11 +347,30 @@ static int qca_tlv_check_data(struct hci_dev *hdev,
 		tlv = (struct tlv_type_hdr *)fw_data;
 
 		type_len = le32_to_cpu(tlv->type_len);
-		length = (type_len >> 8) & 0x00ffffff;
+		length = type_len >> 8;
+		type = type_len & 0xff;
 
-		BT_DBG("TLV Type\t\t : 0x%x", type_len & 0x000000ff);
+		/* Some NVM files have more than one set of tags, only parse
+		 * the first set when it has type 2 for now. When there is
+		 * more than one set there is an enclosing header of type 4.
+		 */
+		if (type == 4) {
+			if (fw_size < 2 * sizeof(struct tlv_type_hdr))
+				return -EINVAL;
+
+			tlv++;
+
+			type_len = le32_to_cpu(tlv->type_len);
+			length = type_len >> 8;
+			type = type_len & 0xff;
+		}
+
+		BT_DBG("TLV Type\t\t : 0x%x", type);
 		BT_DBG("Length\t\t : %d bytes", length);
 
+		if (type != 2)
+			break;
+
 		if (fw_size < length + (tlv->data - fw_data))
 			return -EINVAL;
 
-- 
2.43.2


