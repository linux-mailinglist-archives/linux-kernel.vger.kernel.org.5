Return-Path: <linux-kernel+bounces-146309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C4A8A6364
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B701F227FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B4D3D3B8;
	Tue, 16 Apr 2024 06:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GffCMELH"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B2B3C060;
	Tue, 16 Apr 2024 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247243; cv=none; b=YN4gz6hZUiPvzv4XVLsdLXK5ydJia7WFcGJxae69hSldBe+UlIqcecadeUTjWeqQAvTrkP5twtl4cmy1bNfVCDhFzgvEazTINQjzApNI9YnJxTaBDfgKn6SSUq3RHCbREm7/s6CB3Aj/A7P3ys/0J4Dd1B4fdKqXjsPBRKj6HRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247243; c=relaxed/simple;
	bh=dnnyobTp96GQ9f5n4jroE/22LBVDoDuolCWtYfUKiso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rItxppJTercawzaBb+Q8qOVpckUmYZLkiUeGZpGOF6UqqAGqscQacjmVzaycwEP+L7uIsb9g0YdZfWEC2FuRnsofcdwHRle0m360zeaSQnCoYdW2mFFKkZCs8yv+4JvKQOnEEmQ40Gvyyrhq//+7PG4TbsU6YKRGU+3Bv7oNgHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GffCMELH; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D18F01C0007;
	Tue, 16 Apr 2024 06:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713247237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJAAy6gitbplC0qdLnXXswBXeCRCS+Gizpnl0ra0dak=;
	b=GffCMELH9tcTR+yCegtdUSm0ODT9bFOOPlRH2RK1tGH7qGi63K4hHanvOOMtCVcwFErvdh
	F7IhHKLkQMMVR12ngKIiud0b9th9+uCefzmEr1bIVTVNwcIAlQxPfCpdmGXBVwvyFp0QwF
	GNo68pwH8hnQIEnNRL8ZQRwqjKlH4ONSH1OymzHowX6ld4B3zB9dFBtm1NW9kVRXAJgCep
	Ud/dYhhILQ2+9jd/68bJiGfeGEP0+30yJdxhuiciWCVCQr/dXHgzgt48uMP3I3eY+1HQUy
	u7k6bOWMZtlYGJXtWts1SxxzgA6Sql+Im/h+0KBvovZ0lpdAmlD6wHnLYn6sQA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 16 Apr 2024 08:00:24 +0200
Subject: [PATCH 1/3] ASoC: dapm: debugfs: add component to route lines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-vizdapm-ng-v1-1-5d33c0b57bc5@bootlin.com>
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

debugfs entries for DAPM widgets have the following form:

  Left ADC: Off  in 1 out 0 - R2(0x2) mask 0x2
   stream Left HiFi Capture inactive
   out  "static" "Capture"
   in  "static" "Left PGA"

Lines with the "in" and "out" prefixes describe routes from/to other
widgets presenting the path name and the connected widget name.

This is ambiguous in case of cards having multiple widgets with the same
name in different components. For example the STM32MP157A-DK1 board
(arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi) has a "Capture" widget in both
the "cs42l51.0-004a" and the "hdmi-audio-codec.1.auto" components.

Avoid the ambiguity by adding the component name to the "in" and "out"
lines. Add the new field at the end to minimize backward compatibility
issues. The existing vizdapm tool continues working after this change.

The output becomes:

  Left ADC: Off  in 1 out 0 - R2(0x2) mask 0x2
   stream Left HiFi Capture inactive
   out  "static" "Capture" "cs42l51.0-004a"
   in  "static" "Left PGA" "cs42l51.0-004a"

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 sound/soc/soc-dapm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ad8ba8fbbaee..eb9535764693 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2104,6 +2104,7 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 	int in, out;
 	ssize_t ret;
 	struct snd_soc_dapm_path *p = NULL;
+	const char *c_name;
 
 	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buf)
@@ -2145,11 +2146,13 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 			if (!p->connect)
 				continue;
 
+			c_name = p->node[rdir]->dapm->component ?
+				p->node[rdir]->dapm->component->name : NULL;
 			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
-					" %s  \"%s\" \"%s\"\n",
+					" %s  \"%s\" \"%s\" \"%s\"\n",
 					(rdir == SND_SOC_DAPM_DIR_IN) ? "in" : "out",
 					p->name ? p->name : "static",
-					p->node[rdir]->name);
+					p->node[rdir]->name, c_name);
 		}
 	}
 

-- 
2.34.1


