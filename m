Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EA57C5DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjJKUAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjJKUAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:00:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BFB94;
        Wed, 11 Oct 2023 13:00:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32799639a2aso204511f8f.3;
        Wed, 11 Oct 2023 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697054408; x=1697659208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tX0FgbDhoDy/c6Xp48Q/Lp6Lf1CmRpkAa0uRPBrtEzI=;
        b=kS85T0iNm6PXIkQ0vwA6Dm5UsGu/i7zsw06X4JZXfjdmX984sUoC42aDac/l4TSMSF
         TJfcLQseLgukjFaia7yoJiX9XLZKu5vifaUrc0v7XvJRZfUO+FyjP5RC5k5x9bSa/K8g
         dZBG9fvWCPNj9Ty6oZ9lMiN539hwHIu3qaTlLOi96Zlg8btjnNOWnqMFqAkH1cHOgeca
         g+sWDAD+5rSRhuIp63ekbg469lob8lKoDHYVzpHKXN1/GXj/SXOJkKInkiHO6hPkf4xI
         8ReZ9qemD54ZWMlwXYmzev9LpP/0qh2+NadbqLgVnppFD+73QHFpYIZ01orfDjKgP4xG
         e41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697054408; x=1697659208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tX0FgbDhoDy/c6Xp48Q/Lp6Lf1CmRpkAa0uRPBrtEzI=;
        b=Lx3INY8AhvvYmRNypE70JsvujhRski+yYNTaI1U7CObkWH15oagUI1flg8R0TYCKnJ
         810Djq6GwsFMAwvQnLfdts1NsM8AEyLMUQjdqpAG9aVY0df4B866RHrletyaGiJDDyWf
         VIZc5Yahj5qKbUA+7gXa8yXVlkiSQTm6XtT8Ymbd08JZfiS9qLjJKyvAqoSl/L6muAxA
         711UmgoCBnePXvzPgJR0Iolad1Rc1OBCp4JKFlUV0s+/vavXE031LCprm/EZurPRO2IL
         2mEPl8MZKY5yZuZqoNAQxVouBDQ6SXonyjK1/NM6tuqExAxI8gLznygzFKLOF/BUgYAB
         U8Eg==
X-Gm-Message-State: AOJu0YxPm6BxU9iKVzHMD35r93aBJ2QeBo3AE4aRYo5hJeHijA4WHhf3
        lr+8akn1Ti+f86N5yRth0/8=
X-Google-Smtp-Source: AGHT+IFE2hIFhU90VcqiD1hYI+viGbFaj9N2hYTLBPhgD1g5g2LebpwK9LSugAQZhx3RtB8KGn3BQg==
X-Received: by 2002:a5d:4586:0:b0:31f:eb88:e3c8 with SMTP id p6-20020a5d4586000000b0031feb88e3c8mr18897299wrq.32.1697054407705;
        Wed, 11 Oct 2023 13:00:07 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:b8af:68b0:4272:ed0d])
        by smtp.gmail.com with ESMTPSA id r18-20020adfe692000000b0031912c0ffebsm16329039wrm.23.2023.10.11.13.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 13:00:07 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] pinctrl: renesas: rzg2l: Enhance driver to support interrupt affinity setting
Date:   Wed, 11 Oct 2023 20:59:23 +0100
Message-Id: <20231011195923.67404-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Implement irq_set_affinity callback so that we can set affinity
for GPIO IRQs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index c7c6d912a975..e6bf66fca074 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1576,6 +1576,7 @@ static const struct irq_chip rzg2l_gpio_irqchip = {
 	.irq_set_type = rzg2l_gpio_irq_set_type,
 	.irq_eoi = rzg2l_gpio_irqc_eoi,
 	.irq_print_chip = rzg2l_gpio_irq_print_chip,
+	.irq_set_affinity = irq_chip_set_affinity_parent,
 	.flags = IRQCHIP_IMMUTABLE,
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
-- 
2.34.1

