Return-Path: <linux-kernel+bounces-164687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933C38B8110
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FBC4B24667
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74C71C2304;
	Tue, 30 Apr 2024 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ROZwm6Cw"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E506E1C0DC1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507375; cv=none; b=TSbrWiLl+sKR4AE0yize078hkKRJyGZF9USRaU1TRh5DAWpPsEplwXeOGNSlcq1MZ8U596ZFxiS5KT4TRPDlVgbYnEGKljbRhEU0OvTifQT0b29FjJ9B75qWN51zYpvqJVkjZ3FEPU5REydgOWbTkpkVypVjRHeAJ2G3UVj9RYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507375; c=relaxed/simple;
	bh=6tGvDmG/xNLi12bpHrqDJ+NqHpsPIabBuN8WlgNAqrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhSZiux/dL0rDwpIQ7hRswxAHEJMzP4p6hJ5vlIvewgnFfMJC4OLlYoO2W+7rs8fK/tzt00xXtQH66eLTk8pyPaH2d91qbIDg31l6NPdU7qxJbXN1lF2ip6JvhY/c091T4EhYZGl96ZZ0mdSqRwvddH55l1zxDXiW2oTVpK15ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ROZwm6Cw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1eac92f7c74so49551715ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714507371; x=1715112171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQiYsbLAu4NtV3ntj83w1BVBTNO++5/Arz7ySXN+kco=;
        b=ROZwm6CwSX8PYrMrJeJdUj0QMqJAeYr3XWfcltkRnMJyOjUM9rqHVfJlKW+XRPvrsQ
         MYvs3CCS3fJAwj1GXKIweEERFjxf7zA53TSQY/7QM8JZU2mwvWvggz9dOZ52pygP61cE
         qufCoxAwxwX0ZvC1rWtNrO0I2kLV/fOY5gjx4enZdvM0xG954ZVpwUzBDbxxIlN4nJIG
         Eq8mGqtD366XGRHFrW5ikzzqGLbwTyDBuFgJREZDI65nMCu9NdEBxTA3ZZQ7ZmeT3As7
         5I6ITyadGrMIs0A2lost2q0pY1lsG0u1nWUiDSmrXU3eN3Nh6bAvMCFlL84x4U+Xy+5Q
         kUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714507371; x=1715112171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQiYsbLAu4NtV3ntj83w1BVBTNO++5/Arz7ySXN+kco=;
        b=rPgdH+Br+ThTqUdtmR9hyG5WikEkCoxqikVc0bW/FDAfzABNjBKkzYoR9KdRqB65X+
         +2k7vc8eWlqiL0aBo/z121MUqaDCSdMLZDIZjjHHjO28RIeEphRDTaS14O5EtnxpBeBj
         I3Zov2rD8UcAzcI+967nyJzaM+bKZNG3sEQ2eN9orzMwbXwsFwGwUDlZ6bjJJxreOMdo
         Z7V2KR0rcJnG6k+upotPmIlV78MAg9Uugdr5ToHZlU71K+XT2j8gBBQmLbRigPy7JnuD
         vCv0lTTr8BoZdPN2pesaH454meOEnoOJNAmVaOxlfpf0XFWffjcN7wGVuimXL6ZvN4BB
         CF+w==
X-Forwarded-Encrypted: i=1; AJvYcCWV70OzY6Ccu0Y+IIxl/rDAC2jR+YqMTXmOhQBlTC5sCbne0fvCys95m/XAMFOp9+1fFInXV7z36XNIBIJVAM90MlnnfpIItBCA4ljh
X-Gm-Message-State: AOJu0YxEer8r7wxoxhYBqqZH1Z7cOHurro/iClfZTMGpRy3QmSCY158i
	66xv2zhtFev9cL9CZu0pmzJZE1bJD/9eVk7sc6aKDv8lvmiah/e8u4CXpXhWP88=
X-Google-Smtp-Source: AGHT+IHRdfuijlkb24LOcuYPQCdtd3lSMub9MmPeIFknwDCjKMPmmdiEcBJwMD6uS+y5DV97RZqd/g==
X-Received: by 2002:a17:902:f547:b0:1e4:3386:349f with SMTP id h7-20020a170902f54700b001e43386349fmr492958plf.51.1714507371126;
        Tue, 30 Apr 2024 13:02:51 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709027b9300b001e435fa2521sm22809820pll.249.2024.04.30.13.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 13:02:50 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	Tomasz Jeznach <tjeznach@rivosinc.com>
