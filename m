Return-Path: <linux-kernel+bounces-168087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 226B38BB381
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEF12858D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFF7154C19;
	Fri,  3 May 2024 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD9H+C9W"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9C1524BE;
	Fri,  3 May 2024 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714762523; cv=none; b=tKoPjereRSikhi8qfxG0znYG1dXssOL5emq1NLD4pvld2RZB8bWt8fkZ6GnEQuETu0f3hHpteVYCz2n1lbZBt9npmpydbb3mQy3xOATbNw3xZ7NWIINSUJ1FhfIQpAD/7SVxS06q/NEmHsuyyBuzgJvcfrN0+pHLSAzA9UD5ePc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714762523; c=relaxed/simple;
	bh=yeOI4X99Sc7Swlz3qKg+Cc6O9KkBtF41vdppAyeJnxM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O0PqXbLqPnbcd6JFzUDr8sdrb/Y/L0jiNa3wwUnoUgK0lZPRMaa0NV7n+21Ui/zBnxZV0k5GL6SEu54O2eF+X8LraMab4XfNriftzDlRTtevbD8bhUV+57BT1NE2dkXuEhMyieb4i+Ly5eb+qCbQJPX2/SW2Edm7OfuZajlONTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD9H+C9W; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a599a298990so210817566b.2;
        Fri, 03 May 2024 11:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714762521; x=1715367321; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EnxMYqw83s5oEuRsJKXGuOf6rkwvSd9+11+j63EQ1rg=;
        b=VD9H+C9WDn6VsCGKikmPFWHCcYrBFvzEW2Tz51RI0Ea/9ARI6QmZx5Ub88YoAEN86c
         6+q2sdTm0w3eKIwBH0WSez8mRrcHQwyOuKhAPrZw6jnh4XLb0HmriYrzAo+CBosEXARV
         hnXv3jzqhazmP34VB3pYD0fcQo0nqJGypTyhISI5yMvz6qcdGyCTFquBFM4UWsuYBupM
         dc9Z0exf1L2dohDOM+QA23ui7QFF7ICdrKP8ItkijTY4g8/boTDTSGvpOXUNXBadqo3r
         Y3BhreQDfROvmSfdVrVoZBFSSmke+y1C6Vqk5phPR1YHj+jrxpKv5LFx/ajl71a2pRjp
         kSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714762521; x=1715367321;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnxMYqw83s5oEuRsJKXGuOf6rkwvSd9+11+j63EQ1rg=;
        b=AntEAL2qB8EBvyDkm9B/UVEj0IJVP/wDXl+J5/QwLKX4z84po4dM0gu9J0sOpyr57t
         kir7RJXcIlTdpwYLU3WV0WeJdwYes7SpUd/X82kqyeGmn8h0SJCAKbIGavM/AyeT3P/V
         Txkf3SqGj+mhtS/1VwChealPL6rBn6tfZgBVfPKCzwsMjHeztIB6S9o6Kih+vqB2OtYT
         GcqJiJe1oFO/yRsAQ/npzeIr1ig8x6PXBwDfhotdI+COE4Z/EqUZ39ueD6NG7LhnDUPw
         65O681PAYQnnITsuKzJvRtkqES4fL/36pDTmylQ6pOdCuNReBHTop+K+kaqfytKqdqBi
         JViA==
X-Forwarded-Encrypted: i=1; AJvYcCW/GbFlJMIGfz9zoCgyrCTTAFZDBLe6qU4qK597ZxhIMz1+lOwb3yjZn1QH86G/j1lfR9jHr1HPH0nNzi4ZmuHHQ3iGw5mSp5I3da0c9kPMnOxgDgi2B+tghbUgblNvicSJKOP7B1y1PgvwIUmmUQuxl46V/aT117YGxlIUvDPIkiUFADThWZ3kqGZkpUhwlCm2mGK43dj0ODmKmKRxyJ8EUExYaDCTJQ4=
X-Gm-Message-State: AOJu0YwzHdAQzYAUi5YT3tXxrklvCk9vEs6nu8I7pqjqovvadtJAMrvX
	w/CzTFNCV00M2AbMnEMcaQSZ8kuRo9v/JNfnZzdGSSsZ7DSvkMfp
