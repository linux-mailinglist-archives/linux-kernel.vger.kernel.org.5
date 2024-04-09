Return-Path: <linux-kernel+bounces-136654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F3789D6B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52611C20DE7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD3F1304B6;
	Tue,  9 Apr 2024 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zs2Wmn2T"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D1B130A40
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657649; cv=none; b=iOUxSSZqp0/gLdZ3R4SfAiyI0uRsCXl2XNKdgjhoMuxVP+WS/I7dZwkAfgvjY3JJk2Gsz2muD3TQ5vImg37/xIivJpQl0J7RxV6Yulc/b6xQ2uu5OX7yMuOWT9AlJJaebLs3Hrg63fm5EkSWfPGvFO7qNaP2+GnviMvqslYCOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657649; c=relaxed/simple;
	bh=xiXcG5GEfrvSIF0BlBGjwdfWPuvXXb+gIEE1G1bDPqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=la+sG40UuaFMOuviU3i9IqaA7S78Sqgb8PUga4DQ2oRimg4LA8AX6mw8sd1qPcrvfhWV2MCJB8diI31v16Go+8tsltp/+ITdvqY9cgYbOmvfRsO2SA7CLIisze0u7H6bDmezgCk284+ChnrkS6HzFRwTUKBLAIWkeDNMwKqGDB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Zs2Wmn2T; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-415515178ceso35238925e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712657644; x=1713262444; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFrY1D6xCh71cm7XNWVZx8QqBmaav+xzWA830Kc6M7k=;
        b=Zs2Wmn2TI5c57i7677lyKY85ZGHM0HTQzDJqyeIvkR09amWAbjCwd4d+oycOnVx2hO
         M6Af4ICPB3Z29mrKRyjmJrBwSHMGulXnDTot76j5U+e26WMzszSHW763hnZpZmTJRdjn
         PTq2lPgCIeDwJ54khi7CSKCuckHpBmM8WSN4lYdg5PjZPg75eziNjml+ahOJh/ptACne
         VDGHh917d8i0p5UkFAe9O1+EOvxNjnjPQtJKuRdpJM6dy4pZaNeKRt5DwtJTBCCINUQe
         1PNJHakJoUQPnhtlXsm4ebq9SQcUc/GsKYCuGQeP5naQa8h+ITos/EPKFSgbEWJjfrsp
         ULnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657644; x=1713262444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFrY1D6xCh71cm7XNWVZx8QqBmaav+xzWA830Kc6M7k=;
        b=bXPoWWVy1CDOJkwHZA3eM/KV4hz1NQPOEvQUyrR6NcZSkexcFFOU++2tDEWosjSCy5
         NYqEwUCBUZxORCXyGu7zmxe8EOmeJMGycgf1FBd3H/t15cK/vsyY1lIVNUEgkcdar1kY
         N3Kyepuut4ad9u/DqIIwzhO8I3KpS3pWKPegdcydoT1kt0FveLOYV33YcNBuc1FxmCps
         0h1DecyX9j+ECzrYlZLc7NRYXFBkkUGsW6X3CQUah3dIGkBv0ju1mEFjpec5zN/6+H+i
         Q1624pu9lTh8bHb/ZSPiRt4l5vsOwQzlNK6HEU71RVFqCeY9nAxNRiJRC7WBN87VGjmr
         ke+g==
X-Forwarded-Encrypted: i=1; AJvYcCXPVcsMa3GNdS93mgUOlzusHOXd4E0j7mK+ADKXSXvkJMn+1w9iaP0aQXJiexiLqyAh3GUXKZF9RJmygBDzxjGhEiWbmy/qKTuISlQU
X-Gm-Message-State: AOJu0YxXBvaR0B4yyMthcbqx/zhJ68fAWYbuED3qbN4yOqitkXOu6hfS
	wstUNjquW/zNNfiHBnLhuB2VK5t0y+qy5p8G3WGdEhsPtzzhJ8T7oN4SnDpnJSRpu93+Kgf5uM1
	GDqQ=
X-Google-Smtp-Source: AGHT+IGto5A0cajSMQfWBoUsnHL/bjGErC62X6jy9DY5wuOhWozfx6Hc90y3B4gZlxuozIjpOi/DbA==
X-Received: by 2002:a05:600c:4ece:b0:416:3383:227a with SMTP id g14-20020a05600c4ece00b004163383227amr7019406wmq.0.1712657643955;
        Tue, 09 Apr 2024 03:14:03 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id r7-20020a05600c458700b00416b035c2d8sm1124149wmo.3.2024.04.09.03.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:14:03 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 09 Apr 2024 12:13:36 +0200
Subject: [PATCH v2 15/18] arm64: defconfig: enable mt8365 sound
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-audio-i350-v2-15-3043d483de0d@baylibre.com>
References: <20240226-audio-i350-v2-0-3043d483de0d@baylibre.com>
In-Reply-To: <20240226-audio-i350-v2-0-3043d483de0d@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=777; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=xiXcG5GEfrvSIF0BlBGjwdfWPuvXXb+gIEE1G1bDPqE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmFRTT9bjW/zxLnXdKojc8YmUYjz4Xj8GvfHQ4mR/K
 qdeBVmiJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZhUU0wAKCRArRkmdfjHURbaXD/
 9qEhFdaTc6VeTRp830IrIzI59VW84lMyd4klwB3ysqotwcoiTfhdtKkSJYESy42RJP+s7XlsyHaKNC
 6DMcV517X8o9HasZ+qeqXuU/S6AQorT2SMu2LhRAYpW2ZHAlbx8uNmgq8zdKA0NxsrhB70obL5tMsc
 4i2B5m4mJ8Gx/uUFolJO/0aUN+GWHvEdc5uHNzZx3dUOEfq5TIuwO6GpeT9S68NX/by2O6HJ1SLE3A
 x4P+CY7bcB0z8MFq3So3eImUegjRZRdcHf/nY/kgqzQKuggSgr6u43fimgPtztuak9XxElmFZX+vRW
 plK0XS1uoWpEa0qQakXjOaQX+Lj/rbkkz6+V6vw2bRRsUKkvSjPMk52/+5oWwhzi4uZ1OQ7d4MfxFn
 bPzZnKclzE2DPdlLcVa8ZgkaCNGxg0gxbrCICRvnbq2SBGUafPRNbVvBwapxJr2dh1mWPedzs4dtb+
 g91qwCY+CufuR83GhjAMrC/tLHN6SCtmd14Sa3csER+YUm8ex7Wr3m9ZYCU0vACh3ifBw10Zj26Bjb
 KP3tyqCpSzPxlTRsmqtDLD35rgxdUwzcr2s98VNOrj2bmpaJA+dAgPYV67G3B/fiPVSyDzmgC/Q3GK
 Ixi66Dihvw0FcEd+RIrMbZ77RSNBjdv/OApkKgJtvbfXud9EWNVdxL1E12eQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Enable the MediaTek MT8365-EVK sound support.

The audio feature is handled by the MT8365 SoC and
the MT6357 PMIC codec audio.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e180..40e88cdafa3a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -939,6 +939,8 @@ CONFIG_SND_SOC_MT8192=m
 CONFIG_SND_SOC_MT8192_MT6359_RT1015_RT5682=m
 CONFIG_SND_SOC_MT8195=m
 CONFIG_SND_SOC_MT8195_MT6359=m
+CONFIG_SND_SOC_MT8365=m
+CONFIG_SND_SOC_MT8365_MT6357=m
 CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_MESON_GX_SOUND_CARD=m
 CONFIG_SND_SOC_QCOM=m

-- 
2.25.1


