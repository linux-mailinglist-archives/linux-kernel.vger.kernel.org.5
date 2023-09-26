Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1497AF2F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbjIZS2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbjIZS22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A407CCC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695752854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BuNC2fA/P0lbBI/RsO509Rqj2fam/lzzu0PxsMRFye4=;
        b=AjBPLwIhZrQGNGqSBOobNx0FVGxsiI9uZO/G8G25Aj/tEl1QuPJKe9AgUQrZVbrgVZ+fNC
        Siktz1cOpE18JtjlcrAYjWa5N38eQjzYQr5H7gjv2AgAzMvaSYmcLtnCx4voPcB4IStUux
        5w95DClIwPvqtPvFP42C7mxrltzsh+M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-9zMOJriVMwOk-VgmfNev4g-1; Tue, 26 Sep 2023 14:27:30 -0400
X-MC-Unique: 9zMOJriVMwOk-VgmfNev4g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 578751C068CE;
        Tue, 26 Sep 2023 18:27:30 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7EBB40C6EA8;
        Tue, 26 Sep 2023 18:27:28 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     poros@redhat.com, mschmidt@redhat.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 9/9] i40e: Simplify memory allocation functions
Date:   Tue, 26 Sep 2023 20:27:10 +0200
Message-ID: <20230926182710.2517901-10-ivecera@redhat.com>
In-Reply-To: <20230926182710.2517901-1-ivecera@redhat.com>
References: <20230926182710.2517901-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enum i40e_memory_type enum is unused in i40e_allocate_dma_mem() thus
can be safely removed. Useless macros in i40e_alloc.h can be removed
as well.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c |  4 ----
 drivers/net/ethernet/intel/i40e/i40e_alloc.h  | 21 -------------------
 drivers/net/ethernet/intel/i40e/i40e_hmc.c    | 12 ++++-------
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 20 +++++++++---------
 4 files changed, 14 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 0803402d8e87..c3f165552638 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -52,7 +52,6 @@ static int i40e_alloc_adminq_asq_ring(struct i40e_hw *hw)
 	int ret_code;
 
 	ret_code = i40e_allocate_dma_mem(hw, &hw->aq.asq.desc_buf,
-					 i40e_mem_atq_ring,
 					 (hw->aq.num_asq_entries *
 					 sizeof(struct i40e_aq_desc)),
 					 I40E_ADMINQ_DESC_ALIGNMENT);
@@ -79,7 +78,6 @@ static int i40e_alloc_adminq_arq_ring(struct i40e_hw *hw)
 	int ret_code;
 
 	ret_code = i40e_allocate_dma_mem(hw, &hw->aq.arq.desc_buf,
-					 i40e_mem_arq_ring,
 					 (hw->aq.num_arq_entries *
 					 sizeof(struct i40e_aq_desc)),
 					 I40E_ADMINQ_DESC_ALIGNMENT);
