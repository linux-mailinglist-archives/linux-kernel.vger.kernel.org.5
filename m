Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB639759ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGSTfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjGSTfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:35:06 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEBE2112
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:34:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-262d33fa37cso4021578a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689795276; x=1690400076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUXvXbLuP8wDy1OSCml3bGjGEs0jCX+1NqTNk6KKpl8=;
        b=yJG+r2hMaEM+aliN8AVg0otRKaB4Z8eB26rded4dmVlMEf7QPzs7oXMfpQmJMKL++k
         pDvxPqx/ZqxGapQ8WSH3D2kxHKnBm3x9Q5Nio4OahuUSf/B/GgPdLMDrg7z5Sq1B3ikz
         UeH/z3vVIqFc2rMrJ9TpbVfnlAuwcYXAo6tCGKDkTZV8bY/H0jQvKdPnhjLxXacZpTy/
         iW900N9T4LgH9r16t39SqEYpRVL8dfRWtJHsro1fR6D0IcienUrOo4o6hxfggu3gqr6G
         4XvpBJFV2BHbmMGsUPaauELDeBsOihKwyQFkYQ1vNuTpXydFhJ5707WI9dxod6GTdPZl
         oKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689795276; x=1690400076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUXvXbLuP8wDy1OSCml3bGjGEs0jCX+1NqTNk6KKpl8=;
        b=I6taln9Hu3rG25JPv1dDpJwbuzr8pYevXUDMvtZwj1xgtbt39siGGC0CXST1dsUMKq
         lH4gf5lzFW46XXL0YA1EgrBZJGzlRj9abQM7QvoRTJ9+jAG3aGWBohICcte6WDFOiRnc
         wDGmqvF0r+iBDxIogd5HSradGm1QmhQnvWK+RXDyC5WA4tzeVQHjRjSaw3f6mvfr5vBZ
         xrVBb+rIfBOvRzFMoffMPc6DYkKzw4pEyStbahF5zRgab/8v6/Q+zkC80XGpcnEeBg+8
         3a8zO8ec5N2V3yqZ3H8CnzmMTaOOeKN0HJUw8aJNDG3rr1QSYGF5rSBGwyDNH0g7Qa1G
         sTQg==
X-Gm-Message-State: ABy/qLbqgAphtfQO5VZjTyTeHbEV2/OU4I2gIz3nfwHdhsKsscaJTFre
        tQ/TjN+WLHvMLJnBSW2TuEjzHQ==
X-Google-Smtp-Source: APBJJlGbDD5aTGEi40JcY4RNgasjfgy48ieoko/t1uTH9H4BvKdLkbsHdSPwZCOuiw6bztkQOdloJA==
X-Received: by 2002:a17:90a:aa04:b0:263:f776:8ba3 with SMTP id k4-20020a17090aaa0400b00263f7768ba3mr197600pjq.9.1689795276298;
        Wed, 19 Jul 2023 12:34:36 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a031700b00264040322desm1591053pje.40.2023.07.19.12.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:34:35 -0700 (PDT)
From:   Tomasz Jeznach <tjeznach@rivosinc.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com, Tomasz Jeznach <tjeznach@rivosinc.com>
Subject: [PATCH 10/11] RISC-V: drivers/iommu/riscv: Add MSI identity remapping
Date:   Wed, 19 Jul 2023 12:33:54 -0700
Message-Id: <660b7a8707e494a6bb2706e10569a7414c3640a7.1689792825.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689792825.git.tjeznach@rivosinc.com>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change provides basic identity mapping support to
excercise MSI_FLAT hardware capability.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/iommu.c | 81 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.h |  3 ++
 2 files changed, 84 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 6042c35be3ca..7b3e3e135cf6 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -61,6 +61,9 @@ MODULE_PARM_DESC(priq_length, "Page request interface queue length.");
 #define RISCV_IOMMU_MAX_PSCID	(1U << 20)
 static DEFINE_IDA(riscv_iommu_pscids);
 
+/* TODO: Enable MSI remapping */
+#define RISCV_IMSIC_BASE	0x28000000
+
 /* 1 second */
 #define RISCV_IOMMU_TIMEOUT	riscv_timebase
 
@@ -932,6 +935,72 @@ static irqreturn_t riscv_iommu_priq_process(int irq, void *data)
  * Endpoint management
  */
 
