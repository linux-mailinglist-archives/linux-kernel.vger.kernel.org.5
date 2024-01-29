Return-Path: <linux-kernel+bounces-43143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 255DA840C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8AF31F24A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1A81586DA;
	Mon, 29 Jan 2024 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="wjGgXT8W"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BAF1586C5;
	Mon, 29 Jan 2024 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546979; cv=none; b=pbJiVx9q2lU8ZOcs/3vdmPw9w32x1OeTD60Fdh6nmtLuNPk8JDpBoHgOLeeqCWA/yRYSJ2reBPhL6n4vp/9EGJR/eiknJG80SJsJQObsplxPnD4sI28804Sa4maUxMj3zqkwmLLAF63FIycy4NuPNCIyvjij6uuzC8cvn3bmrgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546979; c=relaxed/simple;
	bh=H/HxW2TxIVghy+7mkGk78We6/Ffzu9ybrx8Ob86h5MM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAC5piXhSGBoyXMYFke7sCWCuOkt737lCPk+82bjo82x7yYeiLXTs+whPIVAcu8yFBfC2tIL9lSZEmLY1TDtw0aYWMjoCC9vPpyhv4YVXKe0wdmYmMCMec3McNsylVS2OG/2h2pU5OGeLiGG5R6r6e7G4/WSnhQExtHxuv9fIZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=wjGgXT8W; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from localhost (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 3C5346356CC0;
	Mon, 29 Jan 2024 17:49:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1706546974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b0k2KIc+1eaBSudNc6eg9ud4brXzOimETVs/9tAFTF8=;
	b=wjGgXT8W+EhK0maE11/NDfrs5SfybtLDgVW0OmLeQzdc20cBwoeeyo/6XLQFIKG86NwuxK
	9IFhG4d7jrEstYzydA8dM+RQ7FrV72+SIXAbQwFlVP6Evs9NyNId0o6PyeaqQY/jYNyGxG
	YeclHS84KBlLYmG5E+Y/ntC1C65KeLg=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] HID: logitech-hidpp: Do not flood kernel log
Date: Mon, 29 Jan 2024 17:49:31 +0100
Message-ID: <20240129164931.38477-1-oleksandr@natalenko.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 680ee411a98e ("HID: logitech-hidpp: Fix connect event race")
the following messages appear in the kernel log from time to time:

logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
logitech-hidpp-device 0003:046D:4051.0006: Disconnected
logitech-hidpp-device 0003:046D:408A.0005: Disconnected

As discussed, print the first per-device "device connected" message
at info level, demoting subsequent messages to debug level. Also,
demote the "Disconnected message" to debug level unconditionally.

Link: https://lore.kernel.org/lkml/3277085.44csPzL39Z@natalenko.name/
Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
---
 drivers/hid/hid-logitech-hidpp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 6ef0c88e3e60a..d2f3f234f29de 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -203,6 +203,8 @@ struct hidpp_device {
 	struct hidpp_scroll_counter vertical_wheel_counter;
 
 	u8 wireless_feature_index;
+
+	bool connected_once;
 };
 
 /* HID++ 1.0 error codes */
@@ -988,8 +990,13 @@ static int hidpp_root_get_protocol_version(struct hidpp_device *hidpp)
 	hidpp->protocol_minor = response.rap.params[1];
 
 print_version:
-	hid_info(hidpp->hid_dev, "HID++ %u.%u device connected.\n",
-		 hidpp->protocol_major, hidpp->protocol_minor);
+	if (!hidpp->connected_once) {
+		hid_info(hidpp->hid_dev, "HID++ %u.%u device connected.\n",
+			 hidpp->protocol_major, hidpp->protocol_minor);
+		hidpp->connected_once = true;
+	} else
+		hid_dbg(hidpp->hid_dev, "HID++ %u.%u device connected.\n",
+			 hidpp->protocol_major, hidpp->protocol_minor);
 	return 0;
 }
 
@@ -4184,7 +4191,7 @@ static void hidpp_connect_event(struct work_struct *work)
 	/* Get device version to check if it is connected */
 	ret = hidpp_root_get_protocol_version(hidpp);
 	if (ret) {
-		hid_info(hidpp->hid_dev, "Disconnected\n");
+		hid_dbg(hidpp->hid_dev, "Disconnected\n");
 		if (hidpp->battery.ps) {
 			hidpp->battery.online = false;
 			hidpp->battery.status = POWER_SUPPLY_STATUS_UNKNOWN;
-- 
2.43.0


