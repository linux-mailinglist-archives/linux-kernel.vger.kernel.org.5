Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14307D48D3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjJXHnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjJXHnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:43:37 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3F3B7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:43:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9d3a21f7aso34843655ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698133415; x=1698738215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp4zribyxkaMmeYlAPKMl/TvSUWz72GegqaBX3+CYe8=;
        b=OYZTDx11F4e4ryGF6J2TTPFEjhWjE1D7kPXyXbI3Ro5FGpHqtvq6mJPx9y5bt6s6eM
         FxGhmNFY9zUZcNY3/PlwnAFI+zV1pfvuT8Ag1oW5O+UFQhdCNE02Nz5sPFRnbKhi2JfN
         6p9S1jw3TFbE5q4r7Dpxs51/S8tkV7uHYRkHNE9sgb7A4yos3R0HAj9MvHU9driaAReQ
         2GKQQdEvF+nd4WH2s92VMUlcSl2buxQPf+eOhAZ4pqirnSntdPnOf6q/AAKvUEQW4wY8
         g1pFUdNDr/6oMbxIR8x/Xnw1/deLtQv+4jNeyGDqhRgTGMNYsHS+EToc+L0vFrggUCa9
         +dtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698133415; x=1698738215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dp4zribyxkaMmeYlAPKMl/TvSUWz72GegqaBX3+CYe8=;
        b=RD6xwTFS9MK/vZ5N+AqUeUf+flAJoSWalKHydQ+XKrRFRzobX0sItNlOjeXh+PPPBt
         4pgpWK4lzWZq8Hay4hn546YgrJK/886IbBHfM0Z873kxjSfLRamoiLCdmOKo5UTQdDCt
         p7CL3oqke83Tii43MPyxEMKec79kAYF3gW2gOkIc0jTpEqVoUdlZTrRPBuGaTPvK2D8o
         RKCJFkbzZHtzHWFGMiLtKeEUmYqe1wqmem7msCI4GSLoNyT0d16UU9JzzuQx4Bl5Oot+
         TZr1VMhbFaYtie9sYxxw4DI17nf6W/OqupF6TuhfnxoXfH3X2tFIim2rGjMXBCcOyYdB
         IVmQ==
X-Gm-Message-State: AOJu0YxI5k15a4u16CnsHe7aUcgjbiUj1GYc9Y8HE/hbtJDSx4UB0gc7
        EfRgtHU37BA3vx+FBdyO0Ik=
X-Google-Smtp-Source: AGHT+IETmKMrh83Ma+B4CDqx2Id4sNL93hgxEC8dc2nBxKXN1JyKY8pu9/MBw5gAqcQqL+K9MBY2tw==
X-Received: by 2002:a17:902:c411:b0:1cb:e412:c3fd with SMTP id k17-20020a170902c41100b001cbe412c3fdmr1692265plk.63.1698133415155;
        Tue, 24 Oct 2023 00:43:35 -0700 (PDT)
Received: from localhost (220-135-95-34.hinet-ip.hinet.net. [220.135.95.34])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f7c700b001b8a3e2c241sm7032169plw.14.2023.10.24.00.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 00:43:34 -0700 (PDT)
Sender: AceLan Kao <acelan@gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: spi-nor: Improve reporting for software reset failures
Date:   Tue, 24 Oct 2023 15:43:32 +0800
Message-Id: <20231024074332.462741-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>

When the software reset command isn't supported, we now report it as an
informational message(dev_info) instead of a warning(dev_warn). 
This adjustment helps avoid unnecessary alarm and confusion regarding
software reset capabilities.

v2. only lower the priority for the not supported failure

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/mtd/spi-nor/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1b0c6770c14e..76920dbc568b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3252,7 +3252,10 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
 
 	ret = spi_mem_exec_op(nor->spimem, &op);
 	if (ret) {
-		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
+		if (ret == -ENOTSUPP)
+			dev_info(nor->dev, "Software reset enable command doesn't support: %d\n", ret);
+		else
+			dev_warn(nor->dev, "Software reset failed: %d\n", ret);
 		return;
 	}
 
@@ -3262,7 +3265,10 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
 
 	ret = spi_mem_exec_op(nor->spimem, &op);
 	if (ret) {
-		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
+		if (ret == -ENOTSUPP)
+			dev_info(nor->dev, "Software reset command doesn't support: %d\n", ret);
+		else
+			dev_warn(nor->dev, "Software reset failed: %d\n", ret);
 		return;
 	}
 
-- 
2.34.1

