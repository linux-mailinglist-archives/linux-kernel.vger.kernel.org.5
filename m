Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253FD759EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjGSTfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGSTfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:35:05 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2539F2109
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:34:35 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so5510378a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689795272; x=1690400072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5i4Hac8zNCva6KUF+QJNd5Gpa8QthSQdhYqfDg3A/Yw=;
        b=dQXEnazYB2vuwxM3Chz9h8ooEIEl1UekfaSytU+WdBmWuSL9V63l5RoT3DGf6pjwHl
         weGKiimrDhgSSn0fm13pJgSoFM5Rr+lBybpKdsxGNuLhzr4v0smdnfzN0Z0tvwCFQpyZ
         eLGmG/VSiiQyRofCAaXzqwSfS34WKPoX16qQgnezgzBpHIl/C5girTKlxssW25rnCAmo
         osvYK0DeFq9ywfVGbudJlnavXdQpRSMW5ahMxJfxNAUCHJSY+TjkL6KBKNGAnumhvx8G
         9wPBFLPhIjl0gkzvfeWyvcyp0ews1NrpuCb4dzbvGp92JdrwsP4aULpZ0LTTGUGJVRRs
         aDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689795272; x=1690400072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5i4Hac8zNCva6KUF+QJNd5Gpa8QthSQdhYqfDg3A/Yw=;
        b=a1imbFwtKtRq6RX6tqxCatW8BU+63Y+YVcFygDAt3ibpZYZoWyWTwcbCnnKEd00Nrh
         7xBA4P9Y0C/lx2X9rBUZmuovuzsiQiIygvGFwXY3Ujmb5GIGbcvo6cpCE9eZnUFqYp6v
         774beSzVUy5yEvtXAJ7A/5KNzDUoiJmMxG/thrqBY+8pwRA5qVbm7TVYcdGBk5A93Y2k
         PkdEkLobIEsxTfle7ryOx0xH/H+p2GMvU4wCXMtl6l0EsFWM1I36waqWGAYfAXJOCS18
         H3KxkcCRSIC+Va4Oj9nMALuZS8uokzjTBxNZdmQyzhcRe2mvBxa09mq6DwwHqd1gChwD
         qW+w==
X-Gm-Message-State: ABy/qLbCST5sgl9UlpXx1hhWuhj2xiIoI0Lca8/3/pATepdY2YMPetx7
        4iLQ2kFu8b4AfxP3wEf6ck412Q==
X-Google-Smtp-Source: APBJJlF3WkEbRRR9gTWmIaq5El2jlzM9pGhayk4YtU6NIiU4+Fk9kbGI6fRUQkRmlf3TAy8N8NPqjQ==
X-Received: by 2002:a17:90a:6709:b0:24e:4b1c:74d2 with SMTP id n9-20020a17090a670900b0024e4b1c74d2mr113588pjj.32.1689795272577;
        Wed, 19 Jul 2023 12:34:32 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a031700b00264040322desm1591053pje.40.2023.07.19.12.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:34:32 -0700 (PDT)
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
Subject: [PATCH 07/11] RISC-V: drivers/iommu/riscv: Add device context support
Date:   Wed, 19 Jul 2023 12:33:51 -0700
Message-Id: <702670f5be2b641a231f2dda84be12024afd2002.1689792825.git.tjeznach@rivosinc.com>
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

Introduces per device translation context, with 1,2 or 3 tree level
device tree structures.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/iommu.c | 163 ++++++++++++++++++++++++++++++++++--
 drivers/iommu/riscv/iommu.h |   1 +
 2 files changed, 158 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 5c4cf9875302..9ee7d2b222b5 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -41,7 +41,7 @@ MODULE_ALIAS("riscv-iommu");
 MODULE_LICENSE("GPL v2");
 
 /* Global IOMMU params. */
-static int ddt_mode = RISCV_IOMMU_DDTP_MODE_BARE;
+static int ddt_mode = RISCV_IOMMU_DDTP_MODE_3LVL;
 module_param(ddt_mode, int, 0644);
 MODULE_PARM_DESC(ddt_mode, "Device Directory Table mode.");
 
@@ -452,6 +452,14 @@ static bool riscv_iommu_post(struct riscv_iommu_device *iommu,
 	return riscv_iommu_post_sync(iommu, cmd, false);
 }
 
