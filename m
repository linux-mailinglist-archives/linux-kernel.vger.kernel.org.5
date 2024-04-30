Return-Path: <linux-kernel+bounces-163384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104E18B6A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423BD1C22169
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDD817BBE;
	Tue, 30 Apr 2024 06:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZNsf7Sy"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738E717732
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456994; cv=none; b=kAaZ6LmJeujFTPL9E6xCHSqKCPGHe05gJfumnKUuK3lp6HXJT4GvI/dR1RksdYtql808iBUfi0qXLv5PvKcExNKixkiMXr8KizdLjMunMDXNRe9c0AjLbcFRUwG+w/4i3PceBY5ThIyYiRjvgAxIrPtH+BTk3ZRyDo6jKQqPEPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456994; c=relaxed/simple;
	bh=wtyxCJh3Ttb/JDN5D3EE4COwC3BdfekHMXHWvpmaJO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KI/W8RrGZHsPYgvuwAXMHHQFhT5oPzeQYnZ96xXucuQGrYGWhBTfW/Iscx8yyBX/Tpm0IXkLVeDmKtAu5MiI7b/0xCGeyafemW3iDPF5G9FK0Moituo0Cb/GfGZYdPlnQUX3Jenj+XtHUivRIFMmGStDTZC8sL15jXhEztDpS1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eZNsf7Sy; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so5497141a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714456991; x=1715061791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3f+ijQyeya70KJofDglQNOZzfNHaShj1cgKGVLxvefs=;
        b=eZNsf7Sy3+QpkZE+rWrrU+yaVGKDGSJTrDLVyqufMvJ0WVe8bPmIWlhj9VPHE9arbe
         RkAgdq8P5wJRriU8Sgwyb9WQs5LhZUN+qTo5GZeqiR/+r7KIvby5DysR5fG89w/plAzg
         7ccS9teBB5P8feoB8BDmoYbhAtlPpklC0xa4YDahpq6QI7F/4OZvXJhr2yWUnotypkDg
         gUty+QuzA/iYRqCN6JfyQ+mcy9Ne9Ljf48LxpvRVt/FlHZmCOMaU8MjVNZzxqFRP6c8R
         TyoK8HI0lRGfY5wJX64qkPy1pCv7SyNTmOiy7g2SjnUl4ceZYdgNglCShMBhrpadBCnx
         E0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714456991; x=1715061791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3f+ijQyeya70KJofDglQNOZzfNHaShj1cgKGVLxvefs=;
        b=fE2B3tvDDglMrkx7KWAk5/p1o9fP2MYNkqlb0l4cylPxx/aGY6CMMvZtc6gHlz0EOR
         gtHVFkimgE8dd56EaARAX4YGRMn9OgkmkQ6HZ/DZFQT9VY4r/KuG3HFEDievXWzuVDPP
         JpA6y7r5LFO1wuvd+5iG8aeIzuWiRxRRudfNSZYfwxH3PRu3EVdZrb9gWI+4pxcfndXE
         CJoiOCmMq0xrMjzlzzprxpSdKoaw9+f3zt8Bked9qH4NXuQLYj4vMUfTd8mNRVqUzz/A
         ylQ7lFSFUMPyRxQ7iOA4WE0F5Ji9XVwhPG/5VfJOgVeMyz7ohxZYH79wNTIoTj+KiD+b
         uNQg==
X-Forwarded-Encrypted: i=1; AJvYcCUs4CHZalAExRRCFC7yFFU15p0jUeXKqU5zogHXG9VipNAumoe3W0iXVlZm6NA0SdbZBS1gBLZaGYJY2xFxXNF/B3KxVGFp8vrRkSij
X-Gm-Message-State: AOJu0Yy92RU32W0PAgX8w9wTvhs6XVXXvo2cyfdXNJcG1Tjc/4Tle13x
	+70VAKbZLtHSqcyp7BuuEOLoT+b1eWz5ny3SLnjqcRQVn+rEgJkmhgQgAafXbno=
X-Google-Smtp-Source: AGHT+IHsxQu1c/Z0Mn3dDIrV8VWK+y6QBHxho/ga7aS2nKLQZkv6W1lrMPoJJP6b4oCO5JKOaJkTsw==
X-Received: by 2002:a50:d497:0:b0:572:9c4c:2503 with SMTP id s23-20020a50d497000000b005729c4c2503mr227076edi.38.1714456988740;
        Mon, 29 Apr 2024 23:03:08 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id ca4-20020aa7cd64000000b0057279d452cbsm2744580edb.83.2024.04.29.23.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 23:03:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] pinctrl: samsung: drop redundant drvdata assignment
Date: Tue, 30 Apr 2024 08:03:04 +0200
Message-ID: <20240430060304.12332-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix W=1 warning:

  drivers/pinctrl/samsung/pinctrl-samsung.c: In function ‘samsung_gpio_set_direction’:
  drivers/pinctrl/samsung/pinctrl-samsung.c:633:42: warning: variable ‘drvdata’ set but not used [-Wunused-but-set-variable]

Fixes: f9c744747973 ("pinctrl: samsung: support a bus clock")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404300825.6lxLwvUY-lkp@intel.com/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index f4607b8493ff..623df65a5d6f 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -630,11 +630,9 @@ static int samsung_gpio_set_direction(struct gpio_chip *gc,
 	struct samsung_pin_bank *bank;
 	void __iomem *reg;
 	u32 data, mask, shift;
-	struct samsung_pinctrl_drv_data *drvdata;
 
 	bank = gpiochip_get_data(gc);
 	type = bank->type;
-	drvdata = bank->drvdata;
 
 	reg = bank->pctl_base + bank->pctl_offset
 			+ type->reg_offset[PINCFG_TYPE_FUNC];
-- 
2.43.0


