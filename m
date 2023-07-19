Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD65759ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjGSTfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjGSTfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:35:06 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6DE2115
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:34:38 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-345f4a3ff76so461585ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689795277; x=1690400077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQtL8/41Z1V1hiq79fEomhJLs5bJqMNwqo2oB2sFh+M=;
        b=N+rgicSBNL326QCmnjhUOfpQ8izFbGdkgaThZ9XQu4Mk7iD0IHeKkXdtZ5VmwkR5S/
         Rha2e6WKVkIXnSSSPhpJB5kwm5JJ8K6GHWb1/fSWu2MjSn1i8oKOPgc1WYSEqaXjg0bt
         BFjczOR5ZKrHW0axat2rmuT9KwZFaMslcXz3HWujeiLsrx5CKDzH7WulClxeSbbBaLMP
         BtB6PO2ogDbNr5NDZKO/s7PS8iWesDpwiw1+8ebka5fPlOPD45mP8UUxpsidA+uJ2WNV
         00rqY9w3Bf+YceD4mU4wYnXuoqe2R9l40eJtVpzgc63P1VjrzeYo+3tJpu1Ir2bR9L50
         KhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689795277; x=1690400077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQtL8/41Z1V1hiq79fEomhJLs5bJqMNwqo2oB2sFh+M=;
        b=DShjlU/IGeRbj8dIPMQTZzcVKk+igkLMt4gK2RYUr0Kmlzl4JeJ+8ccc/tz/2phqnI
         bNSQP5LOqns0iuhOGmJqKn10cb/qgUh4NnC2xVdD2F5SvtWqWvkcyH0k/j6/DL/bUw4X
         IwP0edcNrSljlXYLEi4aqf3MoHqtN44+oGeH3MbI+IQAMN4qMTFrvhBjA+UGp6ba7DGW
         k1RxbVCKFb+DXa1KIyH1a2vbws4kZqnEyZkzW2vJGBzG93Hg2x8sxOUda8GTPARtjCUm
         d2Oj/fifuGjt9vcp6oNa2pGDXk2v4WJKScN3/T+OrDauBNYBQzv/bcHZma5JF80WBZFb
         NWAA==
X-Gm-Message-State: ABy/qLamn4S5Sp3s48/NIHn7Uz+z80B0z+Z4e6etOfSK44A3IXqn6drJ
        vqxDBzieLk92jCZBmR5opGQAHw==
X-Google-Smtp-Source: APBJJlFzjlxmwn6yHr60YRnzS6QP9ZKpMDICdaPBklxkA0AGmYtcK5/R2NpPUsB4j8EU4mV73Zv3TQ==
X-Received: by 2002:a05:6e02:1c8f:b0:345:6c70:a7cd with SMTP id w15-20020a056e021c8f00b003456c70a7cdmr3753958ill.1.1689795277679;
        Wed, 19 Jul 2023 12:34:37 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a031700b00264040322desm1591053pje.40.2023.07.19.12.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:34:37 -0700 (PDT)
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
Subject: [PATCH 11/11] RISC-V: drivers/iommu/riscv: Add G-Stage translation support
Date:   Wed, 19 Jul 2023 12:33:55 -0700
Message-Id: <0c391072fe0be52b3bdf3d826e4313d960aecba0.1689792825.git.tjeznach@rivosinc.com>
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

This change introduces 2nd stage translation configuration
support, enabling nested translation for IOMMU hardware.
Pending integration with VMM IOMMUFD interfaces to manage
1st stage translation and IOMMU virtialization interfaces.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/iommu.c | 58 ++++++++++++++++++++++++++++---------
 drivers/iommu/riscv/iommu.h |  3 +-
 2 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 7b3e3e135cf6..3ca2f0194d3c 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1418,6 +1418,19 @@ static struct iommu_domain *riscv_iommu_domain_alloc(unsigned type)
 	return &domain->domain;
 }
 
+/* mark domain as second-stage translation */
+static int riscv_iommu_enable_nesting(struct iommu_domain *iommu_domain)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+
+	mutex_lock(&domain->lock);
+	if (list_empty(&domain->endpoints))
+		domain->g_stage = true;
+	mutex_unlock(&domain->lock);
+
+	return domain->g_stage ? 0 : -EBUSY;
+}
+
 static void riscv_iommu_domain_free(struct iommu_domain *iommu_domain)
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
@@ -1433,7 +1446,7 @@ static void riscv_iommu_domain_free(struct iommu_domain *iommu_domain)
 		free_io_pgtable_ops(&domain->pgtbl.ops);
 
 	if (domain->pgd_root)
-		free_pages((unsigned long)domain->pgd_root, 0);
+		free_pages((unsigned long)domain->pgd_root, domain->g_stage ? 2 : 0);
 
 	if ((int)domain->pscid > 0)
 		ida_free(&riscv_iommu_pscids, domain->pscid);
