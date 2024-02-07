Return-Path: <linux-kernel+bounces-57158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C884D497
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAC71C20EC5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D369134CE7;
	Wed,  7 Feb 2024 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbhkpxmK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E51415699C;
	Wed,  7 Feb 2024 21:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341125; cv=none; b=SB0JDqXDD/R8iog+kphf3thcRoMpN9trnal/ehCtIq0oGLCCeshC/oC+2TsOJO0kBI1tpdHu4XHsTA9tTwsOinGNHe/yowc58OHEQOQ9jHyjginI8soDSStqbk8gEJAQGkxHwSX3k5jlWqehiqPHpFDac0RCB/XSk7bRfQLjFD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341125; c=relaxed/simple;
	bh=GeYMdViIZNwyqOKQLAvWZAyDii0ag5jF9idqaEjWLqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=puLaDD5KPR+cg4AdCYsXsu6vB9e8DpDy/yoXTYyiiFZ/JH2JjMq6PZ0fsrPlGupioJuUuikfuryk6DcL/kVLQzZBLIXzvjr5IbGUIQu0EHUJx4GqtphunZF5Zj7S8p3sMnBvYoKW6tGcwmGAEPIX5lgTQMBIXAev+CKxtOouhhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbhkpxmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09DDC43399;
	Wed,  7 Feb 2024 21:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341123;
	bh=GeYMdViIZNwyqOKQLAvWZAyDii0ag5jF9idqaEjWLqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbhkpxmKYvOTCVhUZyQvuhpOXQrb+rE3TgaCrsmWRIqn/mZWzvrjnJh7Fr1bnByae
	 mUlPNW48NGDfgaLTqySK7MN/3oZuwqYKSXKUlJ+bASFMDRFtUwZ6LQfVCO8Wq5cdPQ
	 CnsFVtXCRhS00PReFjT9czX6Egy3VS2j8+jylleLX2449wMI5BARqfkckR9Kts26/k
	 WEG8WvDCYgTaTakcbwAAMR+DqM1snwa02l1jlnmWoiXz2ag8n33DvCP01kc1pZsBl+
	 eqdxOcoKPRODOwWg6YvjX2ZqxKA2qMmE3C8c59cgZsAoZy0FgtZHagJR8VbF1Qybfx
	 3fjY0APxw2EGg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Tsoy <alexander@tsoy.me>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 10/29] ALSA: usb-audio: Check presence of valid altsetting control
Date: Wed,  7 Feb 2024 16:24:35 -0500
Message-ID: <20240207212505.3169-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Alexander Tsoy <alexander@tsoy.me>

[ Upstream commit 346f59d1e8ed0eed41c80e1acb657e484c308e6a ]

Many devices with a single alternate setting do not have a Valid
Alternate Setting Control and validation performed by
validate_sample_rate_table_v2v3() doesn't work on them and is not
really needed. So check the presense of control before sending
altsetting validation requests.

MOTU Microbook IIc is suffering the most without this check. It
takes up to 40 seconds to bootup due to how slow it switches
sampling rates:

[ 2659.164824] usb 3-2: New USB device found, idVendor=07fd, idProduct=0004, bcdDevice= 0.60
[ 2659.164827] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[ 2659.164829] usb 3-2: Product: MicroBook IIc
[ 2659.164830] usb 3-2: Manufacturer: MOTU
[ 2659.166204] usb 3-2: Found last interface = 3
[ 2679.322298] usb 3-2: No valid sample rate available for 1:1, assuming a firmware bug
[ 2679.322306] usb 3-2: 1:1: add audio endpoint 0x3
[ 2679.322321] usb 3-2: Creating new data endpoint #3
[ 2679.322552] usb 3-2: 1:1 Set sample rate 96000, clock 1
[ 2684.362250] usb 3-2: 2:1: cannot get freq (v2/v3): err -110
[ 2694.444700] usb 3-2: No valid sample rate available for 2:1, assuming a firmware bug
[ 2694.444707] usb 3-2: 2:1: add audio endpoint 0x84
[ 2694.444721] usb 3-2: Creating new data endpoint #84
[ 2699.482103] usb 3-2: 2:1 Set sample rate 96000, clock 1

Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
Link: https://lore.kernel.org/r/20240129121254.3454481-1-alexander@tsoy.me
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/format.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index ab5fed9f55b6..3b45d0ee7693 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -470,9 +470,11 @@ static int validate_sample_rate_table_v2v3(struct snd_usb_audio *chip,
 					   int clock)
 {
 	struct usb_device *dev = chip->dev;
+	struct usb_host_interface *alts;
 	unsigned int *table;
 	unsigned int nr_rates;
 	int i, err;
+	u32 bmControls;
 
 	/* performing the rate verification may lead to unexpected USB bus
 	 * behavior afterwards by some unknown reason.  Do this only for the
@@ -481,6 +483,24 @@ static int validate_sample_rate_table_v2v3(struct snd_usb_audio *chip,
 	if (!(chip->quirk_flags & QUIRK_FLAG_VALIDATE_RATES))
 		return 0; /* don't perform the validation as default */
 
+	alts = snd_usb_get_host_interface(chip, fp->iface, fp->altsetting);
+	if (!alts)
+		return 0;
+
+	if (fp->protocol == UAC_VERSION_3) {
+		struct uac3_as_header_descriptor *as = snd_usb_find_csint_desc(
+				alts->extra, alts->extralen, NULL, UAC_AS_GENERAL);
+		bmControls = le32_to_cpu(as->bmControls);
+	} else {
+		struct uac2_as_header_descriptor *as = snd_usb_find_csint_desc(
+				alts->extra, alts->extralen, NULL, UAC_AS_GENERAL);
+		bmControls = as->bmControls;
+	}
+
+	if (!uac_v2v3_control_is_readable(bmControls,
+				UAC2_AS_VAL_ALT_SETTINGS))
+		return 0;
+
 	table = kcalloc(fp->nr_rates, sizeof(*table), GFP_KERNEL);
 	if (!table)
 		return -ENOMEM;
-- 
2.43.0


