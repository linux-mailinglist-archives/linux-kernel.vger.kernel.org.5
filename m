Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2DB80AA74
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjLHRRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574218AbjLHRRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:17:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB8710EB;
        Fri,  8 Dec 2023 09:17:25 -0800 (PST)
Date:   Fri, 08 Dec 2023 17:17:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702055844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gM0gup0iM5x+Wx/nfZzRi+3I9Two9z4PE9Cusbju27k=;
        b=kGr8edapDS0Y2hTuLW33rJw8BQL9Hsywcz+COJBBj4t8x9DM3KPaTH5/GgcaWqb2Km37GN
        Sq3H0s0p5VmrA/LSS2fh9bUAbTIpWhCS8qYD0WsxRSbFaOMlMjra0/MvZrwSZ2yPt4n1iA
        dyYX2P6GBusX590G/P/wHz2CAzHWWKok+vWo4/3uzTaw8VjwRHB4GAFMgm1szcoNDKqbPv
        cHhsusbT1YZRjvdsk7fp/4PVAECCs2McrO2ZPQtHKDfOyH54BuuHU8pz9vRtTlG3dQJu4h
        LUTUyFCThloHhhkMvFDRJKNfw2IdQjkpMj+rMWbeKM1ks93INNIsYIK3vRDHVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702055844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gM0gup0iM5x+Wx/nfZzRi+3I9Two9z4PE9Cusbju27k=;
        b=rOihm8ZRXeQ5O0tZ+0eRB8gwXJ1wqv3mkDSTn6Q1E7mYNWwAlnvKzVpvPuT/h24M67aPQX
        RkgJ0uNhf3p9sfBA==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Allocate and set up PAMTs for TDMRs
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yuan Yao <yuan.yao@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205584338.398.14711912124453940964.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     ac3a22088434e31dddda82aa473bee008df99b97
Gitweb:        https://git.kernel.org/tip/ac3a22088434e31dddda82aa473bee008df99b97
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Fri, 08 Dec 2023 09:07:31 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 09:12:37 -08:00

x86/virt/tdx: Allocate and set up PAMTs for TDMRs

The TDX module uses additional metadata to record things like which
guest "owns" a given page of memory.  This metadata, referred as
Physical Address Metadata Table (PAMT), essentially serves as the
'struct page' for the TDX module.  PAMTs are not reserved by hardware
up front.  They must be allocated by the kernel and then given to the
TDX module during module initialization.

TDX supports 3 page sizes: 4K, 2M, and 1G.  Each "TD Memory Region"
(TDMR) has 3 PAMTs to track the 3 supported page sizes.  Each PAMT must
be a physically contiguous area from a Convertible Memory Region (CMR).
However, the PAMTs which track pages in one TDMR do not need to reside
within that TDMR but can be anywhere in CMRs.  If one PAMT overlaps with
any TDMR, the overlapping part must be reported as a reserved area in
that particular TDMR.

Use alloc_contig_pages() since PAMT must be a physically contiguous area
and it may be potentially large (~1/256th of the size of the given TDMR).
The downside is alloc_contig_pages() may fail at runtime.  One (bad)
mitigation is to launch a TDX guest early during system boot to get
those PAMTs allocated at early time, but the only way to fix is to add a
boot option to allocate or reserve PAMTs during kernel boot.

It is imperfect but will be improved on later.

TDX only supports a limited number of reserved areas per TDMR to cover
both PAMTs and memory holes within the given TDMR.  If many PAMTs are
allocated within a single TDMR, the reserved areas may not be sufficient
to cover all of them.

Adopt the following policies when allocating PAMTs for a given TDMR:

  - Allocate three PAMTs of the TDMR in one contiguous chunk to minimize
    the total number of reserved areas consumed for PAMTs.
  - Try to first allocate PAMT from the local node of the TDMR for better
    NUMA locality.

Also dump out how many pages are allocated for PAMTs when the TDX module
is initialized successfully.  This helps answer the eternal "where did
all my memory go?" questions.

