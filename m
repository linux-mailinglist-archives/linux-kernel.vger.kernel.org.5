Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7A47A8D47
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjITT5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjITT5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:57:45 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465A4A9;
        Wed, 20 Sep 2023 12:57:38 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c00c0f11b2so3014661fa.1;
        Wed, 20 Sep 2023 12:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695239856; x=1695844656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dp2D4QZmdlsQyBLWq2sQtKZA/5LWMqfQ8G/Yqqs3zwQ=;
        b=aIqaH4iAoGTsVZ8rBxQKHC1ZPAG6GrSeQC49ZX6tVPs33wUCFsp8dRQ+TjcHbau+L3
         n1MWoJtHujrdiJO68jGQr3ggKKNRT8Yo1DwaLjXIZwm/e0lFhnA+RfCGYK6LPSTbqz8x
         8grDaWOjAR+6jZmReC9QRXvm1h13I625ygmKoXnrypQa2wwCYVzfieiPi+GBbLcrmAjz
         ox1El7qKKSjGqf6tysOKSzXlGTB8GNSRi+fXIkFNUgx2OhMTtaIUFIWckwH1mobTtJgH
         tWIVyOy4XqDpHXJSUZBB9BMiYEa9QaPJgdYKt/8XtE+5zEjUT4FSoYVvuwQm2lLMb2cw
         MYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239856; x=1695844656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dp2D4QZmdlsQyBLWq2sQtKZA/5LWMqfQ8G/Yqqs3zwQ=;
        b=CIzXojZFy1NUNmCn4/xMJ78Q64iTMSLmst3CgtrO3c/LTdMf7r1mCwyaMWYT7bM04z
         2FMRH2cJ5yCj30R1QN7RfPyBosiRSpAT8t2I7QRj99ajW0J9bAJQUYp2thF5zyuuTveO
         DdIDJVSTllpiJvQgFGMFwHcDkgKg5CqgdRzncfE4pxW31O/G4VnZ7+xKu5qLBpwqCzqW
         /Z+BcCPDZJjSYmDdStKECOIiz1bhMp14USD4iA/0EuVMzpODAOrMrgn41fDvR1IvNwZT
         3rRz8Q64HSucx1NaZqWGigeX2S1ZtMjq2vJ0LtWWI/fwc1yy8xHns2jDXjK4xYvI68gk
         BRUw==
X-Gm-Message-State: AOJu0YxBxvCAityTXw2ckHS+zrf5ZUDwH7gmLuL/BfOLi11mw6TVCEwt
        nRrgZM45Y0ZNGt6pXBSslm8=
X-Google-Smtp-Source: AGHT+IFkjCYXba43Sgzfkts2IbGRIloyX7PWaiJZTCw/clVsATFqphseD4OublnUiq477tgxyf4xrQ==
X-Received: by 2002:a2e:9cd5:0:b0:2b9:dd5d:5d0c with SMTP id g21-20020a2e9cd5000000b002b9dd5d5d0cmr2801973ljj.52.1695239856352;
        Wed, 20 Sep 2023 12:57:36 -0700 (PDT)
Received: from localhost ([85.26.234.143])
        by smtp.gmail.com with ESMTPSA id q4-20020a2eb4a4000000b002c12630e4d3sm245602ljm.127.2023.09.20.12.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:57:35 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/13] EDAC/synopsys: Add multi-ranked memory support
Date:   Wed, 20 Sep 2023 22:56:34 +0300
Message-ID: <20230920195720.32047-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920195720.32047-1-fancer.lancer@gmail.com>
References: <20230920195720.32047-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DW uMCTL2 DDRC supports multi-rank memory attached to the controller. If
so the MSTR.active_ranks field will be set with the populated ranks
bitfield. It is permitted to have one, two or four ranks activated at a
time [1]. Since the driver now supports detecting the number of ranks
use it for accordingly extending the MCI chip-select layer. In case of the ECC errors
the affected rank will be read from the CE/UE address CSRs [2].

Note since the multi-rankness is abstracted out on the EDAC-core layer[0]
level, drop the ranks from out of the total memory size calculation.

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
    Databook, Version 3.91a, October 2020, p.739
[2] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
    Databook, Version 3.91a, October 2020, p.821, p.832

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 9a621b7a256d..001553f3849a 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -23,9 +23,6 @@
 
 #include "edac_module.h"
 
-/* Number of cs_rows needed per memory controller */
-#define SNPS_EDAC_NR_CSROWS		1
-
 /* Number of channels per memory controller */
 #define SNPS_EDAC_NR_CHANS		1
 
@@ -799,7 +796,7 @@ static void snps_handle_error(struct mem_ctl_info *mci, struct snps_ecc_status *
 
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, p->ce_cnt,
 				     PHYS_PFN(sys), offset_in_page(sys),
-				     pinf->syndrome, 0, 0, -1,
+				     pinf->syndrome, pinf->sdram.rank, 0, -1,
 				     priv->message, "");
 	}
 
@@ -816,7 +813,8 @@ static void snps_handle_error(struct mem_ctl_info *mci, struct snps_ecc_status *
 
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, p->ue_cnt,
 				     PHYS_PFN(sys), offset_in_page(sys),
-				     0, 0, 0, -1, priv->message, "");
+				     0, pinf->sdram.rank, 0, -1,
+				     priv->message, "");
 	}
 
 	memset(p, 0, sizeof(*p));
@@ -1416,10 +1414,7 @@ static u64 snps_get_sdram_size(struct snps_edac_priv *priv)
 			size++;
 	}
 
-	for (i = 0; i < DDR_MAX_RANK_WIDTH; i++) {
-		if (map->rank[i] != DDR_ADDRMAP_UNUSED)
-			size++;
-	}
+	/* Skip the ranks since the multi-rankness is determined by layer[0] */
 
 	return 1ULL << (size + priv->info.dq_width);
 }
@@ -1473,7 +1468,7 @@ static struct mem_ctl_info *snps_mc_create(struct snps_edac_priv *priv)
 	struct mem_ctl_info *mci;
 
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = SNPS_EDAC_NR_CSROWS;
+	layers[0].size = priv->info.ranks;
 	layers[0].is_virt_csrow = true;
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
 	layers[1].size = SNPS_EDAC_NR_CHANS;
-- 
2.41.0

