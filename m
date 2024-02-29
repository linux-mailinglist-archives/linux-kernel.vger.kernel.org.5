Return-Path: <linux-kernel+bounces-86951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ED786CD72
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5D92877B6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E0E151CCD;
	Thu, 29 Feb 2024 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pd5huMZz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7F21509B1;
	Thu, 29 Feb 2024 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221739; cv=none; b=ooXh+UWdDeJLkAuv6dkokwosoibcVLAMFx+PuJ6VsjLjDZbvsggsV8dhDSE0gGlz/49hlBssdt+HyoSEJTeX2UuDSTs6r/GLQ8sMDNJDtymw3W29lOoW/MfVsggb64JGbDFHJ3m7Ljhr1c2RoAI7Yuh52bk8esUGuxFzepFLGe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221739; c=relaxed/simple;
	bh=aIRyXvmgRyZnTFWiYbSLRS3WFje6cM1cG1tedA4/0vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwHkmm0Y0ognL87cfLu8feffKRQNhMqVBIDto4plt0c6U6ckKEl+DBQPqHIQRXOTBX4nAgEZ2rxFe57QH2K39CHE8RS8FhPrX44TulKRb/6FA1ifQUgN7XSDuyWHQ635x4x8Syv61fopDeFmK03Vn8X5/PsoL7J8n/sm+D9ylN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pd5huMZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917D4C43390;
	Thu, 29 Feb 2024 15:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221738;
	bh=aIRyXvmgRyZnTFWiYbSLRS3WFje6cM1cG1tedA4/0vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pd5huMZzMxtJ1DwTqQhnTK9n1rcPIyrnhp0GTLxZZx5qI++DOVTyf/l53pwQgWWFx
	 ccuyE/JnhxKglde654biDyHYiieuqVdHwaSwEhBJKctfOQW5coEBOZkxraTNB7lS6G
	 3bdUYHO0Ug+yggG+/FULxrbYcWBGpa//+8+w3dRNwTtGekOcoHxSPTvRJ9o1+3gFdu
	 MOP9DtNi3mK0wATyNle901+/JTFPfw4VvYhVcIpU1CD7CHjiDX/5cBEfEOV7tHpi87
	 TvEnL4Snm2mR8JN0oJrHBlECMpRwq5SAC2MfHKFoM+XK6q2zBrJBslUtqOYgUd3F/h
	 li4c+MZz4psKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
	Hans de Goede <hdegoede@redhat.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 04/26] HID: logitech-hidpp: Do not flood kernel log
Date: Thu, 29 Feb 2024 10:48:23 -0500
Message-ID: <20240229154851.2849367-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154851.2849367-1-sashal@kernel.org>
References: <20240229154851.2849367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
Content-Transfer-Encoding: 8bit

From: Oleksandr Natalenko <oleksandr@natalenko.name>

[ Upstream commit 411a20db905b44e18cc9129b745f1d5deba4eae5 ]

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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index fd6d8f1d9b8f6..6ecf40a902369 100644
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


