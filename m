Return-Path: <linux-kernel+bounces-113436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0C0888450
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6601C23CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C591AB8F9;
	Sun, 24 Mar 2024 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJwqp55/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA71AB8DC;
	Sun, 24 Mar 2024 22:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320238; cv=none; b=iXn32oZBQQWmX/n4X1wJbAVGgv8rGWKD+UY9B2/LN2QNYsqNKcu+HGZiknNfgwtAxmBmxTKaC5/vdlpKgMDV1fucxpRwIb2VBuHYjnsDdddUxj+yyxihIavdPEM8eKBO+CncMqzbSTIWxQKVBglCxsysGWTHCMSM7LD3vJBWsrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320238; c=relaxed/simple;
	bh=x5Z2U2sZ/wjxckwbw2SHRMmbWv6kH7BFOJn9gUVeHbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1HFp5yvL5cIurqML3AaVokIdadjV+4HGQZDagcD1+9RkH6hMU8TovBLYpVPjOv+2NFw1DorTcuB9qpH3AJIF+Rvv0sOsbzSVgbGqVTizXMVY1SXLnG18mAIjt94kGwTy0biLeS5luBbf0dKGtGFjja6KVbF73fzV79XSgTmcUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJwqp55/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDC7C43394;
	Sun, 24 Mar 2024 22:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320238;
	bh=x5Z2U2sZ/wjxckwbw2SHRMmbWv6kH7BFOJn9gUVeHbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJwqp55/+xFAlhD78x/KC1d+//bIB8d0wXQoidB6O+MywSX0yE4K9N68YpbGiyV0N
	 Bk/jYVbLeRYO0+unqTObKuQWFMrJuzF9+vf/LGwJykM8Q9GYINuiug2Dkmnd7plquF
	 2HdVn+3oWvmTU7RT8fhvHdLE7u3T/BIQTwpuLrMMoKiEVBH1KfQ9IMoiYH9Zlgd8cR
	 cPzGQX+wfiNDq/QI2R4cZDCOsHPPElO2yZFyt8syhXHKbb8agHQupBf8GdAfQlusvc
	 og7spDzO5arszsD9BFXS8YhFGHBY7UiWMheMTOGfC8aIIlsAyfAKuN5jgkpVf9Ye4y
	 sEPQw3r9X+dSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 545/715] ALSA: scarlett2: Fix Scarlett 4th Gen autogain status values
Date: Sun, 24 Mar 2024 18:32:04 -0400
Message-ID: <20240324223455.1342824-546-sashal@kernel.org>
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

[ Upstream commit be157c4683a91857d3fdf319117c9b9dc6e8a849 ]

The meanings of the raw_auto_gain_status values were originally
guessed through experimentation, but the official names have now been
discovered. Update the autogain status control strings accordingly.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Fixes: 0a995e38dc44 ("ALSA: scarlett2: Add support for software-controllable input gain")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Message-ID: <8bd12a5e7dc714801dd9887c4bc5cb35c384e27c.1710047969.git.g@b4.vu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett2.c | 62 ++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index bce69a78c5052..3815ce1d216e6 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -284,14 +284,22 @@ static const char *const scarlett2_dim_mute_names[SCARLETT2_DIM_MUTE_COUNT] = {
 	"Mute Playback Switch", "Dim Playback Switch"
 };
 
-/* Autogain Status Values */
-enum {
-	SCARLETT2_AUTOGAIN_STATUS_STOPPED,
-	SCARLETT2_AUTOGAIN_STATUS_RUNNING,
-	SCARLETT2_AUTOGAIN_STATUS_FAILED,
-	SCARLETT2_AUTOGAIN_STATUS_CANCELLED,
-	SCARLETT2_AUTOGAIN_STATUS_UNKNOWN,
-	SCARLETT2_AUTOGAIN_STATUS_COUNT
+/* The autogain_status is set based on the autogain_switch and
+ * raw_autogain_status values.
+ *
+ * If autogain_switch is set, autogain_status is set to 0 (Running).
+ * The other status values are from the raw_autogain_status value + 1.
+ */
+static const char *const scarlett2_autogain_status_texts[] = {
+	"Running",
+	"Success",
+	"SuccessDRover",
+	"WarnMinGainLimit",
+	"FailDRunder",
+	"FailMaxGainLimit",
+	"FailClipped",
+	"Cancelled",
+	"Invalid"
 };
 
 /* Power Status Values */
@@ -2835,9 +2843,9 @@ static int scarlett2_autogain_is_running(struct scarlett2_data *private)
 {
 	int i;
 
+	/* autogain_status[] is 0 if autogain is running */
 	for (i = 0; i < private->info->gain_input_count; i++)
-		if (private->autogain_status[i] ==
-		    SCARLETT2_AUTOGAIN_STATUS_RUNNING)
+		if (!private->autogain_status[i])
 			return 1;
 
 	return 0;
@@ -2867,25 +2875,25 @@ static int scarlett2_update_autogain(struct usb_mixer_interface *mixer)
 		return err;
 
 	/* Translate autogain_switch and raw_autogain_status into
-	 * autogain_status
+	 * autogain_status.
+	 *
+	 * When autogain_switch[] is set, the status is the first
+	 * element in scarlett2_autogain_status_texts[] (Running). The
+	 * subsequent elements correspond to the status value from the
+	 * device (raw_autogain_status[]) + 1. The last element is
+	 * "Invalid", in case the device reports a status outside the
+	 * range of scarlett2_autogain_status_texts[].
 	 */
 	for (i = 0; i < info->gain_input_count; i++)
 		if (private->autogain_switch[i])
+			private->autogain_status[i] = 0;
+		else if (raw_autogain_status[i] <
+				ARRAY_SIZE(scarlett2_autogain_status_texts) - 1)
 			private->autogain_status[i] =
-				SCARLETT2_AUTOGAIN_STATUS_RUNNING;
-		else if (raw_autogain_status[i] == 0)
-			private->autogain_status[i] =
-				SCARLETT2_AUTOGAIN_STATUS_STOPPED;
-		else if (raw_autogain_status[i] >= 2 &&
-			 raw_autogain_status[i] <= 5)
-			private->autogain_status[i] =
-				SCARLETT2_AUTOGAIN_STATUS_FAILED;
-		else if (raw_autogain_status[i] == 6)
-			private->autogain_status[i] =
-				SCARLETT2_AUTOGAIN_STATUS_CANCELLED;
+				raw_autogain_status[i] + 1;
 		else
 			private->autogain_status[i] =
-				SCARLETT2_AUTOGAIN_STATUS_UNKNOWN;
+				ARRAY_SIZE(scarlett2_autogain_status_texts) - 1;
 
 	return 0;
 }
@@ -3111,12 +3119,10 @@ static int scarlett2_autogain_switch_ctl_put(
 static int scarlett2_autogain_status_ctl_info(
 	struct snd_kcontrol *kctl, struct snd_ctl_elem_info *uinfo)
 {
-	static const char *const values[SCARLETT2_AUTOGAIN_STATUS_COUNT] = {
-		"Stopped", "Running", "Failed", "Cancelled", "Unknown"
-	};
-
 	return snd_ctl_enum_info(
-		uinfo, 1, SCARLETT2_AUTOGAIN_STATUS_COUNT, values);
+		uinfo, 1,
+		ARRAY_SIZE(scarlett2_autogain_status_texts),
+		scarlett2_autogain_status_texts);
 }
 
 static const struct snd_kcontrol_new scarlett2_autogain_switch_ctl = {
-- 
2.43.0