+static int riscv_iommu_enable_ir(struct riscv_iommu_endpoint *ep)
+{
+	struct riscv_iommu_device *iommu = ep->iommu;
+	struct iommu_resv_region *entry;
+	struct irq_domain *msi_domain;
+	u64 val;
+	int i;
+
+	/* Initialize MSI remapping */
+	if (!ep->dc || !(iommu->cap & RISCV_IOMMU_CAP_MSI_FLAT))
+		return 0;
+
+	ep->msi_root = (struct riscv_iommu_msi_pte *)get_zeroed_page(GFP_KERNEL);
+	if (!ep->msi_root)
+		return -ENOMEM;
+
+	for (i = 0; i < 256; i++) {
+		ep->msi_root[i].pte = RISCV_IOMMU_MSI_PTE_V |
+		    FIELD_PREP(RISCV_IOMMU_MSI_PTE_M, 3) |
+		    phys_to_ppn(RISCV_IMSIC_BASE + i * PAGE_SIZE);
+	}
+
+	entry = iommu_alloc_resv_region(RISCV_IMSIC_BASE, PAGE_SIZE * 256, 0,
+					IOMMU_RESV_SW_MSI, GFP_KERNEL);
+	if (entry)
+		list_add_tail(&entry->list, &ep->regions);
+
+	val = virt_to_pfn(ep->msi_root) |
+	    FIELD_PREP(RISCV_IOMMU_DC_MSIPTP_MODE, RISCV_IOMMU_DC_MSIPTP_MODE_FLAT);
+	ep->dc->msiptp = cpu_to_le64(val);
+
+	/* Single page of MSIPTP, 256 IMSIC files */
+	ep->dc->msi_addr_mask = cpu_to_le64(255);
+	ep->dc->msi_addr_pattern = cpu_to_le64(RISCV_IMSIC_BASE >> 12);
+	wmb();
+
+	/* set msi domain for the device as isolated. hack. */
+	msi_domain = dev_get_msi_domain(ep->dev);
+	if (msi_domain) {
+		msi_domain->flags |= IRQ_DOMAIN_FLAG_ISOLATED_MSI;
+	}
+
+	dev_dbg(ep->dev, "RV-IR enabled\n");
+
+	ep->ir_enabled = true;
+
+	return 0;
+}
+
+static void riscv_iommu_disable_ir(struct riscv_iommu_endpoint *ep)
+{
+	if (!ep->ir_enabled)
+		return;
+
+	ep->dc->msi_addr_pattern = 0ULL;
+	ep->dc->msi_addr_mask = 0ULL;
+	ep->dc->msiptp = 0ULL;
+	wmb();
+
+	dev_dbg(ep->dev, "RV-IR disabled\n");
+
+	free_pages((unsigned long)ep->msi_root, 0);
+	ep->msi_root = NULL;
+	ep->ir_enabled = false;
+}
+
 /* Endpoint features/capabilities */
 static void riscv_iommu_disable_ep(struct riscv_iommu_endpoint *ep)
 {
@@ -1226,6 +1295,7 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 
 	mutex_init(&ep->lock);
 	INIT_LIST_HEAD(&ep->domain);
+	INIT_LIST_HEAD(&ep->regions);
 
 	if (dev_is_pci(dev)) {
 		ep->devid = pci_dev_id(to_pci_dev(dev));
@@ -1248,6 +1318,7 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 	dev_iommu_priv_set(dev, ep);
 	riscv_iommu_add_device(iommu, dev);
 	riscv_iommu_enable_ep(ep);
+	riscv_iommu_enable_ir(ep);
 
 	return &iommu->iommu;
 }
@@ -1279,6 +1350,7 @@ static void riscv_iommu_release_device(struct device *dev)
 		riscv_iommu_iodir_inv_devid(iommu, ep->devid);
 	}
 
+	riscv_iommu_disable_ir(ep);
 	riscv_iommu_disable_ep(ep);
 
 	/* Remove endpoint from IOMMU tracking structures */
@@ -1301,6 +1373,15 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
 
 static void riscv_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 {
+	struct iommu_resv_region *entry, *new_entry;
+	struct riscv_iommu_endpoint *ep = dev_iommu_priv_get(dev);
+
+	list_for_each_entry(entry, &ep->regions, list) {
+		new_entry = kmemdup(entry, sizeof(*entry), GFP_KERNEL);
+		if (new_entry)
+			list_add_tail(&new_entry->list, head);
+	}
+
 	iommu_dma_get_resv_regions(dev, head);
 }
 
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 83e8d00fd0f8..55418a1144fb 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -117,14 +117,17 @@ struct riscv_iommu_endpoint {
 	struct riscv_iommu_dc *dc;		/* device context pointer */
 	struct riscv_iommu_pc *pc;		/* process context root, valid if pasid_enabled is true */
 	struct riscv_iommu_device *iommu;	/* parent iommu device */
+	struct riscv_iommu_msi_pte *msi_root;	/* interrupt re-mapping */
 
 	struct mutex lock;
 	struct list_head domain;		/* endpoint attached managed domain */
+	struct list_head regions;		/* reserved regions, interrupt remapping window */
 
 	/* end point info bits */
 	unsigned pasid_bits;
 	unsigned pasid_feat;
 	bool pasid_enabled;
+	bool ir_enabled;
 };
 
 /* Helper functions and macros */
-- 
2.34.1

