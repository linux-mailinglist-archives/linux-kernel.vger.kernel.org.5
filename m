Return-Path: <linux-kernel+bounces-113204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6DD88824D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6120C1C22735
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4245C61A;
	Sun, 24 Mar 2024 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9li5U84"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85CE17C6D7;
	Sun, 24 Mar 2024 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320006; cv=none; b=TdS4MH00xEe9XdlzFWz/zobs0XN7jTN6UWH/9H13zjO5er28qmpggu2xGPckvrgkZqzgWOk+37FF11O70CFGN6+RztSe5FqB7OJAewonol+ENDkDwvruQpJLczS9+I0KPWAS5CuEGpbVOgp5Q+UIZl939eZWbOwUCqKCrg+46OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320006; c=relaxed/simple;
	bh=eZ8P3VvFJh8AOiFHtetE+vSb5xhTtJgCpVECyeF04SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVSXGhmnDUc6MgSFWNA8Ry1Pv8YeOTattN37ryBaOJfsLzHcO8//QAZyRzcKtCWaXqyr63UBd5wo4JhNuAMrzXXinHO+6/rft5R/aduH5//CbqpLzLzYUBcmLkQUXDS3a3VX0zFW/pWh7vfkqqiW+QSHS04GNUGfH0LQpT2EqTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9li5U84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B9BC43399;
	Sun, 24 Mar 2024 22:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320006;
	bh=eZ8P3VvFJh8AOiFHtetE+vSb5xhTtJgCpVECyeF04SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c9li5U84URkqNto81I00q47G6+N8Gcn4V8F7jYHos3fxnrTWv1rG4c/rvvDk+5X+J
	 8QrbHFAZkRRHww2kxECLGlrIvMN+cneheznxz6Ny+npZaj84fz7lZ0CbUnpIQ6Y0rT
	 euAK4jqJDRjntj9vCSUXTdLxmuVRjwYmZMKOa42HxU9pFafOTS4Z2V8HVKVAj1IXTn
	 IdDpwNd3w/+i8WTDI7V6Wt16wixJ3Ljk3dxBC/uQQIVjET2fKgSXawTIs4qpf4ChE1
	 xtYqm7OTPmpXSgKOwc/85O9v6Il9vUVptHY+nEtdSjEjf5g1vS2UZ9UCM10vMIPDU6
	 NNfw1ikRuZyWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 313/715] Bluetooth: msft: Fix memory leak
Date: Sun, 24 Mar 2024 18:28:12 -0400
Message-ID: <20240324223455.1342824-314-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit a6e06258f4c31eba0fcd503e19828b5f8fe7b08b ]

Fix leaking buffer allocated to send MSFT_OP_LE_MONITOR_ADVERTISEMENT.

Fixes: 9e14606d8f38 ("Bluetooth: msft: Extended monitor tracking by address filter")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/msft.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 630e3023273b2..9612c5d1b13f6 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -875,6 +875,7 @@ static int msft_add_address_filter_sync(struct hci_dev *hdev, void *data)
 		remove = true;
 		goto done;
 	}
+
 	cp->sub_opcode           = MSFT_OP_LE_MONITOR_ADVERTISEMENT;
 	cp->rssi_high		 = address_filter->rssi_high;
 	cp->rssi_low		 = address_filter->rssi_low;
@@ -887,6 +888,8 @@ static int msft_add_address_filter_sync(struct hci_dev *hdev, void *data)
 
 	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, size, cp,
 			     HCI_CMD_TIMEOUT);
+	kfree(cp);
+
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Failed to enable address %pMR filter",
 			   &address_filter->bdaddr);
-- 
2.43.0


