Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBBF7A8CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjITT3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjITT2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:28:54 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD9E1A5;
        Wed, 20 Sep 2023 12:28:45 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-500cfb168c6so371944e87.2;
        Wed, 20 Sep 2023 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695238123; x=1695842923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BUlFc32U67LJr2U7BzHv473MxaTEfZQ+YLInYVLVj8=;
        b=G4j6I0PEtmkd/FLWjBLSJKg6Uuxtf/S9Losx6B2SdamqsmGTzr1tHFoDUxfyUY3cJm
         me3PddC58J1/UI8FxHS6DPa0wnTSveOjva4W9VW8mbGkR+4ysct1U+Ze1k0IZiImWlyU
         dh5kWVx4cPqZZ+dv1AW11+wpw279/INJc0kDxKPhLE2CjnfmljWglf6MNwBirgxg96fU
         BaJtfaBQ7ECFRWUwTrvgYejOk6QPWgUpcsvwG8xSCx6JKrdOi0kLbMMUYaapny1G/R7A
         oX1WtiqNvyxCB5wdcm69KztPCK4adr4qaGuHqp4sNgM0ems85pBslctZXLh+1dHQ0qhF
         qwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238123; x=1695842923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BUlFc32U67LJr2U7BzHv473MxaTEfZQ+YLInYVLVj8=;
        b=a2pzXqTAVm5psBTrPVjuoVjH/Tg8R5kUDMdRUAMnlhUnMq0EjJML8l8Jp7eNlnDoMV
         bRw7LLHAuFxkqgrQqRUMkHqHgZG0bV+ODHYLwJJ/a8GpXH6hle6MjaprLDAi3sc8Tv/C
         yxKng5kjkHTgB7984FpZLaY9mOiZQlLOgmwovpCumNyXO7poSDAz/9mt5PzSFpdmymMX
         awdpMemLpGmdPWOMdQ5+0w2jPmXrM4jnSsGt3vx0tErqTAotEBDKe8IJTYUtIsnlqfkQ
         9uZxRJjo2O80KDSX1bDV5RERVoYgfLMwypkcAaGGngf4CI5XjIO9LPbsS6H7mUZSLLfF
         wclw==
X-Gm-Message-State: AOJu0YzfpBduH5HTxh8DSJ+/v7+kreOD31tDpHhbmx6vgPQRlB5D+Kc9
        Q5DD/ISsONDH7/2HbuGeYR8xtcnC0Xg=
X-Google-Smtp-Source: AGHT+IFYNvADX+pg8J040J7aG80SLXnN5ERc9qA5f7ctLC5xfL2gP5i7P26Ct9T5OB35Yi6y+G1VvQ==
X-Received: by 2002:a19:384b:0:b0:4fd:c715:5667 with SMTP id d11-20020a19384b000000b004fdc7155667mr2480908lfj.20.1695238123500;
        Wed, 20 Sep 2023 12:28:43 -0700 (PDT)
Received: from localhost ([178.176.82.53])
        by smtp.gmail.com with ESMTPSA id d5-20020ac241c5000000b004fe28e3841bsm2793757lfi.267.2023.09.20.12.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:28:42 -0700 (PDT)
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
Subject: [PATCH v4 07/18] EDAC/synopsys: Parse ADDRMAP[7-8] CSRs for (LP)DDR4 only
Date:   Wed, 20 Sep 2023 22:26:52 +0300
Message-ID: <20230920192806.29960-8-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920192806.29960-1-fancer.lancer@gmail.com>
References: <20230920192806.29960-1-fancer.lancer@gmail.com>
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

These CSRs contain the SDRAM Bank Groups and row[16]/row[17] bits mapping,
which are applicable for the DDR4 and LPDDR4 memory chips only. For the
rest of the memories the ADDRMAP[7-8] registers are unused by the
controller and are zeros by default. The zero values will be perceived by
the HIF/SDRAM mapping detection procedure as normal bit positions, which
is wrong. So in order to prevent that parse these registers only if they
are applicable for the detected DDR protocol.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index b77bc84c0bb0..5a06038aedcb 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1008,12 +1008,15 @@ static void snps_setup_row_address_map(struct snps_edac_priv *priv, u32 *addrmap
 	priv->row_shift[15] = (((addrmap[6] >> 24) & ROW_MAX_VAL_MASK) ==
 				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 24) &
 				ROW_MAX_VAL_MASK) + ROW_B15_BASE);
-	priv->row_shift[16] = ((addrmap[7] & ROW_MAX_VAL_MASK) ==
-				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[7] &
-				ROW_MAX_VAL_MASK) + ROW_B16_BASE);
-	priv->row_shift[17] = (((addrmap[7] >> 8) & ROW_MAX_VAL_MASK) ==
-				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[7] >> 8) &
-				ROW_MAX_VAL_MASK) + ROW_B17_BASE);
+
+	if (priv->info.sdram_mode == MEM_DDR4 || priv->info.sdram_mode == MEM_LPDDR4) {
+		priv->row_shift[16] = ((addrmap[7] & ROW_MAX_VAL_MASK) ==
+					ROW_MAX_VAL_MASK) ? 0 : ((addrmap[7] &
+					ROW_MAX_VAL_MASK) + ROW_B16_BASE);
+		priv->row_shift[17] = (((addrmap[7] >> 8) & ROW_MAX_VAL_MASK) ==
+					ROW_MAX_VAL_MASK) ? 0 : (((addrmap[7] >> 8) &
+					ROW_MAX_VAL_MASK) + ROW_B17_BASE);
+	}
 }
 
 static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addrmap)
@@ -1129,6 +1132,10 @@ static void snps_setup_bank_address_map(struct snps_edac_priv *priv, u32 *addrma
 
 static void snps_setup_bg_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 {
+	/* Bank group signals are available on the DDR4 memory only */
+	if (priv->info.sdram_mode != MEM_DDR4)
+		return;
+
 	priv->bankgrp_shift[0] = (addrmap[8] &
 				BANKGRP_MAX_VAL_MASK) + BANKGRP_B0_BASE;
 	priv->bankgrp_shift[1] = (((addrmap[8] >> 8) & BANKGRP_MAX_VAL_MASK) ==
-- 
2.41.0

