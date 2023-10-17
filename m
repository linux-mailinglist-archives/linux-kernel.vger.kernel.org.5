Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD7A7CCC45
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344283AbjJQT2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344252AbjJQT2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:28:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA061FA;
        Tue, 17 Oct 2023 12:27:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32db8924201so1898917f8f.1;
        Tue, 17 Oct 2023 12:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697570875; x=1698175675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mw4sfthIPjM3BfawqG9k28qO9mlhU0PnICKHznmlMio=;
        b=NIZviTjuruV1qa9Wk70mt8Urg8uDkHAiM+hD3B0sVtTO0A7teqOEIm07xRzjaENQj0
         /XhGiyNNG3uSGOpIHKm+XAIHMEY3vvKLvE7NxPyNI100BG27rFG06kL0U07BywL2reWC
         nhGb3zLKciibGeGE3X1URcO0AitVEI5csZsSY3mCBMuxwInA93+/M6DKGK9GuofEq9+6
         aHKDPiPzlV0KBtPPJKN3aml6wn97qMPs18GkzNIe9z+Wo08lRqVlWIKAr7V70oI2V6ol
         VlsDVYydhOUqIs1VaxZ9X1a118+uh5SZHVkMDosmMP/72GfpYhScsPCMS5pv9x2eewWn
         yPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570875; x=1698175675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mw4sfthIPjM3BfawqG9k28qO9mlhU0PnICKHznmlMio=;
        b=VSMwpLypc+BXpOUleL2/HtgIIuEob4ZxoR6C4+7fBUr4RzVpXgIv4eETQDqy9bwv6X
         R+j/EZhrIZNOPmXROcZOnlRzCC84Uduz6PvOxZpIj2VYsfTeIIns0tRvGSuE5HUXdceZ
         tVEi7ZyH9NwgjwHjNZcgsFeMerUQOTvyvbsZH/ZFI0ZxfL/FDwWgSRL4mr+6Qfs0acKy
         wElL1lqqoGrB+cGCoFa7SvfPXnd6XXDzSchQl3Kz1uR+ZY7KMXFVG9tXYAQ1bwXs2oPV
         aNjSJ82iLQU6Sm8ZUyHQ25RE4qIv2SlyYrzfK8YmQr9JXeLtW76VzhU9mo5qJWoUSZYK
         b68A==
X-Gm-Message-State: AOJu0YwRvnS9ciw4zvdWKJ/bDjSYBA5WRBdoW3Q778G1lUlEqZqKqoOX
        rEQuVC8ou650ZkPFWCw70Eg=
X-Google-Smtp-Source: AGHT+IHglYUm70uW0GVWCXnzNjqxcIopFPc+GSa/J1yUXCB4sfKjA0wso4+1pkjiDF1KQL7RhyLuhg==
X-Received: by 2002:adf:e5cb:0:b0:32d:9d3d:3025 with SMTP id a11-20020adfe5cb000000b0032d9d3d3025mr2390702wrn.26.1697570875023;
        Tue, 17 Oct 2023 12:27:55 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id o2-20020adfeac2000000b0032cc35c2ef7sm435897wrn.29.2023.10.17.12.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:27:54 -0700 (PDT)
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
Subject: [net-next RFC PATCH 6/6] wifi: mt76: permit to load precal from NVMEM cell for mt7915
Date:   Tue, 17 Oct 2023 21:05:10 +0200
Message-Id: <20231017190510.27163-6-ansuelsmth@gmail.com>
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

Permit to load precal from NVMEM cell for mt7915. The NVMEM cell must be
named "precal" to be correctly loaded.

NVMEM cell must already account the correct offset and be placed after
the EEPROM as the function expect the data right from the start.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---

I would like to have some hint of the cell name... Is it ok to use
precal? Should we use "precal-eeprom"?

---
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 5228f710b3da..3bb2643d1b26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -11,6 +11,7 @@ static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
 	u8 *eeprom = mdev->eeprom.data;
 	u32 val = eeprom[MT_EE_DO_PRE_CAL];
 	u32 offs;
+	int ret;
 
 	if (!dev->flash_mode)
 		return 0;
@@ -25,7 +26,11 @@ static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
 
 	offs = is_mt7915(&dev->mt76) ? MT_EE_PRECAL : MT_EE_PRECAL_V2;
 
-	return mt76_get_of_data_from_mtd(mdev, dev->cal, offs, val);
+	ret = mt76_get_of_data_from_mtd(mdev, dev->cal, offs, val);
+	if (!ret)
+		return ret;
+
+	return mt76_get_of_data_from_nvmem(mdev, dev->cal, "precal", val);
 }
 
 static int mt7915_check_eeprom(struct mt7915_dev *dev)
-- 
2.40.1

