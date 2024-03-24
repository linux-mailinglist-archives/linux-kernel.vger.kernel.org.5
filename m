Return-Path: <linux-kernel+bounces-113435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36F188844E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110471C23CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767AC1AB8DB;
	Sun, 24 Mar 2024 22:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNn84Zom"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8537070CBF;
	Sun, 24 Mar 2024 22:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320237; cv=none; b=H8g9utkKr0Fn0FC2pe4++gorhnFsE6orBx1i3KMLNOinV5Zq0hfl7jxQSNApK8fCg3uMvbWvf1Jwv+jq9BemT0nQ9sPe//z7KIbQWAnYaf5m93kWTvyJDTPh+qyDLKYa5L8xZj132PaWkcVMAblzWXLD/hRNcKjfsauTqWswPGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320237; c=relaxed/simple;
	bh=GlPov+e3ysjuzy4gqE4z2YW4XPhB6YiJ/TuVT6ZQRxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+Tw29aVPdxT4CiqKMxF5ItRnj32JwCV3HDyp/Jr16sYuGJFxP7LLw2IRbnaHMZUABk2DfI2gCwODgvZ5yu7cXx06No649SRxmlWbdEw6QR5R3xwGUDZEn4PiKoj79vU8co1TjH0HOdBrE/eeeYM3mZS68dyvg4Rvsb/dqShOvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNn84Zom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49E4C43390;
	Sun, 24 Mar 2024 22:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320237;
	bh=GlPov+e3ysjuzy4gqE4z2YW4XPhB6YiJ/TuVT6ZQRxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SNn84Zom5uJBft65RhP87u1jfNwFJqHdQ5mjMNuIDSpbSm36cC2hPHnAmz/5Pc4Ya
	 t2ndBB9nvFYHZLoUqn6LpqttWxdPLdYfFxN1t41NZaVkGXFRhwasd1awzedppz2m+r
	 OcVAfftSdl9whEngl3uFQ+OOWhSEoCyr2Y+Mx0Ll/k1u08Pu54hT59kxv/GmWwf/DC
	 lplGp7UZE1MpLBpsG6/2+SdSjQu7McG18mTGXG6VPej0jdZjlzwX8cgwLunZUU2EQE
	 jBwbqw9cL1qDqSBr7wGphVWdjZNggalqj4EpHXafuwESh5cNxAixg2fyeW7JqdWjhX
	 RIn6eA3pzsPLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 544/715] ALSA: scarlett2: Fix Scarlett 4th Gen 4i4 low-voltage detection
Date: Sun, 24 Mar 2024 18:32:03 -0400
Message-ID: <20240324223455.1342824-545-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: "Geoffrey D. Bennett" <g@b4.vu>

[ Upstream commit 6ef1f08b53fdb6f5f00f17f85a60b3247d77fa54 ]

The value currently being read to determine the low-voltage state is
actually the front panel state. Fix the code to use the correct offset
for the low-voltage state.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Fixes: d7cfa2fdfc8a ("ALSA: scarlett2: Add power status control")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Message-ID: <d97b7d87f43b0e54f37e1552394be2f3ae182704.1710047969.git.g@b4.vu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett2.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index 6de605a601e5f..bce69a78c5052 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -415,7 +415,7 @@ enum {
 	SCARLETT2_CONFIG_INPUT_SELECT_SWITCH,
 	SCARLETT2_CONFIG_INPUT_LINK_SWITCH,
 	SCARLETT2_CONFIG_POWER_EXT,
-	SCARLETT2_CONFIG_POWER_STATUS,
+	SCARLETT2_CONFIG_POWER_LOW,
 	SCARLETT2_CONFIG_PCM_INPUT_SWITCH,
 	SCARLETT2_CONFIG_DIRECT_MONITOR_GAIN,
 	SCARLETT2_CONFIG_COUNT
@@ -723,8 +723,8 @@ static const struct scarlett2_config_set scarlett2_config_set_gen4_4i4 = {
 		[SCARLETT2_CONFIG_POWER_EXT] = {
 			.offset = 0x168 },
 
-		[SCARLETT2_CONFIG_POWER_STATUS] = {
-			.offset = 0x66 }
+		[SCARLETT2_CONFIG_POWER_LOW] = {
+			.offset = 0x16d }
 	}
 };
 
@@ -6294,8 +6294,7 @@ static int scarlett2_update_power_status(struct usb_mixer_interface *mixer)
 {
 	struct scarlett2_data *private = mixer->private_data;
 	int err;
-	u8 power_ext;
-	u8 power_status;
+	u8 power_ext, power_low;
 
 	private->power_status_updated = 0;
 
@@ -6304,12 +6303,12 @@ static int scarlett2_update_power_status(struct usb_mixer_interface *mixer)
 	if (err < 0)
 		return err;
 
-	err = scarlett2_usb_get_config(mixer, SCARLETT2_CONFIG_POWER_STATUS,
-				       1, &power_status);
+	err = scarlett2_usb_get_config(mixer, SCARLETT2_CONFIG_POWER_LOW,
+				       1, &power_low);
 	if (err < 0)
 		return err;
 
-	if (power_status > 1)
+	if (power_low)
 		private->power_status = SCARLETT2_POWER_STATUS_FAIL;
 	else if (power_ext)
 		private->power_status = SCARLETT2_POWER_STATUS_EXT;
-- 
2.43.0


