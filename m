Return-Path: <linux-kernel+bounces-153511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A30188ACEE8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5876E28554E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC98C1514E3;
	Mon, 22 Apr 2024 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7ssyDjF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CE414F9EB;
	Mon, 22 Apr 2024 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713794327; cv=none; b=twbk7/4qxiUxNSLTM5Bkc516Nl10GjWGdbapYwX4tBXUYgIe5msFGJrbrh9Nv+0ygstG4g2mwJvyqJOenbs3sOyVLS2bJtpy2bLH06nkFMnUZG/hRXlTfj5jrcAKA4htZclyyZJ87JpIsWv+t8gIqW4oyjBRIXXSPreYlVAzwDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713794327; c=relaxed/simple;
	bh=jiAYpkNG4v9YIdBtOvoPx060DTrkuniphhZyGAC5Sa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBHRhqzRPk4PnBzONspuDGAYyMBhGtQV6LWcksGp/jPXVzNPNb6BY2GFxdhuA4f+4GwPTsmfjIuijpBaqXyj/zS+Q9dpwtVa7Z/Y3bw6thvgHYg+OXU9jTApPNnh1XYeh+graoeQ1nvXUnX7wLn+PpRM3EAArtY+/TsNZ99iyQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7ssyDjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E93C32782;
	Mon, 22 Apr 2024 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713794326;
	bh=jiAYpkNG4v9YIdBtOvoPx060DTrkuniphhZyGAC5Sa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b7ssyDjFNnuEEbZZv5Yua3MrMkFBm0BIBX0yMJwcvPZb8Mu29/jDTZY+XtD9kLEX+
	 stuID0AvLWgDIXAiaLP+miJtyjCSxvTxrmexWutYVA2sRST362kirux6pWoFrRjruI
	 xfz0amXJx0yHk384BmEtyIDCbarUy8yqHxFVLzfywK7wxnjdGWJ9bXmTpSzjDrsje6
	 648kFFgdtmQ+D3E6myrUc2UfDDHvHP7w2abHViB3AR1bpzN27HzTlwzmCBOTs2l0pw
	 nuliq4UUDA0BA+nMZmJW4mH8Hs5GMokhxP2jC7HlDzfwNqcyuQQfx2IqreJCIpOi79
	 u2OjptBtfzaUQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1ryuBu-0000000061l-1JDF;
	Mon, 22 Apr 2024 15:58:42 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zhengping Jiang <jiangzp@google.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH RESEND 1/2] Bluetooth: qca: fix NULL-deref on non-serdev suspend
Date: Mon, 22 Apr 2024 15:57:47 +0200
Message-ID: <20240422135748.23081-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422135748.23081-1-johan+linaro@kernel.org>
References: <20240422135748.23081-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm ROME controllers can be registered from the Bluetooth line
discipline and in this case the HCI UART serdev pointer is NULL.

Add the missing sanity check to prevent a NULL-pointer dereference when
wakeup() is called for a non-serdev controller during suspend.

Just return true for now to restore the original behaviour and address
the crash with pre-6.2 kernels, which do not have commit e9b3e5b8c657
("Bluetooth: hci_qca: only assign wakeup with serial port support") that
causes the crash to happen already at setup() time.

Fixes: c1a74160eaf1 ("Bluetooth: hci_qca: Add device_may_wakeup support")
Cc: stable@vger.kernel.org      # 5.13
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 92fa20f5ac7d..94c85f4fbf3b 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1672,6 +1672,9 @@ static bool qca_wakeup(struct hci_dev *hdev)
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	bool wakeup;
 
+	if (!hu->serdev)
+		return true;
+
 	/* BT SoC attached through the serial bus is handled by the serdev driver.
 	 * So we need to use the device handle of the serdev driver to get the
 	 * status of device may wakeup.
-- 
2.43.2


