Return-Path: <linux-kernel+bounces-82237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A728680F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B6A1C2100D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87F312FB39;
	Mon, 26 Feb 2024 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XileNh/v"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B211292FF;
	Mon, 26 Feb 2024 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975561; cv=none; b=Wmf1MgTMY1gOz3U1Ln5TaovRF1C678tKOgD3WXtTIbq81ity3yOlL6cdeh8/RPVPlWEi93CUD209B7QyUdiRnxohZcMxXcI3NkjelHVw6+KE2a6tG7Wh/0m5vO6xdMdLQwsrOFY7xAdsNV3G9SyyA6o3vnWeZ01MpTaAuY48bsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975561; c=relaxed/simple;
	bh=PbWMB4jlXVby1Wtl2tOfGSorse+GRJQkhlfRWUhIiRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d5vFVTV35y5NeUupNNxmiJ6fI88F7tZY1x6OFDziRP9McaYM/qzQHvhcSKzf2r1xK6bY2wjkqgrQuTUqmXxrXOSX2Emv619E5YKPfgURfJJDSHk09gPYyyyRZPqyIEAsubyw8e41MCo0y/sPkN8iz3v2rj54l89mppf1XBglBGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XileNh/v; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33de620be53so261473f8f.2;
        Mon, 26 Feb 2024 11:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708975558; x=1709580358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IeaqTjbt7JM44Wpg22D37i2T0qr64kX299bh07EpMv0=;
        b=XileNh/v+PFfiYHwxd6LTmqFm+cKKt0l2ctJlgeuYfh73i18CedY3BBvoB3K7CLef8
         SVojRTFNfseAv3u3pVCeGNfv3izolRZOr1n+XwlKyl8cQxmw1MtVtbkMPRs78cxnUr7E
         XjhMO9JWhFc0wnj4mPm5R8cQa8wSCSeQzfxoN9+QT744D7VV1rqxw3CF7XOkz8YIMFJk
         +CqRVVB2hJKIoAga6d3Mv7dCO1ffaTBDbmUVkqsUv1KbrY8zsbB4q5/emZgiN7wrTtXS
         Z+71tmPS6d11aISsLCfriUESDk+mUKMfUcCUOWxHtXjrbmTBlMY7s96ALXIJx8vJll33
         3t0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708975558; x=1709580358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IeaqTjbt7JM44Wpg22D37i2T0qr64kX299bh07EpMv0=;
        b=K9scgApKP3YfgdyCOLfoRb8CNSX+LpUui+bwXYuFLweSQOfVciT2xn1rk6EUxaIzmO
         NW+qapiECVNCZywOnKl3JT6FQLhCGoEU42/i13AmDOrzmGAza2kJ8EAT+7nRsQ7dRB2y
         Q5aVBZ/uYDCPfE9btteloAM/bJbDlsCeaKiGKDe/ldLMG5eqEexypdGf1Nw5Z+Q/RTs3
         vci3ngdqmW6ZwdPamiQ/I8F1AFsxn79+ryn8KVj3Uiu1d8d1UXt2pKVhVcnfdzMu4fEz
         RENBC8F6ZQWOP/Llxy3NTeyy4WFCLAjXbUg7XHtGA4IORHTuYFvQfC952424IjrBRJxs
         PtUA==
X-Forwarded-Encrypted: i=1; AJvYcCXlgebgGawOfGiYv6TUK/lQvAhs+EnbjlzpE4Yi49vvKvNAsEqG+SlOiSjniH/omafYUuBVwhSyGlOiYNt4zhlLY15FV26J18qR8CNvFxzN7uzuH1k0ACDs8ZH0PbABYrTn8k2rNqjdGg==
X-Gm-Message-State: AOJu0Yw70bhvdpOfqijMteguuAqXVjglDP+YS1YXxYe1JlrlZz+fZDL3
	I8eOEjre9eZ4eEfaD8BASq1nA/ewnFEbGlRb/eBo0LYo6vP+p1K/
X-Google-Smtp-Source: AGHT+IGCUQLoi0xhgTi5p000G5urv8WRNLFGbqdVQmw4abrxPsibNhvPn/iFua6baWGxMhkfWz0CgQ==
X-Received: by 2002:adf:f88f:0:b0:33d:2226:a26b with SMTP id u15-20020adff88f000000b0033d2226a26bmr5955471wrp.24.1708975557436;
        Mon, 26 Feb 2024 11:25:57 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:edb1:7d3e:765:66e3])
        by smtp.gmail.com with ESMTPSA id g9-20020adfd1e9000000b0033cf4e47496sm9295412wrd.51.2024.02.26.11.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:25:56 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] pinctrl: renesas: pinctrl-rzg2l: Remove extra space in function parameter
Date: Mon, 26 Feb 2024 19:25:30 +0000
Message-Id: <20240226192530.141945-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Remove unnecessary space in rzg2l_pinctrl_pm_setup_pfc() function
parameter.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 6840ad574f7f..60974a2b3c0c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2503,7 +2503,7 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, b
 	}
 }
 
-static void rzg2l_pinctrl_pm_setup_pfc(struct  rzg2l_pinctrl *pctrl)
+static void rzg2l_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
 {
 	u32 nports = pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
-- 
2.34.1


