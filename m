Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8397A8CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjITT3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjITT3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:29:25 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E534DE5;
        Wed, 20 Sep 2023 12:29:05 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-501bd6f7d11so387209e87.1;
        Wed, 20 Sep 2023 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695238144; x=1695842944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4SLo29ZsWRxmXYEq5pouZGHA4AJYrYqVFNN0wYQp34=;
        b=dM/61Eo0GXvnTyd1VzZ8dOz+7u2YIHREyMkebKzI03yrsaXZBBQYxwA3w9r/+q4k6Y
         GepmN2adF9r/y9FUejuobvwMQCX1UHbG854FZZfYS7sSLB2/Saf6+q4W9msYR9db/Atw
         HCFUVELMLqilQQs55dhR1evTUxQ51DXqzAmOBs91LTf/ceEtdeJ1iJQGSJeg9e6Ba7zJ
         qMD0HAEXyFkXrttJPXrG3yNGbHyWhwg/A9tUKICFFD5i5e/YOjjvQIhZvvbUEfc1E0bp
         OpODI+y8xZOVAE40gki4kpZpCJeR/OOP4n1t1hFEW12TrMGgSqQZrR4ZkGNRn3NuIguW
         zCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238144; x=1695842944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4SLo29ZsWRxmXYEq5pouZGHA4AJYrYqVFNN0wYQp34=;
        b=rcRrMrgw8+D1GvwGWajBs1BAZ2fSPaGSMcfeeXQCqQXCja92KjxEIzCuaxZEVwC23P
         b7uZKpU3Xyb97qwUfY33FvnWCNr0eIoF4zkAMyrULei/ZsO+q7i54U3u/iwnvgz/jHyL
         tYksl17A2Tws4XAS01imv8c487aseNCguDSzr/k9qc3TIt0IxnuoM9mLwUD9pSZAB+/+
         KdIYYvorW6EGOmjkXFb21ru+Pser0pwaU6tKgsrCt/XTcFc6F4xF8YrEL+V9vZ2H29b1
         N1h0I7guOsAbLml4wjcXuMKfouzqkHxGQAH/PUB5GyywyrVOFSKYh03ZUFCJ9pd88HkP
         96DA==
X-Gm-Message-State: AOJu0YyJH9SLvaMsLCdRy4qWk8uh9KEFbNpqainFJ0b5r29JiXAK1b9c
        4za5VuQCz4eJg8OBUeBPMC0=
X-Google-Smtp-Source: AGHT+IE61sBSRYaEasfvKoNub8Bh9Qbify371yZ1L9/rJ06IVapYKu9pHIJzUaCgHNrlId97sqmRMA==
X-Received: by 2002:ac2:5b1d:0:b0:500:9214:b308 with SMTP id v29-20020ac25b1d000000b005009214b308mr3264451lfn.65.1695238143992;
        Wed, 20 Sep 2023 12:29:03 -0700 (PDT)
Received: from localhost ([85.26.234.143])
        by smtp.gmail.com with ESMTPSA id v10-20020ac2560a000000b00501ce5c2e4asm542921lfd.262.2023.09.20.12.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:29:03 -0700 (PDT)
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
Subject: [PATCH v4 14/18] EDAC/synopsys: Simplify HIF/SDRAM column mapping get procedure
Date:   Wed, 20 Sep 2023 22:26:59 +0300
Message-ID: <20230920192806.29960-15-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920192806.29960-1-fancer.lancer@gmail.com>
References: <20230920192806.29960-1-fancer.lancer@gmail.com>
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

What is currently implemented in the driver by means of the multiple
if-else-if-else statements in fact is described in the hardware reference
manual [1]. It says:
1. All of the column bits shift up 1 bit when only half of the data bus is
in use. (In this case, for instance, you need to look at
ADDRMAP3.addrmap_col_b6 instead to determine the value of column address
bit 7.)
2. All of the column bits shift up 2 bits when only a quarter of the data
bus is in use. (In this case, for instance, you need to look at
ADDRMAP2.addrmap_col_b5 instead to determine the value of column address
bit 7.)
3. In addition to the above, the column bit 10 is reserved for the
auto-precharge command in DDR2/3/4/mDDR. So the column bits must be
further shifted up 1 bit when one of these DDR protocols is enabled.

So taking into account all of the notes above and what the column bit 12
is always reserved, the SDRAM column bits mapping procedure can be
significantly simplified: initially read the mapping as if for the
LPDDR2/3/4 memory with Full DQ-bus utilized; then shift the column bits up
in accordance with the detected DQ-bus width mode. That's it. Simple,
canonical and scalable.

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
    Databook, Version 3.91a, October 2020, p.154

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 83 ++++++++++++------------------------
 1 file changed, 27 insertions(+), 56 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 204d7f1fc7e2..a359018c261c 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -996,8 +996,22 @@ static void snps_get_hif_col_map(struct snps_edac_priv *priv, u32 *addrmap)
 	map->col[9] = map->col[9] == DDR_ADDRMAP_MAX_15 ?
 		      DDR_ADDRMAP_UNUSED : map->col[9] + COL_B9_BASE;
 
