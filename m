Return-Path: <linux-kernel+bounces-164740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660C88B81E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155B01F24986
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5D21BED65;
	Tue, 30 Apr 2024 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V61RWo3K"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49511A38F4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714512574; cv=none; b=Welktwr5dq0Hu7D+SOOE/veB1Rme48Qr1KOjmjS8CMYhizsG9hscsJ51u7Mg0ohn+ztu1Xjvj4uj9F6ugsj5P921zITGGR6fXh9DxyU/esN9tuLb/VJ1BgoBIxGwhQm5wrCsN3J+GRSkxaqqAV+eK2cLx3YS8O5bsCoStLsPyy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714512574; c=relaxed/simple;
	bh=6U9unJGTfc7UWu3ejff7Z+GgZ9ABtAxR/MMYNspzo1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JntCJAzoePcBTti9wAmu1OJGPBrTXkigm3FLrtg25cs+KgM7FK5fGDZKL0gDedyi10mtUOntRqUrVlWZN/BUgKXtYCoptidFes8QkZA6LG888Q3ILHPvIkFIjbb0crqyVKoV8fGrS/mjFZVSTQbqTYYC9CAfBJJC1m6PGNN/1eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V61RWo3K; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e51398cc4eso55228665ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714512572; x=1715117372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PEjf4f0YZskVbYs/23zDtacUAhJaOjxP+1cZSas3wIY=;
        b=V61RWo3KVc17E2cd58KASJ+tz5SI/fakcT/CsuWKtjb/W55mq/vic3FPuplvHzSbBp
         ol0KXdoAraiTCU4yJnnWztroQNKcbRnp4ZB/++Y7zDtWdFACl6/OZn/S1C69J/Nd0SSO
         aNVs4hQoLM9THQ/eLOKSWbLhgsNVsQofFd1s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714512572; x=1715117372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEjf4f0YZskVbYs/23zDtacUAhJaOjxP+1cZSas3wIY=;
        b=ILquef25LblkTfeEk01xW61m1raQm9qlydfrAWHUCsDkkrYN5snmUYOOViq/OiVhBY
         hr0zYtu1IIOzV1mvA2tIE3J1homm8Ucocl83QlgS2wW7Yb4wf49KYd4HVnRzt9tVxnFH
         JAEuO0/BVJPabbrr0nMag3FzPG31urE6Dng9xczPj0AMoSWRbmtK1QbGyHQkGbvQsAHM
         lc6l0NMkWDYR8m9080iWxH1kuOl0n4qGcX4RgXTIV36qLpdKeo3Nhw3FnRqxtQDYyMTu
         Ebgm2jV7KfkCCOHrkIThy+xbSwi8JZ9E7UuIbpoNFV1BMvp/l0nLaeYA48GqoeFK/nRP
         Icbw==
X-Gm-Message-State: AOJu0Yw7tCweKxjwZUWBJHq8wCu3XDSIB1Y+U1BXyFzRyBMJ4q6fwNMQ
	3s6QC0qhWLxS3LQAFXiHm/rnjVW1mjEAtIYMfj93btj6BNImVOFiUdpFdMdJYMHlBCsudfhacqc
	=
X-Google-Smtp-Source: AGHT+IHE3zAOxQdE5LzNdBkq8h+2IF29Scc8fzT8qdg0sTbbJ2ptRGBHW/FSU1Cuv496q9Ut2T8Hcg==
X-Received: by 2002:a17:903:120b:b0:1e5:a025:12f9 with SMTP id l11-20020a170903120b00b001e5a02512f9mr873908plh.28.1714512571923;
        Tue, 30 Apr 2024 14:29:31 -0700 (PDT)
Received: from ballway1.c.googlers.com.com (97.173.125.34.bc.googleusercontent.com. [34.125.173.97])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902ecc800b001e944fc9248sm18684579plh.194.2024.04.30.14.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 14:29:31 -0700 (PDT)
From: Allen Ballway <ballway@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Brady Norander <bradynorander@gmail.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Allen Ballway <ballway@chromium.org>,
	Takashi Iwai <tiwai@suse.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org,
	Mark Hasemeyer <markhas@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH] ALSA: hda: intel-dsp-config: Fix Azulle Access 4 quirk detection
Date: Tue, 30 Apr 2024 21:28:42 +0000
Message-ID: <20240430212838.1.I77b0636d5df17c275042fd66cfa028de8ad43532@changeid>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This device has an audio card which is quirked for force SOF use but the
device does not support SOF so the card is not usable and audio can't
play through the HDMI output.

Add another quirk detection that matches the Azulle Access 4 in the DMI
info.

Signed-off-by: Allen Ballway <ballway@chromium.org>
---

 sound/hda/intel-dsp-config.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 6a384b922e4fa..cf4e25d031d56 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -142,7 +142,9 @@ static const struct config_entry config_table[] = {

 /*
  * Geminilake uses legacy HDAudio driver except for Google
- * Chromebooks and devices based on the ES8336 codec
+ * Chromebooks and devices based on the ES8336 codec. The Azulle Access 4
+ * uses the same audio card but does not support ES8336 and should use
+ * the legacy HDAudio driver.
  */
 /* Geminilake */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_GEMINILAKE)
@@ -159,6 +161,20 @@ static const struct config_entry config_table[] = {
 			{}
 		}
 	},
+	{
+		.flags = 0,
+		.device = PCI_DEVICE_ID_INTEL_HDA_GML,
+		.dmi_table = (const struct dmi_system_id []) {
+			{
+				.ident = "Azulle Access 4",
+				.matches = {
+					DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Azulle"),
+					DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Access4"),
+				}
+			},
+		{}
+		}
+	},
 	{
 		.flags = FLAG_SOF,
 		.device = PCI_DEVICE_ID_INTEL_HDA_GML,
--
2.45.0.rc0.197.gbae5840b3b-goog