@@ -1483,7 +1496,8 @@ static int riscv_iommu_domain_finalize(struct riscv_iommu_domain *domain,
 
 	/* TODO: Fix this for RV32 */
 	domain->mode = satp_mode >> 60;
-	domain->pgd_root = (pgd_t *) __get_free_pages(GFP_KERNEL | __GFP_ZERO, 0);
+	domain->pgd_root = (pgd_t *) __get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						      domain->g_stage ? 2 : 0);
 
 	if (!domain->pgd_root)
 		return -ENOMEM;
@@ -1499,6 +1513,8 @@ static u64 riscv_iommu_domain_atp(struct riscv_iommu_domain *domain)
 	u64 atp = FIELD_PREP(RISCV_IOMMU_DC_FSC_MODE, domain->mode);
 	if (domain->mode != RISCV_IOMMU_DC_FSC_MODE_BARE)
 		atp |= FIELD_PREP(RISCV_IOMMU_DC_FSC_PPN, virt_to_pfn(domain->pgd_root));
+	if (domain->g_stage)
+		atp |= FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->pscid);
 	return atp;
 }
 
@@ -1541,20 +1557,30 @@ static int riscv_iommu_attach_dev(struct iommu_domain *iommu_domain, struct devi
 	if (!dc)
 		return -ENODEV;
 
-	/*
-	 * S-Stage translation table. G-Stage remains unmodified (BARE).
-	 */
-	val = FIELD_PREP(RISCV_IOMMU_DC_TA_PSCID, domain->pscid);
-
-	if (ep->pasid_enabled) {
-		ep->pc[0].ta = cpu_to_le64(val | RISCV_IOMMU_PC_TA_V);
-		ep->pc[0].fsc = cpu_to_le64(riscv_iommu_domain_atp(domain));
+	if (domain->g_stage) {
+		/*
+		 * Enable G-Stage translation with initial pass-through mode
+		 * for S-Stage. VMM is responsible for more restrictive
+		 * guest VA translation scheme configuration.
+		 */
 		dc->ta = 0;
-		dc->fsc = cpu_to_le64(virt_to_pfn(ep->pc) |
-		    FIELD_PREP(RISCV_IOMMU_DC_FSC_MODE, RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8));
+		dc->fsc = 0ULL; /* RISCV_IOMMU_DC_FSC_MODE_BARE */ ;
+		dc->iohgatp = cpu_to_le64(riscv_iommu_domain_atp(domain));
 	} else {
-		dc->ta = cpu_to_le64(val);
-		dc->fsc = cpu_to_le64(riscv_iommu_domain_atp(domain));
+		/* S-Stage translation table. G-Stage remains unmodified. */
+		if (ep->pasid_enabled) {
+			val = FIELD_PREP(RISCV_IOMMU_DC_TA_PSCID, domain->pscid);
+			ep->pc[0].ta = cpu_to_le64(val | RISCV_IOMMU_PC_TA_V);
+			ep->pc[0].fsc = cpu_to_le64(riscv_iommu_domain_atp(domain));
+			dc->ta = 0;
+			val = FIELD_PREP(RISCV_IOMMU_DC_FSC_MODE,
+					  RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8);
+			dc->fsc = cpu_to_le64(val | virt_to_pfn(ep->pc));
+		} else {
+			val = FIELD_PREP(RISCV_IOMMU_DC_TA_PSCID, domain->pscid);
+			dc->ta = cpu_to_le64(val);
+			dc->fsc = cpu_to_le64(riscv_iommu_domain_atp(domain));
+		}
 	}
 
 	wmb();
@@ -1599,6 +1625,9 @@ static int riscv_iommu_set_dev_pasid(struct iommu_domain *iommu_domain,
 	if (!iommu_domain || !iommu_domain->mm)
 		return -EINVAL;
 
+	if (domain->g_stage)
+		return -EINVAL;
+
 	/* Driver uses TC.DPE mode, PASID #0 is incorrect. */
 	if (pasid == 0)
 		return -EINVAL;
@@ -1969,6 +1998,7 @@ static const struct iommu_domain_ops riscv_iommu_domain_ops = {
 	.iotlb_sync = riscv_iommu_iotlb_sync,
 	.iotlb_sync_map = riscv_iommu_iotlb_sync_map,
 	.flush_iotlb_all = riscv_iommu_flush_iotlb_all,
+	.enable_nesting = riscv_iommu_enable_nesting,
 };
 
 static const struct iommu_ops riscv_iommu_ops = {
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 55418a1144fb..55e5aafea5bc 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -102,8 +102,9 @@ struct riscv_iommu_domain {
 	struct riscv_iommu_device *iommu;
 
 	unsigned mode;		/* RIO_ATP_MODE_* enum */
-	unsigned pscid;		/* RISC-V IOMMU PSCID */
+	unsigned pscid;		/* RISC-V IOMMU PSCID / GSCID */
 	ioasid_t pasid;		/* IOMMU_DOMAIN_SVA: Cached PASID */
+	bool g_stage;		/* 2nd stage translation domain */
 
 	pgd_t *pgd_root;	/* page table root pointer */
 };
-- 
2.34.1