@@ -137,7 +135,6 @@ static int i40e_alloc_arq_bufs(struct i40e_hw *hw)
 	for (i = 0; i < hw->aq.num_arq_entries; i++) {
 		bi = &hw->aq.arq.r.arq_bi[i];
 		ret_code = i40e_allocate_dma_mem(hw, bi,
-						 i40e_mem_arq_buf,
 						 hw->aq.arq_buf_size,
 						 I40E_ADMINQ_DESC_ALIGNMENT);
 		if (ret_code)
@@ -199,7 +196,6 @@ static int i40e_alloc_asq_bufs(struct i40e_hw *hw)
 	for (i = 0; i < hw->aq.num_asq_entries; i++) {
 		bi = &hw->aq.asq.r.asq_bi[i];
 		ret_code = i40e_allocate_dma_mem(hw, bi,
-						 i40e_mem_asq_buf,
 						 hw->aq.asq_buf_size,
 						 I40E_ADMINQ_DESC_ALIGNMENT);
 		if (ret_code)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_alloc.h b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
index e0186495ef02..e0dde326255d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_alloc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
@@ -8,19 +8,6 @@
 
 struct i40e_hw;
 
-/* Memory allocation types */
-enum i40e_memory_type {
-	i40e_mem_arq_buf = 0,		/* ARQ indirect command buffer */
-	i40e_mem_asq_buf = 1,
-	i40e_mem_atq_buf = 2,		/* ATQ indirect command buffer */
-	i40e_mem_arq_ring = 3,		/* ARQ descriptor ring */
-	i40e_mem_atq_ring = 4,		/* ATQ descriptor ring */
-	i40e_mem_pd = 5,		/* Page Descriptor */
-	i40e_mem_bp = 6,		/* Backing Page - 4KB */
-	i40e_mem_bp_jumbo = 7,		/* Backing Page - > 4KB */
-	i40e_mem_reserved
-};
-
 /* memory allocation tracking */
 struct i40e_dma_mem {
 	void *va;
@@ -33,17 +20,9 @@ struct i40e_virt_mem {
 	u32 size;
 };
 
-#define i40e_allocate_dma_mem(h, m, unused, s, a) \
-			i40e_allocate_dma_mem_d(h, m, s, a)
-#define i40e_free_dma_mem(h, m) i40e_free_dma_mem_d(h, m)
-
-#define i40e_allocate_virt_mem(h, m, s) i40e_allocate_virt_mem_d(h, m, s)
-#define i40e_free_virt_mem(h, m) i40e_free_virt_mem_d(h, m)
-
 /* prototype for functions used for dynamic memory allocation */
 int i40e_allocate_dma_mem(struct i40e_hw *hw,
 			  struct i40e_dma_mem *mem,
-			  enum i40e_memory_type type,
 			  u64 size, u32 alignment);
 int i40e_free_dma_mem(struct i40e_hw *hw,
 		      struct i40e_dma_mem *mem);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
index 57b716a8ae43..a9ccc0029e99 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
@@ -20,7 +20,6 @@ int i40e_add_sd_table_entry(struct i40e_hw *hw,
 			    enum i40e_sd_entry_type type,
 			    u64 direct_mode_sz)
 {
-	enum i40e_memory_type mem_type __attribute__((unused));
 	struct i40e_hmc_sd_entry *sd_entry;
 	bool dma_mem_alloc_done = false;
 	struct i40e_dma_mem mem;
@@ -41,16 +40,13 @@ int i40e_add_sd_table_entry(struct i40e_hw *hw,
 
 	sd_entry = &hmc_info->sd_table.sd_entry[sd_index];
 	if (!sd_entry->valid) {
-		if (I40E_SD_TYPE_PAGED == type) {
-			mem_type = i40e_mem_pd;
+		if (I40E_SD_TYPE_PAGED == type)
 			alloc_len = I40E_HMC_PAGED_BP_SIZE;
-		} else {
-			mem_type = i40e_mem_bp_jumbo;
+		else
 			alloc_len = direct_mode_sz;
-		}
 
 		/* allocate a 4K pd page or 2M backing page */
-		ret_code = i40e_allocate_dma_mem(hw, &mem, mem_type, alloc_len,
+		ret_code = i40e_allocate_dma_mem(hw, &mem, alloc_len,
 						 I40E_HMC_PD_BP_BUF_ALIGNMENT);
 		if (ret_code)
 			goto exit;
@@ -138,7 +134,7 @@ int i40e_add_pd_table_entry(struct i40e_hw *hw,
 			page = rsrc_pg;
 		} else {
 			/* allocate a 4K backing page */
-			ret_code = i40e_allocate_dma_mem(hw, page, i40e_mem_bp,
+			ret_code = i40e_allocate_dma_mem(hw, page,
 						I40E_HMC_PAGED_BP_SIZE,
 						I40E_HMC_PD_BP_BUF_ALIGNMENT);
 			if (ret_code)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 488ea5e8ded9..69606db341eb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -134,14 +134,14 @@ struct device *i40e_hw_to_dev(struct i40e_hw *hw)
 }
 
 /**
- * i40e_allocate_dma_mem_d - OS specific memory alloc for shared code
+ * i40e_allocate_dma_mem - OS specific memory alloc for shared code
  * @hw:   pointer to the HW structure
  * @mem:  ptr to mem struct to fill out
  * @size: size of memory requested
  * @alignment: what to align the allocation to
  **/
-int i40e_allocate_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem,
-			    u64 size, u32 alignment)
+int i40e_allocate_dma_mem(struct i40e_hw *hw, struct i40e_dma_mem *mem,
+			  u64 size, u32 alignment)
 {
 	struct i40e_pf *pf = i40e_hw_to_pf(hw);
 
@@ -155,11 +155,11 @@ int i40e_allocate_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem,
 }
 
 /**
- * i40e_free_dma_mem_d - OS specific memory free for shared code
+ * i40e_free_dma_mem - OS specific memory free for shared code
  * @hw:   pointer to the HW structure
  * @mem:  ptr to mem struct to free
  **/
-int i40e_free_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem)
+int i40e_free_dma_mem(struct i40e_hw *hw, struct i40e_dma_mem *mem)
 {
 	struct i40e_pf *pf = i40e_hw_to_pf(hw);
 
@@ -172,13 +172,13 @@ int i40e_free_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem)
 }
 
 /**
- * i40e_allocate_virt_mem_d - OS specific memory alloc for shared code
+ * i40e_allocate_virt_mem - OS specific memory alloc for shared code
  * @hw:   pointer to the HW structure
  * @mem:  ptr to mem struct to fill out
  * @size: size of memory requested
  **/
-int i40e_allocate_virt_mem_d(struct i40e_hw *hw, struct i40e_virt_mem *mem,
-			     u32 size)
+int i40e_allocate_virt_mem(struct i40e_hw *hw, struct i40e_virt_mem *mem,
+			   u32 size)
 {
 	mem->size = size;
 	mem->va = kzalloc(size, GFP_KERNEL);
@@ -190,11 +190,11 @@ int i40e_allocate_virt_mem_d(struct i40e_hw *hw, struct i40e_virt_mem *mem,
 }
 
 /**
- * i40e_free_virt_mem_d - OS specific memory free for shared code
+ * i40e_free_virt_mem - OS specific memory free for shared code
  * @hw:   pointer to the HW structure
  * @mem:  ptr to mem struct to free
  **/
-int i40e_free_virt_mem_d(struct i40e_hw *hw, struct i40e_virt_mem *mem)
+int i40e_free_virt_mem(struct i40e_hw *hw, struct i40e_virt_mem *mem)
 {
 	/* it's ok to kfree a NULL pointer */
 	kfree(mem->va);
-- 
2.41.0