+static bool riscv_iommu_iodir_inv_devid(struct riscv_iommu_device *iommu, unsigned devid)
+{
+	struct riscv_iommu_command cmd;
+	riscv_iommu_cmd_iodir_inval_ddt(&cmd);
+	riscv_iommu_cmd_iodir_set_did(&cmd, devid);
+	return riscv_iommu_post(iommu, &cmd);
+}
+
 static bool riscv_iommu_iofence_sync(struct riscv_iommu_device *iommu)
 {
 	struct riscv_iommu_command cmd;
@@ -671,6 +679,94 @@ static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
 	return false;
 }
 
+/* TODO: implement proper device context management, e.g. teardown flow */
+
+/* Lookup or initialize device directory info structure. */
+static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
+						 unsigned devid)
+{
+	const bool base_format = !(iommu->cap & RISCV_IOMMU_CAP_MSI_FLAT);
+	unsigned depth = iommu->ddt_mode - RISCV_IOMMU_DDTP_MODE_1LVL;
+	u8 ddi_bits[3] = { 0 };
+	u64 *ddtp = NULL, ddt;
+
+	if (iommu->ddt_mode == RISCV_IOMMU_DDTP_MODE_OFF ||
+	    iommu->ddt_mode == RISCV_IOMMU_DDTP_MODE_BARE)
+		return NULL;
+
+	/* Make sure the mode is valid */
+	if (iommu->ddt_mode > RISCV_IOMMU_DDTP_MODE_MAX)
+		return NULL;
+
+	/*
+	 * Device id partitioning for base format:
+	 * DDI[0]: bits 0 - 6   (1st level) (7 bits)
+	 * DDI[1]: bits 7 - 15  (2nd level) (9 bits)
+	 * DDI[2]: bits 16 - 23 (3rd level) (8 bits)
+	 *
+	 * For extended format:
+	 * DDI[0]: bits 0 - 5   (1st level) (6 bits)
+	 * DDI[1]: bits 6 - 14  (2nd level) (9 bits)
+	 * DDI[2]: bits 15 - 23 (3rd level) (9 bits)
+	 */
+	if (base_format) {
+		ddi_bits[0] = 7;
+		ddi_bits[1] = 7 + 9;
+		ddi_bits[2] = 7 + 9 + 8;
+	} else {
+		ddi_bits[0] = 6;
+		ddi_bits[1] = 6 + 9;
+		ddi_bits[2] = 6 + 9 + 9;
+	}
+
+	/* Make sure device id is within range */
+	if (devid >= (1 << ddi_bits[depth]))
+		return NULL;
+
+	/* Get to the level of the non-leaf node that holds the device context */
+	for (ddtp = (u64 *) iommu->ddtp; depth-- > 0;) {
+		const int split = ddi_bits[depth];
+		/*
+		 * Each non-leaf node is 64bits wide and on each level
+		 * nodes are indexed by DDI[depth].
+		 */
+		ddtp += (devid >> split) & 0x1FF;
+
+ retry:
+		/*
+		 * Check if this node has been populated and if not
+		 * allocate a new level and populate it.
+		 */
+		ddt = READ_ONCE(*ddtp);
+		if (ddt & RISCV_IOMMU_DDTE_VALID) {
+			ddtp = __va(ppn_to_phys(ddt));
+		} else {
+			u64 old, new = get_zeroed_page(GFP_KERNEL);
+			if (!new)
+				return NULL;
+
+			old = cmpxchg64_relaxed(ddtp, ddt,
+						phys_to_ppn(__pa(new)) |
+						RISCV_IOMMU_DDTE_VALID);
+
+			if (old != ddt) {
+				free_page(new);
+				goto retry;
+			}
+
+			ddtp = (u64 *) new;
+		}
+	}
+
+	/*
+	 * Grab the node that matches DDI[depth], note that when using base
+	 * format the device context is 4 * 64bits, and the extended format
+	 * is 8 * 64bits, hence the (3 - base_format) below.
+	 */
+	ddtp += (devid & ((64 << base_format) - 1)) << (3 - base_format);
+	return (struct riscv_iommu_dc *)ddtp;
+}
+
 static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 {
 	struct riscv_iommu_device *iommu;
@@ -708,6 +804,9 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 	ep->iommu = iommu;
 	ep->dev = dev;
 
+	/* Initial DC pointer can be NULL if IOMMU is configured in OFF or BARE mode */
+	ep->dc = riscv_iommu_get_dc(iommu, ep->devid);
+
 	dev_info(iommu->dev, "adding device to iommu with devid %i in domain %i\n",
 		ep->devid, ep->domid);
 
@@ -734,6 +833,16 @@ static void riscv_iommu_release_device(struct device *dev)
 	list_del(&ep->domain);
 	mutex_unlock(&ep->lock);
 
+	if (ep->dc) {
+		// this should be already done by domain detach.
+		ep->dc->tc = 0ULL;
+		wmb();
+		ep->dc->fsc = 0ULL;
+		ep->dc->iohgatp = 0ULL;
+		wmb();
+		riscv_iommu_iodir_inv_devid(iommu, ep->devid);
+	}
+
 	/* Remove endpoint from IOMMU tracking structures */
 	mutex_lock(&iommu->eps_mutex);
 	rb_erase(&ep->node, &iommu->eps);
@@ -853,11 +962,21 @@ static int riscv_iommu_domain_finalize(struct riscv_iommu_domain *domain,
 	return 0;
 }
 
+static u64 riscv_iommu_domain_atp(struct riscv_iommu_domain *domain)
+{
+	u64 atp = FIELD_PREP(RISCV_IOMMU_DC_FSC_MODE, domain->mode);
+	if (domain->mode != RISCV_IOMMU_DC_FSC_MODE_BARE)
+		atp |= FIELD_PREP(RISCV_IOMMU_DC_FSC_PPN, virt_to_pfn(domain->pgd_root));
+	return atp;
+}
+
 static int riscv_iommu_attach_dev(struct iommu_domain *iommu_domain, struct device *dev)
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	struct riscv_iommu_endpoint *ep = dev_iommu_priv_get(dev);
+	struct riscv_iommu_dc *dc = ep->dc;
 	int ret;
+	u64 val;
 
 	/* PSCID not valid */
 	if ((int)domain->pscid < 0)
@@ -880,17 +999,44 @@ static int riscv_iommu_attach_dev(struct iommu_domain *iommu_domain, struct devi
 		return ret;
 	}
 
-	if (ep->iommu->ddt_mode != RISCV_IOMMU_DDTP_MODE_BARE ||
-	    domain->domain.type != IOMMU_DOMAIN_IDENTITY) {
-		dev_warn(dev, "domain type %d not supported\n",
-		    domain->domain.type);
+	if (ep->iommu->ddt_mode == RISCV_IOMMU_DDTP_MODE_BARE &&
+	    domain->domain.type == IOMMU_DOMAIN_IDENTITY) {
+		dev_info(dev, "domain type %d attached w/ PSCID %u\n",
+		    domain->domain.type, domain->pscid);
+		return 0;
+	}
+
+	if (!dc) {
 		return -ENODEV;
 	}
 
+	/*
+	 * S-Stage translation table. G-Stage remains unmodified (BARE).
+	 */
+	val = FIELD_PREP(RISCV_IOMMU_DC_TA_PSCID, domain->pscid);
+
+	dc->ta = cpu_to_le64(val);
+	dc->fsc = cpu_to_le64(riscv_iommu_domain_atp(domain));
+
+	wmb();
+
+	/* Mark device context as valid, synchronise device context cache. */
+	val = RISCV_IOMMU_DC_TC_V;
+
+	if (ep->iommu->cap & RISCV_IOMMU_CAP_AMO) {
+		val |= RISCV_IOMMU_DC_TC_GADE |
+		       RISCV_IOMMU_DC_TC_SADE;
+	}
+
+	dc->tc = cpu_to_le64(val);
+	wmb();
+
 	list_add_tail(&ep->domain, &domain->endpoints);
 	mutex_unlock(&ep->lock);
 	mutex_unlock(&domain->lock);
 
+	riscv_iommu_iodir_inv_devid(ep->iommu, ep->devid);
+
 	dev_info(dev, "domain type %d attached w/ PSCID %u\n",
 	    domain->domain.type, domain->pscid);
 
@@ -1239,7 +1385,12 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto fail;
 
  no_ats:
-	ret = riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_BARE);
+	if (iommu_default_passthrough()) {
+		dev_info(dev, "iommu set to passthrough mode\n");
+		ret = riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_BARE);
+	} else {
+		ret = riscv_iommu_enable(iommu, ddt_mode);
+	}
 
 	if (ret) {
 		dev_err(dev, "cannot enable iommu device (%d)\n", ret);
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 04148a2a8ffd..9140df71e17b 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -105,6 +105,7 @@ struct riscv_iommu_endpoint {
 	unsigned devid;      			/* PCI bus:device:function number */
 	unsigned domid;    			/* PCI domain number, segment */
 	struct rb_node node;    		/* device tracking node (lookup by devid) */
+	struct riscv_iommu_dc *dc;		/* device context pointer */
 	struct riscv_iommu_device *iommu;	/* parent iommu device */
 
 	struct mutex lock;
-- 
2.34.1

