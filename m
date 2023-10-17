Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65F27CCC3E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344236AbjJQT16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjJQT1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:27:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC3BC4;
        Tue, 17 Oct 2023 12:27:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32d834ec222so5544437f8f.0;
        Tue, 17 Oct 2023 12:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697570870; x=1698175670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2HMXOLF5eJrUMENCt8aiW3aj9mFErqyM1uPwOqtdoQ=;
        b=jF7Fm+ozZZfceySpZ+DlFNpgHhpI04ln+crhE5U9OVziYCzRwYFuIa6g6syjtuz75K
         +5AC/4zmJSVSQ96Tymvlm9kZBPQO0SjgsxN4DydP6h0pYsGYRsd9gpF8h2BeME8YuaGQ
         A/sLy7TI1yHDkFgP75o8GKuIYZAAXJKU8XWAohfpXulxJId42A5iqdGX3Lqm3M7Es4cH
         BiHeqA2EboUYMvAbHC5ZkryUiH4HhMzWTa586SKYfQPoONKp7Hu9esNpdhmDWliSwMuJ
         gpqbcU2JL4hc6MXFPiMvTONTUOUP9r/NpZpjPdgaoaR8/guxprDW55oXAQ+EqLNtnZAf
         uOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570870; x=1698175670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2HMXOLF5eJrUMENCt8aiW3aj9mFErqyM1uPwOqtdoQ=;
        b=bCMk1euWHV0LM3pVstdi5hpo5BG+7/IZA8cWjFIR0H+9BK/CtzSl7PGiHBlO+wCHnx
         +OtDEaFisitSFIh1zO7hUTIrE+klMPkTEIWvthze41KehvP4n8WqFIqDiwFhEl5Meyvr
         3DqUEJA/74QasFbPKj19J0yOAfcSpLP9aXU9RVB6uCtYRgqHEv6rej235yjkbALR58zY
         6Ov/jWxiAjDotaMfCh1F7YizO0pJc++fuCyleZM25yGbm3ZU86+rNm4fA/Fs7XyZoYcs
         Z5rQNEkvG/IAIYWek7FUC8nExnV8bLd38jhjr016j9naAAWKMxhA8wu9xNL8YO3dLjI+
         Zfbg==
X-Gm-Message-State: AOJu0YyWIni0Yyrbp6X7Ag8PiE5p9Gf1GE81h8pABraMN+XD0X+w5U0U
        BI+AH1AiexDaaGN5ADHq+Uw=
X-Google-Smtp-Source: AGHT+IHaxYR/ji/TpEeQiKOxetQQnrm2fznjqODcepcXxmiYcoSadf6rAytgEwutDBenrBNoao4Scg==
X-Received: by 2002:a05:6000:1375:b0:32d:a98c:aa1f with SMTP id q21-20020a056000137500b0032da98caa1fmr2431879wrz.1.1697570870180;
        Tue, 17 Oct 2023 12:27:50 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id o2-20020adfeac2000000b0032cc35c2ef7sm435897wrn.29.2023.10.17.12.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:27:49 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Alexander Couzens <lynxis@fe80.eu>,
        Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [net-next RFC PATCH 2/6] wifi: mt76: fix typo in mt76_get_of_eeprom_from_nvmem function
Date:   Tue, 17 Oct 2023 21:05:06 +0200
Message-Id: <20231017190510.27163-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231017190510.27163-1-ansuelsmth@gmail.com>
References: <20231017190510.27163-1-ansuelsmth@gmail.com>
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

Fix typo in mt76_get_of_eeprom_from_nvmem where eeprom was misspelled as
epprom.

Fixes: 5bef3a406c6e ("wifi: mt76: add support for providing eeprom in nvmem cells")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 2558788f7ffb..1de3c734e136 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -106,7 +106,7 @@ static int mt76_get_of_epprom_from_mtd(struct mt76_dev *dev, void *eep, int offs
 #endif
 }
 
-static int mt76_get_of_epprom_from_nvmem(struct mt76_dev *dev, void *eep, int len)
+static int mt76_get_of_eeprom_from_nvmem(struct mt76_dev *dev, void *eep, int len)
 {
 	struct device_node *np = dev->dev->of_node;
 	struct nvmem_cell *cell;
@@ -153,7 +153,7 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
 	if (!ret)
 		return 0;
 
-	return mt76_get_of_epprom_from_nvmem(dev, eep, len);
+	return mt76_get_of_eeprom_from_nvmem(dev, eep, len);
 }
 EXPORT_SYMBOL_GPL(mt76_get_of_eeprom);
 
-- 
2.40.1

