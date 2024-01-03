Return-Path: <linux-kernel+bounces-15003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2EF8225FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3861F20EE0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B667F2;
	Wed,  3 Jan 2024 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="T4vFW9ip"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A348562A;
	Wed,  3 Jan 2024 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from HP-EliteBook-x360-830-G8-Notebook-PC.. (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9AC47413B9;
	Wed,  3 Jan 2024 00:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704242044;
	bh=bdVOXVR9HgLgK32tp5+AqJGgXa6fNQRmR9sP0YJC1wo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=T4vFW9ipd4QRFCmHAXmnf3xZO6GxdI1lBgC4Xo5Bni4kAzbyu0ytm0VpNmO3WSaaR
	 5xHN6SQYixmJtyU8WPGXqRdL42n6cetIP/WsP6Odchdfswd/xg9fdgg6291yjIIt6Q
	 FAH7U/altV3TOrJF9op3cibL6Z48YhNt7L+ycbUeG2avWgc+78/LDr7b/VwwXXQN0e
	 DDTTD+AHWU+lH2ClFAg0xI3xWMcXACHLqNVIDXJsZmG69qaMz+OQu7pKPDqhLOK0vj
	 OH2m08quqJgMTYbz5sSFEius7xtxDB+2GkRpTyBt3Dx63pR0l1Bn5dhCD1b9TJuJdr
	 cEzg6uHQYFcdQ==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: jikos@kernel.org,
	benjamin.tissoires@redhat.com
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Douglas Anderson <dianders@chromium.org>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Johan Hovold <johan+linaro@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: i2c-hid: Remove SET_POWER SLEEP on system suspend
Date: Wed,  3 Jan 2024 08:33:53 +0800
Message-Id: <20240103003355.747335-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's a Cirque touchpad that wakes system up without anything touched
the touchpad. The input report is empty when this happens.
The reason is stated in HID over I2C spec, 7.2.8.2:
"If the DEVICE wishes to wake the HOST from its low power state, it can
issue a wake by asserting the interrupt."

This is fine if OS can put system back to suspend by identifying input
wakeup count stays the same on resume, like Chrome OS Dark Resume [0].
But for regular distro such policy is lacking.

According to commit d9f448e3d71f ("HID: i2c-hid: set power sleep before
shutdown"), SLEEP is required for shutdown, in addition to that, commit
67b18dfb8cfc ("HID: i2c-hid: Remove runtime power management") didn't
notice any power comsumption reduction from SET_POWER SLEEP, so also
remove that to avoid the device asserting the interrupt.

[0] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/power_manager/docs/dark_resume.md

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 2735cd585af0..dd513dc75cb9 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -957,9 +957,6 @@ static int i2c_hid_core_suspend(struct i2c_hid *ihid, bool force_poweroff)
 	if (ret < 0)
 		return ret;
 
-	/* Save some power */
-	i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);
-
 	disable_irq(client->irq);
 
 	if (force_poweroff || !device_may_wakeup(&client->dev))
-- 
2.34.1


