Return-Path: <linux-kernel+bounces-146310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E498A6366
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA65B20C82
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBAB3BBEC;
	Tue, 16 Apr 2024 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NtQqpkon"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC63D57D;
	Tue, 16 Apr 2024 06:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247246; cv=none; b=o/hS7R+cpkR4dhGc5vFawe5eB3ki50tNFrJfWkQDFn+/zi52GOZEumvItl8PMdGpXeMN/Jv1eAf4vnAHcNWL8AXRUx1YnaEGgKWJhQ2bSi3gKVYI+ARobEpieh0H5AESj8kyy1lLHfJo6sd7CyIC45FIV3ezfAloCZ+WQDHbZa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247246; c=relaxed/simple;
	bh=+jmBdFi+4Pd1BAcftvCw53GdULxuIpSTqOwXGVK2Qy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nnyCJ8Nc13ZrvoiZaO8ij/d22SQ4ib3wKuyIYlo9LPp4fchG/YWTmW4wQLm7N8hYgSAuGGLTz/C/RXNv5+mO91rHdHe0m8sNiQGgRToyGtFqtqDPgIl0DkM5ZM9dnSnmiOKAUlMraOyFf+IOEL1RKlIuUhUmK0gRUsQIcGIdq0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NtQqpkon; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D51151C0002;
	Tue, 16 Apr 2024 06:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713247242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OO+PMASJA/OcNT4aEnxeIIqm+rXOmBuqMP8+7xNz4n0=;
	b=NtQqpkonpseojWZahcx5vO9cedNvoH9QuOtK2vDWIlc8tPi/d1D4EZebE0o86bdqwPi3Vy
	vWFIYQOLlmGX6T9R85KkdJqMYpg7rgbsKQwx5QXiDtJshivtZ3E6dGkRyMuY2lvuMn5Ydm
	gh2u8N+PmdfI7Sxy4UF0pWYfX/sHU7uKk4teQ4VWMMoxyqxmyw27ZbPR0mkXhFI5Q4kcFT
	oJKARc2AlCVGbyk3EzF5QgzTE14WqWh6OYD2hjaetaWIz3hfFLDH80FtATtYdBJnneoCEx
	0l4eEyY8HQZuMrnrVbozh5MIgKFPMW0fTviVuuH+Eav5aG1YXDaS/C5nCDcROA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 16 Apr 2024 08:00:25 +0200
Subject: [PATCH 2/3] ASoC: dapm: debugfs: show the widget type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-vizdapm-ng-v1-2-5d33c0b57bc5@bootlin.com>
References: <20240416-vizdapm-ng-v1-0-5d33c0b57bc5@bootlin.com>
In-Reply-To: <20240416-vizdapm-ng-v1-0-5d33c0b57bc5@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, 
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
 Mihai Serban <mihai.serban@gmail.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

To make the widget debugfs files more informative, add a line showing the
widget type string.

Keeping backward compatibility is nice to have being debugfs, and ease of
parsing by both humans and software is also good. To maximize both with a
reasonable effort add a new line without thouching the already complex
format of the first line. The syntax is meant to be a key/value pair.

The existing vizdapm tool continues working after this change, ignoring the
new line.

The new format is:

  Left ADC: Off  in 1 out 0 - R2(0x2) mask 0x2
   stream Left HiFi Capture inactive
   widget-type adc
   out  "static" "Capture" "cs42l51.0-004a"
   in  "static" "Left PGA" "cs42l51.0-004a"

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 sound/soc/soc-dapm.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index eb9535764693..16dad4a45443 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2094,6 +2094,48 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 }
 
 #ifdef CONFIG_DEBUG_FS
+
+static const char * const snd_soc_dapm_type_name[] = {
+	[snd_soc_dapm_input]            = "input",
+	[snd_soc_dapm_output]           = "output",
+	[snd_soc_dapm_mux]              = "mux",
+	[snd_soc_dapm_demux]            = "demux",
+	[snd_soc_dapm_mixer]            = "mixer",
+	[snd_soc_dapm_mixer_named_ctl]  = "mixer_named_ctl",
+	[snd_soc_dapm_pga]              = "pga",
+	[snd_soc_dapm_out_drv]          = "out_drv",
+	[snd_soc_dapm_adc]              = "adc",
+	[snd_soc_dapm_dac]              = "dac",
+	[snd_soc_dapm_micbias]          = "micbias",
+	[snd_soc_dapm_mic]              = "mic",
+	[snd_soc_dapm_hp]               = "hp",
+	[snd_soc_dapm_spk]              = "spk",
+	[snd_soc_dapm_line]             = "line",
+	[snd_soc_dapm_switch]           = "switch",
+	[snd_soc_dapm_vmid]             = "vmid",
+	[snd_soc_dapm_pre]              = "pre",
+	[snd_soc_dapm_post]             = "post",
+	[snd_soc_dapm_supply]           = "supply",
+	[snd_soc_dapm_pinctrl]          = "pinctrl",
+	[snd_soc_dapm_regulator_supply] = "regulator_supply",
+	[snd_soc_dapm_clock_supply]     = "clock_supply",
+	[snd_soc_dapm_aif_in]           = "aif_in",
+	[snd_soc_dapm_aif_out]          = "aif_out",
+	[snd_soc_dapm_siggen]           = "siggen",
+	[snd_soc_dapm_sink]             = "sink",
+	[snd_soc_dapm_dai_in]           = "dai_in",
+	[snd_soc_dapm_dai_out]          = "dai_out",
+	[snd_soc_dapm_dai_link]         = "dai_link",
+	[snd_soc_dapm_kcontrol]         = "kcontrol",
+	[snd_soc_dapm_buffer]           = "buffer",
+	[snd_soc_dapm_scheduler]        = "scheduler",
+	[snd_soc_dapm_effect]           = "effect",
+	[snd_soc_dapm_src]              = "src",
+	[snd_soc_dapm_asrc]             = "asrc",
+	[snd_soc_dapm_encoder]          = "encoder",
+	[snd_soc_dapm_decoder]          = "decoder",
+};
+
 static ssize_t dapm_widget_power_read_file(struct file *file,
 					   char __user *user_buf,
 					   size_t count, loff_t *ppos)
@@ -2106,6 +2148,8 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 	struct snd_soc_dapm_path *p = NULL;
 	const char *c_name;
 
+	BUILD_BUG_ON(ARRAY_SIZE(snd_soc_dapm_type_name) != SND_SOC_DAPM_TYPE_COUNT);
+
 	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -2137,6 +2181,9 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 				w->sname,
 				w->active ? "active" : "inactive");
 
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret, " widget-type %s\n",
+			 snd_soc_dapm_type_name[w->id]);
+
 	snd_soc_dapm_for_each_direction(dir) {
 		rdir = SND_SOC_DAPM_DIR_REVERSE(dir);
 		snd_soc_dapm_widget_for_each_path(w, dir, p) {

-- 
2.34.1


