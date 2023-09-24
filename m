Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AB77AC83E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjIXNPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjIXNPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:15:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E1CFC;
        Sun, 24 Sep 2023 06:15:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90634C433C7;
        Sun, 24 Sep 2023 13:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561339;
        bh=tm2NoLEv0x00eR3afWdHg3ugbeApHHZnkk2tJKl3Rrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AtlQXxAQ803LxpB+eMyqm53lPIloHstOqyxh1PQbbt+wmQJ7enZvkZYW+EQVt7e5p
         Nm3CCAWC4NNkcq7ZZCph6mi2sXFWu8vXWrM7RCdlwgChpwOdz4U6X9UWZa65wSrM7w
         9yD2h87QF7VmRIC1sYLVkLuTlL0/TM/ZOwLGL1scoQSReFuDmOf57kgVsdAIJFIXAz
         oVPNjR56wM5CgR3uvGTVMGN5X78XyAzUneezA/AEuY8qRkSGbOYtqQ+22vIAn8vqk9
         toJk3PS5dq+YWe9eASRa+iGvkTNWyu74c8VoGgdGYiQQNxUtflqB4Tyo8VpVdwh/Hf
         V5mf7xavtMfDA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com, linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 03/41] parisc: sba-iommu: Fix sparse warnigs
Date:   Sun, 24 Sep 2023 09:14:51 -0400
Message-Id: <20230924131529.1275335-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

[ Upstream commit c1ebb94071cb4455177bafa619423acb3494d15d ]

Fix sparse warnings, as pdir is __le64 *.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/include/asm/ropes.h |  4 ++--
 drivers/parisc/iommu-helpers.h  |  4 ++--
 drivers/parisc/sba_iommu.c      | 28 ++++++++++++++--------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/parisc/include/asm/ropes.h b/arch/parisc/include/asm/ropes.h
