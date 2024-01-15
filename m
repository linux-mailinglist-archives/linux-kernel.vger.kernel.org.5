Return-Path: <linux-kernel+bounces-26148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6202982DBF5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31991F22AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC61A175B9;
	Mon, 15 Jan 2024 14:58:08 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB4617586;
	Mon, 15 Jan 2024 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 41FB5101643;
	Mon, 15 Jan 2024 14:48:47 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	max@enpas.org
Subject: [PATCH v1 2/7] HID: playstation: DS4: Don't fail on MAC address request
Date: Mon, 15 Jan 2024 23:45:33 +0900
Message-Id: <20240115144538.12018-3-max@enpas.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115144538.12018-1-max@enpas.org>
References: <20240115144538.12018-1-max@enpas.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some third-party controllers can't report their MAC address.

Since a unique ID is needed for ps_devices_list_add() and
ps_device_register_battery(), let's use hdev->id for this when we don't
have a MAC address.

Signed-off-by: Max Staudt <max@enpas.org>
---
 drivers/hid/hid-playstation.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 7f50e13601f0..0a3c442af305 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -1966,7 +1966,10 @@ static int dualshock4_get_mac_address(struct dualshock4 *ds4)
 				DS4_FEATURE_REPORT_PAIRING_INFO_SIZE, false);
 		if (ret) {
 			hid_err(hdev, "Failed to retrieve DualShock4 pairing info: %d\n", ret);
-			goto err_free;
+			hid_err(hdev, "Generating fake MAC address for this device.\n");
+			buf[1] = (hdev->id >>  0) & 0xff;
+			buf[2] = (hdev->id >>  8) & 0xff;
+			buf[3] = (hdev->id >> 16) & 0xff;
 		}
 
 		memcpy(ds4->base.mac_address, &buf[1], sizeof(ds4->base.mac_address));
@@ -1986,7 +1989,6 @@ static int dualshock4_get_mac_address(struct dualshock4 *ds4)
 		return 0;
 	}
 
-err_free:
 	kfree(buf);
 	return ret;
 }
@@ -2552,7 +2554,7 @@ static struct ps_device *dualshock4_create(struct hid_device *hdev)
 	ret = dualshock4_get_mac_address(ds4);
 	if (ret) {
 		hid_err(hdev, "Failed to get MAC address from DualShock4\n");
-		return ERR_PTR(ret);
+		hid_err(hdev, "Can't detect simultaneous USB/BT connections from this device.\n");
 	}
 	snprintf(hdev->uniq, sizeof(hdev->uniq), "%pMR", ds4->base.mac_address);
 
-- 
2.39.2


