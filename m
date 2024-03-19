Return-Path: <linux-kernel+bounces-107736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311038800F9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F7B283986
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5262581AB5;
	Tue, 19 Mar 2024 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDwpXITz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE30657AD;
	Tue, 19 Mar 2024 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863173; cv=none; b=tUjI39Tai9YQfqEGc10dXP46UgPZ5FXwIJC+yhH526251fZryXNUQj7vPDdq6/Za24J3OqatX+wy09zD0W6cqTvjmMK3v7VnbTGpGckQZ2x+uf+tyllnkElomaa73ZUHPtOSmaDJBhs6kmU0uLNYDn2iez3yiQFpSHvpRhoJNyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863173; c=relaxed/simple;
	bh=71GoqhGH8N8bnYtZsq9ijp622SfqGqj12oKJWg3VC74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcTP2qPNdllX5k3Yzn+ucmuUE9Itmx067gASSvujHiFv45pFJLH+A9AohIa5+QU/Xi58kwriJnMk0XZm2Tjp134OuThuW65qt7syANTbtUYoMJNjcxBIcJGBJSN1lgvpyYMT4tQxfaS644YbXHgLhrHVq5AjUxn4b+7fqLNy96E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDwpXITz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B12BC433F1;
	Tue, 19 Mar 2024 15:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710863173;
	bh=71GoqhGH8N8bnYtZsq9ijp622SfqGqj12oKJWg3VC74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FDwpXITzgKpJYpScRM4cJlp8JdccJ61kLQnExKuxUbGRi3xpVwvEiFUhKz5MoQBBY
	 IOvfBRWJ2ZAGTm2uk5U4G9wFRkMyCudQTWi5Dwbg+0fw7IGEb/eMQOiFzOQ3sJ8gWl
	 MD735TzjhiMaTEFXt/25AYj/8RB3r4Kx1wCCTdjhXCzsmRJanXWYiMZe/Y4la76Nk4
	 XhkOiGTG0xq17xMARVI3+SM3SU2Q9Gix/LEOXKbom4XLhR7Yq5cmzMPYnhd4HDonMf
	 4kINiBELTVNk4g6BJHCT3j9zuklxE6E423+9xUZSizgVImeDqrp6XUkLrIxlda370p
	 LiMRwkt1VLsBQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rmbfQ-000000000eX-1tKc;
	Tue, 19 Mar 2024 16:46:20 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zhengping Jiang <jiangzp@google.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: qca: fix NULL-deref on non-serdev setup
Date: Tue, 19 Mar 2024 16:46:11 +0100
Message-ID: <20240319154611.2492-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240319154611.2492-1-johan+linaro@kernel.org>
References: <20240319154611.2492-1-johan+linaro@kernel.org>
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
index 84f728943962..6a69a7f9ef64 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1960,8 +1960,10 @@ static int qca_setup(struct hci_uart *hu)
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


