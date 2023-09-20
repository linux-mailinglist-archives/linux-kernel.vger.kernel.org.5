Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C373A7A8CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjITT3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjITT3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:29:06 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EC5D3;
        Wed, 20 Sep 2023 12:28:52 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso2352431fa.3;
        Wed, 20 Sep 2023 12:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695238130; x=1695842930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqkMxqOHncqsMYhQRlBDL7MG22B9ye3F7LSOor6Fxdc=;
        b=a++IAGYwtjcU3SLjl1zGCBp9P+8PgKA35kvSW1Wn9LUe6HB2d8Mpsdg5/pkHCLU2Sn
         wF5k5bjzBx4hn0pJ38Kg7mLaRZXpI06/fPaFKE9LM2agjjudqUNG5dBk1BkWBFyHxC/9
         w+NzRHXiTK4F1ZOTTgADtw6Ilr9jaDdM8/HIrQkGIYQfHiOurz43vHFxP1E6WlGZq86B
         wQLqZJ0SM535FxlNDQgsusYhMTGLT3SlXtIvY1eeOTPOIOt6zAESGRLunQkNggV+DT6y
         DHoXXbKOqhSDIIFghyL2CiDgKcPrx8edHCEovnQrx7wCE66GGH6cgy2SgotVQLyVRpzx
         qHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238130; x=1695842930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqkMxqOHncqsMYhQRlBDL7MG22B9ye3F7LSOor6Fxdc=;
        b=iMGI9tOzHR4gidoF3IY9qQXzUMQOkGaXcs8lu5NYF6X9wmCSUqk83i1uzbseL702za
         FyhfDN9+4IFRsyt0YCdTAVoMhXxI/FSyprwe+0BL1QhAQTE1adfnowMJV8kIIJGOkQco
         YX50KyNeNCxjEfm803JULXDcxB+lmp0YkVMKonD6VWKbKYZifa6AHwoV6rLPV9fKmGKz
         w252dJd4htXzMJUNsBriaPXGCTQJ5qZxpMbYfW4hj/Aea8G46N70KNLyWGjvFLsYMDQ4
         S+Zpz/I0Q4p4V5VnF2K18mI8d8lvejpVjVEidXxaou+TcgvAwHonFCAuvl90qQGYrXYS
         6JBg==
X-Gm-Message-State: AOJu0YyHM15TBPGwrceizy/7eg48R/UTVwl6H4bUUOg+F0jaX6l1xYO0
        TqUYVfYjSqLaGSYCQ4Yj4ZA=
X-Google-Smtp-Source: AGHT+IHwKIWEU16ms/otWDq2b8ELHaN+mH3xTI3PC2c/Z46prfo2moy4ZDTclGHfvjbZhTpn7gKqlQ==
X-Received: by 2002:a05:6512:2813:b0:503:3803:9e99 with SMTP id cf19-20020a056512281300b0050338039e99mr4239358lfb.15.1695238129974;
        Wed, 20 Sep 2023 12:28:49 -0700 (PDT)
Received: from localhost ([178.176.86.191])
        by smtp.gmail.com with ESMTPSA id r6-20020a19ac46000000b00502e01d1383sm2805899lfc.27.2023.09.20.12.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:28:49 -0700 (PDT)
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
Subject: [PATCH v4 09/18] EDAC/synopsys: Set actual DIMM ECC errors grain
Date:   Wed, 20 Sep 2023 22:26:54 +0300
Message-ID: <20230920192806.29960-10-fancer.lancer@gmail.com>
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

It was wrong to set the DIMM errors grain parameter to just 1 byte because
DW uMCTL2 DDRC calculates ECC for each SDRAM word and passes it as an
additional byte of data to the memory chips. SDRAM word is the actual
DQ-bus width determined by the DQ-width set during the IP-core synthesize
and the DQ-bus mode (part of the DQ-bus actually used to get data from the
memory chips) selected during the DDR controller initial setup procedure.
Thus set the MCI DIMMs grain based on these parameters determined during
the DW uMCTL2 DDRC config getting procedure.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index e6288e135480..e10778cead63 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -26,9 +26,6 @@
 /* Number of channels per memory controller */
 #define SNPS_EDAC_NR_CHANS		1
 
-/* Granularity of reported error in bytes */
-#define SNPS_EDAC_ERR_GRAIN		1
-
 #define SNPS_EDAC_MSG_SIZE		256
 
 #define SNPS_EDAC_MOD_STRING		"snps_edac"
@@ -736,9 +733,12 @@ static void snps_init_csrows(struct mem_ctl_info *mci)
 	struct snps_edac_priv *priv = mci->pvt_info;
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
-	u32 size, row;
+	u32 size, row, width;
 	int j;
 
+	/* Actual SDRAM-word width for which ECC is calculated */
+	width = 1U << (priv->info.dq_width - priv->info.dq_mode);
+
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
 		size = snps_get_memsize();
@@ -748,7 +748,7 @@ static void snps_init_csrows(struct mem_ctl_info *mci)
 			dimm->edac_mode	= EDAC_SECDED;
 			dimm->mtype	= priv->info.sdram_mode;
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
-			dimm->grain	= SNPS_EDAC_ERR_GRAIN;
+			dimm->grain	= width;
 			dimm->dtype	= priv->info.dev_cfg;
 		}
 	}
-- 
2.41.0

