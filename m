Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181D77CCC44
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344273AbjJQT2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344235AbjJQT16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:27:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FDDED;
        Tue, 17 Oct 2023 12:27:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so56105395e9.3;
        Tue, 17 Oct 2023 12:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697570874; x=1698175674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6jQJsBRBLmDkm3I/0qquR/3BJtEfnv9Twl5IETKE8Y=;
        b=AA7w2xPK5ta5fbCh4NhIrEkL3ITN5j9fXoCY7zsyNPGx8MAISFpqXvAId0BmEshIQB
         JizZQRRZKpZPhYwOVfyJ9EzB3dD3OINh7fUwV/ZvKVseQ+7TlXxrvG831JOy9DE5nZy6
         doGjOg2wqTgvFzPwGARyryLwf+kWuqMsR77RwVX0Fcdj3pVW/721yBweV4c4NDKWQU/b
         0bM7p3CzjiXgnbWnFFSocMAVAfHig+R/KY1Tg4FPLsDI95rNX0AcigzxTeAzEnGcIbnh
         RsHYuoF9+QVoNOZSV84jppnpaJXhG3Y7fs3zcmz6rHiOvpgQ29ErYpbETM1g8fCPv+lj
         VlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570874; x=1698175674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6jQJsBRBLmDkm3I/0qquR/3BJtEfnv9Twl5IETKE8Y=;
        b=h8LcJo6YfK2H6xGjLBHuRBlhfc/UEDUz/00xXTkxVTrnMlp8Qxpld6rHyumpPo8mkn
         9+gulP+S42HD26DYs2JbfFVMj/srWUxstxhP+P7Qruq9gF1cP6TDb7W+ujU9vasxXBQ5
         cedbsAYRRYpj8PBz3qjaIKSOxZaJjaFfoWJiPh/2qpFQwEACQjdbS57NCdc16OtIqs2O
         KTOjHHV9SSYPRELLiUB3ZD8W9pJKwypOCbtwaFtpOM/pCe8XPFZRNMiOvE5nDELIslOP
         tShOs6JYYenXcfwb+ERlxoXB5ovkFBdAkucO76KHUE/ldc07C5mCij0AZ+WH7zhlJFaN
         aUbQ==
X-Gm-Message-State: AOJu0YzH0Os1Uo0hlqbhXDsLhzSX2aZssWjDeV1pUpKIm1+vhPlGHQ9Z
        A1ZGDXGXxuyzbWiF6KqbuJY=
X-Google-Smtp-Source: AGHT+IEnQ5HC+BuPuzufGE10gWuIiTfP965Vnpx9uNXzZJjYccZpAg+E7wcKaRLYSLxC56LOmeRrdA==
X-Received: by 2002:a05:6000:8b:b0:31f:a62d:264 with SMTP id m11-20020a056000008b00b0031fa62d0264mr2704276wrx.37.1697570873841;
        Tue, 17 Oct 2023 12:27:53 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id o2-20020adfeac2000000b0032cc35c2ef7sm435897wrn.29.2023.10.17.12.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:27:53 -0700 (PDT)
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
Subject: [net-next RFC PATCH 5/6] wifi: mt76: permit to use alternative cell name to eeprom NVMEM load
Date:   Tue, 17 Oct 2023 21:05:09 +0200
Message-Id: <20231017190510.27163-5-ansuelsmth@gmail.com>
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

Generilize mt76_get_of_eeprom_from_nvmem to use alternative cell name by
passing the cell name as an arg and expose it.

Rename it to mt76_get_of_data_from_nvmem to better reflect the now more
generic usage.

This is to permit driver to load additional cell, like precal cell.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 8 +++++---
 drivers/net/wireless/mediatek/mt76/mt76.h   | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 748f4b643a5e..ac6c0a0e876f 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -107,7 +107,8 @@ int mt76_get_of_data_from_mtd(struct mt76_dev *dev, void *eep, int offset, int l
 }
 EXPORT_SYMBOL_GPL(mt76_get_of_data_from_mtd);
 
-static int mt76_get_of_eeprom_from_nvmem(struct mt76_dev *dev, void *eep, int len)
+int mt76_get_of_data_from_nvmem(struct mt76_dev *dev, void *eep,
+				const char *cell_name, int len)
 {
 	struct device_node *np = dev->dev->of_node;
 	struct nvmem_cell *cell;
@@ -115,7 +116,7 @@ static int mt76_get_of_eeprom_from_nvmem(struct mt76_dev *dev, void *eep, int le
 	size_t retlen;
 	int ret = 0;
 
-	cell = of_nvmem_cell_get(np, "eeprom");
+	cell = of_nvmem_cell_get(np, cell_name);
 	if (IS_ERR(cell))
 		return PTR_ERR(cell);
 
@@ -137,6 +138,7 @@ static int mt76_get_of_eeprom_from_nvmem(struct mt76_dev *dev, void *eep, int le
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mt76_get_of_data_from_nvmem);
 
 static int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int len)
 {
@@ -154,7 +156,7 @@ static int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int len)
 	if (!ret)
 		return 0;
 
-	return mt76_get_of_eeprom_from_nvmem(dev, eep, len);
+	return mt76_get_of_data_from_nvmem(dev, eep, "eeprom", len);
 }
 
 void
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 41e4f398083e..c9934258c49d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1096,6 +1096,8 @@ void mt76_seq_puts_array(struct seq_file *file, const char *str,
 int mt76_eeprom_init(struct mt76_dev *dev, int len);
 void mt76_eeprom_override(struct mt76_phy *phy);
 int mt76_get_of_data_from_mtd(struct mt76_dev *dev, void *eep, int offset, int len);
+int mt76_get_of_data_from_nvmem(struct mt76_dev *dev, void *eep,
+				const char *cell_name, int len);
 
 struct mt76_queue *
 mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
-- 
2.40.1

