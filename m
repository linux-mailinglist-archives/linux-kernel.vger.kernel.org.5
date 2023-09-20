Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09617A8C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjITTMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjITTMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:12:30 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822861B4;
        Wed, 20 Sep 2023 12:12:08 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50337b43ee6so360702e87.3;
        Wed, 20 Sep 2023 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237126; x=1695841926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AS2hrfFTOSsFmGDoeV3Bz2HwRNoskotCiooG8ue6RgE=;
        b=iDHAmEMHYXtAht6PXJ8w92+i7ub9a2PgQU6UBBOTJEB8BGYV1pMS+Dz7B99DAQFKHM
         eNoZOGn+kWDwOPRQfwHUq4nTr9T8LD/Xb6uw4ISU31KuSq9nIbkjThZ63/Ypxlti6X/+
         Sp9HQ3EVEBIZP1OO0x+oC9uR28ZZbk3QW2nW1fd5bPHYbnsBGVxfvi1M77GrvGxnFbYK
         zH29matzdvS2ESUYO8U3AP1lbrSoEM671RR1AN7VX/sjqUZr0ANGg+Ynh/1kS19ipWIJ
         sHiFrVQInTDRS4KzrwVRJHQ9MRaMLo5p+YtE+N7UNdnj1DxkGklwaZCXKAyAjvVzRYDJ
         pV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237126; x=1695841926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AS2hrfFTOSsFmGDoeV3Bz2HwRNoskotCiooG8ue6RgE=;
        b=nR0zaDg8iNIThIbpP/Om0bhGjnKp5qvGiCcIxcB0shLrAlKHJGP4y1+sEjT18NfO3K
         YpdgB3nUmf3mRB3HXmhpogrz6p/hTlsrp0CBOH2godVc+VWCxNKt2P4AZb+P9e4aSNj6
         MXdw9u2AyUX5kTOIDcZLhwHtCxmOfvA7xom5Q/i+CnXEHQHKMU9kep/nhsP0qGtTMMsP
         taVmy6tu75Za/nOfa92WMkpafpUx6frqPvIy0Y6H4OQPrpUJJXiMB3jC7AArd2YV33Wn
         I/ZJdtswpqCYjIYwydSvLAZcdbzwcopbze2LbhEnuYookkiTiYXxPvhlhv2qujCyTwEz
         8wTQ==
X-Gm-Message-State: AOJu0YxL3w0cpw7xymsSdmNQPRj+JvJ/qIYFA96CoZWZ4aqn7aY2u1r/
        s9cRMS8I2tfnIOdKPQgrFRA=
X-Google-Smtp-Source: AGHT+IHtZRlHJF1UKfZZ9A2WRkhKJlTB+mjHNA6pQTzuDm8U/J3P8nZXdhnOAe2qvMxWX86rO6G3ZQ==
X-Received: by 2002:a19:9158:0:b0:503:17c0:5374 with SMTP id y24-20020a199158000000b0050317c05374mr2574701lfj.65.1695237126561;
        Wed, 20 Sep 2023 12:12:06 -0700 (PDT)
Received: from localhost ([85.26.234.43])
        by smtp.gmail.com with ESMTPSA id t9-20020a19ad09000000b005032ebff21asm852742lfc.279.2023.09.20.12.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:12:06 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Lei Wang <lewan@microsoft.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Egor Martovetsky <egor@pasemi.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 15/20] EDAC/mc: Re-use generic unique MC index allocation procedure
Date:   Wed, 20 Sep 2023 22:10:39 +0300
Message-ID: <20230920191059.28395-16-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920191059.28395-1-fancer.lancer@gmail.com>
References: <20230920191059.28395-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
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

