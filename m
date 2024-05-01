Return-Path: <linux-kernel+bounces-165252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 292978B8A18
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7891F22C5E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6847412839D;
	Wed,  1 May 2024 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vo3LGkDV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FDF1DFF0;
	Wed,  1 May 2024 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566914; cv=none; b=e54FHMkyr028BChRAGpOSf5RaqJK7s6/sccY/UA3PzzLW3+NlJ4qd9jzt7IlWqNmn8pNFwA6q9L0RILgERhyLpsJR1FUqpXVF7/XKf3ng7Bv/p5NRqRd/t+HwkowgbmCPJv12noTzW/MqQ3TPMOu0QzD0BzFywZwlGBmzDCrL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566914; c=relaxed/simple;
	bh=yxAjPYd7QIYgUwysaKCWGKv4Li4Z9nbUIl7p5X3foOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCGxS53p7K3V5Gjhic2wRypW+qOfdyugO1Nxvv4k/7ZdUZIuj9Oj44YozXHhlSlhPywTx1njdJXfIfSU4y30sbhT8Cygqi67YfTjAVcke3aW+jhLicaOda1pm7I41dP6ZTO45L/nhwLqY0hMHWTLeezUJl+koGmHCXO599ETZZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vo3LGkDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323C0C4AF18;
	Wed,  1 May 2024 12:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714566914;
	bh=yxAjPYd7QIYgUwysaKCWGKv4Li4Z9nbUIl7p5X3foOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vo3LGkDVfYGH/7nw9R4n2TL5EiDNmaR0GP3B/IVekpMdxCdNHqaM0rZ3snErJKqBD
	 Px/a5XoJUs+Scem+HuWa4IogT80RP3Vq034hqM63eyiEq5jRDXrh6HB9CaQBPrSEVp
	 JZWjjvQumETidV3eAl5fJ0+2UTxjw+3fLm8aHZF1rC6xt5Jh8suOpJV7oxoYV5ckWi
	 7aI34IJrApPT7ObWWbH8OTheCCUZF+hrCe8H7do7eDmUnNZQc2+gMjuTx6FdAeRIXf
	 KUUpeSk+fDM8u2+ffuQlbDdZH9X4Qc18O2um1v1gavJBUYQyWJeC2sKXvHnZVUN4/+
	 wjlqbhqEx9N1w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1s29B6-000000001ky-3dgV;
	Wed, 01 May 2024 14:35:16 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] Bluetooth: qca: fix info leak when fetching fw build id
Date: Wed,  1 May 2024 14:34:52 +0200
Message-ID: <20240501123456.6712-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240501123456.6712-1-johan+linaro@kernel.org>
References: <20240501123456.6712-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing sanity checks and move the 255-byte build-id buffer off
the stack to avoid leaking stack data through debugfs in case the
build-info reply is malformed.

Fixes: c0187b0bd3e9 ("Bluetooth: btqca: Add support to read FW build version for WCN3991 BTSoC")
Cc: stable@vger.kernel.org	# 5.12
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/btqca.c | 25 +++++++++++++++++++++----
 drivers/bluetooth/btqca.h |  1 -
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 38a770278103..a508d79d9aaa 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -99,7 +99,8 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 	struct edl_event_hdr *edl;
-	char cmd, build_label[QCA_FW_BUILD_VER_LEN];
+	char *build_label;
+	char cmd;
 	int build_lbl_len, err = 0;
 
 	bt_dev_dbg(hdev, "QCA read fw build info");
@@ -114,6 +115,11 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
 		return err;
 	}
 
+	if (skb->len < sizeof(*edl)) {
+		err = -EILSEQ;
+		goto out;
+	}
+
 	edl = (struct edl_event_hdr *)(skb->data);
 	if (!edl) {
 		bt_dev_err(hdev, "QCA read fw build info with no header");
@@ -129,14 +135,25 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
 		goto out;
 	}
 
+	if (skb->len < sizeof(*edl) + 1) {
+		err = -EILSEQ;
+		goto out;
+	}
+
 	build_lbl_len = edl->data[0];
-	if (build_lbl_len <= QCA_FW_BUILD_VER_LEN - 1) {
-		memcpy(build_label, edl->data + 1, build_lbl_len);
-		*(build_label + build_lbl_len) = '\0';
+
+	if (skb->len < sizeof(*edl) + 1 + build_lbl_len) {
+		err = -EILSEQ;
+		goto out;
 	}
 
+	build_label = kstrndup(&edl->data[1], build_lbl_len, GFP_KERNEL);
+	if (!build_label)
+		goto out;
+
 	hci_set_fw_info(hdev, "%s", build_label);
 
+	kfree(build_label);
 out:
 	kfree_skb(skb);
 	return err;
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 49ad668d0d0b..215433fd76a1 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -48,7 +48,6 @@
 #define get_soc_ver(soc_id, rom_ver)	\
 	((le32_to_cpu(soc_id) << 16) | (le16_to_cpu(rom_ver)))
 
-#define QCA_FW_BUILD_VER_LEN		255
 #define QCA_HSP_GF_SOC_ID			0x1200
 #define QCA_HSP_GF_SOC_MASK			0x0000ff00
 
-- 
2.43.2


