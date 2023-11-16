Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EAF7ED9B4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344514AbjKPCns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 21:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344386AbjKPCnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:43:45 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A92A199
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:43:42 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5be30d543c4so248626a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700102621; x=1700707421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6I6p0aeJNi1NXX592dY0KZOyrxrobvZe6S5ERdhyfrw=;
        b=m7bwxtD0lhcOGt0CIr0eT1ZOJhpU1kjc/YNn6q6wEWKX+sdXMMH1t/0NbGGREHHJ0F
         efg2xEv6HMVkbG6Jh1soxNBlG5B5e+Y0aqzfdJBYHXmbwiU5QNQHRPFeiACr3tmDOtK/
         qCHGVk9/lLzmB8s5zmqoZ4VB6dmTcWgKkq762oODJpxH0xoDKcO66JTp79AU30GMVSzi
         9MkbObCkzzrizm/6Tw16UiO7M+QafvSyHuBho5G4jyY5KJcp+kf4lqnFqeHhtyxkJncb
         J0+azfPJc5cMwEBkT+Lko43vnA9RKrXdkTXFPtt6IH2F4CjxlQ/eicQuIAeCSMQASNCd
         deEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700102621; x=1700707421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6I6p0aeJNi1NXX592dY0KZOyrxrobvZe6S5ERdhyfrw=;
        b=kyEQl04rKj75NYk7BknAECnrUN8EY9gjWNYkDqHPwJ1IpI70vSR7Mjavdw5xxz83In
         U3GOxcw7MUN0R0nQkcYOeb9TCFEQ2JM1dWtw0PSarqoPzmoHR31eIZiIVjiLGLpzqdkr
         YY+fxiUq8F/+c8r9Smm8YiVzfr+KdoW9pKqRACploO2LKP+xKw2OgqBqpaeuZD9ZLlKk
         YefbjnKyg4n7XAgg+h9VTHFF5SYXYOXlUkY782dj1B2IWCObXIJfSCq24+myrMymoKhe
         qshp8z7PQsq7xOS+b9jFF4TxUUvKAszPt+Ymj5xI47qV1izNRU8lzizPUQQTqo+2sX9x
         jakg==
X-Gm-Message-State: AOJu0YwCnSnc4GdnCrqrYN7YhPJVlw2/BWu66BwmuxEZbeq1/nMqRtUP
        OyfVeZcGvp4dLvfpcrM31qM=
X-Google-Smtp-Source: AGHT+IEFg4/OzKLRaySUNn+N/jtE89IKSY9slt6MPiohinEJsTP7yHkFiCMu465EvDF0YFnhoGx6oQ==
X-Received: by 2002:a05:6a20:6a06:b0:187:8eca:8dc6 with SMTP id p6-20020a056a206a0600b001878eca8dc6mr2412789pzk.34.1700102621396;
        Wed, 15 Nov 2023 18:43:41 -0800 (PST)
Received: from localhost (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id x10-20020a17090ab00a00b002801ca4fad2sm507930pjq.10.2023.11.15.18.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:43:40 -0800 (PST)
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
        Mark Brown <broonie@kernel.org>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mario Kicherer <dev@kicherer.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] spi: Replace -ENOTSUPP with -EOPNOTSUPP in op checking
Date:   Thu, 16 Nov 2023 10:43:37 +0800
Message-Id: <20231116024338.337304-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>

The purpose of this patch is to distinguish the "operation not support"
error from the generic "not support", so that drivers could better
handle different errors.

No functional changes are introduced by this patch; it's a code cleanup
to use the correct error code and it affects only "SPI MEM" drivers and
the core parts.

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

---
v5. distinguish -EOPNOTSUPP from -ENOTSUPP
v6. a. spi_nor_set_4byte_addr_mode() should check -EOPNOTSUPP, all
       callbacks of set_4byte_addr_mode() will eventually return
       -EOPNOTSUPP if the checking failed.
    b. Update comment to describe the reason for the patch and the
       affected parts.
    c. Update the kernel-doc of exec_op() in struct spi_controller_mem_ops
---
 drivers/mtd/nand/spi/core.c | 2 +-
 drivers/mtd/spi-nor/core.c  | 2 +-
 drivers/spi/atmel-quadspi.c | 2 +-
 drivers/spi/spi-ath79.c     | 2 +-
 drivers/spi/spi-bcm-qspi.c  | 2 +-
 drivers/spi/spi-mem.c       | 6 +++---
 drivers/spi/spi-npcm-fiu.c  | 2 +-
 drivers/spi/spi-ti-qspi.c   | 4 ++--
 drivers/spi/spi-wpcm-fiu.c  | 2 +-
 include/linux/spi/spi-mem.h | 2 ++
 10 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 849ccfedbc72..e0b6715e5dfe 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -974,7 +974,7 @@ static int spinand_manufacturer_match(struct spinand_device *spinand,
 		spinand->manufacturer = manufacturer;
 		return 0;
 	}
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static int spinand_id_detect(struct spinand_device *spinand)
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1c443fe568cf..87cb2047df80 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3146,7 +3146,7 @@ int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 	int ret;
 
 	ret = params->set_4byte_addr_mode(nor, enable);
-	if (ret && ret != -ENOTSUPP)
+	if (ret && ret != -EOPNOTSUPP)
 		return ret;
 
 	if (enable) {
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
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 6b0a7dc48a4b..f866d5c8ed32 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -233,6 +233,8 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  *		    limitations)
  * @supports_op: check if an operation is supported by the controller
  * @exec_op: execute a SPI memory operation
+ *           not all driver provides supports_op(), so it can return -EOPNOTSUPP
+ *           if the op is not supported by the driver/controller
  * @get_name: get a custom name for the SPI mem device from the controller.
  *	      This might be needed if the controller driver has been ported
  *	      to use the SPI mem layer and a custom name is used to keep
-- 
2.34.1

