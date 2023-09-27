Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D677AFE93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjI0Icz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjI0Ich (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1158E4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695803514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVzY+vMUDmnya1uDGQKz7p3/Jl99vLT/bSf/GBa8Rys=;
        b=jLFEpPrEk5Yp0UTy50341MELmrBRJsvgfLQVT93Vr4L+1E1yaj9JrNVMQPjB5C+5CIyupr
        W7Vzew2AfQ7YNvaUpmgXC9gy8whc4XEKjI+EexBse2Bl3ozBNtvhlUcFm3E/wQ8g5DjXww
        DxpB9aJQrxNqNfI+SEI9GUtdMvX20CM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-7XbEVybwMKmYrUY5c7Zv_A-1; Wed, 27 Sep 2023 04:31:48 -0400
X-MC-Unique: 7XbEVybwMKmYrUY5c7Zv_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EA4F185A78E;
        Wed, 27 Sep 2023 08:31:48 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DB3F2156702;
        Wed, 27 Sep 2023 08:31:46 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     poros@redhat.com, mschmidt@redhat.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        przemyslaw.kitszel@intel.com
Subject: [PATCH net-next v2 5/9] i40e: Simplify memory allocation functions
Date:   Wed, 27 Sep 2023 10:31:31 +0200
Message-ID: <20230927083135.3237206-6-ivecera@redhat.com>
In-Reply-To: <20230927083135.3237206-1-ivecera@redhat.com>
References: <20230927083135.3237206-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/net/ethernet/intel/i40e/i40e_alloc.h  | 14 -------------
 drivers/net/ethernet/intel/i40e/i40e_hmc.c    | 12 ++++-------
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 20 +++++++++----------
 drivers/net/ethernet/intel/i40e/i40e_osdep.h  |  7 -------
 5 files changed, 14 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 100eb77b8dfe..e72cfe587c89 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -51,7 +51,6 @@ static int i40e_alloc_adminq_asq_ring(struct i40e_hw *hw)
 	int ret_code;
 
 	ret_code = i40e_allocate_dma_mem(hw, &hw->aq.asq.desc_buf,
-					 i40e_mem_atq_ring,
 					 (hw->aq.num_asq_entries *
 					 sizeof(struct i40e_aq_desc)),
 					 I40E_ADMINQ_DESC_ALIGNMENT);
@@ -78,7 +77,6 @@ static int i40e_alloc_adminq_arq_ring(struct i40e_hw *hw)
 	int ret_code;
 
 	ret_code = i40e_allocate_dma_mem(hw, &hw->aq.arq.desc_buf,
-					 i40e_mem_arq_ring,
 					 (hw->aq.num_arq_entries *
 					 sizeof(struct i40e_aq_desc)),
 					 I40E_ADMINQ_DESC_ALIGNMENT);
@@ -136,7 +134,6 @@ static int i40e_alloc_arq_bufs(struct i40e_hw *hw)
 	for (i = 0; i < hw->aq.num_arq_entries; i++) {
 		bi = &hw->aq.arq.r.arq_bi[i];
 		ret_code = i40e_allocate_dma_mem(hw, bi,
-						 i40e_mem_arq_buf,
 						 hw->aq.arq_buf_size,
 						 I40E_ADMINQ_DESC_ALIGNMENT);
 		if (ret_code)
@@ -198,7 +195,6 @@ static int i40e_alloc_asq_bufs(struct i40e_hw *hw)
 	for (i = 0; i < hw->aq.num_asq_entries; i++) {
 		bi = &hw->aq.asq.r.asq_bi[i];
 		ret_code = i40e_allocate_dma_mem(hw, bi,
-						 i40e_mem_asq_buf,
 						 hw->aq.asq_buf_size,
 						 I40E_ADMINQ_DESC_ALIGNMENT);
 		if (ret_code)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_alloc.h b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
index a6c9a9e343d1..4b2d8da048c6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_alloc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
@@ -6,23 +6,9 @@
 
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
 /* prototype for functions used for dynamic memory allocation */
 int i40e_allocate_dma_mem(struct i40e_hw *hw,
 			  struct i40e_dma_mem *mem,
-			  enum i40e_memory_type type,
 			  u64 size, u32 alignment);
 int i40e_free_dma_mem(struct i40e_hw *hw,
 		      struct i40e_dma_mem *mem);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
index 96ee63aca7a1..7451d346ae83 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
@@ -22,7 +22,6 @@ int i40e_add_sd_table_entry(struct i40e_hw *hw,
 			    enum i40e_sd_entry_type type,
 			    u64 direct_mode_sz)
 {
-	enum i40e_memory_type mem_type __attribute__((unused));
 	struct i40e_hmc_sd_entry *sd_entry;
 	bool dma_mem_alloc_done = false;
 	struct i40e_dma_mem mem;
@@ -43,16 +42,13 @@ int i40e_add_sd_table_entry(struct i40e_hw *hw,
 
 	sd_entry = &hmc_info->sd_table.sd_entry[sd_index];
 	if (!sd_entry->valid) {
-		if (I40E_SD_TYPE_PAGED == type) {
-			mem_type = i40e_mem_pd;
+		if (type == I40E_SD_TYPE_PAGED)
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
@@ -140,7 +136,7 @@ int i40e_add_pd_table_entry(struct i40e_hw *hw,
 			page = rsrc_pg;
 		} else {
 			/* allocate a 4K backing page */
-			ret_code = i40e_allocate_dma_mem(hw, page, i40e_mem_bp,
+			ret_code = i40e_allocate_dma_mem(hw, page,
 						I40E_HMC_PAGED_BP_SIZE,
 						I40E_HMC_PD_BP_BUF_ALIGNMENT);
 			if (ret_code)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c19d1b4cc32b..40237c778c63 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -131,14 +131,14 @@ struct device *i40e_hw_to_dev(struct i40e_hw *hw)
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
 
@@ -152,11 +152,11 @@ int i40e_allocate_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem,
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
 
@@ -169,13 +169,13 @@ int i40e_free_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem)
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
@@ -187,11 +187,11 @@ int i40e_allocate_virt_mem_d(struct i40e_hw *hw, struct i40e_virt_mem *mem,
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
diff --git a/drivers/net/ethernet/intel/i40e/i40e_osdep.h b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
index 997569a4ad57..70cac3bb31ec 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_osdep.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
@@ -36,18 +36,11 @@ struct i40e_dma_mem {
 	u32 size;
 };
 
-#define i40e_allocate_dma_mem(h, m, unused, s, a) \
-			i40e_allocate_dma_mem_d(h, m, s, a)
-#define i40e_free_dma_mem(h, m) i40e_free_dma_mem_d(h, m)
-
 struct i40e_virt_mem {
 	void *va;
 	u32 size;
 };
 
-#define i40e_allocate_virt_mem(h, m, s) i40e_allocate_virt_mem_d(h, m, s)
-#define i40e_free_virt_mem(h, m) i40e_free_virt_mem_d(h, m)
-
 #define i40e_debug(h, m, s, ...)				\
 do {								\
 	if (((m) & (h)->debug_mask))				\
-- 
2.41.0