The EDAC drivers locally maintaining a statically defined
memory-controllers counter don't care much about the MC index assigned as
long as it's unique so the EDAC core perceives it. Convert these drivers
to be using the generic MC index allocation procedure recently added to
the EDAC core.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v4:
- Initial patch introduction.
---
 drivers/edac/dmc520_edac.c | 4 +---
 drivers/edac/pasemi_edac.c | 5 +----
 drivers/edac/ppc4xx_edac.c | 5 +----
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c
index 1fa5ca57e9ec..abd73ed0ad89 100644
--- a/drivers/edac/dmc520_edac.c
+++ b/drivers/edac/dmc520_edac.c
@@ -173,8 +173,6 @@ struct dmc520_edac {
 	int masks[NUMBER_OF_IRQS];
 };
 
-static int dmc520_mc_idx;
-
 static u32 dmc520_read_reg(struct dmc520_edac *pvt, u32 offset)
 {
 	return readl(pvt->reg_base + offset);
@@ -517,7 +515,7 @@ static int dmc520_edac_probe(struct platform_device *pdev)
 	layers[0].size = dmc520_get_rank_count(reg_base);
 	layers[0].is_virt_csrow = true;
 
-	mci = edac_mc_alloc(dmc520_mc_idx++, ARRAY_SIZE(layers), layers, sizeof(*pvt));
+	mci = edac_mc_alloc(EDAC_AUTO_MC_NUM, ARRAY_SIZE(layers), layers, sizeof(*pvt));
 	if (!mci) {
 		edac_printk(KERN_ERR, EDAC_MOD_NAME,
 			    "Failed to allocate memory for mc instance\n");
diff --git a/drivers/edac/pasemi_edac.c b/drivers/edac/pasemi_edac.c
index 1a1c3296ccc8..afebfbda1ea0 100644
--- a/drivers/edac/pasemi_edac.c
+++ b/drivers/edac/pasemi_edac.c
@@ -57,8 +57,6 @@
 #define PASEMI_EDAC_ERROR_GRAIN			64
 
 static int last_page_in_mmc;
-static int system_mmc_id;
-
 
 static u32 pasemi_edac_get_error_info(struct mem_ctl_info *mci)
 {
@@ -203,8 +201,7 @@ static int pasemi_edac_probe(struct pci_dev *pdev,
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
 	layers[1].size = PASEMI_EDAC_NR_CHANS;
 	layers[1].is_virt_csrow = false;
-	mci = edac_mc_alloc(system_mmc_id++, ARRAY_SIZE(layers), layers,
-			    0);
+	mci = edac_mc_alloc(EDAC_AUTO_MC_NUM, ARRAY_SIZE(layers), layers, 0);
 	if (mci == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
index 046969b4e82e..2b3d66bd0c28 100644
--- a/drivers/edac/ppc4xx_edac.c
+++ b/drivers/edac/ppc4xx_edac.c
@@ -1214,7 +1214,6 @@ static int ppc4xx_edac_probe(struct platform_device *op)
 	const struct device_node *np = op->dev.of_node;
 	struct mem_ctl_info *mci = NULL;
 	struct edac_mc_layer layers[2];
-	static int ppc4xx_edac_instance;
 
 	/*
 	 * At this point, we only support the controller realized on
@@ -1265,7 +1264,7 @@ static int ppc4xx_edac_probe(struct platform_device *op)
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
 	layers[1].size = ppc4xx_edac_nr_chans;
 	layers[1].is_virt_csrow = false;
-	mci = edac_mc_alloc(ppc4xx_edac_instance, ARRAY_SIZE(layers), layers,
+	mci = edac_mc_alloc(EDAC_AUTO_MC_NUM, ARRAY_SIZE(layers), layers,
 			    sizeof(struct ppc4xx_edac_pdata));
 	if (mci == NULL) {
 		ppc4xx_edac_printk(KERN_ERR, "%pOF: "
@@ -1303,8 +1302,6 @@ static int ppc4xx_edac_probe(struct platform_device *op)
 			goto fail1;
 	}
 
-	ppc4xx_edac_instance++;
-
 	return 0;
 
  fail1:
-- 
2.41.0

