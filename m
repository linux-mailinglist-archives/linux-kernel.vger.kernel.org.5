Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0367E52C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbjKHJnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHJnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:43:09 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB241B3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:43:07 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50930f126b1so8285124e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 01:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699436585; x=1700041385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NNgNeA+u/JG3dEDGHsCnM23bBRNPsNNIJ7v/48PUAqU=;
        b=mlE9QGxHFDtULtwk54RiBtHh6Y1ns9ycwMZcZ3eCX9k0SZT9Ix9/E1MHXVKct71ZLp
         0i79tVEZy5IThdqtLAc5KwdKWAp25d2LkhssF+a3KP8rMss6sR4Vey9eP9lxhmooFEnh
         qWtCZPqE4cpLCt7QHqabZhE8CiguuVCCTPkYVL26UQHT4X1uS1h3JTtaGE6XfrQq4/fj
         Z7ctsOZtsZIuodmtyPdGOXDzGLG47NzVyMeD2jYZaVLvRfJb9J7gAYgggPyWvAgwMMjf
         mu7in1czcDVJUv9kgqI3OEm+qBSnWBPObPcMSMjOV2BfTqCcdDOvRDZ/waV5H/LaI1Bi
         F+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699436585; x=1700041385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNgNeA+u/JG3dEDGHsCnM23bBRNPsNNIJ7v/48PUAqU=;
        b=P4b1maUrCmPYISPb3uyHStrLNrCBUpYeKqzFQkUi7V9L1muDfwS1StqC60xmezzTdy
         04DuuuJVQtakHyjOQjz4uYKdADn80ID+9Cns/i/mdeEsm/CtMnkr+DIszhYHPQ7lPyuf
         2WaBZDOJdMLnpiKNPDtTQS8Yj1cPbnvCRFsJQ9A1AK5eJe5gciu6ikIpwvGrIXbwup+n
         ufS/ImqNK7MWIjU8BE4s+xlLDNEdGtRjO9wx9VVxXxdow9DRMQxZvUtIbibFSGiMeW67
         Kf5Vn4wE5B2smV6EsX1Xj04igJ5T7ch5BFeIfPOtc6ErbDXA4FOhH/fuFnu9rfMwqrxb
         Y/lw==
X-Gm-Message-State: AOJu0YwQHWZVhRa5PWgZAkoaVCzynWNi25hCwMg+nQwrjb8csdElpZ0J
        MffKaElkeoe/l0DvPpPeFck=
X-Google-Smtp-Source: AGHT+IFRUyOnJMY5kv/BmZ5a7xXVG9PzwlcBzcVJUddNpWTxLnFR2m9649vH9tJ19JapgSjvwUH32g==
X-Received: by 2002:ac2:5edb:0:b0:4f8:77db:1d9e with SMTP id d27-20020ac25edb000000b004f877db1d9emr823229lfq.12.1699436585110;
        Wed, 08 Nov 2023 01:43:05 -0800 (PST)
Received: from localhost ([195.13.248.78])
        by smtp.gmail.com with ESMTPSA id u3-20020a05651206c300b00501c51ab085sm622510lff.60.2023.11.08.01.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 01:43:04 -0800 (PST)
Sender: AceLan Kao <acelan@gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] spi: Replace -ENOTSUPP with -EOPNOTSUPP in op checking
Date:   Wed,  8 Nov 2023 17:43:02 +0800
Message-Id: <20231108094303.46303-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>

No functional changes are introduced by this patch; it's a code cleanup
to use the correct error code.

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

