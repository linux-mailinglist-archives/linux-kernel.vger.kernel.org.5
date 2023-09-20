Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DED7A8D22
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjITTvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjITTu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:50:57 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FA6D7;
        Wed, 20 Sep 2023 12:50:50 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-500cfb168c6so406284e87.2;
        Wed, 20 Sep 2023 12:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695239449; x=1695844249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLdARslqZ1UHIFAXq/hck+mV3lZPnBFJ5rf0uyQGrzY=;
        b=LsLESdnayLmaQuCa+IKo4tBAiZSu8sIVLWoCU1JERe1njC5O8CxUNY91VRtvsCdJfL
         60/alef8p5FlBweD/1X/cF/Y6hWZsa8r6DqQcTdpiSMEtGpOwSaH9EjykSXbxldMDL+W
         DQpFkyI2cYj16yOd5zAEWK2sFtRyyHG7N6s5L8knzMCQZOq84ic7frVFNUrFVsDKF2+r
         f3QUeFjiXM8qeVw1LAwXTMpZUGvBreQXPVgqNrIvs3hsw52BHVUPxZGijr2BDWnGfrV4
         W9TQ9UriXA384I2IX5ENV4SViAkqCvMdO8/8TmhXxsDzsCm6VYYyQBI606wrK4oDvbgH
         LzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239449; x=1695844249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLdARslqZ1UHIFAXq/hck+mV3lZPnBFJ5rf0uyQGrzY=;
        b=SiG7hfhVgNU4GbqPYN6n2gfRqxtfqqdm7c6FPviziuuntValjZbcomE7U7bYxUxFx+
         nLkDlCjXH3KKXjJ1/m3fnYbrpXKLsWb+nrJ0wzWI27c3tE5o3CT25hyGZdG+gonB4FaR
         LUAQ3Xe+AOocGgKQCCVfDDEfKVDJa43lxYXChvwLEsO/8MYq1U3FMTDt15yDTDbZ0TTA
         iXX1C/bZGsavvxeZIohkKycUQxR7vXspVeZN8KQolti9uFwnp0IjhjfFvPCfR7IPQG3K
         tGQuzfdyEil8nDCuOh7QexOCE6Cjiij6nQFxCDW7uVsz/b1EltH5mvCBywKwxXOx/iYb
         05pg==
X-Gm-Message-State: AOJu0Yz49tUQbxxOnKKKhR2NWkNe8tHY1PoIE98gahZQGx9xqLovPd4d
        5o4v0nBri35TEWlBDjdZtxU=
X-Google-Smtp-Source: AGHT+IGD+1vuPJHvvxlM6XsMPzpeFlN+p62CF5i4Vq+sUzIz0nwdXcTwcBohCcB4cG1BpSAoCNN2PQ==
X-Received: by 2002:a05:6512:b10:b0:500:9a29:bcb8 with SMTP id w16-20020a0565120b1000b005009a29bcb8mr4023028lfu.4.1695239448598;
        Wed, 20 Sep 2023 12:50:48 -0700 (PDT)
Received: from localhost ([85.140.0.132])
        by smtp.gmail.com with ESMTPSA id t26-20020ac2549a000000b004fe09e6d1e7sm2791953lfk.110.2023.09.20.12.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:50:48 -0700 (PDT)
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
Subject: [PATCH v4 18/18] EDAC/synopsys: Add mapping-based memory size calculation
Date:   Wed, 20 Sep 2023 22:50:42 +0300
Message-ID: <20230920195045.31466-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920192806.29960-1-fancer.lancer@gmail.com>
References: <20230920192806.29960-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the size of the memory attached to the controller is retrieved
by means of the si_meminfo() method. It isn't quite correct because the
system may have more than one memory controller. There is a better and
more portable approach available to find out the attached memory size.
Since the full HIF/SDRAM mapping table is available already in the device
probe procedure and the DQ-bus width is detected at that stage too, that
info can be used to calculate the total memory size accessible over the
corresponding DW uMCTL2 DDR controller. It can be done since the
controller databook demands that none two SDRAM bits are mapped to the
same HIF bit [1] and that the unused SDRAM address bits mapping must be
disabled [2].

