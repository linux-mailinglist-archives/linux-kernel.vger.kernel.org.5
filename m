Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B927F8ACF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjKYMf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjKYMfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:35:52 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E7019A2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:35:53 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a04196fc957so400375966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700915752; x=1701520552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txTWULb3qOMaVJaVM0srxekYyIAj97clVpD1wkCUdRs=;
        b=EWPRE/vfl+RmfjK20cXi9hFsk188ZxF6ccY/qTb73etgm1jvHEt5POQmimUde9A/Y5
         IdCMqBIsGH1JXEuBbulmhReOmpDv9oIlVdAnrEusnTp++iADI898Dn+m160uUaVzX4y1
         +FNGjCLURqJDBmnwN5oUh9/EIizXnZRZ6FeGtHobFOopnfF/n9vlS0uao3Y/PtsgjzxM
         sfhUAbU98c9ziJ/5OwyM+YGk7oYeyvUqIGiB72VeJVEwjoXZ6fzE46eNIDPW+pJ65WY/
         dCo24w0ZyuD0v+IEx83Zkvr5ATsLAs1UQJj538L+fGglFA/HhFDEpyc4s2B6fTclH3sA
         ZmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700915752; x=1701520552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txTWULb3qOMaVJaVM0srxekYyIAj97clVpD1wkCUdRs=;
        b=gtGQo8myPnK2Jpgcx1u9JW1mkEjCso9EXj6jdekPlD8WJa3ZO0S4EmmHONE33S7ryS
         5t0yqE+lCPfaKDZP5xdVjhSxwXgP+F2cXlq55prmaEErZe4tMMmQQw+Pj1zFHG5zx4B5
         oQUovMUHzcPvy9KW7nn6T8/di7cxhKM1ip7d0Oj5X0ljrF28kltTSiBTrJ+kFs0l4DnC
         XHUpFBKajLZZWh6+6BQWapMFkazrS8YBIdjsyMwW50ozEFcObgs08ceHHubFKSOxsg6q
         T/CpO3aUuD+3aZ6rV3BCLKo0jeGq2d6VdwrAfvDwO2zYiUdxRRYkdu6UZ3vAaIH2gkFe
         rpuQ==
X-Gm-Message-State: AOJu0YzQn7H25hUtQJ8m42H4Q2i1gWCFSjMA+nMKjPTXyp9jAztB3svH
        Qs6ag9qo0bBNAuHDfUDjlwkciQ==
X-Google-Smtp-Source: AGHT+IHjGaQJjZMvJEp2O+E3VbE3I7/oZ2yVxz1hpulXF7qjWb1sTM6BVp4MjQScsWOTjZslEF2t5g==
X-Received: by 2002:a17:906:d2:b0:9e2:af56:c380 with SMTP id 18-20020a17090600d200b009e2af56c380mr4056526eji.6.1700915752219;
        Sat, 25 Nov 2023 04:35:52 -0800 (PST)
Received: from 1.. ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id lv23-20020a170906bc9700b009f28db2b702sm3390163ejb.209.2023.11.25.04.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 04:35:51 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     pratyush@kernel.org, michael@walle.cc, fastevam@denx.de
Cc:     linux-mtd@lists.infradead.org, takahiro.kuwano@infineon.com,
        bacem.daassi@infineon.com, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 4/5] mtd: spi-nor: remove NO_CHIP_ERASE flag
Date:   Sat, 25 Nov 2023 14:35:28 +0200
Message-Id: <20231125123529.55686-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231125123529.55686-1-tudor.ambarus@linaro.org>
References: <20231125123529.55686-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1896; i=tudor.ambarus@linaro.org; h=from:subject; bh=CCp3s597dd2N34pcvWqlxQ50V8OYh2tnaQCvSzFKDOc=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlYeoRHtkHuEy/gG4P7KkUgLRNHmTbUGbxJBrYu JpjuIMIeFqJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZWHqEQAKCRBLVU9HpY0U 6U8EB/4isL9ZPOAlY3kE68x1LosSOh7Ai80yt+wDjJVDB5heW0xOuYMbkEfIwfpIYuDCHR+GYnd XgA5CiKFrqLiHwBMwRJWKYVHby+AfwdlgJ1D8m+gCeW/8a1KAeBHGDYm3Wt85AoEV+yiFFvDEV+ b+PQX+WSWDVPCX9DrygJ+S5Wy5ddhid7ZoZXrrI84jOjOgC50BUQqEiCRoMLN3GI/L6WSvCeHgp 827qSsTa2taSWG8HocFv0Q/I257SwmQzNUJxGEUPTL8drbtu6if3yd49etgNoooeQiVn/hfS7zK iDgH8EbbhaZDpYO9+qKUoKhnFSDuV2LhYd3AD6zPqPXutGN6
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no flash using it and we'd like to rely instead on SFDP data,
thus remove it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c | 3 ---
 drivers/mtd/spi-nor/core.h | 8 +++-----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 52e5b569ddfd..503fed90c2fa 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2888,9 +2888,6 @@ static void spi_nor_init_flags(struct spi_nor *nor)
 			nor->flags |= SNOR_F_HAS_SR_BP3_BIT6;
 	}
 
-	if (flags & NO_CHIP_ERASE)
-		nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
-
 	if (flags & SPI_NOR_RWW && nor->params->n_banks > 1 &&
 	    !nor->controller_ops)
 		nor->flags |= SNOR_F_RWW;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index b43ea2d49e74..29ed67725b18 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -489,7 +489,6 @@ struct spi_nor_id {
  *                            Usually these will power-up in a write-protected
  *                            state.
  *   SPI_NOR_NO_ERASE:        no erase command needed.
- *   NO_CHIP_ERASE:           chip does not support chip erase.
  *   SPI_NOR_NO_FR:           can't do fastread.
  *   SPI_NOR_QUAD_PP:         flash supports Quad Input Page Program.
  *   SPI_NOR_RWW:             flash supports reads while write.
@@ -539,10 +538,9 @@ struct flash_info {
 #define SPI_NOR_BP3_SR_BIT6		BIT(4)
 #define SPI_NOR_SWP_IS_VOLATILE		BIT(5)
 #define SPI_NOR_NO_ERASE		BIT(6)
-#define NO_CHIP_ERASE			BIT(7)
-#define SPI_NOR_NO_FR			BIT(8)
-#define SPI_NOR_QUAD_PP			BIT(9)
-#define SPI_NOR_RWW			BIT(10)
+#define SPI_NOR_NO_FR			BIT(7)
+#define SPI_NOR_QUAD_PP			BIT(8)
+#define SPI_NOR_RWW			BIT(9)
 
 	u8 no_sfdp_flags;
 #define SPI_NOR_SKIP_SFDP		BIT(0)
-- 
2.34.1

