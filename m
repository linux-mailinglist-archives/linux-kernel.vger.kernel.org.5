Return-Path: <linux-kernel+bounces-77078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 958DC8600F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF871F2193D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431061649BE;
	Thu, 22 Feb 2024 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeJ911FL"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A4E15F311;
	Thu, 22 Feb 2024 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625691; cv=none; b=m7n5PviT5Uzpw/s4swrmiOHWgkrmc/ll0vlUCQtGzQrXirQxyOGYl45bJ2pz5hIYcXVF8OLpm1cy4TR0MqjeqZCWtpPsXLuN4td0leQeonZEXUO22GHIKu7JUZ2yEXiscQCiSiIeerohE4BvGriS0DTDNmLlK/GqpuNB7DgYr6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625691; c=relaxed/simple;
	bh=mt9UynXI2+qgvIzJYiFKClBsAzOssYbzQ3BkuR7uDn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/pSpWm9DofNp+raKfTcfK4kqqT/GQRoanwzTfSr0XcOoj4/2TBGYBLc/TtbXgoq0aqaGbVYN+Qxtm36ZKJ4sykCjGcf/fI/IM/UitEN9+1bdwKMdYw4VP7/Ca/7RVTuFwmhR4uAEw7ABFmwlewR+mnfKLja6Wbj8XHpzXuNa+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeJ911FL; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d1094b5568so924631fa.1;
        Thu, 22 Feb 2024 10:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625688; x=1709230488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nAXuUIOjmGqCty40Smyp4CQdr7UcxvXuJwOvkK+QNc=;
        b=FeJ911FLahQ/GPLrLjq5p6B7fWPlUXj1O9cNttv0L9ZFQ1Ez++LuSfYROZEytQypnt
         MlUZDUg/UF9c5nCvTPI8VBpPHdPftPiR/NS6+NbDedKmNkWC5ofjdUQ88I8qydVRF3LU
         3rUo1ml7L2xlLITADhzAmsBVJGz3pZWw7T6hRE2rqlmi7ha8KAt5q4VOM71sP1k2y8p+
         muOBAHdFlMgDvSpqVqJRwEaPDDBXN08TgaAj5GIZXzNVD8g0nELAchMld3Ghz7QzDmjX
         hv0TUiwSyxSGa0NhBnsy38NeQ15e/AqFwea9Ye4l8fQkwywXzdCWSLhoyoRNmbT0Yajh
         AANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625688; x=1709230488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nAXuUIOjmGqCty40Smyp4CQdr7UcxvXuJwOvkK+QNc=;
        b=gGrKt1cB+2tK//OvJLo/ptmR1OyknWlYXmqIQMponhci/hYjr3NvtU6YPkj7l1b0JR
         14Xf9aoBPU0BNhSvjpLzPB7fNRzYsEAMHg0ORqxR0gcRF8f5AqMMdrbSeKGGSiL+m7UQ
         xb50e7FRnY5ZzISB6GqRWu6F7TwzpZe2CVv1Oj/+Y6Cn3K8u6TW3jAtyk0a74TjJLlpm
         VEIr9r52I+661QSVWH/AQElyXBM54nm9p6Op8YNtoDLOtY9TrcE77R7OGAPi/QWpXwxy
         fXovJpXa9eF3PWHBr8v+sNoFLEc0IU2cDsWOKH70g6jHafBOVH1Jn1DuEYNXWiLM6A37
         iVfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9bltpQjaTpqLNyq228ghYWHTNvXNRpGRENhzcVrUqOLZD/hWUZa0HAWAHICwQ5FHIfBbpiOfEB/7bjfW68RKEjyiLpQwnU3Newbszg45aa1axT+jcdIciVPIe33apakxJXDtCm47aGg==
X-Gm-Message-State: AOJu0YyOfDcm62MnermVRliMABrgMoN+DEshUIg4WhlSPurQo+xq8cDv
	UyUvXcqUwisEG55YdJ+V0JGt9u6nGIcpCV9M45jVGDH+aMd7EcuA
X-Google-Smtp-Source: AGHT+IHuWrnLpg4juM7jhgCVO9zVn6Qc74sw3WuVEmtL6YWr4BWGK20vM8RFfEGoQoVZiRd12s1KiA==
X-Received: by 2002:a2e:a272:0:b0:2d2:4388:63fc with SMTP id k18-20020a2ea272000000b002d2438863fcmr6085862ljm.44.1708625687765;
        Thu, 22 Feb 2024 10:14:47 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id bd7-20020a05651c168700b002d24c720b16sm969025ljb.101.2024.02.22.10.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:47 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Lei Wang <lewan@microsoft.com>,
	Egor Martovetsky <egor@pasemi.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 15/20] EDAC/mc: Re-use generic unique MC index allocation procedure
Date: Thu, 22 Feb 2024 21:13:00 +0300
Message-ID: <20240222181324.28242-16-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222181324.28242-1-fancer.lancer@gmail.com>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 4e30b989a1a4..93734a97a67b 100644
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
index 1eea3341a916..06d267d40a6a 100644
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
2.43.0