Note the size calculation procedure takes the ranks mapping into account.
That part will be removed after the multi-ranked MC registration is added.

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
    Databook, Version 3.91a, October 2020, p.108
[2] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
    Databook, Version 3.91a, October 2020, p.109

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 66 ++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index d67a19fedb3c..9a621b7a256d 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -965,20 +965,6 @@ static inline enum dev_type snps_get_dtype(u32 mstr)
 	return DEV_UNKNOWN;
 }
 
-/**
- * snps_get_memsize - Read the size of the attached memory device.
- *
- * Return: the memory size in bytes.
- */
-static u32 snps_get_memsize(void)
-{
-	struct sysinfo inf;
-
-	si_meminfo(&inf);
-
-	return inf.totalram * inf.mem_unit;
-}
-
 /**
  * snps_get_mtype - Returns controller memory type.
  * @mstr:	Master CSR value.
@@ -1393,6 +1379,51 @@ static void snps_get_addr_map(struct snps_edac_priv *priv)
 	snps_get_hif_rank_map(priv, regval);
 }
 
+/**
+ * snps_get_sdram_size - Calculate SDRAM size.
+ * @priv:	DDR memory controller private data.
+ *
+ * The total size of the attached memory is calculated based on the HIF/SDRAM
+ * mapping table. It can be done since the hardware reference manual demands
+ * that none two SDRAM bits should be mapped to the same HIF bit and that the
+ * unused SDRAM address bits mapping must be disabled.
+ *
+ * Return: the memory size in bytes.
+ */
+static u64 snps_get_sdram_size(struct snps_edac_priv *priv)
+{
+	struct snps_hif_sdram_map *map = &priv->hif_sdram_map;
+	u64 size = 0;
+	int i;
+
+	for (i = 0; i < DDR_MAX_ROW_WIDTH; i++) {
+		if (map->row[i] != DDR_ADDRMAP_UNUSED)
+			size++;
+	}
+
+	for (i = 0; i < DDR_MAX_COL_WIDTH; i++) {
+		if (map->col[i] != DDR_ADDRMAP_UNUSED)
+			size++;
+	}
+
+	for (i = 0; i < DDR_MAX_BANK_WIDTH; i++) {
+		if (map->bank[i] != DDR_ADDRMAP_UNUSED)
+			size++;
+	}
+
+	for (i = 0; i < DDR_MAX_BANKGRP_WIDTH; i++) {
+		if (map->bankgrp[i] != DDR_ADDRMAP_UNUSED)
+			size++;
+	}
+
+	for (i = 0; i < DDR_MAX_RANK_WIDTH; i++) {
+		if (map->rank[i] != DDR_ADDRMAP_UNUSED)
+			size++;
+	}
+
+	return 1ULL << (size + priv->info.dq_width);
+}
+
 /**
  * snps_init_csrows - Initialize the csrow data.
  * @mci:	EDAC memory controller instance.
@@ -1405,7 +1436,8 @@ static void snps_init_csrows(struct mem_ctl_info *mci)
 	struct snps_edac_priv *priv = mci->pvt_info;
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
-	u32 size, row, width;
+	u32 row, width;
+	u64 size;
 	int j;
 
 	/* Actual SDRAM-word width for which ECC is calculated */
@@ -1413,13 +1445,13 @@ static void snps_init_csrows(struct mem_ctl_info *mci)
 
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
-		size = snps_get_memsize();
+		size = snps_get_sdram_size(priv);
 
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm		= csi->channels[j]->dimm;
 			dimm->edac_mode	= EDAC_SECDED;
 			dimm->mtype	= priv->info.sdram_mode;
-			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
+			dimm->nr_pages	= PHYS_PFN(size) / csi->nr_channels;
 			dimm->grain	= width;
 			dimm->dtype	= priv->info.dev_cfg;
 		}
-- 
2.41.0

