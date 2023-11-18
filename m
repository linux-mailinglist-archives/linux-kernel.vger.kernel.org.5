Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D9C7EFE85
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 09:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjKRIcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 03:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKRIcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 03:32:20 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6701A1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:32:17 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5b8f68ba4e5so2037122a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700296336; x=1700901136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRANfzk8DzwIUFYJFYbkxOxGetsmi0eUJR18Xl/qRK4=;
        b=SyhrnZIbqX+Lee2kLPbknW2bT5HoFmp4/5d31bW4gQf9yamDiuMQ8TrvJQoa2pGLSw
         6iYE6YPjLkIiBoZU9IfdVCVQYlARC3+nSDPqsvyYbGDzTMJ3ykEtZDGYJ9GzQx0NPkno
         nZgHjf/Xuc0pdJAgu8HrR1xNmPHaT3iMIoh1s8hKkrtRTsyT6A7LEpRHyLEP/Gm5E8cK
         qUoXMQf3wXnokhXdpE99ZlSZDdCfS/P3E4EZOg9CNsvpe1wXbSrHT527v19A4Of6T/Gf
         2oK0Kzg4+9Be8qQm86FNLrA9Vtj54D2LCLS5chbia2kk5e11n9A/kLIDnnxt86GRlQMh
         w88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700296336; x=1700901136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRANfzk8DzwIUFYJFYbkxOxGetsmi0eUJR18Xl/qRK4=;
        b=f+Xt0MnkKRdE0LOzZG+9msu1KeS+qS/iGlbIND14H0YfEdNzby8uz6J1cffL4XOmw4
         PYSKKDhsk/WylWlbd6Yg8ELfNeETkwRqCDBZd7IQoGZqrUlp8dOsvSxbKwMjkBnd2eWD
         WsHVUprTpJF+C+w4Lxe48n1CBa4c6zSFQU2HSlmBsM49qrmwFH+88A3opGc9P/VwJM8C
         F3lCZrgBn3mXnVWZjBvBnOwBogEq8xMLDGbQV0fu0/++HnISSjAjkHUFM66zBBogeJ1V
         nW+6k/riW7aSJ8aqfAOq4KyQVmGXy3DX+nnQVom0c1cjQpNKAUmcI4lSr66/hC1Kozzq
         eKDQ==
X-Gm-Message-State: AOJu0Yxsq7HnNSDwm1i7PAqgRR8BWelAuW21H6kkecZlRwLF+53SX+26
        YQNez/R+HvyitESOPf1XTF0=
X-Google-Smtp-Source: AGHT+IE13xiSJX75T0VlBR4pVfBBh7BsR12krg4aaLio2bGeoPLCw/utRUbdBwIeF12lBtHoaYWxFg==
X-Received: by 2002:a17:902:d304:b0:1c9:b207:d412 with SMTP id b4-20020a170902d30400b001c9b207d412mr2112867plc.37.1700296336499;
        Sat, 18 Nov 2023 00:32:16 -0800 (PST)
Received: from eagle-5590.. ([103.137.12.142])
        by smtp.gmail.com with ESMTPSA id c8-20020a170902d48800b001ce5b6de75esm2532059plg.160.2023.11.18.00.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 00:32:16 -0800 (PST)
From:   Ronald Monthero <debug.penguin32@gmail.com>
To:     miquel.raynal@bootlin.com, andriy.shevchenko@linux.intel.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        martin.blumenstingl@googlemail.com, paul@crapouillou.net,
        robh@kernel.org, u.kleine-koenig@pengutronix.de,
        debug.penguin32@gmail.com, AVKrasnov@sberdevices.ru,
        r.czerwinski@pengutronix.de, jaimeliao.tw@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Poonam Aggrwal <poonam.aggrwal@freescale.com>,
        Dipen Dudhat <Dipen.Dudhat@freescale.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>, Liu Shuo <b35362@freescale.com>
Subject: [PATCH v4] mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand controller response
Date:   Sat, 18 Nov 2023 18:31:51 +1000
Message-Id: <20231118083156.776887-1-debug.penguin32@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114091302.1f865d66@xps-13>
References: <20231114091302.1f865d66@xps-13>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under heavy load it is likely that the controller is done
with its own task but the thread unlocking the wait is not
scheduled in time. Increasing IFC_TIMEOUT_MSECS allows the
controller to respond within allowable timeslice of 1 sec.

fsl,ifc-nand 7e800000.nand: Controller is not responding

[<804b2047>] (nand_get_device) from [<804b5335>] (nand_write_oob+0x1b/0x4a)
[<804b5335>] (nand_write_oob) from [<804a3585>] (mtd_write+0x41/0x5c)
[<804a3585>] (mtd_write) from [<804c1d47>] (ubi_io_write+0x17f/0x22c)
[<804c1d47>] (ubi_io_write) from [<804c047b>] (ubi_eba_write_leb+0x5b/0x1d0)

Fixes: 82771882d960 ("NAND Machine support for Integrated Flash Controller")
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
---
 drivers/mtd/nand/raw/fsl_ifc_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 20bb1e0cb5eb..f0e2318ce088 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -21,7 +21,7 @@
 
 #define ERR_BYTE		0xFF /* Value returned for read
 					bytes when read failed	*/
-#define IFC_TIMEOUT_MSECS	500  /* Maximum number of mSecs to wait
+#define IFC_TIMEOUT_MSECS	1000 /* Maximum timeout to wait
 					for IFC NAND Machine	*/
 
 struct fsl_ifc_ctrl;
-- 
2.34.1

