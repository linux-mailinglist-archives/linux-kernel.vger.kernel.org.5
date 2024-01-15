Return-Path: <linux-kernel+bounces-26137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0A882DBD6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC0C282B38
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DB71773D;
	Mon, 15 Jan 2024 14:48:57 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FDF175B6;
	Mon, 15 Jan 2024 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id D55ED101649;
	Mon, 15 Jan 2024 14:48:49 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	max@enpas.org
Subject: [PATCH v1 3/7] HID: playstation: DS4: Don't fail on FW/HW version request
Date: Mon, 15 Jan 2024 23:45:34 +0900
Message-Id: <20240115144538.12018-4-max@enpas.org>
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

Some third-party controllers can't report firmware/hardware version.

Unlike for the DualSense, the driver does not use these values for
anything in the DualShock 4 case, but merely exposes them via sysfs.
They will simply be 0x0.

Signed-off-by: Max Staudt <max@enpas.org>
---
 drivers/hid/hid-playstation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 0a3c442af305..12321cae4416 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -2561,7 +2561,7 @@ static struct ps_device *dualshock4_create(struct hid_device *hdev)
 	ret = dualshock4_get_firmware_info(ds4);
 	if (ret) {
 		hid_err(hdev, "Failed to get firmware info from DualShock4\n");
-		return ERR_PTR(ret);
+		hid_err(hdev, "HW/FW version data in sysfs will be invalid.\n");
 	}
 
 	ret = ps_devices_list_add(ps_dev);
-- 
2.39.2


