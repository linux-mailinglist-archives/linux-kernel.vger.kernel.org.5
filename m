Return-Path: <linux-kernel+bounces-120593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A751888D9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA4D1F2B0D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5046D36B0D;
	Wed, 27 Mar 2024 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aJgl/CjM"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CAC381BD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530827; cv=none; b=lnvvK1nQ85o28fck7oIDZNtQkdx/CvUyoKQ9M6kLlpnJPnUcEPz8hY+jbCjXRKJKnO6erSct8NNIHBnSVcTMzWcnzWIF+qcTTBAFyWs0JTeBZYVYhNI0c7w2/HsozyMKlBKtD+nM//302Dkl6HZOulUiHt57Yb/7h+NuvCQ6UYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530827; c=relaxed/simple;
	bh=v+aOuo/K4QIUDcJG8uJaze7G5zKoZoCjGDknbGfD5sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJGA+q0CyFtcjj49mi6VrznP8m6swMqjARdcR18UZpSQc15xlxOvsBGu3XbvfJjdY3goOlpOU40HG0Pm/JMvfw06rIvktPhku9pNMAzmEZV51anhYRttdqv4ewUoteAMSJgb8uzmILo5RIFYwYqrIF1D4fgoX3eMf4K1XzZTmHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aJgl/CjM; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c3d7e7402dso992342b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711530825; x=1712135625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iOYt4zJ+o1C7+SnoOb0q+ySfizskDZk97tdK1KywqY=;
        b=aJgl/CjMnpU+IQldzlojpxYqgMqKpji42FqQYb69aO6I/oRmuG31Fard4wyZxdHItO
         9xmIqhnj3655tM8lC7JrDvT8+pMyv6PqKxIM2OcEZwu8sjm38sXRFNidl0DE2JDMq9rd
         LggOA1IAVqc3qVofQkmUidYPAJf8DYvvb7YLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711530825; x=1712135625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iOYt4zJ+o1C7+SnoOb0q+ySfizskDZk97tdK1KywqY=;
        b=FBvMuwKnhjw9hD7XDwZXA+RD1uGrAgaGQjLJVIchtsVcFTZ49Bc5CIi8+nNEQ6PrJR
         lFaxh1xN+mC1DKkDFwD0jE8XSdRTGYbPoGx9hQXzYKOPeHxmudO0fmTnrhHtTNOCkLo8
         Xax3un50MRh3aMVEdRuE5t1OnHXZTnBsHORMhczdYg6JMY1uy3i+N+VfBfRc7A3y3uYB
         doVlpTIICwogEC2joWVjH4gelEUz6waBfEMhvgp3aaB+NqV1gJUxOLrHsYtBYqeB9Vn1
         CPItwGqd8t5TEAkkVg9rI7i+2XmvzQncnO/lguvCk2BK1h9J6jYP/xsWKlSDWkA4PSy2
         Go+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVG47/8b7E2pGNbiF5Fc+RAxcmIjGR7uDqDW/W4OkzqhueGI6tWAvpb2B69Vunxnucyj3G9fY+wC/aBTRlfDY0jlSsckVRPCwgtAZgJ
X-Gm-Message-State: AOJu0YwOMSH2ZKRhCkzuHrQPgTuhnIoiRfoQCq9sCTjTS7QJs66Br7D0
	krmuqH745lo6AcMZNILpLheckUGDq+EFHwx+WfQpinkxouo4Z/v3n7/wkaVCRA==
X-Google-Smtp-Source: AGHT+IF3aqIva/K4jRimDmX4/NLQURpL14i8+mvF0x7rMtjQj5U78MiIs6pbbKkfU3lhicktx6j8iA==
X-Received: by 2002:a05:6808:319a:b0:3c3:878e:a43b with SMTP id cd26-20020a056808319a00b003c3878ea43bmr772486oib.44.1711530825181;
        Wed, 27 Mar 2024 02:13:45 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:74c2:3606:170b:52f3])
        by smtp.gmail.com with ESMTPSA id fa31-20020a056a002d1f00b006e69cb93585sm7342911pfb.83.2024.03.27.02.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 02:13:44 -0700 (PDT)
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
Subject: [PATCH 2/2] pinctrl: mediatek: paris: Rework support for PIN_CONFIG_{INPUT,OUTPUT}_ENABLE
Date: Wed, 27 Mar 2024 17:13:34 +0800
Message-ID: <20240327091336.3434141-3-wenst@chromium.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240327091336.3434141-1-wenst@chromium.org>
References: <20240327091336.3434141-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a misinterpretation of some of the PIN_CONFIG_* options in this
driver library. PIN_CONFIG_OUTPUT_ENABLE should refer to a buffer or
switch in the output direction of the electrical path. The MediaTek
hardware does not have such a thing. The driver incorrectly maps this
option to the GPIO function's direction.

Likewise, PIN_CONFIG_INPUT_ENABLE should refer to a buffer or switch in
the input direction. The hardware does have such a mechanism, and is
mapped to the IES bit. The driver however sets the direction in addition
to the IES bit, which is incorrect. On readback, the IES bit isn't even
considered.

Ironically, the driver does not support readback for PIN_CONFIG_OUTPUT,
while its readback of PIN_CONFIG_{INPUT,OUTPUT}_ENABLE is what it should
be doing for PIN_CONFIG_OUTPUT.

Rework support for these three options, so that PIN_CONFIG_OUTPUT_ENABLE
is completely removed, PIN_CONFIG_INPUT_ENABLE is only linked to the IES
bit, and PIN_CONFIG_OUTPUT is linked to the GPIO function's direction
and output level.

Fixes: 805250982bb5 ("pinctrl: mediatek: add pinctrl-paris that implements the vendor dt-bindings")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 38 +++++++-----------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 9353f78a52f0..b19bc391705e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -165,20 +165,21 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_SR, &ret);
 		break;
 	case PIN_CONFIG_INPUT_ENABLE:
-	case PIN_CONFIG_OUTPUT_ENABLE:
+		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_IES, &ret);
+		if (!ret)
+			err = -EINVAL;
+		break;
+	case PIN_CONFIG_OUTPUT:
 		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DIR, &ret);
 		if (err)
 			break;
-		/*     CONFIG     Current direction return value
-		 * -------------  ----------------- ----------------------
-		 * OUTPUT_ENABLE       output       1 (= HW value)
-		 *                     input        0 (= HW value)
-		 * INPUT_ENABLE        output       0 (= reverse HW value)
-		 *                     input        1 (= reverse HW value)
-		 */
-		if (param == PIN_CONFIG_INPUT_ENABLE)
-			ret = !ret;
 
+		if (!ret) {
+			err = -EINVAL;
+			break;
+		}
+
+		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DO, &ret);
 		break;
 	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
 		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DIR, &ret);
@@ -283,26 +284,9 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 		err = hw->soc->bias_set_combo(hw, desc, 0, arg);
 		break;
-	case PIN_CONFIG_OUTPUT_ENABLE:
-		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
-				       MTK_DISABLE);
-		/* Keep set direction to consider the case that a GPIO pin
-		 *  does not have SMT control
-		 */
-		if (err != -ENOTSUPP)
-			break;
-
-		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
-				       MTK_OUTPUT);
-		break;
 	case PIN_CONFIG_INPUT_ENABLE:
 		/* regard all non-zero value as enable */
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_IES, !!arg);
-		if (err)
-			break;
-
-		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
-				       MTK_INPUT);
 		break;
 	case PIN_CONFIG_SLEW_RATE:
 		/* regard all non-zero value as enable */
-- 
2.44.0.396.g6e790dbe36-goog