+	map->col[10] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[4]);
+	map->col[10] = map->col[10] == DDR_ADDRMAP_MAX_15 ?
+		      DDR_ADDRMAP_UNUSED : map->col[10] + COL_B10_BASE;
+
+	map->col[11] = FIELD_GET(DDR_ADDRMAP_B8_M15, addrmap[4]);
+	map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
+		      DDR_ADDRMAP_UNUSED : map->col[11] + COL_B11_BASE;
+
+	/*
+	 * In case of the non-Full DQ bus mode the lowest columns are
+	 * unmapped and used by the controller to read the full DQ word
+	 * in multiple cycles (col[0] for the Half bus mode, col[0:1] for
+	 * the Quarter bus mode).
+	 */
 	if (priv->info.dq_mode) {
-		for (i = 9; i > priv->info.dq_mode; i--) {
+		for (i = 11 + priv->info.dq_mode; i >= priv->info.dq_mode; i--) {
 			map->col[i] = map->col[i - priv->info.dq_mode];
 			map->col[i - priv->info.dq_mode] = DDR_ADDRMAP_UNUSED;
 		}
@@ -1007,65 +1021,22 @@ static void snps_get_hif_col_map(struct snps_edac_priv *priv, u32 *addrmap)
 	 * Per JEDEC DDR2/3/4/mDDR specification, column address bit 10 is
 	 * reserved for indicating auto-precharge, and hence no source
 	 * address bit can be mapped to col[10].
+	 */
+	if (priv->info.sdram_mode == MEM_LPDDR || priv->info.sdram_mode == MEM_DDR2 ||
+	    priv->info.sdram_mode == MEM_DDR3 || priv->info.sdram_mode == MEM_DDR4) {
+		for (i = 12 + priv->info.dq_mode; i > 10; i--) {
+			map->col[i] = map->col[i - 1];
+			map->col[i - 1] = DDR_ADDRMAP_UNUSED;
+		}
+	}
+
+	/*
 	 * Per JEDEC specification, column address bit 12 is reserved
 	 * for the Burst-chop status, so no source address bit mapping
 	 * for col[12] either.
 	 */
-	if (priv->info.dq_mode == SNPS_DQ_FULL) {
-		if (priv->info.sdram_mode == MEM_LPDDR3) {
-			map->col[10] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[4]);
-			map->col[10] = map->col[10] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[10] + COL_B10_BASE;
-
-			map->col[11] = FIELD_GET(DDR_ADDRMAP_B8_M15, addrmap[4]);
-			map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[11] + COL_B11_BASE;
-		} else {
-			map->col[11] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[4]);
-			map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[11] + COL_B10_BASE;
-
-			map->col[13] = FIELD_GET(DDR_ADDRMAP_B8_M15, addrmap[4]);
-			map->col[13] = map->col[13] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[13] + COL_B11_BASE;
-		}
-	} else if (priv->info.dq_mode == SNPS_DQ_HALF) {
-		if (priv->info.sdram_mode == MEM_LPDDR3) {
-			map->col[10] = FIELD_GET(DDR_ADDRMAP_B24_M15, addrmap[3]);
-			map->col[10] = map->col[10] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[10] + COL_B9_BASE;
-
-			map->col[11] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[4]);
-			map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[11] + COL_B10_BASE;
-		} else {
-			map->col[11] = FIELD_GET(DDR_ADDRMAP_B24_M15, addrmap[3]);
-			map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[11] + COL_B9_BASE;
-
-			map->col[13] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[4]);
-			map->col[13] = map->col[13] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[13] + COL_B10_BASE;
-		}
-	} else {
-		if (priv->info.sdram_mode == MEM_LPDDR3) {
-			map->col[10] = FIELD_GET(DDR_ADDRMAP_B16_M15, addrmap[3]);
-			map->col[10] = map->col[10] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[10] + COL_B8_BASE;
-
-			map->col[11] = FIELD_GET(DDR_ADDRMAP_B24_M15, addrmap[3]);
-			map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[11] + COL_B9_BASE;
-		} else {
-			map->col[11] = FIELD_GET(DDR_ADDRMAP_B16_M15, addrmap[3]);
-			map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[11] + COL_B8_BASE;
-
-			map->col[11] = FIELD_GET(DDR_ADDRMAP_B24_M15, addrmap[3]);
-			map->col[13] = map->col[13] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[13] + COL_B9_BASE;
-		}
-	}
+	map->col[13] = map->col[12];
+	map->col[12] = DDR_ADDRMAP_UNUSED;
 }
 
 /**
-- 
2.41.0

