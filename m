Return-Path: <linux-kernel+bounces-122946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A477A88FFF6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5997F1F23D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B36080025;
	Thu, 28 Mar 2024 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="P5iDDXBy"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1A02BAE3;
	Thu, 28 Mar 2024 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711631894; cv=none; b=CBOWHnMuBZ1GGzSSgBU6gFm9Dvd/5H1Cs2KGdBHCHgdgM1moZImB53SguuJYHYPSGHsMMICrDrDOAGmgPxWYUrJoQSISVoDzHKzljnjI9LU9e2QtdJ6SwIVkbD+uRhJTtV6HLs/rROi1oreCkcMZ+vJ7yIPE0H5SraNIPFQgt8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711631894; c=relaxed/simple;
	bh=67vjIF9w0ICYAGUq2Ry/04uvh/bSWhp04DB+A5Eo/Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jfg8uiaLp7dk3Xr/lXxORPWxSpj5bj+d9KRbBcb/iDhM7vVYl8Tgo2Y3QCSXYoYhY6iNZXhp2sGWMbcuBWHrCJGyxFRxcz69Yh0pK8EIIe4YQHGeaoeUEjoOGeeYhrBAmuhYrJc69UMEtU5/da8bgxruGltPBrK+Yc9dxY6Qe50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=P5iDDXBy; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse.fritz.box (pd9e59192.dip0.t-ipconnect.de [217.229.145.146])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id B80CC2FC0063;
	Thu, 28 Mar 2024 14:18:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1711631887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AYoQ7bZBk+K3E6UfUVXK8CI/yzdDxiWg0KhvoBMn5kc=;
	b=P5iDDXBytLqpKlT66TPZ4zvYBLwvNobMQNQYrXYQJpmqjiQXvowz3Od/YRZdaXsw09ajxq
	qkvgMNJ2rO4iJjYS2RzL8hAryKwYandaAIe1aFzxyhCpGnxDAH/LbE9bd36ytp4ks5fr2T
	HBcAr8x02LJxlWikpMeZ3TBvB+HCCYk=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Christoffer Sandberg <cs@tuxedo.de>,
	Werner Sembach <wse@tuxedocomputers.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel: Add devices to HCI_QUIRK_BROKEN_LE_CODED
Date: Thu, 28 Mar 2024 14:18:00 +0100
Message-Id: <20240328131800.63328-1-wse@tuxedocomputers.com>
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
 drivers/bluetooth/btintel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index cdc5c08824a0a..6dbfb74d0adf9 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2881,6 +2881,8 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	case 0x17:
 	case 0x18:
 	case 0x19:
+		/* 0x17, 0x18 and 0x19 have issues when LE Coded PHY is enabled */
+		set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
 	case 0x1b:
 	case 0x1c:
 		/* Display version information of TLV type */
-- 
2.34.1


