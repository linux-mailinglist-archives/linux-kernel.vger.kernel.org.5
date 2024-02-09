Return-Path: <linux-kernel+bounces-59108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2537784F14F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 741D7B22855
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D87165BC9;
	Fri,  9 Feb 2024 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDjd1MW2"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4278A804;
	Fri,  9 Feb 2024 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707466854; cv=none; b=HIsWp9nU7Ksmbd+VPstjMeWi05+8bmHjq4wgFX2+hPOK7I+g2K8TUtm9MMwmeQiBGCxyvHzYbtxw4nsZIOd3D5NNvGAbZPeIbdxx6z7vsRiHAUdyaKVBU8GOl+jH/oKHWShfDdg9OIhAcCj4WVhIESG7dYmFLTg1wuUWbkF4TL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707466854; c=relaxed/simple;
	bh=UGZeq7C8AXSDp6QEFpOyY2J9Cw2Ay2NUaHO+BuuL4sA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=gCC7xL+Vx5NjmqZaQoeys3AYUF5hvEKMaWBD/TLb2I1N8q+JhaY6RQpiMWhm/u9TNxCZiscKaaF14kpwmgYKZWQgXyCnZ08opszUHSw7rkBvF+ehqEdBz95nXK/SpdNrCs5npTesURbM2lyW0XEooGCxoUT0J3NMLOICNzxIusU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDjd1MW2; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3122b70439so75757066b.3;
        Fri, 09 Feb 2024 00:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707466851; x=1708071651; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOGM2ox03bKKsQ2BwwS9WHFj8/IxNhRH949PvmjrUH8=;
        b=mDjd1MW24uQIwcN2HLfYaWOudyUdsuxVwqt704/IG+J4aFUDHAU63HornqI4cuQVMP
         bNlvH3r/Vm/zve/BauLl1t4EVrB3Gc1Nz3VEZJNHszvx5oxXBHBa+SNiOeC0cRA1++ss
         Haxkc5JkmRVkHplZmzgWlbvNCM/+KFeYROadZ5C2/X83k0WVpCzsci+VkE2TzhZjvVpS
         IA5xAoDYFBXVwdoYhcfE0AOwcvWwlS5l4AOnFBllT8tnIl52NaPwe6ZRECnRe9Q0CWuh
         867VnksYs61btWvibxqWNG7DvtJ5z0jgTJDEnsDSsqHDCfprAnn8j1AvP70CkZfMU7dP
         EtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707466851; x=1708071651;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOGM2ox03bKKsQ2BwwS9WHFj8/IxNhRH949PvmjrUH8=;
        b=TCAydemKfhbyVumhqr+Ws+JOaQLFsuiDIKwqUBQnGwWY5rbjvYFQwr1YkyIvgdDKvY
         Z4W0mlmdZyx2g6coqApH0LRA+31NcScyohgxFGZgKDgZ0L2RZ1QyjYWAcbi20o5/++XE
         4tIhz61fzZHYNN0imBzgllMSworA6OBDZp0PxtWsLxurkfFJQkSRWVptu2tXftulcIcS
         ULNb6z8RV8cxsO0v1FcZNGa/E8MqtFDrCZTLCP5zvyg1vZS5BBUYrLyOIF//iJljnE8R
         C3Wz1Yj5qQv18K7bnISMAMTaT2p8F7wTbGhb+VMD8pp1qME7lzNosNCXht86baLnRe4q
         HYDg==
X-Gm-Message-State: AOJu0YxN0bKrjmxKirgG/yU+TsB7NlhglkhoNC0I8nO/nLnxYN7NM2n3
	AfOOFWMN8SzOO0bUdqB/l9IA53P6iwlQZzOE9O8YIvUwUXwMNZlZ
X-Google-Smtp-Source: AGHT+IGxinuR90ywB1Bc/RKcrV95AXr/pJxq1Y3/6duqSH25zwQRFd/o7pNJRB+OcLkMPgCXulYRBQ==
X-Received: by 2002:a17:906:874c:b0:a37:7f72:574c with SMTP id hj12-20020a170906874c00b00a377f72574cmr472254ejb.68.1707466851266;
        Fri, 09 Feb 2024 00:20:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4eR9GD9M+KuD19uCHflWV+fAiD7/NLXBZ6dyFie4GJz0WB43lazdCx6+rHPp8TGoZqYqS+SNsljDAmJSpdt2yAi43PwktlTQ+ReVwBkw5DUJcTksGPvCkflJfYXWNjgonU1N0PL0RJ8VsiyfktUGD2aUViKMNUV02kWn4IrspDlWAGEHXa5iYOUUgqEGPqVEWaHi5tBBbLp48HVrWmbwa53XpPaE209R6IIQZcq1lkXquQKfc31cl6FsSmyfQvRqFlJHZVjw5AZMI
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:cc99:64b5:3ac3:6096])
        by smtp.gmail.com with ESMTPSA id t10-20020a170906a10a00b00a3bd7052c22sm518897ejy.60.2024.02.09.00.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 00:20:50 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] ALSA: hda/cs35l56: select intended config FW_CS_DSP
Date: Fri,  9 Feb 2024 09:20:44 +0100
Message-Id: <20240209082044.3981-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic
CS35L56 amplifier") adds configs SND_HDA_SCODEC_CS35L56_{I2C,SPI},
which selects the non-existing config CS_DSP. Note the renaming in
commit d7cfdf17cb9d ("firmware: cs_dsp: Rename KConfig symbol CS_DSP ->
FW_CS_DSP"), though.

Select the intended config FW_CS_DSP.

This broken select command probably was not noticed as the configs also
select SND_HDA_CS_DSP_CONTROLS and this then selects FW_CS_DSP. So, the
select FW_CS_DSP could actually be dropped, but we will keep this
redundancy in place as the author originally also intended to have this
redundancy of selects in place.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 sound/pci/hda/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 20d757e38f94..26da739eea82 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -159,7 +159,7 @@ config SND_HDA_SCODEC_CS35L56_I2C
 	depends on I2C
 	depends on ACPI || COMPILE_TEST
 	depends on SND_SOC
-	select CS_DSP
+	select FW_CS_DSP
 	select SND_HDA_GENERIC
 	select SND_SOC_CS35L56_SHARED
 	select SND_HDA_SCODEC_CS35L56
@@ -174,7 +174,7 @@ config SND_HDA_SCODEC_CS35L56_SPI
 	depends on SPI_MASTER
 	depends on ACPI || COMPILE_TEST
 	depends on SND_SOC
-	select CS_DSP
+	select FW_CS_DSP
 	select SND_HDA_GENERIC
 	select SND_SOC_CS35L56_SHARED
 	select SND_HDA_SCODEC_CS35L56
-- 
2.17.1