index 62399c7ea94a1..c46ad399a74f2 100644
--- a/arch/parisc/include/asm/ropes.h
+++ b/arch/parisc/include/asm/ropes.h
@@ -29,7 +29,7 @@
 struct ioc {
 	void __iomem	*ioc_hpa;	/* I/O MMU base address */
 	char		*res_map;	/* resource map, bit == pdir entry */
-	u64		*pdir_base;	/* physical base address */
+	__le64		*pdir_base;	/* physical base address */
 	unsigned long	ibase;		/* pdir IOV Space base - shared w/lba_pci */
 	unsigned long	imask;		/* pdir IOV Space mask - shared w/lba_pci */
 #ifdef ZX1_SUPPORT
@@ -113,7 +113,7 @@ static inline int IS_PLUTO(struct parisc_device *d) {
 
 #define SBA_PDIR_VALID_BIT	0x8000000000000000ULL
 
-#define SBA_AGPGART_COOKIE	0x0000badbadc0ffeeULL
+#define SBA_AGPGART_COOKIE	(__force __le64) 0x0000badbadc0ffeeULL
 
 #define SBA_FUNC_ID	0x0000	/* function id */
 #define SBA_FCLASS	0x0008	/* function class, bist, header, rev... */
diff --git a/drivers/parisc/iommu-helpers.h b/drivers/parisc/iommu-helpers.h
index 0905be256de08..a00c38b6224ab 100644
--- a/drivers/parisc/iommu-helpers.h
+++ b/drivers/parisc/iommu-helpers.h
@@ -14,13 +14,13 @@
 static inline unsigned int
 iommu_fill_pdir(struct ioc *ioc, struct scatterlist *startsg, int nents, 
 		unsigned long hint,
-		void (*iommu_io_pdir_entry)(u64 *, space_t, unsigned long,
+		void (*iommu_io_pdir_entry)(__le64 *, space_t, unsigned long,
 					    unsigned long))
 {
 	struct scatterlist *dma_sg = startsg;	/* pointer to current DMA */
 	unsigned int n_mappings = 0;
 	unsigned long dma_offset = 0, dma_len = 0;
-	u64 *pdirp = NULL;
+	__le64 *pdirp = NULL;
 
 	/* Horrible hack.  For efficiency's sake, dma_sg starts one 
 	 * entry below the true start (it is immediately incremented
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index b8e91cbb60567..780ea219cd8d4 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -202,7 +202,7 @@ static void
 sba_dump_pdir_entry(struct ioc *ioc, char *msg, uint pide)
 {
 	/* start printing from lowest pde in rval */
-	u64 *ptr = &(ioc->pdir_base[pide & (~0U * BITS_PER_LONG)]);
+	__le64 *ptr = &(ioc->pdir_base[pide & (~0U * BITS_PER_LONG)]);
 	unsigned long *rptr = (unsigned long *) &(ioc->res_map[(pide >>3) & ~(sizeof(unsigned long) - 1)]);
 	uint rcnt;
 
@@ -569,7 +569,7 @@ typedef unsigned long space_t;
  */
 
 static void
-sba_io_pdir_entry(u64 *pdir_ptr, space_t sid, unsigned long vba,
+sba_io_pdir_entry(__le64 *pdir_ptr, space_t sid, unsigned long vba,
 		  unsigned long hint)
 {
 	u64 pa; /* physical address */
@@ -613,7 +613,7 @@ static void
 sba_mark_invalid(struct ioc *ioc, dma_addr_t iova, size_t byte_cnt)
 {
 	u32 iovp = (u32) SBA_IOVP(ioc,iova);
-	u64 *pdir_ptr = &ioc->pdir_base[PDIR_INDEX(iovp)];
+	__le64 *pdir_ptr = &ioc->pdir_base[PDIR_INDEX(iovp)];
 
 #ifdef ASSERT_PDIR_SANITY
 	/* Assert first pdir entry is set.
@@ -714,7 +714,7 @@ sba_map_single(struct device *dev, void *addr, size_t size,
 	unsigned long flags; 
 	dma_addr_t iovp;
 	dma_addr_t offset;
-	u64 *pdir_start;
+	__le64 *pdir_start;
 	int pide;
 
 	ioc = GET_IOC(dev);
@@ -1432,7 +1432,7 @@ sba_ioc_init(struct parisc_device *sba, struct ioc *ioc, int ioc_num)
 
 	ioc->pdir_size = pdir_size = (iova_space_size/IOVP_SIZE) * sizeof(u64);
 
-	DBG_INIT("%s() hpa 0x%lx mem %ldMB IOV %dMB (%d bits)\n",
+	DBG_INIT("%s() hpa %px mem %ldMB IOV %dMB (%d bits)\n",
 			__func__,
 			ioc->ioc_hpa,
 			(unsigned long) totalram_pages() >> (20 - PAGE_SHIFT),
@@ -1469,7 +1469,7 @@ sba_ioc_init(struct parisc_device *sba, struct ioc *ioc, int ioc_num)
 	ioc->iovp_mask = ~(iova_space_mask + PAGE_SIZE - 1);
 #endif
 
-	DBG_INIT("%s() IOV base 0x%lx mask 0x%0lx\n",
+	DBG_INIT("%s() IOV base %#lx mask %#0lx\n",
 		__func__, ioc->ibase, ioc->imask);
 
 	/*
@@ -1581,7 +1581,7 @@ printk("sba_hw_init(): mem_boot 0x%x 0x%x 0x%x 0x%x\n", PAGE0->mem_boot.hpa,
 
 	if (!IS_PLUTO(sba_dev->dev)) {
 		ioc_ctl = READ_REG(sba_dev->sba_hpa+IOC_CTRL);
-		DBG_INIT("%s() hpa 0x%lx ioc_ctl 0x%Lx ->",
+		DBG_INIT("%s() hpa %px ioc_ctl 0x%Lx ->",
 			__func__, sba_dev->sba_hpa, ioc_ctl);
 		ioc_ctl &= ~(IOC_CTRL_RM | IOC_CTRL_NC | IOC_CTRL_CE);
 		ioc_ctl |= IOC_CTRL_DD | IOC_CTRL_D4 | IOC_CTRL_TC;
@@ -1666,14 +1666,14 @@ printk("sba_hw_init(): mem_boot 0x%x 0x%x 0x%x 0x%x\n", PAGE0->mem_boot.hpa,
 		/* flush out the last writes */
 		READ_REG(sba_dev->ioc[i].ioc_hpa + ROPE7_CTL);
 
-		DBG_INIT("	ioc[%d] ROPE_CFG 0x%Lx  ROPE_DBG 0x%Lx\n",
+		DBG_INIT("	ioc[%d] ROPE_CFG %#lx  ROPE_DBG %lx\n",
 				i,
-				READ_REG(sba_dev->ioc[i].ioc_hpa + 0x40),
-				READ_REG(sba_dev->ioc[i].ioc_hpa + 0x50)
+				(unsigned long) READ_REG(sba_dev->ioc[i].ioc_hpa + 0x40),
+				(unsigned long) READ_REG(sba_dev->ioc[i].ioc_hpa + 0x50)
 			);
-		DBG_INIT("	STATUS_CONTROL 0x%Lx  FLUSH_CTRL 0x%Lx\n",
-				READ_REG(sba_dev->ioc[i].ioc_hpa + 0x108),
-				READ_REG(sba_dev->ioc[i].ioc_hpa + 0x400)
+		DBG_INIT("	STATUS_CONTROL %#lx  FLUSH_CTRL %#lx\n",
+				(unsigned long) READ_REG(sba_dev->ioc[i].ioc_hpa + 0x108),
+				(unsigned long) READ_REG(sba_dev->ioc[i].ioc_hpa + 0x400)
 			);
 
 		if (IS_PLUTO(sba_dev->dev)) {
@@ -1737,7 +1737,7 @@ sba_common_init(struct sba_device *sba_dev)
 #ifdef ASSERT_PDIR_SANITY
 		/* Mark first bit busy - ie no IOVA 0 */
 		sba_dev->ioc[i].res_map[0] = 0x80;
-		sba_dev->ioc[i].pdir_base[0] = 0xeeffc0addbba0080ULL;
+		sba_dev->ioc[i].pdir_base[0] = (__force __le64) 0xeeffc0addbba0080ULL;
 #endif
 
 		/* Third (and last) part of PIRANHA BUG */
-- 
2.40.1

