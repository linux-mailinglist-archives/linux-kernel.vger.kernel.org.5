Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E867D2FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjJWK2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWK2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:28:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281FCDB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:28:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5079c846dcfso4129692e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698056888; x=1698661688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mmpbmNsgTug//AKJ23/LOrdfKl+bPeYyVbdQxbwryQU=;
        b=HFMx6Vpk1WYr9L3T+Ehw03LMhD0CTnqfUmzSvs37mL0EqgAq9y309v2/a8jZuWhhrQ
         RiFPCzf2wDCsIKlComjSU2Ytu5X6XO88yLezkswbJ0pkv27BUv4ivyCvAd5STpsyS/qx
         fJeyiiK0n+uHhZdMzZYgFTVZbAw/kCnB7lMNuJRJZwqUjatt3VUuDyqcDKjQWexrHZqp
         8UCQ4go48Kdayo6osNN21TwWg3FWtyMVqSH99w8UpR9MKsKGczfe1kWtpIzcFxJTWunU
         3/3HlAXgRSE820j6E1XpFioF7XNkvdL546JAp1FXM1K2pjqV9rD0udalsteZLL51jCvB
         zvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698056888; x=1698661688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmpbmNsgTug//AKJ23/LOrdfKl+bPeYyVbdQxbwryQU=;
        b=Z7rvSQLHXRzhzMPlwH4z7adnPTwAIip5hwJDRTKraFLC75s/WiUyvSwAXSJmyaEJB8
         jztFynkjM/ZD29q7a6wNHnFmRs1kMNjQEnZ3F6+oNZQoq13z1zzoB9oINSZi0788d+Cr
         gsIVmMyUyAkxiiuDCWHr2M5Tgsj+51+vS9OiVIb+a3GKHgLRVUEcr1WGe14fEv29wodU
         mJ0LzBHwc2SETpVDoG/GTC0qZMIvmOti38ISSJUTFvLV+wFTh6NrUEgERQAoOldaJ+54
         PqrQTSlfhgbnLn50n463YHw5JlfgYyPFShLazRQw4ZHRIunZGy1ooNZtzSFqPd7gCNZL
         iWgw==
X-Gm-Message-State: AOJu0Yy+kY21A6lPaZ/gK/u6V7PudBREBworCcndFWAkpCwiIvrNo5wl
        bk91nJFo+96RcivLYc7kNpM=
X-Google-Smtp-Source: AGHT+IEk0BIT4qm3w/hQKen9lE10v/DCqP0PmAupQ7uBGK9Pymywqj0AQFZw/jvACh9HlLsqd5RW6w==
X-Received: by 2002:ac2:5456:0:b0:507:b074:ecd4 with SMTP id d22-20020ac25456000000b00507b074ecd4mr5594571lfn.7.1698056888098;
        Mon, 23 Oct 2023 03:28:08 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id o13-20020ac24bcd000000b00507a622184dsm1651629lfq.173.2023.10.23.03.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 03:28:07 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH reworded] Revert "nvmem: add new config option"
Date:   Mon, 23 Oct 2023 12:27:59 +0200
Message-Id: <20231023102759.31529-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This reverts commit 517f14d9cf3533d5ab4fded195ab6f80a92e378f.

Config option "no_of_node" is no longer needed since adding a more
explicit and targeted option "add_legacy_fixed_of_cells".

That "no_of_node" config option was needed *earlier* to help mtd's case.

DT nodes of MTD partitions (that are also NVMEM devices) may contain
subnodes. Those SHOULD NOT be treated as NVMEM fixed cells.

To prevent NVMEM core code from parsing subnodes a "no_of_node" option
was added (and set to true in mtd) to make for_each_child_of_node() in
NVMEM a no-op. That was a bit hacky because it was messing with
"of_node" pointer to achieve some side-effect.

With the introduction of "add_legacy_fixed_of_cells" config option
things got more explicit. MTD subsystem simply tells NVMEM when to look
for fixed cells and there is no need to hack "of_node" pointer anymore.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Greg: I reworded this PATCH's commit message. It's hopefully clear now
      that this revert is OK only with the "add_legacy_fixed_of_cells".
---
 drivers/mtd/mtdcore.c          | 1 -
 drivers/nvmem/core.c           | 2 +-
 include/linux/nvmem-provider.h | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 320d8ad2babe..bb0759ca12f1 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -560,7 +560,6 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 	config.read_only = true;
 	config.root_only = true;
 	config.ignore_wp = true;
-	config.no_of_node = !of_device_is_compatible(node, "nvmem-cells");
 	config.priv = mtd;
 
 	mtd->nvmem = nvmem_register(&config);
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 2710943f53c4..bf42b7e826db 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -935,7 +935,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->nkeepout = config->nkeepout;
 	if (config->of_node)
 		nvmem->dev.of_node = config->of_node;
-	else if (!config->no_of_node)
+	else
 		nvmem->dev.of_node = config->dev->of_node;
 
 	switch (config->id) {
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 1b81adebdb8b..e3930835235b 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -89,7 +89,6 @@ struct nvmem_cell_info {
  * @read_only:	Device is read-only.
  * @root_only:	Device is accessibly to root only.
  * @of_node:	If given, this will be used instead of the parent's of_node.
- * @no_of_node:	Device should not use the parent's of_node even if it's !NULL.
  * @reg_read:	Callback to read data.
  * @reg_write:	Callback to write data.
  * @size:	Device size.
@@ -122,7 +121,6 @@ struct nvmem_config {
 	bool			ignore_wp;
 	struct nvmem_layout	*layout;
 	struct device_node	*of_node;
-	bool			no_of_node;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
 	int	size;
-- 
2.35.3

