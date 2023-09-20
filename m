Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491437A8C60
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjITTMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjITTMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:12:07 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7186CE8;
        Wed, 20 Sep 2023 12:11:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5041bb9ce51so347088e87.1;
        Wed, 20 Sep 2023 12:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237107; x=1695841907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMN8G1qZfKnydPQkDFQEnX7n5YXp3uc9H+eJkqdtGMI=;
        b=dlyOsB5NOgksdOHxrBOw2PRYdZX/GN0umLhqlOX0e/K1+3XZcNKJdW7dz6DXPj4W+P
         RCTdQ6GENQw7U6OFA4147IDBpMSnUiGqh+92K6wlET8ef6veUX7/+T5FtbWMRcPgWPWt
         JFq34tPTsn9ad4vpMHkbP0zwfcdWZxi4Cdb7mS6OpRr/oR/eLOHv9yFAj9zEJ3kgWPlh
         Yfhvkkcq/c3IWSyzTYi31HyBk/Vlmg0m7esvreDcdP5fM81BzdbpdlktkGdcaWp95Udz
         tkoG/SK8c28LPflXHOOb5i3aUr977tT+QzLOoP+VEirw7t4rsjlLZjI6ePnxkxreeGy4
         H1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237107; x=1695841907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMN8G1qZfKnydPQkDFQEnX7n5YXp3uc9H+eJkqdtGMI=;
        b=TXVnifCGY95+GNqZVM5rxHgxiYyTLk/ARubEBZ3+IPpnbIVGH2AfkJSaG61fkgj7pW
         gFUMkDz0nTUBxEuT01VfVo5aFqP5VDXl904y7zMKxJCJO6HtoK5dIpe7GBrI+gBPdLtV
         eGaL8sjiB24zOakCiWvFizyCAZ8bzf9+L/47vTaJAt0Yao7IVAiR293v4bZqIOjsoag8
         SGq8KhsCyNAWvWkUP+vkfI0vsi4xQ5tdQCS4NhKJzHUgUdP8tkDhUaj+k0P5UfyS+sSj
         pOYy1Poct6GDhWlBKDwamIwucXxjaPZYTUYB6GsnPOdiLI8e02ZznOIDiRlsoR07D/hj
         kM2Q==
X-Gm-Message-State: AOJu0YxFiCRmj0YgIluhmRoD9/a7iFK5y1vn/ODRdPzwscWrqBat9Kgh
        NgY9QckMl8TlVCiw6Pu6LyQ=
X-Google-Smtp-Source: AGHT+IE8dmjGRreISpqYLy/aiP2ZGsfPK1iOWbULA1il3DyYT/WkSwkK5hrPohVW3MI23FuUmTzK8A==
X-Received: by 2002:a05:6512:2387:b0:503:af9:eb1c with SMTP id c7-20020a056512238700b005030af9eb1cmr3826445lfv.27.1695237107326;
        Wed, 20 Sep 2023 12:11:47 -0700 (PDT)
Received: from localhost ([85.140.0.132])
        by smtp.gmail.com with ESMTPSA id h12-20020ac2596c000000b004fe0760354bsm2773950lfp.275.2023.09.20.12.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:11:46 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/20] EDAC/synopsys: Drop struct ecc_error_info.blknr field
Date:   Wed, 20 Sep 2023 22:10:34 +0300
Message-ID: <20230920191059.28395-11-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920191059.28395-1-fancer.lancer@gmail.com>
References: <20230920191059.28395-1-fancer.lancer@gmail.com>
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

Even though the ECC(C|U)ADDR1 CSR description indeed says it's a "Block
number" in the DW uMCTL2 DDRC IP-core databooks, the corresponding
register field is named as ECC(C|U)ADDR1.ecc_(un)corr_col (which means ECC
(un)corrected column) and in the rest of the document it's referred as the
SDRAM address column. Thus use the already available ecc_error_info.col
field to read the column number to and drop the questionable
ecc_error_info.blknr field for good.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 0c6441719215..f2bcc3f79bf2 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -174,7 +174,7 @@
 #define ECC_CEADDR0_RNK_MASK		BIT(24)
 #define ECC_CEADDR1_BNKGRP_MASK		0x3000000
 #define ECC_CEADDR1_BNKNR_MASK		0x70000
-#define ECC_CEADDR1_BLKNR_MASK		0xFFF
+#define ECC_CEADDR1_COL_MASK		0xFFF
 #define ECC_CEADDR1_BNKGRP_SHIFT	24
 #define ECC_CEADDR1_BNKNR_SHIFT		16
 
@@ -272,7 +272,6 @@
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
  * @bankgrpnr:	Bank group number.
- * @blknr:	Block number.
  */
 struct ecc_error_info {
 	u32 row;
@@ -281,7 +280,6 @@ struct ecc_error_info {
 	u32 bitpos;
 	u32 data;
 	u32 bankgrpnr;
-	u32 blknr;
 };
 
 /**
@@ -434,7 +432,7 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 					ECC_CEADDR1_BNKNR_SHIFT;
 	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
 					ECC_CEADDR1_BNKGRP_SHIFT;
-	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ceinfo.col = (regval & ECC_CEADDR1_COL_MASK);
 	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
 	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
 		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
@@ -450,7 +448,7 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 					ECC_CEADDR1_BNKGRP_SHIFT;
 	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
 					ECC_CEADDR1_BNKNR_SHIFT;
-	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ueinfo.col = (regval & ECC_CEADDR1_COL_MASK);
 	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
 out:
 	spin_lock_irqsave(&priv->reglock, flags);
@@ -481,10 +479,9 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ceinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Bank %d BankGroup Number %d Block Number %d Bit Position: %d Data: 0x%08x",
-				 "CE", pinf->row, pinf->bank,
-				 pinf->bankgrpnr, pinf->blknr,
-				 pinf->bitpos, pinf->data);
+				 "DDR ECC error type:%s Row %d Col %d Bank %d BankGroup Number %d Bit Position: %d Data: 0x%08x",
+				 "CE", pinf->row, pinf->col, pinf->bank,
+				 pinf->bankgrpnr, pinf->bitpos, pinf->data);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
 				 "DDR ECC error type:%s Row %d Bank %d Col %d Bit Position: %d Data: 0x%08x",
@@ -501,9 +498,9 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ueinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Bank %d BankGroup Number %d Block Number %d",
-				 "UE", pinf->row, pinf->bank,
-				 pinf->bankgrpnr, pinf->blknr);
+				 "DDR ECC error type :%s Row %d Col %d Bank %d BankGroup Number %d",
+				 "UE", pinf->row, pinf->col, pinf->bank,
+				 pinf->bankgrpnr);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
 				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-- 
2.41.0

