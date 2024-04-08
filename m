Return-Path: <linux-kernel+bounces-135326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8815289BF08
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4333A284EFD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0BC6BFC8;
	Mon,  8 Apr 2024 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="tsj9ty5A"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF65B2D638;
	Mon,  8 Apr 2024 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579715; cv=none; b=ENovwC8DRhpEma4twG8uNs2SuS38sCU6Qkcf6IRdAHUSVVTiefWh8VXVvjndHp9Y1SM7VzeOxdzyAVvW/tGsgJVr6S7fYCxntodvPvfyKgNYTxlHe5LSOQwvzXBbkHKc3Y5YUp5zqiHYKmTyx0mPbgiAuIBKlyWjr2+OR5DcVIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579715; c=relaxed/simple;
	bh=uzS/b+eLEzhwH697AQNqgQD+zjuipsZxlwOsAMyLfyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P/zgIQOUTC0N46Oi1BCjSrZfBkcogj5UjAv4C9RdUkGfGT0MBgqgw9Y8942hRT2ru0DUuurlT0xoOZJ54izeSg6Mdn2Wyrzo4YFgK8/OAvGMnYh+Jv4RXrxElfbYRLk2BnH7HGZsBuRXUvqZ/Ma2kjtsunK/ySYQvjWKfbYOwcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=tsj9ty5A; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse.fritz.box (p5de45f24.dip0.t-ipconnect.de [93.228.95.36])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 989032FC006E;
	Mon,  8 Apr 2024 14:35:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1712579703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GI9DZr33CILbgz3WNky9szqV38NbOLyK95c6QgkhHHM=;
	b=tsj9ty5Agq2+HqQiRZlvfYeJfxlzM0ANyzoYvvsS+1T5GjnTEcqcPxyTS/fzggeXg07ooz
	HAejyQj/ggGHXp7AyXdOBLAYIvyXI6iWEK57ra/kMxakoKteXbdIwi9gRlr4q4r1nHnh4T
	8uY4ktqAq7CC1Ly8q5X0WkSrZQ1nDzc=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Christoffer Sandberg <cs@tuxedo.de>,
	Werner Sembach <wse@tuxedocomputers.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btintel: Add devices to HCI_QUIRK_BROKEN_LE_CODED
Date: Mon,  8 Apr 2024 14:34:58 +0200
Message-Id: <20240408123459.66504-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoffer Sandberg <cs@tuxedo.de>

For HW variants 0x17, 0x18 and 0x19 LE Coded PHY causes scan and
connection issues when enabled. This patch disables it through
the existing quirk.

Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>
---
 drivers/bluetooth/btintel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index cdc5c08824a0a..9f9c4696d082a 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2881,6 +2881,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	case 0x17:
 	case 0x18:
 	case 0x19:
+		/* 0x17, 0x18 and 0x19 have issues when LE Coded PHY is enabled */
+		set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
+		fallthrough;
 	case 0x1b:
 	case 0x1c:
 		/* Display version information of TLV type */
-- 
2.34.1


