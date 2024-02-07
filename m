Return-Path: <linux-kernel+bounces-57187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD9284D4DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA361C22424
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B691F16DC86;
	Wed,  7 Feb 2024 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmCwzPP0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB47616DC7B;
	Wed,  7 Feb 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341187; cv=none; b=MjM62HQh3dNHLbXo6ODrooEgq/DrJSUXz3H4SgZvRNywEHNoda2Wt2PQCEReHVQGJwjmCjAEPF2Qf8fHU2GoqDyICAZM7xxq4LrQAwRFlbafpx5MpPGy8T2Z0jV764XNGJ++fBlQOarneHBiue0/mxTG5MoHIXiaXmPvsE/DlTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341187; c=relaxed/simple;
	bh=GeYMdViIZNwyqOKQLAvWZAyDii0ag5jF9idqaEjWLqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBJuUQ0zuB2UStm8uBwKCc66GHE/7jDkIyD+kinYMoueG2Hr/1E0yMS/L+Lw80BxUvTRhx1WG5HGYCQLkRsM2H8regIEMbRpkh5jrrFJ5CWtwPGNYfoTp/fhkSlqSpGgVj9l8xFD0+mBVIfJFz+7Ui+oeLgmeodhGTUfBIuDYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmCwzPP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6326EC43390;
	Wed,  7 Feb 2024 21:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341185;
	bh=GeYMdViIZNwyqOKQLAvWZAyDii0ag5jF9idqaEjWLqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZmCwzPP0DqhAM+VqNWFxKavv/P3LTZFIbYOwIqpw7X0Eoj+q2CMvGI4LxEqKecLRw
	 G46P7p7uCXvjoOWKVOYZzWlWRqM1FUSQCgVN3PDBK9JYQpQ+o7tlnaRTf0xy/Ipszh
	 lD1pe6wJOM/nO/Ce0YIatd0HTxpC9p18qx2Eq1v8ztZubSuwXme6mw02l/p4cJTcZM
	 6d/fSXCTsnIiIRcowyU6i/yEoIh4zbxM5DVvQ8OpflKA3gmK7ay1HgPUTcf4IhWDo2
	 Nab0cSc0NasGZEY1s0GEIjIvGa7YCX7HSiYzNXIHjbSMBU64EnGNGK4v29Nlsh2E5n
	 6UinAauJNyJ+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Tsoy <alexander@tsoy.me>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 08/23] ALSA: usb-audio: Check presence of valid altsetting control
Date: Wed,  7 Feb 2024 16:25:49 -0500
Message-ID: <20240207212611.3793-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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


