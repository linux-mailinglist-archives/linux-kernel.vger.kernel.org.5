Return-Path: <linux-kernel+bounces-45887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D371843792
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9701F24AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367C354F92;
	Wed, 31 Jan 2024 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bsCc94Te"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0082451004
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685562; cv=none; b=oLxf1pHJEP71XvL0CQpTZgAHrhsPFC/nbIl5oxls3t2MB3lB3HmQ8Vz3X2CZMSG6BLTFi7FVkmXdDKLLYKEAgaruE2ZM3I9AoxbgcNqm0IyGJ7MTC8vGLlss/KsxhaNnXkU7V+gbrUUMkQROUWrRyw1C7lUKaYhVvMpXK8Ftctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685562; c=relaxed/simple;
	bh=h+sbUvzLd5vauTOG2RK3lZsXuEn4bWQfU9c+cnW0H2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b52tkyeXGl8kcqPU5m7anWYKfc9V4yoo2mMWJXjb/JU+Bj/qSvZHsryAm/0tBLsULB9bSAZ/NxO9eGkepBrGd/neiTLEYtHCOnGwterckxXLesnpDsND3b1s41yVH+5t6f90+gIEX8cWqtQ8DKc7ac7FJJL8oPEhfTh6KFNYp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bsCc94Te; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e11cda9f6fso1881294a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706685560; x=1707290360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzwxVq7iqVCMh+o8QAYUgN6xht/KSR0a8sgxs8d65a8=;
        b=bsCc94TeRiuFbGlnxH/9j96/iFd+O2DY1tH3eXPlR9YVm5CBi7DBUbzBDKAjEWiZ+a
         cJw+YhpEfuy05pzW6bRngLs/KyX4gJNVlawY7ByK03d7LTBJ7RxoghQGQ4nkc8nbYqWj
         CaHN4mSTM2/5bEowz+nauwYqvX1Pg4ABRkRFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706685560; x=1707290360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzwxVq7iqVCMh+o8QAYUgN6xht/KSR0a8sgxs8d65a8=;
        b=hkZxtnCU1acx5zHKq7VrkZAuYYdp5mHdQyNSJ9CZ/IqEIR5BvRuru9LoYmyJ3mb4/d
         hR8Bg9pNSHBKAgLRFgeURO2kvAxxrujyoEcY2cygMLjKydcAlq/flrBgbg2HRLR+Z204
         sKlsU/zc7FJH0zwgJiM/mlSMaZqQyx4qjh7feNPy9Q/84Bfh8PYGRl2XznKTHS5co7TC
         I65nMjuNIXfia6ZcuEO5wbx3rb1GPQHKOwhX1F0EF87xK549XlGYGjFPNcVkQRTHnj9h
         sLNz2LsR24XbUA8leQqNhhQSqXr4yG0FIvr2oewVanKiMbdktlFQYsM3B19mNh37G/uv
         G4yg==
X-Gm-Message-State: AOJu0YyLjfY0N2rRVvh2s13LSpsqJa1f2GZzO/CNI3gNs4gaBFk76zdL
	S3zFArkkEv2ps2E1toD3V929TLglN4mfKXHhuhwSKzmfM5ELlMfWuVtvotgxaCrNwMW99xlqzqg
	=
X-Google-Smtp-Source: AGHT+IHyEAJqaU+GNR8/XcG12RxxRrhWVX6OBK3RUeMhyMagSltWFxHBzffkIDrSozAjGcSeVL8BoA==
X-Received: by 2002:a05:6808:2e93:b0:3be:aafd:ce2 with SMTP id gt19-20020a0568082e9300b003beaafd0ce2mr1450707oib.2.1706685560063;
        Tue, 30 Jan 2024 23:19:20 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:74d3:dadd:270b:194a])
        by smtp.gmail.com with ESMTPSA id y9-20020aa79e09000000b006ddc7af02c1sm9049919pfq.9.2024.01.30.23.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 23:19:18 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pinctrl: mediatek: Drop bogus slew rate register range for MT8192
Date: Wed, 31 Jan 2024 15:19:08 +0800
Message-ID: <20240131071910.3950450-2-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240131071910.3950450-1-wenst@chromium.org>
References: <20240131071910.3950450-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8192 does not support configuring pin slew rate. This is evident
from both the datasheet, and the fact that the driver points the slew
rate register range at the GPIO direction register range.

Drop the bogus setting.

Fixes: d32f38f2a8fc ("pinctrl: mediatek: Add pinctrl driver for mt8192")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pinctrl/mediatek/pinctrl-mt8192.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8192.c b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
index e3a76381f7f4..3f8a9dbcb704 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
@@ -1379,7 +1379,6 @@ static const struct mtk_pin_reg_calc mt8192_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt8192_pin_dir_range),
 	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt8192_pin_di_range),
 	[PINCTRL_PIN_REG_DO] = MTK_RANGE(mt8192_pin_do_range),
-	[PINCTRL_PIN_REG_SR] = MTK_RANGE(mt8192_pin_dir_range),
 	[PINCTRL_PIN_REG_SMT] = MTK_RANGE(mt8192_pin_smt_range),
 	[PINCTRL_PIN_REG_IES] = MTK_RANGE(mt8192_pin_ies_range),
 	[PINCTRL_PIN_REG_PU] = MTK_RANGE(mt8192_pin_pu_range),
-- 
2.43.0.429.g432eaa2c6b-goog