X-Google-Smtp-Source: AGHT+IEQB6b4e3H38yp9btaJmIcRDwe/VCwFfyZT9AmvoljLIJT+ZBSK9hkBuHY8WT6rNnvO1Y6fxA==
X-Received: by 2002:a17:906:4f0f:b0:a55:65e6:ce9f with SMTP id t15-20020a1709064f0f00b00a5565e6ce9fmr2326939eju.20.1714762520609;
        Fri, 03 May 2024 11:55:20 -0700 (PDT)
Received: from hex.my.domain (83.25.185.84.ipv4.supernova.orange.pl. [83.25.185.84])
        by smtp.gmail.com with ESMTPSA id l8-20020a170906078800b00a598d3ddf8dsm1104618ejc.28.2024.05.03.11.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:55:20 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 0/3] ASoC: samsung: midas-audio: Add GPIO-based headset
 jack detection
Date: Fri, 03 May 2024 20:55:10 +0200
Message-Id: <20240503-midas-wm1811-gpio-jack-v1-0-e8cddbd67cbf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA4zNWYC/x3MSQqAMAxA0atI1gaa4IRXERe1Ro3iQAsqiHe3u
 HyL/x8I4lUC1MkDXk4Num8RlCbgJruNgtpHAxvOTG4YV+1twGuligjHQ3ecrVuwI8NcdFSKcxD
 jw8ug9z9u2vf9AMBerkRoAAAA
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714762519; l=2127;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=yeOI4X99Sc7Swlz3qKg+Cc6O9KkBtF41vdppAyeJnxM=;
 b=CVtRwrW63dzCjdHMfuym89IrHMx7aKfSUuB173VVInw9/mE4o5Hyn8+yEyj8S7B5FKza+8hMV
 vXsUAqf9GV9CDmsqN7xyKlhXEfIeHB6rEq3lsoLMY/Om4x1ZtLbpKOW
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Many of Samsung's Exynos 4 devices share the same midas-audio driver
to handle the codec setup. While most of these devices, including the
Midas itself, use the jack detection provided by the WM8994 driver,
other devices such as the Samsung Galaxy Tab 3 8.0 (lt01) use two GPIOs
and an ADC channel to determine jack insertion, the jack's type, and
button presses (for headsets with volume up/down/play buttons).

In the downstream kernel, this behavior is implemented in the sec-jack
driver[1], and the per-device settings are configured in *-jack.c files
in the mach folder (see e.g. the Tab 3's implementation[2]).

This patchset implements this mechanism in the midas_wm1811.c driver,
and adds new DTS options to allow for its configuration. It also
enables jack detection for the Samsung Galaxy Tab 3 8.0.

A very similar mechanism was already present in the aries_wm8994.c
driver[3]; this implementation heavily borrows from it, though there
are a few extra cleanups as well.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

[1] https://github.com/gr8nole/android_kernel_samsung_smdk4x12/blob/lineage-14.1/drivers/misc/sec_jack.c
[2] https://github.com/gr8nole/android_kernel_samsung_smdk4x12/blob/lineage-14.1/arch/arm/mach-exynos/tab3-jack.c
[3] https://github.com/torvalds/linux/blob/master/sound/soc/samsung/aries_wm8994.c

---
Artur Weber (3):
      ASoC: dt-bindings: samsung,midas-audio: Add GPIO-based headset jack detection
      ASoC: samsung: midas_wm1811: Add GPIO-based headset jack detection
      ARM: dts: samsung: exynos4212-tab3: Fix headset mic, add jack detection

 .../bindings/sound/samsung,midas-audio.yaml        |  30 +++
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi     |  23 +-
 sound/soc/samsung/Kconfig                          |   2 +-
 sound/soc/samsung/midas_wm1811.c                   | 265 ++++++++++++++++++++-
 4 files changed, 305 insertions(+), 15 deletions(-)
---
base-commit: e67572cd2204894179d89bd7b984072f19313b03
change-id: 20240502-midas-wm1811-gpio-jack-b10226b17ecc

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


