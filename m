Return-Path: <linux-kernel+bounces-11196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F4081E310
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146691C21315
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621B133D0;
	Tue, 26 Dec 2023 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N57gJGGK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A03205;
	Tue, 26 Dec 2023 00:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9F4C433CD;
	Tue, 26 Dec 2023 00:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550032;
	bh=oBckVlw1lB1B5lSRO8mFEoh2gdCREBT4gVg3mQrp1lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N57gJGGKALpOtihQqHYKefyfUenLoIGD+J1dTsRtJ8O/FnjlgyovfDjtG0BFWAyfG
	 SNaWqvY25NOhmI/ST211Rk1+xfcvAZ4jRBkP8FmA7ppAH9LN6Www42/VzK3Lvupgc0
	 JfabEKeN5QhAiRhOBaatvVJgf6HZ2F+5WV1WvgcIqluEZ7v4kQQXvupbBP7DYr08T+
	 K+DOCRf5cO3S8LpalRK3AZpVZOaZLGsAUuRfqiWlUSTlOoTzKJkIVstLAcIJwNC1Ke
	 ghI2dCGmEsGhQzh5M4TDWgoE86NSlteix5QWQIr7H6OBDawnOd2SGw8mRyfeQ8Gp+j
	 4omRXNgXNVy+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Shang Ye <yesh25@mail2.sysu.edu.cn>,
	gurevitch <mail@gurevit.ch>,
	Egor Ignatov <egori@altlinux.org>,
	Anton Zhilyaev <anton@cpp.in>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	rrangel@chromium.org,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/39] Input: atkbd - skip ATKBD_CMD_GETID in translated mode
Date: Mon, 25 Dec 2023 19:18:53 -0500
Message-ID: <20231226002021.4776-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 936e4d49ecbc8c404790504386e1422b599dec39 ]

There have been multiple reports of keyboard issues on recent laptop models
which can be worked around by setting i8042.dumbkbd, with the downside
being this breaks the capslock LED.

It seems that these issues are caused by recent laptops getting confused by
ATKBD_CMD_GETID. Rather then adding and endless growing list of quirks for
this, just skip ATKBD_CMD_GETID alltogether on laptops in translated mode.

The main goal of sending ATKBD_CMD_GETID is to skip binding to ps/2
mice/touchpads and those are never used in translated mode.

Examples of laptop models which benefit from skipping ATKBD_CMD_GETID:

* "HP Laptop 15s-fq2xxx", "HP laptop 15s-fq4xxx" and "HP Laptop 15-dy2xxx"
  models the kbd stops working for the first 2 - 5 minutes after boot
  (waiting for EC watchdog reset?)

* On "HP Spectre x360 13-aw2xxx" atkbd fails to probe the keyboard

* At least 9 different Lenovo models have issues with ATKBD_CMD_GETID, see:
  https://github.com/yescallop/atkbd-nogetid

This has been tested on:

1. A MSI B550M PRO-VDH WIFI desktop, where the i8042 controller is not
   in translated mode when no keyboard is plugged in and with a ps/2 kbd
   a "AT Translated Set 2 keyboard" /dev/input/event# node shows up

2. A Lenovo ThinkPad X1 Yoga gen 8 (always has a translated set 2 keyboard)

Reported-by: Shang Ye <yesh25@mail2.sysu.edu.cn>
Closes: https://lore.kernel.org/linux-input/886D6167733841AE+20231017135318.11142-1-yesh25@mail2.sysu.edu.cn/
Closes: https://github.com/yescallop/atkbd-nogetid
Reported-by: gurevitch <mail@gurevit.ch>
Closes: https://lore.kernel.org/linux-input/2iAJTwqZV6lQs26cTb38RNYqxvsink6SRmrZ5h0cBUSuf9NT0tZTsf9fEAbbto2maavHJEOP8GA1evlKa6xjKOsaskDhtJWxjcnrgPigzVo=@gurevit.ch/
Reported-by: Egor Ignatov <egori@altlinux.org>
Closes: https://lore.kernel.org/all/20210609073333.8425-1-egori@altlinux.org/
Reported-by: Anton Zhilyaev <anton@cpp.in>
Closes: https://lore.kernel.org/linux-input/20210201160336.16008-1-anton@cpp.in/
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2086156
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20231115174625.7462-1-hdegoede@redhat.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/atkbd.c | 46 +++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index c92e544c792df..786f00f6b7fd8 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -765,6 +765,44 @@ static void atkbd_deactivate(struct atkbd *atkbd)
 			ps2dev->serio->phys);
 }
 
+#ifdef CONFIG_X86
+static bool atkbd_is_portable_device(void)
+{
+	static const char * const chassis_types[] = {
+		"8",	/* Portable */
+		"9",	/* Laptop */
+		"10",	/* Notebook */
+		"14",	/* Sub-Notebook */
+		"31",	/* Convertible */
+		"32",	/* Detachable */
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(chassis_types); i++)
+		if (dmi_match(DMI_CHASSIS_TYPE, chassis_types[i]))
+			return true;
+
+	return false;
+}
+
+/*
+ * On many modern laptops ATKBD_CMD_GETID may cause problems, on these laptops
+ * the controller is always in translated mode. In this mode mice/touchpads will
+ * not work. So in this case simply assume a keyboard is connected to avoid
+ * confusing some laptop keyboards.
+ *
+ * Skipping ATKBD_CMD_GETID ends up using a fake keyboard id. Using a fake id is
+ * ok in translated mode, only atkbd_select_set() checks atkbd->id and in
+ * translated mode that is a no-op.
+ */
+static bool atkbd_skip_getid(struct atkbd *atkbd)
+{
+	return atkbd->translated && atkbd_is_portable_device();
+}
+#else
+static inline bool atkbd_skip_getid(struct atkbd *atkbd) { return false; }
+#endif
+
 /*
  * atkbd_probe() probes for an AT keyboard on a serio port.
  */
@@ -794,12 +832,12 @@ static int atkbd_probe(struct atkbd *atkbd)
  */
 
 	param[0] = param[1] = 0xa5;	/* initialize with invalid values */
-	if (ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
+	if (atkbd_skip_getid(atkbd) || ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
 
 /*
- * If the get ID command failed, we check if we can at least set the LEDs on
- * the keyboard. This should work on every keyboard out there. It also turns
- * the LEDs off, which we want anyway.
+ * If the get ID command was skipped or failed, we check if we can at least set
+ * the LEDs on the keyboard. This should work on every keyboard out there.
+ * It also turns the LEDs off, which we want anyway.
  */
 		param[0] = 0;
 		if (ps2_command(ps2dev, param, ATKBD_CMD_SETLEDS))
-- 
2.43.0


