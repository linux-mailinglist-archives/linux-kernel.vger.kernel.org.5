Return-Path: <linux-kernel+bounces-45886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DD5843791
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 745C7B21730
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74511524DF;
	Wed, 31 Jan 2024 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f1ylBp3o"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA7B50A91
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685558; cv=none; b=BjRf+/JVRfBY8jBc1zpAUHqJ9xG3Z2BkFY4ZFCtwvcXNEkr5lBfQ7CeaR8XRTc67ATq6ul6ecUU87UUTK2c/z2RRP+lCABqq7IU8tsdK8jY/TR0AqiScbHt1RJiB81+ID6v4KIMgoq/vFiaWRkaZKVxRQ5KBvp0+di5mKXLxBmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685558; c=relaxed/simple;
	bh=UheKOyu4PxdtXP+p7L8FVFpklQZUHf5uiW8TCuBmqB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iw2+v2B3xcodU/GuQYjCnPB4wim5/LTmXEsew8RLjMzm7rd23FSqhjLCNqlcB/m1/pVHG2vg7vmOZgfGs46JiaRgfddowjFrA48SZr43xaHUWM7BuZXybiyrDchD0eFYhAFhsp64S8cbKyqQOfVBBEGm6FrsNFrr+Wo4lHTuwS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f1ylBp3o; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59a8b9b327aso279432eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706685556; x=1707290356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2wqRnRIGXiLCSvzJZLYjMcTKthyhOO5v4D4vqmcQVvU=;
        b=f1ylBp3o/u0oX3yfMO19zsJm/IUuvdyBkDH8dy+dSFoqpLSqU29IoUI/5qA9AK+mS0
         hYYRmyIZtpa1y9ECIJdyO0IpcPt+hXPv34zkJ0hfpQ3A4SLHwceO4D03czLRZUuG24JD
         0QurlsaeKGKe7X7Z40CfOu2LLbPFsjgI6LLdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706685556; x=1707290356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wqRnRIGXiLCSvzJZLYjMcTKthyhOO5v4D4vqmcQVvU=;
        b=gxPCKCTXvPQ0KcWxao79XDF2re4CuO3DqNrEzKvOJmF6iPH9KmOqdZezuiawNewJ5h
         WgUIlH+ZKdf7T9gk3bSP3dS/yQGpqS+7W4CKzSno/F23v3l67O2aulSEdQ+P3/Do5bMx
         BrERDvkpK+HYzXVjDpJayhc1qOOGOO7n77kSPO0fpUy/YQ+rT+fPJei+o1jHT2G7bNEN
         +eetUZyarfmI0fi+LTjpxwWaBF7xEukMvh62xw4vB5qEt7IUo8lEix8eB8f1CMeO0Juk
         yqocXwRHI8vPNuBufXNxe7+elqlyREjbWCJ2Wvz1NLcA94Qwt+kowET6Ji4Whkjqajiz
         qqbQ==
X-Gm-Message-State: AOJu0YxrM/1ywj0W8cS1OQsu6XDFuOndXucQLvtefOcNbCXfWlYtqhCn
	t4UEcLNli2VhWOgFRuHkdzDyxdG4aTjD8Yz02i9PWxPn9YsEm72RIU4mLdo8RQ==
X-Google-Smtp-Source: AGHT+IF6hDfOWd8Jvsh/0B4DrXgvbzPeIc9dpxLSCGCQ44hmQpNs836JCIa0j3ZmA5ktz5abA8uT2Q==
X-Received: by 2002:a05:6358:7245:b0:178:63a0:b795 with SMTP id i5-20020a056358724500b0017863a0b795mr686144rwa.29.1706685556269;
        Tue, 30 Jan 2024 23:19:16 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:74d3:dadd:270b:194a])
        by smtp.gmail.com with ESMTPSA id y9-20020aa79e09000000b006ddc7af02c1sm9049919pfq.9.2024.01.30.23.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 23:19:14 -0800 (PST)
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
Subject: [PATCH 1/2] pinctrl: mediatek: Drop bogus slew rate register range for MT8186
Date: Wed, 31 Jan 2024 15:19:07 +0800
Message-ID: <20240131071910.3950450-1-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8186 does not support configuring pin slew rate. This is evident
from both the datasheet, and the fact that the driver points the slew
rate register range at the GPIO direction register range.

Drop the bogus setting.

Fixes: 8b483bda1e46 ("pinctrl: add pinctrl driver on mt8186")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pinctrl/mediatek/pinctrl-mt8186.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8186.c b/drivers/pinctrl/mediatek/pinctrl-mt8186.c
index 7be591591cce..dd19e74856a9 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8186.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8186.c
@@ -1198,7 +1198,6 @@ static const struct mtk_pin_reg_calc mt8186_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt8186_pin_dir_range),
 	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt8186_pin_di_range),
 	[PINCTRL_PIN_REG_DO] = MTK_RANGE(mt8186_pin_do_range),
-	[PINCTRL_PIN_REG_SR] = MTK_RANGE(mt8186_pin_dir_range),
 	[PINCTRL_PIN_REG_SMT] = MTK_RANGE(mt8186_pin_smt_range),
 	[PINCTRL_PIN_REG_IES] = MTK_RANGE(mt8186_pin_ies_range),
 	[PINCTRL_PIN_REG_PU] = MTK_RANGE(mt8186_pin_pu_range),
-- 
2.43.0.429.g432eaa2c6b-goog


