Return-Path: <linux-kernel+bounces-165251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9437A8B8A17
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56161C22123
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59850127E0C;
	Wed,  1 May 2024 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrpxwJis"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960041DFF7;
	Wed,  1 May 2024 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566914; cv=none; b=BO36EmpXfvdDlT91eiJXa8qpZQwTf7eC63jH1vRftCPdLE6fVmUdAwW04PbKKXtb56hzYaPG9yYg191j1W3BWtvelsmEM8XLap1mIS1US4FMQS7xMMBoDzWyCxNmtTvn7cfvT5FDhSXSiILPKuRAU7LMH52gBQp6ms48EQivalI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566914; c=relaxed/simple;
	bh=aVCy5Wv4CfQbYy32F82+h1WTcZq2oIhWZtBHkh54KtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTq0Wh+4FgZjzB9f04k3yG+SRFMHPWUmB4JucK6U2+cJUTW3IjOizciMuu0+SDoNy+sdVAm3AW9jYu5WJcfZYX8vmWPd9AJWhkXYQQMnmojSa/loDbW3dg0ao/Jx/JxWskO7TQHFUZ8zvHHYpUmYgifMMH/2YVwVno6xq9j6+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrpxwJis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B3AC113CC;
	Wed,  1 May 2024 12:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714566914;
	bh=aVCy5Wv4CfQbYy32F82+h1WTcZq2oIhWZtBHkh54KtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DrpxwJis1f+ftfpR42MZljNakzzqkkNLgj3PV/jl21no13KLMOpo0APyn9xy7Da/6
	 1H8j58v26zGajPJCZ+TeJhdMr4y66BR7U2k9aHEML67lY/pKAOtrkHpBIipYzzhIgs
	 su1a1y0XDRO5q1v3a2z893ffk56wu0DQNsYdva/84SKtznm4+2dZ5RE3bjHGXWKrYd
	 pZ0BswXEmtwOBwonX2O0HN1nigV2t2olGknThpzUdiWzJ7ZqP3j1ndU0xEogJx8O0+
	 jOagorrJqWGE0qZ6GXSeqXcD4uUqiyxO4gU02cQ8Dj4Dlrys+TcoQBJ3R0x0L/o+TG
	 nEsE219PA6rpA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1s29B7-000000001l3-06Gn;
	Wed, 01 May 2024 14:35:17 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/5] Bluetooth: qca: drop bogus edl header checks
Date: Wed,  1 May 2024 14:34:54 +0200
Message-ID: <20240501123456.6712-4-johan+linaro@kernel.org>
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

The skb->data pointer is never NULL so drop the bogus sanity checks when
initialising the EDL header pointer.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/btqca.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 638074992c82..2ba1f21f0320 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -55,11 +55,6 @@ int qca_read_soc_version(struct hci_dev *hdev, struct qca_btsoc_version *ver,
 	}
 
 	edl = (struct edl_event_hdr *)(skb->data);
-	if (!edl) {
-		bt_dev_err(hdev, "QCA TLV with no header");
-		err = -EILSEQ;
-		goto out;
-	}
 
 	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
 	    edl->rtype != rtype) {
@@ -121,11 +116,6 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
 	}
 
 	edl = (struct edl_event_hdr *)(skb->data);
-	if (!edl) {
-		bt_dev_err(hdev, "QCA read fw build info with no header");
-		err = -EILSEQ;
-		goto out;
-	}
 
 	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
 	    edl->rtype != EDL_GET_BUILD_INFO_CMD) {
@@ -183,11 +173,6 @@ static int qca_send_patch_config_cmd(struct hci_dev *hdev)
 	}
 
 	edl = (struct edl_event_hdr *)(skb->data);
-	if (!edl) {
-		bt_dev_err(hdev, "QCA Patch config with no header");
-		err = -EILSEQ;
-		goto out;
-	}
 
 	if (edl->cresp != EDL_PATCH_CONFIG_RES_EVT || edl->rtype != EDL_PATCH_CONFIG_CMD) {
 		bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
@@ -502,11 +487,6 @@ static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
 	}
 
 	edl = (struct edl_event_hdr *)(skb->data);
-	if (!edl) {
-		bt_dev_err(hdev, "TLV with no header");
-		err = -EILSEQ;
-		goto out;
-	}
 
 	if (edl->cresp != EDL_CMD_REQ_RES_EVT || edl->rtype != rtype) {
 		bt_dev_err(hdev, "QCA TLV with error stat 0x%x rtype 0x%x",
-- 
2.43.2


