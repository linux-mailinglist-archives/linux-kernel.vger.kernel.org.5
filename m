Return-Path: <linux-kernel+bounces-119239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C7E88C606
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20BB93058C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADA413C683;
	Tue, 26 Mar 2024 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f15vaomC"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8B11F168
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465017; cv=none; b=PcQjGZlk+vOp3JRmhF7Iggmqr8gzitWiiqtTgA/IYhy5dyGkosMXY0E00e2lnM62b7JRrOzLHLemwg9LrlyuhaP4WDGgln61hf5fYyRY6nYDEX1iJWKCPbnXK/LM2Ksd8VVX64C02eOq29QzngeiGygM9QNNmMJVEyu2JfrsSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465017; c=relaxed/simple;
	bh=2y9ctp56HMkbvyZgKo5fx6Q9dshxX5+8r2XntdNWGeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l0ZWyKw3uNCY9ybFphLBZJn6zDtjh8mzDdvEKXJmuX0uuc5Ka5Vm4ZbhtN544Gn//BxqxOOL4b7r2YCaqWvKWmFwd3/X1f4ZxTNM0xolVrEoW4gEunqZnFeUu744UW7q7DjRQuIn9oHjWI0A4GDj85oksXxVMVK1oj28XIceuZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f15vaomC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41490cc034aso2192015e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711465013; x=1712069813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/G1vU/i34n4Yf6dbVXXOkUIfKhQJFotsjQ1E/HHO2A=;
        b=f15vaomC0cvHnHoFzNXXTfWCoXvbuMy8w/RoqQBw0ku9hs/3EX5LWswwSWV4D/Q5Zv
         qo+fZhzXcSNhBdt+kpbU40MdUxUVydKwL6nujj5g1XUs+ZbpOC7CsQRsWR/1D6460Ekb
         pqSMHwZWnCQxOKtxA66IFEoXoR/rSHYvj4Kk6BLykWHE2cIgiEVldCLa5NFt6jiJKtcc
         FTN0NjKdOXQfCXkmxGaSvasSKuDmQFcKmnEGeEAc5XESzB9lMusV7bVAwv8A/86OS6V2
         YY6IrAWWhvOk8MrnszbSjeHsPg95zgbnXkZWaIlhxOnD9gnzJuF5DjZd4QJjPQ5ytO10
         Iu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711465013; x=1712069813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/G1vU/i34n4Yf6dbVXXOkUIfKhQJFotsjQ1E/HHO2A=;
        b=O4bw+Xnd/asVHKY8d4+Znqy/+9F0Fbf93rBpgWjcg93OnR8UJWI1ET4q4Hnovt0imU
         Jvh2KE+yLEoteCss1YHSGpRcn2OpE5VWAJWopfwJWqGg96XGpJsbHkw5VlU82cXqENB1
         9065GbHi15jUkuOUxcxTBNdeq/MjV8uaXZUZ7s5P3zzm2Z2hDxOGCTnctZ5HN+am3g+y
         u/vH0PUhp2PcRahAxHy5AIE8vJTiW9H2nh0qlJF6dFTgC928TtVsE+B2PPlcGxoTjMPF
         Tb2LnNCC/AIy/Dh3USW3qUkUSD3BqxG37ue+bUJk3Vg+dgvw7cirgwXIeEssHxtSSnaw
         8hnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqymt3djnJRJYzbnNqUiRyDf3xj6jJMER1Sb+TO352lm5aAxGeQ0DuzTCPLfVxtHjYJ0H02hGrb2ik6QnRabxCV/WOaaiSTuwUoTxU
X-Gm-Message-State: AOJu0Yy7nEobSKA8B+eU/pf47vZ5tFq9nOIAcvkSD9eva7NTuRXQkQhV
	AEgEd+MpQ9J7oAoYn1JCTypxRL8nRijio4fAG4468HoYZEP9DwBwvzBGFrFNCx8=
X-Google-Smtp-Source: AGHT+IHgX0UjDpUS3pvvXSWQ89lGsdbFRcjbil8q0TiSG1zwcrctb+NcH3iuLaIhpS4dSbwwuyx9yA==
X-Received: by 2002:a05:600c:4510:b0:414:1351:8662 with SMTP id t16-20020a05600c451000b0041413518662mr1176708wmo.12.1711465013025;
        Tue, 26 Mar 2024 07:56:53 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c4e8c00b00414850d567fsm9838120wmq.1.2024.03.26.07.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 07:56:00 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Markus Mirevik <markus.mirevik@dpsolutions.se>
Subject: [PATCH] gpio: omap: Fix double trigger for level interrupts
Date: Tue, 26 Mar 2024 15:50:14 +0100
Message-ID: <20240326145439.1293412-1-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set gpio trigger before clearing the irq status.

This patch was originally proposed by Grygorii Strashko.

Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Reported-by: Markus Mirevik <markus.mirevik@dpsolutions.se>
Closes: https://lore.kernel.org/all/20220122235959.GA10737@sol/T/
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
Hi everyone,

this patch helped me on the beagleboneblack to remove the mentioned
double trigger of level interrupts. This diff was proposed by Grygorii
in the thread linked in the commit message. I am not sure why this never
made it into the kernel, that's why I sending this patch. I did not
create the diff just made a patch out of it, I don't care about being
the author but I would be happy if this would get merged or some other
solution to the problem.

Thanks!

Best
Markus

 drivers/gpio/gpio-omap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 76d5d87e9681..74b8fe2995e1 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -696,6 +696,9 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
 	raw_spin_lock_irqsave(&bank->lock, flags);
 	omap_set_gpio_irqenable(bank, offset, 1);
 
+	if (trigger)
+		omap_set_gpio_triggering(bank, offset, trigger);
+
 	/*
 	 * For level-triggered GPIOs, clearing must be done after the source
 	 * is cleared, thus after the handler has run. OMAP4 needs this done
@@ -705,9 +708,6 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
 	    trigger & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
 		omap_clear_gpio_irqstatus(bank, offset);
 
-	if (trigger)
-		omap_set_gpio_triggering(bank, offset, trigger);
-
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
-- 
2.43.0