Subject: [PATCH v3 7/7] iommu/riscv: Paging domain support
Date: Tue, 30 Apr 2024 13:01:57 -0700
Message-Id: <b83f81c04d1f3885d860b1eec03761fe63a33183.1714494653.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714494653.git.tjeznach@rivosinc.com>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce first-stage address translation support.

Page table configured by the IOMMU driver will use the same format
as the CPU’s MMU, and will fallback to identity translation if the
page table format configured for the MMU is not supported by the
IOMMU hardware.

This change introduces IOTINVAL.VMA command, required to invalidate
any cached IOATC entries after mapping is updated and/or removed from
the paging domain.  Invalidations for the non-leaf page entries use
IOTINVAL for all addresses assigned to the protection domain for
hardware not supporting more granular non-leaf page table cache
invalidations.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/iommu.c | 544 +++++++++++++++++++++++++++++++++++-
 1 file changed, 541 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 98c325cb0591..60b146adfcbb 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -40,6 +40,10 @@
 
 #define dev_to_iommu(dev) iommu_get_iommu_dev(dev, struct riscv_iommu_device, iommu)
 
+/* IOMMU PSCID allocation namespace. */
+static DEFINE_IDA(riscv_iommu_pscids);
+#define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
+
 /* Device resource-managed allocations */
 struct riscv_iommu_devres {
 	void *addr;
@@ -747,6 +751,136 @@ static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
 	return 0;
 }
 
