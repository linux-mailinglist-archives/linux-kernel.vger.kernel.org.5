Return-Path: <linux-kernel+bounces-165253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383C48B8A19
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A59E1C2192F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A39A1292CA;
	Wed,  1 May 2024 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTMc7JsX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960361DFFB;
	Wed,  1 May 2024 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566914; cv=none; b=KJkM/CD0gKlS9CCC7KBBY6zABTK9dT8yewXHtCusO65naXM5sbfO00g+a5F/c0Nt25oOTFuvnrduo6A6h7RjVK3L8ihHRXdqDUFgj4O3ThGI5+c2CTZusk3KvJRxOy2Xn9YUM3cE0IbLCO4qZDvwE7wsaDB84PtAyr8cgZw2tco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566914; c=relaxed/simple;
	bh=+/0WsjYl9G9pdjlSPEHqHyblMh1LaeTcks5oxwjbiKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l022Pg06HiYCw2YTtfqaRl6UlbobVWpCPBjPbC3rnqQT7yh543Rx9PTRIJmOq/FSbH3sDq/egG3KyCMTkfquGPpERLy+9A13n3mlaKQVMMUpAyEfxEnPk3D2PGjRkTpjcGVEBKvIKIjAhdVaQ5hsz6hI5IA9VEm3C950rzh6UhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTMc7JsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFE2C4AF19;
	Wed,  1 May 2024 12:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714566914;
	bh=+/0WsjYl9G9pdjlSPEHqHyblMh1LaeTcks5oxwjbiKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTMc7JsXqc9iPsLa1w/O/X6JTsRjo3rYNdwrR59cQcgcEgNQM9Qujul5XXLjvZmgl
	 GSJ7EGYwwj/L43ZXaXRmmv+L+BiUaCvZNvI8cjhv5iDWfPjnDUH+PNuCpmvtWlMj8y
	 n7POqGaVo2pVNhqq79PstQIJppeG9vBk9oYitiYTwFsemN3/xgVC9ddytCIhgVmhcq
	 GI8GB/XBWT1n+3B1VQhRmhCyBROKXQrh7LoqDeGwM0dG0awsl8B9ukmmctEHSDIicz
	 0tQet3T9ga/PssvPV+EPrJfE7beYVxrWlLhYD9tlzqliHz+JJVx0prxTOCcBrBuqAx
	 HQExJ3PfxT6uA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1s29B6-000000001l0-3yAb;
	Wed, 01 May 2024 14:35:16 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Tim Jiang <quic_tjiang@quicinc.com>
Subject: [PATCH 2/5] Bluetooth: qca: fix info leak when fetching board id
Date: Wed,  1 May 2024 14:34:53 +0200
Message-ID: <20240501123456.6712-3-johan+linaro@kernel.org>
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

Add the missing sanity check when fetching the board id to avoid leaking
slab data when later requesting the firmware.

Fixes: a7f8dedb4be2 ("Bluetooth: qca: add support for QCA2066")
Cc: stable@vger.kernel.org	# 6.7
Cc: Tim Jiang <quic_tjiang@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/btqca.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index a508d79d9aaa..638074992c82 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -252,6 +252,11 @@ static int qca_read_fw_board_id(struct hci_dev *hdev, u16 *bid)
 		goto out;
 	}
 
+	if (skb->len < 3) {
+		err = -EILSEQ;
+		goto out;
+	}
+
 	*bid = (edl->data[1] << 8) + edl->data[2];
 	bt_dev_dbg(hdev, "%s: bid = %x", __func__, *bid);
 
-- 
2.43.2