---
v5. distinguish -EOPNOTSUPP from -ENOTSUPP
---
 drivers/mtd/nand/spi/core.c | 2 +-
 drivers/spi/atmel-quadspi.c | 2 +-
 drivers/spi/spi-ath79.c     | 2 +-
 drivers/spi/spi-bcm-qspi.c  | 2 +-
 drivers/spi/spi-mem.c       | 6 +++---
 drivers/spi/spi-npcm-fiu.c  | 2 +-
 drivers/spi/spi-ti-qspi.c   | 4 ++--
 drivers/spi/spi-wpcm-fiu.c  | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 393ff37f0d23..d1df5cd401cf 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -973,7 +973,7 @@ static int spinand_manufacturer_match(struct spinand_device *spinand,
 		spinand->manufacturer = manufacturer;
 		return 0;
 	}
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static int spinand_id_detect(struct spinand_device *spinand)
diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 3d1252566134..370c4d1572ed 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -272,7 +272,7 @@ static int atmel_qspi_find_mode(const struct spi_mem_op *op)
 		if (atmel_qspi_is_compatible(op, &atmel_qspi_modes[i]))
 			return i;
 
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static bool atmel_qspi_supports_op(struct spi_mem *mem,
diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index c9f1d1e1dcf7..b7ada981464a 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -146,7 +146,7 @@ static int ath79_exec_mem_op(struct spi_mem *mem,
 	/* Only use for fast-read op. */
 	if (op->cmd.opcode != 0x0b || op->data.dir != SPI_MEM_DATA_IN ||
 	    op->addr.nbytes != 3 || op->dummy.nbytes != 1)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	/* disable GPIO mode */
 	ath79_spi_wr(sp, AR71XX_SPI_REG_FS, 0);
diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index ef08fcac2f6d..d96222e6d7d2 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1199,7 +1199,7 @@ static int bcm_qspi_exec_mem_op(struct spi_mem *mem,
 
 	if (!op->data.nbytes || !op->addr.nbytes || op->addr.nbytes > 4 ||
 	    op->data.dir != SPI_MEM_DATA_IN)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	buf = op->data.buf.in;
 	addr = op->addr.val;
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index edd7430d4c05..2dc8ceb85374 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -323,7 +323,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		return ret;
 
 	if (!spi_mem_internal_supports_op(mem, op))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (ctlr->mem_ops && ctlr->mem_ops->exec_op && !spi_get_csgpiod(mem->spi, 0)) {
 		ret = spi_mem_access_start(mem);
@@ -339,7 +339,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		 * read path) and expect the core to use the regular SPI
 		 * interface in other cases.
 		 */
-		if (!ret || ret != -ENOTSUPP)
+		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP)
 			return ret;
 	}
 
@@ -559,7 +559,7 @@ spi_mem_dirmap_create(struct spi_mem *mem,
 	if (ret) {
 		desc->nodirmap = true;
 		if (!spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
-			ret = -ENOTSUPP;
+			ret = -EOPNOTSUPP;
 		else
 			ret = 0;
 	}
diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index 03db9f016a11..f3bb8bbc192f 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -556,7 +556,7 @@ static int npcm_fiu_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		op->data.nbytes);
 
 	if (fiu->spix_mode || op->addr.nbytes > 4)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (fiu->clkrate != chip->clkrate) {
 		ret = clk_set_rate(fiu->clk, chip->clkrate);
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 4c81516b67db..0877dc5058a1 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -613,12 +613,12 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 	/* Only optimize read path. */
 	if (!op->data.nbytes || op->data.dir != SPI_MEM_DATA_IN ||
 	    !op->addr.nbytes || op->addr.nbytes > 4)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	/* Address exceeds MMIO window size, fall back to regular mode. */
 	from = op->addr.val;
 	if (from + op->data.nbytes > qspi->mmap_size)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	mutex_lock(&qspi->list_lock);
 
diff --git a/drivers/spi/spi-wpcm-fiu.c b/drivers/spi/spi-wpcm-fiu.c
index 852ffe013d32..d76f7b5a9b97 100644
--- a/drivers/spi/spi-wpcm-fiu.c
+++ b/drivers/spi/spi-wpcm-fiu.c
@@ -361,7 +361,7 @@ static int wpcm_fiu_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	wpcm_fiu_stall_host(fiu, false);
 
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static int wpcm_fiu_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
-- 
2.34.1

