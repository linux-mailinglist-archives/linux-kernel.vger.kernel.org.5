Return-Path: <linux-kernel+bounces-153510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101C28ACEE7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF671C21551
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8DF1514E2;
	Mon, 22 Apr 2024 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/vgH1A7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D2214F9F8;
	Mon, 22 Apr 2024 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713794327; cv=none; b=ni56iAShlfIK46Inst9YstsD32MKPuGg4Aq3yxbaimbD7vTdC6fAdKjRSyDHambvHcyaXJQvgRsaFcICbAbew8J5g8AGLyCeifFb+RsU82nW8zieq2eq7QE2FOdDGy93nr+kbLqoBvV/mSxe8gZL1701mX52ZCVEf7vHjF4rDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713794327; c=relaxed/simple;
	bh=8sEWvsxwh2ILWET5xE5dtv8sLR76qdeupXXOYaya9Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvhSkRyP955gbLCxxYPe8wTG3lbjcep/xHoTQqzANakNJR4+B+lF/f9g8KgvvUVNBCdqza+GywJEjW8NXMQENRnZgfOVpVGQR9QxE1FrknR9h8g6t6S4mWHhK1BcqBUYVfNVUUTe0ARivu3+/w1jl2fuD5gC3dS3yGED/pcQc6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/vgH1A7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A469EC113CC;
	Mon, 22 Apr 2024 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713794326;
	bh=8sEWvsxwh2ILWET5xE5dtv8sLR76qdeupXXOYaya9Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/vgH1A79J1wuwguf+e1wTU5U0wZIlt382pevMn03EK+WdqlvAdWuK7zKbvfONitq
	 7YXoxPc3juwFIgUPlw00S0zsY9AfZdTeyWsv78aOXPHqMO/AKBoeszsKB4tmOqISjc
	 0n5HRRT7+mrlPl+ZxhVDsKuYwdtj24lcDa1ujKQVNpcKQ+FOHoAtDHNTyuPx5DxQBc
	 pb5OuM976hsKDfnFgkK+JC3F0K8ETO/jDcy3YOix+Nn7I0gOLJiN9J3SV1egQDCbHo
	 wxoOx/+4cPZ9wp1skneTf8GURlkty1LxF3+OFWsmAefOefvKLdBTq30YNgusk7u2mu
	 rhyYOIjmUzZ7Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1ryuBu-0000000061n-1dVX;
	Mon, 22 Apr 2024 15:58:42 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zhengping Jiang <jiangzp@google.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH RESEND 2/2] Bluetooth: qca: fix NULL-deref on non-serdev setup
Date: Mon, 22 Apr 2024 15:57:48 +0200
Message-ID: <20240422135748.23081-3-johan+linaro@kernel.org>
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
setup() is called for a non-serdev controller.

Fixes: e9b3e5b8c657 ("Bluetooth: hci_qca: only assign wakeup with serial port support")
Cc: stable@vger.kernel.org      # 6.2
Cc: Zhengping Jiang <jiangzp@google.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 94c85f4fbf3b..b621a0a40ea4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1958,8 +1958,10 @@ static int qca_setup(struct hci_uart *hu)
 		qca_debugfs_init(hdev);
 		hu->hdev->hw_error = qca_hw_error;
 		hu->hdev->cmd_timeout = qca_cmd_timeout;
-		if (device_can_wakeup(hu->serdev->ctrl->dev.parent))
-			hu->hdev->wakeup = qca_wakeup;
+		if (hu->serdev) {
+			if (device_can_wakeup(hu->serdev->ctrl->dev.parent))
+				hu->hdev->wakeup = qca_wakeup;
+		}
 	} else if (ret == -ENOENT) {
 		/* No patch/nvm-config found, run with original fw/config */
 		set_bit(QCA_ROM_FW, &qca->flags);
-- 
2.43.2


