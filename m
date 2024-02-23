Return-Path: <linux-kernel+bounces-78920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D2F861AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B28C1C21AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94119142632;
	Fri, 23 Feb 2024 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LVSRzWIC"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194761420A0
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710687; cv=none; b=IS43EKCuYhHYvKyZG+Aacy69YeLgEBDZyJGXe+iJwffZBWkMwJ3p67IxDTxZ5erUGpFIzp1zFzuHdfxqWSAn9GnlszM9kZkrd6WATKPeSusPdexNYsA5DJgo6r1Z5qgaVKlv/wUPI7nzgwn+U8jQACPL8F7AZK1cObuRMAmPfVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710687; c=relaxed/simple;
	bh=cyobtDdfcGLm9EgpUOeJh0auXLdMupXD09HbMz5DS7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pw0uQlUs5bp4RvuP9sgt8O7XQtj0cLhrRoMSsgiJKKkDicbTT1oH7TCTfNSEy6pUJRFieg+tbJRpq+nQH5emViPGZUtrqHEQxrqSqm6zMujlR/0YpfzbzedNUXCmPuSnZsYoKx6mHZFwJqTEEdZR3v7zubS3bZK+HkurE9fUCDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LVSRzWIC; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33aeb088324so410383f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708710682; x=1709315482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5asXBXhtOZ8krhmeWknGrfpLZd9XvhtRWxv+IOZLPY=;
        b=LVSRzWICDBkKIvM2DtWlfyx53A8iTDRGRWB5b4rPN4f84qyAnuGjsyZ0Jh07WBV3ER
         fcIUSMRPXku/n1o2sE9deHB6JruyNd6zsq5elUSgl9NIiJpVTYhPoLK5vuRt+zpf0Z4I
         24oTCEltAZwiRXtPT6hgEsWiW2OAMtJX5cUilABqwlUX8f258Y1nC5qqMYo/A74RdgEq
         9VkVRdKg5BPk4LRlRRPN09Y0POrT22S+AjYdJ04qCbqm8vGplMgIG9KzZT0d/Cyra0VE
         okw9IOXVHBQqcsPYtCxJ3oVu4uUXNFekNJgRa/gYd+0dJ/1u4K1ByHOq/e+eshS5v2vS
         Zv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710682; x=1709315482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5asXBXhtOZ8krhmeWknGrfpLZd9XvhtRWxv+IOZLPY=;
        b=qqK46uWgKID0hatuufFX8T0NYVp4cwrrNpGKzPFILJJHxWHXjo4JlSU7IJBi608K6R
         cGu54VAfDAgG1Iwpph/KmF+FODrq4vjU0eAy/n+8XQRu6UR/lANTrUzlCiCrciPJ+ni2
         7XYH/5FyDLMT/TIHC9lkpagoeBEacRFEODClR+eFFS31+ijrITTUACSy7oboh4b0Z5C8
         EMqEwQtljo9DpRAHRaKysaSoOw/6fon8H3A6LlO9jKw3mhLLVLbpYsdSpfKK5tp7enZH
         xL9nDOyQTvkybzxx0I3Oq6hDKnixyiN/MgOmreSPNKU3c7rPdOBhCniTWUvTS/GZyLXl
         OrZg==
X-Forwarded-Encrypted: i=1; AJvYcCVRqGfkkZseii0ivhG6Tc9Gse/syv0T1mJNh6bBUMfPwxTLWwmnIZjqTaZxkidfDyFtNbr3T7hfKVhZO/CdFqyMo+mEPLE1Y3vCRNtE
X-Gm-Message-State: AOJu0YwZdIk/Wc/RGajMz9ATSLTl7IwsWvsw+3T4XzDfl95k9s+aIlLO
	GZ7l++Szu6xxXZSNvwKhISFfgFLfuAwpLX5IMuZsurvIMT7JgSLvLMtjl7OL5rU=
X-Google-Smtp-Source: AGHT+IF55hUqrzLd0OS4Msf5Z4g1J7M8Fx2otOvbUPa75llthqZMYU+z/HGqcEn63wo2SAVnVI/2FQ==
X-Received: by 2002:a5d:6445:0:b0:33d:a440:636c with SMTP id d5-20020a5d6445000000b0033da440636cmr343739wrw.49.1708710682467;
        Fri, 23 Feb 2024 09:51:22 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:e8a0:25a6:d4ec:a7ff])
        by smtp.googlemail.com with ESMTPSA id bo10-20020a056000068a00b0033cddadde6esm3711524wrb.80.2024.02.23.09.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:51:22 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH 1/6] ASoC: meson: axg-tdm-interface: fix mclk setup without mclk-fs
Date: Fri, 23 Feb 2024 18:51:07 +0100
Message-ID: <20240223175116.2005407-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223175116.2005407-1-jbrunet@baylibre.com>
References: <20240223175116.2005407-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

By default, when mclk-fs is not provided, the tdm-interface driver
requests an MCLK that is 4x the bit clock, SCLK.

However there is no justification for this:

* If the codec needs MCLK for its operation, mclk-fs is expected to be set
  according to the codec requirements.
* If the codec does not need MCLK the minimum is 2 * SCLK, because this is
  minimum the divider between SCLK and MCLK can do.

Multiplying by 4 may cause problems because the PLL limit may be reached
sooner than it should, so use 2x instead.

Fixes: d60e4f1e4be5 ("ASoC: meson: add tdm interface driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdm-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 1c3d433cefd2..cd5168e826df 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -264,8 +264,8 @@ static int axg_tdm_iface_set_sclk(struct snd_soc_dai *dai,
 	srate = iface->slots * iface->slot_width * params_rate(params);
 
 	if (!iface->mclk_rate) {
-		/* If no specific mclk is requested, default to bit clock * 4 */
-		clk_set_rate(iface->mclk, 4 * srate);
+		/* If no specific mclk is requested, default to bit clock * 2 */
+		clk_set_rate(iface->mclk, 2 * srate);
 	} else {
 		/* Check if we can actually get the bit clock from mclk */
 		if (iface->mclk_rate % srate) {
-- 
2.43.0


