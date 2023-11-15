Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230847ED5BF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343857AbjKOVMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbjKOVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:12:20 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E38198
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:12:16 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5bda105206fso78330a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20230601.gappssmtp.com; s=20230601; t=1700082736; x=1700687536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D7sCUwcBlF+LnWvSB7Jm+r2N1IF61ZdXk6HmmnXauaI=;
        b=QK1rzMQpEQfokpZtS8QHgHQB157NrIBwE/14/tLK6GxytHJ2+V0/i6KgOAJqwqP+Yv
         aAb1B5W8nPqNbOURF3bm8C/0eBSZuezShDgYofKvdK443HUC9TDumdzSO8UEnG7yEzvL
         QCT8U3j5sfc/KeBjdJRndkd0ZASzRcEvX91SxWGepjOF41gkH6uNyb8SDys1XgKFIIlp
         gKEBZkAvNnNdADi5FdZXFLw0uk2+0zC4UqOd96nf3sgrgyXCUbjUXn1z1o7dHHR2bKnw
         JFXdFyCaXKMQiSqRMswPTfK5TfyfO7u9XPBFHS+9KVRO3kZ+ES5ldsgdQvO+zWxRFwi3
         jrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700082736; x=1700687536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7sCUwcBlF+LnWvSB7Jm+r2N1IF61ZdXk6HmmnXauaI=;
        b=kxsKZgiycw5J5tzqG/pza52rhilKs8GkpZM5aRKvT9F4gFiVJRNNS/Bn72fveqswVP
         Yx9xn2O91kZIdgk05WY/QY45Np5ixaYqEsfh9q0IBt9J3yIdXrjfZutRsYFhnapVV95H
         3VMtnzlLG7vrSBosjbYldzc/Gr3LH3/Luup19RiPm4gPeop9tuIoQK4yyod5LDQFwG4M
         0w/Er2IVz0CyIyAATdXT4acksSqDyyIBW7Noj23cC9op8M6eGWSw0UDeSxw/fqaFwcEm
         RZ9przkcuBGJ57QqCPlPffh02HE56Q1UQHtWtmQFCNJL0XDxlkBe8DPt3HI8HYAY2sLX
         zD0g==
X-Gm-Message-State: AOJu0Yy/XEXVhp5qnTOV+TkbjSXTI9CcO8D/+CmksGS28RH34sZ+SOvw
        0HtR30Z1311N9BSdYchpfP0nziKKeCw+ir/hGk8vCQ==
X-Google-Smtp-Source: AGHT+IEvOBFvCIx2bVxuryxCJrCem8yQIbAY9UFsBdN4FoO3+8M5uv/YfMjfsGXOegflz/Le7wFLbw==
X-Received: by 2002:a05:6a21:47c7:b0:187:a945:8372 with SMTP id as7-20020a056a2147c700b00187a9458372mr597323pzc.23.1700082736303;
        Wed, 15 Nov 2023 13:12:16 -0800 (PST)
Received: from wak-linux.svl.corp.google.com ([2620:15c:2a3:200:c624:fd:194b:791a])
        by smtp.gmail.com with ESMTPSA id e16-20020a62ee10000000b006c31c0dfb69sm3163912pfi.188.2023.11.15.13.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:12:15 -0800 (PST)
From:   "William A. Kennington III" <william@wkennington.com>
To:     tmaimon77@gmail.com, tali.perry1@gmail.com, avifishman70@gmail.com,
        linus.walleij@linaro.org, joel@jms.id.au
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "William A . Kennington III" <william@wkennington.com>
Subject: [PATCH] pinctrl: npcm7xx: prevent glitch when setting the GPIO to output high
Date:   Wed, 15 Nov 2023 13:12:09 -0800
Message-ID: <20231115211209.1683449-1-william@wkennington.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Maimon <tmaimon77@gmail.com>

Enable GPIO output after setting the output value to prevent a glitch
when pinctrl driver sets gpio pin to output high and the pin is in
the default state (high->low->high).

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 1e658721aaba..62a46d824b46 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -1790,8 +1790,8 @@ static int npcm7xx_config_set_one(struct npcm7xx_pinctrl *npcm,
 		bank->direction_input(&bank->gc, pin % bank->gc.ngpio);
 		break;
 	case PIN_CONFIG_OUTPUT:
-		iowrite32(gpio, bank->base + NPCM7XX_GP_N_OES);
 		bank->direction_output(&bank->gc, pin % bank->gc.ngpio, arg);
+		iowrite32(gpio, bank->base + NPCM7XX_GP_N_OES);
 		break;
 	case PIN_CONFIG_DRIVE_PUSH_PULL:
 		npcm_gpio_clr(&bank->gc, bank->base + NPCM7XX_GP_N_OTYP, gpio);
-- 
2.43.0.rc0.421.g78406f8d94-goog