[ dhansen: merge in error handling cleanup ]

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Yuan Yao <yuan.yao@intel.com>
Link: https://lore.kernel.org/all/20231208170740.53979-11-dave.hansen%40intel.com
---
 arch/x86/Kconfig            |   1 +-
 arch/x86/virt/vmx/tdx/tdx.c | 217 ++++++++++++++++++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.h |   1 +-
 3 files changed, 213 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2c69ef8..e255d8a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1972,6 +1972,7 @@ config INTEL_TDX_HOST
 	depends on KVM_INTEL
 	depends on X86_X2APIC
 	select ARCH_KEEP_MEMBLOCK
+	depends on CONTIG_ALLOC
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
 	  host and certain physical attacks.  This option enables necessary TDX
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index d7f9287..c2bff81 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -173,7 +173,7 @@ EXPORT_SYMBOL_GPL(tdx_cpu_enable);
  * overlap.
  */
 static int add_tdx_memblock(struct list_head *tmb_list, unsigned long start_pfn,
-			    unsigned long end_pfn)
+			    unsigned long end_pfn, int nid)
 {
 	struct tdx_memblock *tmb;
 
@@ -184,6 +184,7 @@ static int add_tdx_memblock(struct list_head *tmb_list, unsigned long start_pfn,
 	INIT_LIST_HEAD(&tmb->list);
 	tmb->start_pfn = start_pfn;
 	tmb->end_pfn = end_pfn;
+	tmb->nid = nid;
 
 	/* @tmb_list is protected by mem_hotplug_lock */
 	list_add_tail(&tmb->list, tmb_list);
@@ -211,9 +212,9 @@ static void free_tdx_memlist(struct list_head *tmb_list)
 static int build_tdx_memlist(struct list_head *tmb_list)
 {
 	unsigned long start_pfn, end_pfn;
-	int i, ret;
+	int i, nid, ret;
 
-	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL) {
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
 		/*
 		 * The first 1MB is not reported as TDX convertible memory.
 		 * Although the first 1MB is always reserved and won't end up
@@ -229,7 +230,7 @@ static int build_tdx_memlist(struct list_head *tmb_list)
 		 * memblock has already guaranteed they are in address
 		 * ascending order and don't overlap.
 		 */
-		ret = add_tdx_memblock(tmb_list, start_pfn, end_pfn);
+		ret = add_tdx_memblock(tmb_list, start_pfn, end_pfn, nid);
 		if (ret)
 			goto err;
 	}
@@ -466,6 +467,202 @@ static int fill_out_tdmrs(struct list_head *tmb_list,
 }
 
 /*
+ * Calculate PAMT size given a TDMR and a page size.  The returned
+ * PAMT size is always aligned up to 4K page boundary.
+ */
+static unsigned long tdmr_get_pamt_sz(struct tdmr_info *tdmr, int pgsz,
+				      u16 pamt_entry_size)
+{
+	unsigned long pamt_sz, nr_pamt_entries;
+
+	switch (pgsz) {
+	case TDX_PS_4K:
+		nr_pamt_entries = tdmr->size >> PAGE_SHIFT;
+		break;
+	case TDX_PS_2M:
+		nr_pamt_entries = tdmr->size >> PMD_SHIFT;
+		break;
+	case TDX_PS_1G:
+		nr_pamt_entries = tdmr->size >> PUD_SHIFT;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
+	pamt_sz = nr_pamt_entries * pamt_entry_size;
+	/* TDX requires PAMT size must be 4K aligned */
+	pamt_sz = ALIGN(pamt_sz, PAGE_SIZE);
+
+	return pamt_sz;
+}
+
+/*
+ * Locate a NUMA node which should hold the allocation of the @tdmr
+ * PAMT.  This node will have some memory covered by the TDMR.  The
+ * relative amount of memory covered is not considered.
+ */
+static int tdmr_get_nid(struct tdmr_info *tdmr, struct list_head *tmb_list)
+{
+	struct tdx_memblock *tmb;
+
+	/*
+	 * A TDMR must cover at least part of one TMB.  That TMB will end
+	 * after the TDMR begins.  But, that TMB may have started before
+	 * the TDMR.  Find the next 'tmb' that _ends_ after this TDMR
+	 * begins.  Ignore 'tmb' start addresses.  They are irrelevant.
+	 */
+	list_for_each_entry(tmb, tmb_list, list) {
+		if (tmb->end_pfn > PHYS_PFN(tdmr->base))
+			return tmb->nid;
+	}
+
+	/*
+	 * Fall back to allocating the TDMR's metadata from node 0 when
+	 * no TDX memory block can be found.  This should never happen
+	 * since TDMRs originate from TDX memory blocks.
+	 */
+	pr_warn("TDMR [0x%llx, 0x%llx): unable to find local NUMA node for PAMT allocation, fallback to use node 0.\n",
+			tdmr->base, tdmr_end(tdmr));
+	return 0;
+}
+
+/*
+ * Allocate PAMTs from the local NUMA node of some memory in @tmb_list
+ * within @tdmr, and set up PAMTs for @tdmr.
+ */
+static int tdmr_set_up_pamt(struct tdmr_info *tdmr,
+			    struct list_head *tmb_list,
+			    u16 pamt_entry_size[])
+{
+	unsigned long pamt_base[TDX_PS_NR];
+	unsigned long pamt_size[TDX_PS_NR];
+	unsigned long tdmr_pamt_base;
+	unsigned long tdmr_pamt_size;
+	struct page *pamt;
+	int pgsz, nid;
+
+	nid = tdmr_get_nid(tdmr, tmb_list);
+
+	/*
+	 * Calculate the PAMT size for each TDX supported page size
+	 * and the total PAMT size.
+	 */
+	tdmr_pamt_size = 0;
+	for (pgsz = TDX_PS_4K; pgsz < TDX_PS_NR; pgsz++) {
+		pamt_size[pgsz] = tdmr_get_pamt_sz(tdmr, pgsz,
+					pamt_entry_size[pgsz]);
+		tdmr_pamt_size += pamt_size[pgsz];
+	}
+
+	/*
+	 * Allocate one chunk of physically contiguous memory for all
+	 * PAMTs.  This helps minimize the PAMT's use of reserved areas
+	 * in overlapped TDMRs.
+	 */
+	pamt = alloc_contig_pages(tdmr_pamt_size >> PAGE_SHIFT, GFP_KERNEL,
+			nid, &node_online_map);
+	if (!pamt)
+		return -ENOMEM;
+
+	/*
+	 * Break the contiguous allocation back up into the
+	 * individual PAMTs for each page size.
+	 */
+	tdmr_pamt_base = page_to_pfn(pamt) << PAGE_SHIFT;
+	for (pgsz = TDX_PS_4K; pgsz < TDX_PS_NR; pgsz++) {
+		pamt_base[pgsz] = tdmr_pamt_base;
+		tdmr_pamt_base += pamt_size[pgsz];
+	}
+
+	tdmr->pamt_4k_base = pamt_base[TDX_PS_4K];
+	tdmr->pamt_4k_size = pamt_size[TDX_PS_4K];
+	tdmr->pamt_2m_base = pamt_base[TDX_PS_2M];
+	tdmr->pamt_2m_size = pamt_size[TDX_PS_2M];
+	tdmr->pamt_1g_base = pamt_base[TDX_PS_1G];
+	tdmr->pamt_1g_size = pamt_size[TDX_PS_1G];
+
+	return 0;
+}
+
+static void tdmr_get_pamt(struct tdmr_info *tdmr, unsigned long *pamt_base,
+			  unsigned long *pamt_size)
+{
+	unsigned long pamt_bs, pamt_sz;
+
+	/*
+	 * The PAMT was allocated in one contiguous unit.  The 4K PAMT
+	 * should always point to the beginning of that allocation.
+	 */
+	pamt_bs = tdmr->pamt_4k_base;
+	pamt_sz = tdmr->pamt_4k_size + tdmr->pamt_2m_size + tdmr->pamt_1g_size;
+
+	WARN_ON_ONCE((pamt_bs & ~PAGE_MASK) || (pamt_sz & ~PAGE_MASK));
+
+	*pamt_base = pamt_bs;
+	*pamt_size = pamt_sz;
+}
+
+static void tdmr_free_pamt(struct tdmr_info *tdmr)
+{
+	unsigned long pamt_base, pamt_size;
+
+	tdmr_get_pamt(tdmr, &pamt_base, &pamt_size);
+
+	/* Do nothing if PAMT hasn't been allocated for this TDMR */
+	if (!pamt_size)
+		return;
+
+	if (WARN_ON_ONCE(!pamt_base))
+		return;
+
+	free_contig_range(pamt_base >> PAGE_SHIFT, pamt_size >> PAGE_SHIFT);
+}
+
+static void tdmrs_free_pamt_all(struct tdmr_info_list *tdmr_list)
+{
+	int i;
+
+	for (i = 0; i < tdmr_list->nr_consumed_tdmrs; i++)
+		tdmr_free_pamt(tdmr_entry(tdmr_list, i));
+}
+
+/* Allocate and set up PAMTs for all TDMRs */
+static int tdmrs_set_up_pamt_all(struct tdmr_info_list *tdmr_list,
+				 struct list_head *tmb_list,
+				 u16 pamt_entry_size[])
+{
+	int i, ret = 0;
+
+	for (i = 0; i < tdmr_list->nr_consumed_tdmrs; i++) {
+		ret = tdmr_set_up_pamt(tdmr_entry(tdmr_list, i), tmb_list,
+				pamt_entry_size);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+err:
+	tdmrs_free_pamt_all(tdmr_list);
+	return ret;
+}
+
+static unsigned long tdmrs_count_pamt_kb(struct tdmr_info_list *tdmr_list)
+{
+	unsigned long pamt_size = 0;
+	int i;
+
+	for (i = 0; i < tdmr_list->nr_consumed_tdmrs; i++) {
+		unsigned long base, size;
+
+		tdmr_get_pamt(tdmr_entry(tdmr_list, i), &base, &size);
+		pamt_size += size;
+	}
+
+	return pamt_size / 1024;
+}
+
+/*
  * Construct a list of TDMRs on the preallocated space in @tdmr_list
  * to cover all TDX memory regions in @tmb_list based on the TDX module
  * TDMR global information in @tdmr_sysinfo.
@@ -480,10 +677,13 @@ static int construct_tdmrs(struct list_head *tmb_list,
 	if (ret)
 		return ret;
 
+	ret = tdmrs_set_up_pamt_all(tdmr_list, tmb_list,
+			tdmr_sysinfo->pamt_entry_size);
+	if (ret)
+		return ret;
 	/*
 	 * TODO:
 	 *
-	 *  - Allocate and set up PAMTs for each TDMR.
 	 *  - Designate reserved areas for each TDMR.
 	 *
 	 * Return -EINVAL until constructing TDMRs is done
@@ -537,7 +737,10 @@ static int init_tdx_module(void)
 	 */
 	ret = -EINVAL;
 	if (ret)
-		goto err_free_tdmrs;
+		goto err_free_pamts;
+
+	pr_info("%lu KB allocated for PAMT\n", tdmrs_count_pamt_kb(&tdx_tdmr_list));
+
 out_put_tdxmem:
 	/*
 	 * @tdx_memlist is written here and read at memory hotplug time.
@@ -546,6 +749,8 @@ out_put_tdxmem:
 	put_online_mems();
 	return ret;
 
+err_free_pamts:
+	tdmrs_free_pamt_all(&tdx_tdmr_list);
 err_free_tdmrs:
 	free_tdmr_list(&tdx_tdmr_list);
 err_free_tdxmem:
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index f18ce1b..1b04efe 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -87,6 +87,7 @@ struct tdx_memblock {
 	struct list_head list;
 	unsigned long start_pfn;
 	unsigned long end_pfn;
+	int nid;
 };
 
 /* "TDMR info" part of "Global Scope Metadata" for constructing TDMRs */
