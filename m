Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4209A7FCF50
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344635AbjK2GnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjK2GnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:43:09 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F220010D1;
        Tue, 28 Nov 2023 22:43:14 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d21b9a5808so8503287b3.2;
        Tue, 28 Nov 2023 22:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701240194; x=1701844994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=leTlicg8iH+9lzMnCMbG39z91iwwZaX//lWfRGoWh9k=;
        b=nJ6gYPJZ/l9pB74pjYgtKHvtAcJ/rCIybIIf3PQGQfvZ51CfLpp9rQW1ZbgPck9iqx
         1TMmImcLcEHAqym9jLEYFcf7NqtUpOkHw8C7KzFeS0SKgGSSw0DJyl6lly5xbssraF6Z
         Qi+5qz7bSxi2mnkuS+nrlKCFRaiRBC+bmi+TnrsQmDe0p8QRR3Exo5HKGpE9C/23PPm9
         2Q3m+eqxhuQUzIxBQR4WehL0g4/1hfWOQ0Q0dUbieDl80f+nyX1c1ZVeJSTjknIDrGyQ
         I6uydoodp1+jVID5YUK4NDlciwfLwA2j+tlIF7aC1KgfeQ63mxMJHWmDh1TVYClCfgxD
         HZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701240194; x=1701844994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leTlicg8iH+9lzMnCMbG39z91iwwZaX//lWfRGoWh9k=;
        b=Bei1lmB/h5eKHYyXKPh8y63yBgCg9jCZtKAuy4lAatU1Qf4/Y8f/+POjgOnVRGk0i+
         DGa/CbVtCEKmGi54PnIyJlyhoYG15Koiwn6Y3pu+LVju7tdRTJsKfz8hCy3CF2NKAEOZ
         UIqc+E9cPJMDQ4AyjH1OK/1s2D5gjL3UzKeN1ovK7E01Z/owl2XitBpEHiIWxJnk4Yum
         Ml+BSarHKQRmbN4wncMxsz+K44cAzzB4c2kheaXMke/vsQgsxEi9BDc7hXyc/Xaty5YL
         9rkwFbFyTHNT9Ib+DIKM5tb/e+v2RqHnZDZugkRSmvFLD/59J245g/VGwa+KeZuJNm/v
         9NJQ==
X-Gm-Message-State: AOJu0YxyHi9q4mPOyMIujD/ZA4E3eDTehT4BS6SFz6H2ACDZF2LynRHy
        EXiMRLJsWrWXWNIB9wNTres=
X-Google-Smtp-Source: AGHT+IHX4v4mdEo7sPnEoaB6cWCEFm+xofDAMLk3itbzEpK5Voo03kgeIY4Od0p0FCXbLJRjZ+QcTw==
X-Received: by 2002:a81:b614:0:b0:5cd:f107:9703 with SMTP id u20-20020a81b614000000b005cdf1079703mr17310862ywh.18.1701240194035;
        Tue, 28 Nov 2023 22:43:14 -0800 (PST)
Received: from localhost (220-135-95-34.hinet-ip.hinet.net. [220.135.95.34])
        by smtp.gmail.com with ESMTPSA id by6-20020a056a02058600b005c216d903bdsm9158857pgb.89.2023.11.28.22.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 22:43:13 -0800 (PST)
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
        Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/2] spi: Unify error codes by replacing -ENOTSUPP with -EOPNOTSUPP
Date:   Wed, 29 Nov 2023 14:43:10 +0800
Message-Id: <20231129064311.272422-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>

This commit updates the SPI subsystem, particularly affecting "SPI MEM"
drivers and core parts, by replacing the -ENOTSUPP error code with
-EOPNOTSUPP.

The key motivations for this change are as follows:
1. The spi-nor driver currently uses EOPNOTSUPP, whereas calls to spi-mem
might return ENOTSUPP. This update aims to unify the error reporting
within the SPI subsystem for clarity and consistency.

2. The use of ENOTSUPP has been flagged by checkpatch as inappropriate,
mainly being reserved for NFS-related errors. To align with kernel coding
standards and recommendations, this change is being made.

3. By using EOPNOTSUPP, we provide more specific context to the error,
indicating that a particular operation is not supported. This helps
differentiate from the more generic ENOTSUPP error, allowing drivers to
better handle and respond to different error scenarios.

Risks and Considerations:
While this change is primarily intended as a code cleanup and error code
unification, there is a minor risk of breaking user-space applications
that rely on specific return codes for unsupported operations. However,
this risk is considered low, as such use-cases are unlikely to be common
or critical. Nevertheless, developers and users should be aware of this
change, especially if they have scripts or tools that specifically handle
SPI error codes.

This commit does not introduce any functional changes to the SPI subsystem
or the affected drivers.

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

---
v5. distinguish -EOPNOTSUPP from -ENOTSUPP
v6. a. spi_nor_set_4byte_addr_mode() should check -EOPNOTSUPP, all
       callbacks of set_4byte_addr_mode() will eventually return
       -EOPNOTSUPP if the checking failed.
    b. Update comment to describe the reason for the patch and the
       affected parts.
    c. Update the kernel-doc of exec_op() in struct spi_controller_mem_ops
v7. added comment for the return code changes may affect userspace, and
    the risk after this change
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

