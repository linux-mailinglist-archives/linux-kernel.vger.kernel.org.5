Return-Path: <linux-kernel+bounces-102012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6BA87AD92
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30801C22471
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895E214E2E5;
	Wed, 13 Mar 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxeZgdjf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C3914E2C9;
	Wed, 13 Mar 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348225; cv=none; b=i479BvO+If8XGU15UdRDbToOMUY3TrqxoOMRj1SJZOdy/3brUQbQsRlLpfalZfTNEoUuOHYEBBsmL1gZ+BAWWM4CFjjuoRSPdSJ4D5oBzQf7zT0BpId8DBBalf/JOOGLHV5IFzBgro3OHvbpMXjEhXyoAnF/h9Ne2ggeSUFjub0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348225; c=relaxed/simple;
	bh=LUfg0XTepmWmbWbCCa61wEGCuowP79X8chJrlyHlpsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHzQUCWWhl4YazXdmk8UrH25cLdR0yABQ8/tXXRnQBw7XKiF0xcO1+++UA9PJwJZ5HVCwtgDHBEq/zJexmbw+7WVr8KNAf6J5VfgclNNm9i1pQndYiDLuIYVLIiKvbfk9C7mbeln0akmPbSYyDT1eD8m3gsGWdrUhtBlrwzXiW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxeZgdjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976C7C43390;
	Wed, 13 Mar 2024 16:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348225;
	bh=LUfg0XTepmWmbWbCCa61wEGCuowP79X8chJrlyHlpsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XxeZgdjft12zwKxMyBx45Arl3mKMr9yag7qQQAb2thIVu0F4/TNLSNw79gzmTxtZE
	 EY/vUicWnQ4eo9LBVuORzqqq3o9hL4hoVHOt2otfmAK5UvGXpv3ABUJ52hJxkuWcAS
	 NfkIQcj3jI7jLAFW2dh8Gx2OmuyUrfxoaZ/5++0XQIZQe6voqA0lrMmWNFqbg4o8Jz
	 Hj12vRFR46+i3Tlv7msZdk/CsQuzzoGLWpKVAvjr62YNFyGla8ymTpM7gHPbXJwyDH
	 AstV0oBudDHgwZTrTRHJq6cZRghzLVLhQjMxTaY4W58CGb4fZn+/q+cgyw0ecf6fxN
	 jyohBb1E5yyvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 71/76] ALSA: usb-audio: Sort quirk table entries
Date: Wed, 13 Mar 2024 12:42:18 -0400
Message-ID: <20240313164223.615640-72-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 668abe6dc7b61941fa5c724c06797efb0b87f070 ]

The quirk table entries should be put in the USB ID order, but some
entries have been put in random places.  Re-sort them.

Fixes: bf990c102319 ("ALSA: usb-audio: add quirk to fix Hamedal C20 disconnect issue")
Fixes: fd28941cff1c ("ALSA: usb-audio: Add new quirk FIXED_RATE for JBL Quantum810 Wireless")
Fixes: dfd5fe19db7d ("ALSA: usb-audio: Add FIXED_RATE quirk for JBL Quantum610 Wireless")
Fixes: 4a63e68a2951 ("ALSA: usb-audio: Fix microphone sound on Nexigo webcam.")
Fixes: 7822baa844a8 ("ALSA: usb-audio: add quirk for RODE NT-USB+")
Fixes: 4fb7c24f69c4 ("ALSA: usb-audio: Add quirk for Fiero SC-01")
Fixes: 2307a0e1ca0b ("ALSA: usb-audio: Add quirk for Fiero SC-01 (fw v1.0.0)")
Link: https://lore.kernel.org/r/20240124155307.16996-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 3073570beb3e2..1226ce5d5a304 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1765,6 +1765,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x04e8, 0xa051, /* Samsung USBC Headset (AKG) */
 		   QUIRK_FLAG_SKIP_CLOCK_SELECTOR | QUIRK_FLAG_CTL_MSG_DELAY_5M),
+	DEVICE_FLG(0x0525, 0xa4ad, /* Hamedal C20 usb camero */
+		   QUIRK_FLAG_IFACE_SKIP_CLOSE),
 	DEVICE_FLG(0x054c, 0x0b8c, /* Sony WALKMAN NW-A45 DAC */
 		   QUIRK_FLAG_SET_IFACE_FIRST),
 	DEVICE_FLG(0x0556, 0x0014, /* Phoenix Audio TMX320VC */
@@ -1808,8 +1810,14 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0b0e, 0x0349, /* Jabra 550a */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
+		   QUIRK_FLAG_FIXED_RATE),
+	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
+		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0fd9, 0x0008, /* Hauppauge HVR-950Q */
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
+	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1395, 0x740a, /* Sennheiser DECT */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1397, 0x0507, /* Behringer UMC202HD */
@@ -1840,6 +1848,10 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
 	DEVICE_FLG(0x1901, 0x0191, /* GE B850V3 CP2114 audio interface */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x19f7, 0x0035, /* RODE NT-USB+ */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x1bcf, 0x2283, /* NexiGo N930AF FHD Webcam */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x2040, 0x7200, /* Hauppauge HVR-950Q */
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x2040, 0x7201, /* Hauppauge HVR-950Q-MXL */
@@ -1878,6 +1890,12 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x2b53, 0x0023, /* Fiero SC-01 (firmware v1.0.0 @ 48 kHz) */
+		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
+	DEVICE_FLG(0x2b53, 0x0024, /* Fiero SC-01 (firmware v1.0.0 @ 96 kHz) */
+		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
+	DEVICE_FLG(0x2b53, 0x0031, /* Fiero SC-01 (firmware v1.1.0) */
+		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x30be, 0x0101, /* Schiit Hel */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x413c, 0xa506, /* Dell AE515 sound bar */
@@ -1886,24 +1904,6 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x534d, 0x2109, /* MacroSilicon MS2109 */
 		   QUIRK_FLAG_ALIGN_TRANSFER),
-	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
-		   QUIRK_FLAG_GET_SAMPLE_RATE),
-	DEVICE_FLG(0x2b53, 0x0023, /* Fiero SC-01 (firmware v1.0.0 @ 48 kHz) */
-		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
-	DEVICE_FLG(0x2b53, 0x0024, /* Fiero SC-01 (firmware v1.0.0 @ 96 kHz) */
-		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
-	DEVICE_FLG(0x2b53, 0x0031, /* Fiero SC-01 (firmware v1.1.0) */
-		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
-	DEVICE_FLG(0x0525, 0xa4ad, /* Hamedal C20 usb camero */
-		   QUIRK_FLAG_IFACE_SKIP_CLOSE),
-	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
-		   QUIRK_FLAG_FIXED_RATE),
-	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
-		   QUIRK_FLAG_FIXED_RATE),
-	DEVICE_FLG(0x1bcf, 0x2283, /* NexiGo N930AF FHD Webcam */
-		   QUIRK_FLAG_GET_SAMPLE_RATE),
-	DEVICE_FLG(0x19f7, 0x0035, /* RODE NT-USB+ */
-		   QUIRK_FLAG_GET_SAMPLE_RATE),
 
 	/* Vendor matches */
 	VENDOR_FLG(0x045e, /* MS Lifecam */
-- 
2.43.0


