Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0978D762F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjGZICT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjGZIBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:01:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE1B4C22
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so55516035e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690357993; x=1690962793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGJKtRw4TvIjPpcEW3YYZgR3twL7SAYz6w/Nk+vj+ZE=;
        b=w5N02p5SiiYJzQLFwwFAOX+7CvxBIy0/op/fP7rzRTUMU0q9f8p7MQQURBZj4jmMwb
         ps3gfl6B3efxxCc9Rcm6T0DCVvNrXD60wCEtEg/3dHSkKuI3Wkg8LoEbKuXmJohWUYwd
         v3n5m5yVcBLJdQbf4gZkS9SaHcbJOn3KVu6ovu+vDqY5U1qLZ3+jUDaxdyLsIHqJAcFd
         CG9dEpcSmvtCvkrsSU/DkYFOCkGIOE6Sc2zS83joAyacLwSAcf53QJdm8GiQD7scsbbh
         ncrZnYFIryqFqNh20v0sATflY58Ri13I8pr8jQX4owbRd3imaUsrEdZkZiZ6su2JyQqf
         8Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690357993; x=1690962793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGJKtRw4TvIjPpcEW3YYZgR3twL7SAYz6w/Nk+vj+ZE=;
        b=TvXNtcEyMnMIoeqz01ZRKTCFwjCyVxtikcZ+tn6Bz9XSqDHVXLuTizV2rgv02yS/zw
         LYI4D/8K5Ld3AoKdwsljB/EapY+9gEQKywR7o9x0MmnlzTv2AvU5fuFWxeg7xoAuic9H
         5IekzhmdJNqgAF2LA7DjQCErKVat5NmGxkbuHxpzUn62e5a5raYdGic4T0IlvJh4xwgq
         ycCZctA263SDPherx4rnA17dzYv4KnKz9YhSFaViSMiR/GD2CfmSkpwFCuWaeID8QnDq
         z/FJZSPLeN76aeqcT3Oc8q0HtCpaqu3Xwivm9s9oK81gZQIxXXPjutjyMHxYy0E0s//+
         knEw==
X-Gm-Message-State: ABy/qLYA+3XvqImoOynMFX1HJzNsu6tP0Fw0Wgy1e9VN0AFcw3rIjK6I
        wqhXUJ5eeH0S2nI9XNGPvdoePg==
X-Google-Smtp-Source: APBJJlHuqlDegBijDnUs0fV12jGszcpfU+t1gDU97/q7LSp4HP8yLabBB+6uJmrtZfykKzX4uMVLMw==
X-Received: by 2002:a1c:4c1a:0:b0:3fc:80a:9948 with SMTP id z26-20020a1c4c1a000000b003fc080a9948mr767283wmf.19.1690357993248;
        Wed, 26 Jul 2023 00:53:13 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c260e00b003fbca942499sm1264346wma.14.2023.07.26.00.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:53:12 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v4 07/11] mtd: spi-nor: spansion: add octal DTR support in RD_ANY_REG_OP
Date:   Wed, 26 Jul 2023 10:52:53 +0300
Message-Id: <20230726075257.12985-8-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726075257.12985-1-tudor.ambarus@linaro.org>
References: <20230726075257.12985-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173; i=tudor.ambarus@linaro.org; h=from:subject; bh=+Z4bxTGyJ9/9zDwMM8hBMtji+B4a+ORn3JZ7mTF+ybY=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkwNDYGHy/s6o006qFtWZQ3anN1qewblLvDmIB3 scXS18pCACJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZMDQ2AAKCRBLVU9HpY0U 6TWfB/9+5mfv0gOBgUZej7KRxVVtTF0Ls2oliPm9WOBhfe1lEk3zgrtBubIoDbS6zZbhof3gLKf xRCCopSCMllajAXkrKpjHJaieEAP/V6cyndfDmBQDTduen+TPQ5uBJVZ3cXIvH7IE5EhNN41BYq Ad8tF+zawYIicKhuL0ZXsNYASZY0OuSTBuEqatYmyvhqqkRFKMQ8TUK2kXbcZdV+A6CMaSHSsPn Hl9k4cEdF6fnjVn7DARZLc35vf9+J8bmj39cY55Ow2yGhVcDFEKe8w31lznDcv6NDKhSHfTNTOZ GuViUy7bNO3W7ZMFSrVKdRKRq7XY9c2lqVDdtG1JwwxnGvom
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

S28HS02GT uses RD_ANY_REG_OP to read status of each die. In Octal DTR
mode, RD_ANY_REG_OP needs dummy cycles (same as params->rdsr_dummy) and
data length should be 2.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi-nor/spansion.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index b3a710985f84..d7aa0a90949a 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -102,11 +102,17 @@ static void spansion_nor_clear_sr(struct spi_nor *nor)
 
 static int cypress_nor_sr_ready_and_clear_reg(struct spi_nor *nor, u64 addr)
 {
+	struct spi_nor_flash_parameter *params = nor->params;
 	struct spi_mem_op op =
-		CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes, addr,
+		CYPRESS_NOR_RD_ANY_REG_OP(params->addr_mode_nbytes, addr,
 					  0, nor->bouncebuf);
 	int ret;
 
+	if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
+		op.dummy.nbytes = params->rdsr_dummy;
+		op.data.nbytes = 2;
+	}
+
 	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
 	if (ret)
 		return ret;
-- 
2.34.1

