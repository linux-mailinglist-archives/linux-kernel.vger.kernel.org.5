Return-Path: <linux-kernel+bounces-113613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E808885AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DAF01F23862
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F72F1D1D67;
	Sun, 24 Mar 2024 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="td5JIwy/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE801CF8D7;
	Sun, 24 Mar 2024 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320448; cv=none; b=C/EUobPwynWpnnouJGCC7BDkf+FifvPLmQ6agbaZDAKe8MvJtOQezM96JQEhSwuFdKRZeta1Cx0U8dPNSXAhLNQmv4js7JB4LTJCxs9uUgc+ZUup/C+Hilea0iIUeLIMIf8dcg4yZcvNOHyZs1qQTmF0fr5l2vNbQ/INFNLsCPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320448; c=relaxed/simple;
	bh=bnbHqN1p6Pi+S070hSgaMpfnK259Dy/ZeqRsKyuue0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tND9qmg+so64FpH2RdmlDib2m1iT+Fc9BaV2yDBo9cdglgmVV7VMN+Yri2q6QUQAhH8QDowz2A11kR2lE1b8erTC9DfKerwVEpVvEXwAM6BmzhyjtyOR4ctDOKhgxqb+li2mEjlxTfO3uJMSfBQZHeAG7aoVe6bvmzsMbDSEahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=td5JIwy/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776D8C433C7;
	Sun, 24 Mar 2024 22:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320448;
	bh=bnbHqN1p6Pi+S070hSgaMpfnK259Dy/ZeqRsKyuue0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=td5JIwy/U19v7VqG4INC0PoSKWXZuB7VtSwXwYzWDsiGlEU+VbWb0P/to5kmbAS2L
	 v4tvTjodoig34CvbTzaTA+w1Wsf9VA9isRjc55N9zFeCS4/Z5PEf9RdzFMeCGX35/9
	 MNJxKVXpgH7PY7RAgsO9UJ6x+HoWTDTBOaqJTM/IpCmLpUKKRn6jbirT6j/uF021qt
	 z2lwtKWj+9tN6k3bZbJnFUuHukJCcVqlI77dMXv+zpVp8dAC0oVLzMkd9nAxFeAuWH
	 Eq7n3ensbL4+ti3Cg8tt91HJTXymR/w2M8wo5Q8xGFLdpZ8Yxqb9HQefgb/CuHx79w
	 PiMJgHcZyApLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
	Hans de Goede <hdegoede@redhat.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 006/713] HID: logitech-hidpp: Do not flood kernel log
Date: Sun, 24 Mar 2024 18:35:32 -0400
Message-ID: <20240324224720.1345309-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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


