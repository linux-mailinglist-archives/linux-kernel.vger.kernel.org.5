Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051E17AFE8D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjI0Icc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjI0Ic3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F26A3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695803503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ueYP/ajTB7V4RyeLKkt5pWxuJfeWfMVAt0X1oDNjTwE=;
        b=WX0pBCK0K7nN8Z2ww17kzJVriKVo6whdx2jnYQ7YUV/uTduAXAV1FeeR/FJWEWQ9HLmI4k
        raFDRPF+ozkPW5d/GIC2yDLDctqhBESek9rpvWr7CmfcPv5oJljdEDoXNiASbGwkQWpTFt
        bydt3Jpyd5FkMe0G64zJ/TblsFt9sLA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-9bfQ2AHAOD6FPXjbqiYk3w-1; Wed, 27 Sep 2023 04:31:40 -0400
X-MC-Unique: 9bfQ2AHAOD6FPXjbqiYk3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 530B9857D0D;
        Wed, 27 Sep 2023 08:31:40 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E73E21B2414;
        Wed, 27 Sep 2023 08:31:38 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     poros@redhat.com, mschmidt@redhat.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        przemyslaw.kitszel@intel.com
Subject: [PATCH net-next v2 1/9] i40e: Remove back pointer from i40e_hw structure
Date:   Wed, 27 Sep 2023 10:31:27 +0200
Message-ID: <20230927083135.3237206-2-ivecera@redhat.com>
In-Reply-To: <20230927083135.3237206-1-ivecera@redhat.com>
References: <20230927083135.3237206-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .back field placed in i40e_hw is used to get pointer to i40e_pf
instance but it is not necessary as the i40e_hw is a part of i40e_pf
and containerof macro can be used to obtain the pointer to i40e_pf.
Remove .back field from i40e_hw structure, introduce i40e_hw_to_pf()
and i40e_hw_to_dev() helpers and use them.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h       | 11 ++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c  | 22 ++++++++++++++------
 drivers/net/ethernet/intel/i40e/i40e_osdep.h |  8 +++----
 drivers/net/ethernet/intel/i40e/i40e_type.h  |  1 -
 4 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 6e310a539467..7f79d5929be6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1321,4 +1321,15 @@ static inline u32 i40e_is_tc_mqprio_enabled(struct i40e_pf *pf)
 	return pf->flags & I40E_FLAG_TC_MQPRIO;
 }
 
+/**
+ * i40e_hw_to_pf - get pf pointer from the hardware structure
+ * @hw: pointer to the device HW structure
+ **/
+static inline struct i40e_pf *i40e_hw_to_pf(struct i40e_hw *hw)
+{
+	return container_of(hw, struct i40e_pf, hw);
+}
+
+struct device *i40e_hw_to_dev(struct i40e_hw *hw);
+
 #endif /* _I40E_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 00ca2b88165c..c19d1b4cc32b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -119,6 +119,17 @@ static void netdev_hw_addr_refcnt(struct i40e_mac_filter *f,
 	}
 }
 
+/**
+ * i40e_hw_to_dev - get device pointer from the hardware structure
+ * @hw: pointer to the device HW structure
+ **/
+struct device *i40e_hw_to_dev(struct i40e_hw *hw)
+{
+	struct i40e_pf *pf = i40e_hw_to_pf(hw);
+
+	return &pf->pdev->dev;
+}
+
 /**
  * i40e_allocate_dma_mem_d - OS specific memory alloc for shared code
  * @hw:   pointer to the HW structure
@@ -129,7 +140,7 @@ static void netdev_hw_addr_refcnt(struct i40e_mac_filter *f,
 int i40e_allocate_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem,
 			    u64 size, u32 alignment)
 {
-	struct i40e_pf *pf = (struct i40e_pf *)hw->back;
+	struct i40e_pf *pf = i40e_hw_to_pf(hw);
 
 	mem->size = ALIGN(size, alignment);
 	mem->va = dma_alloc_coherent(&pf->pdev->dev, mem->size, &mem->pa,
@@ -147,7 +158,7 @@ int i40e_allocate_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem,
  **/
 int i40e_free_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem)
 {
-	struct i40e_pf *pf = (struct i40e_pf *)hw->back;
+	struct i40e_pf *pf = i40e_hw_to_pf(hw);
 
 	dma_free_coherent(&pf->pdev->dev, mem->size, mem->va, mem->pa);
 	mem->va = NULL;
@@ -15623,10 +15634,10 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
  **/
 static inline void i40e_set_subsystem_device_id(struct i40e_hw *hw)
 {
-	struct pci_dev *pdev = ((struct i40e_pf *)hw->back)->pdev;
+	struct i40e_pf *pf = i40e_hw_to_pf(hw);
 
-	hw->subsystem_device_id = pdev->subsystem_device ?
-		pdev->subsystem_device :
+	hw->subsystem_device_id = pf->pdev->subsystem_device ?
+		pf->pdev->subsystem_device :
 		(ushort)(rd32(hw, I40E_PFPCI_SUBSYSID) & USHRT_MAX);
 }
 
@@ -15696,7 +15707,6 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	set_bit(__I40E_DOWN, pf->state);
 
 	hw = &pf->hw;
-	hw->back = pf;
 
 	pf->ioremap_len = min_t(int, pci_resource_len(pdev, 0),
 				I40E_MAX_CSR_SPACE);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_osdep.h b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
index 2bd4de03dafa..997569a4ad57 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_osdep.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
@@ -18,10 +18,10 @@
  * actual OS primitives
  */
 
-#define hw_dbg(hw, S, A...)							\
-do {										\
-	dev_dbg(&((struct i40e_pf *)hw->back)->pdev->dev, S, ##A);		\
-} while (0)
+struct i40e_hw;
+struct device *i40e_hw_to_dev(struct i40e_hw *hw);
+
+#define hw_dbg(hw, S, A...) dev_dbg(i40e_hw_to_dev(hw), S, ##A)
 
 #define wr32(a, reg, value)	writel((value), ((a)->hw_addr + (reg)))
 #define rd32(a, reg)		readl((a)->hw_addr + (reg))
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 232131bedc3e..658bc8913278 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -525,7 +525,6 @@ struct i40e_dcbx_config {
 /* Port hardware description */
 struct i40e_hw {
 	u8 __iomem *hw_addr;
-	void *back;
 
 	/* subsystem structs */
 	struct i40e_phy_info phy;
-- 
2.41.0