+/* This struct contains protection domain specific IOMMU driver data. */
+struct riscv_iommu_domain {
+	struct iommu_domain domain;
+	struct list_head bonds;
+	spinlock_t lock;		/* protect bonds list updates. */
+	int pscid;
+	int numa_node;
+	int amo_enabled:1;
+	unsigned int pgd_mode;
+	unsigned long *pgd_root;
+};
+
+#define iommu_domain_to_riscv(iommu_domain) \
+	container_of(iommu_domain, struct riscv_iommu_domain, domain)
+
+#define dev_to_domain(dev) \
+	iommu_domain_to_riscv(dev_iommu_priv_get(dev))
+
+/* Linkage between an iommu_domain and attached devices. */
+struct riscv_iommu_bond {
+	struct list_head list;
+	struct rcu_head rcu;
+	struct device *dev;
+};
+
+static int riscv_iommu_bond_link(struct riscv_iommu_domain *domain, struct device *dev)
+{
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_bond *bond;
+	struct list_head *bonds;
+	unsigned long flags;
+
+	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
+	if (!bond)
+		return -ENOMEM;
+	bond->dev = dev;
+
+	/* List od devices attached to the domain are arranged based on managed IOMMU device */
+	spin_lock_irqsave(&domain->lock, flags);
+	list_for_each_rcu(bonds, &domain->bonds)
+		if (dev_to_iommu(list_entry(bonds, struct riscv_iommu_bond, list)->dev) == iommu)
+			break;
+	list_add_rcu(&bond->list, bonds);
+	spin_unlock_irqrestore(&domain->lock, flags);
+
+	return 0;
+}
+
+static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain, struct device *dev)
+{
+	struct riscv_iommu_bond *bond, *found = NULL;
+	unsigned long flags;
+
+	if (!domain)
+		return;
+
+	spin_lock_irqsave(&domain->lock, flags);
+	list_for_each_entry_rcu(bond, &domain->bonds, list) {
+		if (bond->dev == dev) {
+			list_del_rcu(&bond->list);
+			found = bond;
+		}
+	}
+	spin_unlock_irqrestore(&domain->lock, flags);
+
+	/* Release and wait for all read-rcu critical sections have completed. */
+	kfree_rcu(found, rcu);
+	synchronize_rcu();
+}
+
+/*
+ * Send IOTLB.INVAL for whole address space for ranges larger than 2MB.
+ * This limit will be replaced with range invalidations, if supported by
+ * the hardware, when RISC-V IOMMU architecture specification update for
+ * range invalidations update will be available.
+ */
+#define RISCV_IOMMU_IOTLB_INVAL_LIMIT	(2 << 20)
+
+static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
+				    unsigned long start, unsigned long end)
+{
+	struct riscv_iommu_bond *bond;
+	struct riscv_iommu_device *iommu, *prev;
+	struct riscv_iommu_command cmd;
+	unsigned long len = end - start + 1;
+	unsigned long iova;
+
+	rcu_read_lock();
+
+	prev = NULL;
+	list_for_each_entry_rcu(bond, &domain->bonds, list) {
+		iommu = dev_to_iommu(bond->dev);
+
+		riscv_iommu_cmd_inval_vma(&cmd);
+		riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
+		if (len && len >= RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
+			for (iova = start; iova < end; iova += PAGE_SIZE) {
+				riscv_iommu_cmd_inval_set_addr(&cmd, iova);
+				riscv_iommu_cmd_send(iommu, &cmd, 0);
+			}
+		} else {
+			riscv_iommu_cmd_send(iommu, &cmd, 0);
+		}
+
+		/*
+		 * IOTLB invalidation request can be safely omitted if already sent
+		 * to the IOMMU for the same PSCID, and with domain->bonds list
+		 * arranged based on the device's IOMMU, it's sufficient to check
+		 * last device the invalidation was sent to.
+		 */
+		if (iommu == prev)
+			continue;
+
+		prev = iommu;
+		riscv_iommu_cmd_send(iommu, &cmd, 0);
+	}
+
+	prev = NULL;
+	list_for_each_entry_rcu(bond, &domain->bonds, list) {
+		iommu = dev_to_iommu(bond->dev);
+		if (iommu == prev)
+			continue;
+
+		prev = iommu;
+		riscv_iommu_cmd_iofence(&cmd);
+		riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIMEOUT);
+	}
+	rcu_read_unlock();
+}
+
 #define RISCV_IOMMU_FSC_BARE 0
 
 /*
@@ -766,10 +900,29 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct riscv_iommu_dc *dc;
+	struct riscv_iommu_command cmd;
+	bool sync_required = false;
 	u64 tc;
 	int i;
 
-	/* Device context invalidation ignored for now. */
+	for (i = 0; i < fwspec->num_ids; i++) {
+		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
+		tc = READ_ONCE(dc->tc);
+		if (tc & RISCV_IOMMU_DC_TC_V) {
+			WRITE_ONCE(dc->tc, tc & ~RISCV_IOMMU_DC_TC_V);
+
+			/* Invalidate device context cached values */
+			riscv_iommu_cmd_iodir_inval_ddt(&cmd);
+			riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
+			riscv_iommu_cmd_send(iommu, &cmd, 0);
+			sync_required = true;
+		}
+	}
+
+	if (sync_required) {
+		riscv_iommu_cmd_iofence(&cmd);
+		riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_IOTINVAL_TIMEOUT);
+	}
 
 	/*
 	 * For device context with DC_TC_PDTV = 0, translation attributes valid bit
@@ -787,13 +940,389 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 	}
 }
 
+/*
+ * IOVA page translation tree management.
+ */
+
+#define IOMMU_PAGE_SIZE_4K     BIT_ULL(12)
+#define IOMMU_PAGE_SIZE_2M     BIT_ULL(21)
+#define IOMMU_PAGE_SIZE_1G     BIT_ULL(30)
+#define IOMMU_PAGE_SIZE_512G   BIT_ULL(39)
+
+#define PT_SHIFT (PAGE_SHIFT - ilog2(sizeof(pte_t)))
+
+static void riscv_iommu_iotlb_flush_all(struct iommu_domain *iommu_domain)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+
+	riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
+}
+
+static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
+				   struct iommu_iotlb_gather *gather)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+
+	riscv_iommu_iotlb_inval(domain, gather->start, gather->end);
+}
+
+static inline size_t get_page_size(size_t size)
+{
+	if (size >= IOMMU_PAGE_SIZE_512G)
+		return IOMMU_PAGE_SIZE_512G;
+	if (size >= IOMMU_PAGE_SIZE_1G)
+		return IOMMU_PAGE_SIZE_1G;
+	if (size >= IOMMU_PAGE_SIZE_2M)
+		return IOMMU_PAGE_SIZE_2M;
+	return IOMMU_PAGE_SIZE_4K;
+}
+
+#define _io_pte_present(pte)	((pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE))
+#define _io_pte_leaf(pte)	((pte) & _PAGE_LEAF)
+#define _io_pte_none(pte)	((pte) == 0)
+#define _io_pte_entry(pn, prot)	((_PAGE_PFN_MASK & ((pn) << _PAGE_PFN_SHIFT)) | (prot))
+
+static void riscv_iommu_pte_free(struct riscv_iommu_domain *domain,
+				 unsigned long pte, struct list_head *freelist)
+{
+	unsigned long *ptr;
+	int i;
+
+	if (!_io_pte_present(pte) || _io_pte_leaf(pte))
+		return;
+
+	ptr = (unsigned long *)pfn_to_virt(__page_val_to_pfn(pte));
+
+	/* Recursively free all sub page table pages */
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		pte = READ_ONCE(ptr[i]);
+		if (!_io_pte_none(pte) && cmpxchg_relaxed(ptr + i, pte, 0) == pte)
+			riscv_iommu_pte_free(domain, pte, freelist);
+	}
+
+	if (freelist)
+		list_add_tail(&virt_to_page(ptr)->lru, freelist);
+	else
+		iommu_free_page(ptr);
+}
+
+static unsigned long *riscv_iommu_pte_alloc(struct riscv_iommu_domain *domain,
+					    unsigned long iova, size_t pgsize, gfp_t gfp)
+{
+	unsigned long *ptr = domain->pgd_root;
+	unsigned long pte, old;
+	int level = domain->pgd_mode - RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39 + 2;
+	void *addr;
+
+	do {
+		const int shift = PAGE_SHIFT + PT_SHIFT * level;
+
+		ptr += ((iova >> shift) & (PTRS_PER_PTE - 1));
+		/*
+		 * Note: returned entry might be a non-leaf if there was existing mapping
+		 * with smaller granularity. Up to the caller to replace and invalidate.
+		 */
+		if (((size_t)1 << shift) == pgsize)
+			return ptr;
+pte_retry:
+		pte = READ_ONCE(*ptr);
+		/*
+		 * This is very likely incorrect as we should not be adding new mapping
+		 * with smaller granularity on top of existing 2M/1G mapping. Fail.
+		 */
+		if (_io_pte_present(pte) && _io_pte_leaf(pte))
+			return NULL;
+		/*
+		 * Non-leaf entry is missing, allocate and try to add to the page table.
+		 * This might race with other mappings, retry on error.
+		 */
+		if (_io_pte_none(pte)) {
+			addr = iommu_alloc_page_node(domain->numa_node, gfp);
+			if (!addr)
+				return NULL;
+			old = pte;
+			pte = _io_pte_entry(virt_to_pfn(addr), _PAGE_TABLE);
+			if (cmpxchg_relaxed(ptr, old, pte) != old) {
+				iommu_free_page(addr);
+				goto pte_retry;
+			}
+		}
+		ptr = (unsigned long *)pfn_to_virt(__page_val_to_pfn(pte));
+	} while (level-- > 0);
+
+	return NULL;
+}
+
+static unsigned long *riscv_iommu_pte_fetch(struct riscv_iommu_domain *domain,
+					    unsigned long iova, size_t *pte_pgsize)
+{
+	unsigned long *ptr = domain->pgd_root;
+	unsigned long pte;
+	int level = domain->pgd_mode - RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39 + 2;
+
+	do {
+		const int shift = PAGE_SHIFT + PT_SHIFT * level;
+
+		ptr += ((iova >> shift) & (PTRS_PER_PTE - 1));
+		pte = READ_ONCE(*ptr);
+		if (_io_pte_present(pte) && _io_pte_leaf(pte)) {
+			*pte_pgsize = (size_t)1 << shift;
+			return ptr;
+		}
+		if (_io_pte_none(pte))
+			return NULL;
+		ptr = (unsigned long *)pfn_to_virt(__page_val_to_pfn(pte));
+	} while (level-- > 0);
+
+	return NULL;
+}
+
+static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
+				 unsigned long iova, phys_addr_t phys,
+				 size_t pgsize, size_t pgcount, int prot,
+				 gfp_t gfp, size_t *mapped)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	size_t size = 0;
+	size_t page_size = get_page_size(pgsize);
+	unsigned long *ptr;
+	unsigned long pte, old, pte_prot;
+	int rc = 0;
+	LIST_HEAD(freelist);
+
+	if (!(prot & IOMMU_WRITE))
+		pte_prot = _PAGE_BASE | _PAGE_READ;
+	else if (domain->amo_enabled)
+		pte_prot = _PAGE_BASE | _PAGE_READ | _PAGE_WRITE;
+	else
+		pte_prot = _PAGE_BASE | _PAGE_READ | _PAGE_WRITE | _PAGE_DIRTY;
+
+	while (pgcount) {
+		ptr = riscv_iommu_pte_alloc(domain, iova, page_size, gfp);
+		if (!ptr) {
+			rc = -ENOMEM;
+			break;
+		}
+
+		old = READ_ONCE(*ptr);
+		pte = _io_pte_entry(phys_to_pfn(phys), pte_prot);
+		if (cmpxchg_relaxed(ptr, old, pte) != old)
+			continue;
+
+		riscv_iommu_pte_free(domain, old, &freelist);
+
+		size += page_size;
+		iova += page_size;
+		phys += page_size;
+		--pgcount;
+	}
+
+	*mapped = size;
+
+	if (!list_empty(&freelist)) {
+		/*
+		 * In 1.0 spec version, the smallest scope we can use to invalidate
+		 * all levels of page table (i.e. leaf and non-leaf) is an
+		 * invalidate-all-PSCID IOTINVAL.VMA with AV=0. This will be updated
+		 * with hardware support for capability.NL (non-leaf) IOTINVAL command.
+		 */
+		riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
+		iommu_put_pages_list(&freelist);
+	}
+
+	return rc;
+}
+
+static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
+				      unsigned long iova, size_t pgsize, size_t pgcount,
+				      struct iommu_iotlb_gather *gather)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	size_t size = pgcount << __ffs(pgsize);
+	unsigned long *ptr, old;
+	size_t unmapped = 0;
+	size_t pte_size;
+
+	while (unmapped < size) {
+		ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
+		if (!ptr)
+			return unmapped;
+
+		/* partial unmap is not allowed, fail. */
+		if (iova & (pte_size - 1))
+			return unmapped;
+
+		old = READ_ONCE(*ptr);
+		if (cmpxchg_relaxed(ptr, old, 0) != old)
+			continue;
+
+		iommu_iotlb_gather_add_page(&domain->domain, gather, iova,
+					    pte_size);
+
+		iova += pte_size;
+		unmapped += pte_size;
+	}
+
+	return unmapped;
+}
+
+static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_domain, dma_addr_t iova)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	unsigned long pte_size;
+	unsigned long *ptr;
+
+	ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
+	if (_io_pte_none(*ptr) || !_io_pte_present(*ptr))
+		return 0;
+
+	return pfn_to_phys(__page_val_to_pfn(*ptr)) | (iova & (pte_size - 1));
+}
+
+static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	const unsigned long pfn = virt_to_pfn(domain->pgd_root);
+
+	WARN_ON(!list_empty(&domain->bonds));
+
+	if ((int)domain->pscid > 0)
+		ida_free(&riscv_iommu_pscids, domain->pscid);
+
+	riscv_iommu_pte_free(domain, _io_pte_entry(pfn, _PAGE_TABLE), NULL);
+	kfree(domain);
+}
+
+static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu, int pgd_mode)
+{
+	switch (pgd_mode) {
+	case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
+		return iommu->caps & RISCV_IOMMU_CAP_S_SV39;
+
+	case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48:
+		return iommu->caps & RISCV_IOMMU_CAP_S_SV48;
+
+	case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57:
+		return iommu->caps & RISCV_IOMMU_CAP_S_SV57;
+	}
+	return false;
+}
+
+static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
+					    struct device *dev)
+{
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	u64 fsc, ta;
+
+	if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
+		return -ENODEV;
+
+	if (domain->numa_node == NUMA_NO_NODE)
+		domain->numa_node = dev_to_node(iommu->dev);
+
+	if (riscv_iommu_bond_link(domain, dev))
+		return -ENOMEM;
+
+	/*
+	 * Invalidate PSCID.
+	 * This invalidation might be redundant if IOATC has been already cleared,
+	 * however we are not keeping track for domains not linked to a device.
+	 */
+	riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
+
+	fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
+	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
+	ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) | RISCV_IOMMU_PC_TA_V;
+
+	riscv_iommu_iodir_update(iommu, dev, fsc, ta);
+	riscv_iommu_bond_unlink(dev_to_domain(dev), dev);
+	dev_iommu_priv_set(dev, domain);
+
+	return 0;
+}
+
+static const struct iommu_domain_ops riscv_iommu_paging_domain_ops = {
+	.attach_dev = riscv_iommu_attach_paging_domain,
+	.free = riscv_iommu_free_paging_domain,
+	.map_pages = riscv_iommu_map_pages,
+	.unmap_pages = riscv_iommu_unmap_pages,
+	.iova_to_phys = riscv_iommu_iova_to_phys,
+	.iotlb_sync = riscv_iommu_iotlb_sync,
+	.flush_iotlb_all = riscv_iommu_iotlb_flush_all,
+};
+
+static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
+{
+	struct riscv_iommu_domain *domain;
+	struct riscv_iommu_device *iommu;
+
+	iommu = dev ? dev_to_iommu(dev) : NULL;
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD_RCU(&domain->bonds);
+	spin_lock_init(&domain->lock);
+	domain->numa_node = NUMA_NO_NODE;
+
+	/*
+	 * Follow system address translation mode.
+	 * RISC-V IOMMU ATP mode values match RISC-V CPU SATP mode values.
+	 */
+	domain->pgd_mode = satp_mode >> SATP_MODE_SHIFT;
+	if (iommu) {
+		if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode)) {
+			dev_err(dev, "unsupported page table mode %x\n", domain->pgd_mode);
+			kfree(domain);
+			return ERR_PTR(-ENODEV);
+		}
+		domain->numa_node = dev_to_node(iommu->dev);
+		domain->amo_enabled = !!(iommu->caps & RISCV_IOMMU_CAP_AMO_HWAD);
+	}
+
+	domain->pgd_root = iommu_alloc_page_node(domain->numa_node, GFP_KERNEL_ACCOUNT);
+	if (!domain->pgd_root) {
+		kfree(domain);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	domain->pscid = ida_alloc_range(&riscv_iommu_pscids, 1, RISCV_IOMMU_MAX_PSCID, GFP_KERNEL);
+	if (domain->pscid < 0) {
+		iommu_free_page(domain->pgd_root);
+		kfree(domain);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * Note: RISC-V Privilege spec mandates that virtual addresses
+	 * need to be sign-extended, so if (VA_BITS - 1) is set, all
+	 * bits >= VA_BITS need to also be set or else we'll get a
+	 * page fault. However the code that creates the mappings
+	 * above us (e.g. iommu_dma_alloc_iova()) won't do that for us
+	 * for now, so we'll end up with invalid virtual addresses
+	 * to map. As a workaround until we get this sorted out
+	 * limit the available virtual addresses to VA_BITS - 1.
+	 */
+	domain->domain.geometry.aperture_start = 0;
+	domain->domain.geometry.aperture_end = DMA_BIT_MASK(VA_BITS - 1);
+	domain->domain.geometry.force_aperture = true;
+
+	domain->domain.ops = &riscv_iommu_paging_domain_ops;
+
+	return &domain->domain;
+}
+
 static int riscv_iommu_attach_release_domain(struct iommu_domain *iommu_domain,
 					     struct device *dev)
 {
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 
-	if (iommu->ddt_mode > RISCV_IOMMU_DDTP_MODE_BARE)
+	if (iommu->ddt_mode > RISCV_IOMMU_DDTP_MODE_BARE) {
 		riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
+		riscv_iommu_bond_unlink(dev_to_domain(dev), dev);
+		dev_iommu_priv_set(dev, NULL);
+	}
 
 	return 0;
 }
@@ -815,6 +1344,8 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 		return 0;
 
 	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
+	riscv_iommu_bond_unlink(dev_to_domain(dev), dev);
+	dev_iommu_priv_set(dev, NULL);
 
 	return 0;
 }
@@ -828,7 +1359,12 @@ static struct iommu_domain riscv_iommu_identity_domain = {
 
 static int riscv_iommu_device_domain_type(struct device *dev)
 {
-	return IOMMU_DOMAIN_IDENTITY;
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+
+	if (iommu->ddt_mode == RISCV_IOMMU_DDTP_MODE_BARE)
+		return IOMMU_DOMAIN_IDENTITY;
+
+	return 0;
 }
 
 static struct iommu_group *riscv_iommu_device_group(struct device *dev)
@@ -880,9 +1416,11 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 }
 
 static const struct iommu_ops riscv_iommu_ops = {
+	.pgsize_bitmap = SZ_4K,
 	.of_xlate = riscv_iommu_of_xlate,
 	.identity_domain = &riscv_iommu_identity_domain,
 	.release_domain = &riscv_iommu_release_domain,
+	.domain_alloc_paging = riscv_iommu_alloc_paging_domain,
 	.def_domain_type = riscv_iommu_device_domain_type,
 	.device_group = riscv_iommu_device_group,
 	.probe_device = riscv_iommu_probe_device,
-- 
2.34.1


